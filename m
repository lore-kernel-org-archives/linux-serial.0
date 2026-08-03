Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17F4532B126;
	Mon,  3 Aug 2026 19:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785784962; cv=none; b=tFHF7lfkPwT3jJTPaMpAGLYJQmMLNxzE1mv2Qqv5u5JW0N2a8TcLkGmwV3tQoV5JofWRqDzW8CKMMBLyGDHqkFdtWVavQB6wV5P8YNw6x8JieQbiVo2KsWy1zaMo80iPUrS6RcfRqujHCo72ybEwyoRc95TOvMDAWzV7tC1wbOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785784962; c=relaxed/simple;
	bh=Zf0XHIFkeb4SckG0q0yrKKovdnSGJMqfp6teTltMXsk=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=csIzZbCQT+90AsGxZlLwjZTfPoR2TOEJSzmUmg71t3h6WbAGUf+Zr+d8A8yTc9iMDS65RR5T0dxILLO8mVR2/pSH+EYObVPZCyvZunkoOBKidLbhT8Y2g8Psaj7KUnuPt+OhZde+kMF2d3I/7RdA0vZqk+eB1/7Xb8cYbr7P3NI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=TCXZPT9m; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="TCXZPT9m"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=default; h=Content-Transfer-Encoding:Mime-Version:Message-Id:Subject:Cc:
	To:From:Date:subject:date:message-id:reply-to;
	bh=h+UEWEErTc6A8C9Q3IWQ3i+XYJQrDyBw8GNDLItRhOg=; b=TCXZPT9mnlaaJ4MQsXdUsO29Fs
	TUQ4RMeAc+U57fKeVU9ktZZAeLJlUN9uk8rRwZBgwskWof7ZLMF+P15n4hKPEBf04n/+yncLNcsaY
	eVc2s6VphAmYkXbR+1R9qd0rn4d6mALtw7n4XvK6TdzjoGmtkEJcZ31EFpuZ7lruyrDk=;
Received: from modemcable061.19-161-184.mc.videotron.ca ([184.161.19.61] helo=pettiford.lan)
	by mail.hugovil.com with esmtpa (Exim 4.98.2)
	(envelope-from <hugo@hugovil.com>)
	id 1wqyF2-000000008VP-3ExY;
	Mon, 03 Aug 2026 15:22:29 -0400
Date: Mon, 3 Aug 2026 15:22:28 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
To: Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby
 <jirislaby@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
 <skhan@linuxfoundation.org>, John Ogness <john.ogness@linutronix.de>,
 Stepan Ionichev <sozdayvek@gmail.com>, Fushuai Wang
 <wangfushuai@baidu.com>, Osama Abdelkader <osama.abdelkader@gmail.com>,
 Hugo Villeneuve <hvilleneuve@dimonoff.com>, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v1 3/6] serial: 8250: Make uart_match_port() a 8250
 specific function
Message-Id: <20260803152228.9e3cd296a41e68304b82a22a@hugovil.com>
In-Reply-To: <8f707b41d462afcf7a2237869adece5fc16a9a77.1785489518.git.ukleinek@kernel.org>
References: <cover.1785489518.git.ukleinek@kernel.org>
	<8f707b41d462afcf7a2237869adece5fc16a9a77.1785489518.git.ukleinek@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
X-Spam_score: -2.0
X-Spam_bar: --

Hi Uwe,

On Fri, 31 Jul 2026 11:39:06 +0200
Uwe Kleine-K=F6nig <ukleinek@kernel.org> wrote:

