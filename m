From: Roland Stigge <stigge@antcom.de>
Subject: Re: [PATCH] serial/of-serial: Add 16654 chip to compatible string
 list
Date: Mon, 28 May 2012 13:20:55 +0200
Message-ID: <4FC35F97.2030400@antcom.de>
References: <1338199134-23885-1-git-send-email-stigge@antcom.de> <20120528100338.GI24149@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20120528100338.GI24149@n2100.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: alan@linux.intel.com, gregkh@linuxfoundation.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, kevin.wells@nxp.com, srinivas.bakki@nxp.com, linux-arm-kernel@lists.infradead.org, arnd@arndb.de
List-Id: linux-serial@vger.kernel.org

On 28/05/12 12:03, Russell King - ARM Linux wrote:
> Something which occurs to me.  Normally, the digit at the end indicates
> how many ports are integrated into the device (0=1port, 2=2port, 4=4port.)
> Are you sure there isn't a ST16650 which has the same characteristics?
> 
> We really should stick with naming these using the single port versions if
> at all possible.

Right.

This indicates to me that maybe this is not the right solution for my
original problem, anyway. :-)

Initially, with my RFC patch, there was an #ifdef for bigger FIFO in
case of LPC32xx where we have a 16550A variant with 64 byte fifos.

Looking at the 16x50 line:

16550A  16 bytes FIFOs
16650V2 32 bytes FIFOs
16750   64 bytes FIFOs

(?)

So maybe 16750 is the better choice for me, anyway. Already supported in
of-serial. Works for now, but need more testing. Another hint is that
16750 is advertised as "IP core for Soc" which matches the case of LPC32xx.

Maybe NXP can comment on this?

Thanks in advance,

Roland
