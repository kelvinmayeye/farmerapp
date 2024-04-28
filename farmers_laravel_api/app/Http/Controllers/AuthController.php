<?php

namespace App\Http\Controllers;

use App\Models\User;
use http\Env\Response;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
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
                'message' => 'Invalid Credentials'
            ],401);
        }
        $token = $user->createToken($user->name.'-AuthToken')->plainTextToken;
        return response()->json([
            'access_token' => $token,
        ]);
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
        auth()->user()->tokens()->delete();

        return response()->json([
            "message"=>"logged out"
        ]);
    }
}
