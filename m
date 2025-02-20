Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3455C1B4259;
	Thu, 20 Feb 2025 21:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740088155; cv=none; b=E9gfWVv06jQtzGkVJdX5noaVCyuillhdRcOHTQ6WGCq2QIJGHl4g+dR45FDZBDhX8BwXu6OCRatfE5msNOUPT2Tl8bUscNY3LG+kHiViFVSj4cvFXazX0J8CQKPa9XQPeXzUYm5/04CbTqetdz9ZwYqb5H3y/eRzmvXjHfRQxmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740088155; c=relaxed/simple;
	bh=AQYQMGpBWk2y9F/ajrYPRCHCpKiCNoJBOWBrz6bmQV4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dzCAxTb5B9zzp0/ozFag7xUymmphawzX/yRk7lRJY/Vk1bIiyYeeGKFnQ044aXmLK5KogMaWyp3k8Yp1g/lIpa/qLM5rno0D59k+F7Uug+pdGoQ/a3x+AsJ8XjSHFYgcrce2JZYC4ERuqHO/7jRIaTbVOAZVFuiNVcPiKLqX8wE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ht+6jh6X; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ht+6jh6X"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5e050b1491eso4457878a12.0;
        Thu, 20 Feb 2025 13:49:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740088150; x=1740692950; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9whq2vsv/mk0BYyCs4wwDK57ulcjfcTEY+oV/RVpU7c=;
        b=Ht+6jh6XQ1kzwkJto79NXFhTTPp8//lqhqAuRnrMBBgUwJ5IEsiiMb/birsdw6dpTn
         q3a6r3BI4r0IfKYT7+WhtJhoQpo7YLGmltPuuSb28YRG1pBkuDKZCyGPj32U++nF1fwd
         laHhxnF2aDvpprxxwlLWK/AqeZnRauSEv3eseihjm7+d523gwuffl/gUx4rkUdySc/Nq
         gGYF5G7A3GpKyokLXfImKMSSKV6pWrJdlqHvWfCxOb/X1KJqa88Iyequ5789c2CmSlO0
         wJvqUUeP6lrC5YJJo42ORFYCBjsN5YX/FAU0B0h0tGR4u1XL3S/wkfiGjud03CwfuKBV
         jkJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740088150; x=1740692950;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9whq2vsv/mk0BYyCs4wwDK57ulcjfcTEY+oV/RVpU7c=;
        b=a7HwjBwt5ZZPWScvaCwIexEyosky+NZQsMaeIZJ60/3WoJvBZueq2lghcFfmF5JfIN
         /+dKFPUjgznVtME2OL3VajfUR8BPGe3YjrZAriDscG7PRqNLuhTROAlrkH3cRvOv3CGC
         9T9/k91/F6ibv2nN5cx2kfW7JvFxZ4lJlUO9SIOK0O+pqy9gb6V/xo6fFPg9ffuJQr0v
         6pr3tukLFhJcOq3IAtzYVpF1FC9CtrWaDzw7FEXNd1Mx/Z8Tb+syjiR8o3Qcdhco4KrZ
         X1i3oO5kjNpSH/dfJcCPOxDqhepia7XJDIHKYXt8FGV6bkiYeBEq7yr0ii+hEGj/WK6F
         DqrA==
X-Forwarded-Encrypted: i=1; AJvYcCVVm6oYDFpEMjJij/tLIfi52NE/cG4f9Xwle+26SMB+aBR4ewIoJjBFComjNNVcKw1hCPqY3tUddCv5oQ==@vger.kernel.org, AJvYcCX3P1GX7OPC5x18vSsweXhbBuxe0pOcROF9exvKMxsYlgwirK6btAARXhxfnrC215tUg6ap3Unv7NwIsNgH@vger.kernel.org, AJvYcCXJ06afxLp3gCHaVTc/j/hofJwb3sT86hdIf4K+REffppYcfllf3kMEvYHhbk8oHwm7DBbtzkX3nqyPf5e1@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3h92HcCcC5EbI9V0KOZKkm3e4TU3jI66CACfPZFCB/UneDIMu
	WY6T5lPjGtTvAL8Ybx7URlNVuRHHdcVI74Qe+bx4QBUwrqvLQNw0yu2W5SAWa6b7qPn2jwefsSA
	J7kmZ04X9QsNSsVrOiKifnOSiYD0=
X-Gm-Gg: ASbGncvicopHUxjWutfV5Tp3XvqaxH40EChyU3couflr2GLJBxq3VDhyHx5ozIxs21Z
	PL5NqiEi28w8eu6v8q5byZj/50zlot5AjfwlDa8Z+StayNzlroL4RViD84GJQlZkrVD86Miy54w
	==
X-Google-Smtp-Source: AGHT+IGp1YX/C7wUL2w/hbQEIMyIpKqLWwYKkh80rJxbmnRkhytjom/CeUJs3l44pnaCNarIHAF0ds5LNTtIeMKwxa4=
X-Received: by 2002:a17:907:1c0e:b0:abb:e048:4f5e with SMTP id
 a640c23a62f3a-abc0b14d715mr75893066b.29.1740088150181; Thu, 20 Feb 2025
 13:49:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250220111606.138045-1-jirislaby@kernel.org> <20250220111606.138045-21-jirislaby@kernel.org>
