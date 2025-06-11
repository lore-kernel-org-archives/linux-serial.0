Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 695F727780D;
	Wed, 11 Jun 2025 12:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749644971; cv=none; b=U/vSA2vi/AycXL+6PqwLvacJq79+BgbuCnA2LGOFRyQbe6hLFpX9I7hDeoU5E1jvt3VMgUJslqV4ThZe1ZR1W6wdpxkM+vfyZiKk/lzNLtF1BjJBfMAXVjXD6ioAbiC+9jkl8BNzDPqLDA+VTKYKkPdHldN3VnOpWsRo2kflFE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749644971; c=relaxed/simple;
	bh=JkyzVtj6QCYNu/epXmbZRTiTVfDL+CA3Usj57mVgLe0=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=XGAB5Zm/U60nwi1vAeMIwT4uwlZMm2yy0gL/aScRAsd/2M7DLebVu2x3+z+/Ul32OXcVyvE6Yo7UFwQhnRMPuzfmTnSWwktxxH7xq3kI/6NQDYpH/RwLBZGEZMCOBYYM4JOZ2cm4scSl/09yCrGkwBnybJ+dyHu3oszEdp8OIno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Vtg9ZLlA; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Vtg9ZLlA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749644970; x=1781180970;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=JkyzVtj6QCYNu/epXmbZRTiTVfDL+CA3Usj57mVgLe0=;
  b=Vtg9ZLlA7Nb+WIbR/cFSglJ6lCoDASjGDYKi2F0m+/LOUZNvNBni9BAx
   sE/4eghV3Y9UxKwNgtspT9sxWD0IlyOVu9WuCST0DuUhTeFiXf2RX40ug
   hBZT89zTkGhDmWwjKoa2k0dgAuhbLQ96CJ5PzoImFlaTXT2Arsn2uJ1ok
   aE4TGL/P2VyoLi/hVLE6cmf0vewTnzF+MsPSQ8XlaBQZnoWdEGqOGoK0t
   lvWd4L6rWeE25Q3xIMa8tfDCnoq2H/4eCRyJDZdsqA+d+z+7Bl07Bs0ga
   IYK+tvf1oTMxanrRXAb23Bg7rBWFglU2L43QdV0YXY57j3J8IdpamCpDF
   g==;
X-CSE-ConnectionGUID: fZNJk2fBQ+OXQrPTFBpHfg==
X-CSE-MsgGUID: FDY/2ko9T4amrivKeJ1syw==
X-IronPort-AV: E=McAfee;i="6800,10657,11461"; a="39405236"
X-IronPort-AV: E=Sophos;i="6.16,227,1744095600"; 
   d="scan'208";a="39405236"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2025 05:29:29 -0700
X-CSE-ConnectionGUID: JSyh68v3Tjq6yVTT0KX7Dg==
X-CSE-MsgGUID: Lc0M1UUPR3uS52jEDKB04Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,227,1744095600"; 
   d="scan'208";a="152465810"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.183])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2025 05:29:26 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 11 Jun 2025 15:29:21 +0300 (EEST)
To: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    linux-serial <linux-serial@vger.kernel.org>, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 18/33] serial: 8250: extract serial8250_set_mini()
In-Reply-To: <20250611100319.186924-19-jirislaby@kernel.org>
Message-ID: <bf84598f-0a20-31bf-4967-d01db6fae700@linux.intel.com>
References: <20250611100319.186924-1-jirislaby@kernel.org> <20250611100319.186924-19-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-2067956457-1749644961=:957"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-2067956457-1749644961=:957
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 11 Jun 2025, Jiri Slaby (SUSE) wrote:

> serial8250_do_set_termios() consists of many registers and up flags
> settings. Extract all these into separate functions. This time, setting
> of CSIZE for UART_CAP_MINI ports.
>=20
> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
> ---
>  drivers/tty/serial/8250/8250_port.c | 24 +++++++++++++++++-------
>  1 file changed, 17 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/825=
0/8250_port.c
> index a73f4db22feb..edfbaa6b7a1b 100644
> --- a/drivers/tty/serial/8250/8250_port.c
> +++ b/drivers/tty/serial/8250/8250_port.c
> @@ -2670,6 +2670,22 @@ void serial8250_update_uartclk(struct uart_port *p=
ort, unsigned int uartclk)
>  }
>  EXPORT_SYMBOL_GPL(serial8250_update_uartclk);
> =20
> +static void serial8250_set_mini(struct uart_port *port, struct ktermios =
*termios)
> +{
> +=09struct uart_8250_port *up =3D up_to_u8250p(port);
> +
> +=09if (!(up->capabilities & UART_CAP_MINI))
> +=09=09return;
> +
> +=09termios->c_cflag &=3D ~(CSTOPB | PARENB | PARODD | CMSPAR);
> +
> +=09tcflag_t csize =3D termios->c_cflag & CSIZE;
> +=09if (csize =3D=3D CS5 || csize =3D=3D CS6) {
> +=09=09termios->c_cflag &=3D ~CSIZE;
> +=09=09termios->c_cflag |=3D CS7;
> +=09}
> +}
> +
>  void
>  serial8250_do_set_termios(struct uart_port *port, struct ktermios *termi=
os,
>  =09=09          const struct ktermios *old)
> @@ -2679,14 +2695,8 @@ serial8250_do_set_termios(struct uart_port *port, =
struct ktermios *termios,
>  =09unsigned long flags;
>  =09unsigned int baud, quot, frac =3D 0;
> =20
> -=09if (up->capabilities & UART_CAP_MINI) {
> -=09=09termios->c_cflag &=3D ~(CSTOPB | PARENB | PARODD | CMSPAR);
> -=09=09if ((termios->c_cflag & CSIZE) =3D=3D CS5 ||
> -=09=09    (termios->c_cflag & CSIZE) =3D=3D CS6)
> -=09=09=09termios->c_cflag =3D (termios->c_cflag & ~CSIZE) | CS7;
> -=09}
> +=09serial8250_set_mini(port, termios);
>  =09cval =3D serial8250_compute_lcr(up, termios->c_cflag);
> -
>  =09baud =3D serial8250_get_baud_rate(port, termios, old);
>  =09quot =3D serial8250_get_divisor(port, baud, &frac);
> =20
>=20

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.

--8323328-2067956457-1749644961=:957--
