Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C00625BF12;
	Wed, 11 Jun 2025 11:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749642853; cv=none; b=cprTP10x4WYraNygEqQ/bKSa5gZ11kSyvvQqEpdCr7VvJtaWwwfF/VX4y/idj/YF/VsTrOcnBZVJ7ASCGSscfUlpq01m72OZ39qdFILBSHuq8QOHCKjU2iQW2/2KaoE8n7Kwv2RpZDv+CnA5vupjeq76R3rjx10BED6n2ceYpNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749642853; c=relaxed/simple;
	bh=aNqfbkDfrbz8wt+Ae/fhU2Bit6+gN5flB4KN4WMaMLE=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=STTNZegPTGADs+mgkN5RNud//lPrRTgiwPyGk0t9ozAfsrYfXOnal4CZQNVO2Ri9l+zVLDr5dNhfdXyrEKn/O1DCVSHwdSE2RUFCgqwEcBMSAggkLs8u9QyRUvln/zgoKdIOOzx4wwReNQ70iDkqNVUsuQRPXLVwCLYTPoYwmWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j2YWlW/l; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j2YWlW/l"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749642852; x=1781178852;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=aNqfbkDfrbz8wt+Ae/fhU2Bit6+gN5flB4KN4WMaMLE=;
  b=j2YWlW/l2jVXps9mXN1jc6LuwHL8Fx5JJXX2//asvntpktn+hJI/Hi3f
   i0oHzMUXN8N6bkDoGZ4aPt++lX0/Jrr03BiPHbkMBp5yJQlfs8lvhftDT
   ltVM6jMdVHCNgifEqa1tbIRUbRunE3tVsBLi9rfO4AEj/pxUnFO8Wgtlt
   7awXUKf1AoorXXXcPh5icdEpNDsSiyFufGP6lA6SJl1fZMvztzajHFs64
   8VIQSMEYcfZ/UEqGl506OAm8y72vqELN18Azq148gHxzfrUoFMkJIZN+N
   D7FgDhdY4Pj0DHxewxiXGj8gpCkDFlr1rZbNSbQPHnJeRDzbFEuZDqio0
   w==;
X-CSE-ConnectionGUID: NQCr+8p/QwS7khbBGDh/jw==
X-CSE-MsgGUID: MrVItyhCSPu9HsBQzwDXKQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11460"; a="39401368"
X-IronPort-AV: E=Sophos;i="6.16,227,1744095600"; 
   d="scan'208";a="39401368"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2025 04:54:11 -0700
X-CSE-ConnectionGUID: eB6Ltda0TqW/R0CQcoHSIg==
X-CSE-MsgGUID: POlUJcP1RjKd7eQzOUhK2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,227,1744095600"; 
   d="scan'208";a="147091665"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.183])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2025 04:54:09 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 11 Jun 2025 14:54:04 +0300 (EEST)
To: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
cc: gregkh@linuxfoundation.org, linux-serial@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/33] serial: 8250: put RSA functions to their
 namespace
In-Reply-To: <20250611100319.186924-12-jirislaby@kernel.org>
Message-ID: <b7331326-8317-7e7e-809e-e61211cd7e0a@linux.intel.com>
References: <20250611100319.186924-1-jirislaby@kernel.org> <20250611100319.186924-12-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1177581371-1749642844=:957"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1177581371-1749642844=:957
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 11 Jun 2025, Jiri Slaby (SUSE) wrote:

> Prefix the functions with rsa_, not suffix.
>=20
> This is a preparation for moving them out to 8250_rsa.c in the next
> patch.
>
> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
> ---
>  drivers/tty/serial/8250/8250_port.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
>=20
> diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/825=
0/8250_port.c
> index e7652d62ab2f..d8a90818f431 100644
> --- a/drivers/tty/serial/8250/8250_port.c
> +++ b/drivers/tty/serial/8250/8250_port.c
> @@ -718,7 +718,7 @@ static void serial8250_clear_IER(struct uart_8250_por=
t *up)
>   * Attempts to turn on the RSA FIFO.  Returns zero on failure.
>   * We set the port uart clock rate if we succeed.
>   */
> -static int __enable_rsa(struct uart_8250_port *up)
> +static int __rsa_enable(struct uart_8250_port *up)
>  {
>  =09unsigned char mode;
>  =09int result;
> @@ -741,14 +741,14 @@ static int __enable_rsa(struct uart_8250_port *up)
>  /*
>   * If this is an RSA port, see if we can kick it up to the higher speed =
clock.
>   */
> -static void enable_rsa(struct uart_8250_port *up)
> +static void rsa_enable(struct uart_8250_port *up)
>  {
>  =09if (up->port.type !=3D PORT_RSA)
>  =09=09return;
> =20
>  =09if (up->port.uartclk !=3D SERIAL_RSA_BAUD_BASE * 16) {
>  =09=09uart_port_lock_irq(&up->port);
> -=09=09__enable_rsa(up);
> +=09=09__rsa_enable(up);
>  =09=09uart_port_unlock_irq(&up->port);
>  =09}
>  =09if (up->port.uartclk =3D=3D SERIAL_RSA_BAUD_BASE * 16)
> @@ -760,7 +760,7 @@ static void enable_rsa(struct uart_8250_port *up)
>   * unknown why interrupts were disabled in here. However, the caller is =
expected to preserve this
>   * behaviour by grabbing the spinlock before calling this function.
>   */
> -static void disable_rsa(struct uart_8250_port *up)
> +static void rsa_disable(struct uart_8250_port *up)
>  {
>  =09unsigned char mode;
>  =09int result;
> @@ -794,7 +794,7 @@ static void rsa_autoconfig(struct uart_8250_port *up)
>  =09if (!(up->probe & UART_PROBE_RSA))
>  =09=09return;
> =20
> -=09if (__enable_rsa(up))
> +=09if (__rsa_enable(up))
>  =09=09up->port.type =3D PORT_RSA;
>  }
> =20
> @@ -806,8 +806,8 @@ static void rsa_reset(struct uart_8250_port *up)
>  =09serial_out(up, UART_RSA_FRR, 0);
>  }
>  #else
> -static inline void enable_rsa(struct uart_8250_port *up) {}
> -static inline void disable_rsa(struct uart_8250_port *up) {}
> +static inline void rsa_enable(struct uart_8250_port *up) {}
> +static inline void rsa_disable(struct uart_8250_port *up) {}
>  static inline void rsa_autoconfig(struct uart_8250_port *up) {}
>  static inline void rsa_reset(struct uart_8250_port *up) {}
>  #endif /* CONFIG_SERIAL_8250_RSA */
> @@ -2268,7 +2268,7 @@ int serial8250_do_startup(struct uart_port *port)
>  =09=09=09=09UART_DA830_PWREMU_MGMT_FREE);
>  =09}
> =20
> -=09enable_rsa(up);
> +=09rsa_enable(up);
> =20
>  =09/*
>  =09 * Clear the FIFO buffers and disable them.
> @@ -2535,7 +2535,7 @@ void serial8250_do_shutdown(struct uart_port *port)
>  =09=09=09serial_port_in(port, UART_LCR) & ~UART_LCR_SBC);
>  =09serial8250_clear_fifos(up);
> =20
> -=09disable_rsa(up);
> +=09rsa_disable(up);
> =20
>  =09/*
>  =09 * Read data port to reset things, and then unlink from
>=20

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.

--8323328-1177581371-1749642844=:957--
