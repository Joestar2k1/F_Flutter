<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use App\Models\Product;
use Illuminate\Support\Collection;
class ProductController extends Controller
{
    function getAllProduct(){
        $data = DB::table('products')->get();
        return json_encode(
            $data,
        );
    }
    function viewDetailsProduct($id)
    {
        $isCheck =  DB::table('products')
        ->where('id',$id)->exists();
        if($isCheck){
            $data =  DB::table('products')
            ->where('id',$id)
            ->select('products.*')      
            ->addSelect(DB::raw('null as reviews'))
            ->get();
            $data[0]->reviews = DB::table('reviews')
            ->join('users','reviews.userID','=','users.id')
            ->where('reviews.productID',$id)
            ->select('reviews.*','users.fullName','users.avatar')
            ->get();
            if($data !=null){       
                return  response()->json(
                $data[0],
                );  
            }       
        }
        else{
            return  response()->json([
                "message" => "Không tìm thấy sản phẩm có id là $id",
            ],201);
        }
    }
   
    function createProduct(Request $request)
    {
        $countPrd = Product::all()->count();
        $randomID = 'f23112001pr' .  $countPrd;

        $products = new Product;
        
        $products->id = $randomID;
        $products->sku = $request->sku;
        $products->name = $request->name;
        $products->description = $request->description;
        $products->stock = $request->stock;
        $products->price = $request->price;
        $products->type = $request->type;
        $products->image = $request->image;
        $products->unit = $request->unit;
        $products->status = $request->status; 
        $products->created_at =Date('Y-m-d H:i:s');
        $products->updated_at = Date('Y-m-d H:i:s');
        $products->save();
        
        if($products ==null){
            return  json_encode([
                "message" => "Lỗi",
                 "data" => "Thêm không thành công",
            ]);
        }
        return  json_encode([
            "message" => "Thành công",
             "data" => $products,
        ]);
    }
    function editProduct(Request $request,$id)
    {
        $products = Product::find($id);       
        if($products !=null){       
            $products->sku = $request->sku;
            $products->name = $request->name;
            $products->description = $request->description;
            $products->stock = $request->stock;
            $products->price = $request->price;
            $products->type = $request->type;
            $products->image = $request->image;
            $products->unit = $request->unit;
            $products->status = $request->status; 
            $products->update();  
            return  json_encode([
                "message" => "Thành công",
                "data" => $products,
            ],
        );  
               }       
        else{
            return  json_encode([
                "message" => "Lỗi",
                 "data" => "Sửa không thành công",
            ]);}
    }
    function deleteProduct(Request $request,$id)
    {
        $products = Product::find($id);       
        if($products !=null){       
            $products->truncate();  
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
    function showAllCategory()
    {
        $products = DB::table('products')->select('type')->distinct()->get();       
        if($products !=null){       
            return  json_encode(
                $products,
        );  
        }
    }
    function showProductByTypeCategory($dataFormClient)
    {
        $products = DB::table('products')->where('type',$dataFormClient)->get();       
        if($products !=null){       
            return  json_encode(
                $products,
        );  
        }
    }

    function getProductBestSeller(){
                $data = DB::table('invoices')
                ->join('invoice_details','invoices.id','=','invoice_details.invoiceID')
                ->join('products','invoice_details.productID','=','products.id')
                ->groupBy('invoice_details.productID')
                ->where('invoices.status',-1)
                ->select('invoice_details.productID')
                ->addSelect(DB::raw('null as products'))
                ->havingRaw('SUM(invoice_details.quantity) > 10')
                ->get();
            $array = array();
            foreach($data as $item){
                $item->products= DB::table('products')->where('id',$item->productID)->get();
                foreach ($item->products as $key ) {
                    $array[] = $key;
                }
            }
            return  json_encode(
                $array
            );  
    }
}