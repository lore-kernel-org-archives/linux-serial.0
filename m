Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06CDC1E485;
	Wed, 11 Jun 2025 13:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749647468; cv=none; b=hFN3sidRKa8avMzJgViAK6AYf9zK3t435nmEAnXtFY6egbM2FOIOTjvU2CvbwHEIExnIAtf/zteZ94mnoufFwUUuzgODUIGeYnpJ4+AnkPGjGg0U6ysMxItNwY1z+P+Wc7HazYlxwivp4dug8cwNAuku2qAeS2JWkupi81QEIGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749647468; c=relaxed/simple;
	bh=cSZVsIPN1cHkaqBFPC9Ie8q2ZJ2qtrUkJm326yMAO9E=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Q6z5UuITiEWcBS+vFo5T5X/DEP6b1qMVZEo5nzHbZ/7pA2Pm2pclOorvJNQsp8BMeBHY5cIFqx7Opjxf+5AZEyJY5RCu+hc6qc3maHd+GtwNpI8ZbjAfzS6NO5+/Tnhdge/z1STku7nux7T0PNQkyJ/8kNslNvOva8pSYxoX3qA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J/fb8npG; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J/fb8npG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749647467; x=1781183467;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=cSZVsIPN1cHkaqBFPC9Ie8q2ZJ2qtrUkJm326yMAO9E=;
  b=J/fb8npGD9Ox36MQ3r1CIldJYKkHEXU6ElPaqFtbwOHb5zF1T3kt8aqK
   i9YC/TBBmqRbXONm1MQtuvGGijjQo4N1abCHx/Tw2YYmvayXbEYq9Nm4u
   zvWOKIym+kRPcWPn6X6duiR2qDKEItTwdPrMfLcDLcSBqTK8irydmZr0e
   S011T1TSH6uVvjIOkI8Y7qP+Ur8lyshNrkfldpihNneZROMayJjlO2bCU
   metWF5X9xnmt19ZVh/9vFvA6DuDL3YoGW8fFmStzLnJJ9eFZnjU5jt6CO
   3Pb7qBMhl48/Btb5uLE8jHO6XRDFh3TECgF1fCGHKs/opQYL68YSV0zle
   w==;
X-CSE-ConnectionGUID: /hjEQNmJQOOs0luc06nZRw==
X-CSE-MsgGUID: 2nNTEJN+SmaH5SvUA1i2RQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11461"; a="51781723"
X-IronPort-AV: E=Sophos;i="6.16,227,1744095600"; 
   d="scan'208";a="51781723"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2025 06:11:05 -0700
X-CSE-ConnectionGUID: qQKHkEaqRQmGtBspaw77Lg==
X-CSE-MsgGUID: j+GLSCtxRQiWN9exlCcwlQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,227,1744095600"; 
   d="scan'208";a="150992864"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.183])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2025 06:11:02 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 11 Jun 2025 16:10:59 +0300 (EEST)
To: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
cc: gregkh@linuxfoundation.org, linux-serial@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH 29/33] serial: 8250: drop DEBUG_AUTOCONF() macro
In-Reply-To: <20250611100319.186924-30-jirislaby@kernel.org>
Message-ID: <d6d4c16d-6665-1638-9156-2ed8dcc090ec@linux.intel.com>
References: <20250611100319.186924-1-jirislaby@kernel.org> <20250611100319.186924-30-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-16933694-1749647459=:957"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-16933694-1749647459=:957
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 11 Jun 2025, Jiri Slaby (SUSE) wrote:

> DEBUG_AUTOCONF() is always disabled (by "#if 0"), so one would need to
> recompile the kernel to use it. And even if they did, they would find
> out it is broken anyway:
>   error: variable 'scratch' is used uninitialized whenever 'if' condition=
 is false
