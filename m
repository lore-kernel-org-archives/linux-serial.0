Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBA5536D50D
	for <linux-serial@vger.kernel.org>; Sun, 30 Nov 2025 17:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764522864; cv=none; b=m+yznny611wOHX6sYRgUHCg7Ex70YvV0t0IZ0A1HPNnO9VYmKl2t/y7fWtR95kiWtSe4oV05pOV7rWLtiYPEShP/2e5zPd64HnAhg6frj3ZymCPXcCTFDMVw/e4bUP/rAD5kBwBcAarziDDUTQixlzBF/wiSn9/jCLbtm5apYgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764522864; c=relaxed/simple;
	bh=TRxFa90oK1xYpP9RQtsFwvn/f9TYTL3cOLOCwevHsKQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r2w7tqGzlWr873XiawZGu/6IEX4Kau2ywAuYk9mn1mTxWNQbQM1d55KTRbvMseXczCWw+q9PFAlEi0T3jjAOoHW62hDHidwwYrVCUM4mAUoYTpCf+Rz617EdkVAwANgoUa/gp/pdbUu0xITjt3LYrMi/yuPNYz+108mcIJomvfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EZxlXPWm; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EZxlXPWm"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-640aa1445c3so5221321a12.1
        for <linux-serial@vger.kernel.org>; Sun, 30 Nov 2025 09:14:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764522861; x=1765127661; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l3Er6Yy7wmO0KCQ9T51C+CBpUW2Bg34SDBzEUpVxG+E=;
        b=EZxlXPWmhjW+KhxJGsVQcRDDxpbi3qDHkiSQaXUt9dXC7eltzFBVcJCts+a4jZibYa
         q2+ZE6bQpRJMtSa4D/rbKwP1CasFTWMjCuMtrRH9DOVIbD417HpqDlCpPtc8Yh17mG+Q
         MS/1HE1P22Txizo0Nbya1LzQILnoaPZam7BTM4DOVOOV8tFHQDHTpA0FlCs1GnGj1uaQ
         I+8SimaPw323bJ2QYKPnCnYPjuggHafa6PEWme0HH2pDwdtSHlxFM5Sw93ggmFT3GzgI
         G7dKY5ODTSBRmrPqcwWaCqsejmtADHsI8IFk/kMQUoa57RgKTppbt9rppL0oXcjMMddL
         TEeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764522861; x=1765127661;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=l3Er6Yy7wmO0KCQ9T51C+CBpUW2Bg34SDBzEUpVxG+E=;
        b=uxhc9QTcWlQfXotRiuTMDrcXifLmm7GgFts6ON/AKMZoDKZc3Vd5VNkuCqqphL2XgI
         S/7S2ifqBeYcX60x+paXyyXJjc2soT+JU6e4ihvYVENFs/Zt1oe74/GHXLxi3aNyvqgS
         ag65jeltPEht2WhMjvT+6sr8GWUMVV5aQFa8uShLckvNlDa0gOcNRddfO0SfJjXyHoDF
         Ipvo4toc8X7zPmklhB6V/jP5ayxmaOT7+3yXddNn8u/63osbQl4kph2Gm+V1OowogJ7u
         Y0yWGx/k3E1a+Nt8ELeIwTFwhHBXE+9mBomerfD/E9K3oeusxHO7kGHJ4aze9flpM4HT
         5zbQ==
X-Forwarded-Encrypted: i=1; AJvYcCU9yDj31W38xAzu7hfUItk57yINbbt20ycCm9BuuohWCggPJUZKR1etyTs2i16Ujw4iPBWCQgxlJ2kLjSw=@vger.kernel.org
X-Gm-Message-State: AOJu0YweBc66OrNzMgAAvRzF5w2DsFk0lN64SwxbT2Nylklk6WMKB94F
	TWsU/hO5NP0ekfy4yyE5ZJtjjp6qbfaqAMZNCJ2y1gaWCVbchxQS/5ZzRt6ic5H/iO/BQkAW+o/
	rbaaTAKyeKExrAOYsHucOP44KdVw3fI8=
