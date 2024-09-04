Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6664816F287
	for <linux-serial@vger.kernel.org>; Wed,  4 Sep 2024 21:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725486677; cv=none; b=LhFBlYt6pq3JTf6oW92eTqSoaVHwCDUKWZ/yIwaHu7JS/OYrU15+BmbOEjsY/9mdA3RqU/ZRSZ11cLShqq1C343aCcjSbEC3KCDTAnea/w8p8lMQZVWTed7h3vdvNAWGSSNNm+lTIqsEXi2H/TDW8lDic+S10+B42v3jYpMTA+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725486677; c=relaxed/simple;
	bh=HVv+636NymRBVBT+daSXGh0y1/tqpXcJ5SYAnkYRAJw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RIlSM/LV5GZNcgMWVYC6qYcyeqBed8+fNp/z5G+7VraKx0fN4/GtZ5dIz33Vunbda8EYt31vWNKLLmUKc/Y1kUfCQmXWfwHe4F+LgriXQhZGmNDlubMD0k16jtm8IUZsvqyBI4OUrQ6hBArcDh27sb+aIcd+BlT3ZKxY2suU2SI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=n1FCiBZ5; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="n1FCiBZ5"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-6d44b6e1aebso161307b3.2
        for <linux-serial@vger.kernel.org>; Wed, 04 Sep 2024 14:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1725486673; x=1726091473; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fgfZmpFq3mNdiXjiUQCUbunCBLyKZQQZN/adM34E+5k=;
        b=n1FCiBZ52ADUpg+d98w7M3iQScF8ImMw/OrcoHCu7s52ZWPSEt4KI8zfoOtkREMCKk
         8FXxrBo+ZL7ts8qaC3kiQ1o/GV7ehZGxnqJ8LsxGNowS++1ROJIrfxb+0CfsubeCLUUh
         +87a1sXHzk9mjjqkCmwIYEvUOLy3quJREn3UY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725486673; x=1726091473;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fgfZmpFq3mNdiXjiUQCUbunCBLyKZQQZN/adM34E+5k=;
        b=aZldXVXsBIQW5qfc1OkUpMxSiZ5g4HRdLyBu0gyAQntiOsf2C9YKavziCZE2vPKKN2
         DkoKqyoUxFnjP4+Y2wGq/aunUWlXRr/A6enbG+0mcArOEIuOAwgebD4O07fDWgJYnbbW
         mTCaDI4BzGmLZYz6o4PliRJnd6N2A/tciWmVqeJn5QrscZmqAEtG3+WFHCXIkLJeVJjp
         BYi8Fg29pE9CcCatbtnqMARouJY+3og1UkjpPAZRjv7972I+QriiPEp3tz8hbPw/yvuW
         0mGY87nVRMdxLI9PmmOx9RxJiwDgp70ojRrGFisJSM875a7Yvhf7XTT46QMdocoZjgWU
         /h6g==
X-Forwarded-Encrypted: i=1; AJvYcCXl+7swaSaYTTt6O8aW4xzT39wML36BSEzg4/cgNiNbciH3B54OOHSiUb7hEkqJChM+lNBtILF/nS17zuE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyws3+pEJ/u3d+GDgz0TcG7Nu7spTuM+JozXJnGjWWKiDddaAcY
	93X5ORflwZ42NfNt86HuVipwgEDpmeDjiV7z8/B7MjIOEBuda3+cYPd1Kf/T91avvgb61jV8eY0
	=
X-Google-Smtp-Source: AGHT+IHqhBuLi/l9jYli78fnwJgIaeEPIQZfD/7Pzq5+WgxugeFEZd2oi7gAL6YwJLTniKrTklCz9A==
X-Received: by 2002:a05:690c:67c9:b0:672:e49d:430e with SMTP id 00721157ae682-6d40df80319mr217344097b3.15.1725486672697;
        Wed, 04 Sep 2024 14:51:12 -0700 (PDT)
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com. [209.85.219.182])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6d2eaff2b0fsm25859047b3.39.2024.09.04.14.51.11
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Sep 2024 14:51:11 -0700 (PDT)
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e1d06c728b8so185573276.0
        for <linux-serial@vger.kernel.org>; Wed, 04 Sep 2024 14:51:11 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXmdzvD9rLp72TOZQxMYdP17kPm7TF30Xwgc5fXyLlT/CTImsCv1cLzTZYVKr9+yarCBUV6RZL8WwUmtB0=@vger.kernel.org
X-Received: by 2002:a05:6902:1b11:b0:e1d:13a3:87af with SMTP id
 3f1490d57ef6-e1d13a3892emr2954820276.29.1725486670922; Wed, 04 Sep 2024
 14:51:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240902152451.862-1-johan+linaro@kernel.org> <20240902152451.862-2-johan+linaro@kernel.org>
