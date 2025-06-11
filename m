Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA61272E63;
	Wed, 11 Jun 2025 12:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749646067; cv=none; b=ecg0TUZpO+rcXebpKQAG5vksd1UeDunb5Z4/fodXLLW8XPtCQuanpjamiz0TIYxTL3I7lcXNzUYNJ368F9HEx/v3R9f5bomMDWIt7jkpSK/Y94R70rm1n3/WJifUgoum9FRZPz1j2NRQZFJHt5t+VejQMz2o7z7Od3Coz8SLNR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749646067; c=relaxed/simple;
	bh=58wWmn/AAv0t5U67CJoTQL76p41O7pOXAuazZpFO0rU=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=rEKiMn2EVZJ7/22NRyWpV+gJVcGmOgYH9LMY8MKHmMLcoapXZm/tCL/kYB0epu+7GEK5yJrgMYHgHN+NGA8adoBXLcGfweOhzOGv1vXM6TnZjT+hOEnNmJ19Wg8ggHB5572r78L5q7ITE6vpMC/lZkuMIfK86wD4zy7qn7dG6Fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Id8G1AAP; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Id8G1AAP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749646066; x=1781182066;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=58wWmn/AAv0t5U67CJoTQL76p41O7pOXAuazZpFO0rU=;
  b=Id8G1AAPxs6CNhDg2/ieLSBFRUyYWB33osXHhg5iTncsM4hoUXSAbBeh
   lmjcz19T2WfUQWG/jtaNJjLZpyy59W7SG9+4yt5ewo0cFy6XhWUWf/+m7
   ywl+7gWMskPGbiAvTnccH19471Bcc8mBInqCnpyVwWO0oxGgcBRkKFZRx
   qYIulEbYbNvQYqfIuXafqbo9fqFLtE3o3HssxRByZuduZ448gX6GE7XeB
   +m4cfhPk6ht5GuFbmNMDS0R+q4NfhI7k2zbkCttjuOYOJbz6YUgyIfB+Q
   GkTdisDlHzkgCx2jzZc3Xyzo8p9EvjHyE3xVYS80dILrlRDQD9Om6ZpYz
   Q==;
X-CSE-ConnectionGUID: 20o2LHJ7Rhu/3qPWucYPNg==
X-CSE-MsgGUID: f5iT5ZgnSQ6/jh0kFhRw5g==
X-IronPort-AV: E=McAfee;i="6800,10657,11461"; a="51499827"
X-IronPort-AV: E=Sophos;i="6.16,227,1744095600"; 
   d="scan'208";a="51499827"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2025 05:47:46 -0700
X-CSE-ConnectionGUID: AhtYIV9MR1WC5kP6ZWyYfA==
X-CSE-MsgGUID: dmI2UtMxTAil53awZIlCvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,227,1744095600"; 
   d="scan'208";a="152467978"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.183])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2025 05:47:43 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 11 Jun 2025 15:47:38 +0300 (EEST)
To: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
cc: gregkh@linuxfoundation.org, linux-serial@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH 22/33] serial: 8250: extract serial8250_set_ier()
In-Reply-To: <20250611100319.186924-23-jirislaby@kernel.org>
Message-ID: <0c8d8cf2-03fd-b65d-9dc1-b8529e46cd3f@linux.intel.com>
References: <20250611100319.186924-1-jirislaby@kernel.org> <20250611100319.186924-23-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1986209817-1749646058=:957"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1986209817-1749646058=:957
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 11 Jun 2025, Jiri Slaby (SUSE) wrote:

> serial8250_do_set_termios() consists of many registers and up flags
> settings. Extract all these into separate functions. This time, setting
> of IER.
>=20
> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
> ---
>  drivers/tty/serial/8250/8250_port.c | 31 ++++++++++++++++-------------
>  1 file changed, 17 insertions(+), 14 deletions(-)
>=20
> diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/825=
0/8250_port.c
> index 6bb7f004d607..2c045a4369fc 100644
> --- a/drivers/tty/serial/8250/8250_port.c
> +++ b/drivers/tty/serial/8250/8250_port.c
> @@ -2752,6 +2752,22 @@ static void serial8250_set_errors_and_ignores(stru=
ct uart_port *port, struct kte
>  =09=09port->ignore_status_mask |=3D UART_LSR_DR;
>  }
> =20
> +static void serial8250_set_ier(struct uart_port *port, struct ktermios *=
termios)
> +{
> +=09struct uart_8250_port *up =3D up_to_u8250p(port);
> +
> +=09/* CTS flow control flag and modem status interrupts */
> +=09up->ier &=3D ~UART_IER_MSI;
> +=09if (!(up->bugs & UART_BUG_NOMSR) && UART_ENABLE_MS(&up->port, termios=
->c_cflag))
> +=09=09up->ier |=3D UART_IER_MSI;
> +=09if (up->capabilities & UART_CAP_UUE)
> +=09=09up->ier |=3D UART_IER_UUE;
> +=09if (up->capabilities & UART_CAP_RTOIE)
> +=09=09up->ier |=3D UART_IER_RTOIE;
> +
> +=09serial_port_out(port, UART_IER, up->ier);
> +}
> +
>  void
>  serial8250_do_set_termios(struct uart_port *port, struct ktermios *termi=
os,
>  =09=09          const struct ktermios *old)
> @@ -2780,20 +2796,7 @@ serial8250_do_set_termios(struct uart_port *port, =
struct ktermios *termios,
>  =09serial8250_set_afe(port, termios);
>  =09uart_update_timeout(port, termios->c_cflag, baud);
>  =09serial8250_set_errors_and_ignores(port, termios);
> -
> -=09/*
> -=09 * CTS flow control flag and modem status interrupts
> -=09 */
> -=09up->ier &=3D ~UART_IER_MSI;
> -=09if (!(up->bugs & UART_BUG_NOMSR) &&
> -=09=09=09UART_ENABLE_MS(&up->port, termios->c_cflag))
> -=09=09up->ier |=3D UART_IER_MSI;
> -=09if (up->capabilities & UART_CAP_UUE)
> -=09=09up->ier |=3D UART_IER_UUE;
> -=09if (up->capabilities & UART_CAP_RTOIE)
> -=09=09up->ier |=3D UART_IER_RTOIE;
> -
> -=09serial_port_out(port, UART_IER, up->ier);
> +=09serial8250_set_ier(port, termios);
> =20
>  =09if (up->capabilities & UART_CAP_EFR) {
>  =09=09unsigned char efr =3D 0;
>=20

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.

--8323328-1986209817-1749646058=:957--
