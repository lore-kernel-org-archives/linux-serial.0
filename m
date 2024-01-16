Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6810A1CD06
	for <linux-serial@vger.kernel.org>; Tue, 16 Jan 2024 17:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705427519; cv=none; b=emrqGi04WqnNuJoCZ1sKephVM8SLUlWBhD1ZoBmIgyR6l9xgW9aMK7Nqp2d6sGf4vpaD1u1DWI9XaFdi8we8P2wz/q1ws0dVMLQw+Xemw9Ozu/9Hk02UFQxGMp5jY9Nd/0LFTtBixKmO7OdTKJ72a4k49yhcqM9hpWQXJD0aDQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705427519; c=relaxed/simple;
	bh=2sDRBRp+27dyz+lLnzucjXQfgDv3cCd+bHegl4Kf514=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=FxAAzE55YHxR+zOUtlhfcyKYwYeADherA44auvF2hE750Ao2WC2ysiPm7+E8pbYmHbuLcqEE2sGTzniefRKaPxadhZIR3A1ki2QbXceyWf7B9xRSQi6yoUCB4H1VzM4YO6BjVY8juNNJ3nxWAfD1lnpa1uFRWCw4Ux+brLqF9tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zEBGy0AC; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zEBGy0AC"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-5cf22a89a54so3028673a12.3
        for <linux-serial@vger.kernel.org>; Tue, 16 Jan 2024 09:51:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705427518; x=1706032318; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JLkbVRAk95ipntvmjbPNO29427ChHJt1Wds4CgPJfoc=;
        b=zEBGy0ACJFvND8Gp4XXtSyoH1DfPa2s2JTE9FOZx9DjrJAZ+W3fEUtEoRMZeO9fV3o
         vWoqziTVjrpByNLuP93DepPziNNCTviZnpjHzNRA+zWzROwjpmpea2+PRO67GDU62/Xn
         cy3jvgGydup4ISRwTqKKOH3+223ABUoSQuUDgvW3LjFYkKp9cZjxKwOZBIqmlBZJdOrE
         MATXC60KMjufrRQpseqS0MuChzKf9HhRdvpz+tk/lQlq23Qs0QD45LHNjNnbOa0QXN0W
         Ntcvfhm9WydD/MAqkW+LWCmfM9wrmELBVg1CZKfBfALhSspSiGXgIhL7XmvUqeNU4Or5
         vYIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705427518; x=1706032318;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JLkbVRAk95ipntvmjbPNO29427ChHJt1Wds4CgPJfoc=;
        b=CjcFUMYVL6Ec0LR0Ks5Yt4WutcR8B/dVwMBf15Ys99t2fJLn7vEoqPxM7GEoLcVUND
         d04WuOS2ZF39lMtQXdVD19WwDKAbgPEoZPZzoCuoowJYcw4zxYlW1h+4OguPvW1U/XUj
         rEFavwVtk3I9BZfMtWuTDDsTSmk3H0KvSQ/TmGuGswGLZbxzS/3fcBQWe1zF2HEJT0d9
         3AjvG0o0OPPw/ZZiMhhcgk+W6Cmk3I0+Vt9nsxj8Y299eImP7h391RzjHQ1H8xTv8RuD
         DTU/y0vXF4hc9U+s/r9eEKFdYKIHCP/TE7+fQ6uScIS6N3hPOuvqRTBKh9JVlKguU7lg
         cjzA==
X-Gm-Message-State: AOJu0YyeUsDiTtx36UlSYlVK0W0LklqBjeZH4+WREgsooW8gLH6LUbyR
	HEg6lPBR9vOh62tGdPUoCc79RNJe/Y2MjLvqrmL+2hCsHstZTw==
X-Google-Smtp-Source: AGHT+IGmhFr1Xzziwh8GD2Vq3OCA1ZM67LySAGd4/+lGJnEIaSy0yYNelNXzR4oJcDfV7SY2HFly/HJIoiYFK8jnXC0=
X-Received: by 2002:a17:90b:1649:b0:28d:bec5:a5be with SMTP id
 il9-20020a17090b164900b0028dbec5a5bemr3687886pjb.68.1705427517801; Tue, 16
 Jan 2024 09:51:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240109125814.3691033-1-tudor.ambarus@linaro.org> <20240109125814.3691033-7-tudor.ambarus@linaro.org>
In-Reply-To: <20240109125814.3691033-7-tudor.ambarus@linaro.org>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Tue, 16 Jan 2024 11:51:46 -0600
Message-ID: <CAPLW+4mYMqZUyeSt0Ws8jcuQw2s7a2h8kqCJ2CAbVv7nV4zBTQ@mail.gmail.com>
Subject: Re: [PATCH v3 06/12] tty: serial: samsung: add gs101 earlycon support
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: peter.griffin@linaro.org, krzysztof.kozlowski+dt@linaro.org, 
	gregkh@linuxfoundation.org, mturquette@baylibre.com, sboyd@kernel.org, 
	robh+dt@kernel.org, conor+dt@kernel.org, andi.shyti@kernel.org, 
	alim.akhtar@samsung.com, jirislaby@kernel.org, s.nawrocki@samsung.com, 
	tomasz.figa@gmail.com, cw00.choi@samsung.com, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, 
	linux-serial@vger.kernel.org, andre.draszik@linaro.org, 
	kernel-team@android.com, willmcvicker@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 9, 2024 at 7:00=E2=80=AFAM Tudor Ambarus <tudor.ambarus@linaro.=
org> wrote:
>
> The entire bus (PERIC) on which the GS101 serial resides only allows
> 32-bit register accesses. The reg-io-width dt property is disallowed
> for the "google,gs101-uart" compatible and instead the iotype is
> inferred from the compatible. Always set UPIO_MEM32 iotype for the
> gs101 earlycon.
>
> Reviewed-by: Peter Griffin <peter.griffin@linaro.org>
> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> ---

Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>

> v3: collect Peter's R-b tag
> v2: update commit message
>
>  drivers/tty/serial/samsung_tty.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsun=
g_tty.c
> index a81b61953a28..fed50423b7c1 100644
> --- a/drivers/tty/serial/samsung_tty.c
> +++ b/drivers/tty/serial/samsung_tty.c
> @@ -2812,6 +2812,17 @@ OF_EARLYCON_DECLARE(exynos4210, "samsung,exynos421=
0-uart",
>  OF_EARLYCON_DECLARE(artpec8, "axis,artpec8-uart",
>                         s5pv210_early_console_setup);
>
> +static int __init gs101_early_console_setup(struct earlycon_device *devi=
ce,
> +                                           const char *opt)
> +{
> +       /* gs101 always expects MMIO32 register accesses. */
> +       device->port.iotype =3D UPIO_MEM32;
> +
> +       return s5pv210_early_console_setup(device, opt);
> +}
> +
> +OF_EARLYCON_DECLARE(gs101, "google,gs101-uart", gs101_early_console_setu=
p);
> +
>  /* Apple S5L */
>  static int __init apple_s5l_early_console_setup(struct earlycon_device *=
device,
>                                                 const char *opt)
> --
> 2.43.0.472.g3155946c3a-goog
>
>
