From: Mikhail Kolesnik <mike@openbunker.org>
Subject: Re: Oxford Semiconductor's OXCB950 in 8250_pci.c
Date: Wed, 10 May 2006 21:10:13 +0300
Message-ID: <20060510211013.76cf6a22@mike.staff.sky>
References: <20060507225942.0b2d7bbf@mike.staff.sky>
	<20060510163632.GE32632@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from silver.biz.ua ([80.68.246.128]:16608 "EHLO silver.biz.ua")
	by vger.kernel.org with ESMTP id S932449AbWEJSJY (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 10 May 2006 14:09:24 -0400
In-Reply-To: <20060510163632.GE32632@flint.arm.linux.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Russell King <rmk@arm.linux.org.uk>
Cc: linux-serial@vger.kernel.org

On Wed, 10 May 2006 17:36:32 +0100
Russell King <rmk@arm.linux.org.uk> wrote:

> On Sun, May 07, 2006 at 10:59:42PM +0300, Mikhail Kolesnik wrote:
> > ...
> > +	{	PCI_VENDOR_ID_OXSEMI, PCI_DEVICE_ID_OXSEMI_CB950,
> > +		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
> > +		pbn_b0_bt_1_115200 },
> 
> This should probably be pbn_b0_1_115200?

The reason was (from the discussion mentioned):
> pbn_b0_bt_1_115200 has been used instead
> of pbn_b0_1_115200, because the latter is identical to
> pbn_default, and the effect should be the same since
> OXCB950 is single-port. 

Seems it is not the problem here (as card partially works). Or should I
try changing it?

> > The problem is that card only works with baud rates from 50 to 2400.
> > The card is connected to a common external modem, which is known to
> > work with any reasonable rates in other PC.
> 
> Odd.  Maybe the port isn't clocked at the usual frequency, and 115200
> is the wrong base.

Is that datasheet of any use here?

> Well, 1.8432MHz corresponds with a base of 115200, so that's not wrong.
> IS your modem showing the DTE speed in that connect line?  If so, 2400
> baud seems to actually correspond with 230400 baud, which would be a
> rather interesting state of affairs.  What does setserial -bav /dev/ttyS4
> say?

Yes, the first number is 'DTE data rate' (but modem's chip datasheet
claims it does not support DTE higher than 115200). Note, with ANY
baud from 300 to 2400 result is:
"CONNECT 230400/Vxx/LAPM/Vxxx/TX=xxxxx/RX=xxxxx" 
But bauds lower than 1200 do really limit speed.

# setserial -bav /dev/ttyS4
/dev/ttyS4, Line 4, UART: 16950/954, Port: 0x3010, IRQ: 11
        Baud_base: 115200, close_delay: 50, divisor: 0
        closing_wait: 3000
        Flags: spd_normal skip_test

Changing divisor to 8.625 (it is reported to be '8') gave nothing.

BTW, I have many devices using IRQ 11, hope that is not causing weird
things? This Laptop's bios is not a good helper here...
# lspci -v | grep "IRQ\ 11" | wc -l
7

Anything else I can do here?


-- 
Mikhail Kolesnik
ICQ: 260259143
IRC: mike_k at freenode/#crux, rusnet/#yalta
Jabber: mike_k@jabber.lafox.net
NIC handle: MKK83-UANIC
