Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5940422422E
	for <linux-serial@vger.kernel.org>; Mon,  9 Jun 2025 22:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749509124; cv=none; b=LSpQ4z1wBaovLjjrK73tla/Rzo/VvUD1FamwXJYao9mmmAR0JKZuQsFQSs6AqDQMJt+R5yzXYCrldROuBe0sxJPqa3kAfuxujsAC/raW53CuLBVb8leEl+7iQwJPieO0btwFBZMIjL9JeXUm7zg+GJCNwvzbXxcqM3w5q9E8VV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749509124; c=relaxed/simple;
	bh=Iq0x5q2nwlvRMcB2qn2pumIsm+x63752VXEgXOhaJCQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rGBJn/Xk8I4IAxJ3bIGjzRmx9/Rca393MCGMaPkCzfBV78kzOt/OXQhFMnwmRjEY2KCrjyg+3nIsy42wPcb9PppDTx+cozLnLHuXL6/2SSNsKUu2980I1Ha5rA5fkLu8Ec2iRAgwOzK7OhiB95VhowH/u/EbfqMgL/eBG/iEY6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=UZhS2BAg; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UZhS2BAg"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b2c40a7ca6eso4581290a12.1
        for <linux-serial@vger.kernel.org>; Mon, 09 Jun 2025 15:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1749509117; x=1750113917; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a/LCGkPSUi11y6YDbtw03gAAN8X0aMlNFtkYip4Smws=;
        b=UZhS2BAgdnWp2y1MrJb8Abl6UkXMp18Aqa+ZxZDs4FVnOjlJSEqaeRidRe+OUnZe+r
         u0JvcT4rNrekQy8kpFnX+dzOj27lUNEcw3TfkX+5lOlV8SDYdniWNvW6541wQTxQKVwT
         Xpd8/63mVT95n+4IPRt4hHzLl1sIL11dJ0G9s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749509117; x=1750113917;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a/LCGkPSUi11y6YDbtw03gAAN8X0aMlNFtkYip4Smws=;
        b=bZdcqQ9LpfSapH7nfxXLRL27WcljrCFV4SPyTkNbCqvuFX8CcmEW1cFX9tJtbbfpkD
         ml6rPqntIhnThXZSLPsWQk7a+S9Zc5cvCW96AfXLEKsHX4yVuXr7so7kUgg6byu2MD0v
         BnLA4m/PZ6o9EnV/ITkvKaJQTzZFji68iUPBZ++BCT5qsI6bzZBMk2shM3SCNAB+QpNS
         QqV3zSG3v8JON3GgvdxKx0B+il8RTbT72GQHc+i93IxG7f5s/YmRYrwUrycMdUtBbMp9
         2QhgIhLyGtnZaRcrU1eu4bybyDTXPw5glo+Gd0JmkqXgOwxvrsgg49ao3JjwPLlVDIkU
         0t6A==
X-Forwarded-Encrypted: i=1; AJvYcCUYN7qXJpHMEyxcNH8LANpf3qGLLdEnO27XW8MkQWQ0EozmEVhoDBEPv1UnanWI/2KIh1RBMi8VrGepOy4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyls4es+yPg+f3Do4T9QczVWELeaNJ45VfLhyMIxMySS7O0a2pt
	19iQaur4d/LXBCy+lR4wR+kf7V7HtApr1FjkkpPp52qKuF/ArtbOZE3e9vrTSE/mjQvk1RxObJn
	39iCV0g==
X-Gm-Gg: ASbGncs7tjnbWVpWGLjZeeBfuB0YljSWpwpXkEbP9Qb9I59sWAwGxti6JdnarONxX/M
	iHomOe4ALhy2bZx8ROksDWw/ya8U15WPBmteYcOoLV1xMM/THTABuSbQQrMtl/ZaYzJmzbf1IMW
	0UIofcUA4q1nAqBoWP+wbAWs69Pw0q2AsZMkFzWUZbS54U4hLYKWt1i7el2HpsYAnNNGarWT2+u
	Lo2PZE87jk7fahIVB0TDuRzqftvziUAP5p7m0Ojeka2Urpw9F6EtJTJlytPKqy37slx6KgTXEXX
	xkv2pcQvmJxhWeRnfk8nDM4W6fxMhfcQGvHOUM7B0Q6+siogkUriaU0QmUeWmTrnHznMJ//mxQg
	LVDlMZVc4vLQhdJpHi1QfB2wzhT21NpEn21Hc
X-Google-Smtp-Source: AGHT+IHMYEmqaTz+JkKqqO1Tb+qoQ7kCw2wXiAkRkDwgYASGcvg+zXcJua+uXSlK2w+1Aju6hKOmqg==
X-Received: by 2002:a17:90b:28c3:b0:311:c1ec:7d05 with SMTP id 98e67ed59e1d1-313a16e9839mr334604a91.35.1749509117595;
        Mon, 09 Jun 2025 15:45:17 -0700 (PDT)
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com. [209.85.216.53])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3134b9b730bsm6054822a91.18.2025.06.09.15.45.15
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Jun 2025 15:45:15 -0700 (PDT)
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3109f106867so5841130a91.1
        for <linux-serial@vger.kernel.org>; Mon, 09 Jun 2025 15:45:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWtwiWYeQEiekGkdxTBad+EgaWugs6nN5I7Wuv+BWZrgyg0xT5D2MWj6CgfHCcSVaTttoxgSO2MAPQX96I=@vger.kernel.org
