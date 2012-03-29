From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] serial: PL011: move interrupt clearing
Date: Thu, 29 Mar 2012 14:49:37 -0600
Message-ID: <CACxGe6u+KeYzWwiJ7MK7pWG444Y99CQ1LLCZP4m3R=zdYFR_pg@mail.gmail.com>
References: <1332357318-8017-1-git-send-email-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:41067 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759862Ab2C2Ut6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 29 Mar 2012 16:49:58 -0400
Received: by yenl12 with SMTP id l12so1837556yen.19
        for <linux-serial@vger.kernel.org>; Thu, 29 Mar 2012 13:49:58 -0700 (PDT)
In-Reply-To: <1332357318-8017-1-git-send-email-linus.walleij@linaro.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Russell King <linux@arm.linux.org.uk>, Jong-Sung Kim <neidhard.kim@lge.com>, stable <stable@vger.kernel.org>, Chanho Min <chanho0207@gmail.com>, linux-arm-kernel@lists.infradead.org, Shreshtha Kumar Sahu <shreshthakumar.sahu@stericsson.com>

On Wed, Mar 21, 2012 at 1:15 PM, Linus Walleij <linus.walleij@linaro.or=
g> wrote:
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

Ugh; the original patch is obviously broken.  How did it get applied
without testing?

Greg, can you get this out to Linus ASAP please?  I have one comment
below, but I don't think it should block merging this patch.

Tested-by: Grant Likely <grant.likely@secretlab.ca>

> ---
> =A0drivers/tty/serial/amba-pl011.c | =A0 =A08 ++++----
> =A01 files changed, 4 insertions(+), 4 deletions(-)
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

Is it correct to move the interrupt clearing below the
pl011_dma_probe() call?  I've tested the fix with the interrupt
clearing both above and below the pl011_dma_probe() call and versatile
qemu boots in both cases.

g.
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
