Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBAC61C3C18
	for <linux-serial@vger.kernel.org>; Fri, 24 Oct 2025 01:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761270180; cv=none; b=APO5f9PrDKKQuDO0SFcNqJAdGzjPBt4t6Qx1Gj1rlBTeSo53V3a80EpeOWdm96vzho+cFMKseZooR6Vxl/95PNM97dAKASjDnQF/xwqEuXKXG+o0XFAE4JrRhzQjL0ZIrTirqlLmD/l/Fb6pSKEVCavBZx0sVOwtvrHeTOUzweM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761270180; c=relaxed/simple;
	bh=Gp2UP6WPoEHKVVhOqyaK/3ITaNQsf40VL330L1MeraI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l61xmaLbf5MG1XoacnW9p+0/A71wKVk4OtHIC3eQ0z1dO+6Ej+ZUbpfN/f0oixxE5PqcSXjwSNCSSk0MBrO/enXtcSfGgrmTCPSJ5n3Rcr0JKJYfJbC6qr8CScgxM/K54KerIwdnMr7Kro1bG9Ld2XxkS30Xt2a5lvCmDw7Ol5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UYLmSNKB; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UYLmSNKB"
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-64990f4dba2so886922eaf.1
        for <linux-serial@vger.kernel.org>; Thu, 23 Oct 2025 18:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761270178; x=1761874978; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UAbS/I/ENAzCitCydMxMmGwL+5iHoTPGPWV8yBVNDn0=;
        b=UYLmSNKBj2NbLQsPcFUuGXfinEhYfQAitTaR8e7Vzt20/C9J2PE0TpSkGo0OkmndYV
         yJ89cJSdfSmBAdWP2JPtR48FtrYt8UfI73QtGMkLGy7DsSnN16GwGAgVEWc2KdeoSSBI
         lhH4l/a9ljJ3QES/rzZMfBpoGZrpekV0DzDzH61pybyqQvc6NjhrILOX8ZVQk1ZlF513
         l5r1SoM7vCQQrfOe9E8+wo+CLgiqLI0KM7ApZsA0z2EAW//lKR8S3wFtgYKfVbFifCG+
         a3xokd57Hl8Ej90yOecXGAzrSLQmgA6ZmfskzpUFTTTo8hg3zio5/brr4QgvJ6zDHA6D
         mtkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761270178; x=1761874978;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UAbS/I/ENAzCitCydMxMmGwL+5iHoTPGPWV8yBVNDn0=;
        b=MBHYi4VXXk8OqZHW+jRXRbgSg/goDFCpauo9kSH0ROvR5P5/8OkSZlcw6YA9B/LSra
         5Woei1G3H90gDYo3mC7+5sHtwyXRG5IBqnjQzCB3sqr5SzeAG+1JCfZYCSgLWP42FfFI
         g12pKzMnU/0lOC+8Ki+RNG8KocTG9D32SHaOEjvvrbrJwXEulC+iO8AQhZGPr3ey5/7A
         rDrVMMDFDsTf+/5/TGqh1ZknlYmKRibSca81tsYqUZx9moK+Lu5ycQUAA7wWwgfaQXdC
         Hp2GVF1kLG1xmnVwD2XeqK8BNyisEgn+TdyuWQ48grDJjA1wRPrSKBEGPsV9bVnxtHZJ
         N1hw==
X-Forwarded-Encrypted: i=1; AJvYcCWH1XhKgmAOflJlP/8ymxoapc5ZRfB08wOaOcoE0nSAgrIaOPY+r8crAYhn0b5BuM7aIvfGnk1RvAa4vOk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyK2GBjzmGEWKNbNrDt/QVcjMWx7RSQvShs05rsR850CRWf24oM
	7ZniVhl6zi72hZRQGzwQYlRumLBjWGLqFBAXGtAwn/i0JcYroEqOSYT70dZrFZumLvmeQB3PZ+P
	RWYpxMEh+BsY6qJeccYuQcPvwEkIz4Qs=
X-Gm-Gg: ASbGncsjC9e0ENqMHuTfhcl2RH31QG0JUV2EWM3NtUIVo6jE9HOoMc/xLuHoMmUNdq4
	6FyX+6jpvhbwR36O1nwPAOTdt3sI1N9gtESaXoZAgBJ1CICEKFjcgtaSP2YWE6BULS6FokAv4VI
	gSXBYr8P/YGCfIYPAndbxL8VkGj7pQOnx9ujXGOpZJY/lrtl6aZCuB0JXfGlejA9V57jXJ21DOV
	XaCFawOp7g+LuRGgaP8lFYFqTvmaKqDkcDROrxaliKJlJHBxdA+A2pBw5yqkRtJ7r4vJA==
X-Google-Smtp-Source: AGHT+IFOrs3kAu333i9kjtC7Z4VNGNTt0EV9dP15noDMl6HW4uB2m9tABAka0QntVdtaXJk8/BQlYI7Rv8qX6VpdwoU=
X-Received: by 2002:a05:6870:194f:b0:3c9:77fb:dc3b with SMTP id
 586e51a60fabf-3d173332ebbmr410914fac.18.1761270177796; Thu, 23 Oct 2025
 18:42:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251022030840.956589-1-Wenhua.Lin@unisoc.com>
 <CAAfSe-uq6GszSLgtM+UBuwJ6V1Bt0_1Ard8cb6e9MMCsdpJPqw@mail.gmail.com> <CAB9BWhdKd93kJxPJv10X5uZ00O8d5NugoehX3_QtjmXQOMhDig@mail.gmail.com>
