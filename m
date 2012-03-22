From: viresh kumar <viresh.linux@gmail.com>
Subject: Re: [PATCH] serial: PL011: move interrupt clearing
Date: Thu, 22 Mar 2012 06:34:37 +0530
Message-ID: <CAOh2x==5QHEcA3h216p8rJukx0LR=cVcGYN84aqzw=fnhu8Y-g@mail.gmail.com>
References: <1332357318-8017-1-git-send-email-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:41277 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755211Ab2CVBEi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 21 Mar 2012 21:04:38 -0400
In-Reply-To: <1332357318-8017-1-git-send-email-linus.walleij@linaro.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Russell King <linux@arm.linux.org.uk>, Jong-Sung Kim <neidhard.kim@lge.com>, stable <stable@vger.kernel.org>, Chanho Min <chanho0207@gmail.com>, linux-arm-kernel@lists.infradead.org, Shreshtha Kumar Sahu <shreshthakumar.sahu@stericsson.com>, spear-devel <spear-devel@list.st.com>

On Thu, Mar 22, 2012 at 12:45 AM, Linus Walleij
<linus.walleij@linaro.org> wrote:
> Commit 360f748b204275229f8398cb2f9f53955db1503b
> "serial: PL011: clear pending interrupts"
> attempts to clear interrupts by writing to a
> yet-unassigned memory address. This fixes the issue.
>
> The breaking patch is marked for stable so should be
> carried along with the other patch.
>
> Cc: Shreshtha Kumar Sahu <shreshthakumar.sahu@stericsson.com>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: stable <stable@vger.kernel.org>
> Reported-by: Viresh Kumar <viresh.kumar@st.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> =A0drivers/tty/serial/amba-pl011.c | =A0 =A08 ++++----
> =A01 files changed, 4 insertions(+), 4 deletions(-)

You missed me in CC??

>
> diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amb=
a-pl011.c
> index 7e01399..4ed35c5 100644
> --- a/drivers/tty/serial/amba-pl011.c
> +++ b/drivers/tty/serial/amba-pl011.c
> @@ -1930,10 +1930,6 @@ static int pl011_probe(struct amba_device *dev=
, const struct amba_id *id)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto unmap;
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 /* Ensure interrupts from this UART are masked and clea=
red */
> - =A0 =A0 =A0 writew(0, uap->port.membase + UART011_IMSC);
> - =A0 =A0 =A0 writew(0xffff, uap->port.membase + UART011_ICR);
> -
> =A0 =A0 =A0 =A0uap->vendor =3D vendor;
> =A0 =A0 =A0 =A0uap->lcrh_rx =3D vendor->lcrh_rx;
> =A0 =A0 =A0 =A0uap->lcrh_tx =3D vendor->lcrh_tx;
> @@ -1951,6 +1947,10 @@ static int pl011_probe(struct amba_device *dev=
, const struct amba_id *id)
> =A0 =A0 =A0 =A0uap->port.line =3D i;
> =A0 =A0 =A0 =A0pl011_dma_probe(uap);
>
> + =A0 =A0 =A0 /* Ensure interrupts from this UART are masked and clea=
red */
> + =A0 =A0 =A0 writew(0, uap->port.membase + UART011_IMSC);
> + =A0 =A0 =A0 writew(0xffff, uap->port.membase + UART011_ICR);
> +
> =A0 =A0 =A0 =A0snprintf(uap->type, sizeof(uap->type), "PL011 rev%u", =
amba_rev(dev));
>
> =A0 =A0 =A0 =A0amba_ports[i] =3D uap;

Reviewed-by: Viresh Kumar <viresh.kumar@st.com>

--
viresh
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
