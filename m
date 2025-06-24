Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A3AA2868BD;
	Tue, 24 Jun 2025 11:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750763126; cv=none; b=f19jVXYxi5JC1YzPhPVsrNA1wifKbAjx3LllDgppA5pOpMVDx59k40jPs2OOBOTO2FgfS5z2m5+6wF08THNCb0pMaxSMmR3SSRlju0C53bT+/AkwaYMhwQN9nrs4ZL6EGUPdbre9r5Y1O8B1E55uQpAKENr831JPQzm8oYXp8RM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750763126; c=relaxed/simple;
	bh=J17QCFM0YmsTh7lSotIGCixJIQqf5DkpQr93wgTxfE8=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=njxxsKWLlbwIU8E9v5fnoZSMxOsLOl2yoGfpUBdz571zlKY3zc+ZBi8X4aiQ0PCwKezXM4S6oonZt2ElWj2Q1LVw844RwSMy+d6nvifTUDHDcY0FMmqPoxvaILMhGVbkjSxFfebYeleDny4bVLMiaHDTE67CY0Q40RC8buiDy9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SlMVtvbv; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SlMVtvbv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750763125; x=1782299125;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=J17QCFM0YmsTh7lSotIGCixJIQqf5DkpQr93wgTxfE8=;
  b=SlMVtvbviUrlougH0bdvR2zs96AtdePUkW00hfLz7oBo41PK/n+tQ/gg
   RWMXaQHQWmjPVnwU4kVue0ekKqpdaFt2/ExzZyn+y9alou6caK5OkMRgt
   pLiQSf5pn2D46uTmNwLiTkgGn7YsLNEoiuMjSQfYeDt3fHDugClnfPGQ4
   UtPtDwQnPxDJSQSBeGgCYaOWyUL2sH5Y5AnFEAN3qKFGR7swaZYXVa8XY
   +ANH2/PNUxlqw+47+Re8rgxHxEiWjS9W/5jxuBcQwqd/yWl/lbh/JcjSI
   2pIw1tw/tjjzX1GP9X4yXXe8sGzrPP0IqRUoyws12eVQ2dMIljBqX+/v2
   A==;
X-CSE-ConnectionGUID: 3bv6vhefSQizxMbA7AJ+ew==
X-CSE-MsgGUID: PP3FgOVgRMa+kEKyN8bbbQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11473"; a="40613102"
X-IronPort-AV: E=Sophos;i="6.16,261,1744095600"; 
   d="scan'208";a="40613102"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2025 04:05:24 -0700
X-CSE-ConnectionGUID: fUp4ee/0Rb2k8XdbB2gTCQ==
X-CSE-MsgGUID: zCYXp7LhTduHB/9ru6yNew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,261,1744095600"; 
   d="scan'208";a="152177842"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.16])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2025 04:05:22 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 24 Jun 2025 14:05:18 +0300 (EEST)
To: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    linux-serial <linux-serial@vger.kernel.org>, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/5] serial: 8250: extract
 serial8250_iir_txen_test()
In-Reply-To: <20250624080641.509959-3-jirislaby@kernel.org>
Message-ID: <a77e5a15-0eb8-02ed-c279-80cba3e51ff1@linux.intel.com>
References: <20250624080641.509959-1-jirislaby@kernel.org> <20250624080641.509959-3-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-1579240240-1750763032=:943"
Content-ID: <a2de4972-feeb-1a7c-452f-8bfd3178bfaa@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1579240240-1750763032=:943
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <f88b4dde-aa3e-c326-6e75-c656a90a194c@linux.intel.com>

On Tue, 24 Jun 2025, Jiri Slaby (SUSE) wrote:

