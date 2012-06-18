From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 1/2] serial/amba-pl011: use devm_* allocators
Date: Mon, 18 Jun 2012 08:37:20 +0200
Message-ID: <CACRpkdahAYSd+H1hgUwwZh3UY7oS1QTym8uyggpmOgBAuSOaxg@mail.gmail.com>
References: <1339940648-6847-1-git-send-email-linus.walleij@stericsson.com>
	<CAOMZO5DGxPQyHpPLLJk1P5kmyfB+9jct1rwEZj918wM84ePRKA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-qa0-f42.google.com ([209.85.216.42]:33576 "EHLO
	mail-qa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751461Ab2FRGhV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 18 Jun 2012 02:37:21 -0400
Received: by qafi31 with SMTP id i31so1279312qaf.1
        for <linux-serial@vger.kernel.org>; Sun, 17 Jun 2012 23:37:20 -0700 (PDT)
In-Reply-To: <CAOMZO5DGxPQyHpPLLJk1P5kmyfB+9jct1rwEZj918wM84ePRKA@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Linus Walleij <linus.walleij@stericsson.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Sun, Jun 17, 2012 at 4:13 PM, Fabio Estevam <festevam@gmail.com> wro=
te:
> On Sun, Jun 17, 2012 at 10:44 AM, Linus Walleij
> <linus.walleij@stericsson.com> wrote:
>
>> =A0 =A0 =A0 =A0uap->pinctrl =3D devm_pinctrl_get(&dev->dev);
>> =A0 =A0 =A0 =A0if (IS_ERR(uap->pinctrl)) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ret =3D PTR_ERR(uap->pinctrl);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto unmap;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>> =A0 =A0 =A0 =A0}
>> =A0 =A0 =A0 =A0uap->pins_default =3D pinctrl_lookup_state(uap->pinct=
rl,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 PINCTRL_STATE_DEFAULT);
>> @@ -1915,7 +1917,7 @@ static int pl011_probe(struct amba_device *dev=
, const struct amba_id *id)
>> =A0 =A0 =A0 =A0uap->clk =3D clk_get(&dev->dev, NULL);
>
> Maybe you can use devm_clk_get here too.

That requires all users of the driver to be using CONFIG_CLKDEV, which
I *think* is safe to do, but better check: Russell, do you know if
it's safe to use
this feature from clkdev in the PL011 driver?

It seems so to me and most likely works on the systems I have (Ux500, U=
300,
Nomadik, Integrator, RealView) but the world of PL011 is so big...

Yours,
Linus Walleij
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
