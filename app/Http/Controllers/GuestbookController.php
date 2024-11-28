<?php

namespace App\Http\Controllers;

use App\Models\GuestbookEntry;
use Illuminate\Http\Request;

class GuestbookController extends Controller
{
    public function index()
    {
        $entries = GuestbookEntry::latest()->get();
        return view('guestbook.index', compact('entries'));
    }

    public function store(Request $request)
    {
        $validated = $request->validate([
            'name' => 'required|max:255',
            'message' => 'required'
        ]);

        GuestbookEntry::create($validated);

        return redirect()->route('guestbook.index')
            ->with('success', 'Message added successfully!');
    }
}