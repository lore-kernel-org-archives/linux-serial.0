From: Mikhail Kolesnik <mike@openbunker.org>
Subject: Fw: Re: Oxford Semiconductor's OXCB950 in 8250_pci.c
Date: Sun, 21 May 2006 13:17:20 +0300
Message-ID: <20060521131720.29c990f0@mike.staff.sky>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from silver.biz.ua ([80.68.246.128]:48352 "EHLO silver.biz.ua")
	by vger.kernel.org with ESMTP id S932356AbWEUKQF (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sun, 21 May 2006 06:16:05 -0400
Received: from 63-38-207-82.pool.ukrtel.net ([82.207.38.63]:42572 helo=mike.staff.sky)
	by silver.biz.ua with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.52)
	id 1Fhkyf-00064C-Fu
	for linux-serial@vger.kernel.org; Sun, 21 May 2006 14:16:01 +0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

Hope it is ok forwarding the message as my reply to it seems to be lost
somewhere...

Begin forwarded message:

Date: Wed, 10 May 2006 20:20:49 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Mikhail Kolesnik <mike@openbunker.org>
Subject: Re: Oxford Semiconductor's OXCB950 in 8250_pci.c

On Wed, May 10, 2006 at 09:10:13PM +0300, Mikhail Kolesnik wrote:
> On Wed, 10 May 2006 17:36:32 +0100
> Russell King <rmk@arm.linux.org.uk> wrote:
> 
> > On Sun, May 07, 2006 at 10:59:42PM +0300, Mikhail Kolesnik wrote:
> > > ...
> > > +	{	PCI_VENDOR_ID_OXSEMI, PCI_DEVICE_ID_OXSEMI_CB950,
> > > +		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
> > > +		pbn_b0_bt_1_115200 },
> > 
> > This should probably be pbn_b0_1_115200?
> 
> The reason was (from the discussion mentioned):
> > pbn_b0_bt_1_115200 has been used instead
> > of pbn_b0_1_115200, because the latter is identical to
> > pbn_default, and the effect should be the same since
> > OXCB950 is single-port. 
> 
> Seems it is not the problem here (as card partially works). Or should I
> try changing it?

The reason given there is no longer valid, and is just a preference.

> > > The problem is that card only works with baud rates from 50 to 2400.
> > > The card is connected to a common external modem, which is known to
> > > work with any reasonable rates in other PC.
> > 
> > Odd.  Maybe the port isn't clocked at the usual frequency, and 115200
> > is the wrong base.
> 
> Is that datasheet of any use here?

No - such devices can be used with multiple differing crystals, and the
data sheet allows the device to be used with crystals up to 60MHz!

> > Well, 1.8432MHz corresponds with a base of 115200, so that's not wrong.
> > IS your modem showing the DTE speed in that connect line?  If so, 2400
> > baud seems to actually correspond with 230400 baud, which would be a
> > rather interesting state of affairs.  What does setserial -bav /dev/ttyS4
> > say?
> 
> Yes, the first number is 'DTE data rate' (but modem's chip datasheet
> claims it does not support DTE higher than 115200). Note, with ANY
> baud from 300 to 2400 result is:
> "CONNECT 230400/Vxx/LAPM/Vxxx/TX=xxxxx/RX=xxxxx" 
> But bauds lower than 1200 do really limit speed.
> 
> # setserial -bav /dev/ttyS4
> /dev/ttyS4, Line 4, UART: 16950/954, Port: 0x3010, IRQ: 11
>         Baud_base: 115200, close_delay: 50, divisor: 0
>         closing_wait: 3000
>         Flags: spd_normal skip_test
> 
> Changing divisor to 8.625 (it is reported to be '8') gave nothing.

The "divisor" doesn't do anything in this mode.

What happens if you:

1. setserial /dev/ttyS4 spd_cust divisor 104
2. set the baud rate to 38400 baud

If what I think has happened is correct, 104 should approximate 9600
baud, 52 should approximate 19200 baud, 26 should be 38400 baud, and 17
should approximate 57600 baud.

It would be helpful if you could confirm that the modem does report the
real DTE data rate under Windows.

I hope that each time you test this it doesn't cost. 8/

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
