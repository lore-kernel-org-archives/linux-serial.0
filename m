Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B76CD1CD03
	for <linux-serial@vger.kernel.org>; Tue, 16 Jan 2024 17:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705427415; cv=none; b=czZHpb6wJVTc6blVzfuAzNowuakOa1PjM2BCFKDXjdZHarbV+VX7tiqzL8gch8UDX+mpJNhj6eqYVquB6Hucg5YDJMsAPBSMVejJhTvsx2US18wk+Hy6XxjiKTiIiw3ybGX6UzTMp1bHdmSr7rSdSzy8aTWVwvH+dRmEGSVjU0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705427415; c=relaxed/simple;
	bh=QR+De36hMUhgSQ2eyKizgxPqkaeTMpzOr0ptVuPSei0=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=Oo1Hr4ysqUYUK0cEC4uEELxvBwQg6FDmV4UeocbpNkZBFyE5LXZxJyvAtstjKehYt42oi/XYzQINycsl6mUKSd6BRSgR+OZGIrXvyfJvix3dy93SfZM5pmUMgU3K+0lKa4XeV7HRUkZvhhZC3w/OkB3SVfhl3PSZ0of1NF2q3O4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=o8WBcgDp; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o8WBcgDp"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6d9b37f4804so6632430b3a.1
        for <linux-serial@vger.kernel.org>; Tue, 16 Jan 2024 09:50:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705427413; x=1706032213; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DL1DJaWW+xNF6zlPfuF6H2bCuPWljxQzZ1FlAtjMl8s=;
        b=o8WBcgDphdQVPDencFrPoeTUgjfRNCI2ReNdlMvTUuB2h7uNIF5rFkn7GyBpLeGlI/
         T6kNWywcPSdu7MRfEKPa0EowlDx5nGkYF8iZbfA8yufKE+LbfX7xJUKiYOitWJ9ZFNqP
         B90H2VWxL+3IZGlYxPtneCicnjf3VwGGZ7HGMfwcp7coXSyY4FdRylDXU7UE1/kqpl3O
         nR/UY+TiLMeJIWHEVoVcfOCr/2Pm9IL4DCZComL045MDPuHwiWHrBJaPJtMR+7gXOF8f
         zwtYQYMwq7NgfJjxcvzmh+K1HgyS7APslzDAAbNucHxjAI+gtajrDBWZ3xZ65p94YXii
         lgdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705427413; x=1706032213;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DL1DJaWW+xNF6zlPfuF6H2bCuPWljxQzZ1FlAtjMl8s=;
        b=edVoSZ6dtfGSvB7jkNSx1kmfFLoQUSCU9T7DjsPnIb0s9AXjjOKpIeqWjzpFlaWItj
         fOB8GEoVrKQQI+Glv91Xa9sBsFT46XcMU4VVx82IFKE2pWvCflvQe8txwgQFcLZOoCET
         dDtdom08h6FZuY/niY/rgHiIE8qkD055yJb9gmNg/sX19WU9fbLaOK91+/cLA+klQipP
         JA8TnMojr+W1XBL+8qNnOQTNBab0m0U34dtziTxDfKtSJFGWRdOUiaHLxOjMguUeMJCB
         cBatgOvUYusnqiyTt+QKU69NezteFEZee7sGiLFvdoSgiWaKb8dv3Gb+HjBKdPVWHKKL
         mkEA==
X-Gm-Message-State: AOJu0Yy0t3jgH9z1SkyCICjhhLdyeyVCealEi1w7iFFctp2vJEZx4RsP
	BWi3qV4fGl1LSaFW9HMzbWfwgQW+PKLitTCo2ZN0ETzn2ur4zg==
X-Google-Smtp-Source: AGHT+IEYLcIEDsdKmCMS1/QF36ffXPkbxUDb2/EeTHYx/6fg0PkvAErgToGh1QU5gMt2zador0RjSSwzx0s9p3kgOgQ=
X-Received: by 2002:a05:6a20:1194:b0:199:ae11:d2dd with SMTP id
 v20-20020a056a20119400b00199ae11d2ddmr7994438pze.1.1705427413090; Tue, 16 Jan
 2024 09:50:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240109125814.3691033-1-tudor.ambarus@linaro.org> <20240109125814.3691033-5-tudor.ambarus@linaro.org>
In-Reply-To: <20240109125814.3691033-5-tudor.ambarus@linaro.org>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Tue, 16 Jan 2024 11:50:02 -0600
Message-ID: <CAPLW+4m-2fdBL4N1DmHzg4rrGbdJEOj8LqFA7DYvf4-uc=Gu-g@mail.gmail.com>
Subject: Re: [PATCH v3 04/12] tty: serial: samsung: prepare for different IO types
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

