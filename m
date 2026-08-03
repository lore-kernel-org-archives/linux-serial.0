Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BAC53195F9;
	Mon,  3 Aug 2026 17:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785777840; cv=none; b=eUJbaUhl+8iUfMGuOTYxvJysGdKlNpoPGgEdHa3828oRYeo35Oy/2/GUdF3yyt5HNV2Taknk/A08SCSScTWbMnOPdf5Njx8Im1dO6h2XTVkXEQFQstC8dmHl8qXZFAoC+cpi2w6L8NllLtDW/D6fPEIS0nO00bxM6gOeyZZn8QM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785777840; c=relaxed/simple;
	bh=A6mbnhNrzJK4qOh6Hb3SSxXudhxLb0SfcQiK/pFXkJM=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Tel1vruzcHj4rmJA6R+yQ3a4L5v+wHgpH8wFgohdCwdPmWSrPr7hR9XcDWiEI4Twa3Ysa72FCAR9fUFp0rjj2pVQQJgR9yKwkVeNO4SH8KNBrFywvMea+xNBvTbyUgSvfz8RNI+4SboaPrXu8MNQawuSc98Y7k1ILEDVxGmm6D0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BNbf97Jy; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BNbf97Jy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785777838; x=1817313838;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=A6mbnhNrzJK4qOh6Hb3SSxXudhxLb0SfcQiK/pFXkJM=;
  b=BNbf97JymM/XaC3VfGrZBXQG59ZjcQuHxzJ4z6hlfs1648sEhkXaCjxU
   B9d3Af3esrCOpcBwA/t4wODBy+QqKrKp/1k9OjsM20maJZA6P7v5hsxZW
   yONqmMLC8cOdJ3NBzZXi4qa42jDPmXshvmcEE3DygE8zNjD5n4R/EF8k6
   pc8tAbuDoxTPpCmWN0dBDvxWi2toIC+W4W5EEStAelh05pIAJyolH+Mtx
   yybfG8se2U7ttVoXvZYXL6pKmRGnNauzaEH7PBwi8p9iP97XMLB50fCt2
   FQlrpQ/3t1sjLPN8oAW2B0xIaGm/z431nEPqzBrid9kT2SsYREeU+3Svz
   g==;
X-CSE-ConnectionGUID: H7yiXE+SSvuK30c/Fs3YQA==
X-CSE-MsgGUID: QJOKGQ2fTWeVNtlXMbGC2Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11864"; a="97691397"
X-IronPort-AV: E=Sophos;i="6.25,202,1779174000"; 
   d="scan'208";a="97691397"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2026 10:23:58 -0700
X-CSE-ConnectionGUID: xnMu9EnVR9Oe+dpQ8t+P3g==
X-CSE-MsgGUID: qvsSLgiETcSgZNn0ilJC9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,202,1779174000"; 
   d="scan'208";a="299493968"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.61])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2026 10:23:52 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 3 Aug 2026 20:23:48 +0300 (EEST)
To: =?ISO-8859-15?Q?Uwe_Kleine-K=F6nig?= <ukleinek@kernel.org>
cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Jiri Slaby <jirislaby@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
    Shuah Khan <skhan@linuxfoundation.org>, 
    John Ogness <john.ogness@linutronix.de>, 
    Stepan Ionichev <sozdayvek@gmail.com>, 
    Fushuai Wang <wangfushuai@baidu.com>, 
    Osama Abdelkader <osama.abdelkader@gmail.com>, 
    Hugo Villeneuve <hvilleneuve@dimonoff.com>, 
    LKML <linux-kernel@vger.kernel.org>, 
    linux-serial <linux-serial@vger.kernel.org>, linux-doc@vger.kernel.org
Subject: Re: [PATCH v1 3/6] serial: 8250: Make uart_match_port() a 8250
 specific function
In-Reply-To: <8f707b41d462afcf7a2237869adece5fc16a9a77.1785489518.git.ukleinek@kernel.org>
Message-ID: <bf8293fb-8418-1c60-5fc1-bef476f47f0a@linux.intel.com>
References: <cover.1785489518.git.ukleinek@kernel.org> <8f707b41d462afcf7a2237869adece5fc16a9a77.1785489518.git.ukleinek@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1670649127-1785777828=:1172"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1670649127-1785777828=:1172
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Fri, 31 Jul 2026, Uwe Kleine-K=C3=B6nig wrote:

> The 8250 driver conglomerate is the only user of this function and in

Please write these such that they don't depend on the shortlog. Here "this=
=20
function" lacks any context without assuming one has first read the=20
shortlog.

You have similar problem with "this driver" in patch 2.

--=20
 i.

> fact it already is 8250 specific as it uses hub6_match_port() which is
> defined in drivers/tty/serial/8250/8250_hub6.c unless the dummy
> implementation is in use.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <ukleinek@kernel.org>
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
> +=09=09=09=09  const struct uart_port *port2)
> +{
> +=09if (port1->iotype !=3D port2->iotype)
> +=09=09return false;
> +=09else if (port1->iotype =3D=3D UPIO_PORT)
> +=09=09return port1->iobase =3D=3D port2->iobase;
> +=09else if (port1->iotype =3D=3D UPIO_HUB6)
> +=09=09return hub6_match_port(port1, port2);
> +=09else if (uart_iotype_mmio(port1->iotype))
> +=09=09return port1->mapbase =3D=3D port2->mapbase;
> +=09else if (port1->iotype =3D=3D UPIO_BUS)
> +=09=09return true;
> +=09else
> +=09=09return false;
> +}
> +
>  static struct uart_8250_port *serial8250_find_match_or_unused(const stru=
ct uart_port *port)
>  {
>  =09int i;
> @@ -638,7 +663,7 @@ static struct uart_8250_port *serial8250_find_match_o=
r_unused(const struct uart_
>  =09 * First, find a port entry which matches.
>  =09 */
>  =09for (i =3D 0; i < nr_uarts; i++)
> -=09=09if (uart_match_port(&serial8250_ports[i].port, port))
> +=09=09if (serial8250_match_port(&serial8250_ports[i].port, port))
>  =09=09=09return &serial8250_ports[i];
> =20
>  =09/* try line number first if still available */
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
>  =09state->uart_port =3D NULL;
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
> -=09=09const struct uart_port *port2)
> -{
> -=09if (port1->iotype !=3D port2->iotype)
> -=09=09return false;
> -=09else if (port1->iotype =3D=3D UPIO_PORT)
> -=09=09return port1->iobase =3D=3D port2->iobase;
> -=09else if (port1->iotype =3D=3D UPIO_HUB6)
> -=09=09return hub6_match_port(port1, port2);
> -=09else if (uart_iotype_mmio(port1->iotype))
> -=09=09return port1->mapbase =3D=3D port2->mapbase;
> -=09else if (port1->iotype =3D=3D UPIO_BUS)
> -=09=09return true;
> -=09else
> -=09=09return false;
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
> -=09=09const struct uart_port *port2);
> =20
>  /*
>   * Power Management
>=20
--8323328-1670649127-1785777828=:1172--
