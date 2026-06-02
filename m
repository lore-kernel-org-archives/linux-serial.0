Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B277B2F3C07
	for <linux-serial@vger.kernel.org>; Tue,  2 Jun 2026 16:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780417144; cv=none; b=iaHSGFV+I7B5wzJKwqIAGaOb425WbTotdJdDKH1eYchu2P/4LTsXER1MRsAI5c2aLGqwb6nQ7J6rcEyfWymaQlkGWdSv7HqCIn4cV0X6XgUSt5EmevpZuD34hRaTI0UWtztT6XliZSrdRejV/yIQEMrxGK+wglsNzwui/WNWtFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780417144; c=relaxed/simple;
	bh=BPbTvHpkT/+atMHfAn83Ogy4KZjiKb1VCoyZTifM4YA=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bqRU/jvfXGNfxk4htHaSmJ2Llcyl+gxcFhzhVKGK42J4pnOkR8mErOJI4wiWrd5kUAE3gEur143gwZOgfjCfp6CMWOkTp0ZIZZqM2hvFYetHZMWerNcn3obMuWDG6dtAICPzhRCgUrUzIc1Ei4Gm8JH9QbBL8LjpDwxsH+MP+VI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dwtw1pne; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dwtw1pne"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B5701F0089A
	for <linux-serial@vger.kernel.org>; Tue,  2 Jun 2026 16:19:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780417142;
	bh=BPbTvHpkT/+atMHfAn83Ogy4KZjiKb1VCoyZTifM4YA=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=Dwtw1pneN91J12PMkaxGO1CMKagCvWg/EPs/mkBH7uGuLxN9b2QAMPXFDWIYZpGOd
	 rdJc1SGshSGuGvO700BuGHmsTZyKJgKx67rSYJQmWV4tjXRzfNcBle6mDExJVGjB/C
	 VPJ6GdESA1DRFgBwX0BvMGUvXeZlgY4l6BbY8ZtFJkNQ1seJrCW50XpfCDyyNNeOUp
	 KY+sgfvNOuXg1O5a7GF7zghpQ7AGwV3cOF9xVw/sOK0KiN3f4Cp8PCJR8puC3HinKC
	 aIyhqICjsIpnKHwEXbU83dqANndYcud9eLXK6c/v2m9tV2I9km0QDhHMJCSonzmO5S
	 ZfbLY3Dzwk6vQ==
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-3966c3dbf10so30633641fa.0
        for <linux-serial@vger.kernel.org>; Tue, 02 Jun 2026 09:19:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/S4E9G4BZoNF/vuUCFNB186HMwIEsnVaM0YJ6iDO5l/p9nLrhO3exbiz3x9mg6bkPjj2lsEKeDFOyE9kM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzpOzmk2s4rgIb98sORfl5ZIj+VfO2mgHFe8P3ZpqOLewNyq62
	+xmL+ScePaz9juzpY5dZkVUQxJFfbwoVI4bJMme9+gqSg0gl4azZ+4cUWhSOQuuFshqH6UsQ4Y7
	0dFxksbDZYxd2MVvTJvLrCjkvzA7cr0K1YnlRLcb2xQ==
X-Received: by 2002:a2e:a90d:0:b0:396:75ac:457a with SMTP id
 38308e7fff4ca-396ac2bf8f1mr1234431fa.8.1780417141042; Tue, 02 Jun 2026
 09:19:01 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 2 Jun 2026 11:18:59 -0500
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 2 Jun 2026 11:18:59 -0500
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260602-b4-serial-max310x-gpio-get-direction-v1-1-23bf84e8ee14@vaisala.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260602-b4-serial-max310x-gpio-get-direction-v1-1-23bf84e8ee14@vaisala.com>
Date: Tue, 2 Jun 2026 11:18:59 -0500
X-Gmail-Original-Message-ID: <CAMRc=MePduXLREX+X6mLF5qusfjvp6=TZC6RJcQb7vm7=KAixQ@mail.gmail.com>
X-Gm-Features: AVHnY4ISA-VZS8ud-UYiHr-qhu-EM_kTyWlK8MV1UlB9AJNiwyCX_g3JEU1YW-k
Message-ID: <CAMRc=MePduXLREX+X6mLF5qusfjvp6=TZC6RJcQb7vm7=KAixQ@mail.gmail.com>
Subject: Re: [PATCH] serial: max310x: implement gpio_chip::get_direction()
To: Tapio Reijonen <tapio.reijonen@vaisala.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	linux-gpio@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, Linus Walleij <linusw@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, Alexander Shiyan <shc_work@mail.ru>
Content-Type: text/plain; charset="UTF-8"

On Tue, 2 Jun 2026 12:02:35 +0200, Tapio Reijonen
<tapio.reijonen@vaisala.com> said:
> It's strongly recommended for GPIO drivers to always implement the
> .get_direction() callback - even when the direction is tracked in
> software. The GPIO core emits a warning when the callback is missing
> and a user reads the direction of a line, e.g. via
> /sys/kernel/debug/gpio.
>
> The MAX310X keeps the GPIO direction in the GPIOCFG register (a set bit
> selects output), which the existing direction_input/output callbacks
> already program, so the current direction can be read back directly.
>
> Fixes: f65444187a66 ("serial: New serial driver MAX310X")
> Signed-off-by: Tapio Reijonen <tapio.reijonen@vaisala.com>
> ---
> Found and HW-tested on an i.MX6 SoloX board with a MAX14830 over SPI:
> without this, "cat /sys/kernel/debug/gpio" triggers the gpiolib.c:429
> WARNING (tainting the kernel W) on each queried MAX14830 line; with it
> applied the lines report their in/out direction and the WARNING is gone.
> ---

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
