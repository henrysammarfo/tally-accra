/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _is;
import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart'
    as _iacs;
import 'package:serverpod_auth_idp_server/serverpod_auth_idp_server.dart'
    as _iais;
import 'package:tally_server/src/generated/till/currency_code.dart'
    as _iumn2k98;
import 'package:tally_server/src/generated/till/payment_method.dart'
    as _iflrub3c;
import '../auth/email_idp_endpoint.dart' as _iuc1hd5t;
import '../auth/jwt_refresh_endpoint.dart' as _inwq3ztq;
import '../greetings/greeting_endpoint.dart' as _il624ik7;
import '../till/insight_endpoint.dart' as _i05x5dvo;
import '../till/organization_endpoint.dart' as _icg6iw1v;
import '../till/till_endpoint.dart' as _idnf239c;

class Endpoints extends _is.EndpointDispatch {
  @override
  void initializeEndpoints(_is.Server server) {
    var endpoints = <String, _is.Endpoint>{
      'emailIdp': _iuc1hd5t.EmailIdpEndpoint()
        ..initialize(
          server,
          'emailIdp',
          null,
        ),
      'jwtRefresh': _inwq3ztq.JwtRefreshEndpoint()
        ..initialize(
          server,
          'jwtRefresh',
          null,
        ),
      'greeting': _il624ik7.GreetingEndpoint()
        ..initialize(
          server,
          'greeting',
          null,
        ),
      'insight': _i05x5dvo.InsightEndpoint()
        ..initialize(
          server,
          'insight',
          null,
        ),
      'organization': _icg6iw1v.OrganizationEndpoint()
        ..initialize(
          server,
          'organization',
          null,
        ),
      'till': _idnf239c.TillEndpoint()
        ..initialize(
          server,
          'till',
          null,
        ),
    };
    connectors['emailIdp'] = _is.EndpointConnector(
      name: 'emailIdp',
      endpoint: endpoints['emailIdp']!,
      methodConnectors: {
        'login': _is.MethodConnector(
          name: 'login',
          params: {
            'email': _is.ParameterDescription(
              name: 'email',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'password': _is.ParameterDescription(
              name: 'password',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint).login(
                    session,
                    email: params['email'],
                    password: params['password'],
                  ),
        ),
        'startRegistration': _is.MethodConnector(
          name: 'startRegistration',
          params: {
            'email': _is.ParameterDescription(
              name: 'email',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint)
                  .startRegistration(
                    session,
                    email: params['email'],
                  ),
        ),
        'verifyRegistrationCode': _is.MethodConnector(
          name: 'verifyRegistrationCode',
          params: {
            'accountRequestId': _is.ParameterDescription(
              name: 'accountRequestId',
              type: _is.getType<_is.UuidValue>(),
              nullable: false,
            ),
            'verificationCode': _is.ParameterDescription(
              name: 'verificationCode',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint)
                  .verifyRegistrationCode(
                    session,
                    accountRequestId: params['accountRequestId'],
                    verificationCode: params['verificationCode'],
                  ),
        ),
        'finishRegistration': _is.MethodConnector(
          name: 'finishRegistration',
          params: {
            'registrationToken': _is.ParameterDescription(
              name: 'registrationToken',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'password': _is.ParameterDescription(
              name: 'password',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint)
                  .finishRegistration(
                    session,
                    registrationToken: params['registrationToken'],
                    password: params['password'],
                  ),
        ),
        'startPasswordReset': _is.MethodConnector(
          name: 'startPasswordReset',
          params: {
            'email': _is.ParameterDescription(
              name: 'email',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint)
                  .startPasswordReset(
                    session,
                    email: params['email'],
                  ),
        ),
        'verifyPasswordResetCode': _is.MethodConnector(
          name: 'verifyPasswordResetCode',
          params: {
            'passwordResetRequestId': _is.ParameterDescription(
              name: 'passwordResetRequestId',
              type: _is.getType<_is.UuidValue>(),
              nullable: false,
            ),
            'verificationCode': _is.ParameterDescription(
              name: 'verificationCode',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint)
                  .verifyPasswordResetCode(
                    session,
                    passwordResetRequestId: params['passwordResetRequestId'],
                    verificationCode: params['verificationCode'],
                  ),
        ),
        'finishPasswordReset': _is.MethodConnector(
          name: 'finishPasswordReset',
          params: {
            'finishPasswordResetToken': _is.ParameterDescription(
              name: 'finishPasswordResetToken',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'newPassword': _is.ParameterDescription(
              name: 'newPassword',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint)
                  .finishPasswordReset(
                    session,
                    finishPasswordResetToken:
                        params['finishPasswordResetToken'],
                    newPassword: params['newPassword'],
                  ),
        ),
        'hasAccount': _is.MethodConnector(
          name: 'hasAccount',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint)
                  .hasAccount(session),
        ),
      },
    );
    connectors['jwtRefresh'] = _is.EndpointConnector(
      name: 'jwtRefresh',
      endpoint: endpoints['jwtRefresh']!,
      methodConnectors: {
        'refreshAccessToken': _is.MethodConnector(
          name: 'refreshAccessToken',
          params: {
            'refreshToken': _is.ParameterDescription(
              name: 'refreshToken',
              type: _is.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['jwtRefresh'] as _inwq3ztq.JwtRefreshEndpoint)
                      .refreshAccessToken(
                        session,
                        refreshToken: params['refreshToken'],
                      ),
        ),
      },
    );
    connectors['greeting'] = _is.EndpointConnector(
      name: 'greeting',
      endpoint: endpoints['greeting']!,
      methodConnectors: {
        'hello': _is.MethodConnector(
          name: 'hello',
          params: {
            'name': _is.ParameterDescription(
              name: 'name',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['greeting'] as _il624ik7.GreetingEndpoint).hello(
                    session,
                    params['name'],
                  ),
        ),
      },
    );
    connectors['insight'] = _is.EndpointConnector(
      name: 'insight',
      endpoint: endpoints['insight']!,
      methodConnectors: {
        'askDeskInsight': _is.MethodConnector(
          name: 'askDeskInsight',
          params: {
            'question': _is.ParameterDescription(
              name: 'question',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'context': _is.ParameterDescription(
              name: 'context',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['insight'] as _i05x5dvo.InsightEndpoint)
                  .askDeskInsight(
                    session,
                    question: params['question'],
                    context: params['context'],
                  ),
        ),
      },
    );
    connectors['organization'] = _is.EndpointConnector(
      name: 'organization',
      endpoint: endpoints['organization']!,
      methodConnectors: {
        'bootstrapGuestHouse': _is.MethodConnector(
          name: 'bootstrapGuestHouse',
          params: {
            'name': _is.ParameterDescription(
              name: 'name',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'slug': _is.ParameterDescription(
              name: 'slug',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'displayName': _is.ParameterDescription(
              name: 'displayName',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['organization'] as _icg6iw1v.OrganizationEndpoint)
                      .bootstrapGuestHouse(
                        session,
                        name: params['name'],
                        slug: params['slug'],
                        displayName: params['displayName'],
                      ),
        ),
        'myOrganization': _is.MethodConnector(
          name: 'myOrganization',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['organization'] as _icg6iw1v.OrganizationEndpoint)
                      .myOrganization(session),
        ),
      },
    );
    connectors['till'] = _is.EndpointConnector(
      name: 'till',
      endpoint: endpoints['till']!,
      methodConnectors: {
        'createDeposit': _is.MethodConnector(
          name: 'createDeposit',
          params: {
            'guestName': _is.ParameterDescription(
              name: 'guestName',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'guestPhone': _is.ParameterDescription(
              name: 'guestPhone',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'roomNumber': _is.ParameterDescription(
              name: 'roomNumber',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'nights': _is.ParameterDescription(
              name: 'nights',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'amount': _is.ParameterDescription(
              name: 'amount',
              type: _is.getType<double>(),
              nullable: false,
            ),
            'currency': _is.ParameterDescription(
              name: 'currency',
              type: _is.getType<_iumn2k98.CurrencyCode>(),
              nullable: false,
            ),
            'method': _is.ParameterDescription(
              name: 'method',
              type: _is.getType<_iflrub3c.PaymentMethod>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['till'] as _idnf239c.TillEndpoint).createDeposit(
                    session,
                    guestName: params['guestName'],
                    guestPhone: params['guestPhone'],
                    roomNumber: params['roomNumber'],
                    nights: params['nights'],
                    amount: params['amount'],
                    currency: params['currency'],
                    method: params['method'],
                  ),
        ),
        'assignNight': _is.MethodConnector(
          name: 'assignNight',
          params: {
            'roomNumber': _is.ParameterDescription(
              name: 'roomNumber',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'lock': _is.ParameterDescription(
              name: 'lock',
              type: _is.getType<bool>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['till'] as _idnf239c.TillEndpoint).assignNight(
                    session,
                    roomNumber: params['roomNumber'],
                    lock: params['lock'],
                  ),
        ),
        'listToday': _is.MethodConnector(
          name: 'listToday',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['till'] as _idnf239c.TillEndpoint)
                  .listToday(session),
        ),
        'closeShift': _is.MethodConnector(
          name: 'closeShift',
          params: {
            'notes': _is.ParameterDescription(
              name: 'notes',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'countedTotal': _is.ParameterDescription(
              name: 'countedTotal',
              type: _is.getType<double>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['till'] as _idnf239c.TillEndpoint).closeShift(
                    session,
                    notes: params['notes'],
                    countedTotal: params['countedTotal'],
                  ),
        ),
        'reopenShift': _is.MethodConnector(
          name: 'reopenShift',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['till'] as _idnf239c.TillEndpoint)
                  .reopenShift(session),
        ),
        'watchToday': _is.MethodStreamConnector(
          name: 'watchToday',
          params: {},
          streamParams: {},
          returnType: _is.MethodStreamReturnType.streamType,
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
                Map<String, Stream> streamParams,
              ) => (endpoints['till'] as _idnf239c.TillEndpoint).watchToday(
                session,
              ),
        ),
      },
    );
    modules['serverpod_auth_idp'] = _iais.Endpoints()
      ..initializeEndpoints(server);
    modules['serverpod_auth_core'] = _iacs.Endpoints()
      ..initializeEndpoints(server);
  }
}
