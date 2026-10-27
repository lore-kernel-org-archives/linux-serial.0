Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793103357;
	b=hyW3+SlBYDUJSQ04j1AtOUnXHL6pGPCMqvkHJOp1XW1QqkxxLx9xZvvYbX8YR6u8Z1ze
	 tkBM5LsfqhUrWCUfswM3de9rK6er+nb/TeBz4BHtq2aSZWGTzy5aOY8YgWLpMBifqXoLY
	 NTzjeaP5bKgpy3xlPgNTtCQFPRwRnesTJKfqm3BYwshy6+dNBmsIvAHkrScYU+AsUiBD3
	 JLKVsOD9CsegFAHE+f33C/BpFLG2+5AeSm/Vo6l2teSaTWXiH3qOAHZlnABiIcMw8bJL4
	 XGSqojg0RqwXGAmJLHxp7+xYosgxhwrAAeDL9Uit1mPrlyUiqRUQYyybjzvIeLrKorw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793103357;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:Date:To:cc:
	 Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type;
	bh=Pnak3QWc69sHbb1RFnYL6nPtU2FfGUcZ+N6D+Ko4R2g=;
	b=WPhv4THvO2vcACmKqaxJWPuaz1EtGy26qLZjNSjiTSJUk41iVFG7pU1bqK7f9nqwIdNM
	 FlqzsDQbAEw7miJcjw1iIiLnOgsUK+eVKVU0LrpT0lApSv6Txurjv5fi7kkccMOlK0yG7
	 1ZF+xc2RPt0H+dcAfy57qkv/cZ2yOfjZDGyRCGfPZpYtdD1APg/89AJrlGEQeJP3mrJEf
	 4YHXM16U9fmtrpHC/MTGjBCTWGZnJl27JyOanNPdb8xFui8hQBuldVlqUcNpb4cEK7hoq
	 lCnCPX5uCyNolSb6ctb7LuSfS76a4IKuaK/Eh2iEw0aMOKqkgfuZ8U3MJE6INxggaGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="czjgwO/T";
	arc=none smtp.remote-ip=192.198.163.9
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE8DB606A33C;
	Tue, 27 Oct 2026 12:15:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CE8DB606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=czjgwO/T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793103357; x=1824639357;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=umEMZhPNW/nvWTV4Mp6l1nCZiSq30mJ9elF0cO8f6OY=;
  b=czjgwO/TqGFD0VYR0Yccr3CE1tMTorjPygK6wBzrriKBcHSPyO262hJz
   YKDURPX3+wARpZ64D2IEOZjrU2dKIBl9QKq0aJucHGSfym4VyficdG9Rz
   UvVoUoYMBJrA8iXQQgjwVDd3qlwApFLsdSVn/sNb6mCkytORF+tWWDHUF
   6yAPaZXw6kPnYAFYyY8YLCHNdAqmQd13qGw3ZA/luD3rZKRFbIHjrA86z
   y0089h49hnzPZ85gqHGXLhUX9w/9yM8U5iEBd72YCSKvOfLs7H0YN4JAO
   KJXR18UiVi34GN7RntlYHDNDeF9OKXDtQq+krcdnfVic61S4L9pz/aFAC
   g==;
X-CSE-ConnectionGUID: n6n9b2iLS7SvoRmHStrLtg==
X-CSE-MsgGUID: 3a75NAa6RuaWzgIbihvARg==
X-IronPort-AV: E=McAfee;i="6800,10657,11947"; a="1685099"
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="1685099"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 05:15:56 -0700
X-CSE-ConnectionGUID: WZEplk97SZ2fbNzvHjSKcg==
X-CSE-MsgGUID: hvs/KOd3TPupfiEZirN7Kg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="4911572"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.30])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 05:15:42 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 27 Oct 2026 14:15:38 +0200 (EET)
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
cc: Jiri Slaby <jirislaby@kernel.org>, Joshua Rogers <linux@joshua.hu>, 
    Chris Mason <mason@kernel.org>, Josef Bacik <josef@toxicpanda.com>, 
    Tony Lindgren <tony@atomide.com>, Rafael Gago Castano <rgc@hms.se>, 
    Florian Fainelli <f.fainelli@gmail.com>, 
    Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
    Peter Hurley <peter@hurleysoftware.com>, 
    Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
    Crescent Hsieh <crescentcy.hsieh@moxa.com>, Frank Li <Frank.Li@nxp.com>, 
    Sherry Sun <sherry.sun@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>, 
    Pengutronix Kernel Team <kernel@pengutronix.de>, 
    Fabio Estevam <festevam@gmail.com>, 
    Manivannan Sadhasivam <mani@kernel.org>, Olof Johansson <olof@lixom.net>, 
    =?ISO-8859-15?Q?Andreas_F=E4rber?= <afaerber@suse.de>, 
    Arnd Bergmann <arnd@arndb.de>, Krzysztof Kozlowski <krzk@kernel.org>, 
    Peter Griffin <peter.griffin@linaro.org>, 
    Alim Akhtar <alim.akhtar@samsung.com>, 
    Robert Baldyga <r.baldyga@samsung.com>, 
    Thomas Abraham <thomas.abraham@linaro.org>, 
    Kukjin Kim <kgene.kim@samsung.com>, 
    Patrice Chotard <patrice.chotard@foss.st.com>, 
    Srinivas Kandagatla <srini@kernel.org>, 
    Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
    Alexandre Torgue <alexandre.torgue@foss.st.com>, 
    Andy Shevchenko <andy.shevchenko@gmail.com>, 
    Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>, 
    Al Cooper <alcooperx@gmail.com>, LKML <linux-kernel@vger.kernel.org>, 
    linux-serial <linux-serial@vger.kernel.org>, 
    John Ogness <john.ogness@linutronix.de>, 
    Fushuai Wang <wangfushuai@baidu.com>, 
    =?ISO-8859-15?Q?Uwe_Kleine-K=F6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>, 
    Moteen Shah <m-shah@ti.com>, Kendall Willis <k-willis@ti.com>, 
    Hugo Villeneuve <hvilleneuve@dimonoff.com>, stable <stable@kernel.org>
