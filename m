From: David Lawyer <dave@lafn.org>
Subject: Re: Non-standard baud rate setting 14400 ..Possible?
Date: Fri, 10 Oct 2003 16:08:39 -0700
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <20031010230839.GA696@lafn.org>
References: <007101c38f3e$e6419d70$cf14a8c0@sampath>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from zoot.lafn.ORG ([206.117.18.6]:27652 "EHLO zoot.lafn.org")
	by vger.kernel.org with ESMTP id S263179AbTJJXJA (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 10 Oct 2003 19:09:00 -0400
Content-Disposition: inline
In-Reply-To: <007101c38f3e$e6419d70$cf14a8c0@sampath>
List-Id: linux-serial@vger.kernel.org
To: Sampath Kumar <sampath@spartanlabs.com>
Cc: linux-serial@vger.kernel.org

On Fri, Oct 10, 2003 at 08:27:59PM +0530, Sampath Kumar wrote:
> Hello ,
> 
> Is there a way to set the serial port on the i386 Linux 2.4.17 at non
> standard baud rates like 14400,28800,etc.?
Since the baud-base of 115,200 is divisible by these numbers you can do
it.  Use a divisor of 8 to get 14400.

But the speed of transmission over a serial line can be any rate at all,
provided it's under the serial port speed selected.  For example, if
it's  been set for 115,200 I can (sort of) send bits at 96,049.37
bits/sec.  Each byte is sent at 115,200 bits/sec but there is a rest
period after each byte to result in 96,049.37 bits/sec average.  One may
calculate that for this example that there will be a 1.817 micro-sec
pause after the transmission of each byte during which time the line is
held at mark (-12 v) beyond the end of the stop bit (which also happens
to be mark).  This is like inserting extra long stop bits so as to
adjust for the correct speed.  

			David Lawyer
