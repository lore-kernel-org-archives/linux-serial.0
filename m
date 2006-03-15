From: Paul Fulghum <paulkf@microgate.com>
Subject: Re: High speed RS232 card woes
Date: Wed, 15 Mar 2006 09:58:45 -0600
Message-ID: <1142438325.3425.12.camel@amdx2.microgate.com>
References: <4417E973.6070602@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from adsl-70-250-156-241.dsl.austtx.swbell.net ([70.250.156.241]:17360
	"EHLO gw.microgate.com") by vger.kernel.org with ESMTP
	id S1752091AbWCOP6x (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 15 Mar 2006 10:58:53 -0500
In-Reply-To: <4417E973.6070602@mail.ru>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Nickie Deuxyeux <the_lt@mail.ru>
Cc: linux-serial@vger.kernel.org

On Wed, 2006-03-15 at 13:16 +0300, Nickie Deuxyeux wrote:
> I am trying to setup a 2-port high-speed RS232 card (MP954R2) under 
> Gentoo Linux 2006.0. The card has an Oxford Semi OX16PCI954 chip and a 
> clock oscillator at 1.8432 Mhz.
...
> The main problem is, the device I am trying to connect (CDMA terminal) 
> can only work with a baud rate of 230400. I can't seem to get the device 
> to respond to AT commands in minicom, though I have absolutely no 
> problems under Windows, the device works flawlessly using the same card.

The OX16PCI954 defaults to a standard oversampling of 16
which yields a max 115200bps for a 1.8432MHz clock.

This device has a non-standard Times Clock Register (TCR) that
can be used to lower the oversampling (minimum of 4)
and allow higher speeds (up to 460,800bps) with the 1.8432MHz clock.

But the driver has to know how to set that. I don't see
that the standard 8250.c serial driver has any knowledge of this
register.

The Windows drivers must know how to set this correctly.

-- 
Paul Fulghum
Microgate Systems, Ltd

