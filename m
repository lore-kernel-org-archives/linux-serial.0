Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5982BA41;
	Fri,  9 Aug 2024 09:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723195170; cv=none; b=OzY9GvorzF2TmbAY8BVH4UXLH4IzbccSVZRaVaoqeHbNSRig9CRviXC/JkWRvY4/AcXmyEaXQWFVa2TkKDbxqGT7oNOp8ltunP0mYrKg2gGkvzJl6TmT30NTmVAuyAyenKB8u4zs57ImJazWIUrTUDSdGyD+bKMqxFfOLOWgIow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723195170; c=relaxed/simple;
	bh=sUsO4fKiqSiBVaZ+TYIJBDRCCTtp09Sd/uJiufQVOi0=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=mbMpVfFE6sgyNVrBBwYIgPSga+0E/sHZ3zHDd6Igx8yCBa5KiVs0bdkILJ/oDEALxBfXn5G/naU/tvT0Kxei0Gx12S134uiFkr3lRUpHU4YJjWvLW79GgicnZXbG/ixX9Kdh6J3ocnmLZFxNXBSC5/CVBx5WLBN4IliZ3lPPuJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Nx4XNTg9; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Nx4XNTg9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723195169; x=1754731169;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=sUsO4fKiqSiBVaZ+TYIJBDRCCTtp09Sd/uJiufQVOi0=;
  b=Nx4XNTg9tD5lKZv6Fw5QeteIjD4ZR+daDe43shi3xeK4eTiW863T9SWn
   U8qNzOix0SHvZHrIUehXTYpXPj3x1rHdvnrHcjnAyc6J20fpmqXAr2LX+
   NmKglNaJocrFzTOYeHbJanJjB7TYi7k9VuEViluB/aHLveUaQfaniqYJs
   b3aTH6yq4jjed7X/8rdQsKmpmZxyuvFO8mucKt9zW2SG6koKcdkiPD3F5
   HAKiigwVariwI4LznhucwkQ3oxPtUuv0uni4zLbpLACFjlyrtjqnwriqD
   PdqxzYau5Hznv8XNnKQTrn2wJ9gkwpKrbZtD6SWnyu94tUTiMxti8GGj/
   Q==;
X-CSE-ConnectionGUID: rK67eKHESLSFOZT67AhN3g==
X-CSE-MsgGUID: ycjlhFRUQxSHhiZ4RH9mpg==
X-IronPort-AV: E=McAfee;i="6700,10204,11158"; a="38813415"
X-IronPort-AV: E=Sophos;i="6.09,275,1716274800"; 
   d="scan'208";a="38813415"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2024 02:19:28 -0700
X-CSE-ConnectionGUID: DkXxQpMMR1+lvafwMBmBuA==
X-CSE-MsgGUID: fWK0ENh4TT2qZsgrWa01Rw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,275,1716274800"; 
   d="scan'208";a="57160206"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.245.119])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2024 02:19:25 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 9 Aug 2024 12:19:21 +0300 (EEST)
To: Arnd Bergmann <arnd@kernel.org>
cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Jiri Slaby <jirislaby@kernel.org>, Sunil V L <sunilvl@ventanamicro.com>, 
    Arnd Bergmann <arnd@arndb.de>, 
    Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
    LKML <linux-kernel@vger.kernel.org>, 
    linux-serial <linux-serial@vger.kernel.org>
Subject: Re: [PATCH 2/2] serial: 8250_platform: fix uart_8250_port
 initializer
In-Reply-To: <20240807075751.2206508-2-arnd@kernel.org>
Message-ID: <fc9934a5-e770-ac07-e68a-b6528ad19aec@linux.intel.com>
References: <20240807075751.2206508-1-arnd@kernel.org> <20240807075751.2206508-2-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-353041224-1723195161=:1401"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-353041224-1723195161=:1401
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 7 Aug 2024, Arnd Bergmann wrote:

> From: Arnd Bergmann <arnd@arndb.de>
>=20
> The first element in uart_8250_port is a structure, so initializing
> it to 0 causes a warning on newer compilers:
>=20
> drivers/tty/serial/8250/8250_platform.c: In function 'serial8250_platform=
_probe':
> drivers/tty/serial/8250/8250_platform.c:111:40: error: excess elements in=
 struct initializer [-Werror]
>   111 |         struct uart_8250_port uart =3D { 0 };
>=20
> Use the modern empty {} initializer instead that works on all
> supported compilers.
>=20
> Fixes: d9e5a0ce2f16 ("serial: 8250_platform: Enable generic 16550A platfo=
rm devices")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/tty/serial/8250/8250_platform.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/tty/serial/8250/8250_platform.c b/drivers/tty/serial=
/8250/8250_platform.c
> index c9ef988d58b3..2a3765334843 100644
> --- a/drivers/tty/serial/8250/8250_platform.c
> +++ b/drivers/tty/serial/8250/8250_platform.c
> @@ -108,7 +108,7 @@ void __init serial8250_isa_init_ports(void)
>  static int serial8250_platform_probe(struct platform_device *pdev)
>  {
>  =09struct device *dev =3D &pdev->dev;
> -=09struct uart_8250_port uart =3D { 0 };
> +=09struct uart_8250_port uart =3D { };
>  =09struct resource *regs;
>  =09unsigned char iotype;
>  =09int ret, line;
>=20

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>


--=20
 i.

--8323328-353041224-1723195161=:1401--
