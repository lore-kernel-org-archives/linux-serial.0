From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 3/3][v6] serial_mctrl_gpio: use gpiod_set_array function
Date: Fri, 14 Nov 2014 10:59:49 +0100
Message-ID: <CACRpkdZURBdaqg=hWpP7WDirQy+zcSEm-_5_X0-2UBO+8yLvng@mail.gmail.com>
References: <4411649.XDFZ6bkb1u@pcimr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-ig0-f182.google.com ([209.85.213.182]:45388 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965054AbaKNJ7u (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 14 Nov 2014 04:59:50 -0500
Received: by mail-ig0-f182.google.com with SMTP id hn18so1223871igb.3
        for <linux-serial@vger.kernel.org>; Fri, 14 Nov 2014 01:59:49 -0800 (PST)
In-Reply-To: <4411649.XDFZ6bkb1u@pcimr>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Rojhalat Ibrahim <imr@rtschenk.de>, Greg Kroah-Hartman <greg@kroah.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
Cc: "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Alexandre Courbot <gnurou@gmail.com>, Grant Likely <grant.likely@linaro.org>, Mark Brown <broonie@kernel.org>, Gerhard Sittig <gsi@denx.de>

On Tue, Nov 4, 2014 at 5:12 PM, Rojhalat Ibrahim <imr@rtschenk.de> wrote:

> Make the serial_mctrl_gpio driver the first user of the new gpiod_set_array
> function. All modem control output signals are now set simultaneously.
>
> Signed-off-by: Rojhalat Ibrahim <imr@rtschenk.de>
> ---
> This patch depends on my previous patch "gpiolib: allow simultaneous setting
> of multiple GPIO outputs".
>
> Change log:
>   v6: - add this patch to the series

You need to send this patch to Greg and the Linux-serial mailing list so
I can get an ACK from Greg on it.

But I totally accept it as a good first in-kernel usecase!

Yours,
Linus Walleij
