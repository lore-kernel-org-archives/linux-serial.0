Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD963B42F5
	for <linux-serial@vger.kernel.org>; Mon,  8 Jun 2026 22:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780958717; cv=none; b=SHhavrjBe1O4iN3VnM6K08+m6KJTK+Y0Y8o2jbXgFuV7VlOdDFFUgOkrqn7LjZQJ2wTby3N+KPAztRk9JD8Ro0JaPApGfQLSrbyWFg3gJmE7PsELeNOrx/rIv2GDNKHLNqOnVaUiXKrNPIKKvuj18DvK8aUkmyr7oXJUUWtgEVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780958717; c=relaxed/simple;
	bh=7ovR92x8Z/N/u3SFG32f5HpKTxDqeJiLi9zXPvC0kQs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ub7ufDk3MYsWaoG0jp/gkZ5CzC1fUNx3nlkrdLSFf8bdUlau0TmoNDEOUjgb9R17ZfH3+9LdvALLuE860aTdl+4bkdTyJxPPmMBekYKgEchiuVEgn0AZyfuQS4CPRYZKsfNrY7rjD2ljR8SW4jb6+kPaVW4gWE50bYd0ugliYmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a7Xlsmbg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a7Xlsmbg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA2111F00893
	for <linux-serial@vger.kernel.org>; Mon,  8 Jun 2026 22:45:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780958714;
	bh=7ovR92x8Z/N/u3SFG32f5HpKTxDqeJiLi9zXPvC0kQs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=a7Xlsmbgu4/3/LK06mzCdWtQcCpzmSJNgUihCh9+PCHXwM+gy63hjqgiIfEjkMSBB
	 Yu6L23L28BzyENB4OtAJqnAw8AdSkG2bYnd8UH0R68KGGBF7jfGFG5FJqIklGNsH7n
	 eaC6MuVt1jezbLQgtNoVmo+AwQLtx+/h4WOn/SOFb82teqVP8zraDEuyuH5Dvx+FQx
	 yzg60UXqT9exhiOigd9weocZ3lphry7HyPIFEuOmwj5xjharM91cYQs95h454949OR
	 mI7DYUYASmKYjCUp+5jEeCLJFHCtrSFjKIgGIdc5PMJDfLpUCu1C3tlXPvBezjC5xi
	 ChP3qb6zXUfZA==
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-396775c26e0so44599081fa.2
        for <linux-serial@vger.kernel.org>; Mon, 08 Jun 2026 15:45:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ81rPcLJNHszU2QNOc1MM3lhURc3wOgLf3TkYstq3WUdsKKviN1Nq9jmdqm0VLPKt4gzRVMNEEXaW68l30=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIytE4wT0u2qeOkNDFRF5Y5gbS/W2qI4cebnMWhI6rBIoZIK8H
	CF8lyOjqhaxmtaxpNAJXsSihVluWNuMdr14jHpBIwiZNZvKU3pkPq/FgVJq87VHqYG1MoRPRIH7
	Rnu8YaODFHQfMff4oTqNhlGVP9K3agnQ=
X-Received: by 2002:ac2:4e10:0:b0:5aa:6cfc:771e with SMTP id
 2adb3069b0e04-5aa87b8dcb5mr5032062e87.2.1780958713709; Mon, 08 Jun 2026
 15:45:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260602-b4-serial-max310x-gpio-get-direction-v1-1-23bf84e8ee14@vaisala.com>
In-Reply-To: <20260602-b4-serial-max310x-gpio-get-direction-v1-1-23bf84e8ee14@vaisala.com>
From: Linus Walleij <linusw@kernel.org>
Date: Tue, 9 Jun 2026 00:45:01 +0200
X-Gmail-Original-Message-ID: <CAD++jL=2a6UxD95r2wMMtaXsrQXVxRHWqw=jJKLsZRxMivObmQ@mail.gmail.com>
X-Gm-Features: AVVi8CdYZC_LNrT4lj-okPc6TIwG-u_u2wJAN03mvE0tz4MJaSgzc0ZXmRT8C0k
Message-ID: <CAD++jL=2a6UxD95r2wMMtaXsrQXVxRHWqw=jJKLsZRxMivObmQ@mail.gmail.com>
Subject: Re: [PATCH] serial: max310x: implement gpio_chip::get_direction()
To: Tapio Reijonen <tapio.reijonen@vaisala.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, Alexander Shiyan <shc_work@mail.ru>, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 2, 2026 at 12:02=E2=80=AFPM Tapio Reijonen
<tapio.reijonen@vaisala.com> wrote:

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

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
