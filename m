Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 760B33CF206
	for <linux-serial@vger.kernel.org>; Mon, 15 Jun 2026 08:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781513162; cv=none; b=LHk3ua4fh9wf7jA3buQcFm7+ySrIFx18XTPeCJCF5WqUKuciZ1HydOvVRQY/VAyhOURBHVlZ9b/H8eaehJL0qg86m1RloML4FrR7jjzhipH1mDsd2XROQ1+xTgctGSLswgltNFF3h2E6rbSM9pDCS3V+6jYHajZXA+YgF/PBK7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781513162; c=relaxed/simple;
	bh=2n+rqqEQk9Dgk9v85PEmZctuQJcL5Aft8l5cRPlN33w=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=en357WUsCL5kQqiNBA30cgP1ZCMXoBBMTzUJuL7LHvAheBUHt9QHRpeDI/+6Vj29JkwI3bWPbG1ibxJA+cPbsyQCJ9lRipP6LfWSWQC5WovkWhwIbp/1PjEgDKXCCvL9f9OlsjYbcswgxiQYNHy99dNcyeTulgT5HPYwntB19ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n4d9Z9CU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n4d9Z9CU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 576DD1F00A3A
	for <linux-serial@vger.kernel.org>; Mon, 15 Jun 2026 08:46:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781513160;
	bh=OBe0ITxGv6gOrcKtGcU3uQ6eRRXWDLj4lG7UY0EX+8M=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=n4d9Z9CUbwfC8ON3UfMZ9ZMsmHnha2OANu1VYlBLWr/Pb78deiFwVZ52DIk8A0HnV
	 YybM+99jnHM6piBa8xn8tW8BrI1ekvyxRVQwpraLcuNirlcNVviWvYluF827lCznb1
	 IlhW6qBIH1KfSwVto3YJFZcTc4hqYI8Y3pe/yw3sWpwL5L+JkeNI/6LlZ50N3ycSeM
	 iU7PMYjIq5I0Zx9hk4+74OW+hnckt1VjBi40THiiBlEcCTbsY4lIE8hJG1zgnf1BjC
	 k9SCantWf/K1TH7oXGXG6poGUkVu6tezGLFQvH3CMfP2W+azOk9vxZA/X5tjVxtiz0
	 EQzAR8ECJrfVg==
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5aa5ce4904eso2940583e87.3
        for <linux-serial@vger.kernel.org>; Mon, 15 Jun 2026 01:46:00 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8Y01yfjNZC6ieqS6t1em/b+qIo8XbND6qBVBP9eIDVp6TzvP09vz5jlupBAvY4nfkvabBeKyDsxLitkI4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuAVCaCXoAeDukkgkPu1H/9hdS1aJIh+QYIxKsj0xa8sWa+AZr
	cnE0rZm8JEblMGhS3+Zp18r96cLtV//aHNbNLTnbuxWJfS75okQCj63qdOBhK05VyibwtCy4HGa
	6MyCycVbD25E712Ztq0XmzRfEmunka9+9XwHrcJjwPA==
X-Received: by 2002:ac2:4341:0:b0:5aa:6e86:55e1 with SMTP id
 2adb3069b0e04-5ad2db1f44emr2789666e87.16.1781513158741; Mon, 15 Jun 2026
 01:45:58 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 15 Jun 2026 01:45:56 -0700
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 15 Jun 2026 01:45:56 -0700
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260615-b4-serial-max310x-gpio-get-direction-v2-1-4704ba2b181a@vaisala.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260615-b4-serial-max310x-gpio-get-direction-v2-1-4704ba2b181a@vaisala.com>
Date: Mon, 15 Jun 2026 01:45:56 -0700
X-Gmail-Original-Message-ID: <CAMRc=Mc2WAo0mEFazT=S0R_fYaX=B52AhE+aiuLKei36B1QV5Q@mail.gmail.com>
X-Gm-Features: AVVi8CdTwdnJuiJVu0N2jnzm1Xm_R8Lp-KFeKEhnreTnrWdRHPV4v96weeSz6II
Message-ID: <CAMRc=Mc2WAo0mEFazT=S0R_fYaX=B52AhE+aiuLKei36B1QV5Q@mail.gmail.com>
Subject: Re: [PATCH v2] serial: max310x: implement gpio_chip::get_direction()
To: Tapio Reijonen <tapio.reijonen@vaisala.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	linux-gpio@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, Linus Walleij <linusw@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, Alexander Shiyan <shc_work@mail.ru>
Content-Type: text/plain; charset="UTF-8"

On Mon, 15 Jun 2026 08:38:40 +0200, Tapio Reijonen
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
> Changes in v2:
> - Address Hugo Villeneuve's review: use BIT(offset % 4) and put the
>   return statement on a single line.
> - Rebase onto v7.1-rc7.
> - Link to v1: https://lore.kernel.org/r/20260602-b4-serial-max310x-gpio-get-direction-v1-1-23bf84e8ee14@vaisala.com
> ---

I've already left my tag under this.

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
