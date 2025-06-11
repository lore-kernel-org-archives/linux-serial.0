Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C01882777F7;
	Wed, 11 Jun 2025 12:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749644852; cv=none; b=oRSDtwORB1N/Aomh+QPdYtHeT4pVOexGEEWSpqI/+YvbD5bn6O+ahOF0ICF0VuuuBYgqqlVyJts3PXO2Gaj231dvM0r0USVlAmIKl7dZJzmZPo4y5KR0eaO+awdsxUIlgCw+GbiRd5735WWY49g9TcZTOPvlnXi3AL86mbJdvwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749644852; c=relaxed/simple;
	bh=RjEntDbrU6uWcnkzSUUjf9kM9SHS98XmvdM0tJf5ijo=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=LX4jkmxql0qcZcVNO5F0g2hhEwPv9EyyvXmrVpW8KicQF1Q7bagvC+PfGcz6imVt6IoLpYXeN3E7FIo6HasXMZvqRjwKNSnGV+eBp3+eHHDHkqlo/ClaLKDoqLJSYE0my6JWSkTfSdHpAc38Os/fCiClB1YxwCg21mjuGLxI2IE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ItuEfpaa; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ItuEfpaa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749644851; x=1781180851;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=RjEntDbrU6uWcnkzSUUjf9kM9SHS98XmvdM0tJf5ijo=;
  b=ItuEfpaadiE2pCEQRQWierNhLsdZ5rXLHrJ9rrPoJ5z0engAOokiJBp+
   DajbBBfoAcMphSspHf0de13ZWlSsoLfnxye/CindFSSH+OHYM4HOPqyOh
   1ZXlL4DiOrzIJjPmvKPmmpXKaMHGbyIodSYqS9FNACW9iYBebV7YidcbO
   c5gPLDfNDYm8EwTnnZOEFJSCQB2QaoEyTU/xXlULTJqL3TdioWqLdqXzg
   rx101A5E6oHaaZO5GIEYcd6QxvGPYgCBaJW/tAOV5C3m5jLiBjl2hEKls
   bWrLYEifc/BFIkPyGoXGuqpodeQXJvI8g6SU3tTUJLU3X74I+HEosPJmk
   g==;
X-CSE-ConnectionGUID: h0wjVm5cSy6khihLjfnAmw==
X-CSE-MsgGUID: mz0W/GZYRIuYciozySmoRw==
X-IronPort-AV: E=McAfee;i="6800,10657,11461"; a="51008122"
X-IronPort-AV: E=Sophos;i="6.16,227,1744095600"; 
   d="scan'208";a="51008122"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2025 05:27:30 -0700
X-CSE-ConnectionGUID: s7c5YyUPSvSCi3Drb16i0A==
X-CSE-MsgGUID: 3SP6jsmsR2WA/9UxHBFOvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,227,1744095600"; 
   d="scan'208";a="151965714"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.183])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2025 05:27:28 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 11 Jun 2025 15:27:23 +0300 (EEST)
To: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    linux-serial <linux-serial@vger.kernel.org>, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 17/33] serial: 8250: extract
 serial8250_clear_interrupts()
In-Reply-To: <20250611100319.186924-18-jirislaby@kernel.org>
Message-ID: <baba910f-7c63-d908-af13-7120d085c6a1@linux.intel.com>
References: <20250611100319.186924-1-jirislaby@kernel.org> <20250611100319.186924-18-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1301835318-1749644843=:957"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1301835318-1749644843=:957
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 11 Jun 2025, Jiri Slaby (SUSE) wrote:

> On three places in 8250_port.c, the interrupts are cleared by reading 4
> registers. Extract this to a separate function:
> serial8250_clear_interrupts(). And call it from all the places.
>=20
> Note autoconfig_irq() now uses serial_port_in() instead of serial_in().
> But they are the same, in fact (modulo parameter).
>=20
> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
> ---
>  drivers/tty/serial/8250/8250_port.c | 27 ++++++++++++---------------
>  1 file changed, 12 insertions(+), 15 deletions(-)
>=20
> diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/825=
0/8250_port.c
> index 6851c197b31d..a73f4db22feb 100644
> --- a/drivers/tty/serial/8250/8250_port.c
> +++ b/drivers/tty/serial/8250/8250_port.c
> @@ -705,6 +705,15 @@ static void serial8250_set_sleep(struct uart_8250_po=
rt *p, int sleep)
>  =09serial8250_rpm_put(p);
>  }
> =20
> +/* Clear the interrupt registers. */
> +static void serial8250_clear_interrupts(struct uart_port *port)
> +{
> +=09serial_port_in(port, UART_LSR);
> +=09serial_port_in(port, UART_RX);
> +=09serial_port_in(port, UART_IIR);
> +=09serial_port_in(port, UART_MSR);

Okay, although I'd call some of these "status" registers. Yes, one can use=
=20
their status flags to trigger interrupts but it's not immediately obvious=
=20
to me if the calling code really _only_ wants to clear interrupts or if it=
=20
is also clearing stale status bits even if that's not explicitly=20
mentioned. Especially, the one callsite which zeroes also the stored=20
flags looks like it wants to get rid of stale status too (some status=20
bits might have not yet migrated from the register to the cached flags).

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>


> +}
> +
>  static void serial8250_clear_IER(struct uart_8250_port *up)
>  {
>  =09if (up->capabilities & UART_CAP_UUE)
> @@ -1275,10 +1284,7 @@ static void autoconfig_irq(struct uart_8250_port *=
up)
>  =09uart_port_lock_irq(port);
>  =09serial_out(up, UART_IER, UART_IER_ALL_INTR);
>  =09uart_port_unlock_irq(port);
> -=09serial_in(up, UART_LSR);
> -=09serial_in(up, UART_RX);
> -=09serial_in(up, UART_IIR);
> -=09serial_in(up, UART_MSR);
> +=09serial8250_clear_interrupts(port);
>  =09serial_out(up, UART_TX, 0xFF);
>  =09udelay(20);
>  =09irq =3D probe_irq_off(irqs);
> @@ -2322,13 +2328,7 @@ int serial8250_do_startup(struct uart_port *port)
>  =09 */
>  =09serial8250_clear_fifos(up);
> =20
> -=09/*
> -=09 * Clear the interrupt registers.
> -=09 */
> -=09serial_port_in(port, UART_LSR);
> -=09serial_port_in(port, UART_RX);
> -=09serial_port_in(port, UART_IIR);
> -=09serial_port_in(port, UART_MSR);
> +=09serial8250_clear_interrupts(port);
> =20
>  =09/*
>  =09 * At this point, there's no way the LSR could still be 0xff;
> @@ -2363,10 +2363,7 @@ int serial8250_do_startup(struct uart_port *port)
>  =09 * saved flags to avoid getting false values from polling
>  =09 * routines or the previous session.
>  =09 */
> -=09serial_port_in(port, UART_LSR);
> -=09serial_port_in(port, UART_RX);
> -=09serial_port_in(port, UART_IIR);
> -=09serial_port_in(port, UART_MSR);
> +=09serial8250_clear_interrupts(port);
>  =09up->lsr_saved_flags =3D 0;
>  =09up->msr_saved_flags =3D 0;
> =20
>=20

--=20
 i.

--8323328-1301835318-1749644843=:957--
