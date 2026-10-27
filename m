Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793101448;
	b=R5C3w7blxPDxmVkDfKVQul6ngkfQOrqWHwkdrePyLiboNCJd+MpBkvQXccBeOUT6g3Jf
	 MlkO22xMRzyBcS/L7R7OyjSd1WyzuPn5aeSZYcrsTutRBHYujCKnkC5Cu5U4yZgwangVH
	 6nS+OMmdLvdn8yKVbIY7q6EBXJnclUwJ5o/eezXjCChkuuz3GgrR1vmtRK+HbH1/+Shq+
	 a3tjbR+c129s4y/2sNOkj7BYveubcqPLn/knAbi2NCYHOjX2Gqrj1ONP6AM0KqOYQQhOd
	 X1FvbUyOPYWD+5P8Em6TlsB/e+CeyTuTFjNOkAuCxHHKshtuhvijfxyPhimMxecw+7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793101448;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:Date:To:cc:
	 Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type;
	bh=lpFhOWgr/P5xi5D31DTra6PALUIvcILbxzdHus08h3I=;
	b=Jv20e+rNZq5i/2kzhfhqvJtD/6PhoYz1570EBQuSKIhIsEJI/VX3qZ+XLu04S0DVyXvq
	 CQLSdagAbJDjBUzlWthXcksZtsSnVv5Jr7/u89rHqGdmn9RntUB0hsLM0iPS8r7x7F4/9
	 RFWjFOGl4QKTjXA3y0rCM04vVBbzfi9KsUq5GFvZVb604dYmplgaccs1cshRvUqcmP0vN
	 /25C0vnnlWtY6izWQCjYr2lR1uw4YGE6ysCT4RpvPBxxw9couKzbgFGMP+YegNhh983Jb
	 4JjCsYzcogBASzPBq+i+/kptEnuOaYL9Y+f1EbDaFGlmXtUIwf6f4d9IgHwkXsBthoQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=HptLxkIz;
	arc=none smtp.remote-ip=198.175.65.18
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 015EF606A334;
	Tue, 27 Oct 2026 11:44:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 015EF606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=HptLxkIz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793101447; x=1824637447;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=xfK/d2RJjV1AUxmc72J5YDT/nIqUvjzRbw+diStP0Wc=;
  b=HptLxkIzY8ExtNbvwiTOtLfU4CkBwTUmpHBTXC6lBpmp6+qtg1jcQAUg
   5p5W+SebBinJ9XkmrlFF/QQIYjJwpDN30nGRHsh/iDloC1UyuA3wsCgHb
   rr//xUsGqPZ+msQERDgwBuDCNkFt9x/0ldkuBQQzcJsjskzGU+0xHn29i
   RJfn2O07Iwr/6xakRgIGnOBSX3mWRX6GpA0bJTM+7/Z3Zo8CskX/fWD72
   0wzc//8Svs/DB/IXaRdQPJkMyWpSrIa2ZVstcAXqfDmmgwSUbm7OCMTHA
   Y2sBtFUPQEk5AMTor2XFn1D6L9GH4E88GIwe9dkKCsVvkUmZ9QUggxWkw
   w==;
X-CSE-ConnectionGUID: TeJ+p3zlTBmhkJt5ia6h5Q==
X-CSE-MsgGUID: DPJDB7fTRda/HmZ5e0pC1g==
X-IronPort-AV: E=McAfee;i="6800,10657,11947"; a="1806347"
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="1806347"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 04:44:06 -0700
X-CSE-ConnectionGUID: BPfowfSRSwyrmYKTOpN9jA==
X-CSE-MsgGUID: 9UBOc+aSSwSayXWrFHNSxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="4481106"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.30])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 04:43:53 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 27 Oct 2026 13:43:50 +0200 (EET)
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
    John Ogness <john.ogness@linutronix.de>, Petr Mladek <pmladek@suse.com>, 
    Hugo Villeneuve <hvilleneuve@dimonoff.com>
Subject: Re: [PATCH 04/24] serial: 8250: don't report a wakeup to a closed
 tty
In-Reply-To: <20261027-tty-llm-v1-4-99b0202ae546@linuxfoundation.org>
Message-ID: <9457871a-2b2d-e66e-9cd6-a5010a2ebc8d@linux.intel.com>
References: <20261027-tty-llm-v1-0-99b0202ae546@linuxfoundation.org> <20261027-tty-llm-v1-4-99b0202ae546@linuxfoundation.org>
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-381436007-1793101430=:1182"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-381436007-1793101430=:1182
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 27 Oct 2026, Greg Kroah-Hartman wrote:

> From: Josef Bacik <josef@toxicpanda.com>
>=20
> If its interrupt is a wakeup source, serial8250_handle_irq_locked()
> reports the characters which arrive as a wakeup event of
> tport->tty->dev.  That pointer is only set while the port is open.  The
> port of a console is not shut down by the last close, so its interrupt
> handler goes on running without a tty.  If the system is then woken up
> by a character on the console, the handler dereferences a NULL pointer.
>=20
> Take a reference to the tty, and leave the event out if there is none.
>=20
> Fixes: 0ba9e3a13c6a ("serial: 8250: Add missing wakeup event reporting")
> Cc: stable <stable@kernel.org>
> Cc: Jiri Slaby <jirislaby@kernel.org>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: John Ogness <john.ogness@linutronix.de>
> Cc: "Ilpo J=C3=A4rvinen" <ilpo.jarvinen@linux.intel.com>
> Cc: Petr Mladek <pmladek@suse.com>
> Cc: Crescent Hsieh <crescentcy.hsieh@moxa.com>
> Cc: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> Cc: Florian Fainelli <f.fainelli@gmail.com>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/tty/serial/8250/8250_port.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/825=
0/8250_port.c
> index 3d47f535d6f1..4afebd96e062 100644
> --- a/drivers/tty/serial/8250/8250_port.c
> +++ b/drivers/tty/serial/8250/8250_port.c
> @@ -1900,8 +1900,15 @@ void serial8250_handle_irq_locked(struct uart_port=
 *port, unsigned int iir)
>  =09=09struct irq_data *d;
> =20
>  =09=09d =3D irq_get_irq_data(port->irq);
> -=09=09if (d && irqd_is_wakeup_set(d))
> -=09=09=09pm_wakeup_event(tport->tty->dev, 0);
> +=09=09if (d && irqd_is_wakeup_set(d)) {
> +=09=09=09struct tty_struct *tty =3D tty_port_tty_get(tport);
> +
> +=09=09=09/* A console goes on receiving after the last close */
> +=09=09=09if (tty) {
> +=09=09=09=09pm_wakeup_event(tty->dev, 0);
> +=09=09=09=09tty_kref_put(tty);
> +=09=09=09}
> +=09=09}
>  =09=09if (!up->dma || handle_rx_dma(up, iir))
>  =09=09=09status =3D serial8250_rx_chars(up, status);
>  =09}

Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.

--8323328-381436007-1793101430=:1182--
