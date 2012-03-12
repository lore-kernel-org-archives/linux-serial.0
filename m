From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] serial: PL011: clear pending interrupts
Date: Mon, 12 Mar 2012 11:48:36 +0100
Message-ID: <CACRpkdbsa6HW63vN7CeKNpgLZokB+S6GEaU27CiaVsbvo5qA-g@mail.gmail.com>
References: <1331540750-25697-1-git-send-email-linus.walleij@stericsson.com>
	<20120312083221.GW17370@n2100.arm.linux.org.uk>
	<20120312101100.GA8649@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:49112 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751749Ab2CLKsh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 12 Mar 2012 06:48:37 -0400
Received: by gghe5 with SMTP id e5so2376489ggh.19
        for <linux-serial@vger.kernel.org>; Mon, 12 Mar 2012 03:48:36 -0700 (PDT)
In-Reply-To: <20120312101100.GA8649@n2100.arm.linux.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Linus Walleij <linus.walleij@stericsson.com>, linux-serial@vger.kernel.org, Chanho Min <chanho0207@gmail.com>, linux-arm-kernel@lists.infradead.org, Jong-Sung Kim <neidhard.kim@lge.com>, stable@kernel.org, Shreshtha Kumar Sahu <shreshthakumar.sahu@stericsson.com>

On Mon, Mar 12, 2012 at 11:11 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:

>> > + =A0 /* RXIS but RXFE? Just clear the interrupt */
>> > + =A0 if(unlikely(fifotaken =3D=3D 0))
>> > + =A0 =A0 =A0 =A0 =A0 writew(UART011_RTIS | UART011_RXIS,
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0uap->port.membase + UART011_I=
CR);
>
> BTW, I don't see why we need any of this stuff.
>
> The problem as described is that the interrupt handler is called with=
 one
> of the receive flags set (UART011_RTIS or UART011_RXIS) but with
> UART01x_FR_RXFE clear.
>
> The problem report indicates that this is caused when we switch from =
=46IFO
> mode to non-FIFO mode, and the FIFO contained some unread characters.
>
> That can only happen once we've enabled interrupts in the IMSC regist=
er,
> which doesn't happen until later in the startup function.
>
> So:
>
> =A0 =A0 =A0 =A0spin_lock_irq(&uap->port.lock);
> =A0 =A0 =A0 =A0uap->im =3D UART011_RTIM;
> =A0 =A0 =A0 =A0if (!pl011_dma_rx_running(uap))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0uap->im |=3D UART011_RXIM;
> =A0 =A0 =A0 =A0writew(uap->im, uap->port.membase + UART011_IMSC);
> =A0 =A0 =A0 =A0spin_unlock_irq(&uap->port.lock);
>
> clearing the transmit/receive interrupts here _before_ we unmask them
> should be sufficient.

Right! OK I'll cook a v2 patch according to this suggestion and
request Chanho to test it.

Yours,
Linus Walleij
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