> The 8250 driver conglomerate is the only user of this function and in
> fact it already is 8250 specific as it uses hub6_match_port() which is
> defined in drivers/tty/serial/8250/8250_hub6.c unless the dummy
> implementation is in use.
>=20
> Signed-off-by: Uwe Kleine-K=F6nig <ukleinek@kernel.org>
> ---
>  Documentation/driver-api/serial/driver.rst |  2 +-
>  drivers/tty/serial/8250/8250_core.c        | 27 +++++++++++++++++++++-
>  drivers/tty/serial/serial_core.c           | 27 ----------------------
>  include/linux/serial_core.h                |  2 --
>  4 files changed, 27 insertions(+), 31 deletions(-)
>=20
> diff --git a/Documentation/driver-api/serial/driver.rst b/Documentation/d=
river-api/serial/driver.rst
> index c1db6a1a67c4..975b0ba53e98 100644
> --- a/Documentation/driver-api/serial/driver.rst
> +++ b/Documentation/driver-api/serial/driver.rst
> @@ -70,7 +70,7 @@ Other functions
> =20
>  .. kernel-doc:: drivers/tty/serial/serial_core.c
>     :identifiers: uart_update_timeout uart_get_baud_rate uart_get_divisor
> -           uart_match_port uart_write_wakeup uart_register_driver
> +           uart_write_wakeup uart_register_driver
>             uart_unregister_driver uart_suspend_port uart_resume_port
>             uart_add_one_port uart_remove_one_port uart_console_write
>             uart_parse_earlycon uart_parse_options uart_set_options
> diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/825=
0/8250_core.c
> index c0e8a4efbdcc..6059b84d8364 100644
> --- a/drivers/tty/serial/8250/8250_core.c
> +++ b/drivers/tty/serial/8250/8250_core.c
> @@ -630,6 +630,31 @@ EXPORT_SYMBOL(serial8250_resume_port);
>   */
>  static DEFINE_MUTEX(serial_mutex);
> =20
> +/**
> + * serial8250_match_port - are the two ports equivalent?
> + * @port1: first port
> + * @port2: second port
> + *
> + * This utility function can be used to determine whether two uart_port
> + * structures describe the same port.
> + */
> +static bool serial8250_match_port(const struct uart_port *port1,
> +				  const struct uart_port *port2)
> +{
> +	if (port1->iotype !=3D port2->iotype)
> +		return false;
> +	else if (port1->iotype =3D=3D UPIO_PORT)
> +		return port1->iobase =3D=3D port2->iobase;
> +	else if (port1->iotype =3D=3D UPIO_HUB6)
> +		return hub6_match_port(port1, port2);
> +	else if (uart_iotype_mmio(port1->iotype))
> +		return port1->mapbase =3D=3D port2->mapbase;
> +	else if (port1->iotype =3D=3D UPIO_BUS)
> +		return true;

Since this is now moved to 8250-only context, UPIO_BUS case can
probably be dropped.


> +	else
> +		return false;
> +}
> +
>  static struct uart_8250_port *serial8250_find_match_or_unused(const stru=
ct uart_port *port)
>  {
>  	int i;
> @@ -638,7 +663,7 @@ static struct uart_8250_port *serial8250_find_match_o=
r_unused(const struct uart_
>  	 * First, find a port entry which matches.
>  	 */
>  	for (i =3D 0; i < nr_uarts; i++)
> -		if (uart_match_port(&serial8250_ports[i].port, port))
> +		if (serial8250_match_port(&serial8250_ports[i].port, port))
>  			return &serial8250_ports[i];
> =20
>  	/* try line number first if still available */
> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial=
_core.c
> index edd1e7be2a5c..8a6c53a9996e 100644
> --- a/drivers/tty/serial/serial_core.c
> +++ b/drivers/tty/serial/serial_core.c
> @@ -33,7 +33,6 @@
>  #include <linux/uaccess.h>
> =20
>  #include "serial_base.h"
> -#include "8250/8250.h" /* For hub6_match_port() */
> =20
>  /*
>   * This is used to lock changes in serial line configuration.
> @@ -3229,32 +3228,6 @@ static void serial_core_remove_one_port(struct uar=
t_driver *drv,
>  	state->uart_port =3D NULL;
>  }
> =20
> -/**
> - * uart_match_port - are the two ports equivalent?
> - * @port1: first port
> - * @port2: second port
> - *
> - * This utility function can be used to determine whether two uart_port
> - * structures describe the same port.
> - */
> -bool uart_match_port(const struct uart_port *port1,
> -		const struct uart_port *port2)
> -{
> -	if (port1->iotype !=3D port2->iotype)
> -		return false;
> -	else if (port1->iotype =3D=3D UPIO_PORT)
> -		return port1->iobase =3D=3D port2->iobase;
> -	else if (port1->iotype =3D=3D UPIO_HUB6)
> -		return hub6_match_port(port1, port2);
> -	else if (uart_iotype_mmio(port1->iotype))
> -		return port1->mapbase =3D=3D port2->mapbase;
> -	else if (port1->iotype =3D=3D UPIO_BUS)
> -		return true;
> -	else
> -		return false;
> -}
> -EXPORT_SYMBOL(uart_match_port);
> -
>  static struct serial_ctrl_device *
>  serial_core_get_ctrl_dev(struct serial_port_device *port_dev)
>  {
> diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
> index c4cc4f66af4b..1659805e2233 100644
> --- a/include/linux/serial_core.h
> +++ b/include/linux/serial_core.h
> @@ -1137,8 +1137,6 @@ int uart_add_one_port(struct uart_driver *reg, stru=
ct uart_port *port);
>  void uart_remove_one_port(struct uart_driver *reg, struct uart_port *por=
t);
>  int uart_read_port_properties(struct uart_port *port);
>  int uart_read_and_validate_port_properties(struct uart_port *port);
> -bool uart_match_port(const struct uart_port *port1,
> -		const struct uart_port *port2);
> =20
>  /*
>   * Power Management
> --=20
> 2.55.0.11.g153666a7d9bb
>=20
>=20
>=20


--=20
Hugo Villeneuve
