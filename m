Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8358B368D4A
	for <linux-serial@vger.kernel.org>; Thu, 24 Sep 2026 12:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790253647; cv=none; b=a3DSCGGhIx+11WR2HZaZTNRVZZPqNCcmYokS5CLBBqJ670UK8oDaPc5wgxAeUbpknz0LDocht/hEqFz4F4qx1b4e+5MZ3wkPwDIAUA2CVmgKwofFAL/mNxlPlOZfSIAmr+DRRusQP9s0gEFOQharjUtPhW4FfZWCLTEdG94Epzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790253647; c=relaxed/simple;
	bh=s3+yd3TP+IHikb14hTk+QxD4B62vNARJz+QMdxFrB+w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=knsiP7gQUZ5e0FYPb2r+85ip3h8w5tP04n4rN3gP+eIq/LSPQZDxOJMseaABDg/tlXzTU9f6SBJuTvyrxRhO7amJZC2JMPz9oVAiz5yfwKkw79+703cZwb0KVn+XPS7XnGCpEvT1/Eck8JnsAjgSUA2xQJ41Tfl7BUCILjKsBWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dxf1chlC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dxf1chlC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C4AF1F000FF;
	Thu, 24 Sep 2026 12:40:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790253642;
	bh=3OS0OCTrh8R60RvjWD8frNjlWDREVk8g+8pQmRYzmxs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dxf1chlC2hmjwYZZcMEeOiArd72TmFhzBCqGJaZb7Z494ktXnbFmP58/ddUgiG760
	 uL9+hRpjMU8GWh3cjRBC4UnIeLYsojCgdyy0+qFYD5Gd07UvS0EfGd8gljjjZfMJ0j
	 coHPuwxU6iSBtSDxFyDj7i1pzkRE+PobAMCPHIi/WsE5NZsZ8EOv6R9Dc0NBt0ZZqV
	 4pBg02Dr5i+WvNPF0543xBIJVh9jzKqSfdD//splAD5yIHyYKNBVvFX+YxhJlgU1Hj
	 wiPom2RZIuj9562qgJ0+2+iXVo7XJ1hT0TZt4fNA2pIpaU2zBefKme1h6MfdVi6lw0
	 Q4ouiRO83l36A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] serial: 8250_port: properly handle runtime PM in
 IRQ
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20260924122549.668680-3-andriy.shevchenko@linux.intel.com>
References: <20260924122549.668680-1-andriy.shevchenko@linux.intel.com>
 <20260924122549.668680-3-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 12:40:41 +0000
Message-Id: <20260924124042.1C4AF1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] serial: 8250: missing port->dev NULL check in serial8250_default_h=
andle_irq()
--

commit 128116d52224b04215dd65b2f4f799e8c14bdec7
Author: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

serial: 8250_port: properly handle runtime PM in IRQ

This commit updates the 8250 driver IRQ handler to explicitly check the
runtime PM status before processing the interrupt. It returns immediately
if the device is powered off, assuming it is a shared interrupt.

> diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/825=
0/8250_port.c
> index c0bcc0742a60c..1e62460b19ab9 100644
> --- a/drivers/tty/serial/8250/8250_port.c
> +++ b/drivers/tty/serial/8250/8250_port.c
> @@ -1878,13 +1878,22 @@ EXPORT_SYMBOL_GPL(serial8250_handle_irq);
> =20
>  static int serial8250_default_handle_irq(struct uart_port *port)
>  {
[ ... ]
> +	/* if driver suspended, return, probably shared interrupt */
> +	pm_status =3D pm_runtime_get_if_active(port->dev);

[Severity: High]
Will this trigger a kernel panic if the port has no associated device?=20
Some ports, such as legacy ISA serial ports, might have a NULL port->dev.=20
Calling pm_runtime_get_if_active() with a NULL pointer would unconditionall=
y=20
dereference it.

> +	if (!pm_status)
> +		return 0;
> =20
>  	iir =3D serial_port_in(port, UART_IIR);
> -	return serial8250_handle_irq(port, iir);
> +	ret =3D serial8250_handle_irq(port, iir);
> +
> +	if (pm_status > 0)
> +		pm_runtime_put_autosuspend(port->dev);

[Severity: High]
Similarly, does this put operation need a check to ensure port->dev is valid
before passing it to pm_runtime_put_autosuspend()?

> +
> +	return ret;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924122549.6686=
80-1-andriy.shevchenko@linux.intel.com?part=3D2
