<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use App\Models\Cart;
use App\Models\User;
class CartController extends Controller
{
    function getCartOfUser($userID){    
            $data = DB::table('carts')->where("userID",$userID)->select('id')->get();

            // $data = DB::table('carts')
            // ->join('users', 'carts.userID', '=', 'users.id')
            // ->join('products', 'carts.productID', '=', 'products.id')
            // ->select('carts.id','products.name','products.price','products.image','products.stock','carts.quantity','carts','carts.status')
            // ->where('carts.userID',$id)->get();

              return $data;
    }
    function addToCart(Request $request)
    {
        $countCart = DB::table('carts')->count()+1;
        $date = Date('Ymd');
        $randomID =  'c'. $date.'cart'.  $countCart;
        $carts = new Cart;
        $carts->id =  $randomID;
        $carts->userID = $request->userID;
        $carts->productID = $request->productID;
        $carts->quantity = $request->quantity;
        $carts->status = 1; 
        $carts->save();       
        if($carts ==null){
            return  json_encode([
                "message" => "Lỗi",
                 "data" => "Thêm vào giỏ hàng không thành công",
            ]);
        }
        return  json_encode([
            "message" => true,
             $carts,
        ]);
    }
    function deleteCart(Request $request,$id)
    {
        $carts = Cart::find($id);       
        if($carts !=null){       
            $carts->delete();  
            return  json_encode([
                "message" => "Xóa Thành công",
            ],
        );  
               }       
        else{
            return  json_encode([
                "message" => "Xóa không thành công",
            ]);}
    }
    function deleteProduct(Request $request,$id)
    {
        $carts = Cart::find($id);       
        if($carts !=null){       
            $carts->delete();  
            return  json_encode([
                "message" => "Thành công",
            ],
        );  
               }       
        else{
            return  json_encode([
                "message" => "Lỗi",
            ]);}
    }
}
