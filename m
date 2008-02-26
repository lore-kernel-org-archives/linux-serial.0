From: Robin Getz <rgetz@blackfin.uclinux.org>
Subject: Re: Inter-Character Delay
Date: Tue, 26 Feb 2008 11:11:58 -0500
Message-ID: <200802261111.58448.rgetz@blackfin.uclinux.org>
References: <200802181336.26328.rgetz@blackfin.uclinux.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from nwd2mail11.analog.com ([137.71.25.57]:8774 "EHLO
	nwd2mail11.analog.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750995AbYBZQKX (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 26 Feb 2008 11:10:23 -0500
In-Reply-To: <200802181336.26328.rgetz@blackfin.uclinux.org>
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Russell King <rmk+lkml@arm.linux.org.uk>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Haavard Skinnemoen <hskinnemoen@atmel.com>
Cc: linux-serial@vger.kernel.org

On Mon 18 Feb 2008 13:36, Robin Getz pondered:
> It is quite common on many industrial serial devices which do not
> support either software or hardware flow control to require a 
> Inter-Character delay longer than than the standard one, one and a 
> half, or two stop bits. 
> 
> A device where this long inter character delay is required are devices
> like Point of Sale terminals, and devices that are talking to Modbus
> (Honeywell SI-FTA implements a check on the inter-character gap).
> 
> Some hardware manufactures have seen this need, and added it to their
> UART controllers - Atmel's AT32AP7000 has added this and called it a
> "Timeguard" (Don't ask me why). The "timeguard delay" is controlled
> between 0 and 255 Bit Periods.
> 
> http://www.atmel.com/dyn/resources/prod_documents/doc32003.pdf
> 
> I think I have seen similar things for some ARM devices, and other
> embedded architectures. Today, we have done similar things in the driver
> (on hardware that doesn't support it natively).
> 
> I'm not sure that bit periods are the best way to measure things, or 
> milliseconds. I guess it really doesn't matter, as long as everyone does
> it the same way - which brings me to my next question:
> 
> Does anyone have a good idea of a standard way to expose this to
> userspace?
>  - grabbing 8 bits in the termios_p c_oflag isn't going to fit
>  - adding a new field in the termios structure seems like overkill
>  - adding backdoor ioctls for serial drivers seems like a bad idea.
> 
> Thoughts?

ping.

Comments appreciated.

-Robin
