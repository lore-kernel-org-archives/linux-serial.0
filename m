From: Harry Wilkinson <harryw@nipltd.com>
Subject: C code - Dealing with a serial cable getting unplugged and plugged back in.
Date: Wed, 19 Jun 2002 15:02:27 +0100
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <E17Kg8a-0000qa-00@mail.nipltd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from nat88.nipltd.com ([194.193.44.88] helo=there)
	by mail.nipltd.com with smtp (AMailer 1.3.34 #2)
	id 17Kg8a-0000qa-00
	for linux-serial@vger.kernel.org; Wed, 19 Jun 2002 15:08:44 +0100
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

Hi :)

A little intro to what I'm doing first:

I am writing some C functions that are wrapped up into a Python extension 
module.  The objective is just to read/write to/from a serial port in a very 
simple way.  I'm writing and testing this on Linux but it's probably going to 
end up on Irix, and I'd like to be able to release this as open source when 
it's all done, so I'm trying to keep it POSIX compatible.  Everything is 
working so far, the only thing left to fix (unless it's incredibly difficult 
in which case we'll live with it) is that this program is going to be running 
constantly, using the serial port a lot (this is for a phone system), and 
there is a chance the serial port will get unplugged and plugged back in 
sometimes.

Okay, on to the problem:

Currently, when I unplug the serial port, if the app is trying to send 
something it will just send the data into a black hole and the data gets 
lost.  I was sort of hoping it would get buffered somewhere along the line 
until the connection was back but I guess that isn't happening (I'm new to 
this serial port stuff).

I'm using software flow control at the moment since that's all the cable I've 
got at the moment will do.  If necessary I can get a better cable and use 
hardware flow control.

So, what I'd like to know is, how can I stop my data flowing out into the 
abyss?

I can see two options at the moment, but I'm not sure how feasible either is, 
at least in a POSIX-compatible way:

A) Set some settings on the serial port that tell it to wait until the 
receiver is ready before it sends the data.  This is good because I don't 
have to change anything other than port settings when I call open() :)

B) Before I write data, make sure I wait until the connection is okay.  I 
don't know how to tell whether the connection is okay, however.


If anyone has any ideas on this I would really appreciate it :)  This is my 
first post to this list too, so I don't know if this is the right place to 
ask.  If not, please let me know where would be better :)

Thanks.

Harry Wilkinson
