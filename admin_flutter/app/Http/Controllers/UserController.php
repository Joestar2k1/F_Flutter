<?php

namespace App\Http\Controllers;
use App\Models\User;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\DB;
use Illuminate\Foundation\Auth\AuthenticatesUsers;
use Illuminate\Support\Facades;
use Illuminate\Support\Facades\Session;
use Illuminate\Support\Facades\Auth;
use Illuminate\Http\Request;
use Illuminate\Support\Str;

class UserController extends Controller
{
    public function loadUser($id){
        $getUser = DB::table('users')
        ->where('id',$id)
        ->select('users.*')
        ->addSelect(DB::raw('null as address'))
        ->get();
            $getUser[0]->address= DB::table('addresses')
            ->where('userID',$id)
            ->select('name')
            ->get();
        return response()->json($getUser[0]);
    }

    function register(Request $request)
    {   
       
        $countUser = DB::table('users')->count()+1;
        $randomID =  'KH'.Date('Ymd').  $countUser;
        
        $users = new User;
        $users->id = $randomID;
        $users->username = $request->username;
        $users->fullName = $request->fullName;
        $users->email = $request->email;
        $isCheckEmail = DB::table('users')->where('email',$users->email)->exists();
        if($isCheckEmail){
            return response()->json([
                "message" => "Email đã tồn tại",
            ],201);
        }
        $users->avatar = null;
        $users->phone =  $request->phone;
        $users->password = Hash::make($request->password);
        $users->status = 0; 
        $users->save();
        
        DB::table('addresses') -> insert([
            'userID' => $randomID,
            'name' => $request->address,
        ]);
        if($users ==null){
            return  response()->json([
                "message" => "Thêm không thành công",
            ],201);
        }
        return  json_encode([
            "message" => "Thành công",
        ]);
    }
    function editUser(Request $request,$id)
    {
        $users = DB::table('users')->where('id',$id)->get();  
       
        $checkEmail =  DB::table('users')->where('id',$id)->where('email',$request->email)->exists();
        if($users !=null){     
            if(empty($request->password)){
                DB::table('users')
                ->update([
                    'username' => $request->username,
                    'fullName' => $request->fullName,
                    'phone' => $request->phone,
                ]);
            }
            if($checkEmail){
                DB::table('users')
                ->update([
                    'username' => $request->username,
                    'fullName' => $request->fullName,
                    'phone' => $request->phone,
                    'password' => Hash::make($request->password),
                ]);
            }else{
                DB::table('users')
                ->update([
                    'username' => $request->username,
                    'fullName' => $request->fullName,
                    'email' => $request->email,
                    'phone' => $request->phone,
                    'password' => Hash::make($request->password),
                ]);
            }
           
            $newUser = DB::table('users')
            ->where('id',$id)
            ->select('users.*')
            ->addSelect(DB::raw('null as address'))
            ->get();                           
            foreach($newUser as $user){
                $addresses= DB::table('addresses')
                ->where('userID',$user->id)
                ->select('name')
                ->get();
                $user->address = $addresses;
            }
            return  json_encode($newUser[0]);  
               }       
        else{
            return  json_encode([
                "message" => "Lỗi",
                 "data" => "Sửa không thành công",
            ]);}
    }
  
    public function login(Request $request)
    {
       
        if (Auth::guard('user')->attempt([
            'email' => $request->email,
            'password' => $request->password
        ], $request->get('remember'))) {
            $token = Str::random(length:40);
            DB::table('users')
            ->where('email',$request->email)
            ->update([
                'remember_token' =>  $token,
                'status' => 1
            ]);
            $users = DB::table('users')
            ->where('remember_token',$token)
            ->select('users.*')
            ->addSelect(DB::raw('null as address'))
            ->get();                           
            foreach($users as $user){
                $addresses= DB::table('addresses')
                ->where('userID',$user->id)
                ->select('name')
                ->get();
                $user->address = $addresses;
            }
            return  json_encode(
              $users[0]
            );
        }
        return  response()->json([
            "message" => false,
        ],201);
    }

    function logout(Request $request){     
        DB::table('users')
        ->where('email',$request->email)
        ->update([
            'status' => 0
        ]); 
        Auth::guard('user')->logout();
        return  response()->json([
            "message" => true,
        ],200);
    }
}
