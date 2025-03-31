Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F0A21D514B;
	Mon, 31 Mar 2025 08:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743408204; cv=none; b=OfY8BibjFPtYuZzh7WLH64auJPxXpTGu5youb7n9fLnr718bCIPgANGSOhYgeXIgrRmGXjdCdUHKgcGvhZCeh4kyyof2yqT2fz7z50+CHo/In58AkyhiLm3XbBDLAYmCCCE2jTHyFh6aUg+0ZvhwWO1VRdsIPJqNKADu5Qj9l0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743408204; c=relaxed/simple;
	bh=+1xycFoEEvfkplY83xdxtrCF3C+pn1NbeQIaH1TKCMI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FSQF+Gf6SQYD0pXC8GOpGfAhij0e923xkivuDF2x2UsYdTuxUQGYweA5Nxs7SF2RnBi3iN6tnU3xUsG0l52P1JzHL9nyMOXW9s/tZn3E+ciLGWEOXPo6uG8XNol/+rk5zFxmBZ5HgZAw81L5w2nNaCJzBTTOnfmqOkd9QoioNYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NKxlC4/a; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uSSqXfQn; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NKxlC4/a";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uSSqXfQn"
Date: Mon, 31 Mar 2025 10:03:18 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1743408200;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=75LtVyshrpJURZDN4urZhi8S9CoAlSOeTIRvPjPMZJo=;
	b=NKxlC4/aH1YHe9/fhfvyILrpo3cMwJRrA3MFoqOXhsalLN0hCEuLUmhulZUI6aP/kfEP7R
	F+ldAEzgmSrbYKeTRjv0YpRZzCqHzZxy9i97E4RRAJMLWpnFBdS6Estd1uvSZfl5s4X3yX
	4mEpV7ZoJqX+BN1SulNpzWxr8EJD29jq6fVRIaR92jKEvmrP2MncgunbT9Bv8oayllbaRD
	in1wKZ8q7SvTjQPjNcONitjYJGxWqSHbbPT6xuwQTSBj91G8uuD0Yl0Sn0Jmjpw+BYiGMw
	0Xmh3jkUymzKlVxhSEmPwKSXUwYLoBdbLpKML7FKGhFO/BL3PAmqNF8LNMd4Uw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1743408200;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=75LtVyshrpJURZDN4urZhi8S9CoAlSOeTIRvPjPMZJo=;
	b=uSSqXfQnv8ErdniQp/vNTsDTt7J4Z1TE9vvTE//wlMYTSEmbq9c5pBUmTKI3fWplCy+UbN
	s4MdZgfQfCBhYnDQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Ryo Takakura <ryotkkr98@gmail.com>
Cc: alex@ghiti.fr, aou@eecs.berkeley.edu, gregkh@linuxfoundation.org,
	jirislaby@kernel.org, john.ogness@linutronix.de, palmer@dabbelt.com,
	paul.walmsley@sifive.com, pmladek@suse.com,
	samuel.holland@sifive.com, conor.dooley@microchip.com,
	u.kleine-koenig@baylibre.com, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH v3 2/2] serial: sifive: Switch to nbcon console
Message-ID: <20250331080318.BdZQodhu@linutronix.de>
References: <20250330110957.392460-1-ryotkkr98@gmail.com>
 <20250330112109.393526-1-ryotkkr98@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250330112109.393526-1-ryotkkr98@gmail.com>

On 2025-03-30 20:21:09 [+0900], Ryo Takakura wrote:
> --- a/drivers/tty/serial/sifive.c
> +++ b/drivers/tty/serial/sifive.c
> @@ -785,33 +786,88 @@ static void sifive_serial_console_putchar(struct ua=
rt_port *port, unsigned char
> =20
>  	__ssp_wait_for_xmitr(ssp);
>  	__ssp_transmit_char(ssp, ch);
> +
> +	ssp->console_line_ended =3D (ch =3D=3D '\n');
> +}
> +
> +static void sifive_serial_device_lock(struct console *co, unsigned long =
*flags)
> +{
> +	struct uart_port *up =3D &sifive_serial_console_ports[co->index]->port;
> +
> +	return __uart_port_lock_irqsave(up, flags);

this does look odd. A return statement in a return-void function. The
imx driver started it=E2=80=A6

> +}
> +
> +static void sifive_serial_device_unlock(struct console *co, unsigned lon=
g flags)
> +{
> +	struct uart_port *up =3D &sifive_serial_console_ports[co->index]->port;
> +
> +	return __uart_port_unlock_irqrestore(up, flags);
>  }

Sebastian
