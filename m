Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 980001CD2F
	for <linux-serial@vger.kernel.org>; Tue, 16 Jan 2024 18:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705428882; cv=none; b=IMaMtwXbSauMFpEdhJ5c038lTkKSZlnY/LIYJ1J11Nasp2qLHnz6kdRXj1EIxCJrImT7FMWxOt4EaJOJ4/pM55+mkQRO8FpxRq7e+40dEnMPhLSAsOJT8hUvvRgVTUssmhCMFm85a4cHw9x+IoRXVpO08uSFoMdfkaNUZ7GLnrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705428882; c=relaxed/simple;
	bh=cv59bDCTOqRhiDC3HpONyDpPUeopXrDeTyWmM+8EkOI=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=iiMGLZZPax6CC6/Ipd/Bsfb7h98kv19FyMxllF+b6mEOVYr/hi4ys9W9W4nT7hRJ3ifxxDyYN0HO4Z/4yefBX5jf5UwkF9gICdVVuIyZmRWh4XbVGd5m3RBuADgKQY3vSaLzytkFyVidlFQJjciZpvf+6vSy/GBM1wTjT093cLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ntfNTKq8; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ntfNTKq8"
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-7bee874fcc2so362334339f.1
        for <linux-serial@vger.kernel.org>; Tue, 16 Jan 2024 10:14:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705428879; x=1706033679; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xRhLuuiIVVo+A52y6bxPnSkQ+JrLAw3wqr2sWjodaZc=;
        b=ntfNTKq8C4HxrhN7HqHgbmqQXfktwh8hmtgTA5ncDWjXGizdF3GP0fGzClzVcPySY5
         Fr/LPYZkV9MKuT7X9Ho1WvaMWPpxFEqRhWT90Sy7hmG1jl9bMpHMyWnWjyEYvOSSdOWL
         7RsivC3zzWi4FqeKBp1Fbus4EvmmfmE3Ira6cAvx5n03Mi7ocy62RMTCJHCjxRribQ2T
         RcvSJ0PxWvBqmO8FcwuvIr3ttU+VFagMYmrqyEP++o14SO2/yzy3wEuWj1wWkEpVm1EU
         paXan10Buan5kMdpRnQbVihNjLYYRVwsx6+Ihh3oMBg7fP1FX6pVxm41RiGQqlToSr72
         7SNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705428879; x=1706033679;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xRhLuuiIVVo+A52y6bxPnSkQ+JrLAw3wqr2sWjodaZc=;
        b=YndPNVegPQtNJxOHaB8tw7EYGh771YFK9tiCqFbKv5b+4dltXuoTyQ1kCNokedvVCl
         e1UnL355rFjkYqV491YiturGPVPuCTQfkWaEWb5SxKUrdk/ve7WQu20PRTryESKL0ZbN
         roEeOmLlftABSAIVyKhkQwe71Ast7l7gimjWIDNyiQUIlYFU/6jPLrO50U/NQKIs6xIG
         lWSfYmQAsNb/rvbXYYMRS3tZAMYn6zMhbT2+YNi2vZ7N8LCAPi1qMmwlV3yj7g46raDx
         z0ew2y2mBNnPldu8k2vQSFJlT71MYMy8b1AS9AuzpjbIM4YZcFSTy6U7Ad92R/UcBT8i
         c13g==
X-Gm-Message-State: AOJu0YyyaA46xK/gNzrwHtPkGpdiEoIKipcQBPt3MtMFhfSYsD9zUySR
	ZEtCKU+cmkz7654bh3/aMVUpIvGJThMnriJPGpvwQzmtcrpaTA==
X-Google-Smtp-Source: AGHT+IEfZdEKTVV73IlpY3EGlS1kPKh3DImT91Va7UPo6ctMhZS1jwa3ClSyV/+ZVIEwxJrtZw8TuE8UvHu/GnDXkQ4=
X-Received: by 2002:a05:6602:3054:b0:7be:d30c:d170 with SMTP id
 p20-20020a056602305400b007bed30cd170mr8728680ioy.34.1705428879752; Tue, 16
 Jan 2024 10:14:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240110102102.61587-1-tudor.ambarus@linaro.org> <20240110102102.61587-4-tudor.ambarus@linaro.org>
In-Reply-To: <20240110102102.61587-4-tudor.ambarus@linaro.org>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Tue, 16 Jan 2024 12:14:28 -0600
Message-ID: <CAPLW+4mY4VUm+cryBDFLp9TFkxG2oqJrmbZVuRuT5bFOzYXrnQ@mail.gmail.com>
Subject: Re: [PATCH 03/18] tty: serial: samsung: add gs101 earlycon support
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: krzysztof.kozlowski@linaro.org, alim.akhtar@samsung.com, 
	gregkh@linuxfoundation.org, jirislaby@kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	andre.draszik@linaro.org, peter.griffin@linaro.org, kernel-team@android.com, 
	willmcvicker@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 10, 2024 at 4:21=E2=80=AFAM Tudor Ambarus <tudor.ambarus@linaro=
.org> wrote:
>
> The entire bus (PERIC) on which the GS101 serial resides only allows
> 32-bit register accesses. The reg-io-width dt property is disallowed
> for the "google,gs101-uart" compatible and instead the iotype is
> inferred from the compatible. Always set UPIO_MEM32 iotype for the
> gs101 earlycon.
>
> Reviewed-by: Peter Griffin <peter.griffin@linaro.org>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> ---

Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>

>  drivers/tty/serial/samsung_tty.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsun=
g_tty.c
> index 20ec6ef1a52f..74bc5151dad4 100644
> --- a/drivers/tty/serial/samsung_tty.c
> +++ b/drivers/tty/serial/samsung_tty.c
> @@ -2810,6 +2810,17 @@ OF_EARLYCON_DECLARE(exynos4210, "samsung,exynos421=
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