X-Gm-Gg: ASbGnctxFGY9op3qLAOybsYOnPIPKV0kTJogEEO5pykMGut6kBOAacDpMzrmug4oMCq
	2kspwHa0upUb9+eEBcIkyVrRd+/3k58Ct9wXPOGKXNmAle1xBQgzzIdLd71Vx2SpHe069OsOzAb
	tcUJmvsjAWnF0OQFoNtNiPxNb8DwtKP5F44Zaag4Ld7veZ6lkcEKUK6tUeaYzpROMLVpVcYy4is
	wuztSGtWdf3++kEQX5gij9i4g6YFxwW4GoE+OJpflueJPebjrBX/q4VI51CkndrVdKZBVEzosDb
	MqCRc5nFh7H9q9TJMFtKtzMp7W7H3JDPS0/J+dbwpSs4UYTNhaR7iz2MhzGBDNHvSWDSsR1uJ3i
	91Q1I8fGrIoURc15qLw==
X-Google-Smtp-Source: AGHT+IEFFzOwd6p17DccsXxI0EQqobHxNMh9Sqotr/Sc80QChAOXc5fz5uJLkqjc+6exGRaB2HiRXO9QT+kUJ0Zou9M=
X-Received: by 2002:a17:907:3e8d:b0:b76:5393:758d with SMTP id
 a640c23a62f3a-b767170c801mr3304528066b.34.1764522860899; Sun, 30 Nov 2025
 09:14:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251130104222.63077-1-crescentcy.hsieh@moxa.com> <20251130104222.63077-4-crescentcy.hsieh@moxa.com>
In-Reply-To: <20251130104222.63077-4-crescentcy.hsieh@moxa.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sun, 30 Nov 2025 19:13:44 +0200
X-Gm-Features: AWmQ_blZ_P-lcoOA_8Z-oUYe3Gpv2C4mbhSKo6FCXTtU3oHRnfhPXUYGRJGtgek
Message-ID: <CAHp75VcN3R3PcWD7x5+8mVi48fRaUnghtT-2Bh94FcFLkQizLQ@mail.gmail.com>
Subject: Re: [PATCH v1 03/31] serial: 8250_mxupci: enable enhanced mode and
 custom FIFO trigger levels
To: Crescent Hsieh <crescentcy.hsieh@moxa.com>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org, 
	ilpo.jarvinen@linux.intel.com, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 30, 2025 at 12:43=E2=80=AFPM Crescent Hsieh
<crescentcy.hsieh@moxa.com> wrote:
>
> Add support for enabling enhanced mode and configuring custom FIFO trigge=
r
> levels on Moxa UPCI serial boards.
>
> Enhanced mode is activated via EFR, which also provides access to three
> configuration pages selected through EFR[7:6].
> These pages allow fine-tuning of advanced UART feature such as Rx/Tx

features

> interrupt trigger levels and flow control thresholds.

...

> +static int mxupci8250_startup(struct uart_port *port)
> +{
> +       struct uart_8250_port *up =3D up_to_u8250p(port);
> +       int ret;
> +       u8 efr;
> +
> +       ret =3D serial8250_do_startup(port);

This needs a very good comment on why it is okay to continue even in
error cases.

> +       serial_out(up, UART_LCR, UART_LCR_CONF_MODE_B);
> +
> +       efr =3D serial_in(up, UART_EFR);
> +       efr |=3D UART_EFR_ECB;
> +       serial_out(up, UART_EFR, efr);
> +
> +       efr &=3D ~MOXA_UART_EFR_PAGE_MASK;
> +       efr |=3D MOXA_UART_EFR_PAGE_1;
> +       serial_out(up, UART_EFR, efr);
> +
> +       serial_out(up, MOXA_UART_THRTL, 0);
> +       serial_out(up, MOXA_UART_RBRTI, 96);
> +       serial_out(up, MOXA_UART_RBRTL, 32);
> +       serial_out(up, MOXA_UART_RBRTH, 96);
> +
> +       serial_out(up, UART_LCR, up->lcr);
> +
> +       return ret;
> +}

--=20
With Best Regards,
Andy Shevchenko
