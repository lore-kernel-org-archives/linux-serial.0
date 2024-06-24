Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDB0E47F5F
	for <linux-serial@vger.kernel.org>; Mon, 24 Jun 2024 07:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719215740; cv=none; b=k4j80uEjslEZBsJNfhmrDxS3N8XQCdWKeZDajK3Dj4x+QOFgTEvWAz8UY4r+CCodz2hJxBdd/HNn4Rt+96l9QLv4OTecSlz/kwU9pHXWg9boLnZ6fumpW7R3n1LZ3tAg6uOXloaqGbfajwALranSXcZukbU9ST30/yNXbO9CRzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719215740; c=relaxed/simple;
	bh=O4J/qLYevhSKQ6BsWs9p5FrpyastHyauN3q7QN3/bYg=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=kCh+veCGCDjVi5UoOSg7aMgjnvwIGMWY0RLQuSSMiLfduMvRoLPfAeuruDxEPsQK0VadUgHXrqvVKnIMz/bs0aw4FytCQ7d6KjEQ2RFNsyUGOH7NNNhDX8XwayZ5T4SEsnTCqoVyyhyg2Oh2A2J+HMo917Wn3r3bYlq4TEaq8Zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Xpxr2OI8; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Xpxr2OI8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719215739; x=1750751739;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=O4J/qLYevhSKQ6BsWs9p5FrpyastHyauN3q7QN3/bYg=;
  b=Xpxr2OI8/86JLy80rEgMavxqYBuUlY1DheqSy7NbYLAJkIaCgliQgnFy
   pryw0NfMSlwPgF/CC6ATnCWi1i6oFEFzHcNjmk5vE/bBUIdArR5xN5HsS
   03jVC99zwi8YjrbizMmuaw4kIto3qQSQsYDBYhz9G7vk75o0yHQsHoAWo
   0M51FcC1QSTFQ6rKXVrd3Cfb5NH4L2OSn4vZbQcO3uXLM54wvqdx495L0
   9H1pCFYAZaZDwVB9w1CmmJ6EbD8BZIBfw4XOo+rhz2HPFiuuqBAxdXF0d
   /pAwVVJ5vCnRN8poLa42K7m0Eqh4ZQONZIRFjlaUOJ8XqnwLgA+erjxtj
   w==;
X-CSE-ConnectionGUID: lnb4/PSzSuuGGEQoQkxLvQ==
X-CSE-MsgGUID: oylMXsk4Qjm7svY4gpcpGQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11112"; a="16140046"
X-IronPort-AV: E=Sophos;i="6.08,261,1712646000"; 
   d="scan'208";a="16140046"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2024 00:55:39 -0700
X-CSE-ConnectionGUID: gJJRiF3rRIuo56uKZxz+pA==
X-CSE-MsgGUID: /q+5npuaSV6XIilmiwSz+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,261,1712646000"; 
   d="scan'208";a="48164234"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.61])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2024 00:55:37 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 24 Jun 2024 10:55:33 +0300 (EEST)
To: =?ISO-8859-2?Q?Filip_=A9t=ECdronsk=FD?= <r.lkml@regnarg.cz>
cc: linux-serial <linux-serial@vger.kernel.org>
Subject: Re: DW UART EM485 broken because autoconfig resets UART_CAP_NOTEMT
In-Reply-To: <x6mi5lvykjfzk7alvivuuefwc5ya5mykirtrmfcum4t5sgrqaj@icbl5wjgj2h6>
Message-ID: <307ba4bd-f5d5-8df3-3eea-d2ca48372263@linux.intel.com>
References: <x6mi5lvykjfzk7alvivuuefwc5ya5mykirtrmfcum4t5sgrqaj@icbl5wjgj2h6>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-667425279-1719215733=:1031"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-667425279-1719215733=:1031
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Mon, 24 Jun 2024, Filip =C5=A0t=C4=9Bdronsk=C3=BD wrote:

