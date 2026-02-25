Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF358394462
	for <linux-serial@vger.kernel.org>; Wed, 25 Feb 2026 11:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772019362; cv=none; b=TrPi/UvmabMvDayyCNYbxmS3wzD5MqVQq2/QVQ/ZbecgRb3iPqZrta5Xy/QCzbDHdKJPKk6ll/Tn/vYO8gpNotjKeJwLKRV2+f1d/prM/tHiEJ6vfxTtcr/5hHFPD0960fap4a9wVHuNGYz/P18KiWfHtmTJz2OXclPNOmGkgd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772019362; c=relaxed/simple;
	bh=z0z9fbVGWha/WaK5/eGCrGsLT91GO3j2+zSBMQRWJXM=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TxXEP+HIdLrSU2G3WIJXA6nmR4pMOfGSiitR22uyjDA3FfVo5tScNRYvltXyDcpCVY28c+UmMd13I/IG8riF4WXpCSPieh4l24DuaW3l2mWBar7+ECEVHgz4jtMNL/0REqVkG5TvFZEE8Kz5jqQkkDa853xJm8odmv2VOOZ0jHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=zliSyNW7; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="zliSyNW7"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-483487335c2so58901895e9.2
        for <linux-serial@vger.kernel.org>; Wed, 25 Feb 2026 03:35:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1772019356; x=1772624156; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:organization
         :references:in-reply-to:date:to:from:subject:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z0z9fbVGWha/WaK5/eGCrGsLT91GO3j2+zSBMQRWJXM=;
        b=zliSyNW73BsEhKT51PO+TK6XmASUXiZ2aAnkaHzfTB7Vq+ttRApNvsk15Tx4HQgbUN
         Z4OfnyBnPpElOpEcaXGalO0k30G+negA6IvDH/fwUdoSryI9STLHWzZJFkOwQAUwkrj+
         Hbth9zrCzgnMREXj/pTTYuRPoYoCj4xyUpAPCZaPmBHOTe8zH/MC6IlU0kgcWQGkY7IU
         ytVf++9SRh/tgkLVau9QcdDA8GNNYg1xhJTvay3ONLEzKnB/xw7kOeWPT6hvyoGALgQG
         bOQAajP+5OLF0tZ57eoSJ3JQH5OK7Y3KtX0U5btx+YBuC1x9EJ5mkJ5y4eeE5zAGx6OA
         crrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772019356; x=1772624156;
        h=mime-version:user-agent:content-transfer-encoding:organization
         :references:in-reply-to:date:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z0z9fbVGWha/WaK5/eGCrGsLT91GO3j2+zSBMQRWJXM=;
        b=rCm7xIrq12dJwcxLR2hABQu7Rg4S5jH7gtPVgY/Xe0mp52ofPJldVmLrZ+kMyIC87M
         uD23zH+JqOZUnQZKPIh0OYmJBTT8HgVTLc/fbv2UyVt483p9YWlxXFUfaVFlq0/JSyeC
         hcYGeZ2z1gYbZgqR/hM4dlin6GF2q0PGToRIjxc1NzBTvQAPzw4bTAxf71DR7CqSfOFV
         iZ1dt9qaVRW+NZ2aI1bLabMaIX68h2xmvETJufC7aIUxkrxgFn9XcTJMYT+YxQP/lcPX
         PxTjMPN2yDEJsTdSyQ9FvS8q9UmvNzWyy1uMPUS3LPvfL5eFLSZMgOAKelB0PBxnue2o
         4Lfw==
X-Forwarded-Encrypted: i=1; AJvYcCVX3OPftJ4f5M2ZBaQIdOjsj22Mf5ObqT9POlqonSij6iHlFkRF/GnUk2Fj4/F1VZb5lXtaAjKdZ+IaWbo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbUeBmCaTRiq6oGCaxN+sMnwC8KtyrjwjAnHyDZLKZQFmpduXM
	DsWDhW5TT9XaC69ypU9R1XnRxkzgt5PGY30QbKQW/iRuCGXwvFt38/MSNM9/b45ceuE=
