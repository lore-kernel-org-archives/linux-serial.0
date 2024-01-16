Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30CE91CF89
	for <linux-serial@vger.kernel.org>; Tue, 16 Jan 2024 18:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705431299; cv=none; b=pYQzcRV6LVcVnqN2otgmrnpRgPjCoZojQc9EAmth3oCT6mYTXLV7rEkp1mEmQJZsIeQI7kwCmyq5Xs9EBXE/rK3QTPyw6zfkio9dTFAvUpBB9nu4tHwVO8LBVRjL7Umw/fgdmaqCZJPfQS/FKWNeYQe8Bx3mP/izXdF4/YbjeIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705431299; c=relaxed/simple;
	bh=AcaArvIGHBhawjXJC5ECINtq4Y4+SY0odW2qhBtPErc=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=LKbsoz478apmflYT5/FT3AsxCJ1bWFSaEtE17WPS0XkZsEvPjG06a/C1Q09+YTENl5VGMMHkIDDOnPvshhBFGQQ0WjMJndujngc9jw0epdV+kGwmpOH+I6On+IJJwdxy2QTWSGclF+mRgiZq20P01v2LMQbIBVLEljX6xwrJwCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LPW1C0Gj; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LPW1C0Gj"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-28b6218d102so8285994a91.0
        for <linux-serial@vger.kernel.org>; Tue, 16 Jan 2024 10:54:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705431296; x=1706036096; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SKWI3GBw8XVmkGMp4kp5cBnwP168mn/eNzlkwz0VmsY=;
        b=LPW1C0GjQTtRBXCTSL8vE54wbRZcUF2FCm90doXtgvTocIfBhx8nuai4B2e+JaoUZL
         3OpOvfyQD+yHxNDECrJ2fNg0i8uzvC0tkdgyO6AEhyyqitrWIqNcsNi0ChuGhR98poom
         5CMy4AkPP8fCMU3EJ1lNmKVpObw0D3i5pquVN4/ZznWjccaxss7lCadAA6tRrYOJvxHA
         CmKf6mqWGhPTuVb+fOLJDZYGIaLWwIHf7jQuxoRDY8NzmRGbS1lzCEfGbMYQj5EHias3
         C+e4xhI/zZmERz0G2RXhGEkJJszvKQ4iluCoFTWBdQ2dDEAaZjYEwY22dcCpSSOQoFWx
         /Zng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705431296; x=1706036096;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SKWI3GBw8XVmkGMp4kp5cBnwP168mn/eNzlkwz0VmsY=;
        b=KAqCFAS846qWXQZPyR85/b5TWvW4AxZ1+iNaJKalzLGzlnugR65lhlp88zxfgpuiHF
         zRj1FJrxHwbhbFNjnh/k79Kl3ZQzcCHKdCxpp6epHnbysqyiFIixhgw1q2PyZ3kcRPzV
         vlBaajZkJ0/FfgbuBOkCcKlmY4y3RjHpmAVyFpithr0QDVXKI38oiqlIGjR2WSilMfJc
         L/luxeMVyHesRISxC8Jzd6ctWt1mTWdBdUqqJPTzfcTseMfcOr9AeAcQq3QEx3Ap1lwW
         eb2raXRqJVx7gzZwNLVlj6t/2FBzpkQ811nRkJAuKbyFlnQGbODpm2j8mBpVccpeh1kq
         eCOg==
X-Gm-Message-State: AOJu0YzYsSlTBrh+/JaAVOXk8wU7B75t9jmo6clmdbv/oJEmnek8pRBH
	hlZjsA14A6R8YUqYmYPieVjaYxAloIp91Yf1ligs/txemCed1w==
X-Google-Smtp-Source: AGHT+IEFtoFGlnGt6DKWSN181qFbFfM7zhz4boriHOhF5W2AqSgVEM830AlQr0zgGUviJ0so7F2IEofXyY64Nwjuneo=
X-Received: by 2002:a17:90a:3484:b0:28e:79a4:979c with SMTP id
 p4-20020a17090a348400b0028e79a4979cmr982068pjb.58.1705431296571; Tue, 16 Jan
 2024 10:54:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240110102102.61587-1-tudor.ambarus@linaro.org> <20240110102102.61587-15-tudor.ambarus@linaro.org>
In-Reply-To: <20240110102102.61587-15-tudor.ambarus@linaro.org>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Tue, 16 Jan 2024 12:54:45 -0600
Message-ID: <CAPLW+4=O2OaDsC7KNeLPt4UC-OLjD3_VVL1xL6PnrOBPUmcDrw@mail.gmail.com>
Subject: Re: [PATCH 14/18] tty: serial: samsung: return bool for s3c24xx_serial_console_txrdy()
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: krzysztof.kozlowski@linaro.org, alim.akhtar@samsung.com, 
	gregkh@linuxfoundation.org, jirislaby@kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	andre.draszik@linaro.org, peter.griffin@linaro.org, kernel-team@android.com, 
	willmcvicker@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 10, 2024 at 4:25=E2=80=AFAM Tudor Ambarus <tudor.ambarus@linaro=
.org> wrote:
>
> s3c24xx_serial_console_txrdy() returned just 0 or 1 to indicate whether
> the TX is empty or not. Change its return type to bool.
>
> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> ---
>  drivers/tty/serial/samsung_tty.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsun=
g_tty.c
> index 63e993bed296..37c0ba2a122c 100644
> --- a/drivers/tty/serial/samsung_tty.c
> +++ b/drivers/tty/serial/samsung_tty.c
> @@ -2183,7 +2183,7 @@ static const struct dev_pm_ops s3c24xx_serial_pm_op=
s =3D {
>
>  static struct uart_port *cons_uart;
>
> -static int
> +static bool
>  s3c24xx_serial_console_txrdy(struct uart_port *port, u32 ufcon)
>  {
>         const struct s3c24xx_uart_info *info =3D s3c24xx_port_to_info(por=
t);
> @@ -2193,13 +2193,13 @@ s3c24xx_serial_console_txrdy(struct uart_port *po=
rt, u32 ufcon)
>                 /* fifo mode - check amount of data in fifo registers... =
*/
>
>                 ufstat =3D rd_regl(port, S3C2410_UFSTAT);
> -               return (ufstat & info->tx_fifofull) ? 0 : 1;
> +               return !(ufstat & info->tx_fifofull);
>         }
>
>         /* in non-fifo mode, we go and use the tx buffer empty */
>
>         utrstat =3D rd_regl(port, S3C2410_UTRSTAT);
> -       return (utrstat & S3C2410_UTRSTAT_TXE) ? 1 : 0;
> +       return !!(utrstat & S3C2410_UTRSTAT_TXE);

Again, personally I think !! is just clutters the code here, as the
function already returns bool. Other than that:

Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>

>  }
>
>  static bool
> --
> 2.43.0.472.g3155946c3a-goog
>
>