On Tue, Jan 9, 2024 at 6:59=E2=80=AFAM Tudor Ambarus <tudor.ambarus@linaro.=
org> wrote:
>
> GS101's Connectivity Peripheral blocks (peric0/1 blocks) which
> include the I3C and USI (I2C, SPI, UART) only allow 32-bit
> register accesses. If using 8-bit register accesses, a SError
> Interrupt is raised causing the system unusable.
>
> Instead of specifying the reg-io-width =3D 4 everywhere, for each node,
> the requirement should be deduced from the compatible.
>
> Prepare the samsung tty driver to allow IO types different than
> UPIO_MEM. ``struct uart_port::iotype`` is an unsigned char where all
> its 8 bits are exposed to uapi. We can't make NULL checks on it to
> verify if it's set, thus always set it from the driver's data.
> Use u8 for the ``iotype`` member of ``struct s3c24xx_uart_info`` to
> emphasize that the iotype is an 8 bit mask.
>
> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> ---

Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>

> v3:
> - reposition the ``iotype`` member of ``struct s3c24xx_uart_info`` so
>   that we reduce the struct's memory footprint.
> - change ``iotype`` to u8 to emphasize that it's a 8 bit mask and update
>   the commit message explaining why.
> v2: new patch
>
>  drivers/tty/serial/samsung_tty.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsun=
g_tty.c
> index 66bd6c090ace..ff646cddd3f8 100644
> --- a/drivers/tty/serial/samsung_tty.c
> +++ b/drivers/tty/serial/samsung_tty.c
> @@ -84,6 +84,7 @@ struct s3c24xx_uart_info {
>         unsigned long           clksel_mask;
>         unsigned long           clksel_shift;
>         unsigned long           ucon_mask;
> +       u8                      iotype;
>
>         /* uart port features */
>
> @@ -1742,7 +1743,6 @@ static void s3c24xx_serial_init_port_default(int in=
dex) {
>
>         spin_lock_init(&port->lock);
>
> -       port->iotype =3D UPIO_MEM;
>         port->uartclk =3D 0;
>         port->fifosize =3D 16;
>         port->flags =3D UPF_BOOT_AUTOCONF;
> @@ -1989,6 +1989,8 @@ static int s3c24xx_serial_probe(struct platform_dev=
ice *pdev)
>                 break;
>         }
>
> +       ourport->port.iotype =3D ourport->info->iotype;
> +
>         if (np) {
>                 of_property_read_u32(np,
>                         "samsung,uart-fifosize", &ourport->port.fifosize)=
;
> @@ -2401,6 +2403,7 @@ static const struct s3c24xx_serial_drv_data s3c6400=
_serial_drv_data =3D {
>                 .name           =3D "Samsung S3C6400 UART",
>                 .type           =3D TYPE_S3C6400,
>                 .port_type      =3D PORT_S3C6400,
> +               .iotype         =3D UPIO_MEM,
>                 .fifosize       =3D 64,
>                 .has_divslot    =3D 1,
>                 .rx_fifomask    =3D S3C2440_UFSTAT_RXMASK,
> @@ -2430,6 +2433,7 @@ static const struct s3c24xx_serial_drv_data s5pv210=
_serial_drv_data =3D {
>                 .name           =3D "Samsung S5PV210 UART",
>                 .type           =3D TYPE_S3C6400,
>                 .port_type      =3D PORT_S3C6400,
> +               .iotype         =3D UPIO_MEM,
>                 .has_divslot    =3D 1,
>                 .rx_fifomask    =3D S5PV210_UFSTAT_RXMASK,
>                 .rx_fifoshift   =3D S5PV210_UFSTAT_RXSHIFT,
> @@ -2459,6 +2463,7 @@ static const struct s3c24xx_serial_drv_data s5pv210=
_serial_drv_data =3D {
>                 .name           =3D "Samsung Exynos UART",        \
>                 .type           =3D TYPE_S3C6400,                 \
>                 .port_type      =3D PORT_S3C6400,                 \
> +               .iotype         =3D UPIO_MEM,                     \
>                 .has_divslot    =3D 1,                            \
>                 .rx_fifomask    =3D S5PV210_UFSTAT_RXMASK,        \
>                 .rx_fifoshift   =3D S5PV210_UFSTAT_RXSHIFT,       \
> @@ -2519,6 +2524,7 @@ static const struct s3c24xx_serial_drv_data s5l_ser=
ial_drv_data =3D {
>                 .name           =3D "Apple S5L UART",
>                 .type           =3D TYPE_APPLE_S5L,
>                 .port_type      =3D PORT_8250,
> +               .iotype         =3D UPIO_MEM,
>                 .fifosize       =3D 16,
>                 .rx_fifomask    =3D S3C2410_UFSTAT_RXMASK,
>                 .rx_fifoshift   =3D S3C2410_UFSTAT_RXSHIFT,
> @@ -2548,6 +2554,7 @@ static const struct s3c24xx_serial_drv_data artpec8=
_serial_drv_data =3D {
>                 .name           =3D "Axis ARTPEC-8 UART",
>                 .type           =3D TYPE_S3C6400,
>                 .port_type      =3D PORT_S3C6400,
> +               .iotype         =3D UPIO_MEM,
>                 .fifosize       =3D 64,
>                 .has_divslot    =3D 1,
>                 .rx_fifomask    =3D S5PV210_UFSTAT_RXMASK,
> --
> 2.43.0.472.g3155946c3a-goog
>
>
