Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD8EA225AF;
	Tue, 13 Aug 2024 08:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723537044; cv=none; b=EvaefYIwGNuxQbOBW7K/CbBwnkbI29mGYBWfN/CSy8ZSpItp4MUymYOHCnmBs5NUZAe3Klsu8yd8JVlVbPMPRW087xW/WmFYOcb5EZJNmMz42yS+pQS6zlbi8WhQ3n43utGYUxkvkKv6/MlugO1kEn1HO5WOXkb00xlSa4J7UQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723537044; c=relaxed/simple;
	bh=guyBHbG72uRX+1b4UcVPViM/pujMAI+UWsaf5B+yXS4=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=gPzN9I9Gh4MCzQFw4Jngmj5t7niusc3q4cZdR8m4o1aGc5V8cOvuC5r5ucVEcz4EvMHHTtFXrQnpNmpc5afzHbvNmcx6jbEjg7sRKkvlVFLODJwSIr10QkmOkW8/QmPrOHk6FHv1pXZJJHI+GXFDSZt1ArreLCD7XNrkl6nYkYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ls9mrDi0; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ls9mrDi0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723537043; x=1755073043;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=guyBHbG72uRX+1b4UcVPViM/pujMAI+UWsaf5B+yXS4=;
  b=ls9mrDi0mJCVpXZu8ps2XlfNnwIkUT9bUwa5OjgX5sA+DNaOahdhpNsi
   9PWtQNzA8hz0EFXwfukUxrA+zEL+NgajN1FGTOGbTitZ/6f6qaLasHMOV
   hAPNqAt6TYKZNSs57QhgRZbbJqZ7CTgZIFeGrZMPpkNkuwTiXD9Vv0rSe
   i7+jO/94ZcZgBP/ohyWVYuBRRr3RdEJlUvo0Sy0TFoWWBCWeyy+g1e9bd
   igndd9pfeHjeVtUU3lOWaGca3wb3t23AMrlV506Vf9NdrbJ3mjCn5T8xI
   omG1IP1bk2lorvM7U44cqOHU92Er/j1hVnayjKVWCEZQ1LMyqBMXDdhUb
   w==;
X-CSE-ConnectionGUID: 1cPDG2xURwS2LJk3dDpinA==
X-CSE-MsgGUID: 0BRnn+weTK6P9r1mjX29mQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11162"; a="25473367"
X-IronPort-AV: E=Sophos;i="6.09,285,1716274800"; 
   d="scan'208";a="25473367"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2024 01:17:22 -0700
X-CSE-ConnectionGUID: 4B4dcFVKTpi2ZTGMBGxyHA==
X-CSE-MsgGUID: 9ZckQ9TTQuWj+KTXV4Orcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,285,1716274800"; 
   d="scan'208";a="89247056"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.244.153])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2024 01:17:18 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 13 Aug 2024 11:17:13 +0300 (EEST)
To: Alexander Dahl <ada@thorsis.com>
cc: Mathieu Othacehe <othacehe@gnu.org>, 
    Richard Genoud <richard.genoud@bootlin.com>, 
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Jiri Slaby <jirislaby@kernel.org>, 
    Nicolas Ferre <nicolas.ferre@microchip.com>, 
    Alexandre Belloni <alexandre.belloni@bootlin.com>, 
    Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
    LKML <linux-kernel@vger.kernel.org>, 
    linux-serial <linux-serial@vger.kernel.org>, 
    linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] tty: atmel_serial: use the correct RTS flag.
In-Reply-To: <20240813-absinthe-plaza-70575e847015@thorsis.com>
Message-ID: <84eaddb1-0987-d44f-cba0-48e519f93fed@linux.intel.com>
References: <20240808060637.19886-1-othacehe@gnu.org> <20240813-absinthe-plaza-70575e847015@thorsis.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-416352353-1723537033=:963"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-416352353-1723537033=:963
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 13 Aug 2024, Alexander Dahl wrote:

> Hello Mathieu,
>=20
> Am Thu, Aug 08, 2024 at 08:06:37AM +0200 schrieb Mathieu Othacehe:
> > In RS485 mode, the RTS pin is driven high by hardware when the transmit=
ter
> > is operating. This behaviour cannot be changed. This means that the dri=
ver
> > should claim that it supports SER_RS485_RTS_ON_SEND and not
> > SER_RS485_RTS_AFTER_SEND.
> >=20
> > Otherwise, when configuring the port with the SER_RS485_RTS_ON_SEND, on=
e
> > get the following warning:
> >=20
> > kern.warning kernel: atmel_usart_serial atmel_usart_serial.2.auto:
> > ttyS1 (1): invalid RTS setting, using RTS_AFTER_SEND instead
>=20
> I've seen this warning already, when migrating a sam9x60 based board
> from LTS kernel 6.1 to 6.6, so thanks for taking care of this.
>=20
> I can confirm after applying the patch on top of 6.6.44 the warning is
> gone, and RS-485 communication still works on our platform, so =E2=80=A6
>=20
> Tested-by: Alexander Dahl <ada@thorsis.com>
>=20
> Does this deserve a Fixes tag for the change which introduced struct
> serial_rs485 to the atmel serial driver?  Then it should be this:
>=20
> Fixes: af47c491e3c7 ("serial: atmel: Fill in rs485_supported")
>=20
> Greets
> Alex
>=20
> > which is contradictory with what's really happening.
> >=20
> > Signed-off-by: Mathieu Othacehe <othacehe@gnu.org>

This got (more) broken by one of the changes made into=20
uart_sanitize_serial_rs485() even if af47c491e3c7 used a wrong flag and=20
must be fixed. The code in af47c491e3c7:uart_sanitize_serial_rs485()=20
picks RTS_ON_SEND if no RTS_*_SEND flag is specified by the userspace=20
code.

The behavior change was due to 4afeced55baa ("serial: core: fix sanitizing=
=20
check for RTS settings") that enforced flags differently (4afeced55baa=20
makes very much sense but because of the wrong flag in atmel driver, it=20
ended up breaking atmel).

--=20
 i.

> > ---
> >  drivers/tty/serial/atmel_serial.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atm=
el_serial.c
> > index 0a90964d6d107..09b246c9e389e 100644
> > --- a/drivers/tty/serial/atmel_serial.c
> > +++ b/drivers/tty/serial/atmel_serial.c
> > @@ -2514,7 +2514,7 @@ static const struct uart_ops atmel_pops =3D {
> >  };
> > =20
> >  static const struct serial_rs485 atmel_rs485_supported =3D {
> > -=09.flags =3D SER_RS485_ENABLED | SER_RS485_RTS_AFTER_SEND | SER_RS485=
_RX_DURING_TX,
> > +=09.flags =3D SER_RS485_ENABLED | SER_RS485_RTS_ON_SEND | SER_RS485_RX=
_DURING_TX,
> >  =09.delay_rts_before_send =3D 1,
> >  =09.delay_rts_after_send =3D 1,
> >  };
> > --=20
> > 2.45.2
> >=20
> >=20
>=20
--8323328-416352353-1723537033=:963--