> After commit 795158691cc0 ("serial: 8250: extract
> serial8250_initialize()"), split serial8250_initialize() even more --
> the TX enable test part of this code can be separated into
> serial8250_iir_txen_test().
>=20
> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
> Suggested-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>
> ---
>  drivers/tty/serial/8250/8250_port.c | 49 ++++++++++++++++-------------
>  1 file changed, 28 insertions(+), 21 deletions(-)
>=20
> diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/825=
0/8250_port.c
> index 0f85a2f292fc..5bb0ca04da55 100644
> --- a/drivers/tty/serial/8250/8250_port.c
> +++ b/drivers/tty/serial/8250/8250_port.c
> @@ -2230,16 +2230,19 @@ static void serial8250_init_mctrl(struct uart_por=
t *port)
>  =09serial8250_set_mctrl(port, port->mctrl);
>  }
> =20
> -static void serial8250_initialize(struct uart_port *port)
> +static void serial8250_iir_txen_test(struct uart_port *port)
>  {
>  =09struct uart_8250_port *up =3D up_to_u8250p(port);
> -=09unsigned long flags;
>  =09bool lsr_TEMT, iir_NOINT;
> =20
> -=09serial_port_out(port, UART_LCR, UART_LCR_WLEN8);
> +=09if (port->quirks & UPQ_NO_TXEN_TEST)
> +=09=09return;
> =20
> -=09uart_port_lock_irqsave(port, &flags);
> -=09serial8250_init_mctrl(port);
> +=09/* Do a quick test to see if we receive an interrupt when we enable t=
he TX irq. */
> +=09serial_port_out(port, UART_IER, UART_IER_THRI);
> +=09lsr_TEMT =3D serial_port_in(port, UART_LSR) & UART_LSR_TEMT;
> +=09iir_NOINT =3D serial_port_in(port, UART_IIR) & UART_IIR_NO_INT;
> +=09serial_port_out(port, UART_IER, 0);
> =20
>  =09/*
>  =09 * Serial over Lan (SoL) hack:
> @@ -2247,26 +2250,30 @@ static void serial8250_initialize(struct uart_por=
t *port)
>  =09 * Lan.  Those chips take a longer time than a normal serial device t=
o signalize that a
>  =09 * transmission data was queued. Due to that, the above test generall=
y fails. One solution
>  =09 * would be to delay the reading of iir. However, this is not reliabl=
e, since the timeout is
> -=09 * variable. So, let's just don't test if we receive TX irq.  This wa=
y, we'll never enable
> -=09 * UART_BUG_TXEN.
> +=09 * variable. So, in case of UPQ_NO_TXEN_TEST, let's just don't test i=
f we receive TX irq.
> +=09 * This way, we'll never enable UART_BUG_TXEN.
>  =09 */
> -=09if (!(port->quirks & UPQ_NO_TXEN_TEST)) {
> -=09=09/* Do a quick test to see if we receive an interrupt when we enabl=
e the TX irq. */
> -=09=09serial_port_out(port, UART_IER, UART_IER_THRI);
> -=09=09lsr_TEMT =3D serial_port_in(port, UART_LSR) & UART_LSR_TEMT;
> -=09=09iir_NOINT =3D serial_port_in(port, UART_IIR) & UART_IIR_NO_INT;
> -=09=09serial_port_out(port, UART_IER, 0);
> -
> -=09=09if (lsr_TEMT && iir_NOINT) {
> -=09=09=09if (!(up->bugs & UART_BUG_TXEN)) {
> -=09=09=09=09up->bugs |=3D UART_BUG_TXEN;
> -=09=09=09=09dev_dbg(port->dev, "enabling bad tx status workarounds\n");
> -=09=09=09}
> -=09=09} else {
> -=09=09=09up->bugs &=3D ~UART_BUG_TXEN;
> +=09if (lsr_TEMT && iir_NOINT) {
> +=09=09if (!(up->bugs & UART_BUG_TXEN)) {
> +=09=09=09up->bugs |=3D UART_BUG_TXEN;
> +=09=09=09dev_dbg(port->dev, "enabling bad tx status workarounds\n");
>  =09=09}
> +=09=09return;
>  =09}
> =20
> +=09/* FIXME: why is this needed? */
> +=09up->bugs &=3D ~UART_BUG_TXEN;
> +}
> +
> +static void serial8250_initialize(struct uart_port *port)
> +{
> +=09unsigned long flags;
> +
> +=09serial_port_out(port, UART_LCR, UART_LCR_WLEN8);
> +
> +=09uart_port_lock_irqsave(port, &flags);
> +=09serial8250_init_mctrl(port);
> +=09serial8250_iir_txen_test(port);
>  =09uart_port_unlock_irqrestore(port, flags);
>  }
> =20
>=20

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.
--8323328-1579240240-1750763032=:943--
