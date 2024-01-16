Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D93C1CF8A
	for <linux-serial@vger.kernel.org>; Tue, 16 Jan 2024 18:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705429093; cv=none; b=FdcKkyFAqGdOJErM4jmjuEY7ZEAqe+puaDSEe4tqrk4n9e4cIj17SpM4sS8/IdBgLPtdy6Lgh5bi2ifEoiMcahQxaf6WfZ07AD5CTOnbAM/6i7l449cxBhvUxnHie/Peb5a39cxTzQ/2l0RXGGNDuBw7rLrB1Psxv3p8rKNjO6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705429093; c=relaxed/simple;
	bh=gKTkgQrZ49Y9ypGVnL4BuMEuKgsHCL1mmdyBQRQ7TyM=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=VfVLr+4gn/R1W1316LS5HPnAlweVWHT+g0N3/zmDqPI9xI0kDaEiN97z4R6Glv/2RhN9hTQpHboVAXZYcreeTi7K5m55rS7YMI0qPmVUmwwHa0kuOHdtmwAV5Pz6zNloSwghfiEn1Tl5MKJo1TNhfFQm8K0krnyqahpWzNlY3Ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zRp7oB14; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zRp7oB14"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-28e8c930c01so266791a91.0
        for <linux-serial@vger.kernel.org>; Tue, 16 Jan 2024 10:18:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705429091; x=1706033891; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nJooin9XTx4g3x3a9c7SBIxC9eNa2n9cCWHm63C9sSo=;
        b=zRp7oB147QO+I2o3hq79h6wka3bcgMLkOSALgvFUpwnMywOFBP5kJPBEUC8PhpRXtA
         KXiHqlvjR7vwXpd1xUvrsuJDsrw15v9nREGTbhv8LueGrYT7oam/uGLX5WimynX/F64h
         1szairMFRms95dn9HP0UvQqPBZ7T3h6iMevoUt0AQUrM0D1JI240LeEGd+x6Ekqxrmdt
         8SUYJWtYGNoSKs/YiLkTSsgDtBIplMQDJXA5217B7dHjfu5pMolmNVxPSJ/6YJFZkdSM
         2wPCuBXEI+ekkwEbd9gxv9SA9eWdlzdeByBVwDjdmaET7tzcN0uCts/YS3hR3kydEWKH
         lyNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705429091; x=1706033891;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nJooin9XTx4g3x3a9c7SBIxC9eNa2n9cCWHm63C9sSo=;
        b=VBhWcOA+qSvpdU3g0d35wXQxjC2lxyIsadbDV1cNcXdj7XTk5Lk7oq7SYOpSJNriv9
         WVLG2J0blTFo6tSfBOoEmEpiDQ1XQYO48Bn1ZQaaa5hilR+Vp3I/xX6b9MwVScQDAdZa
         aBut1kd2mY0IxoHb3bxBN6j284Suz5MFLs5MXu2nWzaHTaNcUNBek+cmnKkGZl18wFZC
         7SErLutfyro62CaF3K6k20bdTAj416K85CExrHQ5m0xlW47BzuhQVx+6P4wRLnFVrNz2
         Sqz6hd6i27GVee7zcP6zPTiGHk7JBedCDeKMpZnig4P1THxwLpSRQ9/7FfQR37NA6DKb
         dsTA==
X-Gm-Message-State: AOJu0YxsIu2cPPRM9rRP6jXBaiajjLKI2VlzDzobX/P+UCLR/MIt5iea
	QlU5Ox7Ho0Vrdfug/Ygby5aiXa78eNn72t+Hkz4Ljy6mQDSyzg==
X-Google-Smtp-Source: AGHT+IGSVRpaZ7py0aGDcXqUGB1wR1pdRNGkrbP520E/PLnsPPWJZ6RT2l0QCqMxgJNKCi+AWA26QY6IY55+lhtrXOA=
X-Received: by 2002:a17:90a:6586:b0:28c:4a6:2190 with SMTP id
 k6-20020a17090a658600b0028c04a62190mr4488921pjj.10.1705429091652; Tue, 16 Jan
 2024 10:18:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240110102102.61587-1-tudor.ambarus@linaro.org> <20240110102102.61587-9-tudor.ambarus@linaro.org>
In-Reply-To: <20240110102102.61587-9-tudor.ambarus@linaro.org>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Tue, 16 Jan 2024 12:18:00 -0600
Message-ID: <CAPLW+4=yQYQvMKuMX68_kmCtV8C_EUD2a1UHQBCpg4x186FtaA@mail.gmail.com>
Subject: Re: [PATCH 08/18] tty: serial: samsung: move open brace '{' on the
 next line
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: krzysztof.kozlowski@linaro.org, alim.akhtar@samsung.com, 
	gregkh@linuxfoundation.org, jirislaby@kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	andre.draszik@linaro.org, peter.griffin@linaro.org, kernel-team@android.com, 
	willmcvicker@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 10, 2024 at 4:23=E2=80=AFAM Tudor Ambarus <tudor.ambarus@linaro=
.org> wrote:
>
> Move open brace '{' following function definition on the next line.
>
> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> ---

Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>

>  drivers/tty/serial/samsung_tty.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsun=
g_tty.c
> index 11ae3a1dcdc3..b9d1ef67468c 100644
> --- a/drivers/tty/serial/samsung_tty.c
> +++ b/drivers/tty/serial/samsung_tty.c
> @@ -1740,7 +1740,8 @@ static struct uart_driver s3c24xx_uart_drv =3D {
>
>  static struct s3c24xx_uart_port s3c24xx_serial_ports[UART_NR];
>
> -static void s3c24xx_serial_init_port_default(int index) {
> +static void s3c24xx_serial_init_port_default(int index)
> +{
>         struct uart_port *port =3D &s3c24xx_serial_ports[index].port;
>
>         spin_lock_init(&port->lock);
> --
> 2.43.0.472.g3155946c3a-goog
>
>
