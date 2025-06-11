Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F18E32E611B;
	Wed, 11 Jun 2025 11:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749642571; cv=none; b=UwyDpRlUOnC+XthCrpx0tM86LRB1YQ3ibCfd37aOO5WTin2XBfEJm/2+mXDY3ZyaYrG3KZwfyHYMzNVYp4JcC+TGgJbv/Viy7Z8snPz4bwgCu5WDLCe+wCcAegzaNXB8Nevrc9AGfDPt6MTfEJmqmwxTOx0K9nzmXC5RUzWpSzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749642571; c=relaxed/simple;
	bh=AuV1sbkvV6me8J9YURc/SUOK6IBHhelqaiEVy4c4ZEM=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ENRUgUoYNNQ6IC0abG34gkhOlwhK/xHX3Cxys3szvY5cC7+vF3D17n3R3EWt4Fq9IgqAjwdSO6iVUprpRU3A9Ii2OKc2QH9hyC78s2Neuw7zQd2pUJ6TcOtnO7Q+7AWstg8PpD80mCzXSSZrW4GavIJY+iv0Ct8cNoprrQR0ldc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iV43ZDb6; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iV43ZDb6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749642570; x=1781178570;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=AuV1sbkvV6me8J9YURc/SUOK6IBHhelqaiEVy4c4ZEM=;
  b=iV43ZDb6YpxkV2ca6W7kn2eLtvf7SdDLLmbpryq+gFHxUOw+792KQX2k
   0/aS1nBpzImgHuYseqjIdK4tjWs0hBTuXcAkcsU5C+wggQvnQ5Vqa6QBD
   DAUzidojhBctG5bpcJTO7IWljiTkrAKdCW4JNwZU6K9RjSXdOVZeLd8BV
   6lb3qBGZmqBL6uIGuo0pceojYKb8wXDf0EDcDWJt5cxNsbWGi3ThQnHqs
   yfQMX7nYb5207oG0efszX1XSjdjzju0VoePCr5r3Z/NjQofLPl/zUvbnV
   udcGjOs5gEQI5CdEEIJTxwBK4yRAo23Q54uNxernn3mOaCApOzCQp9DBx
   w==;
X-CSE-ConnectionGUID: pzYPZGT1RTmAyClB6GrQAA==
X-CSE-MsgGUID: 4hFHfO5gSAKtvLRX+6wsDw==
X-IronPort-AV: E=McAfee;i="6800,10657,11460"; a="39400851"
X-IronPort-AV: E=Sophos;i="6.16,227,1744095600"; 
   d="scan'208";a="39400851"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2025 04:49:17 -0700
X-CSE-ConnectionGUID: uhaPBnlMRNCWDnv1/G+TvA==
X-CSE-MsgGUID: 4HFYnJJZT3aRwg3UQNPX6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,227,1744095600"; 
   d="scan'208";a="147089132"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.183])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2025 04:49:16 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 11 Jun 2025 14:49:11 +0300 (EEST)
To: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
cc: gregkh@linuxfoundation.org, linux-serial@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH 12/33] serial: 8250: move RSA functions to 8250_rsa.c
In-Reply-To: <20250611100319.186924-13-jirislaby@kernel.org>
Message-ID: <12af3273-a8b3-d88e-3c5a-290595e346a2@linux.intel.com>
References: <20250611100319.186924-1-jirislaby@kernel.org> <20250611100319.186924-13-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1686644607-1749642551=:957"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1686644607-1749642551=:957
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 11 Jun 2025, Jiri Slaby (SUSE) wrote:

> They are RSA-specific, so should live in a preexisting 8250_rsa.c. Move
> them there.
>=20
> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>

No unexpected change found in the diff-of-diffs,

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.

