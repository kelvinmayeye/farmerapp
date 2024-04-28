<?php

namespace App\Http\Controllers;

use App\Models\User;
use http\Env\Response;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Log;
use Illuminate\Validation\Rule;

class AuthController extends Controller
{
    public function login(Request $request){
        $loginUserData = $request->validate([
            'username'=>'required|string',
            'password'=>'required|min:8'
        ]);
        $user = User::where('username',$loginUserData['username'])->first();
        if(!$user || !Hash::check($loginUserData['password'],$user->password)){
            return response()->json([
                'message' => 'Wrong Username or Password'
            ],401);
        }
        $token = $user->createToken($user->name.'-AuthToken')->plainTextToken;
        return response([
            'user' => $user,
            'token' => $token
        ], 200);
    }

    public function register(Request $request){
        $registerUserData = $request->validate([
            'name'=>'required|string',
            'username'=>'required|string|unique:users',
            'role' => ['required', 'string', Rule::in(['farmer', 'customer'])],
            'email'=>'required|string|email|unique:users',
            'password'=>'required|min:8'
        ]);
        $registerUserData['password'] = Hash::make($registerUserData['password']);
      //  return Response()->json($registerUserData);
        $user = User::create($registerUserData);
        return response()->json([
            'message' => 'User Created ',
        ]);
    }

    public function logout(){
        Log::info("tried to logout");
        auth()->user()->tokens()->delete();

        return response()->json([
            "message"=>"logged out"
        ]);
    }
}
