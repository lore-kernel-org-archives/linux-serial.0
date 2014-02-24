From: Richard Genoud <richard.genoud@gmail.com>
Subject: Re: [PATCH v3 6/7] pinctrl: at91: implement get_direction
Date: Mon, 24 Feb 2014 15:56:36 +0100
Message-ID: <CACQ1gAi+rSvuRzCQiyV4QT0V75CccwH7iSEBRMyDdF_1W63OKA@mail.gmail.com>
References: <1392656247-3351-1-git-send-email-richard.genoud@gmail.com>
 <1392656247-3351-7-git-send-email-richard.genoud@gmail.com> <CACRpkdZN_fT05+1JCJ2bemN3KfpfFFWu__HQcL9Sz7n2M9gCnw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-la0-f53.google.com ([209.85.215.53]:45990 "EHLO
	mail-la0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752260AbaBXO45 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 24 Feb 2014 09:56:57 -0500
Received: by mail-la0-f53.google.com with SMTP id e16so5887523lan.12
        for <linux-serial@vger.kernel.org>; Mon, 24 Feb 2014 06:56:56 -0800 (PST)
In-Reply-To: <CACRpkdZN_fT05+1JCJ2bemN3KfpfFFWu__HQcL9Sz7n2M9gCnw@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Alexander Shiyan <shc_work@mail.ru>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>

2014-02-24 15:44 GMT+01:00 Linus Walleij <linus.walleij@linaro.org>:
> On Mon, Feb 17, 2014 at 5:57 PM, Richard Genoud
> <richard.genoud@gmail.com> wrote:
>
>> This is needed for gpiod_get_direction().
>> Otherwise, it returns -EINVAL.
>>
>> Signed-off-by: Richard Genoud <richard.genoud@gmail.com>
>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
>
> Can I apply this directly to the pinctrl tree or do you want it to
> go through AT91 ARM SoC with the rest of these patches
> or something?

Well, I guess you can apply it on pinctrl tree.

I'll comme with an updated version of patches 1,4,7 soon, and I'll
write clearly in the cover letter the needed patches, and the tree
they're in to prevent breaking the compilation.

thanks !
