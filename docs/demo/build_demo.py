"""Build TALLY demo MP4: title cards + Windows SAPI narration (synced)."""
from __future__ import annotations

import subprocess
import time
import wave
from pathlib import Path

from PIL import Image, ImageDraw, ImageFont

ROOT = Path(__file__).resolve().parent
AUDIO = ROOT / "audio"
FRAMES = ROOT / "frames"
OUT = ROOT / "TALLY-demo.mp4"

LINES = [
    ("01_intro.wav", "01_intro.png", "Hi. This is TALLY, a guest-house till for Accra."),
    (
        "02_stack.wav",
        "02_stack.png",
        "It is built with Flutter on the front, and Serverpod four on the back, live on Serverpod Cloud.",
    ),
    (
        "03_flow.wav",
        "03_flow.png",
        "Staff sign in, set up the property, take a deposit, lock a room night, and see todays tally update from real Postgres.",
    ),
    (
        "04_offline.wav",
        "04_offline.png",
        "If the desk goes offline, the deposit queues. Come back online, hit sync, and the owner live tally updates. Nothing critical is faked.",
    ),
    (
        "05_end.wav",
        "05_end.png",
        "Live link and GitHub repo are in the submission. Thank you.",
    ),
]

SLIDES = [
    ("01_intro.png", "TALLY", "Accra guest-house till", "Live on Serverpod Cloud"),
    ("02_stack.png", "Flutter + Serverpod 4", "Real generated client", "Postgres · auth · streams"),
    ("03_flow.png", "Deposit -> Lock night", "-> Today's tally", "Nothing critical faked"),
    ("04_offline.png", "Offline queue -> Sync", "Owner watchToday updates", "Fail closed. Honest."),
    ("05_end.png", "Thanks", "tallyaccra.serverpod.space", "github.com/henrysammarfo/tally-accra"),
]


def make_tts_sapi() -> None:
    """Use Windows SpeechSynthesizer via PowerShell."""
    AUDIO.mkdir(parents=True, exist_ok=True)
    for wav, _png, text in LINES:
        path = AUDIO / wav
        # Escape for PowerShell single-quoted string
        safe = text.replace("'", "''")
        ps = f"""
Add-Type -AssemblyName System.Speech
$s = New-Object System.Speech.Synthesis.SpeechSynthesizer
$s.Rate = -1
$s.SetOutputToWaveFile('{path.as_posix()}')
$s.Speak('{safe}')
$s.Dispose()
"""
        subprocess.check_call(["powershell", "-NoProfile", "-Command", ps])
        print("audio", path.name, path.stat().st_size)


def make_frames() -> None:
    FRAMES.mkdir(parents=True, exist_ok=True)
    w, h = 1920, 1080
    bg, gold, milk, slate = (10, 10, 10), (212, 175, 55), (250, 250, 250), (180, 180, 190)
    try:
        font_big = ImageFont.truetype("arialbd.ttf", 96)
        font_mid = ImageFont.truetype("arial.ttf", 54)
        font_sm = ImageFont.truetype("arial.ttf", 40)
    except OSError:
        font_big = font_mid = font_sm = ImageFont.load_default()
    for name, a, b, c in SLIDES:
        im = Image.new("RGB", (w, h), bg)
        d = ImageDraw.Draw(im)
        d.rectangle([0, 0, w, 8], fill=gold)
        d.text((120, 320), a, fill=gold, font=font_big)
        d.text((120, 460), b, fill=milk, font=font_mid)
        d.text((120, 560), c, fill=slate, font=font_sm)
        im.save(FRAMES / name)
        print("frame", name)


def wav_duration(path: Path) -> float:
    with wave.open(str(path), "rb") as w:
        return w.getnframes() / float(w.getframerate())


def assemble() -> None:
    concat = ROOT / "concat.txt"
    parts: list[Path] = []
    for i, (wav, png, _text) in enumerate(LINES):
        audio = AUDIO / wav
        frame = FRAMES / png
        dur = wav_duration(audio) + 0.4
        part = ROOT / f"part_{i:02d}.mp4"
        subprocess.check_call(
            [
                "ffmpeg",
                "-y",
                "-loop",
                "1",
                "-i",
                str(frame),
                "-i",
                str(audio),
                "-c:v",
                "libx264",
                "-tune",
                "stillimage",
                "-c:a",
                "aac",
                "-b:a",
                "192k",
                "-pix_fmt",
                "yuv420p",
                "-shortest",
                "-t",
                f"{dur:.3f}",
                str(part),
            ],
            stdout=subprocess.DEVNULL,
            stderr=subprocess.STDOUT,
        )
        parts.append(part)
        print("part", part.name, f"{dur:.1f}s")

    # ffmpeg concat demuxer on Windows prefers forward slashes / escaped paths
    lines = []
    for p in parts:
        lines.append("file '" + str(p).replace("\\", "/") + "'")
    concat.write_text("\n".join(lines), encoding="utf-8")
    subprocess.check_call(
        [
            "ffmpeg",
            "-y",
            "-f",
            "concat",
            "-safe",
            "0",
            "-i",
            str(concat),
            "-c",
            "copy",
            str(OUT),
        ],
        stdout=subprocess.DEVNULL,
        stderr=subprocess.STDOUT,
    )
    print("WROTE", OUT, "bytes", OUT.stat().st_size)


def main() -> None:
    make_frames()
    make_tts_sapi()
    assemble()


if __name__ == "__main__":
    main()
