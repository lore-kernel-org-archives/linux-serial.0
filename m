Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 634212E6122;
	Wed, 11 Jun 2025 11:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749642402; cv=none; b=W4hWz4smOPp6WRnLGxvtC8pjXbtvAGh7Om/8Yd8IlFFWTl9sWryZhYs9+pH3wvY5oZ3Gi51wpxvRS7RPDoKR6zFU7+0x1l/XiMEpbYQWmGUIukhavomXTq8GZuH+7HGvim269ffUbewKZkoe2yf5JntAYLeNFJbAZS9hFQBsAjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749642402; c=relaxed/simple;
	bh=ZUlVFcUAC/pCaM5x+TevXdecSEVUqfUzanokBPqQUzY=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=qFk06tmoKFXaLltdQ59DypGUAcf6c9jmarzG6uHizqHgNqI15yz+GY3BmjLA84fYy22V6t/owRlsvfi3OO+V78U0f0fVSe/kixMXdGgjCDpwspflhEafHAZo4tYfzltRcRg303zdPkFXH5zi3+Dtvz4IlTnKADfVOfCJM7bb7/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LOBIM0P/; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LOBIM0P/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749642400; x=1781178400;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=ZUlVFcUAC/pCaM5x+TevXdecSEVUqfUzanokBPqQUzY=;
  b=LOBIM0P/08vqRHDejOi4otruILXZsa9Cny9qj/Mgb9QH7f4DAlCEQbPy
   Yz8i7XPoCU7APhNxcIYuLM6nDFMWWwyIiVTvH9qtGhHL73ZPbaxztJkYM
   1duzxKF4Vy9ljonq6qJLrDH7ZytQiQ1aTTGzqaYxJ1DfO1DwhqQ9zC1jt
   8NfiKharUSJso1m/GqgJIM+ojLAIz+KexOVKYGA3s37SZqo7vO7RYu3Ae
   iUnM06tUur1dzJI8h7yNKwWF+Z6tE7Pqzk4kfNORb6d/RI4NEcdUL9RZu
   M46thWZ14ntlOJBeZncDEd+yplPPzGoz7VQu5+EQie+qKoQOLL7RMwumK
   g==;
X-CSE-ConnectionGUID: X6HnY10dTQaEgYT+HE832Q==
X-CSE-MsgGUID: T4WGC75ASGyPVnhYqNNt7w==
X-IronPort-AV: E=McAfee;i="6800,10657,11460"; a="62434413"
X-IronPort-AV: E=Sophos;i="6.16,227,1744095600"; 
   d="scan'208";a="62434413"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2025 04:46:40 -0700
X-CSE-ConnectionGUID: GzZ1AoAWTkSRB75O7rUf/w==
X-CSE-MsgGUID: /E7l+tARS7+Mk7ucpVjQlw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,227,1744095600"; 
   d="scan'208";a="152066028"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.183])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2025 04:46:37 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 11 Jun 2025 14:46:33 +0300 (EEST)
To: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    linux-serial <linux-serial@vger.kernel.org>, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 09/33] serial: 8250: remove CONFIG_SERIAL_8250_RSA inline
 macros from code
In-Reply-To: <20250611100319.186924-10-jirislaby@kernel.org>
Message-ID: <43385fba-407a-418a-d3df-ac50eaa761f8@linux.intel.com>
References: <20250611100319.186924-1-jirislaby@kernel.org> <20250611100319.186924-10-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-462843366-1749642393=:957"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-462843366-1749642393=:957
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 11 Jun 2025, Jiri Slaby (SUSE) wrote:

> All these:
>   #ifdef CONFIG_SERIAL_8250_RSA
>   ...
>   #endif
>=20
> in the 8250 generic code distract the reader. Introduce empty inlines to
> handle the !CONFIG_SERIAL_8250_RSA case and handle the '#if's around the
> RSA functions definitions.
>=20
> This means rsa_autoconfig() and rsa_reset() functions were introduced to
> contain the particular code.

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.

> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
> ---
>  drivers/tty/serial/8250/8250_port.c | 54 ++++++++++++++---------------
>  1 file changed, 27 insertions(+), 27 deletions(-)
>=20
> diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/825=
0/8250_port.c
> index f5407832e8a7..233316a88df2 100644
> --- a/drivers/tty/serial/8250/8250_port.c
> +++ b/drivers/tty/serial/8250/8250_port.c
> @@ -738,6 +738,9 @@ static int __enable_rsa(struct uart_8250_port *up)
>  =09return result;
>  }
> =20
> +/*
> + * If this is an RSA port, see if we can kick it up to the higher speed =
clock.
> + */
>  static void enable_rsa(struct uart_8250_port *up)
>  {
>  =09if (up->port.type =3D=3D PORT_RSA) {
> @@ -752,10 +755,9 @@ static void enable_rsa(struct uart_8250_port *up)
>  }
> =20
>  /*
> - * Attempts to turn off the RSA FIFO.  Returns zero on failure.
> - * It is unknown why interrupts were disabled in here.  However,
> - * the caller is expected to preserve this behaviour by grabbing
> - * the spinlock before calling this function.
> + * Attempts to turn off the RSA FIFO and resets the RSA board back to 11=
5kbps compat mode. It is
> + * unknown why interrupts were disabled in here. However, the caller is =
expected to preserve this
> + * behaviour by grabbing the spinlock before calling this function.
>   */
>  static void disable_rsa(struct uart_8250_port *up)
>  {
> @@ -780,6 +782,25 @@ static void disable_rsa(struct uart_8250_port *up)
>  =09=09uart_port_unlock_irq(&up->port);
>  =09}
>  }
> +
> +static void rsa_autoconfig(struct uart_8250_port *up)
> +{
> +=09/* Only probe for RSA ports if we got the region. */
> +=09if (up->port.type =3D=3D PORT_16550A && up->probe & UART_PROBE_RSA &&
> +=09    __enable_rsa(up))
> +=09=09up->port.type =3D PORT_RSA;
> +}
> +
> +static void rsa_reset(struct uart_8250_port *up)
> +{
> +=09if (up->port.type =3D=3D PORT_RSA)
> +=09=09serial_out(up, UART_RSA_FRR, 0);
> +}
> +#else
> +static inline void enable_rsa(struct uart_8250_port *up) {}
> +static inline void disable_rsa(struct uart_8250_port *up) {}
> +static inline void rsa_autoconfig(struct uart_8250_port *up) {}
> +static inline void rsa_reset(struct uart_8250_port *up) {}
>  #endif /* CONFIG_SERIAL_8250_RSA */
> =20
>  /*
> @@ -1267,14 +1288,7 @@ static void autoconfig(struct uart_8250_port *up)
>  =09=09break;
>  =09}
> =20
> -#ifdef CONFIG_SERIAL_8250_RSA
> -=09/*
> -=09 * Only probe for RSA ports if we got the region.
> -=09 */
> -=09if (port->type =3D=3D PORT_16550A && up->probe & UART_PROBE_RSA &&
> -=09    __enable_rsa(up))
> -=09=09port->type =3D PORT_RSA;
> -#endif
> +=09rsa_autoconfig(up);
> =20
>  =09serial_out(up, UART_LCR, save_lcr);
> =20
> @@ -1289,10 +1303,7 @@ static void autoconfig(struct uart_8250_port *up)
>  =09/*
>  =09 * Reset the UART.
>  =09 */
> -#ifdef CONFIG_SERIAL_8250_RSA
> -=09if (port->type =3D=3D PORT_RSA)
> -=09=09serial_out(up, UART_RSA_FRR, 0);
> -#endif
> +=09rsa_reset(up);
>  =09serial8250_out_MCR(up, save_mcr);
>  =09serial8250_clear_fifos(up);
>  =09serial_in(up, UART_RX);
> @@ -2248,13 +2259,7 @@ int serial8250_do_startup(struct uart_port *port)
>  =09=09=09=09UART_DA830_PWREMU_MGMT_FREE);
>  =09}
> =20
> -#ifdef CONFIG_SERIAL_8250_RSA
> -=09/*
> -=09 * If this is an RSA port, see if we can kick it up to the
> -=09 * higher speed clock.
> -=09 */
>  =09enable_rsa(up);
> -#endif
> =20
>  =09/*
>  =09 * Clear the FIFO buffers and disable them.
> @@ -2521,12 +2526,7 @@ void serial8250_do_shutdown(struct uart_port *port=
)
>  =09=09=09serial_port_in(port, UART_LCR) & ~UART_LCR_SBC);
>  =09serial8250_clear_fifos(up);
> =20
> -#ifdef CONFIG_SERIAL_8250_RSA
> -=09/*
> -=09 * Reset the RSA board back to 115kbps compat mode.
> -=09 */
>  =09disable_rsa(up);
> -#endif
> =20
>  =09/*
>  =09 * Read data port to reset things, and then unlink from
>=20
--8323328-462843366-1749642393=:957--
