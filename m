From: "Karl Kamysek" <karl.kamysek@gmail.com>
Subject: Re: Serial Port Woes - Blocked From Sending?
Date: Fri, 6 Oct 2006 12:07:26 -0400
Message-ID: <9248506a0610060907u1663af6ere4ce4cf463c83b56@mail.gmail.com>
References: <9248506a0610060540k3972d2b4k33e6d02ab1a81b2b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.238]:52273 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751550AbWJFQH3 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Fri, 6 Oct 2006 12:07:29 -0400
Received: by wr-out-0506.google.com with SMTP id i32so211467wra
        for <linux-serial@vger.kernel.org>; Fri, 06 Oct 2006 09:07:28 -0700 (PDT)
In-Reply-To: <9248506a0610060540k3972d2b4k33e6d02ab1a81b2b@mail.gmail.com>
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

Odd,

I guess my earlier test with the voltmeter was faulty, I tested the
port using a gender changer and jumper wire (home made serial loopback
:-)  and was able to receive a test message back sent via ttyS0 using
these instructions...

"As a jumper you could use a mini (or micro) jumper cable (sold in
some electronic parts stores) with mini alligator clips. A small scrap
of paper may be used to prevent the mini clips from making electrical
contact where it shouldn't. Metal paper clips can sometimes be bent to
use as jumpers. Whatever you use as a jumper take care not to bend or
excessively scratch the pins. To receive something from a port, you
can go to a virtual terminal (for example Alt-F2 and login) and type
something like "cp /dev/ttyS2 /dev/tty". Then at another virtual
terminal you may send something to ttyS2 (or whatever) by "echo
test_message > /dev/ttyS2". Then go back to the receive virtual
terminal and look for the test_message."

So I guess that means the signal is going out the port? (as opposed to
being blocked?)  What then could be the problem?  I know the serial
port on the cable box is open (I tested it with a windows based
channel-changing script for SageTV).

If anybody has a clue on where else I can look to resolve this I would
really appreciate the help.

Thanks,

Kamy