>=20
> Drop it.
>=20
> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
> ---
>  drivers/tty/serial/8250/8250_port.c | 39 ++---------------------------
>  1 file changed, 2 insertions(+), 37 deletions(-)
>=20
> diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/825=
0/8250_port.c
> index 6363915a1787..e93bfdac3d0e 100644
> --- a/drivers/tty/serial/8250/8250_port.c
> +++ b/drivers/tty/serial/8250/8250_port.c
> @@ -38,15 +38,6 @@
> =20
>  #include "8250.h"
> =20
> -/*
> - * Debugging.
> - */
> -#if 0
> -#define DEBUG_AUTOCONF(fmt...)=09printk(fmt)
> -#else
> -#define DEBUG_AUTOCONF(fmt...)=09do { } while (0)
> -#endif
> -
>  /*
>   * Here we define the default xmit fifo size used for each type of UART.
>   */
> @@ -825,8 +816,6 @@ static void autoconfig_has_efr(struct uart_8250_port =
*up)
>  =09id3 =3D serial_icr_read(up, UART_ID3);
>  =09rev =3D serial_icr_read(up, UART_REV);
> =20
> -=09DEBUG_AUTOCONF("950id=3D%02x:%02x:%02x:%02x ", id1, id2, id3, rev);
> -
>  =09if (id1 =3D=3D 0x16 && id2 =3D=3D 0xC9 &&
>  =09    (id3 =3D=3D 0x50 || id3 =3D=3D 0x52 || id3 =3D=3D 0x54)) {
>  =09=09up->port.type =3D PORT_16C950;
> @@ -850,7 +839,6 @@ static void autoconfig_has_efr(struct uart_8250_port =
*up)
>  =09 *  0x14 - XR16C854.
>  =09 */
>  =09id1 =3D autoconfig_read_divisor_id(up);
> -=09DEBUG_AUTOCONF("850id=3D%04x ", id1);
> =20
>  =09id2 =3D id1 >> 8;
>  =09if (id2 =3D=3D 0x10 || id2 =3D=3D 0x12 || id2 =3D=3D 0x14) {
> @@ -937,7 +925,6 @@ static void autoconfig_16550a(struct uart_8250_port *=
up)
>  =09if (serial_in(up, UART_EFR) =3D=3D 0) {
>  =09=09serial_out(up, UART_EFR, 0xA8);
>  =09=09if (serial_in(up, UART_EFR) !=3D 0) {
> -=09=09=09DEBUG_AUTOCONF("EFRv1 ");
>  =09=09=09up->port.type =3D PORT_16650;
>  =09=09=09up->capabilities |=3D UART_CAP_EFR | UART_CAP_SLEEP;
>  =09=09} else {
> @@ -950,8 +937,6 @@ static void autoconfig_16550a(struct uart_8250_port *=
up)
> =20
>  =09=09=09if (status1 =3D=3D UART_IIR_FIFO_ENABLED_16750)
>  =09=09=09=09up->port.type =3D PORT_16550A_FSL64;
> -=09=09=09else
> -=09=09=09=09DEBUG_AUTOCONF("Motorola 8xxx DUART ");
>  =09=09}
>  =09=09serial_out(up, UART_EFR, 0);
>  =09=09return;
> @@ -963,7 +948,6 @@ static void autoconfig_16550a(struct uart_8250_port *=
up)
>  =09 */
>  =09serial_out(up, UART_LCR, UART_LCR_CONF_MODE_B);
>  =09if (serial_in(up, UART_EFR) =3D=3D 0 && !broken_efr(up)) {
> -=09=09DEBUG_AUTOCONF("EFRv2 ");
>  =09=09autoconfig_has_efr(up);
>  =09=09return;
>  =09}
> @@ -1026,8 +1010,6 @@ static void autoconfig_16550a(struct uart_8250_port=
 *up)
> =20
>  =09serial_out(up, UART_LCR, 0);
> =20
> -=09DEBUG_AUTOCONF("iir1=3D%d iir2=3D%d ", status1, status2);
> -
>  =09if (status1 =3D=3D UART_IIR_FIFO_ENABLED_16550A &&
>  =09    status2 =3D=3D UART_IIR_FIFO_ENABLED_16750) {
>  =09=09up->port.type =3D PORT_16750;
> @@ -1056,17 +1038,10 @@ static void autoconfig_16550a(struct uart_8250_po=
rt *up)
>  =09=09=09 * It's an Xscale.
>  =09=09=09 * We'll leave the UART_IER_UUE bit set to 1 (enabled).
>  =09=09=09 */
> -=09=09=09DEBUG_AUTOCONF("Xscale ");
>  =09=09=09up->port.type =3D PORT_XSCALE;
>  =09=09=09up->capabilities |=3D UART_CAP_UUE | UART_CAP_RTOIE;
>  =09=09=09return;
>  =09=09}
> -=09} else {
> -=09=09/*
> -=09=09 * If we got here we couldn't force the IER_UUE bit to 0.
> -=09=09 * Log it and continue.
> -=09=09 */
> -=09=09DEBUG_AUTOCONF("Couldn't force IER_UUE to 0 ");
>  =09}
>  =09serial_out(up, UART_IER, iersave);
> =20
> @@ -1098,9 +1073,6 @@ static void autoconfig(struct uart_8250_port *up)
>  =09if (!port->iobase && !port->mapbase && !port->membase)
>  =09=09return;
> =20
> -=09DEBUG_AUTOCONF("%s: autoconf (0x%04lx, 0x%p): ",
> -=09=09       port->name, port->iobase, port->membase);
> -
>  =09/*
>  =09 * We really do need global IRQs disabled here - we're going to
>  =09 * be frobbing the chips IRQ enable register to see if it exists.
> @@ -1147,9 +1119,7 @@ static void autoconfig(struct uart_8250_port *up)
>  =09=09=09 * We failed; there's nothing here
>  =09=09=09 */
>  =09=09=09uart_port_unlock_irqrestore(port, flags);
> -=09=09=09DEBUG_AUTOCONF("IER test failed (%02x, %02x) ",
> -=09=09=09=09       scratch2, scratch3);
> -=09=09=09goto out;
> +=09=09=09return;
>  =09=09}
>  =09}
> =20
> @@ -1171,9 +1141,7 @@ static void autoconfig(struct uart_8250_port *up)
>  =09=09serial8250_out_MCR(up, save_mcr);
>  =09=09if (status1 !=3D (UART_MSR_DCD | UART_MSR_CTS)) {
>  =09=09=09uart_port_unlock_irqrestore(port, flags);
> -=09=09=09DEBUG_AUTOCONF("LOOP test failed (%02x) ",
> -=09=09=09=09       status1);
> -=09=09=09goto out;
> +=09=09=09return;
>  =09=09}
>  =09}
> =20
> @@ -1241,9 +1209,6 @@ static void autoconfig(struct uart_8250_port *up)
>  =09=09dev_warn(port->dev, "detected caps %08x should be %08x\n",
>  =09=09=09 old_capabilities, up->capabilities);
>  =09}
> -out:
> -=09DEBUG_AUTOCONF("iir=3D%d ", scratch);
> -=09DEBUG_AUTOCONF("type=3D%s\n", uart_config[port->type].name);
>  }
> =20
>  static void autoconfig_irq(struct uart_8250_port *up)
>=20

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.

--8323328-16933694-1749647459=:957--
