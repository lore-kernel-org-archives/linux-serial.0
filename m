Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF2B1C6BE
	for <linux-serial@vger.kernel.org>; Wed,  9 Oct 2024 10:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728471082; cv=none; b=hvoBUnLNze2yc6viVgCwiBhvm++sWApo6NBHFlDX0DCo6CniE9bLSP7AwGP8PA9lajrDuXu+v/taX86fHi7r2R+UrWmCs/310TqAi3L22caNP26qqdB1uEcGaW2l+qW09oMjX+66QP+JfbM2mNvutEcN4mj8r2BLC+UsA9RHDlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728471082; c=relaxed/simple;
	bh=+yvFAbQ7s0rgRQQpPZtq6CE0U2hIXEf6wBenPgPDXqM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mJwB9XQ+irXg8iRD1RWjEMPSA4WFQhpEKVYSLQdJXmcPfVzSC5qQDsUVQSB27/PBGq1Yc4yteUKUBPQo7+kq29pDK+aNziCvMeAWBxn9suWwuyz35DkQMPg4uXlTwHoi1wr1OdVrz/YF2FAdwJ51FBucVimKEaM6zVsdlRqB0iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RFYWg7wm; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RFYWg7wm"
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e28ee55190aso1493676276.0
        for <linux-serial@vger.kernel.org>; Wed, 09 Oct 2024 03:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728471080; x=1729075880; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iXqRckUcaLEwb08tvELxqUUlJj2ycSVSO8hNl/Y5Qqk=;
        b=RFYWg7wmjtYrOUlytTJiJqrCRtpYn7ES7P2+DJeRVjhoggdTpTrirU/WwTyJLi4n1J
         6J4JbfCY8GDCptnAd+VKqffpoCYHkO2HMmK6g4l7haMhNiCzczxecmhe5bCl+atTBwKQ
         EnQZR9vRjsYBWtAY5g9Mldo6FnifQJghNuFTafD9PUPSJK4ND37/RtjGg4BqsF4tLBfU
         HGggfvXY1SbM/4aMF4GBpPpAIhAmWyhQF0ZDETyd4vROc3wYs7yTvR94aPyiBMVGXjaG
         caz9fUCGvWf/sE09709bAss9dFSCIbR74X//Y2Dgr5nz8LJVEpxeD/xww/23ZqEjn62E
         ZTHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728471080; x=1729075880;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iXqRckUcaLEwb08tvELxqUUlJj2ycSVSO8hNl/Y5Qqk=;
        b=jADWAk8CCV6L5O1qTl4kylheCBJrTo5yj758TXZYkD4jpg996BnYDzCwcZtt0BIx2Q
         rI/oFX8kJHWPjpZPhJfE2uBDtaXB/HDkrb5cYXiW0GHmR+S66mUQqqpuDyJspWBuPjr2
         S4Q6rToBDLMwvYS2Wd7HXDh31Ze7ybZc01WhtgCGNIUgGip1oQ7IeTmTMwQR1emnjJwr
         FACA1wQN2sgb5pQRzsS20GNhYpOcDs94zeXl/KFvCQ4RrCbCjBnnecF9T4dLWNI3vb1I
         34f5xzoA4TEBgOIBLe91/MO4L2UfoIdYD5yTj1wQI/rXQHrGfDEIycD0SGg56hOV8oq+
         8urw==
X-Forwarded-Encrypted: i=1; AJvYcCUQM3O7R5KV8Vadzislj8b/wYwcth5bz8ei03DD0hf9h8TcrmfiOm80WEEseA2WW1tsRNXEm4KJ8/CGzUE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxo4/g3sqU+LpyObw6Atcb/HVEG14xNmqRy6Rt9e/sF1usqRcQZ
	gmSTHo5fym+CPkNSLZEmcV07uA22swBElUdr2AwQr3Z+4E+Vz+AZqIOTbonvwXD4Ki1tcyBsH8G
	KqyoUfCKItXhf7j8qOypaPydeXQmYJNda8WnXyg==
X-Google-Smtp-Source: AGHT+IFMmaCoYqELojZrx455Xf9B0d6jXNtv4wk+RYx3eU7mtusx7xzvsECrueDK/C+TiR4avlTI+nzU55aqnY0+2rQ=
X-Received: by 2002:a05:6902:e0c:b0:e28:f3e7:d92b with SMTP id
 3f1490d57ef6-e28fe36916dmr1640596276.24.1728471079940; Wed, 09 Oct 2024
 03:51:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241008-8250-omap-no-console-suspend-v1-0-e7f0365c02f0@bootlin.com>
 <20241008-8250-omap-no-console-suspend-v1-2-e7f0365c02f0@bootlin.com>
In-Reply-To: <20241008-8250-omap-no-console-suspend-v1-2-e7f0365c02f0@bootlin.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 9 Oct 2024 12:50:43 +0200
Message-ID: <CAPDyKFpnsV-c4F7SNPQmLBSM1sUknr-3sTyiXMDt9n43UBQkNg@mail.gmail.com>
Subject: Re: [PATCH 2/2] serial: 8250_omap: mark the serial as on the wakeup
 path if no_console_suspend
To: Thomas Richard <thomas.richard@bootlin.com>
Cc: Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>, 
	Santosh Shilimkar <ssantosh@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, linux-arm-kernel@lists.infradead.org, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, u-kumar1@ti.com, tony@atomide.com, 
	khilman@kernel.org, gregory.clement@bootlin.com, thomas.petazzoni@bootlin.com, 
	theo.lebrun@bootlin.com, richard.genoud@bootlin.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 8 Oct 2024 at 11:34, Thomas Richard <thomas.richard@bootlin.com> wr=
ote:
>
> If the console suspend is disabled, mark the serial as on the wakeup path
> to keep its PM domain powered on.
>
> Suggested-by: Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>
> Signed-off-by: Thomas Richard <thomas.richard@bootlin.com>
> ---
>  drivers/tty/serial/8250/8250_omap.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/825=
0/8250_omap.c
> index 88b58f44e4e9..6764fe2f9cad 100644
> --- a/drivers/tty/serial/8250/8250_omap.c
> +++ b/drivers/tty/serial/8250/8250_omap.c
> @@ -1660,8 +1660,12 @@ static int omap8250_suspend(struct device *dev)
>         if (!device_may_wakeup(dev))
>                 priv->wer =3D 0;
>         serial_out(up, UART_OMAP_WER, priv->wer);
> -       if (uart_console(&up->port) && console_suspend_enabled)
> -               err =3D pm_runtime_force_suspend(dev);
> +       if (uart_console(&up->port)) {
> +               if (console_suspend_enabled)
> +                       err =3D pm_runtime_force_suspend(dev);
> +               else
> +                       device_set_wakeup_path(dev);
> +       }

Isn't this already managed by the serial core? See commit a47cf07f60dc
("serial: core: Call device_set_awake_path() for console port")

[...]

Kind regards
Uffe
