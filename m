Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDACD288C22;
	Wed, 28 Jan 2026 15:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769612983; cv=none; b=h1zJeCk0JnJcp2qinE4mzaRMC3lYYt43KVK3eGR4L6hsoGQUfF22niYmj+wDA+AiuBJd9fqEAemfu3dPV3rzJdlzaVppuSRV65EqogNXiOHsw8HosIXpEHp7xY0S8R+6p7KCD7lX7U5QfEyQ32rKufOcTDHYBDuYo22NV6x6ZK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769612983; c=relaxed/simple;
	bh=99TIhnyP8asXVXQLWDoMJXHTaNSbjKcuxYcrZ1UWSTQ=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ujAFXQU//BBc+tBdO99t0W4uwy8VVDoWdm2amYC3e1Nph1wtFqb07VCtJ5nDRsuXWHuTMnSjKAXrgRO9eV2vOC4nUTtcGlfIFuW2KC5XCR5tZs5xvzbcymAioFvHmYJm6cvfonCC2cC6bymBfhmalwceQIXhxhfokdOLhmzfBKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GF4500mB; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GF4500mB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769612982; x=1801148982;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=99TIhnyP8asXVXQLWDoMJXHTaNSbjKcuxYcrZ1UWSTQ=;
  b=GF4500mBNgC8O1PfTlZh/qFaAJBf6KW4W48UP5iPgOlmKHw/o/43dbf0
   sXuKfc7fyVMdLJ1AAXU+ttP08B7XrLzH99/5Xbf0IPt0DwwVXeTh3uYcH
   MhaJcnnv0vtcp8xcSok98ornvPxkUt6KXMtlxL7iZIryKPG65Qh1EjgOz
   ZcoBaecR4CKuwh+nBMg/iHfAP6NFmuDkiD+Z6PVdWEbb1mPCV/OLhfB1u
   vysZ19M5PRB61ipubcaw/NULJ6sOEzp85htmMb7+kew5F6ZU/Vj3oSU23
   7slkV7rY7kf0G5rSGB7/zATo9sQ+pBCpFSv7+zwNNVc0betieTm4P8Hn9
   g==;
X-CSE-ConnectionGUID: mxzwWZSYSt+84L7dUmC3Ng==
X-CSE-MsgGUID: U8iWDZpUR6a5avXUSvHjVQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11685"; a="88400964"
X-IronPort-AV: E=Sophos;i="6.21,258,1763452800"; 
   d="scan'208";a="88400964"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2026 07:09:37 -0800
X-CSE-ConnectionGUID: g/dB/hdrSuqXkEMMabKD+A==
X-CSE-MsgGUID: BLJEv0gHTfyf1dTM9DXGAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,258,1763452800"; 
   d="scan'208";a="212849657"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.14])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2026 07:09:35 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 28 Jan 2026 17:09:31 +0200 (EET)
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    "Jiri Slaby (SUSE)" <jirislaby@kernel.org>, 
    LKML <linux-kernel@vger.kernel.org>, 
    linux-serial <linux-serial@vger.kernel.org>
Subject: Re: [PATCH v1 1/1] serial: 8250_port: Drop duplicate NULL check
In-Reply-To: <20260128142726.128175-1-andriy.shevchenko@linux.intel.com>
Message-ID: <c2f50f9e-fc4c-dc6f-8bc7-8cc758c741dc@linux.intel.com>
References: <20260128142726.128175-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1297348080-1769612971=:1017"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1297348080-1769612971=:1017
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 28 Jan 2026, Andy Shevchenko wrote:

> serial8250_release_dma() is NULL-aware, no need to check this in the call=
er.
> While at it, make sure DMA won't be used again, by NULLifying the pointer=
=2E
>=20
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/tty/serial/8250/8250_port.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/825=
0/8250_port.c
> index 21fdf84f118f..c40d750d5a4b 100644
> --- a/drivers/tty/serial/8250/8250_port.c
> +++ b/drivers/tty/serial/8250/8250_port.c
> @@ -2366,8 +2366,8 @@ void serial8250_do_shutdown(struct uart_port *port)
> =20
>  =09synchronize_irq(port->irq);
> =20
> -=09if (up->dma)
> -=09=09serial8250_release_dma(up);
> +=09serial8250_release_dma(up);
> +=09up->dma =3D NULL;
> =20
>  =09scoped_guard(uart_port_lock_irqsave, port) {
>  =09=09if (port->flags & UPF_FOURPORT) {
>=20

Seems reasonable safeguard,

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>


--=20
 i.

--8323328-1297348080-1769612971=:1017--
