<?php

namespace App\Http\Controllers;
use App\Models\User;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\DB;
use Illuminate\Http\Request;use Illuminate\Support\Str;

class UserController extends Controller
{
    function getAllUser(){
        $data = DB::table('users')->get();
        return json_encode([
            'message' => true,
            'data' => $data,
        ]);
    }
    function register(Request $request)
    {   
        $countUser = DB::table('users')->count();
        $randomID =  'user23112001x'.  $countUser;
        
        $users = new User;
        $users->id = $randomID;
        $users->username = $request->username;
        $isCheckUsername = DB::table('users')->where('username',$users->username)->exists();
        if($isCheckUsername){
            return response()->json([
                "message" => "Username đã tồn tại",
            ],201);
        }
        $users->fullName = $request->fullName;
        $users->email = $request->email;
        $isCheckEmail = DB::table('users')->where('email',$users->email)->exists();
        if($isCheckEmail){
            return response()->json([
                "message" => "Email đã tồn tại",
            ],201);
        }
        $users->avatar = "";
        $users->phone =  $request->phone;
        $users->address =  $request->address;;
        $users->isAdmin = 0;
        $users->password = $request->password;
        $users->status = 0; 

        $users->save();
        
        if($users ==null){
            return  response()->json([
                "message" => "Thêm không thành công",
            ],201);
        }
        return  json_encode([
            "message" => "Thành công",
            "user" =>$users,
        ]);
    }
    function editUser(Request $request,$id)
    {
        $users = User::find($id);       
        if($users !=null){       
            $users->username = $request->username;
            $users->fullName = $request->fullName;
            $users->email = $request->email;
            $users->avatar = $request->avatar;
            $users->phone = $request->phone;
            $users->address = $request->address;
            $users->isAdmin = $request->isAdmin;
            $users->password = $request->password;
            $users->status = $request->status; 
            $users->update();  
            return  json_encode([
                "message" => "Thành công",
                "data" => $users,
            ],
        );  
               }       
        else{
            return  json_encode([
                "message" => "Lỗi",
                 "data" => "Sửa không thành công",
            ]);}
    }
    function deleteUser($id)
    {
        $users = User::find($id);       
        if($users !=null){       
            $users->delete();  
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
  
    //http get
    function login(Request $request){
        $listID = DB::table('users')->where('email',$request->email)->select('id')->get();  
         $list = DB::table('users')->where('email',$request->email)->get();    
        $isCheckEmail =  DB::table('users')->where('email',$request->email)->exists();
        if($isCheckEmail!=null){
            $ID="";
            foreach($listID[0] as $item){
               $ID =$item;
            }  
            $isCheckPassword = DB::table('users')->where('password',$request->password)
            ->where('id',$ID)->exists();
            if($isCheckPassword){
                return json_encode([
                    "success" => true,
                    "userID" =>   $list,
                ]);
            }else{
                return json_encode([
                    "success" => false,
                    
                ]);
            }
        }else{
            return json_encode([
                "success" => false,               
            ]);
        }
    }
    function logout($id){        
        $user = User::find($id);
        $user->status = 0;
        $user->save();
    }
}