> ---
>  drivers/tty/serial/8250/8250.h      |  8 +++
>  drivers/tty/serial/8250/8250_port.c | 99 -----------------------------
>  drivers/tty/serial/8250/8250_rsa.c  | 92 +++++++++++++++++++++++++++
>  3 files changed, 100 insertions(+), 99 deletions(-)
>=20
> diff --git a/drivers/tty/serial/8250/8250.h b/drivers/tty/serial/8250/825=
0.h
> index 18530c31a598..cfe6ba286b45 100644
> --- a/drivers/tty/serial/8250/8250.h
> +++ b/drivers/tty/serial/8250/8250.h
> @@ -318,8 +318,16 @@ static inline void serial8250_pnp_exit(void) { }
> =20
>  #ifdef CONFIG_SERIAL_8250_RSA
>  void univ8250_rsa_support(struct uart_ops *ops);
> +void rsa_enable(struct uart_8250_port *up);
> +void rsa_disable(struct uart_8250_port *up);
> +void rsa_autoconfig(struct uart_8250_port *up);
> +void rsa_reset(struct uart_8250_port *up);
>  #else
>  static inline void univ8250_rsa_support(struct uart_ops *ops) { }
> +static inline void rsa_enable(struct uart_8250_port *up) {}
> +static inline void rsa_disable(struct uart_8250_port *up) {}
> +static inline void rsa_autoconfig(struct uart_8250_port *up) {}
> +static inline void rsa_reset(struct uart_8250_port *up) {}
>  #endif
> =20
>  #ifdef CONFIG_SERIAL_8250_FINTEK
> diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/825=
0/8250_port.c
> index d8a90818f431..476f5fc50237 100644
> --- a/drivers/tty/serial/8250/8250_port.c
> +++ b/drivers/tty/serial/8250/8250_port.c
> @@ -713,105 +713,6 @@ static void serial8250_clear_IER(struct uart_8250_p=
ort *up)
>  =09=09serial_out(up, UART_IER, 0);
>  }
> =20
> -#ifdef CONFIG_SERIAL_8250_RSA
> -/*
> - * Attempts to turn on the RSA FIFO.  Returns zero on failure.
> - * We set the port uart clock rate if we succeed.
> - */
> -static int __rsa_enable(struct uart_8250_port *up)
> -{
> -=09unsigned char mode;
> -=09int result;
> -
> -=09mode =3D serial_in(up, UART_RSA_MSR);
> -=09result =3D mode & UART_RSA_MSR_FIFO;
> -
> -=09if (!result) {
> -=09=09serial_out(up, UART_RSA_MSR, mode | UART_RSA_MSR_FIFO);
> -=09=09mode =3D serial_in(up, UART_RSA_MSR);
> -=09=09result =3D mode & UART_RSA_MSR_FIFO;
> -=09}
> -
> -=09if (result)
> -=09=09up->port.uartclk =3D SERIAL_RSA_BAUD_BASE * 16;
> -
> -=09return result;
> -}
> -
> -/*
> - * If this is an RSA port, see if we can kick it up to the higher speed =
clock.
> - */
> -static void rsa_enable(struct uart_8250_port *up)
> -{
> -=09if (up->port.type !=3D PORT_RSA)
> -=09=09return;
> -
> -=09if (up->port.uartclk !=3D SERIAL_RSA_BAUD_BASE * 16) {
> -=09=09uart_port_lock_irq(&up->port);
> -=09=09__rsa_enable(up);
> -=09=09uart_port_unlock_irq(&up->port);
> -=09}
> -=09if (up->port.uartclk =3D=3D SERIAL_RSA_BAUD_BASE * 16)
> -=09=09serial_out(up, UART_RSA_FRR, 0);
> -}
> -
> -/*
> - * Attempts to turn off the RSA FIFO and resets the RSA board back to 11=
5kbps compat mode. It is
> - * unknown why interrupts were disabled in here. However, the caller is =
expected to preserve this
> - * behaviour by grabbing the spinlock before calling this function.
> - */
> -static void rsa_disable(struct uart_8250_port *up)
> -{
> -=09unsigned char mode;
> -=09int result;
> -
> -=09if (up->port.type !=3D PORT_RSA)
> -=09=09return;
> -
> -=09if (up->port.uartclk !=3D SERIAL_RSA_BAUD_BASE * 16)
> -=09=09return;
> -
> -=09uart_port_lock_irq(&up->port);
> -=09mode =3D serial_in(up, UART_RSA_MSR);
> -=09result =3D !(mode & UART_RSA_MSR_FIFO);
> -
> -=09if (!result) {
> -=09=09serial_out(up, UART_RSA_MSR, mode & ~UART_RSA_MSR_FIFO);
> -=09=09mode =3D serial_in(up, UART_RSA_MSR);
> -=09=09result =3D !(mode & UART_RSA_MSR_FIFO);
> -=09}
> -
> -=09if (result)
> -=09=09up->port.uartclk =3D SERIAL_RSA_BAUD_BASE_LO * 16;
> -=09uart_port_unlock_irq(&up->port);
> -}
> -
> -static void rsa_autoconfig(struct uart_8250_port *up)
> -{
> -=09/* Only probe for RSA ports if we got the region. */
> -=09if (up->port.type !=3D PORT_16550A)
> -=09=09return;
> -=09if (!(up->probe & UART_PROBE_RSA))
> -=09=09return;
> -
> -=09if (__rsa_enable(up))
> -=09=09up->port.type =3D PORT_RSA;
> -}
> -
> -static void rsa_reset(struct uart_8250_port *up)
> -{
> -=09if (up->port.type !=3D PORT_RSA)
> -=09=09return;
> -
> -=09serial_out(up, UART_RSA_FRR, 0);
> -}
> -#else
> -static inline void rsa_enable(struct uart_8250_port *up) {}
> -static inline void rsa_disable(struct uart_8250_port *up) {}
> -static inline void rsa_autoconfig(struct uart_8250_port *up) {}
> -static inline void rsa_reset(struct uart_8250_port *up) {}
> -#endif /* CONFIG_SERIAL_8250_RSA */
> -
>  /*
>   * This is a quickie test to see how big the FIFO is.
>   * It doesn't work at all the time, more's the pity.
> diff --git a/drivers/tty/serial/8250/8250_rsa.c b/drivers/tty/serial/8250=
/8250_rsa.c
> index 4c8b9671bd41..59d2ecf23068 100644
> --- a/drivers/tty/serial/8250/8250_rsa.c
> +++ b/drivers/tty/serial/8250/8250_rsa.c
> @@ -107,6 +107,98 @@ void univ8250_rsa_support(struct uart_ops *ops)
>  module_param_hw_array(probe_rsa, ulong, ioport, &probe_rsa_count, 0444);
>  MODULE_PARM_DESC(probe_rsa, "Probe I/O ports for RSA");
> =20
> +/*
> + * Attempts to turn on the RSA FIFO.  Returns zero on failure.
> + * We set the port uart clock rate if we succeed.
> + */
> +static int __rsa_enable(struct uart_8250_port *up)
> +{
> +=09unsigned char mode;
> +=09int result;
> +
> +=09mode =3D serial_in(up, UART_RSA_MSR);
> +=09result =3D mode & UART_RSA_MSR_FIFO;
> +
> +=09if (!result) {
> +=09=09serial_out(up, UART_RSA_MSR, mode | UART_RSA_MSR_FIFO);
> +=09=09mode =3D serial_in(up, UART_RSA_MSR);
> +=09=09result =3D mode & UART_RSA_MSR_FIFO;
> +=09}
> +
> +=09if (result)
> +=09=09up->port.uartclk =3D SERIAL_RSA_BAUD_BASE * 16;
> +
> +=09return result;
> +}
> +
> +/*
> + * If this is an RSA port, see if we can kick it up to the higher speed =
clock.
> + */
> +void rsa_enable(struct uart_8250_port *up)
> +{
> +=09if (up->port.type !=3D PORT_RSA)
> +=09=09return;
> +
> +=09if (up->port.uartclk !=3D SERIAL_RSA_BAUD_BASE * 16) {
> +=09=09uart_port_lock_irq(&up->port);
> +=09=09__rsa_enable(up);
> +=09=09uart_port_unlock_irq(&up->port);
> +=09}
> +=09if (up->port.uartclk =3D=3D SERIAL_RSA_BAUD_BASE * 16)
> +=09=09serial_out(up, UART_RSA_FRR, 0);
> +}
> +
> +/*
> + * Attempts to turn off the RSA FIFO and resets the RSA board back to 11=
5kbps compat mode. It is
> + * unknown why interrupts were disabled in here. However, the caller is =
expected to preserve this
> + * behaviour by grabbing the spinlock before calling this function.
> + */
> +void rsa_disable(struct uart_8250_port *up)
> +{
> +=09unsigned char mode;
> +=09int result;
> +
> +=09if (up->port.type !=3D PORT_RSA)
> +=09=09return;
> +
> +=09if (up->port.uartclk !=3D SERIAL_RSA_BAUD_BASE * 16)
> +=09=09return;
> +
> +=09uart_port_lock_irq(&up->port);
> +=09mode =3D serial_in(up, UART_RSA_MSR);
> +=09result =3D !(mode & UART_RSA_MSR_FIFO);
> +
> +=09if (!result) {
> +=09=09serial_out(up, UART_RSA_MSR, mode & ~UART_RSA_MSR_FIFO);
> +=09=09mode =3D serial_in(up, UART_RSA_MSR);
> +=09=09result =3D !(mode & UART_RSA_MSR_FIFO);
> +=09}
> +
> +=09if (result)
> +=09=09up->port.uartclk =3D SERIAL_RSA_BAUD_BASE_LO * 16;
> +=09uart_port_unlock_irq(&up->port);
> +}
> +
> +void rsa_autoconfig(struct uart_8250_port *up)
> +{
> +=09/* Only probe for RSA ports if we got the region. */
> +=09if (up->port.type !=3D PORT_16550A)
> +=09=09return;
> +=09if (!(up->probe & UART_PROBE_RSA))
> +=09=09return;
> +
> +=09if (__rsa_enable(up))
> +=09=09up->port.type =3D PORT_RSA;
> +}
> +
> +void rsa_reset(struct uart_8250_port *up)
> +{
> +=09if (up->port.type !=3D PORT_RSA)
> +=09=09return;
> +
> +=09serial_out(up, UART_RSA_FRR, 0);
> +}
> +
>  #ifdef CONFIG_SERIAL_8250_DEPRECATED_OPTIONS
>  #ifndef MODULE
>  /*
>=20
--8323328-1686644607-1749642551=:957--