In-Reply-To: <20240902152451.862-2-johan+linaro@kernel.org>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 4 Sep 2024 14:50:57 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WDx69BqK2MmhOMfKdEUtExo1wWFMY_n3edQhSF7RoWzg@mail.gmail.com>
Message-ID: <CAD=FV=WDx69BqK2MmhOMfKdEUtExo1wWFMY_n3edQhSF7RoWzg@mail.gmail.com>
Subject: Re: [PATCH 1/8] serial: qcom-geni: fix fifo polling timeout
To: Johan Hovold <johan+linaro@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	=?UTF-8?B?TsOtY29sYXMgRiAuIFIgLiBBIC4gUHJhZG8=?= <nfraprado@collabora.com>, 
	linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Sep 2, 2024 at 8:26=E2=80=AFAM Johan Hovold <johan+linaro@kernel.or=
g> wrote:
>
> The qcom_geni_serial_poll_bit() can be used to wait for events like
> command completion and is supposed to wait for the time it takes to
> clear a full fifo before timing out.
>
> As noted by Doug, the current implementation does not account for start,
> stop and parity bits when determining the timeout. The helper also does
> not currently account for the shift register and the two-word
> intermediate transfer register.
>
> Instead of determining the fifo timeout on every call, store the timeout
> when updating it in set_termios() and wait for up to 19/16 the time it
> takes to clear the 16 word fifo to account for the shift and
> intermediate registers. Note that serial core has already added a 20 ms
> margin to the fifo timeout.
>
> Also note that the current uart_fifo_timeout() interface does
> unnecessary calculations on every call and also did not exists in
> earlier kernels so only store its result once. This also facilitates
> backports as earlier kernels can derive the timeout from uport->timeout,
> which has since been removed.
>
> Fixes: c4f528795d1a ("tty: serial: msm_geni_serial: Add serial driver sup=
port for GENI based QUP")
> Cc: stable@vger.kernel.org      # 4.17
> Reported-by: Douglas Anderson <dianders@chromium.org>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>  drivers/tty/serial/qcom_geni_serial.c | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/q=
com_geni_serial.c
> index 69a632fefc41..e1926124339d 100644
> --- a/drivers/tty/serial/qcom_geni_serial.c
> +++ b/drivers/tty/serial/qcom_geni_serial.c
> @@ -124,7 +124,7 @@ struct qcom_geni_serial_port {
>         dma_addr_t tx_dma_addr;
>         dma_addr_t rx_dma_addr;
>         bool setup;
> -       unsigned int baud;
> +       unsigned long fifo_timeout_us;
>         unsigned long clk_rate;
>         void *rx_buf;
>         u32 loopback;
> @@ -270,22 +270,21 @@ static bool qcom_geni_serial_poll_bit(struct uart_p=
ort *uport,
>  {
>         u32 reg;
>         struct qcom_geni_serial_port *port;
> -       unsigned int baud;
> -       unsigned int fifo_bits;
>         unsigned long timeout_us =3D 20000;
>         struct qcom_geni_private_data *private_data =3D uport->private_da=
ta;
>
>         if (private_data->drv) {
>                 port =3D to_dev_port(uport);
> -               baud =3D port->baud;
> -               if (!baud)
> -                       baud =3D 115200;
> -               fifo_bits =3D port->tx_fifo_depth * port->tx_fifo_width;
> +
>                 /*
> -                * Total polling iterations based on FIFO worth of bytes =
to be
> -                * sent at current baud. Add a little fluff to the wait.
> +                * Wait up to 19/16 the time it would take to clear a ful=
l
> +                * FIFO, which accounts for the three words in the shift =
and
> +                * intermediate registers.
> +                *
> +                * Note that fifo_timeout_us already has a 20 ms margin.
>                  */
> -               timeout_us =3D ((fifo_bits * USEC_PER_SEC) / baud) + 500;
> +               if (port->fifo_timeout_us)
> +                       timeout_us =3D 19 * port->fifo_timeout_us / 16;

It made me giggle a bit that part of the justification for caching
"fifo_timeout_us" was to avoid calculations each time through the
function. ...but then the code does the "19/16" math here instead of
just including it in the cache. ;-) ;-) ;-)

That being said, I'm not really a fan of the "19 / 16" anyway. The 16
value is calculated elsewhere in the code as:

port->tx_fifo_depth =3D geni_se_get_tx_fifo_depth(&port->se);
port->tx_fifo_width =3D geni_se_get_tx_fifo_width(&port->se);
port->rx_fifo_depth =3D geni_se_get_rx_fifo_depth(&port->se);
uport->fifosize =3D
  (port->tx_fifo_depth * port->tx_fifo_width) / BITS_PER_BYTE;

...and here you're just hardcoding it to 16. Then there's also the
fact that the "19 / 16" will also multiply the 20 ms "slop" added by
uart_fifo_timeout() which doesn't seem ideal.

How about this: we just change "uport->fifosize" to account for the 3
extra words? So it can be:

((port->tx_fifo_depth + 3) * port->tx_fifo_width) / BITS_PER_BYTE;

...then the cache will be correct and everything will work out. What
do you think?

-Doug
