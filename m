Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EE131A08C8
	for <linux-serial@vger.kernel.org>; Mon, 24 Jun 2024 21:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719264253; cv=none; b=OV9ED9OJPjQ17fLp5Xk5hn4n7Q8nBPGx4zX+1gu030ETR09XjF7tmaQIQbCzBebkKpT+lj78P88H3wrsQLvyP5q83dGbX3Lh/9RE0RV5pmBs0A/kkWf7VBfohU/ptstQwmYzuNaEhl53XQJNW9chZDHdU6HWxIN6cVhbpGM6qFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719264253; c=relaxed/simple;
	bh=IFZr6MV4AR6r14kqmLG6qUlrfX6va9/24Y1lP+Gq/00=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hsRIbSeq6ZN8OZHYMoeZAik+Shd2u8J+E0kYgdPmkc3tG2AQnYV8by6kYgxOe51ihJpZ4ca3Nr2cZiPwXywRNum8rYVByd3fPiu3YrvdTIXxsZYsvGaD6nsmxxr0dsEExhsrtkrrVYGsrdE+JTjbvPkB9aUED3xKeRQcmuu2szo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=kDNZt61U; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kDNZt61U"
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3c9d70d93dbso3241441b6e.3
        for <linux-serial@vger.kernel.org>; Mon, 24 Jun 2024 14:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1719264248; x=1719869048; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1JOTUT9twe9eD9jXfuDuG0OciOCniJECQvgGWn276Tc=;
        b=kDNZt61UVaPfgB+JV8yoAvwIn6c1tSD91QszRvvzy8GzFti2r9PfhumRND6D7SsDnP
         gnZecWiDFXsNbMikWj2S2WQY2eIhzNRRIHOEnBz7sHtaXJyDNAfFxivDticcmn4CzpG0
         IXYO8c0UqW6upmhfaxGkP04x1vyN9fZPeQIFw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719264248; x=1719869048;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1JOTUT9twe9eD9jXfuDuG0OciOCniJECQvgGWn276Tc=;
        b=ZR9PLWgm4+Uv0RJxeHn3pOp0HF5x0Q9x5gozm0dmYOCvfdNenxajTPq1SatgMzR8vH
         I5LcX5FO1oHQLChblj3Q566xoVMMfRiLO7f0Hmg8l5Cyd3qe16wA55l4w03rP3QuCrIO
         ExowLbY27qZhJ4bHJle675mI+QZcU1wbzIwAPnZYvF1QXLYeLUJ8wv8DKY7dKDZxXp9q
         mu1w9rxVJnWD8WDvjIFjRij9NQBLI9Cw10VoLXSykGpAMi/SE27caQK1+SihOfF9t2HE
         +0pPlQY2G2jlQ7koDcOSfphfrHaUdlP0dAFmNvdY7lW5/PwsUZ7CUamSSmFuNSECUdTH
         dhoQ==
X-Forwarded-Encrypted: i=1; AJvYcCVOVqcXGFy1eFVknLtt/4idIbkV+1XVXT7M6yCkV3SCvYLFTcRXHIO/RNNqoGnSNSccyri/gXem3YYB/Nj0xkqHwXGTNEKBDpGJcAKm
X-Gm-Message-State: AOJu0Yzz5tltW2nU3AQvFr0NEupDhhqth8bUrAm6T+mikfNgs8TOW2yW
	T9SO6w/93b63gvIIcWh7fQZa1DzKiMsNLoxc6ndl3aYRD7dYgwhaj1vOn5mzT/xVlgDvxKB+mO8
	=
X-Google-Smtp-Source: AGHT+IHId43YoKLQmdwdm8AFxZnLf/eFFGHghgSAjaHvEhgl/IA/jnDplRXTk1XHS51WN3RXUrd32A==
X-Received: by 2002:a05:6808:d4b:b0:3d2:2721:8a85 with SMTP id 5614622812f47-3d545960772mr5841682b6e.12.1719264247860;
        Mon, 24 Jun 2024 14:24:07 -0700 (PDT)
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com. [209.85.160.180])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-444c2bb083csm46880811cf.57.2024.06.24.14.24.04
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jun 2024 14:24:07 -0700 (PDT)
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-44056f72257so35961cf.0
        for <linux-serial@vger.kernel.org>; Mon, 24 Jun 2024 14:24:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVCc9idXaF06ZkGbM7H5fOmmMbhVszMJg49feRgZ7lMQwWznyCMorhT+AiIN1oPImDjrE/wdi5qvkcvq36knoPiagv7IBh40mAXmx49
X-Received: by 2002:ac8:7fc6:0:b0:444:b755:2aa1 with SMTP id
 d75a77b69052e-444f368e55amr295621cf.17.1719264244099; Mon, 24 Jun 2024
 14:24:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240624133135.7445-1-johan+linaro@kernel.org> <20240624133135.7445-3-johan+linaro@kernel.org>
In-Reply-To: <20240624133135.7445-3-johan+linaro@kernel.org>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 24 Jun 2024 14:23:52 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UauWffRM45FsU2SHoKtkVaOEf=Adno+jV+Ashf7NFHuA@mail.gmail.com>
Message-ID: <CAD=FV=UauWffRM45FsU2SHoKtkVaOEf=Adno+jV+Ashf7NFHuA@mail.gmail.com>
Subject: Re: [PATCH 2/3] serial: qcom-geni: fix soft lockup on sw flow control
 and suspend
To: Johan Hovold <johan+linaro@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Bjorn Andersson <andersson@kernel.org>, 
	linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jun 24, 2024 at 6:31=E2=80=AFAM Johan Hovold <johan+linaro@kernel.o=
