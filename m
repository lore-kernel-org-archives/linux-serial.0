Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793102475;
	b=XapBpFzWyO6eokUX4xz1Be7UPJjp9geG0YR6/Q9zCquN1QsB1pCXUwp8A8eq4UCF5Bx0
	 c7rJiP0tO1QEhpoGbzzpcOPMKyU5Ou431zNkl32bu2VhCox0UuDOb4YFecbUxc8rjrKnv
	 Df9mVsdsD6JVjihH3C5ROK9jMs+QXCbljH2OUvvotRcQ72J1c+1KdkmBcNuifJROXc5/G
	 uPNBKdoyIL6iDfPb3dT4hhrXX74bvk630rXnGANnzWECSsahnc2vCDKvCxRfu7+ue+oIQ
	 YopE8QT8NMGXE0l4JS1G0MPCinNnpuMIwfErNId5SZYJTU/qE0tdzoCGwThfPRoQjWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793102475;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:Date:To:cc:
	 Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type;
	bh=OQYRipuP124143QCMJhvTr9qvY3O5guW1GgytysnBfc=;
	b=yMeTZeXADF1YKtEJpiIMMMghxMqY2cFeUXL1PdpmPxyErA4uJ7eX5MTLcNfGcmMaUZz0
	 uySkaVOEy6kpcZXZ7HAmqARXnElsDGDA1Myyakf3ZwVEIIRLuC8h63BAiSGKQUVLpTRys
	 conFNUW+fuSQvfOm5oeBKjcSw4yqb516X1G+aWihOZTqw77DX/xnWZO8+u6yVAkb/38vh
	 UxezIdrSfK0F/+VMj/kDpS/mj+uK18uN9+WFPYt8Zm0iIHg2fuG//VP8tSMJ/Y5NP6Lka
	 TpX4ebJ2RS1ywSShHjQT+2K3sk2O2vGROx3TnMbQ5CPE1dV8bae16+oXYsFzesP7Htw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Tj2ibMdQ;
	arc=none smtp.remote-ip=198.175.65.9
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A2E660A383D;
	Tue, 27 Oct 2026 12:01:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3A2E660A383D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Tj2ibMdQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793102474; x=1824638474;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Rxj6MiO85lPb0RtbvRVzjDkOvjkrpNou9e16H5MhBBI=;
  b=Tj2ibMdQZDVT4lZPLhjEFGEY08V6m8OVjUMZTM7GdziJdu41oGfY4ENM
   I0UW7kaclzi/+NtVNLymri04TkT0CDCGJzoeC5AVvEP4JSqrJj57GPnFw
   dvVdInvLRG+BxhiFRWj/9QWs5KlAkcDrj0RuWqzbvQWrA/fSvzhvQRsUR
   ScNQQfVtpVFrWbTHqwVYzcDkrqK9NEGhZzO999+/Xrm+DKaYrK3QwP09y
   mGIhSdwrm9qrTi7DUJ0KUm9ob/XEfx1D7urRiYIYcH7QLawZYZUonDvvm
   iSR3IWAvZubGX4qiBmSPjFyoIxQMV/cUwO/z8WLeC/pjdNRqeD5Wm5hFt
   A==;
X-CSE-ConnectionGUID: v/UhhZ0ISoy5dz9AisO04A==
X-CSE-MsgGUID: axj27Y9TTi6Yhkl0GRwZKA==
X-IronPort-AV: E=McAfee;i="6800,10657,11947"; a="1680964"
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="1680964"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 05:01:13 -0700
X-CSE-ConnectionGUID: krEz9piZSJCRMHkzXB2ukA==
X-CSE-MsgGUID: wzIAapIGT8SGweeZStrpww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="4864382"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.30])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 05:00:59 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 27 Oct 2026 14:00:55 +0200 (EET)
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
    linux-serial <linux-serial@vger.kernel.org>, stable <stable@kernel.org>, 
    John Ogness <john.ogness@linutronix.de>, 
    Fushuai Wang <wangfushuai@baidu.com>, 
    =?ISO-8859-15?Q?Uwe_Kleine-K=F6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
Subject: Re: [PATCH 07/24] serial: 8250: hold hash_mutex across irq_info
 lookup and linking
In-Reply-To: <20261027-tty-llm-v1-7-99b0202ae546@linuxfoundation.org>
Message-ID: <ee0d971b-b928-0bfd-693e-c8ddfe9c04c2@linux.intel.com>
References: <20261027-tty-llm-v1-0-99b0202ae546@linuxfoundation.org> <20261027-tty-llm-v1-7-99b0202ae546@linuxfoundation.org>
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1797829899-1793102455=:1182"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1797829899-1793102455=:1182
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 27 Oct 2026, Greg Kroah-Hartman wrote:

> From: Joshua Rogers <linux@joshua.hu>
>=20
> serial_get_or_create_irq_info() released hash_mutex before returning the
> irq_info pointer, allowing serial_unlink_irq_chain() on another CPU to
> free the irq_info before serial_link_irq_chain() could link its port,
> causing a use-after-free. Hold hash_mutex in serial_link_irq_chain() for
> its entire scope so the irq_info lifetime is protected across both
> lookup and linking.
>=20
> Cc: stable <stable@kernel.org>
> Cc: Jiri Slaby <jirislaby@kernel.org>
> Cc: John Ogness <john.ogness@linutronix.de>
> Cc: Fushuai Wang <wangfushuai@baidu.com>
> Cc: Crescent Hsieh <crescentcy.hsieh@moxa.com>
> Cc: "Uwe Kleine-K=C3=B6nig (The Capable Hub)" <u.kleine-koenig@baylibre.c=
om>
> Signed-off-by: Joshua Rogers <linux@joshua.hu>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/tty/serial/8250/8250_core.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/825=
0/8250_core.c
> index 673fde55828a..5730ef97f836 100644
> --- a/drivers/tty/serial/8250/8250_core.c
> +++ b/drivers/tty/serial/8250/8250_core.c
> @@ -131,12 +131,11 @@ static void serial_do_unlink(struct irq_info *i, st=
ruct uart_8250_port *up)
>   * - find the corresponding info in the hashtable and return it, or
>   * - allocate a new one, add it to the hashtable and return it.
>   */
> +/* Caller must hold hash_mutex */

We do have lockdep asserts to actually check these.

I also don't understand why own comment is opened for this. And it would=20
be better to follow kerneldoc's syntax by starting with Context:

>  static struct irq_info *serial_get_or_create_irq_info(const struct uart_=
8250_port *up)
>  {
>  =09struct irq_info *i;
> =20
> -=09guard(mutex)(&hash_mutex);
> -
>  =09hash_for_each_possible(irq_lists, i, node, up->port.irq)
>  =09=09if (i->irq =3D=3D up->port.irq)
>  =09=09=09return i;
> @@ -157,6 +156,8 @@ static int serial_link_irq_chain(struct uart_8250_por=
t *up)
>  =09struct irq_info *i;
>  =09int ret;
> =20
> +=09guard(mutex)(&hash_mutex);
> +
>  =09i =3D serial_get_or_create_irq_info(up);
>  =09if (IS_ERR(i))
>  =09=09return PTR_ERR(i);
>=20
>=20

--=20
 i.

--8323328-1797829899-1793102455=:1182--
