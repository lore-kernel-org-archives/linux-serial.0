Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAAF027CCF3;
	Wed, 11 Jun 2025 13:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749646918; cv=none; b=oGLMsMz/FeGy/HrX/o14EcXUGLS8CEb8B+kHRA+Us2k1jTV8oSvIqFMZELy6mb7ma9e/excXa5q0efVMCXrFn2NkTr4p2Ev/yQ7bL3lwHCtJ0bMH41oQeXrof6eKd6IEbAdcDwZlx8HFTsHGJ/DiHvD2Cnp58ufGRb54OfTqqJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749646918; c=relaxed/simple;
	bh=wBGF3MH8wy3Irie1YSoRIMKpmvzTW1os8hg0quSGLqg=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=SmVGyCIgfZvSJ41/j+7ATdAOh28dxVS8OhhB6Kk8R9xHrBcxwaFANfN4/+Rdcsm3hWdBs1l/2aTdnX468WEVQNN9s5TVyo7vFAQst3ic6bAADxphnjNMfOPptvkArY8psIoZvKDlrcFwKWIAbt9QkNGa07UkB+fgT6R11HnvZhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XC2ibfEc; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XC2ibfEc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749646917; x=1781182917;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=wBGF3MH8wy3Irie1YSoRIMKpmvzTW1os8hg0quSGLqg=;
  b=XC2ibfEcJtSU7ZcoeHhcIqfCvR7aXu0mLOVMvJuLLc+OaCawQBRnblq5
   4DcFogX4b9LsscvjBjAL3GBnG1cfz+ggVJuPCLuWUq2xOvikciM2ABSUo
   0Pu8r5Z0gOHBO+Kz4uefDrnzpbCBFQB+cDK9nxP/Aq0kku/sNF0cusUZC
   Ad1WS+Ol7rP8Vz5kzAH/XAaKW2vA8cM00DwWPNFibAzi4o/DTfICB15Rt
   WgUTlIpaprfkHVb4W/3gxh27m76+9EKMD/JAknYQ9Ok+0z9ygFoUn0GLK
   FiT584o7NfK72q3hiOcUoy8Ib5O0CqB1y985tp8XWG3jyrQUG30JrWeMs
   w==;
X-CSE-ConnectionGUID: PdlEDo3MS4edzkp4aEr0kw==
X-CSE-MsgGUID: +axT6ppbQB2hfEtLTL818A==
X-IronPort-AV: E=McAfee;i="6800,10657,11461"; a="62068105"
X-IronPort-AV: E=Sophos;i="6.16,227,1744095600"; 
   d="scan'208";a="62068105"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2025 06:01:57 -0700
X-CSE-ConnectionGUID: wcrPaK8JSSKYPMryxyQUvA==
X-CSE-MsgGUID: ejq+zzRyQDWfbzM1aZHdeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,227,1744095600"; 
   d="scan'208";a="184398869"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.183])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2025 06:01:54 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 11 Jun 2025 16:01:50 +0300 (EEST)
To: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
cc: gregkh@linuxfoundation.org, linux-serial@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH 24/33] serial: 8250: extract serial8250_set_fcr()
In-Reply-To: <20250611100319.186924-25-jirislaby@kernel.org>
Message-ID: <5eba83d2-4273-7fad-529e-35b5e1e62bd5@linux.intel.com>
References: <20250611100319.186924-1-jirislaby@kernel.org> <20250611100319.186924-25-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1688731510-1749646910=:957"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1688731510-1749646910=:957
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 11 Jun 2025, Jiri Slaby (SUSE) wrote:

> serial8250_do_set_termios() consists of many registers and up flags
> settings. Extract all these into separate functions. This time, setting
> of FCR.
>=20
> serial8250_do_set_termios() looks sane at this point.
>=20
> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.

> ---
>  drivers/tty/serial/8250/8250_port.c | 41 ++++++++++++++++++-----------
>  1 file changed, 26 insertions(+), 15 deletions(-)
>=20
> diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/825=
0/8250_port.c
> index 0f16398cc86f..85b75ff0699e 100644
> --- a/drivers/tty/serial/8250/8250_port.c
> +++ b/drivers/tty/serial/8250/8250_port.c
> @@ -2792,6 +2792,30 @@ static void serial8250_set_efr(struct uart_port *p=
ort, struct ktermios *termios)
>  =09serial_port_out(port, efr_reg, efr);
>  }
> =20
> +static void serial8250_set_fcr(struct uart_port *port, struct ktermios *=
termios)
> +{
> +=09struct uart_8250_port *up =3D up_to_u8250p(port);
> +=09bool is_16750 =3D port->type =3D=3D PORT_16750;
> +
> +=09if (is_16750)
> +=09=09serial_port_out(port, UART_FCR, up->fcr);
> +
> +=09/*
> +=09 * LCR DLAB must be reset to enable 64-byte FIFO mode. If the FCR is =
written without DLAB
> +=09 * set, this mode will be disabled.
> +=09 */
> +=09serial_port_out(port, UART_LCR, up->lcr);
> +
> +=09if (is_16750)
> +=09=09return;
> +
> +=09/* emulated UARTs (Lucent Venus 167x) need two steps */
> +=09if (up->fcr & UART_FCR_ENABLE_FIFO)
> +=09=09serial_port_out(port, UART_FCR, UART_FCR_ENABLE_FIFO);
> +
> +=09serial_port_out(port, UART_FCR, up->fcr);
> +}
> +
>  void
>  serial8250_do_set_termios(struct uart_port *port, struct ktermios *termi=
os,
>  =09=09          const struct ktermios *old)
> @@ -2823,22 +2847,9 @@ serial8250_do_set_termios(struct uart_port *port, =
struct ktermios *termios,
>  =09serial8250_set_ier(port, termios);
>  =09serial8250_set_efr(port, termios);
>  =09serial8250_set_divisor(port, baud, quot, frac);
> -
> -=09/*
> -=09 * LCR DLAB must be set to enable 64-byte FIFO mode. If the FCR
> -=09 * is written without DLAB set, this mode will be disabled.
> -=09 */
> -=09if (port->type =3D=3D PORT_16750)
> -=09=09serial_port_out(port, UART_FCR, up->fcr);
> -
> -=09serial_port_out(port, UART_LCR, up->lcr);=09/* reset DLAB */
> -=09if (port->type !=3D PORT_16750) {
> -=09=09/* emulated UARTs (Lucent Venus 167x) need two steps */
> -=09=09if (up->fcr & UART_FCR_ENABLE_FIFO)
> -=09=09=09serial_port_out(port, UART_FCR, UART_FCR_ENABLE_FIFO);
> -=09=09serial_port_out(port, UART_FCR, up->fcr);=09/* set fcr */
> -=09}
> +=09serial8250_set_fcr(port, termios);
>  =09serial8250_set_mctrl(port, port->mctrl);
> +
>  =09uart_port_unlock_irqrestore(port, flags);
>  =09serial8250_rpm_put(up);
> =20
>=20
--8323328-1688731510-1749646910=:957--
