Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C9391C862D;
	Wed,  6 Aug 2025 21:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754514349; cv=none; b=uJvwcwr+aV46X+DDV1EVh1U64Q77TfXsXbcVA/C6W85WnkEa9sTfNBcoOrHdliMqURF7nXFPLiLSxhJNqIfiOk6KE9bqeRle286e/ezKlCpGP0JKFUHzJTHeRhVx9XrN+aXqR1caAqiP+/4RyMbcyMf7rBbZ/5aBhpn+B0mAbIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754514349; c=relaxed/simple;
	bh=inOXr2gxpXIuq1rhwe8J8ETm165ksxf6xYrXSkgR6Hg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hQRe+idMqFryrLykXg6VNv3cMVDBshewFOxeatiMVKfxrdr/zh4qmrFdfQxBYglSlydt6SchJggM1FlgtHT4TlLtGsW4amf82wVSskjjSMVU3/h6oZtyZ2wMrwgf06u2LykmY24sCAmmh3jcNbxhfqLy1T+INYqyoquoXWs+pcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ebAb3PKH; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ebAb3PKH"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2405c0c431cso2546395ad.1;
        Wed, 06 Aug 2025 14:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754514347; x=1755119147; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9mqLSDQG6lM86WBfEbXIj7RV4h0WuVHXNTq3ygYzF6o=;
        b=ebAb3PKHbk+ES9Ii8MuZKidIHlJ0h2XWKln7sTrsP3RtSW3ouLo5TMBiSOXixhTnDJ
         /lZmkDPIdFEwayUUht0menSkwJMqEByLN7tNpmqJ1iS577XYt61iEI/tTetLw8ZfjWvB
         WidHdo9c/cpJR0u4ycV1X8jZJPnJTZZRBZo5sckv71RsLxeYC3nKOU+VVrvagMYBV3Px
         8yeH3DRb+7B1qgaoOWoJ9rsHPs1USeILvUdF4fzrrDaZmSQcDNQ2PdlxoTpst1/BZGhL
         bssz+oMITngYR+CqmISpzmP5UwVMeubVNOFegXRnh5/TnaI9O+sAGzBW7bcjNy5XFceH
         OEtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754514347; x=1755119147;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9mqLSDQG6lM86WBfEbXIj7RV4h0WuVHXNTq3ygYzF6o=;
        b=ADv1/wmC3sF4nZsZYgba51q+dg9BorqknjGfgSVlDRBfQbZ02yTrN7PwuWAzdT96Vi
         khS3lKYmKWQMZEAWSam5Ou6KZPhVDFFGMiBxY9mF1ClPPhLUthYKZPgllUV2xlVlco8G
         IPiFUgF4iP2sbMeJujTU9fO/7L4EMc8GTCWoLjzOWRh4SUFoHHKc9CnZ1Nr8QplVtNEr
         G8YcFJNJVW12Uef66yVw3vGI61/zsrGc+qU6X3Zi6oD4DsjOCJnLDc9FbOjQh71dz98r
         HOdtiGtDYaJ7373kzQeI57mvVbP44+MbDZR7ZdWlx4hBl3fVJJOWTprQFVe1myzk9S7o
         qpsg==
X-Forwarded-Encrypted: i=1; AJvYcCUesfCuYLOTfoiHh3178UQJMANgRXhWowpSZZCOFxBThv1tH44d7cjiMukC6wdZ2er+/GLvLLQSFytzl98i@vger.kernel.org, AJvYcCUmn+Nh1xkqL3uWpUJ1rrWkzz9Cf0cXU/r2u5h25WtNphM8qAL7zS3f8bIHZcNC72tkzt8bxEAxBhs9HIY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaWjHDSLL6qyolcaf1fSn2VXuy8/qqd6VNt+w4yEx3wDy12S2s
	c7OIfdmLEXQsunStwXGQq2c2tdgriLNkPKH6bzCG7bCgeFII8cgAL7+mK/S9fECDYy9pXVGHkdQ
	HllpWaob53JN3srJXoqHjVlr6vgA4+oU=
X-Gm-Gg: ASbGnctplvWg2QRO98Qr+0+VZO0IRAB4pVcuszQ6hGMVMQxYHKsuDgqcFzAXXUMBnbA
	8aTnjsrRlmGmPeZmGb1IAVg3u9pjdrzi1wETbw8tBBfQ/60pgl+sSphbuGL+Ai4CBnXN8UxPDL8
	ZF4Hw+d2IeiYiDL+HXGxhLL5KzsZ8M973STHWTSjKSk8XKlXmxeMSlw1MFeMkCE3Vu54YQb6ZHm
	sNUdBg=
