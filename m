From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 1/2] serial/amba-pl011: use devm_* allocators
Date: Wed, 20 Jun 2012 11:03:01 +0100
Message-ID: <20120620100301.GB12537@n2100.arm.linux.org.uk>
References: <1339940648-6847-1-git-send-email-linus.walleij@stericsson.com> <CAOMZO5DGxPQyHpPLLJk1P5kmyfB+9jct1rwEZj918wM84ePRKA@mail.gmail.com> <CACRpkdahAYSd+H1hgUwwZh3UY7oS1QTym8uyggpmOgBAuSOaxg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:58974 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751511Ab2FTKDP (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 20 Jun 2012 06:03:15 -0400
Content-Disposition: inline
In-Reply-To: <CACRpkdahAYSd+H1hgUwwZh3UY7oS1QTym8uyggpmOgBAuSOaxg@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Fabio Estevam <festevam@gmail.com>, Linus Walleij <linus.walleij@stericsson.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Mon, Jun 18, 2012 at 08:37:20AM +0200, Linus Walleij wrote:
> On Sun, Jun 17, 2012 at 4:13 PM, Fabio Estevam <festevam@gmail.com> w=
rote:
> > On Sun, Jun 17, 2012 at 10:44 AM, Linus Walleij
> > <linus.walleij@stericsson.com> wrote:
> >
> >> =A0 =A0 =A0 =A0uap->pinctrl =3D devm_pinctrl_get(&dev->dev);
> >> =A0 =A0 =A0 =A0if (IS_ERR(uap->pinctrl)) {
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ret =3D PTR_ERR(uap->pinctrl);
> >> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto unmap;
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
> >> =A0 =A0 =A0 =A0}
> >> =A0 =A0 =A0 =A0uap->pins_default =3D pinctrl_lookup_state(uap->pin=
ctrl,
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 PINCTRL_STATE_DEFAULT);
> >> @@ -1915,7 +1917,7 @@ static int pl011_probe(struct amba_device *d=
ev, const struct amba_id *id)
> >> =A0 =A0 =A0 =A0uap->clk =3D clk_get(&dev->dev, NULL);
> >
> > Maybe you can use devm_clk_get here too.
>=20
> That requires all users of the driver to be using CONFIG_CLKDEV, whic=
h
> I *think* is safe to do, but better check: Russell, do you know if
> it's safe to use
> this feature from clkdev in the PL011 driver?

No idea.  What I have said is that the devm_* clk_get interfaces should
not be dependent on clkdev being built.
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
