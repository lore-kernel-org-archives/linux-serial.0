From: David Lawyer <dave@lafn.org>
Subject: Re: Serial port shuts down APC UPS
Date: Fri, 24 Jan 2003 22:54:42 -0800
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <20030125065442.GB532@lafn.org>
References: <20030124013902.GF765@wheat.boylan.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from localhost (mail@host-66-81-18-208.rev.o1.com [66.81.18.208])
	by zoon.lafn.org (8.12.3/8.11.3) with ESMTP id h0P6woZi049539
	for <linux-serial@vger.kernel.org>; Fri, 24 Jan 2003 22:58:50 -0800 (PST)
	(envelope-from dave@lafn.org)
Received: from dave by localhost with local (Exim 3.36 #1 (Debian))
	id 18cKDD-0000DJ-00
	for <linux-serial@vger.kernel.org>; Fri, 24 Jan 2003 22:54:43 -0800
Content-Disposition: inline
In-Reply-To: <20030124013902.GF765@wheat.boylan.org>
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

On Thu, Jan 23, 2003 at 05:39:02PM -0800, Ross Boylan wrote:
> When I connect my APC BackUPS 650 to ttyS1 the unit turns off when
> Linux starts up.  APC tells me (after several days) that a different
> cable is necessary for Unixy systems than for windows.  Apparently
> some voltage on the serial port gets transmitted back to the unit,
> which interprets it as a shut down signal.  (That is, I continue to
> get power, but if the wall power fails the battery won't kick in).
> 
> Since the hardware works under Windows, I assume there is a software
> solution, and I would like to find it.
> 
> APC further says the port should be at 2400 baud, with Flow set to
> XON/XOFF (which might also be known as no FIFO).  

Xon/Xoff flow control also makes use of the FIFO.  You must disable
RTS/CTS hardware flow control so that the RTS and CTS lines can be used
for UPS signalling on those lines.  You can do this with the stty
command.  The control setting is: -crtscts to disable it.  Look at how
it's set with "stty -F /dev/ttyS1 -a".  Regarding setting Xon/Xoff, the
stty man page seems to be wrong as you need both ixon and ixoff to have
full software flow control.  See "man termios" for the correct info on
this.  

> I find baud control but no flow control in setserial, and at any rate
Since it's done by stty.
> my understanding is that it doesn't reprogram the physical device.
Correct.  But stty does a little of this since it sets the baud rate in
the physical device.

[snip]

			David Lawyer
