Received: from mail-106104.protonmail.ch (mail-106104.protonmail.ch [79.135.106.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67EA6389472
	for <linux-serial@vger.kernel.org>; Thu, 16 Apr 2026 07:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776324011; cv=none; b=Oq3d3xBhQ4yEjc5CIZ1qf/9CTM2OALW++VsWGUZ14xsRQXGcm4LdJAO3AzbKgb7l2SpfgdVDP3R9Q3EcY6wJZTie4/+aHH2+bP5Bg/s31tAQBl4y9pfbzQtTsbveJBNbTetn6rpgZoKPiN5+BFaWVtqjDVw0slcQabqnTnuvj4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776324011; c=relaxed/simple;
	bh=XyMy7lpp0vec+yjNGHgWw094HCmcOkJwG+6EQhtl8Gw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lrcZFUEY9ttstjSE1BxBbt9rR11IresHL7Wp+PlLB7rZH9ugR49WTAGVFtI51z2e59sVBtAMBvQAxJ6CExpeT8C41R/vf7u7MKtpWDKKT4Fe4yHMPuMi/+rtd4Xw4xwdZw3gsa8Ws2c1DAiRHhRlrrd6ZUtLwW+GoX/oevkXT24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=nQWy/MtG; arc=none smtp.client-ip=79.135.106.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="nQWy/MtG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=jynqt7qzo5gwrcpkfzfwgdsyt4.protonmail; t=1776324000; x=1776583200;
	bh=izzvQA5PYaT68YANwCXy6bN5n00IIX9Z0Gu65kVl6Vs=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=nQWy/MtGYrHXUaKjk/RICj6IgSubE2K70x5YveNsAOMffAEzkp2eZHWrAs0eqzy4l
	 cO4eVE4kJWGoUzr2eCPu7DPeA4gFogfSzHs0W1edVAj0oOXkO7BS6YBAR6i7N1bPl7
	 EL2HGjhUZzTXT+llbHIBHmvpFjXKzBFjBzzR6w5sklaCjRod1h8Jvyjc9G2DOIZqwU
	 PgPKuda5s1f4Qq23EtY4hCWZH3VcJRnD6Jozmthb2gnQs3S49gSRzzIwYcbop/gAjr
	 b5pCTF7tEO2KTkj/iHft/p5J7JpGf8LAap85SQJwljlsCWV15s4U8XabaN/HgqFG8p
	 +CvcP2daIyhfg==
Date: Thu, 16 Apr 2026 07:19:56 +0000
To: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "jirislaby@kernel.org" <jirislaby@kernel.org>
From: kpursoty@proton.me
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>, "tsbogend@alpha.franken.de" <tsbogend@alpha.franken.de>
Subject: Re: [PATCH] serial: base: do not disable TX on hangup for console ports
Message-ID: <rHcToILwx6aB9P0a5jBv5Xkuyu8LeRk9nEXX4FezpwlmzPVoKL3MFkw77E_u68Yz6twiE4C7sPLN3Knlw3rf9BL6ejgjqiqmOffgou6ziyQ=@proton.me>
In-Reply-To: <1fpGAFo1KYyRDeGSGmaDWx6gXbV00C83qU_tep62Zu_cl9JfjpjWg8SKhw6z0owZ9eEMzXR2GnZ_U3V2PVi2R1fuGAmzgK43GYbWkCIBFf8=@proton.me>
References: <1fpGAFo1KYyRDeGSGmaDWx6gXbV00C83qU_tep62Zu_cl9JfjpjWg8SKhw6z0owZ9eEMzXR2GnZ_U3V2PVi2R1fuGAmzgK43GYbWkCIBFf8=@proton.me>
Feedback-ID: 133470881:user:proton
X-Pm-Message-ID: d294ac24d99d74913ecec0028bac37a3d68497dc
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Thanks for your notes. Patch withdrawn.

On Wednesday, 15 April 2026 at 09:01, kpursoty@proton.me <kpursoty@proton.m=
e> wrote:

> serial_base_port_shutdown() calls serial_base_port_set_tx(false)
> unconditionally. When a TTY hangup occurs on a port that is also a
> registered kernel console, this permanently disables the console
> transmitter.
>
> uart_hangup() already guards against uart_change_pm(PM_OFF) for console
> ports (see the uart_console() check in uart_hangup()). Apply the same
> guard in serial_base_port_shutdown(): skip TX-disable if the port is a
> registered console.
>
> Without this fix, any path that calls uart_shutdown() on a console port
> - including TIOCSCTTY with force=3D1 (as used by init systems such as
> procd) - permanently silences all subsequent kernel console output.
>
> Signed-off-by: Kervin Pursoty <kpursoty@proton.me>
> ---
>  drivers/tty/serial/serial_port.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/tty/serial/serial_port.c b/drivers/tty/serial/serial=
_port.c
> --- a/drivers/tty/serial/serial_port.c
> +++ b/drivers/tty/serial/serial_port.c
> @@ -110,5 +110,14 @@
>  {
>  =09struct serial_port_device *port_dev =3D port->port_dev;
>
> -=09serial_base_port_set_tx(port, port_dev, false);
> +=09/*
> +=09 * Do not disable TX on a console port. When an init system calls
> +=09 * TIOCSCTTY with force=3D1, the kernel hangs up the previous session=
,
> +=09 * triggering uart_hangup() -> uart_shutdown() -> here. Stopping TX
> +=09 * kills all kernel console output permanently.
> +=09 * uart_hangup() already skips uart_change_pm(PM_OFF) for consoles
> +=09 * via uart_console(); apply the same guard here.
> +=09 */
> +=09if (!uart_console(port))
> +=09=09serial_base_port_set_tx(port, port_dev, false);
>  }
>
>  static DEFINE_RUNTIME_DEV_PM_OPS(serial_port_pm,
>
