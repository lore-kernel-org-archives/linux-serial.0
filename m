Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2252C26773C;
	Wed, 11 Jun 2025 13:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749647091; cv=none; b=i0pRch1FrBX92XgFsukYk10VlxLS6qscT7avCsei0DQJ/PjiEWoB5tUrkmZD9osnP8ciYe7agCo30hIm8ZH+FGShK53tioaGhsIr4ilULkpgTKS9npwwxBsHZV32m3VhtUnBXptfM6wtBVU4ZfUG8tymjQUjuN4yeCOAy4L+Kl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749647091; c=relaxed/simple;
	bh=82zrhyiCmDtGIG28EYQvCnCYmuCIw8+lKn8GLqiHvI8=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=cgLIPCyp/6Q/PT5NuEGeidufxupUMeIaD3m9YBIw3+TRoNvxsRY/VSF1pIB4+Do2rQ6IFyErpyYAszQ9+miZCHjkrv77eYtG7DZylUzSQ36HWXdrQt6J9jsfkGVjJtUFw0dTA2S2N5sY4DzWgIjT4jSkFbkKdvvmB7ie+tLHWY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aC3m+ipf; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aC3m+ipf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749647090; x=1781183090;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=82zrhyiCmDtGIG28EYQvCnCYmuCIw8+lKn8GLqiHvI8=;
  b=aC3m+ipfLsqeghbzmXaa1XyVoKU/kC/iKIYA7/gx4M3HGG9KIaMoXlOk
   TMewgpVQGXwSDCbkJ8VT8dvSOs7GXTvd1Bn6iHUlKr88hSr9qiOuCt9nu
   XOsugX84/1E5zENHalRy6XcDs3gIr8O6yYuAHU5XzFHQtZ/TBhIaOylj5
   hSdUD1fgCGpPDCqzjUR5XLQ9PCcLwzquuhirZt2P5KSlpTM70jloJ2nup
   lbWOp2A1/BxxAUxzoLquQyo32BwhyT2kbZu0L/8ffYyt/6Hd1BnAd9v0h
   exGlWnMyQoz9mO8lfzoHVGOCIwEEvlt1d8ZbzH6Ih6Ti8uoTbeXRavR+Q
   w==;
X-CSE-ConnectionGUID: RYHf/JCaSlKW0QQFMfXpUw==
X-CSE-MsgGUID: 5I0gRxV/SuaDbgV6XavPnw==
X-IronPort-AV: E=McAfee;i="6800,10657,11461"; a="51668969"
X-IronPort-AV: E=Sophos;i="6.16,227,1744095600"; 
   d="scan'208";a="51668969"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2025 06:04:49 -0700
X-CSE-ConnectionGUID: YHzyThYZQFWLP1fIZbrFTg==
X-CSE-MsgGUID: d2JBEAi4SLSTVFJ+ixWTCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,227,1744095600"; 
   d="scan'208";a="147686406"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.183])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2025 06:04:47 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 11 Jun 2025 16:04:43 +0300 (EEST)
To: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
cc: gregkh@linuxfoundation.org, linux-serial@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH 26/33] serial: 8250: drop unused frac from
 serial8250_do_get_divisor()
In-Reply-To: <20250611100319.186924-27-jirislaby@kernel.org>
Message-ID: <7307957d-a1a1-6429-93c2-9440de760673@linux.intel.com>
References: <20250611100319.186924-1-jirislaby@kernel.org> <20250611100319.186924-27-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-465504706-1749647083=:957"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-465504706-1749647083=:957
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 11 Jun 2025, Jiri Slaby (SUSE) wrote:

> 'frac' is not used in the generic implementation of get_divisor. Drop it
> from there. (Only some port->get_divisor() compute that and receive it
> then to port->set_divisor()).
>=20
> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
> ---
>  drivers/tty/serial/8250/8250_port.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/825=
0/8250_port.c
> index 2af89038e50e..6363915a1787 100644
> --- a/drivers/tty/serial/8250/8250_port.c
> +++ b/drivers/tty/serial/8250/8250_port.c
> @@ -2481,9 +2481,7 @@ static void serial8250_flush_buffer(struct uart_por=
t *port)
>  =09=09serial8250_tx_dma_flush(up);
>  }
> =20
> -static unsigned int serial8250_do_get_divisor(struct uart_port *port,
> -=09=09=09=09=09      unsigned int baud,
> -=09=09=09=09=09      unsigned int *frac)
> +static unsigned int serial8250_do_get_divisor(struct uart_port *port, un=
signed int baud)
>  {
>  =09upf_t magic_multiplier =3D port->flags & UPF_MAGIC_MULTIPLIER;
>  =09struct uart_8250_port *up =3D up_to_u8250p(port);
> @@ -2544,7 +2542,7 @@ static unsigned int serial8250_get_divisor(struct u=
art_port *port,
>  =09if (port->get_divisor)
>  =09=09return port->get_divisor(port, baud, frac);
> =20
> -=09return serial8250_do_get_divisor(port, baud, frac);
> +=09return serial8250_do_get_divisor(port, baud);
>  }
> =20
>  static unsigned char serial8250_compute_lcr(struct uart_8250_port *up, t=
cflag_t c_cflag)
>=20

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.

--8323328-465504706-1749647083=:957--
