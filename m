Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B372D219E0;
	Tue, 24 Jun 2025 11:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750763812; cv=none; b=ltHsVoXoF7E4dyux7tGM9Ta45EUjdTA3pWTCGaps8Eg5BNS4jphQMwDt9n6r7lALPqSkqJYLggu68Vat/Lt5+oIZA1koxldMR+yqzfgSa6MklyRu0nyYooueXcVe6Z+3yzD8LpkCpvcT4HeuGRjcLE9WRxh2FRgp3cypiWekePQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750763812; c=relaxed/simple;
	bh=nCl2E+s7tJFCjEFA0CnyRPYSci8gpVc2Si+6Du9JNUA=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=IEDkCqueuTmGeydkYqC0M0bw4hGYtOVQn+xA5o2SSzZN2gAoaPGSijyEAm6Y8+t6keMxxdlWsXA1of9qr+wGAqtAd850N4X10JlRhxDrM06lTJdQhnMDlgJrH1ZCTM8f/7cBO2IJwstrD2dp5mfrhd3A4ktJ3yryUtSI2Hlub8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LX53D62p; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LX53D62p"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750763810; x=1782299810;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=nCl2E+s7tJFCjEFA0CnyRPYSci8gpVc2Si+6Du9JNUA=;
  b=LX53D62pcgsyXheGVMQhQI4bmUhOT1zuPoPMH779apKrW64brtT17dF8
   tFArANSoigMRDrtitoSCdCeWYS3sRj47/cZLJZR2QWzd3oCN96i6sWwMs
   2jkjD2VJgAjRUmD0GTlcXD91/tnbPKH3dmRORX5itmvr99hK1H48ia92l
   5Oo+aGn/VR3TUBlDAwTW5v/m1bOZG8xYPxhlB7BG7/Lpxssc7MwTKkM8v
   R8cq1zmffKSBu3Bo+2W0DXEJA1tuAJIXSOLjiOtc0jIGMRkoPqEHXBwBb
   GBhAUhgfPvM9zV/Ro0jonAhXOcx5H8Ny2NUuDDG730OfPINGdqfUPcfae
   A==;
X-CSE-ConnectionGUID: xHloWSKyRNyqL0ctT6fpeQ==
X-CSE-MsgGUID: 1vHK6Vf5RhGMkCFxzyKBMA==
X-IronPort-AV: E=McAfee;i="6800,10657,11473"; a="64354642"
X-IronPort-AV: E=Sophos;i="6.16,261,1744095600"; 
   d="scan'208";a="64354642"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2025 04:16:50 -0700
X-CSE-ConnectionGUID: YlX6LPLqTAalCzkNQaoa3g==
X-CSE-MsgGUID: Ryv4M6l4QqOn7v4k8nlIXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,261,1744095600"; 
   d="scan'208";a="151313933"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.16])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2025 04:16:47 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 24 Jun 2025 14:16:43 +0300 (EEST)
To: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    linux-serial <linux-serial@vger.kernel.org>, 
    LKML <linux-kernel@vger.kernel.org>, 
    Andy Shevchenko <andy.shevchenko@gmail.com>, 
    "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Subject: Re: [PATCH v2 4/5] serial: 8250: document doubled "type == PORT_8250_CIR"
 check
In-Reply-To: <20250624080641.509959-5-jirislaby@kernel.org>
Message-ID: <a6f74299-24c9-6086-be48-8987ff567084@linux.intel.com>
References: <20250624080641.509959-1-jirislaby@kernel.org> <20250624080641.509959-5-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1129569128-1750763803=:943"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1129569128-1750763803=:943
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 24 Jun 2025, Jiri Slaby (SUSE) wrote:

> The check for "port.type =3D=3D PORT_8250_CIR" is present twice in
> serial8250_register_8250_port(). The latter was already tried to be
> dropped by 1104321a7b3b ("serial: Delete dead code for CIR serial
> ports") and then reverted by 9527b82ae3af ("Revert "serial: Delete dead
> code for CIR serial ports"").
>=20
> Document this weirdness with a reason.
>=20
> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
> Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Acked-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Cc: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
> Link: https://lore.kernel.org/all/aFcDOx1bdB34I5hS@surfacebook.localdomai=
n/
> ---
>  drivers/tty/serial/8250/8250_core.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/825=
0/8250_core.c
> index a6ecb8575da4..feb920c5b2e8 100644
> --- a/drivers/tty/serial/8250/8250_core.c
> +++ b/drivers/tty/serial/8250/8250_core.c
> @@ -717,6 +717,7 @@ int serial8250_register_8250_port(const struct uart_8=
250_port *up)
>  =09=09nr_uarts++;
>  =09}
> =20
> +=09/* Check if it is CIR already. We check this below again, see there w=
hy. */
>  =09if (uart->port.type =3D=3D PORT_8250_CIR) {
>  =09=09ret =3D -ENODEV;
>  =09=09goto unlock;
> @@ -815,6 +816,7 @@ int serial8250_register_8250_port(const struct uart_8=
250_port *up)
>  =09if (up->dl_write)
>  =09=09uart->dl_write =3D up->dl_write;
> =20
> +=09/* Check the type (again)! It might have changed by the port.type ass=
ignment above. */
>  =09if (uart->port.type !=3D PORT_8250_CIR) {
>  =09=09if (uart_console_registered(&uart->port))
>  =09=09=09pm_runtime_get_sync(uart->port.dev);
>=20

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.

--8323328-1129569128-1750763803=:943--