X-Google-Smtp-Source: AGHT+IGX97bzlOFvWNARro2Lk94bJ2TmsR0RtAZCjrabVOI+X+5or8c4VEDiURAc7sTFx4wmP4FpSp2zGpmTk7vswhs=
X-Received: by 2002:a17:902:f690:b0:23f:cd4d:a91a with SMTP id
 d9443c01a7336-2429f30b017mr51042875ad.30.1754514347173; Wed, 06 Aug 2025
 14:05:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250805195155.742004-1-abinashsinghlalotra@gmail.com> <f765eae4-f83e-4c25-9697-2705afd7b9b8@app.fastmail.com>
In-Reply-To: <f765eae4-f83e-4c25-9697-2705afd7b9b8@app.fastmail.com>
From: Abinash Singh <abinashsinghlalotra@gmail.com>
Date: Thu, 7 Aug 2025 02:36:24 +0530
X-Gm-Features: Ac12FXwiKjB95HCJYl0H6dPexm14JCfOzUTSqY9AD9VQx0sdO3FtNFHgJs2ofF0
Message-ID: <CAMV7Lq6ky1w5j4QJPpHh-aLTAqWUywnF2hVoOE4nesL+2HSUJA@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] tty: serial/8250: Fix build warning in serial8250_probe_acpi()
To: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Sunil V L <sunilvl@ventanamicro.com>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 6, 2025 at 12:32=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> wrote=
:
> Hi Abinash,
Hi ,Arnd

> I've seen this one as well in some configurations, thanks
> for helping out addressing it!

You are welcome ..! ,
 I have a patch accepted in that
commit : (3df63fa8f2af) dma: dw-edma: Fix build warning in dw_edma_pcie_pro=
be()

In general, using dynamic memory allocation in functions that are not in
performance-critical paths=E2=80=94like probe routines=E2=80=94is a reasona=
ble approach
to reduce large stack usage without performance penalties.

> The same problem does show up in a lot of 8250 driver variants,
> plus a couple that have it in theory but don't run into the
> 1024 byte limit:

You are absolutely right. I compiled these drivers with
"-fstack-usage" flag which generated the stack usage of each function.

> drivers/char/mwave/mwavedd.c-static int register_serial_portandirq(unsign=
ed int port, int irq)
> drivers/char/mwave/mwavedd.c-{
> drivers/char/mwave/mwavedd.c:   struct uart_8250_port uart;
>
// stack usage using -fstack-usage in bytes
drivers/char/mwave/mwavedd.c:123:13:mwave_ioctl 216 static
drivers/char/mwave/mwavedd.c:437:12:register_serial_portandirq 976 static

> drivers/ptp/ptp_ocp.c-ptp_ocp_serial_line(struct ptp_ocp *bp, struct ocp_=
resource *r)
> drivers/ptp/ptp_ocp.c-{
> drivers/ptp/ptp_ocp.c-  struct pci_dev *pdev =3D bp->pdev;
> drivers/ptp/ptp_ocp.c:  struct uart_8250_port uart;
>
// stack usage using -fstack-usage bytes
drivers/ptp/ptp_ocp.c:2273:1:ptp_ocp_serial_line.isra 984 static
drivers/ptp/ptp_ocp.c:2295:1:ptp_ocp_register_serial 32 static

similar results for other drivers mentioned.....

> In total, I see 34 drivers using this exact pattern for
> their probe function, and ideally we would to to fix them
> all to do it some other way.
>
Dynamic memory allocation is acceptable in probe functions,
as the introduced delay is minimal and these functions are
called infrequently.

> Note how serial8250_register_8250_port() ands up just copying
> individual members of the passed uart_8250_port structure into
> the global array of the same type, so one way of addressing
> this would be to use a structure for initialization that only
> contains a subset of the uart_8250_port members and can still
> be allocated on the stack, or possibly be constant.
>
This is a very good approach because it confines dynamic
memory allocation to the probe function, where it is acceptable.
In most other functions, dynamic allocation is generally not suitable.

I also reviewed a few functions and noticed that only a small number
of fields from the stack-allocated struct uart_8250_port are
actually used. Therefore, this method is well-suited for such cases.

> There is already a 'struct plat_serial8250_port', which some
> (mostly ancient) drivers use to register a 8250 compatible
> uart through the 8250_platform driver. That driver has
> a number of problems, so I don't really want to expand its
> usage, but it may be possible to use a single structure
> for both purposes.
>
To proceed, we can introduce a smaller struct containing only the
required fields.
In the probe function, the choice between dynamic allocation and using
this reduced
struct can be made based on the number of fields used in each specific scen=
ario.

Thanks.

Abinash
