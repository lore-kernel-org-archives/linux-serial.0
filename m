Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34B01311C35
	for <linux-serial@vger.kernel.org>; Thu, 27 Nov 2025 09:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764235696; cv=none; b=l5iG4bRGsHyDPnAiq3wB3GfCWTgUxIQWJWx5mYWKhx4P2Ij9A9s1jUgNFG7aOHUSFGkkMGVMrzrEBEAhFXcfWupAIZPp7jy1nNlCkUjNC68XwkxcxzOD1ecu6R/vIziwWPqUK4jp4SQ+jstq9zbiWvGFv5EqA2GZdArk/vyzytM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764235696; c=relaxed/simple;
	bh=HTXoxDXfGGvRujojE4GihAsh+GMmR3u0ZriTuIY9eEo=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=WFIQ9mX67BvNH1ClBVWYSkmij2EPe2TkReuUjzoRQHQ/+nqcXnQl9e43MSolHIHNEw+h8HxaaMvmp5Kot7Hcgqh4C4uvDA97zRtyoAbJMfrZXur3IzWO2eHvasS/3geSspBIdmLSlQ+8hJ4p1KEqqXG1IrOPIsXuqHZuu2Nwmng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BdXygR5X; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BdXygR5X"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764235694; x=1795771694;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=HTXoxDXfGGvRujojE4GihAsh+GMmR3u0ZriTuIY9eEo=;
  b=BdXygR5XTr8CTmWbSxJ2NWrsrv0r1vEffSLOVjT+yfM+e8d7vCcEbGij
   7lf8Du+1A51QilmBCMTBsU9UYWA4DYgo+M/RHlf9Ag2iytH3Os9kYpD80
   Gwk/6ID8sFIoFbBnQWXk8ZhI0CZzXm7YpdR/JVSEELQ3uV7rfgjxAddlQ
   eXydHtdjxQqtWJUmkCW9mM2BhSDJSiYlXuiCtefQm1A+7LP2zRMDez31d
   DD9PIDIOGgGWQW2cCdef4Ww9P+kpPwQLgTQMUt5/fsPnXgcBXUVSx0uGo
   moF029NbPeeQquNmG7J6R0pq4XCmNRXmK2n2XCOC+hcllgosOFLQu9No+
   g==;
X-CSE-ConnectionGUID: zhQcUjTWTmaXgFiEbTtKyQ==
X-CSE-MsgGUID: vBx8xLqpSF+Cv3eiOOGrPQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11625"; a="76909191"
X-IronPort-AV: E=Sophos;i="6.20,230,1758610800"; 
   d="scan'208";a="76909191"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2025 01:28:14 -0800
X-CSE-ConnectionGUID: j1t8W0hbR8iojRBrXw3ekg==
X-CSE-MsgGUID: KCVZ0ZvvReOETREknfs5KQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,230,1758610800"; 
   d="scan'208";a="193285854"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.27])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2025 01:28:11 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 27 Nov 2025 11:28:07 +0200 (EET)
To: Gerhard Engleder <gerhard@engleder-embedded.com>
cc: linux-serial <linux-serial@vger.kernel.org>, 
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Jiri Slaby <jirislaby@kernel.org>, Lukas Wunner <lukas@wunner.de>, 
    Gerhard Engleder <eg@keba.com>, Daniel Gierlinger <gida@keba.com>
Subject: Re: [PATCH v4 2/2] serial: 8250: add driver for KEBA UART
In-Reply-To: <2e23bf3b-c42e-45b2-8035-e210ed566f0d@engleder-embedded.com>
Message-ID: <9abd5fcd-973d-cede-5165-591ecf6e14da@linux.intel.com>
References: <20251023151229.11774-1-gerhard@engleder-embedded.com> <20251023151229.11774-3-gerhard@engleder-embedded.com> <b7f51612-9192-998c-b0fd-18512d84c154@linux.intel.com> <2e23bf3b-c42e-45b2-8035-e210ed566f0d@engleder-embedded.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-431976794-1764235162=:8713"
Content-ID: <9c3ed528-f198-dbdb-3298-3aff3077ce0e@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-431976794-1764235162=:8713
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <c83367e6-02d5-fbdc-fda6-3793763c3912@linux.intel.com>

