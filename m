From: viresh kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] serial/amba-pl011: move custom pin control to driver
Date: Mon, 25 Jun 2012 12:31:00 +0100
Message-ID: <CAOh2x==OPVVLeKxCT0mkYX3NmOjGQRcsSY=GHCaHEJfy6wOg3Q@mail.gmail.com>
References: <1337800726-4076-1-git-send-email-linus.walleij@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:56526 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751677Ab2FYLbA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 25 Jun 2012 07:31:00 -0400
Received: by obbuo13 with SMTP id uo13so6332469obb.19
        for <linux-serial@vger.kernel.org>; Mon, 25 Jun 2012 04:31:00 -0700 (PDT)
In-Reply-To: <1337800726-4076-1-git-send-email-linus.walleij@stericsson.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Linus Walleij <linus.walleij@stericsson.com>, Vipul Kumar SAMAR <vipulkumar.samar@st.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Lee Jones <lee.jones@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Shawn Guo <shawn.guo@linaro.org>, Russell King <rmk+kernel@arm.linux.org.uk>, spear-devel <spear-devel@list.st.com>

On Wed, May 23, 2012 at 8:18 PM, Linus Walleij
<linus.walleij@stericsson.com> wrote:
> From: Linus Walleij <linus.walleij@linaro.org>
>
> We had a boot regression in Ux500 in the merge window because
> two orthogonal pin control schemes for the PL011 were merged
> at the same time:
>
> - One using the .init() and .exit() hooks into the platform
> =A0for Ux500 putting the pins into default vs sleep state
> =A0respectively as the port was started/stopped.
> =A0commit a09806607fd20bed2f8c41fe22793386790a14aa
> =A0"ARM: ux500: switch to using pinctrl for uart0"
>
> - One hogging the default setting at PL011 probe()
> =A0commit 258e055111d3cde2607e0d04eb91da2f7a59b591
> =A0"serial: amba-pl011: adopt pinctrl support"
>
> To get a solution that works for both let's scrap the stuff
> in the platform callbacks, instead have the driver itself
> select default and sleep states when the port is
> started/stopped. Hopefully this works for all clients.
> Platform callbacks are bad for device tree migration anyway,
> so this rids us of another problem in Ux500.
>
> Cc: linux-serial@vger.kernel.org
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Shawn Guo <shawn.guo@linaro.org>
> Cc: Russell King <rmk+kernel@arm.linux.org.uk>
> Reported-by: Lee Jones <lee.jones@linaro.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> =A0arch/arm/mach-ux500/board-mop500.c | =A0 54 +---------------------=
--------------
> =A0drivers/tty/serial/amba-pl011.c =A0 =A0| =A0 45 ++++++++++++++++++=
+++++++++---
> =A02 files changed, 42 insertions(+), 57 deletions(-)

> diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amb=
a-pl011.c
> @@ -1869,11 +1897,20 @@ static int pl011_probe(struct amba_device *de=
v, const struct amba_id *id)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto free;
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 pinctrl =3D devm_pinctrl_get_select_default(&dev->dev);
> - =A0 =A0 =A0 if (IS_ERR(pinctrl)) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D PTR_ERR(pinctrl);
> + =A0 =A0 =A0 uap->pinctrl =3D devm_pinctrl_get(&dev->dev);
> + =A0 =A0 =A0 if (IS_ERR(uap->pinctrl)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D PTR_ERR(uap->pinctrl);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto unmap;
> =A0 =A0 =A0 =A0}

Hi Linus,

People testing SPEAr with v3.5-rc1 saw that serial devices don't show
up during boot and they
actually return with error from this point, after Shawn's last patch.
That will still happen with
this patch i believe.

What is expected from Platforms to handle this? AFAICR, we haven't
done anything special
to bind a pinctrl node to a struct dev for uart.

--
Viresh
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
