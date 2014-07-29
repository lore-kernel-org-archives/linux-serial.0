From: =?UTF-8?B?SmnFmcOtIFByY2hhbA==?= <jiri.prchal@aksignal.cz>
Subject: Re: Support for RS485 on 8250 clone
Date: Tue, 29 Jul 2014 08:10:21 +0200
Message-ID: <53D73ACD.4010602@aksignal.cz>
References: <CAPybu_2XurwztXTo+KwqKw1NpKFTLgPQ5AHyuO-z7-=65oAGqw@mail.gmail.com>
Reply-To: jiri.prchal@aksignal.cz
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from router.aksignal.cz ([188.175.113.102]:60706 "EHLO
	router.aksignal.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750988AbaG2GK0 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 29 Jul 2014 02:10:26 -0400
In-Reply-To: <CAPybu_2XurwztXTo+KwqKw1NpKFTLgPQ5AHyuO-z7-=65oAGqw@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org

Hi,
as I know, the 8250 chip does not support RS485 rx/tx hw switching. You can do sw switching on some gpio.
HW switching suports 16550 or higher.

Dne 28.7.2014 v 17:19 Ricardo Ribalda Delgado napsal(a):
> Hello
>
> I have a device with a Fintek F81216A  LPC to 4 Uart device.
>
> One of the uarts is used as half duplex rs485 serial port. This means
> that it needs to be configured properly (logical level of rts, delays,
> etc...)
>
> I see that there is an API on the kernel to do this (TIOCGRS485),
> unfortunately the 8250 driver does not support it.
>
> 1) Is there any interest on supporting this kind of hardware on the kernel?
It would be nice.
>
> 2) Some driver that I could use for inspiration?
Try Advantech web site, they have some, but not GPL.
>
> Thanks and best regards!
>
>
>
>
