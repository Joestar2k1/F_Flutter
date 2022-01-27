<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\api\ProductController;
use App\Http\Controllers\api\UserController;
use App\Http\Controllers\api\CartController;
use App\Http\Controllers\api\InvoiceController;
use App\Http\Controllers\api\InvoiceDetailsController;

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
    Route::get('/getAllUser',[UserController::class,'getAllUser']);
    Route::post('/register',[UserController::class,'register']);
    Route::put('/editUser/{id}',[UserController::class,'editUser']);
    Route::delete('/deleteUser/{id}',[UserController::class,'deleteUser']);
    Route::post('/login',[UserController::class,'login']);
    Route::get('/logout/{id}',[UserController::class,'logout']);
});

//cart controller
Route::group(['prefix' => 'carts'], function () {
    Route::get('/getCart/{id}',[CartController::class,'getCartOfUser']);
    Route::post('/addToCart',[CartController::class,'addToCart']);
    Route::put('/editUser/{id}',[CartController::class,'editUser']);
    Route::delete('/deleteCart/{id}',[CartController::class,'deleteCart']);
});

//invoices controller
Route::group(['prefix' => 'invoices'], function () {
        Route::get('/getInvoiceForUser/{id}',[InvoiceController::class,'getInvoiceForUser']);
        Route::post('/createInvoice',[InvoiceController::class,'createInvoice']);
        Route::put('/editUser/{id}',[InvoiceController::class,'editUser']);
        Route::delete('/deleteUser/{id}',[InvoiceController::class,'deleteUser']);
        Route::get('/showAll',[InvoiceController::class,'showAll']);
    });
    //'invoice_details controller
Route::group(['prefix' => 'invoice_details'], function () {
            Route::post('/createInvoiceDetails',[InvoiceDetailsController::class,'createInvoiceDetails']);
            Route::post('/createInvoice',[InvoiceDetailsController::class,'createInvoice']);
            Route::put('/editUser/{id}',[InvoiceDetailsController::class,'editUser']);
            Route::delete('/deleteUser/{id}',[InvoiceDetailsController::class,'deleteUser']);
            Route::get('/showAll',[InvoiceDetailsController::class,'showAll']);
        });