From: whitnl73@juno.com
Subject: Re: port speeds >115k
Date: Mon, 24 Feb 2003 20:25:29 -0500 (EST)
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <20030225.100825.8.2.whitnl73@juno.com>
References: <20030224175738.GA349@jats9>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <20030224175738.GA349@jats9>
List-Id: linux-serial@vger.kernel.org
To: delt@gate-way.net
Cc: linux-serial@vger.kernel.org

On Mon, 24 Feb 2003, Tim wrote:

...
>
> Well I noticed stty <anyspeed> makes no dif in an xterm, or the
> getty on a vc, but with

Right.  xterm and getty set the speed themselves, as any serial app can.
stty only matters if the app doesn't set the speed.

> http://members.gate-way.net/delt/test/500k.html
> my hardware ISA modem behaves like:
>
> CARRIER	PORT	AVG.RATE
> =======	====	========
> 46k	115k	10.5kB/s
> 26k	115k	10.5kB/s
> 14k	115k	10.5kB/s
> 46k	 57k	 5.3kB/s

This is ^ _bits_, not bytes, per second, and includes start and stop
bits.

...
Lawson
--
---oops---



________________________________________________________________
Sign Up for Juno Platinum Internet Access Today
Only $9.95 per month!
Visit www.juno.com
