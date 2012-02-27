From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] Clear previous interrupts after fifo is disabled
Date: Mon, 27 Feb 2012 11:45:12 +0100
Message-ID: <CACRpkdZe5caTr5LLWm7J5NfsWegoih4yQx+GV=H5brdPSUvEsQ@mail.gmail.com>
References: <CAOAMb1ASB0zznSSOAU9HgPNW2e=Do+8hSJ6JZ00DxtAxqsXyXQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:44337 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753089Ab2B0KpN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 27 Feb 2012 05:45:13 -0500
Received: by mail-iy0-f174.google.com with SMTP id z13so3084001iaz.19
        for <linux-serial@vger.kernel.org>; Mon, 27 Feb 2012 02:45:13 -0800 (PST)
In-Reply-To: <CAOAMb1ASB0zznSSOAU9HgPNW2e=Do+8hSJ6JZ00DxtAxqsXyXQ@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Chanho Min <chanho0207@gmail.com>
Cc: Russell King <linux@arm.linux.org.uk>, Alan Cox <alan@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Shreshtha Kumar Sahu <shreshthakumar.sahu@stericsson.com>, "Kim, Jong-Sung" <neidhard.kim@lge.com>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org

On Mon, Feb 27, 2012 at 10:30 AM, Chanho Min <chanho0207@gmail.com> wro=
te:

> This is another workaroud of =A0'https://lkml.org/lkml/2012/1/17/104'
> with additional analysis.Bootloader can transfer control to kernel an=
d
> there are some pending interrupts. In this case, RXFE of the flag
> register is set by clearing FEN(LCRH) even if rx data remains in the
> fifo. It seems that the fifo's status is initiailized. Interrupt
> handler can not get any data from data register because of the below
> break condtion.
>
> pl011_fifo_to_tty
> =A0while (max_count--) {
> =A0 if (status & UART01x_FR_RXFE)
> =A0 =A0 =A0 =A0break;
>
> Then, Rx interrupt is never cleared. cpu is looping in ISR. System is
> hang. If we don't guarantee that no interrupt is pended until fifo is
> disabled by calling 'writew(0, uap->port.membase + uap->lcrh_rx)',
> this misbehave of the interrupt handelr can be occurred. So, All
> pending interrupts should be cleared just after fifo is disabled unde=
r
> the protection from interrupt. Also,'clear error interrupts' routine
> can be removed becuase all interrupts are cleared before.
>
> Signed-off-by: Chanho Min <chanho.min@lge.com>

Looks correct to me.
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Thanks,
Linus Walleij
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
