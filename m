From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v3 5/7] ARM: at91: gpio: implement get_direction
Date: Mon, 24 Feb 2014 15:42:45 +0100
Message-ID: <CACRpkdZCvTM8aD2-pJQSeX7rm01F5tgBGisJvK+uBr4NP7jd+Q@mail.gmail.com>
References: <1392656247-3351-1-git-send-email-richard.genoud@gmail.com>
	<1392656247-3351-6-git-send-email-richard.genoud@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-ob0-f178.google.com ([209.85.214.178]:45210 "EHLO
	mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752558AbaBXOmq (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 24 Feb 2014 09:42:46 -0500
Received: by mail-ob0-f178.google.com with SMTP id va2so4038436obc.37
        for <linux-serial@vger.kernel.org>; Mon, 24 Feb 2014 06:42:46 -0800 (PST)
In-Reply-To: <1392656247-3351-6-git-send-email-richard.genoud@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Richard Genoud <richard.genoud@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?ISO-8859-1?Q?Uwe_Kleine=2DK=F6nig?= <u.kleine-koenig@pengutronix.de>, Nicolas Ferre <nicolas.ferre@atmel.com>, Alexander Shiyan <shc_work@mail.ru>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>

On Mon, Feb 17, 2014 at 5:57 PM, Richard Genoud
<richard.genoud@gmail.com> wrote:

> This is needed for gpiod_get_direction().
> Otherwise, it returns -EINVAL.
>
> Signed-off-by: Richard Genoud <richard.genoud@gmail.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Nicolas: please apply this through the AT91 tree.

Yours,
Linus Walleij
