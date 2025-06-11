Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56889287519;
	Wed, 11 Jun 2025 13:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749648089; cv=none; b=o5L0PtpCSbQACwtwQY/mftW6uXt4ElYCLrMyqWVb22sLU3F7J9Uo+stjyOHkLpDoxkFsUfaYgbvWrQs4gwZr6Xs6XW8HLTEOHSA7ZvLbK/NbFbfebeINQAR7PehPrz9jsP05hdCxzyTWpDTiq46GBPJmlxTosCCRVOVWx+ItUKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749648089; c=relaxed/simple;
	bh=63Ypwf8QBn8D7Q7UwXfVEEfH5zk40Vxo36OO1424U68=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=tnZY7dFosP+M3wBh03kwYS1bTinqiGrCAAE+RyCktEn+JO/kWxsiuvjlYnMg3aoS8EvOqtdPJK07InvDJoZi/TGxvcXHGiZMJP66pUiq85useQkW5AdjH7oS7SaxbwtWZS8v5v7pMD51kjJDbHk1UGP4Gw0lEVTrbsKOCH9JyB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mCydYCY5; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mCydYCY5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749648088; x=1781184088;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=63Ypwf8QBn8D7Q7UwXfVEEfH5zk40Vxo36OO1424U68=;
  b=mCydYCY5AuKMoYGTwfa2dlcYRHLvjgiBJ1/x5Fl+VPe8Wjq8poa3GSnO
   SO2VeN795BEQdjS68AEtS15s9mKh3/hczzqWQS1uN9GhzQdzEjSzHo/oZ
   mAyj3zVjAHVL1wT+in1F0dLgm8mXN6b3MYhGDVgCKVn/t9lZQElDTh5yW
   xd9nKsIgkmaksGThA6SvSgBlIX6YnMecA74gJFbcOrZ5kl9S7MewX4rB6
   C9Vyov3jroG8V80XQrbDElESxNzpXbwUeRyA/572TGlQqtYN0t2kALy1a
   1hICDoJX7j9qanJOv3Z9G3ERZmhPYRViSlCRqEbBFwfNrH87X9vdW0b9h
   Q==;
X-CSE-ConnectionGUID: eSAa1Lk2Tq2tJFQKg1At8A==
X-CSE-MsgGUID: 4KyvxRdXQ1CBjX+phIxlbg==
X-IronPort-AV: E=McAfee;i="6800,10657,11461"; a="51928100"
X-IronPort-AV: E=Sophos;i="6.16,227,1744095600"; 
   d="scan'208";a="51928100"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2025 06:21:27 -0700
X-CSE-ConnectionGUID: qoOkOkclT2WQ9yhIwCD9dw==
X-CSE-MsgGUID: mv2QX6GGTOmVrUFNthzZzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,227,1744095600"; 
   d="scan'208";a="152474038"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.183])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2025 06:21:24 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 11 Jun 2025 16:21:20 +0300 (EEST)
To: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
cc: gregkh@linuxfoundation.org, linux-serial@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH 30/33] serial: 8250: invert serial8250_register_8250_port()
 CIR condition
In-Reply-To: <20250611100319.186924-31-jirislaby@kernel.org>
Message-ID: <d95339c7-92d5-5f71-f159-e45f4c273a7e@linux.intel.com>
References: <20250611100319.186924-1-jirislaby@kernel.org> <20250611100319.186924-31-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-122357125-1749648080=:957"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-122357125-1749648080=:957
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 11 Jun 2025, Jiri Slaby (SUSE) wrote:

> There is no point in a long 'if' in serial8250_register_8250_port() to
> just return ENOSPC for PORT_8250_CIR ports. Invert the condition and
> return immediately.
>=20
> 'gpios' variable was moved to its set location.
>=20
> And return ENODEV instead of ENOSPC. The latter is a leftover from the
> previous find-uart 'if'. The former makes a lot more sense in this case.
>=20
> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
> ---
>  drivers/tty/serial/8250/8250_core.c | 253 ++++++++++++++--------------
>  1 file changed, 127 insertions(+), 126 deletions(-)
>=20
> diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/825=
0/8250_core.c
> index 2bac9c7827de..10f25bae9f46 100644
> --- a/drivers/tty/serial/8250/8250_core.c
> +++ b/drivers/tty/serial/8250/8250_core.c
> @@ -725,139 +725,140 @@ int serial8250_register_8250_port(const struct ua=
rt_8250_port *up)
>  =09=09nr_uarts++;
>  =09}
> =20
> -=09if (uart->port.type !=3D PORT_8250_CIR) {
> -=09=09struct mctrl_gpios *gpios;
> -
> -=09=09if (uart->port.dev)
> -=09=09=09uart_remove_one_port(&serial8250_reg, &uart->port);
> -
> -=09=09uart->port.ctrl_id=09=3D up->port.ctrl_id;
> -=09=09uart->port.port_id=09=3D up->port.port_id;
> -=09=09uart->port.iobase       =3D up->port.iobase;
> -=09=09uart->port.membase      =3D up->port.membase;
> -=09=09uart->port.irq          =3D up->port.irq;
> -=09=09uart->port.irqflags     =3D up->port.irqflags;
> -=09=09uart->port.uartclk      =3D up->port.uartclk;
> -=09=09uart->port.fifosize     =3D up->port.fifosize;
> -=09=09uart->port.regshift     =3D up->port.regshift;
> -=09=09uart->port.iotype       =3D up->port.iotype;
> -=09=09uart->port.flags        =3D up->port.flags | UPF_BOOT_AUTOCONF;
> -=09=09uart->bugs=09=09=3D up->bugs;
> -=09=09uart->port.mapbase      =3D up->port.mapbase;
> -=09=09uart->port.mapsize      =3D up->port.mapsize;
> -=09=09uart->port.private_data =3D up->port.private_data;
> -=09=09uart->tx_loadsz=09=09=3D up->tx_loadsz;
> -=09=09uart->capabilities=09=3D up->capabilities;
> -=09=09uart->port.throttle=09=3D up->port.throttle;
> -=09=09uart->port.unthrottle=09=3D up->port.unthrottle;
> -=09=09uart->port.rs485_config=09=3D up->port.rs485_config;
> -=09=09uart->port.rs485_supported =3D up->port.rs485_supported;
> -=09=09uart->port.rs485=09=3D up->port.rs485;
> -=09=09uart->rs485_start_tx=09=3D up->rs485_start_tx;
> -=09=09uart->rs485_stop_tx=09=3D up->rs485_stop_tx;
> -=09=09uart->lsr_save_mask=09=3D up->lsr_save_mask;
> -=09=09uart->dma=09=09=3D up->dma;
> -
> -=09=09/* Take tx_loadsz from fifosize if it wasn't set separately */
> -=09=09if (uart->port.fifosize && !uart->tx_loadsz)
> -=09=09=09uart->tx_loadsz =3D uart->port.fifosize;
> -
> -=09=09if (up->port.dev) {
> -=09=09=09uart->port.dev =3D up->port.dev;
> -=09=09=09ret =3D uart_get_rs485_mode(&uart->port);
> -=09=09=09if (ret)
> -=09=09=09=09goto err;
> -=09=09}
> +=09if (uart->port.type =3D=3D PORT_8250_CIR) {
> +=09=09ret =3D -ENODEV;
> +=09=09goto unlock;
> +=09}
> =20
> -=09=09if (up->port.flags & UPF_FIXED_TYPE)
> -=09=09=09uart->port.type =3D up->port.type;
> +=09if (uart->port.dev)
> +=09=09uart_remove_one_port(&serial8250_reg, &uart->port);
> +
> +=09uart->port.ctrl_id=09=3D up->port.ctrl_id;
> +=09uart->port.port_id=09=3D up->port.port_id;
> +=09uart->port.iobase       =3D up->port.iobase;
> +=09uart->port.membase      =3D up->port.membase;
> +=09uart->port.irq          =3D up->port.irq;
> +=09uart->port.irqflags     =3D up->port.irqflags;
> +=09uart->port.uartclk      =3D up->port.uartclk;
> +=09uart->port.fifosize     =3D up->port.fifosize;
> +=09uart->port.regshift     =3D up->port.regshift;
> +=09uart->port.iotype       =3D up->port.iotype;
> +=09uart->port.flags        =3D up->port.flags | UPF_BOOT_AUTOCONF;
> +=09uart->bugs=09=09=3D up->bugs;
> +=09uart->port.mapbase      =3D up->port.mapbase;
> +=09uart->port.mapsize      =3D up->port.mapsize;
> +=09uart->port.private_data =3D up->port.private_data;
> +=09uart->tx_loadsz=09=09=3D up->tx_loadsz;
> +=09uart->capabilities=09=3D up->capabilities;
> +=09uart->port.throttle=09=3D up->port.throttle;
> +=09uart->port.unthrottle=09=3D up->port.unthrottle;
> +=09uart->port.rs485_config=09=3D up->port.rs485_config;
> +=09uart->port.rs485_supported =3D up->port.rs485_supported;
> +=09uart->port.rs485=09=3D up->port.rs485;
> +=09uart->rs485_start_tx=09=3D up->rs485_start_tx;
> +=09uart->rs485_stop_tx=09=3D up->rs485_stop_tx;
> +=09uart->lsr_save_mask=09=3D up->lsr_save_mask;
> +=09uart->dma=09=09=3D up->dma;
> +
> +=09/* Take tx_loadsz from fifosize if it wasn't set separately */
> +=09if (uart->port.fifosize && !uart->tx_loadsz)
> +=09=09uart->tx_loadsz =3D uart->port.fifosize;
> +
> +=09if (up->port.dev) {
> +=09=09uart->port.dev =3D up->port.dev;
> +=09=09ret =3D uart_get_rs485_mode(&uart->port);
> +=09=09if (ret)
> +=09=09=09goto err;
> +=09}
> =20
> -=09=09/*
> -=09=09 * Only call mctrl_gpio_init(), if the device has no ACPI
> -=09=09 * companion device
> -=09=09 */
> -=09=09if (!has_acpi_companion(uart->port.dev)) {
> -=09=09=09gpios =3D mctrl_gpio_init(&uart->port, 0);
> -=09=09=09if (IS_ERR(gpios)) {
> -=09=09=09=09ret =3D PTR_ERR(gpios);
> -=09=09=09=09goto err;
> -=09=09=09} else {
> -=09=09=09=09uart->gpios =3D gpios;
> -=09=09=09}
> -=09=09}
> +=09if (up->port.flags & UPF_FIXED_TYPE)
> +=09=09uart->port.type =3D up->port.type;
> =20
> -=09=09serial8250_set_defaults(uart);
> -
> -=09=09/* Possibly override default I/O functions.  */
> -=09=09if (up->port.serial_in)
> -=09=09=09uart->port.serial_in =3D up->port.serial_in;
> -=09=09if (up->port.serial_out)
> -=09=09=09uart->port.serial_out =3D up->port.serial_out;
> -=09=09if (up->port.handle_irq)
> -=09=09=09uart->port.handle_irq =3D up->port.handle_irq;
> -=09=09/*  Possibly override set_termios call */
> -=09=09if (up->port.set_termios)
> -=09=09=09uart->port.set_termios =3D up->port.set_termios;
> -=09=09if (up->port.set_ldisc)
> -=09=09=09uart->port.set_ldisc =3D up->port.set_ldisc;
> -=09=09if (up->port.get_mctrl)
> -=09=09=09uart->port.get_mctrl =3D up->port.get_mctrl;
> -=09=09if (up->port.set_mctrl)
> -=09=09=09uart->port.set_mctrl =3D up->port.set_mctrl;
> -=09=09if (up->port.get_divisor)
> -=09=09=09uart->port.get_divisor =3D up->port.get_divisor;
> -=09=09if (up->port.set_divisor)
> -=09=09=09uart->port.set_divisor =3D up->port.set_divisor;
> -=09=09if (up->port.startup)
> -=09=09=09uart->port.startup =3D up->port.startup;
> -=09=09if (up->port.shutdown)
> -=09=09=09uart->port.shutdown =3D up->port.shutdown;
> -=09=09if (up->port.pm)
> -=09=09=09uart->port.pm =3D up->port.pm;
> -=09=09if (up->port.handle_break)
> -=09=09=09uart->port.handle_break =3D up->port.handle_break;
> -=09=09if (up->dl_read)
> -=09=09=09uart->dl_read =3D up->dl_read;
> -=09=09if (up->dl_write)
> -=09=09=09uart->dl_write =3D up->dl_write;
> -
> -=09=09if (uart->port.type !=3D PORT_8250_CIR) {
> -=09=09=09if (uart_console_registered(&uart->port))
> -=09=09=09=09pm_runtime_get_sync(uart->port.dev);
> -
> -=09=09=09if (serial8250_isa_config !=3D NULL)
> -=09=09=09=09serial8250_isa_config(0, &uart->port,
> -=09=09=09=09=09=09&uart->capabilities);
> -
> -=09=09=09serial8250_apply_quirks(uart);
> -=09=09=09ret =3D uart_add_one_port(&serial8250_reg,
> -=09=09=09=09=09=09&uart->port);
> -=09=09=09if (ret)
> -=09=09=09=09goto err;
> -
> -=09=09=09ret =3D uart->port.line;
> +=09/*
> +=09 * Only call mctrl_gpio_init(), if the device has no ACPI
> +=09 * companion device
> +=09 */
> +=09if (!has_acpi_companion(uart->port.dev)) {
> +=09=09struct mctrl_gpios *gpios =3D mctrl_gpio_init(&uart->port, 0);
> +=09=09if (IS_ERR(gpios)) {
> +=09=09=09ret =3D PTR_ERR(gpios);
> +=09=09=09goto err;
>  =09=09} else {
> -=09=09=09dev_info(uart->port.dev,
> -=09=09=09=09"skipping CIR port at 0x%lx / 0x%llx, IRQ %d\n",
> -=09=09=09=09uart->port.iobase,
> -=09=09=09=09(unsigned long long)uart->port.mapbase,
> -=09=09=09=09uart->port.irq);
> -
> -=09=09=09ret =3D 0;
> +=09=09=09uart->gpios =3D gpios;
>  =09=09}
> +=09}
> =20
> -=09=09if (!uart->lsr_save_mask)
> -=09=09=09uart->lsr_save_mask =3D LSR_SAVE_FLAGS;=09/* Use default LSR ma=
sk */
> +=09serial8250_set_defaults(uart);
> +
> +=09/* Possibly override default I/O functions.  */
> +=09if (up->port.serial_in)
> +=09=09uart->port.serial_in =3D up->port.serial_in;
> +=09if (up->port.serial_out)
> +=09=09uart->port.serial_out =3D up->port.serial_out;
> +=09if (up->port.handle_irq)
> +=09=09uart->port.handle_irq =3D up->port.handle_irq;
> +=09/*  Possibly override set_termios call */
> +=09if (up->port.set_termios)
> +=09=09uart->port.set_termios =3D up->port.set_termios;
> +=09if (up->port.set_ldisc)
> +=09=09uart->port.set_ldisc =3D up->port.set_ldisc;
> +=09if (up->port.get_mctrl)
> +=09=09uart->port.get_mctrl =3D up->port.get_mctrl;
> +=09if (up->port.set_mctrl)
> +=09=09uart->port.set_mctrl =3D up->port.set_mctrl;
> +=09if (up->port.get_divisor)
> +=09=09uart->port.get_divisor =3D up->port.get_divisor;
> +=09if (up->port.set_divisor)
> +=09=09uart->port.set_divisor =3D up->port.set_divisor;
> +=09if (up->port.startup)
> +=09=09uart->port.startup =3D up->port.startup;
> +=09if (up->port.shutdown)
> +=09=09uart->port.shutdown =3D up->port.shutdown;
> +=09if (up->port.pm)
> +=09=09uart->port.pm =3D up->port.pm;
> +=09if (up->port.handle_break)
> +=09=09uart->port.handle_break =3D up->port.handle_break;
> +=09if (up->dl_read)
> +=09=09uart->dl_read =3D up->dl_read;
> +=09if (up->dl_write)
> +=09=09uart->dl_write =3D up->dl_write;
> =20
> -=09=09/* Initialise interrupt backoff work if required */
> -=09=09if (up->overrun_backoff_time_ms > 0) {
> -=09=09=09uart->overrun_backoff_time_ms =3D
> -=09=09=09=09up->overrun_backoff_time_ms;
> -=09=09=09INIT_DELAYED_WORK(&uart->overrun_backoff,
> -=09=09=09=09=09serial_8250_overrun_backoff_work);
> -=09=09} else {
> -=09=09=09uart->overrun_backoff_time_ms =3D 0;
> -=09=09}
> +=09if (uart->port.type !=3D PORT_8250_CIR) {
> +=09=09if (uart_console_registered(&uart->port))
> +=09=09=09pm_runtime_get_sync(uart->port.dev);
> +
> +=09=09if (serial8250_isa_config !=3D NULL)
> +=09=09=09serial8250_isa_config(0, &uart->port,
> +=09=09=09=09=09&uart->capabilities);
> +
> +=09=09serial8250_apply_quirks(uart);
> +=09=09ret =3D uart_add_one_port(&serial8250_reg,
> +=09=09=09=09=09&uart->port);
> +=09=09if (ret)
> +=09=09=09goto err;
> +
> +=09=09ret =3D uart->port.line;
> +=09} else {
> +=09=09dev_info(uart->port.dev,
> +=09=09=09"skipping CIR port at 0x%lx / 0x%llx, IRQ %d\n",
> +=09=09=09uart->port.iobase,
> +=09=09=09(unsigned long long)uart->port.mapbase,
> +=09=09=09uart->port.irq);
> +
> +=09=09ret =3D 0;
> +=09}
> +
> +=09if (!uart->lsr_save_mask)
> +=09=09uart->lsr_save_mask =3D LSR_SAVE_FLAGS;=09/* Use default LSR mask =
*/
> +
> +=09/* Initialise interrupt backoff work if required */
> +=09if (up->overrun_backoff_time_ms > 0) {
> +=09=09uart->overrun_backoff_time_ms =3D
> +=09=09=09up->overrun_backoff_time_ms;
> +=09=09INIT_DELAYED_WORK(&uart->overrun_backoff,
> +=09=09=09=09serial_8250_overrun_backoff_work);
> +=09} else {
> +=09=09uart->overrun_backoff_time_ms =3D 0;
>  =09}
> =20
>  unlock:
>=20

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.

--8323328-122357125-1749648080=:957--
