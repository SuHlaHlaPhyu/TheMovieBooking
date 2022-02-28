import 'package:dio/dio.dart';
import 'package:movie_booking/network/response/checkout_response.dart';
import 'package:movie_booking/network/response/create_card_response.dart';
import 'package:movie_booking/network/response/get_cinema_day_timeslot_response.dart';
import 'package:movie_booking/network/response/get_cinema_seating_plan_response.dart';
import 'package:movie_booking/network/response/get_payment_method_list_response.dart';
import 'package:movie_booking/network/response/get_snack_list_response.dart';
import 'package:movie_booking/network/response/auth_response.dart';
import 'package:retrofit/retrofit.dart';

import '../api_constants.dart';
import '../checkout_request.dart';

part 'auth_api.g.dart';

@RestApi(baseUrl: BASE_AUTH_URL_DIO)
abstract class AuthApi {
  factory AuthApi(Dio dio) = _AuthApi;

  @POST(ENDPOINT_LOGIN_WITH_EMAIL)
  @FormUrlEncoded()
  Future<AuthResponse> loginWithEmail(
    @Field("email") String email,
    @Field("password") String password,
  );

  @POST(ENDPOINT_LOGIN_WITH_GOOGLE)
  @FormUrlEncoded()
  Future<AuthResponse> loginWithGoogle(
    @Field("access-token") String accessToken,
  );

  @POST(ENDPOINT_LOGIN_WITH_FACEBOOK)
  @FormUrlEncoded()
  Future<AuthResponse> loginWithFacebook(
    @Field("access-token") String accessToken,
  );

  @POST(ENDPOINT_REGISTER_WITH_EMAIL)
  @FormUrlEncoded()
  Future<AuthResponse> registerWithEmail(
    @Field("name") String name,
    @Field("email") String email,
    @Field("phone") String phone,
    @Field("password") String password,
    @Field("google-access-token") String googleToken,
    @Field("facebook-access-token") String facebookToken,
  );

  @POST(ENDPOINT_LOGOUT)
  Future<AuthResponse> logout(
    @Header("Authorization") String contentType,
  );

  @GET(ENDPOINT_GET_CINEMA_DAY_TIMESLOT)
  Future<GetCinemaDayTimeslotResponse> getCinemaDayTimeSlot(
    @Header("Authorization") String contentType,
    @Query("date") String date,
  );

  @GET(ENDPOINT_CINEMA_SEATING_PLAN)
  Future<GetCinemaSeatingPlanResponse> getCinemaSeatingPlan(
    @Header("Authorization") String contentType,
    @Query("cinema_day_timeslot_id") int cinemaDaytimeslotId,
    @Query("booking_date") String bookingDate,
  );

  @GET(ENDPOINT_GET_SNACK_LIST)
  Future<GetSnackListResponse> getSnackList(
    @Header("Authorization") String contentType,
  );

  @POST(ENDPOINT_CREATE_CARD)
  @FormUrlEncoded()
  Future<CreateCardResponse> creatCard(
    @Header("Authorization") String contentType,
    @Field("card_number") int cardNumber,
    @Field("card_holder") String cardHolder,
    @Field("expiration_date") String expirationDate,
    @Field("cvc") int cvc,
  );

  @GET(ENDPOINT_GET_PAYMENT_METHOD_LIST)
  Future<GetPaymentMethodListResponse> getPaymentMethodList(
    @Header("Authorization") String contentType,
  );

  @GET(ENDPOINT_PROFILE)
  Future<AuthResponse> profile(
    @Header("Authorization") String contentType,
  );

  @POST(ENDPOINT_CHECKOUT)
  Future<CheckoutResponse> checkOut(
    @Header("Authorization") String token,
    @Body() CheckOutRequest checkOutRequest,
  );
}
