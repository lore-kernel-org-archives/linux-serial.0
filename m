Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF1B2E6123;
	Wed, 11 Jun 2025 12:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749645263; cv=none; b=G2CvGEkYS6vji7+kirfuVavqal/nADHMG8RGqxXZ12cJX2IUY9tHLihMS03wnNsvGgkbFagYqDqvg5AYXaxTg8iMUi9fkZ6JeQd0+rSxI7PGLbiPdOgRRU1qTKwB8pHQxgz9Qec8jAvABb2jGMleyxfEvCfArXGhN06/eCy1TkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749645263; c=relaxed/simple;
	bh=5CpQlymwoVo/zvpPHUBW84N3kwvYl9lZZFpAyTCuztE=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=f0Y0nR2M71CVSCG0TPkCXkJ9WNIPUzuk4aVqLF5jooDEdVe61RENZ8Z2k1Yy7S7fdL/JCqNFY04BSLSulSE3NxDOCNgY+Vev/7vLc/fEYtuHF3hrnme7fy+BhRNgjPrLSBMnxe6yGsP5FjT7YdPlMekui9TruOTIRZHTkxEFbqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ug0IxoWw; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ug0IxoWw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749645262; x=1781181262;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=5CpQlymwoVo/zvpPHUBW84N3kwvYl9lZZFpAyTCuztE=;
  b=Ug0IxoWw3ImM9TPK72/eELM8gXzzhtxS8mueKyHP251O73zg5n1GmCYW
   8xPYXNvTUyH9u7JmB2xvhWgUh0wafXiOATb5dK+nbPlrI7AAnt/511LPq
   saHKapRRrAgUxUBdzxtArPXx7wAjHYbNdzNJbzu1LPTRIGZN/zzwLJTEg
   +wofBaLohBKi3YtNQmxTjbjTU2pL2Vp26awBdf1WCjoGBsOwRD5OfexVG
   zVaJ+522ON4cSlSJxZj0vHwKViTdW3koq5u+c6qHu3gTqWPHQioJZQDRs
   2opa/F+6aUBPbk9/Sgfq8Ijti3Kul5G49NJ5V0CpVUGq5S9VVXe2z56Ss
   A==;
X-CSE-ConnectionGUID: HKXalC+bTX+ZmZCIeGvvbw==
X-CSE-MsgGUID: 44Duw6N/QVOiVDghp28imQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11461"; a="51934164"
X-IronPort-AV: E=Sophos;i="6.16,227,1744095600"; 
   d="scan'208";a="51934164"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2025 05:34:21 -0700
X-CSE-ConnectionGUID: 012BdzAPTsyMikQqkuiN9w==
X-CSE-MsgGUID: qFYcyz6PQB6c20OYCSDQ1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,227,1744095600"; 
   d="scan'208";a="147676672"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.183])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2025 05:34:20 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 11 Jun 2025 15:34:15 +0300 (EEST)
To: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    linux-serial <linux-serial@vger.kernel.org>, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 19/33] serial: 8250: extract
 serial8250_set_trigger_for_slow_speed()
In-Reply-To: <20250611100319.186924-20-jirislaby@kernel.org>
Message-ID: <ac284b63-2232-639d-b94d-2116cc680173@linux.intel.com>
References: <20250611100319.186924-1-jirislaby@kernel.org> <20250611100319.186924-20-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-40714149-1749645255=:957"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-40714149-1749645255=:957
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 11 Jun 2025, Jiri Slaby (SUSE) wrote:

> serial8250_do_set_termios() consists of many registers and up flags
> settings. Extract all these into separate functions. This time, setting
> of trigger level for slow speeds.
>=20
> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
> ---
>  drivers/tty/serial/8250/8250_port.c | 26 +++++++++++++++++++-------
>  1 file changed, 19 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/825=
0/8250_port.c
> index edfbaa6b7a1b..52385314c426 100644
> --- a/drivers/tty/serial/8250/8250_port.c
> +++ b/drivers/tty/serial/8250/8250_port.c
> @@ -2686,6 +2686,24 @@ static void serial8250_set_mini(struct uart_port *=
port, struct ktermios *termios
>  =09}
>  }
> =20
> +static void serial8250_set_trigger_for_slow_speed(struct uart_port *port=
, struct ktermios *termios,
> +=09=09=09=09=09=09  unsigned int baud)
> +{
> +=09struct uart_8250_port *up =3D up_to_u8250p(port);
> +
> +=09if (!(up->capabilities & UART_CAP_FIFO))
> +=09=09return;
> +=09if (port->fifosize <=3D 1)
> +=09=09return;
> +=09if (baud >=3D 2400)
> +=09=09return;
> +=09if (up->dma)

Nit, I'd have put the DMA check before the speed check.

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

> +=09=09return;
> +
> +=09up->fcr &=3D ~UART_FCR_TRIGGER_MASK;
> +=09up->fcr |=3D UART_FCR_TRIGGER_1;
> +}
> +
>  void
>  serial8250_do_set_termios(struct uart_port *port, struct ktermios *termi=
os,
>  =09=09          const struct ktermios *old)
> @@ -2710,13 +2728,7 @@ serial8250_do_set_termios(struct uart_port *port, =
struct ktermios *termios,
>  =09uart_port_lock_irqsave(port, &flags);
> =20
>  =09up->lcr =3D cval;=09=09=09=09=09/* Save computed LCR */
> -
> -=09if (up->capabilities & UART_CAP_FIFO && port->fifosize > 1) {
> -=09=09if (baud < 2400 && !up->dma) {
> -=09=09=09up->fcr &=3D ~UART_FCR_TRIGGER_MASK;
> -=09=09=09up->fcr |=3D UART_FCR_TRIGGER_1;
> -=09=09}
> -=09}
> +=09serial8250_set_trigger_for_slow_speed(port, termios, baud);
> =20
>  =09/*
>  =09 * MCR-based auto flow control.  When AFE is enabled, RTS will be
>=20

--=20
 i.

--8323328-40714149-1749645255=:957--