> Hi,
>=20
> it seems that the EM485 mode on Designware UART controller is broken.
> At the start of transmission, the RTS line is correctly asserted, but
> it never gets deasserted.
>=20
> Checked this with a logic analyzer. See:
>=20
>     https://regnarg.cz/tmp/em485_bad.sr (PulseView dump)
>     https://regnarg.cz/tmp/em485_bad.png
>=20
> The test system is FriendlyElec NanoPi Neo-LTS (Allwinner H3).
> For reference, the test userspace program I used:
>=20
>     https://regnarg.cz/tmp/485.c
>=20
> The mechanism seems to be this:
>=20
> - The DW UART driver sets UART_CAP_NOTEMT when creating the port
>   (8250_dwlib.c:dw8250_setup_port) to indicate that the controller
>   does not generate interrupt on emptying the shift register.
>=20
> - This should be then used in 8250_port.c:__stop_tx to use a timer
>   instead of an interrupt to trigger DE deassertion.
>=20
> - However, the port also goes through the 8250 autoconfig mechanism.
>   For my controller, dw8250_setup_port does _not_ set UPF_FIXED_TYPE,
>   so it tries to autodetect port type. As part of this, the
>   up->capabilities field is reset, dropping the UART_CAP_NOTEMT
>   (8250_port.c:autoconfig).
>     * On this particular controller, the Component Version Register
>       (DW_UART_UCV) returns zero, so the dw8250_setup_port function
>       returns after this block:
>=20
>           reg =3D dw8250_readl_ext(p, DW_UART_UCV);
>               return;
>=20
> - Without UART_CAP_NOTEMT, __stop_tx does not set up a timer and instead
>   leaves deasserting DE to an interrupt that never comes.
>=20
> If I hotfix autoconfig to preserve UART_CAP_NOTEMT, the
> EM485 functionality seems to work correctly:
>=20
>=20
> diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/825=
0/8250_port.c
> index 893bc493f662..1c2d24074722 100644
> --- a/drivers/tty/serial/8250/8250_port.c
> +++ b/drivers/tty/serial/8250/8250_port.c
> @@ -1140,6 +1140,7 @@ static void autoconfig(struct uart_8250_port *up)
>  =09struct uart_port *port =3D &up->port;
>  =09unsigned long flags;
>  =09unsigned int old_capabilities;
> +=09unsigned int preserved_capabilities;
> =20
>  =09if (!port->iobase && !port->mapbase && !port->membase)
>  =09=09return;
> @@ -1155,7 +1156,8 @@ static void autoconfig(struct uart_8250_port *up)
>  =09 */
>  =09uart_port_lock_irqsave(port, &flags);
> =20
> -=09up->capabilities =3D 0;
> +=09preserved_capabilities =3D up->capabilities & UART_CAP_NOTEMT;
> +=09up->capabilities =3D preserved_capabilities;
>  =09up->bugs =3D 0;
> =20
>  =09if (!(port->flags & UPF_BUGGY_UART)) {
> @@ -1266,7 +1268,7 @@ static void autoconfig(struct uart_8250_port *up)
> =20
>  =09port->fifosize =3D uart_config[up->port.type].fifo_size;
>  =09old_capabilities =3D up->capabilities;
> -=09up->capabilities =3D uart_config[port->type].flags;
> +=09up->capabilities =3D uart_config[port->type].flags | preserved_capabi=
lities;
>  =09up->tx_loadsz =3D uart_config[port->type].tx_loadsz;
> =20
>  =09if (port->type =3D=3D PORT_UNKNOWN)
>=20
> And the result:
>=20
>     https://regnarg.cz/tmp/em485_good.sr (PulseView dump)
>     https://regnarg.cz/tmp/em485_good.png
>=20
> But I am not quite sure what the 'proper' fix is, as I am missing a lot
> of context regarding the relationship between DW UART, 8250 and the
> various port types.

While this patch fixes the problem (and I'm not strictly against it=20
since this is kind of the minimal fix), it would be good to discuss about=
=20
the fundamental problem behind this, the current autoconfig code is pretty=
=20
all-encompassing.

To me it looks like in this case dw8250 code would want to tell to the=20
autoconfig "please config x, and y, etc. but don't config z". I wonder
if it would be good to start moving towards direction where it's not=20
either-or like UPF_FIXED_TYPE currently is and driver would have=20
finer-grained control over what it wants to get autoconfigured.

If somebody else has some vision on what the autoconfig code should look=20
like, please chim in.

--=20
 i.

--8323328-667425279-1719215733=:1031--