X-Received: by 2002:a17:90b:6c7:b0:313:1a8c:c2c6 with SMTP id
 98e67ed59e1d1-313a1695527mr399198a91.16.1749509115055; Mon, 09 Jun 2025
 15:45:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250506125133.108786-1-nicolescu.roxana@protonmail.com> <20250506125133.108786-3-nicolescu.roxana@protonmail.com>
In-Reply-To: <20250506125133.108786-3-nicolescu.roxana@protonmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 9 Jun 2025 15:45:02 -0700
X-Gmail-Original-Message-ID: <CAD=FV=V2PSoakXH0_nKx1MkjPGXrHkFbPyMR=om9efW7LPn-dw@mail.gmail.com>
X-Gm-Features: AX0GCFvms_bTeu1m1tYJFabPtpRa0hg1AcW21wJUDi4AC8ourQTRpSPGDqEtFkQ
Message-ID: <CAD=FV=V2PSoakXH0_nKx1MkjPGXrHkFbPyMR=om9efW7LPn-dw@mail.gmail.com>
Subject: Re: [RFC PATCH 2/2] serial: kgdboc: convert to use faux_device
To: Roxana Nicolescu <nicolescu.roxana@protonmail.com>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, dakr@kernel.org, 
	jason.wessel@windriver.com, danielt@kernel.org, jirislaby@kernel.org, 
	kgdb-bugreport@lists.sourceforge.net, linux-serial@vger.kernel.org, 
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org, 
	linux-kernel-mentees@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, May 6, 2025 at 5:51=E2=80=AFAM Roxana Nicolescu
<nicolescu.roxana@protonmail.com> wrote:
>
> The kgdboc uses a "fake" platform device to handle tty drivers showing
> up late. In case the tty device is not detected during probe, it will
> return EPROBE_DEFER which means the probe will be called later when the
> tty device might be there. Before this, the kgdboc driver
> would be initialized early in the process (useful for early boot
> debugging) but then the tty device wouldn't be there, and retry wouldn't =
be
> done later. For a better explanation, see commit
> '68e55f61c138: ("kgdboc: Use a platform device to handle tty drivers
> showing up late")'.
>
> This replaces the platform_device usage with faux_device which was
> introduced recently for scenarios like this, where there is not real
> platform device needed. Moreover, it makes the code cleaner than before.
>
> Signed-off-by: Roxana Nicolescu <nicolescu.roxana@protonmail.com>
> ---
>  drivers/tty/serial/kgdboc.c | 50 +++++++++++--------------------------
>  1 file changed, 14 insertions(+), 36 deletions(-)
>
> diff --git a/drivers/tty/serial/kgdboc.c b/drivers/tty/serial/kgdboc.c
> index 85f6c5a76e0f..d1ffe6186685 100644
> --- a/drivers/tty/serial/kgdboc.c
> +++ b/drivers/tty/serial/kgdboc.c
> @@ -21,7 +21,7 @@
>  #include <linux/input.h>
>  #include <linux/irq_work.h>
>  #include <linux/module.h>
> -#include <linux/platform_device.h>
> +#include <linux/device/faux.h>
>  #include <linux/serial_core.h>
>
>  #define MAX_CONFIG_LEN         40
> @@ -42,7 +42,7 @@ static int kgdboc_use_kms;  /* 1 if we use kernel mode =
switching */
>  static struct tty_driver       *kgdb_tty_driver;
>  static int                     kgdb_tty_line;
>
> -static struct platform_device *kgdboc_pdev;
> +static struct faux_device *kgdboc_fdev;
>
>  #if IS_BUILTIN(CONFIG_KGDB_SERIAL_CONSOLE)
>  static struct kgdb_io          kgdboc_earlycon_io_ops;
> @@ -259,7 +259,7 @@ static int configure_kgdboc(void)
>         return err;
>  }
>
> -static int kgdboc_probe(struct platform_device *pdev)
> +static int kgdboc_probe(struct faux_device *fdev)
>  {
>         int ret =3D 0;
>
> @@ -276,47 +276,26 @@ static int kgdboc_probe(struct platform_device *pde=
v)
>         return ret;
>  }
>
> -static struct platform_driver kgdboc_platform_driver =3D {
> +struct faux_device_ops kgdboc_driver =3D {

nit: s/kgdboc_driver/kgdboc_faux_ops/ ?

Other than that, this seems reasonable to me. I guess I'd assume that
Greg would chime in at some point since patch #1 in this series would
need to go through him.

-Doug
