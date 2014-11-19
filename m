From: =?UTF-8?B?SmFudXN6IFXFvHlja2k=?= <j.uzycki@elproma.com.pl>
Subject: Re: [PATCH][RESEND] serial_mctrl_gpio: use gpiod_set_array function
Date: Wed, 19 Nov 2014 23:41:06 +0100
Message-ID: <546D1C82.4020808@elproma.com.pl>
References: <8534699.OPo8bzguux@pcimr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from v032797.home.net.pl ([89.161.177.31]:62822 "HELO
	v032797.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1758360AbaKSWk7 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 19 Nov 2014 17:40:59 -0500
In-Reply-To: <8534699.OPo8bzguux@pcimr>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Rojhalat Ibrahim <imr@rtschenk.de>
Cc: Richard Genoud <richard.genoud@gmail.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>

Hello.

Good patch but I'd prefer to introduce separate function for mctrl_gpio.
I'm not conviced whether it is useful for 2 gpio lines (outputs: RTS, 
DTR) of mctrl_gpio.
It adds some overhead for all drivers which use mctrl_gpio but likely 
they don't require it.

best regards
Janusz
