Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B04861411C3;
	Tue,  4 Jun 2024 07:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717484968; cv=none; b=FeDyQi6dtBArveAX4YbVWhXhcOK8GTr8vEZuiV+ZbRnnilrC+CavdE/TIzhHDxY/UweYqYNLwHAZdNgtOJzoVzkQh7kth50GDaYaVQNspgUlq1rot9hMF9XMmMsjPHGaIIw2lFW0z4o5pJYycaVF8heIw6RL61qgcKszR8Cl2IA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717484968; c=relaxed/simple;
	bh=A3/3UWbr7tB6Pwqmw5cQ4r6ZRN3gWJ7+oVpZNka9V2k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nMxQUMM4Sq8b8lJkjULp+GFinjGfFmzWtMsT7eDWafqRjCL0VGN8r2iycL9PjjwMnqadTCN2EQEPs78h+pfAPbP9bK7rPN2ABLBnnpNFpQQduUf10gfJuRqN+4OlF6KiHrt1iWxSbLuiw3RkGt3Mxx6XYHj5VCcpSaHjMPQP87U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-62a052f74c1so40300587b3.1;
        Tue, 04 Jun 2024 00:09:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717484965; x=1718089765;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H80MceH/Axu7a3UTONeNo9Hwh9a4GRgNTJAXzjxJWVk=;
        b=NMRDfF1ghiEXCbtYXCjzudaZyLeXkZT9CNy1A+Uvc1XhRIWjfeazyz0ztCUSV93jPs
         Xjv/202aaEYjims5WZigwrARUmcL8nR/mmSolH/Olwlv0cuwHfyAXFLX7Z05EHm8HASl
         V55Sj6ezAwVbmWN9QyOg6enQKpTmjhM91ORgLrq1vX1cVzOi+5BT87f3w2UdvDdis/En
         nxk6iAKyRByvrx1516Rg2PZYEO0iXnq36tI53KQYQtgMz50vhsBJCwaLX8DHFV8oFJli
         Fv76Z/CJk/A17z11Mgp7zGoO+yhZYS7aGGoSCmR2i4zEw+mlahWMkttWStzjvdFmkt5q
         +sTw==
X-Forwarded-Encrypted: i=1; AJvYcCUQLCqmEom90ElOb8PVaW63EbW4H/tBXM8F20F3q0WH07ZNWDNq5ZHen2tn6RRH/iz8dlff7OFJ88xsf6GF0Br+4tC4WeIh/QGiNBoj753+niQ0ahBGQdMW2rSSz/txXjZoyE+TSA/IcYhg
X-Gm-Message-State: AOJu0YwMgdPm1fZLAAD32yccCOKfy2VwdN3DxruNycvlLbf+a32vK8jW
	oRWlFQ8m1UjcYGN+JjJTIE0+a5OsYSs+8q/rmQoJxudHiQTjXLnksARUKDje
X-Google-Smtp-Source: AGHT+IEGEEfymXaJmH9/ja3NDM9JMaZN+LyHVTpB/PXffFTuLgzz9Vd3FXcMohLkWjHooEvSBdSjcQ==
X-Received: by 2002:a05:690c:4445:b0:61b:e13c:e3f4 with SMTP id 00721157ae682-62cabc89d17mr12181577b3.15.1717484964885;
        Tue, 04 Jun 2024 00:09:24 -0700 (PDT)
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com. [209.85.219.177])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-62c7667d5bbsm17269447b3.97.2024.06.04.00.09.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jun 2024 00:09:24 -0700 (PDT)
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-dfac121b6a6so97454276.0;
        Tue, 04 Jun 2024 00:09:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW86EC7kePORvYsXiFBcvvx354gLBxNxNfhwOCADOQzYOsyNAryrTaUo6T5exIlpU3VUPi5nBihO7ujaP8LNsjNgsHdvFR3bFoe0NeYzdQ/57o18VJGlWf9mDth+J9fPUYJC6Mjixo29jEz
X-Received: by 2002:a25:31d5:0:b0:dc6:c670:c957 with SMTP id
 3f1490d57ef6-dfab8b463b7mr1214769276.32.1717484964217; Tue, 04 Jun 2024
 00:09:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240603152601.3689319-1-hugo@hugovil.com> <20240603152601.3689319-3-hugo@hugovil.com>
In-Reply-To: <20240603152601.3689319-3-hugo@hugovil.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 4 Jun 2024 09:09:12 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUo7yPdkPKHXYiWqsqM9Zs4rr2G1tQbH9mZ=bjNLgKamw@mail.gmail.com>
Message-ID: <CAMuHMdUo7yPdkPKHXYiWqsqM9Zs4rr2G1tQbH9mZ=bjNLgKamw@mail.gmail.com>
Subject: Re: [PATCH 2/2] serial: sc16is7xx: re-add Kconfig SPI or I2C dependency
To: Hugo Villeneuve <hugo@hugovil.com>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org, hvilleneuve@dimonoff.com, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Hugo,

On Mon, Jun 3, 2024 at 5:26=E2=80=AFPM Hugo Villeneuve <hugo@hugovil.com> w=
rote:
> From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
>
> Commit d49216438139
> ("serial: sc16is7xx: split into core and I2C/SPI parts (core)")
> removed Kconfig SPI_MASTER or I2C dependency for SERIAL_SC16IS7XX (core).
> This removal was done because I inadvertently misinterpreted some review
> comments.
>
> Because of that, the driver question now pops up if both I2C and
> SPI_MASTER are disabled.
>
> Re-add Kconfig SPI_MASTER or I2C dependency to fix the problem.
>
> Suggested-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Fixes: d49216438139 ("serial: sc16is7xx: split into core and I2C/SPI part=
s (core)")
> Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Thanks for your patch!

> --- a/drivers/tty/serial/Kconfig
> +++ b/drivers/tty/serial/Kconfig
> @@ -1025,6 +1025,7 @@ config SERIAL_SCCNXP_CONSOLE
>
>  config SERIAL_SC16IS7XX
>         tristate "NXP SC16IS7xx UART support"
> +       depends on SPI_MASTER || I2C

You may want to add "|| COMPILE_TEST".

>         select SERIAL_CORE
>         select SERIAL_SC16IS7XX_SPI if SPI_MASTER
>         select SERIAL_SC16IS7XX_I2C if I2C

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds
