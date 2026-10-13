Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40BAD42C4FA
	for <linux-serial@vger.kernel.org>; Tue, 13 Oct 2026 12:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791895108; cv=none; b=U/icXJyM4DavZb9fPHAa76U0k/3CA0JCdK3aT+XMqwPsPulCYY31TYbKaidkwd2R9VjDziZ+CJp9wcBwhQvIfpL4ZW9jQ9BPYd65xCyzEKzPyZXQxL+8Khsj6gtF/e+eq6B58dLa6V6C1NoAm53flQoeEwwuGCbKl8qWCEaYibA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791895108; c=relaxed/simple;
	bh=6PeKlkVlCYmFRs2IKFn/L7hn633RP5Q6pI53uWfsEgY=;
	h=Message-ID:From:Subject:To:In-Reply-To:References:Content-Type:
	 Date; b=G6z4FncQ+eMxwGxpGDCC7WccInTUzokiphbdynghT6qWv5SI/ijZ3obM5Br9i6R8G3QmZxgr8puN+MkWs2qikkUAdFWAZ4PsOP4lZ7muS121CE4CdWM3NdSGGvJcmDGEFDMvQZePnV24tBz1BRlPWjfFMlTT5cMjm0SYyS2ZqjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=juPywoAh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="juPywoAh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04E601F000FF;
	Tue, 13 Oct 2026 12:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791895107;
	bh=Yd6q9pg+2H/jA+5INzBDCwxT6l5MwC7kAEHgwTHzm/w=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=juPywoAhUfW7aItkP0IgRW9ImhfqGj58jgobUXCV4VVQxcTg/v8PNzs5haZREXQHO
	 JEN30AmSbJNaaWI2gl1nzqr8YKOX6pzhXVSgYEC2+ZKCHeniL8wR/UHmU4rI0Vrpcp
	 Up91ZuAoWb0uLlLucXs8PPsMBHSxVw5jwsApuu34gQwukFy+5ohlKGBuw8jj3025hz
	 dYJbKHyNTY0izXqMk2pQIDo6MdyLJ6lEebTWBo4oDmpqM+3P4luS2nKhRdH3Xy/x97
	 4s4f2bAu3Wojc0idYq8Q9olVs6z0Bg5Q3SZ9OdW5838Cc5jFpMatfndwxGCZEwr89J
	 +KCxvPHyzoOvQ==
Message-ID: <sashiko-outbox-169727@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/5] serial: mcf: dynamically allocate memory
Reply-To: sashiko-reviews@lists.linux.dev
To: "Greg Ungerer" <gerg@linux-m68k.org>, linux-serial@vger.kernel.org
In-Reply-To: <20261013120831.1046590-4-gerg@linux-m68k.org>
References: <20261013120831.1046590-1-gerg@linux-m68k.org>
 <20261013120831.1046590-4-gerg@linux-m68k.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 12:38:26 +0000
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] tty: mcf: Use-After-Free and double-unregister due to dangling poi=
nters and global array loop
- [High] tty: mcf: Premature console publication causes NULL pointer derefe=
rence
- [High] tty: serial: mcf: Use-After-Free on probe error and driver removal
--

commit cc5afe1f9a1d1092ba4a245994a51d452fb2379c
Author: Greg Ungerer <gerg@linux-m68k.org>

serial: mcf: dynamically allocate memory

Modify the ColdFire serial driver to dynamically allocate the local uart
port structures as required at init time. Currently it uses a fixed
size array - a little wasteful of memory on most parts with only a
couple of UARTs.

> diff --git a/drivers/tty/serial/mcf.c b/drivers/tty/serial/mcf.c
> index 3651910dff99e..7cbe43cbe3a0e 100644
> --- a/drivers/tty/serial/mcf.c
> +++ b/drivers/tty/serial/mcf.c

[ ... ]

> @@ -509,9 +517,9 @@ static int __init mcf_console_setup(struct console *c=
o, char *options)
> =20
>  	if ((co->index < 0) || (co->index >=3D MCF_MAXPORTS))
>  		co->index =3D 0;
> -	port =3D &mcf_ports[co->index].port;
> -	if (port->membase =3D=3D 0)
> +	if (mcf_ports[co->index] =3D=3D NULL)
>  		return -ENODEV;
> +	port =3D &mcf_ports[co->index]->port;

[Severity: High]
Could this change lead to a NULL pointer dereference if console setup runs
concurrently with device probe?

In mcf_probe(), the new port structure is allocated and assigned to the
global mcf_ports[] array before port->membase is initialized via ioremap.
Since mcf_console_setup() no longer checks if port->membase is zero, it can
successfully complete before the mapping is done. If a printk occurs in
this window, mcf_console_putc() will dereference the NULL membase when
attempting to read the UART status.

[ ... ]

> @@ -572,10 +580,16 @@ static int mcf_probe(struct platform_device *pdev)
>  {
>  	struct uart_port *port;
>  	struct resource *res;
> +	struct mcf_uart *mp;
> =20
>  	if (pdev->id >=3D MCF_MAXPORTS)
>  		return -ENODEV;
> -	port =3D &mcf_ports[pdev->id].port;
> +
> +	mp =3D devm_kzalloc(&pdev->dev, sizeof(*mp), GFP_KERNEL);
> +	if (mp =3D=3D NULL)
> +		return -ENOMEM;
> +	mcf_ports[pdev->id] =3D mp;
> +	port =3D &mp->port;
> =20
>  	port->membase =3D devm_platform_get_and_ioremap_resource(pdev, 0, &res);
>  	if (IS_ERR(port->membase))

[Severity: High]
Does this leak a dangling pointer into the global mcf_ports array if probe
fails?

The devm_kzalloc() pointer is assigned to mcf_ports[pdev->id] before
devm_platform_get_and_ioremap_resource() or platform_get_irq() are called.
If either of those functions fail, mcf_probe() returns an error, and the
devres framework will free the memory. However, mcf_ports[pdev->id] is
never cleared, leaving a dangling pointer that can be dereferenced later.

[ ... ]

> @@ -605,13 +619,11 @@ static int mcf_probe(struct platform_device *pdev)
> =20
>  static void mcf_remove(struct platform_device *pdev)
>  {
> -	struct uart_port *port;
>  	int i;
> =20
>  	for (i =3D 0; (i < MCF_MAXPORTS); i++) {
> -		port =3D &mcf_ports[i].port;
> -		if (port)
> -			uart_remove_one_port(&mcf_driver, port);
> +		if (mcf_ports[i])
> +			uart_remove_one_port(&mcf_driver, &mcf_ports[i]->port);
>  	}
>  }

[Severity: High]
Can this loop cause a use-after-free and improperly unregister all ports
when a single device is removed?

During mcf_remove(), the code iterates through the entire mcf_ports array
up to MCF_MAXPORTS and calls uart_remove_one_port() on every non-NULL
entry, rather than just the port associated with the pdev being removed.

Additionally, it does not clear mcf_ports[i] back to NULL. When
mcf_remove() finishes, devres will free the memory associated with the
removed pdev. If another UART device is subsequently unbound, mcf_remove()
will run again, iterate over the array, and call uart_remove_one_port()
using the dangling pointer from the previously freed device.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013120831.1046=
590-1-gerg@linux-m68k.org?part=3D3
