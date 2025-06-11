Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F01A2686B9;
	Wed, 11 Jun 2025 13:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749647007; cv=none; b=MbLtbjMLhZEPGH9u68RCLUY80w52dUnA6tq2VD66vaGeeATNpCsMtxfn5dTiqw8lzI5l4/0exKEw0SKEKqclvTxAAVIfNGx6E7jB7cPGdB51DrDUq6DNA+S5kQGRdBOcwWsbviEdazNU6X3aE+GDulaQKD2KPvI6zafOtvJBGuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749647007; c=relaxed/simple;
	bh=Bz2bdxOUaqTHvZMbxUQwOOy/NgmCLjniwlMl2slSc64=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=F5WN7QqYvWl2OqTmyzXgRJFkLrv0IZ6rCYbe1KjjUb1daMebbneQGUMm75nXI9uKE12EEpr/+aAPzExUeo86OwTVSOWKzINpGVLqSQT6juiJSwNSk1uYoGx3Cuvw8toxrzhqocM19PdyJDcMHGUZju5iip3dXehnmY9961SUVXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ns6IDvyT; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ns6IDvyT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749647007; x=1781183007;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Bz2bdxOUaqTHvZMbxUQwOOy/NgmCLjniwlMl2slSc64=;
  b=Ns6IDvyTboqFIM0V+NN9BQOgIrVTSPk4Y1O69+P79Nfq6noVMazTykEN
   dTfAGyeSNDEnF64losYVjhtwD3ZN+BeL7zHKnObQA3ekvio5I8Zd8E7PI
   FpjuxM/6S24Bnwq/j7YosJ4JjTlxP/B0xUbHaYvIdD/smKxhdwo+V9+NS
   GNTrWPVf7m522CLf6JCKSmPD1PwlLnMgm+L9sIe5DEw3gDHSAwULiFDyd
   JAxfM5luTQoCox6BSoYYhaudL8ZrqNsxQO0XKSB6zPrT/XAhm4GKWAXb6
   Kqjr3tRKIHkB0O7c6MR6ro7k1dpgLFjP8Sccs7etgcMzAENqWzbkFXHCV
   g==;
X-CSE-ConnectionGUID: ji1E8EjHQauBpGhYqmiLSg==
X-CSE-MsgGUID: NtG7Zq+7RbqHSTLM3A925Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11461"; a="63199321"
X-IronPort-AV: E=Sophos;i="6.16,227,1744095600"; 
   d="scan'208";a="63199321"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2025 06:03:26 -0700
X-CSE-ConnectionGUID: +WXYxpaxThyifWms1emG/A==
X-CSE-MsgGUID: HkOhY5VCQMG0vg6Hoxmghg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,227,1744095600"; 
   d="scan'208";a="147066795"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.183])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2025 06:03:24 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 11 Jun 2025 16:03:19 +0300 (EEST)
To: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    linux-serial <linux-serial@vger.kernel.org>, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 25/33] serial: 8250: lcr compute cleanup
In-Reply-To: <20250611100319.186924-26-jirislaby@kernel.org>
Message-ID: <bf099c75-eb83-a0c0-3656-36880a9a0ce7@linux.intel.com>
References: <20250611100319.186924-1-jirislaby@kernel.org> <20250611100319.186924-26-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1154005854-1749646999=:957"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1154005854-1749646999=:957
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 11 Jun 2025, Jiri Slaby (SUSE) wrote:

> * use 'lcr' as variable containing the "computed value" (and not 'cval')
> * use 'u8' for the type (and not 'unsigned char')
> * drop useless comment
>=20
> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.

> ---
>  drivers/tty/serial/8250/8250_port.c | 23 ++++++++++-------------
>  1 file changed, 10 insertions(+), 13 deletions(-)
>=20
> diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/825=
0/8250_port.c
> index 85b75ff0699e..2af89038e50e 100644
> --- a/drivers/tty/serial/8250/8250_port.c
> +++ b/drivers/tty/serial/8250/8250_port.c
> @@ -2547,23 +2547,20 @@ static unsigned int serial8250_get_divisor(struct=
 uart_port *port,
>  =09return serial8250_do_get_divisor(port, baud, frac);
>  }
> =20
> -static unsigned char serial8250_compute_lcr(struct uart_8250_port *up,
> -=09=09=09=09=09    tcflag_t c_cflag)
> +static unsigned char serial8250_compute_lcr(struct uart_8250_port *up, t=
cflag_t c_cflag)
>  {
> -=09unsigned char cval;
> -
> -=09cval =3D UART_LCR_WLEN(tty_get_char_size(c_cflag));
> +=09u8 lcr =3D UART_LCR_WLEN(tty_get_char_size(c_cflag));
> =20
>  =09if (c_cflag & CSTOPB)
> -=09=09cval |=3D UART_LCR_STOP;
> +=09=09lcr |=3D UART_LCR_STOP;
>  =09if (c_cflag & PARENB)
> -=09=09cval |=3D UART_LCR_PARITY;
> +=09=09lcr |=3D UART_LCR_PARITY;
>  =09if (!(c_cflag & PARODD))
> -=09=09cval |=3D UART_LCR_EPAR;
> +=09=09lcr |=3D UART_LCR_EPAR;
>  =09if (c_cflag & CMSPAR)
> -=09=09cval |=3D UART_LCR_SPAR;
> +=09=09lcr |=3D UART_LCR_SPAR;
> =20
> -=09return cval;
> +=09return lcr;
>  }
> =20
>  void serial8250_do_set_divisor(struct uart_port *port, unsigned int baud=
,
> @@ -2821,12 +2818,12 @@ serial8250_do_set_termios(struct uart_port *port,=
 struct ktermios *termios,
>  =09=09          const struct ktermios *old)
>  {
>  =09struct uart_8250_port *up =3D up_to_u8250p(port);
> -=09unsigned char cval;
>  =09unsigned long flags;
>  =09unsigned int baud, quot, frac =3D 0;
> +=09u8 lcr;
> =20
>  =09serial8250_set_mini(port, termios);
> -=09cval =3D serial8250_compute_lcr(up, termios->c_cflag);
> +=09lcr =3D serial8250_compute_lcr(up, termios->c_cflag);
>  =09baud =3D serial8250_get_baud_rate(port, termios, old);
>  =09quot =3D serial8250_get_divisor(port, baud, &frac);
> =20
> @@ -2839,7 +2836,7 @@ serial8250_do_set_termios(struct uart_port *port, s=
truct ktermios *termios,
>  =09serial8250_rpm_get(up);
>  =09uart_port_lock_irqsave(port, &flags);
> =20
> -=09up->lcr =3D cval;=09=09=09=09=09/* Save computed LCR */
> +=09up->lcr =3D lcr;
>  =09serial8250_set_trigger_for_slow_speed(port, termios, baud);
>  =09serial8250_set_afe(port, termios);
>  =09uart_update_timeout(port, termios->c_cflag, baud);
>=20
--8323328-1154005854-1749646999=:957--
