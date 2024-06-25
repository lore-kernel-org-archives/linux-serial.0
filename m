Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3605B176254;
	Tue, 25 Jun 2024 20:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719348007; cv=none; b=Lq9dU9cOWIrsrtsbOdXzc9+4h8s84EcBxrperGZjboSMHndmFC2mHXiMOp2zpgPhRfIzP/PKP001ajBzf447HmbBn3k35Vaz99uf2L5zhmEopLlNRczcCvrcCr27LYgoan+W+Y9kwhhtFEdlWiC2Np9CuDfRRBoEw1WZDe8OXvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719348007; c=relaxed/simple;
	bh=tBsPqz9KdloQlOQClLnwN02KtLwV6EXgBuETXlrvzCE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UrnTWYXA/3GpIYRgNSecT6HS8AmyI2NnNuzx/Eeit4+I9jwoqCBjm9XiaQF2X4nH/m6eXhHVtqfYNbgiglO9dNjL52Lkaf+KUT/xi9K8HlBQvFJARpVwhKJFREKKJdQ1dobXpjzTG2jdSsq3aqrZyJsBwfzvn5W0T7KyRyVsfh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GgGDq6qc; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GgGDq6qc"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2c7cfba36f8so1082797a91.3;
        Tue, 25 Jun 2024 13:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719348005; x=1719952805; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vTAUN47IqqElZXeBcrK8yXzS1ClqmFbCRPEYR3+9RTs=;
        b=GgGDq6qc4QNZp6nbLBFRsc9MKkNosdvUHONyhO5TdpsqNc1RGRVFJ1Z1Y17teEZigN
         8cz3jC3addXSHL6vf0ZY4m//cp/JGAbc0THWMH4FayKkDR0V0qeRm6otOkWwbKO98pBa
         N+X5s+KE0thGyk9r1vyP2E/nw2nB82GOpf2isIqH7pXNjy5hSxccfzsYUESTszALP907
         3FW2JrKm2jSXDWt3iZNZLXHtlMatJdYsHii4FTv7s8rYGSHlc1qoizVBSQArZBug2oaR
         MBZfz0JikQvf+dlJ/pcR2FpPKFiiSHTnVHvzMFCQY0hPtvoMk1UNYcfVwYdeefkWPfs0
         93NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719348005; x=1719952805;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vTAUN47IqqElZXeBcrK8yXzS1ClqmFbCRPEYR3+9RTs=;
        b=bMCco3Xm9vSQeEI2N4Sc7YX1UezYMa8XNPaX3rLO6ribv4NNrZrH3ByH4NdFkg7HRQ
         XheOjfYCwrxFSstdTyEeJIlDk/ij37L3or5FoIysPZRiWglVl5A7EXGccYMqlnJcCJTB
         gS0UOOVt6YbpMPzv7Wr0gu9xr70g8I0RbK6mPTX56YmGAYI8gLZOuKurdPOrndiJ6B23
         7ReziHn6nUyoblQ6o+8Djppz6Wg79PEg+Fvzehb4tMCEgggYhKfb58pFd3DBwCNLwwj7
         TcXnlBFs23L01o97gNVxlRTRNc7jsVLVOe7JnK1BHPunLYQZcEkXr/x+Z/SO3SkR7D2V
         vP1Q==
X-Forwarded-Encrypted: i=1; AJvYcCVeeevOnkTPbm786sLn7dh5TgnvfjjXGIv4ydy0AEyGRjJmFxPRpGrJa6QFYzdWMKXBgwVO8dPfoG2+zwlNZT05l7eXXMjokiSZK6Fr/hrsvwQM6t+ZS4WYirW0xEyKfmmEdwuo0kW0SWAS
X-Gm-Message-State: AOJu0Yymx0sN8XNBe5nxitL/lSY4aYaeoAT4FaQMEFjEGqpUQ7O9mRoj
	hUg2Nf4yyQWwPVPRAruFPHmevjHzRrGFYIey+unwbiGE3Oujtc7jFiH09Ob/pDLrx+704FM/1VS
	itE0RAOi8pkupHiCTQ0dbYgl9zL8=
X-Google-Smtp-Source: AGHT+IGgfquiJAzbCXphhDVUAqYNiuHQa5FzJ49MHmgKnDF871dkMxNZHt7A4agfHaQChwXdhlYV+okvZoeC+0Zt+io=
X-Received: by 2002:a17:90a:fe0a:b0:2c7:ad55:85d8 with SMTP id
 98e67ed59e1d1-2c84291894bmr9452658a91.2.1719348005481; Tue, 25 Jun 2024
 13:40:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240625184206.508837-1-linux@rasmusvillemoes.dk>
In-Reply-To: <20240625184206.508837-1-linux@rasmusvillemoes.dk>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 25 Jun 2024 17:39:54 -0300
Message-ID: <CAOMZO5AejtxU4hTMWa8PK9duXYAKUGzGm_mmeLuEW=tRk7GSCQ@mail.gmail.com>
Subject: Re: [PATCH v2] serial: imx: ensure RTS signal is not left active
 after shutdown
To: Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Christoph Niedermaier <cniedermaier@dh-electronics.com>, Marek Vasut <marex@denx.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

[Adding Christoph and Marek]

