From: David Lawyer <dave@lafn.org>
Subject: Re: Best way to detect received call on dumb modem ...
Date: Sun, 2 Nov 2003 00:28:03 -0800
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <20031102082803.GA520@lafn.org>
References: <20031101211402.GV31376@lug-owl.de> <000801c3a0f7$fbd98a10$0200000a@francois>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from zoot.lafn.ORG ([206.117.18.6]:38929 "EHLO zoot.lafn.org")
	by vger.kernel.org with ESMTP id S261931AbTKCGt5 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 3 Nov 2003 01:49:57 -0500
Content-Disposition: inline
In-Reply-To: <000801c3a0f7$fbd98a10$0200000a@francois>
List-Id: linux-serial@vger.kernel.org
To: lewisbrown@acm.org
Cc: linux-serial@vger.kernel.org

On Sat, Nov 01, 2003 at 09:15:38PM -0700, Lewis Brown wrote:
> Sorry for not being more specific.
> 
> I thought a 'dumb' modem was one that had been taken out of command mode
> and thus does not respond to AT commands; at least that's what I meant.

How do you get the modem into this mode?  When you connect to another
modem, AT command mode is lost, but then you can't get any rings since
you are using the phone line.

> 
> I should say that this is an old problem that I haven't worked on in
> over 9 months, so I've forgotten some of the details of my problem.  I
> think that in dumb state, the modem can't send RING, CONNECT, etc., so
> one must detect DSR, DTR, RNG, etc.  At least that's what I want to do.

Sure, you can tell it not to send result codes or words, but it's still
in AT command mode and still responds to AT commands.  Is this what
you're doing?

> When I wrote this program the first time, it worked great and was really
> fast.  Then I moved it to the real hardware, a DIGI RAS box, which
> didn't have all the standard IOCTLs.  The program now requires the
> modems to be in command mode; I have to parse the stream for RING,
> CONNECT, OK, etc;  and it is slow and very prone to error.  Seems the
> modems are always going haywire this way.  I want to go back to dumb
> mode and work as close as possible to the hardware.  I need speed and
> reliability.
> 
> Any suggestions are much appreciated.
> lb
> 
[snip]
			David Lawyer
