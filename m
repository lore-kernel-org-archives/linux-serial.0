From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v3 6/7] pinctrl: at91: implement get_direction
Date: Mon, 24 Feb 2014 15:44:53 +0100
Message-ID: <CACRpkdZN_fT05+1JCJ2bemN3KfpfFFWu__HQcL9Sz7n2M9gCnw@mail.gmail.com>
References: <1392656247-3351-1-git-send-email-richard.genoud@gmail.com>
	<1392656247-3351-7-git-send-email-richard.genoud@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-oa0-f47.google.com ([209.85.219.47]:57081 "EHLO
	mail-oa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752461AbaBXOoy (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 24 Feb 2014 09:44:54 -0500
Received: by mail-oa0-f47.google.com with SMTP id h16so2041497oag.20
        for <linux-serial@vger.kernel.org>; Mon, 24 Feb 2014 06:44:54 -0800 (PST)
In-Reply-To: <1392656247-3351-7-git-send-email-richard.genoud@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Richard Genoud <richard.genoud@gmail.com>, Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?ISO-8859-1?Q?Uwe_Kleine=2DK=F6nig?= <u.kleine-koenig@pengutronix.de>, Alexander Shiyan <shc_work@mail.ru>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>

On Mon, Feb 17, 2014 at 5:57 PM, Richard Genoud
<richard.genoud@gmail.com> wrote:

> This is needed for gpiod_get_direction().
> Otherwise, it returns -EINVAL.
>
> Signed-off-by: Richard Genoud <richard.genoud@gmail.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Can I apply this directly to the pinctrl tree or do you want it to
go through AT91 ARM SoC with the rest of these patches
or something?

Yours,
Linus Walleij