On Tue, Jun 25, 2024 at 3:42=E2=80=AFPM Rasmus Villemoes
<linux@rasmusvillemoes.dk> wrote:
>
> If a process is killed while writing to a /dev/ttymxc* device in RS485
> mode, we observe that the RTS signal is left high, thus making it
> impossible for other devices to transmit anything.
>
> Moreover, the ->tx_state variable is left in state SEND, which means
> that when one next opens the device and configures baud rate etc., the
> initialization code in imx_uart_set_termios dutifully ensures the RTS
> pin is pulled down, but since ->tx_state is already SEND, the logic in
> imx_uart_start_tx() does not in fact pull the pin high before
> transmitting, so nothing actually gets on the wire on the other side
> of the transceiver. Only when that transmission is allowed to complete
> is the state machine then back in a consistent state.
>
> This is completely reproducible by doing something as simple as
>
>   seq 10000 > /dev/ttymxc0
>
> and hitting ctrl-C, and watching with a logic analyzer.
>
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> ---
> v2: Use dev_warn() instead of dev_WARN_ONCE().
>
> v1: https://lore.kernel.org/lkml/20240524121246.1896651-1-linux@rasmusvil=
lemoes.dk/
>
> A screen dump from a logic analyzer can be seen at:
>
>   https://ibb.co/xCcP7Jy
>
> This is on an imx8mp board, with /dev/ttymxc0 and /dev/ttymxc2 both
> configured for rs485 and connected to each other. I'm writing to
> /dev/ttymxc2. This demonstrates both bugs; that RTS is left high when
> a write is interrupted, and that a subsequent write actually fails to
> have RTS high while TX'ing.
>
> I'm not sure what commit to name as a Fixes:. This certainly happens
> on 6.6 and onwards, but I assume the problem exists since the tx_state
> machine was introduced in cb1a60923609 (serial: imx: implement rts
> delaying for rs485), and possibly even before that.
>
>
>  drivers/tty/serial/imx.c | 51 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 51 insertions(+)
>
> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> index 2eb22594960f..85c240e8c24e 100644
> --- a/drivers/tty/serial/imx.c
> +++ b/drivers/tty/serial/imx.c
> @@ -1551,6 +1551,7 @@ static void imx_uart_shutdown(struct uart_port *por=
t)
>         struct imx_port *sport =3D (struct imx_port *)port;
>         unsigned long flags;
>         u32 ucr1, ucr2, ucr4, uts;
> +       int loops;
>
>         if (sport->dma_is_enabled) {
>                 dmaengine_terminate_sync(sport->dma_chan_tx);
> @@ -1613,6 +1614,56 @@ static void imx_uart_shutdown(struct uart_port *po=
rt)
>         ucr4 &=3D ~UCR4_TCEN;
>         imx_uart_writel(sport, ucr4, UCR4);
>
> +       /*
> +        * We have to ensure the tx state machine ends up in OFF. This
> +        * is especially important for rs485 where we must not leave
> +        * the RTS signal high, blocking the bus indefinitely.
> +        *
> +        * All interrupts are now disabled, so imx_uart_stop_tx() will
> +        * no longer be called from imx_uart_transmit_buffer(). It may
> +        * still be called via the hrtimers, and if those are in play,
> +        * we have to honour the delays.
> +        */
> +       if (sport->tx_state =3D=3D WAIT_AFTER_RTS || sport->tx_state =3D=
=3D SEND)
> +               imx_uart_stop_tx(port);
> +
> +       /*
> +        * In many cases (rs232 mode, or if tx_state was
> +        * WAIT_AFTER_RTS, or if tx_state was SEND and there is no
> +        * delay_rts_after_send), this will have moved directly to
> +        * OFF. In rs485 mode, tx_state might already have been
> +        * WAIT_AFTER_SEND and the hrtimer thus already started, or
> +        * the above imx_uart_stop_tx() call could have started it. In
> +        * those cases, we have to wait for the hrtimer to fire and
> +        * complete the transition to OFF.
> +        */
> +       loops =3D port->rs485.flags & SER_RS485_ENABLED ?
> +               port->rs485.delay_rts_after_send : 0;
> +       while (sport->tx_state !=3D OFF && loops--) {
> +               uart_port_unlock_irqrestore(&sport->port, flags);
> +               msleep(1);
> +               uart_port_lock_irqsave(&sport->port, &flags);
> +       }
> +
> +       if (sport->tx_state !=3D OFF) {
> +               dev_warn(sport->port.dev, "unexpected tx_state %d\n",
> +                        sport->tx_state);
> +               /*
> +                * This machine may be busted, but ensure the RTS
> +                * signal is inactive in order not to block other
> +                * devices.
> +                */
> +               if (port->rs485.flags & SER_RS485_ENABLED) {
> +                       ucr2 =3D imx_uart_readl(sport, UCR2);
> +                       if (port->rs485.flags & SER_RS485_RTS_AFTER_SEND)
> +                               imx_uart_rts_active(sport, &ucr2);
> +                       else
> +                               imx_uart_rts_inactive(sport, &ucr2);
> +                       imx_uart_writel(sport, ucr2, UCR2);
> +               }
> +               sport->tx_state =3D OFF;
> +       }
> +
>         uart_port_unlock_irqrestore(&sport->port, flags);
>
>         clk_disable_unprepare(sport->clk_per);
> --
> 2.45.2
>