X-Gm-Gg: ATEYQzyVUD531QfzsdktdPBGk1CeOJPzSnQBXDm8z+8Zd7qYn4Weu8ACq1lvivmL3Ad
	gjTsxoIwEtutV0Vi/fPaVzr9y9Nr8h/xeQMlBvdLshFkO8o337Zvg7ojDiTFwla2mvaXui08Ndc
	1HaR2/H1XGPmMHUdNl1JW551WSZi44bbCOXvOth17qVn//XsiLWiUzUWHeKvEZ435e8lXZmgS6s
	M0IJ6Pt5kE9rexRAsRR472lcx4BsGcOaEdQLvHsZnX44x0YQzHmOSTXGj5FGmNetgU1sJRZL+Y5
	cFw0mcS9KHvyQeB6ybJD2xZpL669SHdf1WO9yElGaFb/V+T5V+zy13l51MXqvDoa5Z5HqDKUJWc
	74HAnR63dgTDJCKKToz2oLoe4xcGI34RdnBhVO01sPt2BJauE8paCID4ITvgzWxjRXfY09HISHV
	Gt8WokF+kJ7mV50EdxNUAPTA0wHg==
X-Received: by 2002:a05:600c:1c22:b0:483:79ad:f3b9 with SMTP id 5b1f17b1804b1-483a95eada4mr268490645e9.28.1772019355786;
        Wed, 25 Feb 2026 03:35:55 -0800 (PST)
Received: from [10.203.83.19] ([151.35.220.155])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43986aa2f84sm11012467f8f.7.2026.02.25.03.35.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 03:35:55 -0800 (PST)
Message-ID: <c850b374071b694e4c33ca091d124c0e90df02e1.camel@baylibre.com>
Subject: Re: [PATCH] serial: tegra: remove Kconfig dependency on APB DMA
 controller
From: Francesco Lavra <flavra@baylibre.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby
 <jirislaby@kernel.org>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>,  Kartik Rajput <kkartik@nvidia.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>, Wolfram Sang
 <wsa+renesas@sang-engineering.com>, Robert Marko <robert.marko@sartura.hr>,
  Thierry Bultel <thierry.bultel.yh@bp.renesas.com>, Douglas Anderson
 <dianders@chromium.org>,  linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org
Date: Wed, 25 Feb 2026 12:35:53 +0100
In-Reply-To: <20251126090759.4042709-1-flavra@baylibre.com>
References: <20251126090759.4042709-1-flavra@baylibre.com>
Organization: BayLibre
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Friendly ping

On Wed, 2025-11-26 at 10:07 +0100, Francesco Lavra wrote:
> This driver runs also on SoCs without a Tegra20 APB DMA controller (e.g.
> Tegra234).
> Remove the Kconfig dependency on TEGRA20_APB_DMA, and remove reference to
> the APB DMA controller from the Kconfig help text.
>=20
> Fixes: 60d2016a5161 ("arm64: tegra: Add Tegra234 GPCDMA device tree
> node")
> Signed-off-by: Francesco Lavra <flavra@baylibre.com>
> ---
> =C2=A0drivers/tty/serial/Kconfig | 5 ++---
> =C2=A01 file changed, 2 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
> index 44427415a80d..6212a814fdb7 100644
> --- a/drivers/tty/serial/Kconfig
> +++ b/drivers/tty/serial/Kconfig
> @@ -255,14 +255,13 @@ config SERIAL_SAMSUNG_CONSOLE
> =C2=A0
> =C2=A0config SERIAL_TEGRA
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0tristate "NVIDIA Tegra20/=
30 SoC serial controller"
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0depends on (ARCH_TEGRA && TEGR=
A20_APB_DMA) || COMPILE_TEST
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0depends on ARCH_TEGRA || COMPI=
LE_TEST
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0select SERIAL_CORE
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0help
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Support for the on=
-chip UARTs on the NVIDIA Tegra series SOCs
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 providing /dev/tty=
THS0, 1, 2, 3 and 4 (note, some machines may
> not
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 provide all of the=
se ports, depending on how the serial port
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 are enabled). This driv=
er uses the APB DMA to achieve higher
> baudrate
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 and better performance.
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 are enabled).
> =C2=A0
> =C2=A0config SERIAL_TEGRA_TCU
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0tristate "NVIDIA Tegra Co=
mbined UART"

