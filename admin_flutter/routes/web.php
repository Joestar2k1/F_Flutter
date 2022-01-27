<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\Admin\LoginController;
use App\Http\Controllers\Admin\HomeController;
use App\Http\Controllers\Admin\AccountController;
use App\Http\Controllers\Admin\ProductController;
use Illuminate\Support\Facades\Auth;


//Auth::routes();

// Route::get('/home', [App\Http\Controllers\HomeController::class, 'index'])->name('home');

Route::prefix('/')->group(function () {
    Route::get('Home', function () {
        return view('user.home.index');
    })->name("home");

    Route::get('shop', function () {
        return view('user.home.shop');
    })-> name("shop");

    Route::get('news', function () {
        return view('user.news.index');
    })-> name("news");

    Route::get('single-product', function () {
        return view('user.home.single-product');
    })-> name("single-product");

    Route::get('cart', function () {
        return view('user.cart.index');
    })-> name("cart");

    Route::get('checkout', function () {
        return view('user.checkout.index');
    })->name("checkout");
});

?>