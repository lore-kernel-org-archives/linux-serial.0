Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 207084A8A1F
	for <linux-serial@vger.kernel.org>; Tue,  6 Oct 2026 19:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791315372; cv=none; b=EN36PJnIahIkUMEbS/P1/fGXIk+13f8PvvUI4bW/Z6pJoml0+lNkC4brv4LdpEwGLb8JBTo/cNujEnvjuqg5pPDqYR3TP1zsKrSDH7S1F0oiSyiXYBDxyWJxOHDrwXucOqnmoM9T4249ytejSyrdQXHmmfXsFsSP5RN2A0fprB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791315372; c=relaxed/simple;
	bh=Oesqh81RHMadplQw10fVWvrTYRvP/kv8SYJ2XIEq1nE=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=Ku08t3q9A9l4f8BffeLHUsNO3+JLqabwUSVl5iB2SxEbYLGBsAnyjsIjJ5YgyTGj2zQgTNE0jnLcl+Cy4XsXKCPoGKPuCtazn4om1DzqU1ujUG5rDxwbU3tH7pGctgtbtWk31kJMnSigY38hOYpOy5B9DYHgIqr4Gtw8cuKSx1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YTsinBU0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YTsinBU0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C2F81F0089B;
	Tue,  6 Oct 2026 19:36:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791315370;
	bh=KvoYMPPT1Au5IK0CmfAn8tg8j6Q+h61Bx1A3rurA0HQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YTsinBU0fV7KO0Y503jamq1fyVgz0B3Rs9cbt9g+WiQZIzarKCUbovhZtL3LlRI45
	 7EVQ+MFSbL0LlNxhKVgMCSVQwHOUFzuLe5L+sOgKxLo7qWC75ZSRnb3pK5A24dCpcm
	 cq0mjsW83prRsjeWrfb9BWvvE7+BF8OSnPgM4Gz65SrKlm/2OO6FP3yXdRiwT21Hj1
	 Xbez47tkibrDuVPYstyKDvpJQxdL73SWwVAEttdim3J3yzZNhcQbWIWMYXl1DxCWhX
	 /HiN7sPVG14wKOPixOqQTttGnWXn5o6Bbi8Lw8O8UjAEZyC1I2mfr4atZC1JzqXVlx
	 s8IY7E8dP7RMg==
Message-ID: <sashiko-outbox-162399@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] serial: sc16is7xx: declare MCR and IER as volatile
 registers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hugo Villeneuve" <hugo@hugovil.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261006192540.234402-1-hugo@hugovil.com>
References: <20261006192540.234402-1-hugo@hugovil.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 06 Oct 2026 19:36:09 +0000
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] tty: sc16is7xx: making MCR/IER volatile fails to fix bank-switch r=
ace
--

commit d56a719b3706ed6ed6267916f8234030f616e7b3
Author: Hugo Villeneuve <hvilleneuve@dimonoff.com>

serial: sc16is7xx: declare MCR and IER as volatile registers

This commit declares MCR and IER as volatile in the regmap configuration
to prevent potential access errors, as they share addresses with XON1 and
DLH.

> diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7x=
x.c
> index 296079c16fdb9..d6b3b67d17d55 100644
> --- a/drivers/tty/serial/sc16is7xx.c
> +++ b/drivers/tty/serial/sc16is7xx.c
> @@ -501,7 +501,9 @@ static bool sc16is7xx_regmap_volatile(struct device *=
dev, unsigned int reg)
>  {
>  	switch (reg) {
>  	case SC16IS7XX_RHR_REG: /* Shared address space with THR & DLL */
> +	case SC16IS7XX_IER_REG: /* Shared address space with DLH */
>  	case SC16IS7XX_IIR_REG: /* Shared address space with FCR & EFR */
> +	case SC16IS7XX_MCR_REG: /* Shared address space with XON1 */

[Severity: High]
Does making these registers volatile actually fix the underlying bank-switch
race?

If sc16is7xx_set_termios() holds one->lock and changes LCR to 0xBF to access
enhanced registers (like XON1), and sc16is7xx_reg_proc() concurrently updat=
es
MCR without holding one->lock:

drivers/tty/serial/sc16is7xx.c:sc16is7xx_reg_proc() {
	...
		sc16is7xx_port_update(&one->port, SC16IS7XX_MCR_REG,
				      SC16IS7XX_MCR_RTS_BIT |
				      SC16IS7XX_MCR_DTR_BIT |
				      SC16IS7XX_MCR_LOOP_BIT,
				      mcr);
	...
}

Won't the forced physical hardware read-modify-write still hit XON1 instead
of MCR since LCR is currently switched?

This same pattern appears in sc16is7xx_tx_empty() where it reads LSR without
holding one->lock, racing with LCR bank switching:

drivers/tty/serial/sc16is7xx.c:sc16is7xx_tx_empty() {
	...
	lsr =3D sc16is7xx_port_read(port, SC16IS7XX_LSR_REG);
	...
}

Does this approach fail to fix the underlying locking race while adding
unnecessary I2C/SPI overhead?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261006192540.2344=
02-1-hugo@hugovil.com?part=3D1
