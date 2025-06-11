Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA2E82E6123;
	Wed, 11 Jun 2025 12:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749645322; cv=none; b=cAjk0UFGhZlP0EyKdOqPKKAyaNSL9ITNYmhL8yMOTLMGBwUf6XUqIv8u57A5Cl+QDO32XCB6If4pQA6VPxEXIIdTJ9Blz9m8410IGpodcFrPDFoYvrFumOUm56OLi+Zx5xrIWHr9pzwxwGCx7u1mKfSeAJybNXwmbTx4C5Z3hzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749645322; c=relaxed/simple;
	bh=Lfb02Jo+43qW8H3V2NfIVq3vmU0B/6G6Chg7P0ENtk8=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=rusYy3Go6HKWlTFTWcrc40Wb29Or2DMCwWhkDT2kaFrZ6igsnqfzXCtj5MoXGSprhjGh3WudvxgEO5OfmufqVWLoJYX3c7qLqCzJsYZDPhs0bJZQzAfBGapQSptuDp8iVMULAOCPpG0CcgWCi8S5r9LrKHlDt1iVntwl/KWpwL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J/JfMTYF; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J/JfMTYF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749645321; x=1781181321;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Lfb02Jo+43qW8H3V2NfIVq3vmU0B/6G6Chg7P0ENtk8=;
  b=J/JfMTYFe1TwaVQ0D3tYGu3jWekvqGtGlztkNlORupZCCvv1rUKqmKSz
   hsGbUrq9v5vFbABm6s38jmRirpKuPIGuLai3jOaLabbSrUhHLxtybmYlB
   Fh1uoF1PJj/JhR02a4/kxknaaQhbrmXprxcis8Yc6RwKrcT7iu8zz631H
   IMD6m7MbL3FmFHVPxEGx+MDdnRFRp/UAYc7JpQe7fOtvKQoD3FnysMj4U
   Lmj4CQfXSHE6fJWDiPxB0jbi6O7YaaIqyjfvFisvi0kCN0qWVnOZhxmsG
   ksFZTkPkNahjByoFsxjYXMsimk30YEx6IP7hFYIWZSehZ23xb8BzEW7Gj
   w==;
X-CSE-ConnectionGUID: gaA03MsuRD2hE23yTgm0+w==
X-CSE-MsgGUID: AwUgpQBMStCHhTq+hqIGvQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11461"; a="62065572"
X-IronPort-AV: E=Sophos;i="6.16,227,1744095600"; 
   d="scan'208";a="62065572"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2025 05:35:11 -0700
X-CSE-ConnectionGUID: F74wZCpyS4yna4uwWe2bsQ==
X-CSE-MsgGUID: ChXHrNjIQxe3FpnjfN/8VA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,227,1744095600"; 
   d="scan'208";a="147743268"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.183])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2025 05:35:08 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 11 Jun 2025 15:35:04 +0300 (EEST)
To: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
cc: gregkh@linuxfoundation.org, linux-serial@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH 20/33] serial: 8250: extract serial8250_set_afe()
In-Reply-To: <20250611100319.186924-21-jirislaby@kernel.org>
Message-ID: <1de58a33-b2f2-3425-752c-cabd2eda89bf@linux.intel.com>
References: <20250611100319.186924-1-jirislaby@kernel.org> <20250611100319.186924-21-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-2056429544-1749645304=:957"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-2056429544-1749645304=:957
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 11 Jun 2025, Jiri Slaby (SUSE) wrote:

> serial8250_do_set_termios() consists of many registers and up flags
> settings. Extract all these into separate functions. This time, setting
> of MCR for UART_CAP_AFE ports.
>=20
> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
> ---
>  drivers/tty/serial/8250/8250_port.c | 32 +++++++++++++++--------------
>  1 file changed, 17 insertions(+), 15 deletions(-)
>=20
> diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/825=
0/8250_port.c
> index 52385314c426..b15371838366 100644
> --- a/drivers/tty/serial/8250/8250_port.c
> +++ b/drivers/tty/serial/8250/8250_port.c
> @@ -2704,6 +2704,22 @@ static void serial8250_set_trigger_for_slow_speed(=
struct uart_port *port, struct
>  =09up->fcr |=3D UART_FCR_TRIGGER_1;
>  }
> =20
> +/*
> + * MCR-based auto flow control. When AFE is enabled, RTS will be deasser=
ted when the receive FIFO
> + * contains more characters than the trigger, or the MCR RTS bit is clea=
red.
> + */
> +static void serial8250_set_afe(struct uart_port *port, struct ktermios *=
termios)
> +{
> +=09struct uart_8250_port *up =3D up_to_u8250p(port);
> +
> +=09if (!(up->capabilities & UART_CAP_AFE))
> +=09=09return;
> +
> +=09up->mcr &=3D ~UART_MCR_AFE;
> +=09if (termios->c_cflag & CRTSCTS)
> +=09=09up->mcr |=3D UART_MCR_AFE;
> +}
> +
>  void
>  serial8250_do_set_termios(struct uart_port *port, struct ktermios *termi=
os,
>  =09=09          const struct ktermios *old)
> @@ -2729,21 +2745,7 @@ serial8250_do_set_termios(struct uart_port *port, =
struct ktermios *termios,
> =20
>  =09up->lcr =3D cval;=09=09=09=09=09/* Save computed LCR */
>  =09serial8250_set_trigger_for_slow_speed(port, termios, baud);
> -
> -=09/*
> -=09 * MCR-based auto flow control.  When AFE is enabled, RTS will be
> -=09 * deasserted when the receive FIFO contains more characters than
> -=09 * the trigger, or the MCR RTS bit is cleared.
> -=09 */
> -=09if (up->capabilities & UART_CAP_AFE) {
> -=09=09up->mcr &=3D ~UART_MCR_AFE;
> -=09=09if (termios->c_cflag & CRTSCTS)
> -=09=09=09up->mcr |=3D UART_MCR_AFE;
> -=09}
> -
> -=09/*
> -=09 * Update the per-port timeout.
> -=09 */
> +=09serial8250_set_afe(port, termios);
>  =09uart_update_timeout(port, termios->c_cflag, baud);
> =20
>  =09/*
>=20

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.

--8323328-2056429544-1749645304=:957--
