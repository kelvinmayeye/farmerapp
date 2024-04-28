<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

class AuthController extends Controller
{
    public function login(Request $request){
        return response([
            'user' => "user",
            'token' => "637363839393",
            'message'=> "wrong username or password",
        ], 200);
    }

    public function register(Request $request){
        return response([
            'data' => $request,
        ], 200);
    }
}
