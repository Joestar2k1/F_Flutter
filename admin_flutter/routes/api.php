<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\ProductController;
use App\Http\Controllers\UserController;
use App\Http\Controllers\CartController;
use App\Http\Controllers\InvoiceController;
use App\Http\Controllers\InvoiceDetailsController;
use App\Http\Controllers\NotificationController;
use Illuminate\Support\Facades\Auth;
/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

// Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
//     return $request->user();
// });
//product controller
Route::group(['prefix' => 'products'], function () {
    Route::get('/getAllProduct',[ProductController::class,'getAllProduct']);

    Route::post('/createProduct',[ProductController::class,'createProduct']);

    Route::put('/editProduct/{id}',[ProductController::class,'editProduct']);

    Route::delete('/deleteProduct/{id}',[ProductController::class,'deleteProduct']);

    Route::get('/details-product/{id}',[ProductController::class,'viewDetailsProduct']);

    Route::get('/showCategory',[ProductController::class,'showAllCategory']);

    Route::get('/showProductByTypeCategory/{dataFromClient}',[ProductController::class,'showProductByTypeCategory']);

    Route::get('/getBestSeller',[ProductController::class,'getProductBestSeller']);
});

//user controller
Route::group(['prefix' => 'users'], function () {
    Route::get('/return-user/{id}',[UserController::class,'loadUser']);

    Route::post('/register',[UserController::class,'register']);

    Route::put('/editUser/{id}',[UserController::class,'editUser']);

    Route::delete('/deleteUser/{id}',[UserController::class,'deleteUser']);

    Route::post('/login',[UserController::class,'login']);

    Route::get('/logout',[UserController::class,'logout']);
});
//invoices controller
Route::group(['prefix' => 'invoices'], function () {
        Route::get('/getInvoiceForUser/{id}',[InvoiceController::class,'getInvoiceForUser']);

        Route::post('/createInvoice',[InvoiceController::class,'createInvoice']);

        Route::put('/editUser/{id}',[InvoiceController::class,'editUser']);

        Route::delete('/deleteUser/{id}',[InvoiceController::class,'deleteUser']);

        Route::put('/payment/{id}',[InvoiceController::class,'payment']);
        //cart
        Route::get('/getCart/{id}',[CartController::class,'getCartForUser']);

        Route::post('/AddToCart/{id}',[CartController::class,'AddToCart']);

        Route::delete('/DeleteProductCart/{id}',[CartController::class,'deleteProductCart']);

        Route::put('/UpdateQuantityIncrement/{id}',[CartController::class,'updateQuantityIncrement']);

        Route::put('/UpdateQuantityDecrement/{id}',[CartController::class,'UpdateQuantityDecrement']);
        //end cart
        Route::get('/getInvoiceSuccess/{id}',[InvoiceController::class,'getInvoiceForUser']);

        Route::get('/getWaitingToAccept/{id}',[InvoiceController::class,'getInvoiceWaitingToAccept']);

        Route::get('/getPickingUpGood/{id}',[InvoiceController::class,'getInvoicePickingUpGood']);

        Route::get('/getOnDelivery/{id}',[InvoiceController::class,'getInvoiceOnDelivery']);
    });
    //'invoice_details controller
Route::group(['prefix' => 'invoice_details'], function () {
            Route::post('/createInvoiceDetails',[InvoiceDetailsController::class,'createInvoiceDetails']);

            Route::post('/createInvoice',[InvoiceDetailsController::class,'createInvoice']);

            Route::put('/editUser/{id}',[InvoiceDetailsController::class,'editUser']);

            Route::delete('/deleteUser/{id}',[InvoiceDetailsController::class,'deleteUser']);

            Route::get('/showAll',[InvoiceDetailsController::class,'showAll']);
});

Route::group(['prefix' => 'notifications'], function () {

    Route::get('/show',[NotificationController::class,'loadNotification']);
});