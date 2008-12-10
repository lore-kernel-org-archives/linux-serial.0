From: Chris Gibson <chris@toftronix.com.au>
Subject: Re: Onboard COM of P5E-V-HDMI
Date: Wed, 10 Dec 2008 21:17:56 +1100
Message-ID: <1228904276.3664.20.camel@thewinkle.toftronix.com.au>
References: <493D4C7A.3050409@netspace.net.au>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from toftronix.com.au ([60.241.205.236]:40983 "EHLO
	thetriton.toftronix.com.au" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755161AbYLJKOy (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 10 Dec 2008 05:14:54 -0500
In-Reply-To: <493D4C7A.3050409@netspace.net.au>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Russell Shaw <rjshaw@netspace.net.au>
Cc: linux-serial@vger.kernel.org

Could be a fault with the Mother board.  Could be a grounding fault.

First thing that I would check is continuity on the RS232 port ground
pin to the motherboard earth with a multimeter (say one of the black
leads from the power supply).

It's my first guess that the port has a bad ground connection, and that
you are seeing a current flow out of the output signals back through the
input signals down to ground via input pull down resistors on the
motherboard, or in the chip-set.

If you have access to a CRO I would say that it would be worth looking
at the serial port wave forms. 

On Tue, 2008-12-09 at 03:34 +1100, Russell Shaw wrote:
> Hi,
> 
> I'm running 2.6.24 on debian/unstable.
> 
> I have an Asus P5E-V-HDMI (Intel G35 chipset) with on-board rs232 serial port.
> 
> http://www.asus.com/products.aspx?l1=3&l2=11&l3=584&l4=0&model=1929&modelmenu=1
> 
> 
> With an LED breakout box connected, i get these signals asserted
> when doing: cat random.txt > /dev/ttyS0:
> 
> TD   faint green
> RD   flickering red and green
> RTS  red
> DTR  red
> 
> When i'm not sending anything i get:
> 
> TD  red
> RD  green
> RTS green
> CTS red
> DSR red
> DCD red
> DTR red
> 
> 
> IIRC, RD should not be asserted red or green at all because it
> should be an input.
> 
> My other serial cards behave ok.
> 
> I checked the cable between the motherboard and breakout box.
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-serial" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