rg> wrote:
>
> The stop_tx() callback is used to implement software flow control and
> must not discard data as the Qualcomm GENI driver is currently doing
> when there is an active TX command.
>
> Cancelling an active command can also leave data in the hardware FIFO,
> which prevents the watermark interrupt from being enabled when TX is
> later restarted. This results in a soft lockup and is easily triggered
> by stopping TX using software flow control in a serial console but this
> can also happen after suspend.
>
> Fix this by only stopping any active command, and effectively clearing
> the hardware fifo, when shutting down the port. Make sure to temporarily
> raise the watermark level so that the interrupt fires when TX is
> restarted.

Nice! I did quite a few experiments, but it sounds like you found
something that I wasn't able to find. Specifically once I cancelled an
ongoing command I could never manage to get it started back up, but it
must have just been that data was still in the FIFO and thus the
watermark never fired again.

When I was experimenting, I also swore that there were cases where
geni would sometimes fully drop bytes when I tried to "cancel" a
command, but maybe I was mistaken. Everything I figured out was
essentially by running experiments and I could easily have had a bug
in my experiment.


> Fixes: c4f528795d1a ("tty: serial: msm_geni_serial: Add serial driver sup=
port for GENI based QUP")
> Cc: stable@vger.kernel.org      # 4.17
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>  drivers/tty/serial/qcom_geni_serial.c | 28 +++++++++++++++++----------
>  1 file changed, 18 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/q=
com_geni_serial.c
> index 1d5d6045879a..72addeb9f461 100644
> --- a/drivers/tty/serial/qcom_geni_serial.c
> +++ b/drivers/tty/serial/qcom_geni_serial.c
> @@ -651,13 +651,8 @@ static void qcom_geni_serial_start_tx_fifo(struct ua=
rt_port *uport)
>  {
>         u32 irq_en;
>
> -       if (qcom_geni_serial_main_active(uport) ||
> -           !qcom_geni_serial_tx_empty(uport))
> -               return;
> -
>         irq_en =3D readl(uport->membase + SE_GENI_M_IRQ_EN);
>         irq_en |=3D M_TX_FIFO_WATERMARK_EN | M_CMD_DONE_EN;
> -
>         writel(DEF_TX_WM, uport->membase + SE_GENI_TX_WATERMARK_REG);
>         writel(irq_en, uport->membase + SE_GENI_M_IRQ_EN);
>  }
> @@ -665,16 +660,28 @@ static void qcom_geni_serial_start_tx_fifo(struct u=
art_port *uport)
>  static void qcom_geni_serial_stop_tx_fifo(struct uart_port *uport)
>  {
>         u32 irq_en;
> -       struct qcom_geni_serial_port *port =3D to_dev_port(uport);
>
>         irq_en =3D readl(uport->membase + SE_GENI_M_IRQ_EN);
>         irq_en &=3D ~(M_CMD_DONE_EN | M_TX_FIFO_WATERMARK_EN);
>         writel(0, uport->membase + SE_GENI_TX_WATERMARK_REG);
>         writel(irq_en, uport->membase + SE_GENI_M_IRQ_EN);
> -       /* Possible stop tx is called multiple times. */

If qcom_geni_serial_stop_tx_fifo() is supposed to be used for UART
flow control and you have a way to stop the transfer immediately
without losing data (by using geni_se_cancel_m_cmd), maybe we should
do that? If the other side wants us to stop transferring data and we
can stop it right away that would be ideal...


> +}
> +
> +static void qcom_geni_serial_clear_tx_fifo(struct uart_port *uport)
> +{
> +       struct qcom_geni_serial_port *port =3D to_dev_port(uport);
> +
>         if (!qcom_geni_serial_main_active(uport))
>                 return;
>
> +       /*
> +        * Increase watermark level so that TX can be restarted and wait =
for
> +        * sequencer to start to prevent lockups.
> +        */
> +       writel(port->tx_fifo_depth, uport->membase + SE_GENI_TX_WATERMARK=
_REG);
> +       qcom_geni_serial_poll_bit(uport, SE_GENI_M_IRQ_STATUS,
> +                                       M_TX_FIFO_WATERMARK_EN, true);

Oh, maybe this "wait for sequencer to start to prevent lockups." is
the part that I was missing? Can you explain more about what's going
on here? Why does waiting for the watermark interrupt to fire prevent
lockups? I would have imagined that the watermark interrupt would be
part of the geni hardware and have nothing to do with the firmware
running on the other end, so I'm not sure why it firing somehow would
prevent a lockup. Was this just by trial and error?


> @@ -684,6 +691,8 @@ static void qcom_geni_serial_stop_tx_fifo(struct uart=
_port *uport)
>                 writel(M_CMD_ABORT_EN, uport->membase + SE_GENI_M_IRQ_CLE=
AR);
>         }
>         writel(M_CMD_CANCEL_EN, uport->membase + SE_GENI_M_IRQ_CLEAR);
> +
> +       port->tx_remaining =3D 0;
>  }
>
>  static void qcom_geni_serial_handle_rx_fifo(struct uart_port *uport, boo=
l drop)
> @@ -1069,11 +1078,10 @@ static void qcom_geni_serial_shutdown(struct uart=
_port *uport)
>  {
>         disable_irq(uport->irq);
>
> -       if (uart_console(uport))
> -               return;

Can you explain this part of the patch? I'm not saying it's wrong to
remove this special case since this driver seems to have lots of
needless special cases that are already handled by the core or by
other parts of the driver, but this change seems unrelated to the rest
of the patch. Could it be a separate patch?