In-Reply-To: <20250220111606.138045-21-jirislaby@kernel.org>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Thu, 20 Feb 2025 22:48:59 +0100
X-Gm-Features: AWEUYZlVB8Ilmwmyppyz3eSnc_9QchXf_BwskO6erv4yNirl5dmVaFDLRF_6T_E
Message-ID: <CA+=Fv5RadC05i29h_geUq3Moyn3hGydoRu335T-q9vnfcwZqew@mail.gmail.com>
Subject: Re: [PATCH 20/29] tty: srmcons: fix retval from srmcons_init()
To: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Cc: gregkh@linuxfoundation.org, linux-serial@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Richard Henderson <richard.henderson@linaro.org>, Matt Turner <mattst88@gmail.com>, 
	linux-alpha@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I've applied and verified this patch on an Alphaserver ES40 with
serial console.

Regarding the future use of label err_free_drv, is the intention to
use it to break out early if tty_alloc_driver() fails?


Tested-by: Magnus Lindholm <linmag7@gmail.com>




On Thu, Feb 20, 2025 at 12:22=E2=80=AFPM Jiri Slaby (SUSE) <jirislaby@kerne=
l.org> wrote:
>
> The value returned from srmcons_init() was -ENODEV for over 2 decades.
> But it does not matter, given device_initcall() ignores retvals.
>
> But to be honest, return 0 in case the tty driver was registered
> properly.
>
> To do that, the condition is inverted and a short path taken in case of
> error.
>
> err_free_drv is introduced as it will be used from more places later.
>
> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
> Cc: Richard Henderson <richard.henderson@linaro.org>
> Cc: Matt Turner <mattst88@gmail.com>
> Cc: linux-alpha@vger.kernel.org
> ---
>  arch/alpha/kernel/srmcons.c | 62 ++++++++++++++++++++-----------------
>  1 file changed, 33 insertions(+), 29 deletions(-)
>
> diff --git a/arch/alpha/kernel/srmcons.c b/arch/alpha/kernel/srmcons.c
> index 3e61073f4b30..b9cd364e814e 100644
> --- a/arch/alpha/kernel/srmcons.c
> +++ b/arch/alpha/kernel/srmcons.c
> @@ -196,40 +196,44 @@ static const struct tty_operations srmcons_ops =3D =
{
>  static int __init
>  srmcons_init(void)
>  {
> +       struct tty_driver *driver;
> +       int err;
> +
>         timer_setup(&srmcons_singleton.timer, srmcons_receive_chars, 0);
> -       if (srm_is_registered_console) {
> -               struct tty_driver *driver;
> -               int err;
> -
> -               driver =3D tty_alloc_driver(MAX_SRM_CONSOLE_DEVICES, 0);
> -               if (IS_ERR(driver))
> -                       return PTR_ERR(driver);
> -
> -               tty_port_init(&srmcons_singleton.port);
> -
> -               driver->driver_name =3D "srm";
> -               driver->name =3D "srm";
> -               driver->major =3D 0;      /* dynamic */
> -               driver->minor_start =3D 0;
> -               driver->type =3D TTY_DRIVER_TYPE_SYSTEM;
> -               driver->subtype =3D SYSTEM_TYPE_SYSCONS;
> -               driver->init_termios =3D tty_std_termios;
> -               tty_set_operations(driver, &srmcons_ops);
> -               tty_port_link_device(&srmcons_singleton.port, driver, 0);
> -               err =3D tty_register_driver(driver);
> -               if (err) {
> -                       tty_driver_kref_put(driver);
> -                       tty_port_destroy(&srmcons_singleton.port);
> -                       return err;
> -               }
> -               srmcons_driver =3D driver;
> -       }
>
> -       return -ENODEV;
> +       if (!srm_is_registered_console)
> +               return -ENODEV;
> +
> +       driver =3D tty_alloc_driver(MAX_SRM_CONSOLE_DEVICES, 0);
> +       if (IS_ERR(driver))
> +               return PTR_ERR(driver);
> +
> +       tty_port_init(&srmcons_singleton.port);
> +
> +       driver->driver_name =3D "srm";
> +       driver->name =3D "srm";
> +       driver->major =3D 0;      /* dynamic */
> +       driver->minor_start =3D 0;
> +       driver->type =3D TTY_DRIVER_TYPE_SYSTEM;
> +       driver->subtype =3D SYSTEM_TYPE_SYSCONS;
> +       driver->init_termios =3D tty_std_termios;
> +       tty_set_operations(driver, &srmcons_ops);
> +       tty_port_link_device(&srmcons_singleton.port, driver, 0);
> +       err =3D tty_register_driver(driver);
> +       if (err)
> +               goto err_free_drv;
> +
> +       srmcons_driver =3D driver;
> +
> +       return 0;
> +err_free_drv:
> +       tty_driver_kref_put(driver);
> +       tty_port_destroy(&srmcons_singleton.port);
> +
> +       return err;
>  }
>  device_initcall(srmcons_init);
>
> -
>  /*
>   * The console driver
>   */
> --
> 2.48.1
>
>
