Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE5E02777FE;
	Wed, 11 Jun 2025 12:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749643682; cv=none; b=ZuP8isyT1Zz9cN3RD1tTMAjiUeL+JvUETxu/af0r2Ib521HLt4F+Vy4ay99SVyXlKbWC33XLg45GMVrEYy2A9ni3Fyk6dLQtm9i8P6rjpbjljFskGH7bebpLmGhZVS7TFtSm7ubtdHUvYD3kMv5Mkr3hJG4eC2o0lMjG7SuEZpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749643682; c=relaxed/simple;
	bh=gAtOn3IEDCFoyVBpxSx+9nzPNntzg/89KNvpVHNO5kI=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=BJOd6zBAyFKeyuyUi7nIelIEDLceKov95tUOiECPSlFthTrdmoGPOXitX4F3ZkoxD2DlL/jGRCHzIXL7MjIBwA1SMB6xdcKq8xb7dH5DCD8Vi87sEjUSBCB+yw4cmH01iTR4urDU4T3WHKptCfE5pBWsqvmP4MjQUuWpz5hEBCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l64YWIB2; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l64YWIB2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749643681; x=1781179681;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=gAtOn3IEDCFoyVBpxSx+9nzPNntzg/89KNvpVHNO5kI=;
  b=l64YWIB2157vChqqDIYA9LIHeHOwKiE4ve7THzcphJbLGaQZDiyhXqVH
   kSf4KTD2Ovb/u27sHJSekZlm8AV/Fj2SF1/Hj/Tb7eDBS3PVwMrFsJo/Y
   JPEKKGUdVmyPXoPraQ1RpCw6H2IlxS8k2kYgWTvhP9Ls+RzDeA3DYP7oO
   SZj3eY7Owy41N6RMhTBt8Iywi5RNvoNP58C1AlRo/dCfNDysIH0luy87S
   58bhH3Yq4MqwQKM2wqGrsfMxXl59EvM5h3qJOTwTZmNzvxcZLNgR2lzEx
   h96e50pj/PCJM7jiVcdTxAmK4izeO2jpc3LjFJMOxIZL1fVpM7sS3p4Yj
   g==;
X-CSE-ConnectionGUID: 4JGYwJ3MQ4O24+6FuHZAZQ==
X-CSE-MsgGUID: v759A6BmSUm4w+F3zDcXwg==
X-IronPort-AV: E=McAfee;i="6800,10657,11460"; a="39402797"
X-IronPort-AV: E=Sophos;i="6.16,227,1744095600"; 
   d="scan'208";a="39402797"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2025 05:08:00 -0700
X-CSE-ConnectionGUID: XaMO6fXVSlypurRn9yK/mw==
X-CSE-MsgGUID: fsaJqPs2Tsm7vUHR2lenYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,227,1744095600"; 
   d="scan'208";a="147096587"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.183])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2025 05:07:58 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 11 Jun 2025 15:07:53 +0300 (EEST)
To: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
cc: gregkh@linuxfoundation.org, linux-serial@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH 14/33] serial: 8250: extract
 serial8250_set_TRG_levels()
In-Reply-To: <20250611100319.186924-15-jirislaby@kernel.org>
Message-ID: <10916f86-b010-8dbf-9100-5f8198c1f37b@linux.intel.com>
References: <20250611100319.186924-1-jirislaby@kernel.org> <20250611100319.186924-15-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1527717672-1749643673=:957"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1527717672-1749643673=:957
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 11 Jun 2025, Jiri Slaby (SUSE) wrote:

> serial8250_do_startup() contains peculiar trigger levels setup for
> special ports (16850, ALTR_16550_*). Move this away to a separate
> function: serial8250_set_TRG_levels().
>=20
> And use switch-case instead of 'if's.

At this point of series I was already expecting this will come. :-)
Another nice cleanup.

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.

> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
> ---
>  drivers/tty/serial/8250/8250_port.c | 77 +++++++++++++++--------------
>  1 file changed, 41 insertions(+), 36 deletions(-)
>=20
> diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/825=
0/8250_port.c
> index 21ff56a31b56..c09a90b38d8f 100644
> --- a/drivers/tty/serial/8250/8250_port.c
> +++ b/drivers/tty/serial/8250/8250_port.c
> @@ -2159,6 +2159,46 @@ static void serial8250_startup_special(struct uart=
_port *port)
>  =09}
>  }
> =20
> +static void serial8250_set_TRG_levels(struct uart_port *port)
> +{
> +=09struct uart_8250_port *up =3D up_to_u8250p(port);
> +
> +=09switch (port->type) {
> +=09/* For a XR16C850, we need to set the trigger levels */
> +=09case PORT_16850: {
> +=09=09u8 fctr;
> +
> +=09=09serial_out(up, UART_LCR, UART_LCR_CONF_MODE_B);
> +
> +=09=09fctr =3D serial_in(up, UART_FCTR) & ~(UART_FCTR_RX|UART_FCTR_TX);
> +=09=09fctr |=3D UART_FCTR_TRGD;
> +=09=09serial_port_out(port, UART_FCTR, fctr | UART_FCTR_RX);
> +=09=09serial_port_out(port, UART_TRG, UART_TRG_96);
> +=09=09serial_port_out(port, UART_FCTR, fctr | UART_FCTR_TX);
> +=09=09serial_port_out(port, UART_TRG, UART_TRG_96);
> +
> +=09=09serial_port_out(port, UART_LCR, 0);
> +=09=09break;
> +=09}
> +=09/* For the Altera 16550 variants, set TX threshold trigger level. */
> +=09case PORT_ALTR_16550_F32:
> +=09case PORT_ALTR_16550_F64:
> +=09case PORT_ALTR_16550_F128:
> +=09=09if (port->fifosize <=3D 1)
> +=09=09=09return;
> +
> +=09=09/* Bounds checking of TX threshold (valid 0 to fifosize-2) */
> +=09=09if (up->tx_loadsz < 2 || up->tx_loadsz > port->fifosize) {
> +=09=09=09dev_err(port->dev, "TX FIFO Threshold errors, skipping\n");
> +=09=09=09return;
> +=09=09}
> +=09=09serial_port_out(port, UART_ALTR_AFR, UART_ALTR_EN_TXFIFO_LW);
> +=09=09serial_port_out(port, UART_ALTR_TX_LOW, port->fifosize - up->tx_lo=
adsz);
> +=09=09port->handle_irq =3D serial8250_tx_threshold_handle_irq;
> +=09=09break;
> +=09}
> +}
> +
>  int serial8250_do_startup(struct uart_port *port)
>  {
>  =09struct uart_8250_port *up =3D up_to_u8250p(port);
> @@ -2208,42 +2248,7 @@ int serial8250_do_startup(struct uart_port *port)
>  =09=09goto out;
>  =09}
> =20
> -=09/*
> -=09 * For a XR16C850, we need to set the trigger levels
> -=09 */
> -=09if (port->type =3D=3D PORT_16850) {
> -=09=09unsigned char fctr;
> -
> -=09=09serial_out(up, UART_LCR, UART_LCR_CONF_MODE_B);
> -
> -=09=09fctr =3D serial_in(up, UART_FCTR) & ~(UART_FCTR_RX|UART_FCTR_TX);
> -=09=09serial_port_out(port, UART_FCTR,
> -=09=09=09=09fctr | UART_FCTR_TRGD | UART_FCTR_RX);
> -=09=09serial_port_out(port, UART_TRG, UART_TRG_96);
> -=09=09serial_port_out(port, UART_FCTR,
> -=09=09=09=09fctr | UART_FCTR_TRGD | UART_FCTR_TX);
> -=09=09serial_port_out(port, UART_TRG, UART_TRG_96);
> -
> -=09=09serial_port_out(port, UART_LCR, 0);
> -=09}
> -
> -=09/*
> -=09 * For the Altera 16550 variants, set TX threshold trigger level.
> -=09 */
> -=09if (((port->type =3D=3D PORT_ALTR_16550_F32) ||
> -=09     (port->type =3D=3D PORT_ALTR_16550_F64) ||
> -=09     (port->type =3D=3D PORT_ALTR_16550_F128)) && (port->fifosize > 1=
)) {
> -=09=09/* Bounds checking of TX threshold (valid 0 to fifosize-2) */
> -=09=09if ((up->tx_loadsz < 2) || (up->tx_loadsz > port->fifosize)) {
> -=09=09=09dev_err(port->dev, "TX FIFO Threshold errors, skipping\n");
> -=09=09} else {
> -=09=09=09serial_port_out(port, UART_ALTR_AFR,
> -=09=09=09=09=09UART_ALTR_EN_TXFIFO_LW);
> -=09=09=09serial_port_out(port, UART_ALTR_TX_LOW,
> -=09=09=09=09=09port->fifosize - up->tx_loadsz);
> -=09=09=09port->handle_irq =3D serial8250_tx_threshold_handle_irq;
> -=09=09}
> -=09}
> +=09serial8250_set_TRG_levels(port);
> =20
>  =09/* Check if we need to have shared IRQs */
>  =09if (port->irq && (up->port.flags & UPF_SHARE_IRQ))
>=20
--8323328-1527717672-1749643673=:957--
