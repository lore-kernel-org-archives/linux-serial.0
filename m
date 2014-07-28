From: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Subject: Support for RS485 on 8250 clone
Date: Mon, 28 Jul 2014 17:19:56 +0200
Message-ID: <CAPybu_2XurwztXTo+KwqKw1NpKFTLgPQ5AHyuO-z7-=65oAGqw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-oa0-f42.google.com ([209.85.219.42]:58558 "EHLO
	mail-oa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750915AbaG1PUR (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 28 Jul 2014 11:20:17 -0400
Received: by mail-oa0-f42.google.com with SMTP id n16so8828433oag.15
        for <linux-serial@vger.kernel.org>; Mon, 28 Jul 2014 08:20:16 -0700 (PDT)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org

Hello

I have a device with a Fintek F81216A  LPC to 4 Uart device.

One of the uarts is used as half duplex rs485 serial port. This means
that it needs to be configured properly (logical level of rts, delays,
etc...)

I see that there is an API on the kernel to do this (TIOCGRS485),
unfortunately the 8250 driver does not support it.

1) Is there any interest on supporting this kind of hardware on the kernel?

2) Some driver that I could use for inspiration?

Thanks and best regards!




-- 
Ricardo Ribalda