In-Reply-To: <CAB9BWhdKd93kJxPJv10X5uZ00O8d5NugoehX3_QtjmXQOMhDig@mail.gmail.com>
From: Chunyan Zhang <zhang.lyra@gmail.com>
Date: Fri, 24 Oct 2025 09:42:20 +0800
X-Gm-Features: AS18NWC32uQ6w5HtSVr1L-03d5RGkfSam7lucV4ocAv1EGY-5LX2aClPYLicTtY
Message-ID: <CAAfSe-sTUC=mW-iO+NK+mq2i8GEv1RaNPvCGgQwb23dOFBigXQ@mail.gmail.com>
Subject: Re: [PATCH] serial: sprd: Return -EPROBE_DEFER when uart clock is not ready
To: wenhua lin <wenhua.lin1994@gmail.com>
Cc: Wenhua Lin <Wenhua.Lin@unisoc.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, Orson Zhai <orsonzhai@gmail.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Cixi Geng <cixi.geng@linux.dev>, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	Xiongpeng Wu <xiongpeng.wu@unisoc.com>, Zhaochen Su <Zhaochen.Su@unisoc.com>, 
	Zhirong Qiu <Zhirong.Qiu@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Wenhua,

On Thu, 23 Oct 2025 at 10:10, wenhua lin <wenhua.lin1994@gmail.com> wrote:
>
> On Wed, Oct 22, 2025 at 2:55=E2=80=AFPM Chunyan Zhang <zhang.lyra@gmail.c=
om> wrote:
> >
> > On Wed, 22 Oct 2025 at 11:09, Wenhua Lin <Wenhua.Lin@unisoc.com> wrote:
> > >
> > > In sprd_clk_init(), when devm_clk_get() returns -EPROBE_DEFER
> > > for either uart or source clock, we should propagate the
> > > error instead of just warning and continuing with NULL clocks.
> > >
> > > Currently the driver only emits a warning when clock acquisition
> > > fails and proceeds with NULL clock pointers. This can lead to
> > > issues later when the clocks are actually needed. More importantly,
> > > when the clock provider is not ready yet and returns -EPROBE_DEFER,
> > > we should return this error to allow deferred probing.
> > >
> > > This change adds explicit checks for -EPROBE_DEFER after both:
> > > 1. devm_clk_get(uport->dev, uart)
> > > 2. devm_clk_get(uport->dev, source)
> > >
> > > When -EPROBE_DEFER is encountered, the function now returns
> > > -EPROBE_DEFER to let the driver framework retry probing
> > > later when the clock dependencies are resolved.
> > >
> > > Signed-off-by: Wenhua Lin <Wenhua.Lin@unisoc.com>
> > > ---
> > >  drivers/tty/serial/sprd_serial.c | 6 ++++++
> > >  1 file changed, 6 insertions(+)
> > >
> > > diff --git a/drivers/tty/serial/sprd_serial.c b/drivers/tty/serial/sp=
rd_serial.c
> > > index 8c9366321f8e..092755f35683 100644
> > > --- a/drivers/tty/serial/sprd_serial.c
> > > +++ b/drivers/tty/serial/sprd_serial.c
> > > @@ -1133,6 +1133,9 @@ static int sprd_clk_init(struct uart_port *upor=
t)
> > >
> > >         clk_uart =3D devm_clk_get(uport->dev, "uart");
> > >         if (IS_ERR(clk_uart)) {
> > > +               if (PTR_ERR(clk_uart) =3D=3D -EPROBE_DEFER)
> > > +                       return -EPROBE_DEFER;
> > > +
> >
> > You are making this clock mandatory, sprd_serial driver could work as
> > serial ports for logs output without this "uart" clock.
>
> Hi chunyan:
>    Thank you very much for your review.
>    This clock is actually mandatory now=EF=BC=8Csome SPRD project use def=
ault 26M clock,
>    some new SPRD project use default 24M clock.  If driver can't parse

Oh I see, then you can set a different default clock according to the
compatible string, that's saying make SPRD_DEFAULT_SOURCE_CLK to be an
element of "of_device_id.data".

Thanks,
Chunyan

> this clock correctly,
>    driver will configure wrong baudrate and make the log garbled.
>
> Thanks
>
> >
> > >                 dev_warn(uport->dev, "uart%d can't get uart clock\n",
> > >                          uport->line);
> > >                 clk_uart =3D NULL;
> > > @@ -1140,6 +1143,9 @@ static int sprd_clk_init(struct uart_port *upor=
t)
> > >
> > >         clk_parent =3D devm_clk_get(uport->dev, "source");
> > >         if (IS_ERR(clk_parent)) {
> > > +               if (PTR_ERR(clk_parent) =3D=3D -EPROBE_DEFER)
> > > +                       return -EPROBE_DEFER;
> > > +
> > >                 dev_warn(uport->dev, "uart%d can't get source clock\n=
",
> > >                          uport->line);
> > >                 clk_parent =3D NULL;
> > > --
> > > 2.34.1
> > >
