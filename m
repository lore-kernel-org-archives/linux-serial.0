From: Steve Tell <tell@telltronics.org>
Subject: RE: Best way to detect received call on dumb modem ...
Date: Tue, 4 Nov 2003 01:17:31 -0500 (EST)
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <Pine.LNX.4.56.0311040106360.15984@ariel>
References: <000801c3a0f7$fbd98a10$0200000a@francois>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from dsl093-240-080.ral1.dsl.speakeasy.net ([66.93.240.80]:29946
	"EHLO telltronics.org") by vger.kernel.org with ESMTP
	id S263718AbTKDGRj (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 4 Nov 2003 01:17:39 -0500
In-Reply-To: <000801c3a0f7$fbd98a10$0200000a@francois>
List-Id: linux-serial@vger.kernel.org
To: lewisbrown@acm.org
Cc: linux-serial@vger.kernel.org

On Sat, 1 Nov 2003, Lewis Brown wrote:

> Sorry for not being more specific.
> 
> I thought a 'dumb' modem was one that had been taken out of command mode
> and thus does not respond to AT commands; at least that's what I meant.

(That's what I thought too... or else a modem that never had an AT or any 
other fancy command set to begin with)
 
Configure the modem to auto-answer when DTR is asserted and when when 
phone rings, and to only assert CD (carrier detect) when it really has a 
carrier.

Then call open(2) on the tty without O_NONBLOCK/O_NDELAY.  DTR will get
asserted to enable the modem, and then the open(2)  will block until the
modem answers and establishes a connection with the calling modem.

This is how modems and getty(8) worked on unixes 20+ years ago... 
(well, except that the 1200bps modems modems were the fast ones)

Steve
 
> I should say that this is an old problem that I haven't worked on in
> over 9 months, so I've forgotten some of the details of my problem.  I
> think that in dumb state, the modem can't send RING, CONNECT, etc., so
> one must detect DSR, DTR, RNG, etc.  At least that's what I want to do.
> 
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
> -----Original Message-----
> From: linux-serial-owner@vger.kernel.org
> [mailto:linux-serial-owner@vger.kernel.org] On Behalf Of Jan-Benedict
> Glaw
> Sent: Saturday, November 01, 2003 2:14 PM
> To: linux-serial@vger.kernel.org
> Subject: Re: Best way to detect received call on dumb modem ...
> 
> 
> On Sat, 2003-11-01 13:43:23 -0700, Lewis Brown <lewisb@denveronline.com>
> wrote in message <000001c3a0b8$ce82efa0$0200000a@francois>:
> > Hello,
> > 
> > I'm trying to detect incoming calls on a dumb modem but dealing with a
> > driver that doesn't implement TIOCMIWAIT or TIOCGICOUNT. I'm puzzled
> how
> > best to go forward in an efficient way.
> 
> select() on the fd and wait until you receive "RING"? However, what's a
> "dumb" modem?
> 
> MfG, JBG
> 
> 
