From: viresh kumar <viresh.linux@gmail.com>
Subject: Re: [PATCH v3] serial: PL011: clear pending interrupts
Date: Wed, 21 Mar 2012 17:28:27 +0530
Message-ID: <CAOh2x=nh-aiJ1FQecm=5WsNw=Fph5osNh5C2YU6x9TGrKBoMmA@mail.gmail.com>
References: <1331641643-25929-1-git-send-email-linus.walleij@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:64062 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751321Ab2CUL62 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 21 Mar 2012 07:58:28 -0400
Received: by wgbdr13 with SMTP id dr13so608049wgb.1
        for <linux-serial@vger.kernel.org>; Wed, 21 Mar 2012 04:58:27 -0700 (PDT)
In-Reply-To: <1331641643-25929-1-git-send-email-linus.walleij@stericsson.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Linus Walleij <linus.walleij@stericsson.com>
Cc: Greg Kroah-Hartman <gregkh@suse.de>, linux-serial@vger.kernel.org, Chanho Min <chanho0207@gmail.com>, linux-arm-kernel@lists.infradead.org, Russell King <linux@arm.linux.org.uk>, Jong-Sung Kim <neidhard.kim@lge.com>, Linus Walleij <linus.walleij@linaro.org>, stable@kernel.org, Shreshtha Kumar Sahu <shreshthakumar.sahu@stericsson.com>, spear-devel <spear-devel@list.st.com>

On Tue, Mar 13, 2012 at 5:57 PM, Linus Walleij
<linus.walleij@stericsson.com> wrote:
> diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amb=
a-pl011.c
> @@ -1927,6 +1930,10 @@ static int pl011_probe(struct amba_device *dev=
, const struct amba_id *id)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto unmap;
> =A0 =A0 =A0 =A0}
>
> + =A0 =A0 =A0 /* Ensure interrupts from this UART are masked and clea=
red */
> + =A0 =A0 =A0 writew(0, uap->port.membase + UART011_IMSC);
> + =A0 =A0 =A0 writew(0xffff, uap->port.membase + UART011_ICR);
> +


Hey Linus,

I was working on v3.3 and found a crash for my SoC. When i checked i go=
t a crash
due to above changes.

There are two issues here
 - uap->port is uninitialized
 - clk is not enabled.

How is this working for you?

--
viresh
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
