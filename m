From: David Lawyer <dave@lafn.org>
Subject: Re: Serial Howto suggestions (was Re: Trouble reading from my serial device...)
Date: Fri, 21 Nov 2003 21:32:39 -0800
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <20031122053239.GB488@lafn.org>
References: <11E89240C407D311958800A0C9ACF7D1A34049@EXCHANGE> <3FBD7CD7.1060902@rochester.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from zoot.lafn.ORG ([206.117.18.6]:9741 "EHLO zoot.lafn.org")
	by vger.kernel.org with ESMTP id S262030AbTKVGNW (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sat, 22 Nov 2003 01:13:22 -0500
Content-Disposition: inline
In-Reply-To: <3FBD7CD7.1060902@rochester.rr.com>
List-Id: linux-serial@vger.kernel.org
To: Chuck Messenger <chuckm@rochester.rr.com>
Cc: linux-serial@vger.kernel.org

On Thu, Nov 20, 2003 at 09:47:51PM -0500, Chuck Messenger wrote:
> OK, thanks for the thorough explanation, Ed -- it all makes sense now...
> 
> As far as the documentation goes -- I'm sending this to the 
> maintainers/writers of the Linux Serial Howto, and the Linux Serial 
> Programming Howto.  I had trouble sending to both before, so I'm 
> cross-posting here in the hopes they might see it...
> 
> 1) In my experience, open() does not hang if DTD is not asserted, even 
> without O_NONBLOCK.  Instead, open() returns, but read() hangs instead. 
>  If DTD is not asserted, and you open with O_NONBLOCK, then open() 
> returns (as per the documentation), but all read()'s fail right away 
> (not in the documentation).
> 
> 2) It would be very helpful to point out in the documentation that you 
> _must_ assert DCD -- in hardware -- or it will be impossible for you to 
> operate the serial port, no matter what software flags you use.

Not so.  At least not on my system.  I'm running kernel 2.4.20 and
updated using Debian unstable a few months ago.  I'm now typing on a
dump terminal which is only connected by 3 wires to the PC so there is
no DCD.  But getty has set clocal which does the trick

Furthermore, I just used minicom to open my serial port for my modem
while watching "modemstat".  It shows DCD off (red) since I've set up my
modem to only assert DCD once the modem connects.  No problem opening
the port or reading it.  It reads when I see the results of AT commands
such as displaying the modem settings to double check that I've set it
for DCD off until connect.

So the way it's described is the way it's been working for many years.
I just checked the modemstat code and it opens the port without
O_NONBLOCK so it may well be that it's read() that hangs and not open().
Modemstat just checks the control lines and doesn't do any reads.

		David Lawyer (maintainer of Serial-HOWTO)

> It would be nice to point out the trick of attaching DTR to DCD, too.

> For reference, I'm running Mandrake 9.1, with kernel 2.4.21-0.13mdk.

Was a bug introduced with 2.4.21?  Anyway, you could try setting your
modem to negate DCD and see if you can dial out.

> 
>     - Chuck
> 
[snip]
