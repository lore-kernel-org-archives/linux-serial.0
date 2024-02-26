Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A017128386
	for <linux-serial@vger.kernel.org>; Mon, 26 Feb 2024 16:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708963270; cv=none; b=Iu7SHlSPvJiYgCr98p9/Gt6OCn2KF0+hasj5Hs1vbjdagOzo6OSVb611bkZce9ZdsZn1DkzMlHCzYev8Pec31IcAsbgBgKJGmL+GOl0H/BUNm2s+U/X0zA+p+uHNUbtKAEMehiAqCIu8eX6n+vmmThO9ng/HTL9NAh73stYVqb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708963270; c=relaxed/simple;
	bh=KR4gqawWz888BDqcnt6P3mx6J0Z8KN7NyP4/jwzp43k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lJ5HkXQhLcY/gPulGivlHu3d7XL88OgP0EM1Idevv56kdfoPjLOkHNW+yGs3vY4IFchZVZDXIpwJ5RgX/5L8OLljl63RXxn0kv6wK5q0S0FLqbQpisOVZbKCz2LtptFm/jETsOB4XR/0VGAqHSB+oWMK57HsWHhyoHpp/kn2gn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hB9C6BRt; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hB9C6BRt"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4129a748420so95415e9.0
        for <linux-serial@vger.kernel.org>; Mon, 26 Feb 2024 08:01:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708963267; x=1709568067; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rx2ismZqI+uUe7s0HDfK/iCGkx96FSYcL/qVJ23SipU=;
        b=hB9C6BRt/AYHvKOoraUm/QaHtnHHxbEWRXs6kHUPH/hXQXgZQHRmZJBhe00etA38XN
         F0O9MLwHFsZyrygRGq1Wu7sbHm5rbzb2EkLd0C3Msf1nSPA1EiI4aTl1BW/+ZDjzm+Qr
         rr0Tm2dbMDahJ1MRrVxJ9z3yyKjHlFcNDMw4C91LnQ2qeXdj6e+HAuMqDapaKd2vskgJ
         nBp9Rxd6XhStmwpewwN4SBU9C6J/bPKrQfQH1YvF9MmnR5v1T/mS0/9njKypXf0RoLqZ
         +Lru4aLM581Sq3Vkk2o0u391Cp5hZkdcMFQL9bgYh2Zcrrgv9GTtd+LYfiv2Coa7/grV
         gGcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708963267; x=1709568067;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rx2ismZqI+uUe7s0HDfK/iCGkx96FSYcL/qVJ23SipU=;
        b=MA2HnBqj8FruANe0KOcc2RsIDORIutRtl+BRDh5lXnctL3zLaW1g0YGEVx7TAadIix
         kTHDiRZtnZaCHo8+Gv4Z9/aeEWWhkpouUiNIkKmxZ+6LGPnthVW/E9WaWwzNaak81GS2
         b9ohNPOJVJab+nALAA1ee08atxL3LihHkXJo3vaWK7sIU5di6ikzW+0qdAicLSXNjwra
         WxRtM/+RiJfFtsxztAhbWj1qDpTplrcbByIygxYh1mVu2ns7Lp7ZMJr2gywhBmscAtSW
         8E+CDiRvtjotpMmjoXdbluJDgIi0RYd2Vj0+YTd1pYDtWUX952Y8NsZM2Uk1TXDIM9FK
         21Aw==
X-Forwarded-Encrypted: i=1; AJvYcCX7V/ZYIAt1jYSDCHm5iz/pX3tqIPYvmc0WgvfKiwS1qmJmjGCgUgwx55KleyB5ueNF06UW3GzSetnxgRMC6/e7QV7bRCGHDlASNYQ6
X-Gm-Message-State: AOJu0YzrzWlj/vkv/mjeuvaanjD5BbM2UfXLHySmnKAqH4DIhYqZvwpX
	Cskjr+Zb2IRVoZPowQcV+zjxZC+lcLN1lbFo+mYPUeTGJeUpiEubHu6EtnjjE3jBPt/KAr4I9h+
	SBvhGEpxyRWfxRiYqJQ/1qD3TPyuzb6EKnYUh
X-Google-Smtp-Source: AGHT+IEmC5IIk8VP5+8/9Vrdmx7qEPI0kAZBxvZ4GdYje0qo4jDPNkxsjR5tLHl+hzo1DQpclP5C0nHf3h6pVwtGX2w=
X-Received: by 2002:a05:600c:1d93:b0:412:a897:a78 with SMTP id
 p19-20020a05600c1d9300b00412a8970a78mr94398wms.5.1708963267311; Mon, 26 Feb
 2024 08:01:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240222111922.2016122-2-u.kleine-koenig@pengutronix.de>
In-Reply-To: <20240222111922.2016122-2-u.kleine-koenig@pengutronix.de>
From: VAMSHI GAJJELA <vamshigajjela@google.com>
Date: Mon, 26 Feb 2024 21:30:53 +0530
Message-ID: <CAMTSyjrKVL12CrXuqJhWydObhYfgLF=zKTE0U0LdzimTT6Sdsw@mail.gmail.com>
Subject: Re: [PATCH] serial: 8250_dw: Emit an error message if getting the
 baudclk failed
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 22, 2024 at 4:50=E2=80=AFPM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> Instead of silently giving up, at least tell what the problem is.
>
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/tty/serial/8250/8250_dw.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/=
8250_dw.c
> index 2d1f350a4bea..94aa3dddb71e 100644
> --- a/drivers/tty/serial/8250/8250_dw.c
> +++ b/drivers/tty/serial/8250/8250_dw.c
> @@ -597,7 +597,8 @@ static int dw8250_probe(struct platform_device *pdev)
>         if (data->clk =3D=3D NULL)
>                 data->clk =3D devm_clk_get_optional_enabled(dev, NULL);
>         if (IS_ERR(data->clk))
> -               return PTR_ERR(data->clk);
> +               return dev_err_probe(dev, PTR_ERR(data->clk),
> +                                    "failed to get baudclk\n");

Not required IMO as the baudclk is optional, otherwise it might ask
for a similar change at apb_pclk.
Could you please provide some insight into the circumstances that lead
to encountering this error case?

Also the check is for IS_ERR(data->clk), data-clk could be NULL aswell.

I see any error should be caught at the following line, provided no
clock-frequency
```
/* If no clock rate is defined, fail. */
if (!p->uartclk)
        return dev_err_probe(dev, -EINVAL, "clock rate not defined\n");
```
>
>         INIT_WORK(&data->clk_work, dw8250_clk_work_cb);
>         data->clk_notifier.notifier_call =3D dw8250_clk_notifier_cb;
> --
> 2.43.0
>
>