On Wed, 26 Nov 2025, Gerhard Engleder wrote:

> On 26.11.25 16:46, Ilpo J=E4rvinen wrote:
> > On Thu, 23 Oct 2025, Gerhard Engleder wrote:
> >=20
> > > From: Gerhard Engleder <eg@keba.com>
> > >=20
> > > The KEBA UART is found in the system FPGA of KEBA PLC devices. It is
> > > mostly 8250 compatible with extension for some UART modes.
> > >=20
> > > 3 different variants exist. The simpliest variant supports only RS-23=
2
> > > and is used for debug interfaces. The next variant supports only RS-4=
85
> > > and is used mostly for communication with KEBA panel devices. The thi=
rd
> > > variant is able to support RS-232, RS-485 and RS-422. For this varian=
t
> > > not only the mode of the UART is configured, also the physics and
> > > transceivers are switched according to the mode.
> > >=20
> > > Signed-off-by: Gerhard Engleder <eg@keba.com>
> > > Tested-by: Daniel Gierlinger <gida@keba.com>
> > > ---
> > >   drivers/tty/serial/8250/8250_keba.c | 280 +++++++++++++++++++++++++=
+++
> > >   drivers/tty/serial/8250/Kconfig     |  13 ++
> > >   drivers/tty/serial/8250/Makefile    |   1 +
> > >   3 files changed, 294 insertions(+)
> > >   create mode 100644 drivers/tty/serial/8250/8250_keba.c
> > >=20
> > > diff --git a/drivers/tty/serial/8250/8250_keba.c
> > > b/drivers/tty/serial/8250/8250_keba.c
> > > new file mode 100644
> > > index 000000000000..c05b89551b12
> > > --- /dev/null
> > > +++ b/drivers/tty/serial/8250/8250_keba.c
> > > @@ -0,0 +1,280 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/*
> > > + * Copyright (C) 2025 KEBA Industrial Automation GmbH
> > > + *
> > > + * Driver for KEBA UART FPGA IP core
> > > + */
> > > +
> > > +#include <linux/auxiliary_bus.h>
> > > +#include <linux/device.h>
> > > +#include <linux/io.h>
> > > +#include <linux/misc/keba.h>
> > > +#include <linux/module.h>
> >=20
> > + linux/serial_core.h
>=20
> Is this really necessary even with the include of 8250.h below?

Yes. Generally don't rely on indirect includes.

