Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AF587262F;
	Mon,  1 Sep 2025 08:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756716797; cv=none; b=HvIuttY3xu0HS3IjnwIfOka3NBKJWrwEfHBnxyOOo+jOrHv+UhPRuC2xJwqJV5wonM3enJhtJuM1ASEzfxD8ZVyD9fazt+pw9kOVl9IN+EVaBVq+uWTPDN3Tjy/C9S5t8l3Y+qMCwPwYk+32e9xxfnCEZWbDY7BZgnS2a3xJI5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756716797; c=relaxed/simple;
	bh=xkcIUqU1NHV0DJZXrd/onXacp9Mgwv91i/+bnnqT08M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aQCotY6cYGIQE9NkGlmlQqhLTfA9cbWC34VemNQxZlxMoFaVdFaSgKLJuqUlOr6Eh7Qzw1ioUy5rDXCm7ueULfR4hNbTkCPeAQiwZMJhNzv2euOP7YBrrxTdytHtygJp8S2OWcewjwbatZZvmLcUGzGxBsCwZ5y1EnX3sAi1NNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-544a1485979so512035e0c.3;
        Mon, 01 Sep 2025 01:53:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756716795; x=1757321595;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hwV0ZxFlGA9LVCwpYAd/S0jSR5rIjW8cIxXeVwnFYUM=;
        b=a++8IrxBIJlI0f7O/w+L+Cd2K7VKGwzvR1GMHusVn4BzETRCFA0f1Ev36jcIgiioVL
         kGcb5UsHZITAQg1ijFRr4zmxay5ZDNLWVO6rU1Y8RWTW1KuksUFklpikqNcybUwzKZrp
         kPBpzO9MHHfH3nslmJ3YGCV6bXJpFOs+nfOuoJngzPGH55s3Ix8zAiuEbq11HKpdJgiV
         HaBkr/yCHFGmU1f0gaR64M5BuItscZ+mM2SCG/EnKtXEiFnL2S08lMJh8zJm+jNiPJkq
         PBwcu0EzjB11kjXvqyE/LdXm+v9TX0X3s0gPMlRCyCLyzVBnDeqczWbQ3wjxg/SM5lHA
         p9sQ==
X-Forwarded-Encrypted: i=1; AJvYcCVuBFS9taBSUh+mB+BYTgVYt5xtbTmMkkIzrbxyJLbkDl8RCtVySfmxgig5nwE4lGSqBJeaSar4Akfqfx4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyaz/zesJB/3BcFSwWV8PWZy2cKbEhwv8DIbLRGES5JGQKYcgwj
	jAVDu1g6gf7lWuwz09fehgUIm0Uifi3FZXAm+zio4g4oLJtcwhzMmjQ95gQd9WVg
X-Gm-Gg: ASbGncsyqiwHluGSkbCGk2hgsEoXNML0Kli0hPhmx5qbJ5XcTdHT28x84iKetiHfSj2
	b8J4N1/0+n3l2epxleVqsT7dkzh9cPDHHKxPnrLByvlx+vnV4FldSyRK+cKY517xdhof0VAaYT+
	0A1m1Q7jkczrSXoEdl+wrfKFUbzSF308eAcYmeQ3a400v5/zxKs3CR5rEqwfzEaFnwZLJNF6NMR
	vfRSkjv/L8zOcChr6qezGLIHBR+Og/6plsKcZWhyO0yjqNd797cotkm9xGlLQALbrA/5BMBvNs4
	vnBGWqiWzANh7XANx9t0kgZ7VAB7qT7KAHd2kuwi7Gc7qFExeDm7cxbGRPRl5DbFvUaCw30KNed
	x8HOFIrtMXgeNrz9bVhj3WeIQ3UurAyuOlxNxRXSpntUeHVaGTatw3P6q0PA+tA82qO1t9UA=
X-Google-Smtp-Source: AGHT+IHTCli5TjIdcjHsgFRsBoq+JJx7dKPZNS1I+boEX9ZBLdf+eMh98R9FcNcRJhUKQpPDev2qLA==
X-Received: by 2002:a05:6122:659b:b0:541:2e11:6738 with SMTP id 71dfb90a1353d-544a02a9309mr1661553e0c.9.1756716795249;
        Mon, 01 Sep 2025 01:53:15 -0700 (PDT)
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com. [209.85.217.48])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-544912ef219sm4294323e0c.7.2025.09.01.01.53.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Sep 2025 01:53:15 -0700 (PDT)
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-528d8aa2f3bso1310851137.2;
        Mon, 01 Sep 2025 01:53:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCViA3kUjzxxB96G58PtOPF5rXvq5XVLNoP5+zfhrPVdn5PaMdml4NIngamFE9ddSixNmXn+qOXm0knJ0tE=@vger.kernel.org
X-Received: by 2002:a05:6102:6889:b0:52a:4268:7618 with SMTP id
 ada2fe7eead31-52b1c246f01mr1657627137.27.1756716794630; Mon, 01 Sep 2025
 01:53:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250822104208.751191-1-jirislaby@kernel.org>
In-Reply-To: <20250822104208.751191-1-jirislaby@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 1 Sep 2025 10:53:02 +0200
X-Gmail-Original-Message-ID: <CAMuHMdW7e-QOjoWqsccvyBLOeoGgeLrE3ERuHv_o3PXBtKAoRg@mail.gmail.com>
X-Gm-Features: Ac12FXws79G7sfNDXlYCwBsnRL2gsroj-XTL_Qr7goYhu25uBKLks1ZnLnPmw9c
Message-ID: <CAMuHMdW7e-QOjoWqsccvyBLOeoGgeLrE3ERuHv_o3PXBtKAoRg@mail.gmail.com>
Subject: Re: [PATCH] m68k: make HPDCA and HPAPCI bools
To: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-m68k@lists.linux-m68k.org, Philip Blundell <philb@gnu.org>
Content-Type: text/plain; charset="UTF-8"

CC PhilB

On Fri, 22 Aug 2025 at 12:42, Jiri Slaby (SUSE) <jirislaby@kernel.org> wrote:
> The only user -- 8250_hp300 -- tests for CONFIG_HPDCA and CONFIG_HPAPCI.
> It does not test for *_MODULE variants. That means that if someone sets
> the configs to =m, the code is not compiled at all.
>
> There is actually no point having these as tristate. Switch them to
> bool.
>
> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: linux-m68k@lists.linux-m68k.org
> ---
>  arch/m68k/Kconfig.devices | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/m68k/Kconfig.devices b/arch/m68k/Kconfig.devices
> index e6e3efac1840..e277f1bd2de1 100644
> --- a/arch/m68k/Kconfig.devices
> +++ b/arch/m68k/Kconfig.devices
> @@ -105,14 +105,14 @@ config AMIGA_BUILTIN_SERIAL
>           To compile this driver as a module, choose M here.
>
>  config HPDCA
> -       tristate "HP DCA serial support"
> +       bool "HP DCA serial support"
>         depends on DIO && SERIAL_8250
>         help
>           If you want to use the internal "DCA" serial ports on an HP300
>           machine, say Y here.
>
>  config HPAPCI
> -       tristate "HP APCI serial support"
> +       bool "HP APCI serial support"
>         depends on HP300 && SERIAL_8250
>         help
>           If you want to use the internal "APCI" serial ports on an HP400
> --
> 2.51.0
