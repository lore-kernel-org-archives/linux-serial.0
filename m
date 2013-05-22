From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC 1/8] serial:st-asc: Add ST ASC driver.
Date: Wed, 22 May 2013 17:13:37 +0200
Message-ID: <201305221713.37752.arnd@arndb.de>
References: <1368022187-1633-1-git-send-email-srinivas.kandagatla@st.com> <201305081634.43498.arnd@arndb.de> <A3BF01DB4A606149A4C20C4C4C808F6C336343F95B@SAFEX1MAIL1.st.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:62200 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753226Ab3EVPNo (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 22 May 2013 11:13:44 -0400
In-Reply-To: <A3BF01DB4A606149A4C20C4C4C808F6C336343F95B@SAFEX1MAIL1.st.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Stephen GALLIMORE <stephen.gallimore@st.com>
Cc: Srinivas KANDAGATLA <srinivas.kandagatla@st.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Monday 20 May 2013, Stephen GALLIMORE wrote:
> We have pretty much completed reworking the patch set we sent recently, but
> there is one comment you made which seemed to make perfect sense
> but after investigating it has left me totally confused, which was:
> 
> >I would also recommed adding a way to set the default baud rate through
> > a property. Following the example of the 8250 driver, you should probably
> > call that "current-speed".
> 
> I note that you are listed as the author of of_serial.c so I was assuming
> that looking at this would make sense, but it doesn't at all, and I would
> be really grateful if you could explain what you were trying to achieve
> and how you thought it worked. The code does:
> 
>         /* If current-speed was set, then try not to change it. */
>         if (of_property_read_u32(np, "current-speed", &spd) == 0)
>                 port->custom_divisor = clk / (16 * spd);
> 
> The "spd" variable is not used again and I do not understand why you 
> thought setting port->custom_divisor would have any impact on the default 
> or current baud rate of the UART, or that this information was useful to 
> any other part of the system. A search has only revealed that this port 
> field has only one purpose, which is to provide a "custom" speed 
> (unsurprisingly) when the user requests 38.4K and the port flag 
> UPF_SPD_CUST has been set through a TIOCSSERIAL ioctl call, instead of
> actually getting 38.4K. The key part of that assessment being the 
> implementation of uart_get_divisor() :
> 
>        if (baud == 38400 && (port->flags & UPF_SPD_MASK) == UPF_SPD_CUST)
>                 quot = port->custom_divisor;
>         else
>                 quot = DIV_ROUND_CLOSEST(port->uartclk, 16 * baud);
> 
> Also all of the custom_divisor functionality is basically commented as "old" 
> or has a kernel warning saying it is deprecated (see uart_set_info), so as
> far as I can see for our (and I suspect most) hardware it is completely 
> irrelevant functionality.

What may have happened here is that custom_divisor was used in a different
way when I added that code than it is today, and the change was not propagated
into the of_serial driver. However, going back to 2.6.20 shows no different
code than what we have today in this regard. It may simply have been a mistake
on my side.

> So I don't see why you think the concept of a default or current speed belongs 
> in the device tree description of the uart at all, unless there is something 
> special about the hardware.

I looked it up in the original serial port binding at
http://www.openfirmware.org/1275/bindings/devices/html/serial.html, which does
not specify the property, and in ePAPR, which does have it in the section about
"serial class devices":

18 6.2.1.2 current-speed
19 Property: current-speed
20 Value type: <u32>
21 Description:
22 Specifies the current speed of a serial device in bits per second. A boot program should set
23 this property if it has initialized the serial device.
24 Example:
25 current - speed = <115200>; # 115200 baud

The reason you want this is so that the driver can initialize the hardware from
scratch more easily and get back to the same settings. Why they only specified
the baud rate but not also start/stop bits and flow control I don't understand
though.

I guess you can ignore my original comment.

	Arnd
