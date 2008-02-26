From: =?iso-8859-1?Q?Chris_Dor=E9?= <cdore@connecttech.com>
Subject: RE: Inter-Character Delay
Date: Tue, 26 Feb 2008 15:59:41 -0500
Message-ID: <010301c878ba$8365b4b0$8a311e10$@com>
References: <200802181336.26328.rgetz@blackfin.uclinux.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from inetc.connecttech.com ([64.7.140.42]:1644 "EHLO
	inetc.connecttech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753756AbYBZVJ1 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 26 Feb 2008 16:09:27 -0500
Received: from connecttech.com (cti2.connecttech.com [206.130.75.42])
	by inetc.connecttech.com (8.13.3P/8.13.3) with ESMTP id m1QL039t001939
	for <linux-serial@vger.kernel.org>; Tue, 26 Feb 2008 16:00:03 -0500 (EST)
	(envelope-from cdore@connecttech.com)
Received: from cdore ([206.130.75.122]) by connecttech.com (8.10.1/UW7.1.1-NSCd) with ESMTP id m1QKxgE02114 for <linux-serial@vger.kernel.org>; Tue, 26 Feb 2008 15:59:43 -0500 (EST)
In-Reply-To: <200802181336.26328.rgetz@blackfin.uclinux.org>
Content-Language: en-ca
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

If I read this correctly, the summary is that you:

1. Want to add functionality to the serial driver that supports an extra
feature (the delay register).
2. Would like to know what the best way is to expose this new functionality
to a user app.
3. Are NOT looking for a way to create the delay on hardware that does not
natively support it.

I don't have good answers for you, but perhaps this will help summarize and
clear up what you are really after.


..Chris

> -----Original Message-----
> From: linux-serial-owner@vger.kernel.org [mailto:linux-serial-
> owner@vger.kernel.org] On Behalf Of Robin Getz
> Sent: February 18, 2008 1:36 PM
> To: linux-serial@vger.kernel.org
> Subject: Inter-Character Delay
> 
> It is quite common on many industrial serial devices which do not support
> either software or hardware flow control to require a Inter-Character
delay
> longer than than the standard one, one and a half, or two stop bits.
> 
> A device where this long inter character delay is required are devices
like
> Point of Sale terminals, and devices that are talking to Modbus (Honeywell
> SI-FTA implements a check on the inter-character gap).
> 
> Some hardware manufactures have seen this need, and added it to their UART
> controllers - Atmel's AT32AP7000 has added this and called it a
"Timeguard"
> (Don't ask me why). The "timeguard delay" is controlled between 0 and 255
Bit
> Periods.
> 
> http://www.atmel.com/dyn/resources/prod_documents/doc32003.pdf
> 
> I think I have seen similar things for some ARM devices, and other
embedded
> architectures. Today, we have done similar things in the driver (on
hardware
> that doesn't support it natively).
> 
> I'm not sure that bit periods are the best way to measure things, or
> milliseconds. I guess it really doesn't matter, as long as everyone does
it
> the same way - which brings me to my next question:
> 
> Does anyone have a good idea of a standard way to expose this to
userspace?
>  - grabbing 8 bits in the termios_p c_oflag isn't going to fit
>  - adding a new field in the termios structure seems like overkill
>  - adding backdoor ioctls for serial drivers seems like a bad idea.
> 
> Thoughts?
> 
> Thanks
> -Robin
> -
> To unsubscribe from this list: send the line "unsubscribe linux-serial" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

