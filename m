Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B740425BF12;
	Wed, 11 Jun 2025 11:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749642819; cv=none; b=Bn1T3ZHaBF0RhAgs0sMF8HqBQd6Ogk8j1sBZqDR0pswp8qj0wnVdn0/z1AImjIE4o0LH96EbjEe27Or/vau4l9VQBLeuI7zlLzLVd9GKYoll/5ZZONXZfAIruERS2gEyFSuEZV1L8fYiKWq0aEqG4RYzkCYYh+k8c9TTDENsyFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749642819; c=relaxed/simple;
	bh=3YgcALv5UpDU1VP62yB8oELOF/CrA0zK5VxMJcKE3rM=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=IL+0a0VoL9yzJylrQH88hDCtSRaSJw0r80fapQgSCjCZtuo/j0sSxggQKXYXb7yGhuP1zqRZajWRjCEnp7liL2F2IpLkzwxsRHP8hHC+Vxp16XxxHfXw5SgtTQoxXogqMD4d7tDKjaW1leG0fEybOnsXBpzU4VQNQwh9hDnJ2WM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PHz4HI9n; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PHz4HI9n"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749642818; x=1781178818;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=3YgcALv5UpDU1VP62yB8oELOF/CrA0zK5VxMJcKE3rM=;
  b=PHz4HI9nWug3XMiGdlLfu2n+O8n5BWw64WVUnykYRb/lD+Re+4czh08J
   xAj/RSeobi/UB1UI9l2SR153djfgLNb/JDW/6ZSzNvqDkp4AEzb00VF2B
   iJYe7bK0wWUep6vlMgiIcc4Ufet7Wt1JObqw25w7WzLc91F8fouIGqIDb
   UzvrrGqhyoVof+rUz/0ag22qDfWaEkCOJV16gxkc/aMvOVzhyVM0A4L7L
   jFWAWlC65YgLNE28tK9CtonZ0hZQPei0QHiuiyt8yWQDVCMvQKux5MX3a
   aWetkkHIhC3gFd4aALNlmszCRNK4Z/PFhkb4ZjOXYNvjJqDk/KVtfytCA
   A==;
X-CSE-ConnectionGUID: VFfkB+2TRV+yI/Fs0Yw2oQ==
X-CSE-MsgGUID: 9LjJaR3xSqe1zfVP9ShGmg==
X-IronPort-AV: E=McAfee;i="6800,10657,11460"; a="62435105"
X-IronPort-AV: E=Sophos;i="6.16,227,1744095600"; 
   d="scan'208";a="62435105"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2025 04:53:37 -0700
X-CSE-ConnectionGUID: /j7CDHu7Q+Geh5V6ikVv5A==
X-CSE-MsgGUID: YrZFgKFqR4Gur9l41DnglA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,227,1744095600"; 
   d="scan'208";a="178082141"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.183])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2025 04:53:35 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 11 Jun 2025 14:53:30 +0300 (EEST)
To: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    linux-serial <linux-serial@vger.kernel.org>, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 13/33] serial: 8250: extract
 serial8250_startup_special()
In-Reply-To: <20250611100319.186924-14-jirislaby@kernel.org>
Message-ID: <397ab91c-c05c-4dad-db94-866f500458fb@linux.intel.com>
References: <20250611100319.186924-1-jirislaby@kernel.org> <20250611100319.186924-14-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1727677288-1749642810=:957"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1727677288-1749642810=:957
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 11 Jun 2025, Jiri Slaby (SUSE) wrote:

> Let the serial8250_do_startup() code handle the special ports (16C950,
> DA830, RSA) startup in a separate function:
> serial8250_startup_special().
>=20
> And instead of multiple if-else-if, use switch-case. So that it can be
> easily checked for PORT_RSA now too.
>=20
> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>

Another very nice cleanup for old cruft.

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.

> ---
>  drivers/tty/serial/8250/8250_port.c | 53 +++++++++++++++++------------
>  1 file changed, 32 insertions(+), 21 deletions(-)
>=20
> diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/825=
0/8250_port.c
> index 476f5fc50237..21ff56a31b56 100644
> --- a/drivers/tty/serial/8250/8250_port.c
> +++ b/drivers/tty/serial/8250/8250_port.c
> @@ -2111,27 +2111,13 @@ static void serial8250_put_poll_char(struct uart_=
port *port,
> =20
>  #endif /* CONFIG_CONSOLE_POLL */
> =20
> -int serial8250_do_startup(struct uart_port *port)
> +static void serial8250_startup_special(struct uart_port *port)
>  {
>  =09struct uart_8250_port *up =3D up_to_u8250p(port);
>  =09unsigned long flags;
> -=09unsigned char iir;
> -=09int retval;
> -=09u16 lsr;
> -
> -=09if (!port->fifosize)
> -=09=09port->fifosize =3D uart_config[port->type].fifo_size;
> -=09if (!up->tx_loadsz)
> -=09=09up->tx_loadsz =3D uart_config[port->type].tx_loadsz;
> -=09if (!up->capabilities)
> -=09=09up->capabilities =3D uart_config[port->type].flags;
> -=09up->mcr =3D 0;
> -
> -=09if (port->iotype !=3D up->cur_iotype)
> -=09=09set_io_from_upio(port);
> =20
> -=09serial8250_rpm_get(up);
> -=09if (port->type =3D=3D PORT_16C950) {
> +=09switch (port->type) {
> +=09case PORT_16C950:
>  =09=09/*
>  =09=09 * Wake up and initialize UART
>  =09=09 *
> @@ -2148,9 +2134,8 @@ int serial8250_do_startup(struct uart_port *port)
>  =09=09serial_port_out(port, UART_EFR, UART_EFR_ECB);
>  =09=09serial_port_out(port, UART_LCR, 0);
>  =09=09uart_port_unlock_irqrestore(port, flags);
> -=09}
> -
> -=09if (port->type =3D=3D PORT_DA830) {
> +=09=09break;
> +=09case PORT_DA830:
>  =09=09/*
>  =09=09 * Reset the port
>  =09=09 *
> @@ -2167,9 +2152,35 @@ int serial8250_do_startup(struct uart_port *port)
>  =09=09=09=09UART_DA830_PWREMU_MGMT_UTRST |
>  =09=09=09=09UART_DA830_PWREMU_MGMT_URRST |
>  =09=09=09=09UART_DA830_PWREMU_MGMT_FREE);
> +=09=09break;
> +=09case PORT_RSA:
> +=09=09rsa_enable(up);
> +=09=09break;
>  =09}
> +}
> +
> +int serial8250_do_startup(struct uart_port *port)
> +{
> +=09struct uart_8250_port *up =3D up_to_u8250p(port);
> +=09unsigned long flags;
> +=09unsigned char iir;
> +=09int retval;
> +=09u16 lsr;
> +
> +=09if (!port->fifosize)
> +=09=09port->fifosize =3D uart_config[port->type].fifo_size;
> +=09if (!up->tx_loadsz)
> +=09=09up->tx_loadsz =3D uart_config[port->type].tx_loadsz;
> +=09if (!up->capabilities)
> +=09=09up->capabilities =3D uart_config[port->type].flags;
> +=09up->mcr =3D 0;
> +
> +=09if (port->iotype !=3D up->cur_iotype)
> +=09=09set_io_from_upio(port);
> +
> +=09serial8250_rpm_get(up);
> =20
> -=09rsa_enable(up);
> +=09serial8250_startup_special(port);
> =20
>  =09/*
>  =09 * Clear the FIFO buffers and disable them.
>=20
--8323328-1727677288-1749642810=:957--