Subject: Re: [PATCH 08/24] serial: 8250: cancel overrun backoff work on port
 shutdown and unregister
In-Reply-To: <20261027-tty-llm-v1-8-99b0202ae546@linuxfoundation.org>
Message-ID: <5a56a9f6-5a6b-c69c-7617-ee5a3d08da7a@linux.intel.com>
References: <20261027-tty-llm-v1-0-99b0202ae546@linuxfoundation.org> <20261027-tty-llm-v1-8-99b0202ae546@linuxfoundation.org>
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1412818898-1793103338=:1182"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1412818898-1793103338=:1182
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 27 Oct 2026, Greg Kroah-Hartman wrote:

> From: Joshua Rogers <linux@joshua.hu>
>=20
> The overrun_backoff delayed work can be scheduled from IRQ handlers in
> 8250_fsl.c and 8250_omap.c via schedule_delayed_work(). However, this
> work is never canceled in the shutdown or unregister paths, so it can
> fire after the port has been torn down, causing stale hardware access or
> use-after-free.
>=20
> The existing synchronize_irq() calls in the shutdown path only
> synchronize with the IRQ handler itself, not with workqueue callbacks
> that the handler has already enqueued. Add cancel_delayed_work_sync()
> after the IRQ is quiesced in serial8250_do_shutdown() (the generic
> shutdown path used by FSL and others), omap_8250_shutdown() (the
> OMAP-specific shutdown path), and serial8250_unregister_port() (the
> module unload / hot-unplug path).
>=20
> Cc: Jiri Slaby <jirislaby@kernel.org>
> Cc: John Ogness <john.ogness@linutronix.de>
> Cc: Joshua Rogers <linux@joshua.hu>
> Cc: Fushuai Wang <wangfushuai@baidu.com>
> Cc: Crescent Hsieh <crescentcy.hsieh@moxa.com>
> Cc: "Uwe Kleine-K=C3=B6nig (The Capable Hub)" <u.kleine-koenig@baylibre.c=
om>
> Cc: Moteen Shah <m-shah@ti.com>
> Cc: Kendall Willis <k-willis@ti.com>
> Cc: Frank Li <Frank.Li@nxp.com>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: "Ilpo J=C3=A4rvinen" <ilpo.jarvinen@linux.intel.com>
> Cc: Josef Bacik <josef@toxicpanda.com>
> Cc: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> Cc: stable <stable@kernel.org>
> Signed-off-by: Joshua Rogers <linux@joshua.hu>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/tty/serial/8250/8250_core.c | 3 +++
>  drivers/tty/serial/8250/8250_omap.c | 3 +++
>  drivers/tty/serial/8250/8250_port.c | 3 +++
>  3 files changed, 9 insertions(+)
>=20
> diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/825=
0/8250_core.c
> index 5730ef97f836..af94ed4e633e 100644
> --- a/drivers/tty/serial/8250/8250_core.c
> +++ b/drivers/tty/serial/8250/8250_core.c
> @@ -950,6 +950,9 @@ void serial8250_unregister_port(struct uart_8250_port=
 *uart)
> =20
>  =09serial8250_em485_free(uart);
> =20
> +=09if (uart->overrun_backoff_time_ms)
> +=09=09cancel_delayed_work_sync(&uart->overrun_backoff);
> +
>  =09uart_remove_one_port(&serial8250_reg, &uart->port);
>  =09if (serial8250_isa_devs) {
>  =09=09uart->port.flags &=3D ~UPF_BOOT_AUTOCONF;
> diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/825=
0/8250_omap.c
> index 29a203ed93fd..07ebed6ac6c9 100644
> --- a/drivers/tty/serial/8250/8250_omap.c
> +++ b/drivers/tty/serial/8250/8250_omap.c
> @@ -786,6 +786,9 @@ static void omap_8250_shutdown(struct uart_port *port=
)
> =20
>  =09disable_irq_nosync(port->irq);
> =20
> +=09if (up->overrun_backoff_time_ms)
> +=09=09cancel_delayed_work_sync(&up->overrun_backoff);
> +
>  =09serial8250_release_dma(up);
>  =09up->dma =3D NULL;
> =20
> diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/825=
0/8250_port.c
> index 4afebd96e062..710d2a28b918 100644
> --- a/drivers/tty/serial/8250/8250_port.c
> +++ b/drivers/tty/serial/8250/8250_port.c
> @@ -2497,6 +2497,9 @@ void serial8250_do_shutdown(struct uart_port *port)
> =20
>  =09synchronize_irq(port->irq);
> =20
> +=09if (up->overrun_backoff_time_ms)
> +=09=09cancel_delayed_work_sync(&up->overrun_backoff);

Wouldn't it be better for fsl to add own shutdown function to do this=20
there and not within the generic code?

This entire overrun_backoff machinery seems something that should be part=
=20
of the respective drivers but that's beyond the scope of this fix.

> +
>  =09if (up->dma)
>  =09=09serial8250_release_dma(up);
> =20
>=20
>=20

--=20
 i.

--8323328-1412818898-1793103338=:1182--