> > > +
> > > +#include "8250.h"
> > > +
> > > +#define KUART "kuart"
>=20
> ...
>=20
> > > +static void kuart_enhanced_mode(struct uart_8250_port *up, bool enab=
le)
> > > +{
> > > +=09u8 lcr, efr;
> > > +
> > > +=09/* backup LCR register */
> >=20
> > Save + restore is quite obvious thing. IMO, no comment is needed about =
it.
>=20
> Yes it could be ommited. The patch is already merged, so I would keep
> it. Ok?

Ah, I didn't realize this is already merged. Just leave them then, it's=20
not that big thing.

> > > +=09lcr =3D serial_in(up, UART_LCR);
> > > +
> > > +=09/* enable 650 compatible register set (EFR, ...) */
> > > +=09serial_out(up, UART_LCR, UART_LCR_CONF_MODE_B);
> > > +
> > > +=09/* enable/disable enhanced mode with indexed control registers */
> > > +=09efr =3D serial_in(up, UART_EFR);
> > > +=09if (enable)
> > > +=09=09efr |=3D UART_EFR_ECB;
> > > +=09else
> > > +=09=09efr &=3D ~UART_EFR_ECB;
> > > +=09serial_out(up, UART_EFR, efr);
> > > +
> > > +=09/* disable 650 compatible register set, restore LCR */
> > > +=09serial_out(up, UART_LCR, lcr);
> > > +}
> > > +
> > > +static void kuart_dtr_line_config(struct uart_8250_port *up, u8 dtrl=
c)
> > > +{
> > > +=09u8 acr;
> > > +
> > > +=09/* set index register to 0 to access ACR register */
> > > +=09serial_out(up, UART_SCR, UART_ACR);
> >=20
> > So the scratch register has some special use on this UART (register
> > multiplexer?), it would probably better name it with define, if that's =
the
> > case.
>=20
> This UART supports an enhanced mode, which changes the behavior of some
> registers. But the register still have their normal use with enhanced
> mode disabled. So I would keep the register name.

But this code clearly assume UART is in enhanced mode. Same number can
have different names. You could of course reuse the other define in the=20
define:

#define KUART_EMODE_INDEX_REG=09UART_SCR

> > > +=09/* set value register to 0x10 writing DTR mode (1,0) */
> > > +=09acr =3D serial_in(up, UART_LSR);
> > > +=09acr &=3D ~UART_ACR_DTRLC_MASK;
> > > +=09acr |=3D dtrlc;
> > > +=09serial_out(up, UART_LSR, acr);
> > > +}
>=20
> ...
>=20
> > > +=09/*
> > > +=09 * UART supports RS485, RS422 and RS232 with switching of physica=
l
> > > +=09 * interface
> > > +=09 */
> > > +=09uart.port.rs485_config =3D kuart_rs485_config;
> > > +=09if (kuart->flags & KUART_RS485) {
> > > +=09=09uart.port.rs485_supported.flags =3D SER_RS485_ENABLED |
> > > +=09=09=09=09=09=09  SER_RS485_RTS_ON_SEND;
> > > +=09=09uart.port.rs485.flags =3D SER_RS485_ENABLED |
> > > +=09=09=09=09=09SER_RS485_RTS_ON_SEND;
> > > +=09}
> > > +=09if (kuart->flags & KUART_USE_CAPABILITY) {
> > > +=09=09/* default mode priority is RS485 > RS422 > RS232 */
> > > +=09=09if (kuart->capability & KUART_CAPABILITY_RS422) {
> > > +=09=09=09uart.port.rs485_supported.flags |=3D SER_RS485_ENABLED |
> > > +
> > > SER_RS485_RTS_ON_SEND |
> > > +
> > > SER_RS485_MODE_RS422;
> > > +=09=09=09uart.port.rs485.flags =3D SER_RS485_ENABLED |
> > > +=09=09=09=09=09=09SER_RS485_RTS_ON_SEND |
> > > +=09=09=09=09=09=09SER_RS485_MODE_RS422;
> > > +=09=09}
> > > +=09=09if (kuart->capability & KUART_CAPABILITY_RS485) {
> > > +=09=09=09uart.port.rs485_supported.flags |=3D SER_RS485_ENABLED |
> > > +
> > > SER_RS485_RTS_ON_SEND;
> > > +=09=09=09uart.port.rs485.flags =3D SER_RS485_ENABLED |
> > > +=09=09=09=09=09=09SER_RS485_RTS_ON_SEND;
> > > +=09=09}
> > > +=09}
> >=20
> > Is it so that only one mode is supported or can that be changes using
> > kuart_rs485_config() in which case you should have all flags listed (yo=
u
> > seem to talk about priority so that sounds like all are supported)?
>=20
> Both. As written in the commit message, there are 3 variants of the
> device. 2 variants support only one mode and 1 variant supports up to
> 3 modes.
>=20
> > > +
> > > +=09retval =3D serial8250_register_8250_port(&uart);
> > > +=09if (retval < 0) {
> > > +=09=09dev_err(&auxdev->dev, "UART registration failed!\n");
> >=20
> > Missing header.
>=20
> I will check for the header.
>=20
> As this patch is already merged, I will do a follow up.
>=20
> regards, gerhard
>=20

--=20
 i.
--8323328-431976794-1764235162=:8713--
