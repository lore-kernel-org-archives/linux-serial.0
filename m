Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 409F11B87D9;
	Tue, 24 Jun 2025 11:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750762944; cv=none; b=FquvTN6HXOYRV+ExTFTW/0atSMsok2zUoucdBSZKUuPmUGuYeSJFFoeSuB27lvojcl5UjIFuan8DlTVbt5cZpWjPzGq04U0fhlLnmWOPYJMhFLRyrVixdH42YbjQdlFjmidXr1ZYv1wuyfsfooiWIxOY4sYuhBBlxWplLYeu+lI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750762944; c=relaxed/simple;
	bh=uIUTFdHMprKJpRb7GqF1AX4ILHX5Lv3mp3u/iKGLJTs=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=f0HgesDG1MfP5LdS2DurGrCW+rzp+b4+gpJBSCE09+Cu400OVrV4o6dEMbKBcMsDuYREwvHIX4iJad4MNDEc2Kzl2uy4brD9ktzkaLzHjdPqyFEL3LSwJo5KG69i/9NEjQc4k9ECn3+K/gHPkyIWDeotAKkMdW7JkpDxFqkMmNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W+QKwx73; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W+QKwx73"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750762943; x=1782298943;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=uIUTFdHMprKJpRb7GqF1AX4ILHX5Lv3mp3u/iKGLJTs=;
  b=W+QKwx73//fhjF/UL+rbmvfL5xIahZaMQ5MOP/FiCgIyNc6xBURu3R1i
   9HLmwGzEI/CKoOTUtmlVyc8aE83OPbiuxBqM8hkOQbTyGNuvyXE7h2o96
   IeUvB8ZD+8NFIht0+isUm/OgF++7fmENbk3Ob0wjpXWqdpgFcYWK3iV1O
   NYM4BTIw1e9ATX56fRQsojfNbhq1mnObJmnuRRiAokbPHsxvXQl0Ga8eI
   CDjruRv6shOI/2hMYWfh8YRAUcIy1PUhf33MwOCBWUgFMPENnxvKBFejJ
   Y0b/UvDy555/bjpTwpiSV1/NO82yPxderHTB62rMYfnE1U/WyzwFRSChA
   w==;
X-CSE-ConnectionGUID: WoifrOa5RN27TgaPn5vurw==
X-CSE-MsgGUID: swLSgGNZR2Cpk17eqlg2Tw==
X-IronPort-AV: E=McAfee;i="6800,10657,11473"; a="52965421"
X-IronPort-AV: E=Sophos;i="6.16,261,1744095600"; 
   d="scan'208";a="52965421"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2025 04:02:20 -0700
X-CSE-ConnectionGUID: f3S6VbB4Tk6ABs9grH6svQ==
X-CSE-MsgGUID: OJsIolJ9SvSD/DFJ32XErQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,261,1744095600"; 
   d="scan'208";a="151480967"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.16])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2025 04:02:18 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 24 Jun 2025 14:02:15 +0300 (EEST)
To: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    linux-serial <linux-serial@vger.kernel.org>, 
    LKML <linux-kernel@vger.kernel.org>, 
    Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v2 1/5] serial: 8250: extract serial8250_init_mctrl()
In-Reply-To: <20250624080641.509959-2-jirislaby@kernel.org>
Message-ID: <b78023eb-f5ab-6287-1cd7-5db76d905eed@linux.intel.com>
References: <20250624080641.509959-1-jirislaby@kernel.org> <20250624080641.509959-2-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-584487287-1750762935=:943"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-584487287-1750762935=:943
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 24 Jun 2025, Jiri Slaby (SUSE) wrote:

> After commit 795158691cc0 ("serial: 8250: extract
> serial8250_initialize()"), split serial8250_initialize() even more --
> the mctrl part of this code can be separated into
> serial8250_init_mctrl() -- done now.
>=20
> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
> Suggested-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

Heh, I didn't even realize I was suggesting this :-D but it's good=20
nonetheless.

Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

> Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
> ---
> [v2]
> * use port-> directly.
> * do not remove curly braces.
> Both rebase errors -- noticed by Andy.
> ---
>  drivers/tty/serial/8250/8250_port.c | 21 +++++++++++++--------
>  1 file changed, 13 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/825=
0/8250_port.c
> index 48c30e158cb8..0f85a2f292fc 100644
> --- a/drivers/tty/serial/8250/8250_port.c
> +++ b/drivers/tty/serial/8250/8250_port.c
> @@ -2216,15 +2216,8 @@ static void serial8250_THRE_test(struct uart_port =
*port)
>  =09=09up->bugs |=3D UART_BUG_THRE;
>  }
> =20
> -static void serial8250_initialize(struct uart_port *port)
> +static void serial8250_init_mctrl(struct uart_port *port)
>  {
> -=09struct uart_8250_port *up =3D up_to_u8250p(port);
> -=09unsigned long flags;
> -=09bool lsr_TEMT, iir_NOINT;
> -
> -=09serial_port_out(port, UART_LCR, UART_LCR_WLEN8);
> -
> -=09uart_port_lock_irqsave(port, &flags);
>  =09if (port->flags & UPF_FOURPORT) {
>  =09=09if (!port->irq)
>  =09=09=09port->mctrl |=3D TIOCM_OUT1;
> @@ -2235,6 +2228,18 @@ static void serial8250_initialize(struct uart_port=
 *port)
>  =09}
> =20
>  =09serial8250_set_mctrl(port, port->mctrl);
> +}
> +
> +static void serial8250_initialize(struct uart_port *port)
> +{
> +=09struct uart_8250_port *up =3D up_to_u8250p(port);
> +=09unsigned long flags;
> +=09bool lsr_TEMT, iir_NOINT;
> +
> +=09serial_port_out(port, UART_LCR, UART_LCR_WLEN8);
> +
> +=09uart_port_lock_irqsave(port, &flags);
> +=09serial8250_init_mctrl(port);
> =20
>  =09/*
>  =09 * Serial over Lan (SoL) hack:
>=20

--=20
 i.

--8323328-584487287-1750762935=:943--
