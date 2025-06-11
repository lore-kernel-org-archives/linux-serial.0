Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C1872E6122;
	Wed, 11 Jun 2025 11:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749642367; cv=none; b=rIEtdFejJS3Po14B1MXzvw/1RpPZMdQgm4cSfC3reGCAAeznfN3cSPbePXpxHTc/UXIN1rcmX1mjP7PtX4Hc2lRi88+vWDL0H80kydgPFoIvUQAWlzUVuZqvuOF4FW4fWaryslgKQXDKSUh3pwYhRd8VQcjiV5EUuXXBEcKWOoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749642367; c=relaxed/simple;
	bh=w6eIWXnO3yCzkh3ZsHnCibuvXeOxGt+HJo4enLI+60E=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=DJRDtjhfatsE7ydHg9h7ytl0/uAUUgbRGgQq02oNHKA9NuB4e51aVLFM9L8+tf9WWgl6Q32aCS8K4IQtf4dKcbfdIbrndt+MUDnAxpimYyVkLPvg98w93KyS1UX6y7mX838NjBxE9LXHZqRb3qYLKRJy45Bnqu/o66E14Ur6/H4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jtOrkcSz; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jtOrkcSz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749642361; x=1781178361;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=w6eIWXnO3yCzkh3ZsHnCibuvXeOxGt+HJo4enLI+60E=;
  b=jtOrkcSz1sPSFl6X1q5J/anra0jR6kHR1K42aLLwg4FFgGF+AZgIUdNB
   gKoZyxyScooRVgWH65O12Wcj1tVL8OLq0Xob5yP8PZJ7AcoY8nOYA9VUv
   DKYHI72WpwQ7ldlu6tnWaWM/Qf2ZXSOpQbUIutPXUoo4I0vg99wQN6LeS
   bAok++9458O88rjnXeCJxfV8X9jIxhgxyqoyd5VHuJApfe9BlOT7wZZ9R
   ErfUUapbIpxBBg4xtxTv9uUokO3Kn93GsqJs2unWyG/f8GyxVsZH6B+Mt
   FTyWi1s2qBGR6J3/FMRdZIIkusX38HV2+vjk8gnfYKsdBYIROcMCe7b4D
   w==;
X-CSE-ConnectionGUID: SFqwAiATRzOMGEnC+gvQxQ==
X-CSE-MsgGUID: I5dRv5YlSo2onEFYwKGgmA==
X-IronPort-AV: E=McAfee;i="6800,10657,11460"; a="51920923"
X-IronPort-AV: E=Sophos;i="6.16,227,1744095600"; 
   d="scan'208";a="51920923"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2025 04:46:00 -0700
X-CSE-ConnectionGUID: 2SNd4O50Sgis/VYxa1qalQ==
X-CSE-MsgGUID: oRwqfl8jQxa4QdJsfccMcQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,227,1744095600"; 
   d="scan'208";a="147733208"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.183])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2025 04:45:58 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 11 Jun 2025 14:45:54 +0300 (EEST)
To: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
cc: gregkh@linuxfoundation.org, linux-serial@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/33] serial: 8250: invert conditions in RSA functions
In-Reply-To: <20250611100319.186924-11-jirislaby@kernel.org>
Message-ID: <19c8369c-6839-1876-eefe-33dd69977707@linux.intel.com>
References: <20250611100319.186924-1-jirislaby@kernel.org> <20250611100319.186924-11-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1772484938-1749642354=:957"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1772484938-1749642354=:957
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 11 Jun 2025, Jiri Slaby (SUSE) wrote:

> The code can short-return in case something does not hold. So invert the
> conditions and return in those cases immediately. This makes the code
> flow more natural and less nested.

Ah, never mind my comment on the previous patch :-).

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.


> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
> ---
>  drivers/tty/serial/8250/8250_port.c | 59 +++++++++++++++++------------
>  1 file changed, 34 insertions(+), 25 deletions(-)
>=20
> diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/825=
0/8250_port.c
> index 233316a88df2..e7652d62ab2f 100644
> --- a/drivers/tty/serial/8250/8250_port.c
> +++ b/drivers/tty/serial/8250/8250_port.c
> @@ -743,15 +743,16 @@ static int __enable_rsa(struct uart_8250_port *up)
>   */
>  static void enable_rsa(struct uart_8250_port *up)
>  {
> -=09if (up->port.type =3D=3D PORT_RSA) {
> -=09=09if (up->port.uartclk !=3D SERIAL_RSA_BAUD_BASE * 16) {
> -=09=09=09uart_port_lock_irq(&up->port);
> -=09=09=09__enable_rsa(up);
> -=09=09=09uart_port_unlock_irq(&up->port);
> -=09=09}
> -=09=09if (up->port.uartclk =3D=3D SERIAL_RSA_BAUD_BASE * 16)
> -=09=09=09serial_out(up, UART_RSA_FRR, 0);
> +=09if (up->port.type !=3D PORT_RSA)
> +=09=09return;
> +
> +=09if (up->port.uartclk !=3D SERIAL_RSA_BAUD_BASE * 16) {
> +=09=09uart_port_lock_irq(&up->port);
> +=09=09__enable_rsa(up);
> +=09=09uart_port_unlock_irq(&up->port);
>  =09}
> +=09if (up->port.uartclk =3D=3D SERIAL_RSA_BAUD_BASE * 16)
> +=09=09serial_out(up, UART_RSA_FRR, 0);
>  }
> =20
>  /*
> @@ -764,37 +765,45 @@ static void disable_rsa(struct uart_8250_port *up)
>  =09unsigned char mode;
>  =09int result;
> =20
> -=09if (up->port.type =3D=3D PORT_RSA &&
> -=09    up->port.uartclk =3D=3D SERIAL_RSA_BAUD_BASE * 16) {
> -=09=09uart_port_lock_irq(&up->port);
> +=09if (up->port.type !=3D PORT_RSA)
> +=09=09return;
> =20
> -=09=09mode =3D serial_in(up, UART_RSA_MSR);
> -=09=09result =3D !(mode & UART_RSA_MSR_FIFO);
> +=09if (up->port.uartclk !=3D SERIAL_RSA_BAUD_BASE * 16)
> +=09=09return;
> =20
> -=09=09if (!result) {
> -=09=09=09serial_out(up, UART_RSA_MSR, mode & ~UART_RSA_MSR_FIFO);
> -=09=09=09mode =3D serial_in(up, UART_RSA_MSR);
> -=09=09=09result =3D !(mode & UART_RSA_MSR_FIFO);
> -=09=09}
> +=09uart_port_lock_irq(&up->port);
> +=09mode =3D serial_in(up, UART_RSA_MSR);
> +=09result =3D !(mode & UART_RSA_MSR_FIFO);
> =20
> -=09=09if (result)
> -=09=09=09up->port.uartclk =3D SERIAL_RSA_BAUD_BASE_LO * 16;
> -=09=09uart_port_unlock_irq(&up->port);
> +=09if (!result) {
> +=09=09serial_out(up, UART_RSA_MSR, mode & ~UART_RSA_MSR_FIFO);
> +=09=09mode =3D serial_in(up, UART_RSA_MSR);
> +=09=09result =3D !(mode & UART_RSA_MSR_FIFO);
>  =09}
> +
> +=09if (result)
> +=09=09up->port.uartclk =3D SERIAL_RSA_BAUD_BASE_LO * 16;
> +=09uart_port_unlock_irq(&up->port);
>  }
> =20
>  static void rsa_autoconfig(struct uart_8250_port *up)
>  {
>  =09/* Only probe for RSA ports if we got the region. */
> -=09if (up->port.type =3D=3D PORT_16550A && up->probe & UART_PROBE_RSA &&
> -=09    __enable_rsa(up))
> +=09if (up->port.type !=3D PORT_16550A)
> +=09=09return;
> +=09if (!(up->probe & UART_PROBE_RSA))
> +=09=09return;
> +
> +=09if (__enable_rsa(up))
>  =09=09up->port.type =3D PORT_RSA;
>  }
> =20
>  static void rsa_reset(struct uart_8250_port *up)
>  {
> -=09if (up->port.type =3D=3D PORT_RSA)
> -=09=09serial_out(up, UART_RSA_FRR, 0);
> +=09if (up->port.type !=3D PORT_RSA)
> +=09=09return;
> +
> +=09serial_out(up, UART_RSA_FRR, 0);
>  }
>  #else
>  static inline void enable_rsa(struct uart_8250_port *up) {}
>=20
--8323328-1772484938-1749642354=:957--
