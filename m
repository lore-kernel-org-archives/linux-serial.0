Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8EC8221FD2;
	Tue, 24 Jun 2025 11:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750763761; cv=none; b=fT0Ay4biDK3cKQGGLrdUYsvXVZ6Q6J2X3FwhYoZjZgd4kD1E5wd/KojpRTXUwRYiZW9gQXX3vvfl7GNS4ySqma9ZRzlZNL6pz2mZ2citWptkMoFLxVBXIrnNrV3nHwkuS+2qnoTU6WCeUmzG2p76D8ihiFLFPWx1fsiZai0zSV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750763761; c=relaxed/simple;
	bh=/hEDWmKMpxL1TTtSTgQajlUalHKiOIbTebJglgbd3XI=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=nVAySYs6pgrJEs7Hky22prRkSWtKdHLQLidz3rspAIFxWJD12AvQa4OHbGyu7jqzLaxZ5GoTDQh/oeyk9RDD2m0xJDBBeoWGYvHKaJVfkXV472IIcVcg1TgdLqOeIT9vPEbwJMf3J6W/Qv/DjCmsfJ7/IRYkiQIsBIEwmA3zflU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NA6nZe1l; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NA6nZe1l"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750763760; x=1782299760;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=/hEDWmKMpxL1TTtSTgQajlUalHKiOIbTebJglgbd3XI=;
  b=NA6nZe1lJ8d3r15Mp4qt6wxQCqr2e1+eWjeimrwgtp/c7nN4REt3r+WC
   xbfpWdgwR9dsU8hQHa3j/wpw/oT+ZlquZBrxobCrRHJX+8yih3VMdIx0C
   VSnUMGpE4e2ijDxQ1BdbbNexzQkDZFc4bRld5/GGdQnCksW3hPqrzmC8r
   c6TJbb/NV9+zbVgss7+x4FUXDBKoXOr4KzeeCK0FXuSwx0KYrAJb/E6u/
   LShHF2gM0iZv5+qkc655ghJiWk8tB4rOh2ypMixwUBiGMv9RP5MyF5MdT
   5JeFEkud7o/9+Is412tVaBCPyeszmIeMZXzmagyCDDyHQYTp/VtaBqy3i
   w==;
X-CSE-ConnectionGUID: hdEsl2LtS0Kz6vn6iByfrw==
X-CSE-MsgGUID: mS9aQ9P8R16PjtmYYRC+hg==
X-IronPort-AV: E=McAfee;i="6800,10657,11473"; a="52967793"
X-IronPort-AV: E=Sophos;i="6.16,261,1744095600"; 
   d="scan'208";a="52967793"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2025 04:15:59 -0700
X-CSE-ConnectionGUID: U0BrDhxySZmm8dQeB5z3Dw==
X-CSE-MsgGUID: N8ZIb1TNRJ2NIjz8hwJa+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,261,1744095600"; 
   d="scan'208";a="182769515"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.16])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2025 04:15:57 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 24 Jun 2025 14:15:53 +0300 (EEST)
To: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    linux-serial <linux-serial@vger.kernel.org>, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/5] serial: 8250: rename lsr_TEMT, iir_NOINT to
 lowercase
In-Reply-To: <20250624080641.509959-4-jirislaby@kernel.org>
Message-ID: <d56d8017-71f3-3cd5-4190-7515531695f3@linux.intel.com>
References: <20250624080641.509959-1-jirislaby@kernel.org> <20250624080641.509959-4-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-96334279-1750763753=:943"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-96334279-1750763753=:943
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 24 Jun 2025, Jiri Slaby (SUSE) wrote:

> There are already variables like 'iir_noint1' and 'iir_noint2'. Follow
> the preexisting lowercase naming of variables. So s/lsr_TEMT/lsr_temt/
> and 'iir_NOINT' likewise.
>=20
> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
> Suggested-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> ---
>  drivers/tty/serial/8250/8250_port.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/825=
0/8250_port.c
> index 5bb0ca04da55..7eddcab318b4 100644
> --- a/drivers/tty/serial/8250/8250_port.c
> +++ b/drivers/tty/serial/8250/8250_port.c
> @@ -2233,15 +2233,15 @@ static void serial8250_init_mctrl(struct uart_por=
t *port)
>  static void serial8250_iir_txen_test(struct uart_port *port)
>  {
>  =09struct uart_8250_port *up =3D up_to_u8250p(port);
> -=09bool lsr_TEMT, iir_NOINT;
> +=09bool lsr_temt, iir_noint;
> =20
>  =09if (port->quirks & UPQ_NO_TXEN_TEST)
>  =09=09return;
> =20
>  =09/* Do a quick test to see if we receive an interrupt when we enable t=
he TX irq. */
>  =09serial_port_out(port, UART_IER, UART_IER_THRI);
> -=09lsr_TEMT =3D serial_port_in(port, UART_LSR) & UART_LSR_TEMT;
> -=09iir_NOINT =3D serial_port_in(port, UART_IIR) & UART_IIR_NO_INT;
> +=09lsr_temt =3D serial_port_in(port, UART_LSR) & UART_LSR_TEMT;
> +=09iir_noint =3D serial_port_in(port, UART_IIR) & UART_IIR_NO_INT;
>  =09serial_port_out(port, UART_IER, 0);
> =20
>  =09/*
> @@ -2253,7 +2253,7 @@ static void serial8250_iir_txen_test(struct uart_po=
rt *port)
>  =09 * variable. So, in case of UPQ_NO_TXEN_TEST, let's just don't test i=
f we receive TX irq.
>  =09 * This way, we'll never enable UART_BUG_TXEN.
>  =09 */
> -=09if (lsr_TEMT && iir_NOINT) {
> +=09if (lsr_temt && iir_noint) {
>  =09=09if (!(up->bugs & UART_BUG_TXEN)) {
>  =09=09=09up->bugs |=3D UART_BUG_TXEN;
>  =09=09=09dev_dbg(port->dev, "enabling bad tx status workarounds\n");
>=20

Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.

--8323328-96334279-1750763753=:943--
