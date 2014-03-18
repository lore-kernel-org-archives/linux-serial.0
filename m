From: Richard Genoud <richard.genoud@gmail.com>
Subject: Re: [PATCH v6 1/3] tty/serial: Add GPIOLIB helpers for controlling
 modem lines
Date: Tue, 18 Mar 2014 11:13:35 +0100
Message-ID: <CACQ1gAjNfZ5e7tp6zpXZfceyDeORTODxHMN-YM3hY0Zz-vEefA@mail.gmail.com>
References: <1394469951-21192-1-git-send-email-richard.genoud@gmail.com>
 <1394469951-21192-2-git-send-email-richard.genoud@gmail.com> <20140317232359.GA8943@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-la0-f53.google.com ([209.85.215.53]:61079 "EHLO
	mail-la0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754359AbaCRKN5 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 18 Mar 2014 06:13:57 -0400
Received: by mail-la0-f53.google.com with SMTP id b8so4629757lan.12
        for <linux-serial@vger.kernel.org>; Tue, 18 Mar 2014 03:13:55 -0700 (PDT)
In-Reply-To: <20140317232359.GA8943@kroah.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Richard Genoud <noreply.rgenoud@gmail.com>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Nicolas Ferre <nicolas.ferre@atmel.com>, Linus Walleij <linus.walleij@linaro.org>, Alexander Shiyan <shc_work@mail.ru>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

2014-03-18 0:23 GMT+01:00 Greg Kroah-Hartman <gregkh@linuxfoundation.org>:
> On Mon, Mar 10, 2014 at 05:45:49PM +0100, Richard Genoud wrote:
>> This patch add some helpers to control modem lines (CTS/RTS/DSR...) via
>> GPIO.
>> This will be useful for many boards which have a serial controller that
>> only handle CTS/RTS pins (or even just RX/TX).
>>
>> Signed-off-by: Richard Genoud <richard.genoud@gmail.com>
>
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>
> I can't take this series through my tty tree as the non-tty patches
> don't apply, so feel free to take them through whatever tree is needed.
>
> greg k-h

To clarify things, here are the patches that this series needs, on top
of 3.14-rc6:
tty/tty-next tree: ddaa603739fe tty/serial: at91: use dev_err instead of printk
tty/tty-next tree: a3c1fa99f4d2 tty/serial: at91: remove unused open/close hooks
ukl/dropmachtimexh-fixup: 354e57f3a0a2 ARM/serial: at91: switch atmel
serial to use gpiolib
tree unknown: [PATCH v3 5/7] ARM: at91: gpio: implement get_direction
pinctrl/for-next: 8af584b86836 pinctrl: at91: implement get_direction

after that, the series applies cleanly.
the patch "[PATCH v3 5/7] ARM: at91: gpio: implement get_direction"
has been acked-by Linus, but I didn't found it in a tree.

onto next-20140318, it only needs "[PATCH v3 5/7] ARM: at91: gpio:
implement get_direction" .

trees:
tty: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git
ukl: git://git.pengutronix.de/git/ukl/linux.git
pinctrl: git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git


Richard.
