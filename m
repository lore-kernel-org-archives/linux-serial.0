From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v3 6/7] pinctrl: at91: implement get_direction
Date: Tue, 25 Feb 2014 10:34:33 +0100
Message-ID: <CACRpkdaOhJr2=uiR6KeEFBNT4ChPF6T42Q2v5oLwZrZLBgS=6A@mail.gmail.com>
References: <1392656247-3351-1-git-send-email-richard.genoud@gmail.com>
	<1392656247-3351-7-git-send-email-richard.genoud@gmail.com>
	<CACRpkdZN_fT05+1JCJ2bemN3KfpfFFWu__HQcL9Sz7n2M9gCnw@mail.gmail.com>
	<CACQ1gAi+rSvuRzCQiyV4QT0V75CccwH7iSEBRMyDdF_1W63OKA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-oa0-f45.google.com ([209.85.219.45]:63207 "EHLO
	mail-oa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750744AbaBYJee (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 25 Feb 2014 04:34:34 -0500
Received: by mail-oa0-f45.google.com with SMTP id i11so124595oag.32
        for <linux-serial@vger.kernel.org>; Tue, 25 Feb 2014 01:34:33 -0800 (PST)
In-Reply-To: <CACQ1gAi+rSvuRzCQiyV4QT0V75CccwH7iSEBRMyDdF_1W63OKA@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Richard Genoud <richard.genoud@gmail.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?ISO-8859-1?Q?Uwe_Kleine=2DK=F6nig?= <u.kleine-koenig@pengutronix.de>, Alexander Shiyan <shc_work@mail.ru>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>

On Mon, Feb 24, 2014 at 3:56 PM, Richard Genoud
<richard.genoud@gmail.com> wrote:
> 2014-02-24 15:44 GMT+01:00 Linus Walleij <linus.walleij@linaro.org>:
>> On Mon, Feb 17, 2014 at 5:57 PM, Richard Genoud
>> <richard.genoud@gmail.com> wrote:
>>
>>> This is needed for gpiod_get_direction().
>>> Otherwise, it returns -EINVAL.
>>>
>>> Signed-off-by: Richard Genoud <richard.genoud@gmail.com>
>>
>> Acked-by: Linus Walleij <linus.walleij@linaro.org>
>>
>> Can I apply this directly to the pinctrl tree or do you want it to
>> go through AT91 ARM SoC with the rest of these patches
>> or something?
>
> Well, I guess you can apply it on pinctrl tree.

OK patch applied tentatively unless Nicolas or Jean-Christophe
has objections.

Yours,
Linus Walleij
