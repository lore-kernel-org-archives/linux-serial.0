Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793275008;
	b=i5H9RmuvR61nYmrm+/AYcDL0k0jQ0VMIC9Ty66z6wt7hMV7S5/y4j9zesKXdlm56dW14
	 /9wbIgGEEzAfWLD0lDPi9K9VbFg/XFWNRfGE7QyGQjOC7jO4FwZvZrTOUfj4vB7PvUCY1
	 mvb7LZZNvXbLVH1v1iGqYvXdQnqHcn5rD/3+jfO9PpuNf1235fXsji66ZoWx89GvOcO/X
	 YdFLG7AtdKgkzkzNQd9Cn3GswkLXsfhLPzs6rw0Voc/N9/ScZ1hnkI5PUpMbAIKCcin7A
	 oqlp49dG0KfHs8dOaNnkwV9kwvcsSJUqeqO3R/J+rRyGx7jGgFTkJNqwHRH2g60xeXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793275008;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:Date:To:cc:
	 Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type;
	bh=sU4e7wuqTqzUVQN/c3QiLVT4NajPsQIxnJ8H+MQ9VO4=;
	b=VK/y180niGJcMgcJKBlrmEZjU0ydw6g6DIWbD6e0D2RNfOuxBsKhSpSbZGqax91qXU6n
	 vFbMqITbujbV3imdwv0eK7jr9s8k0WCiYAZBZKStPMtqvs4QEruVnhbjIT/RT5hTtF4rx
	 T3uYEdBd7/dl7WkM4QYX06oX6p+TfQT3THuvMuLJ1FaOdaPEuV7sBy10vDLKDdBIB5z+u
	 e3u1QeBso0uupQt/EQDZVk/9X/Dsme4EBHAsQkt2bJQPAhwXwFh7pU3Ts9tm52gibnoK7
	 Vi5AVmIiev5YnBzELW3VdFqs33Gc5uyp7K3HLXOVPX9XAAIPBXB/x76X8xR1ASjipHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Aq2yS91g;
	arc=none smtp.remote-ip=198.175.65.21
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AC90606A31A;
	Thu, 29 Oct 2026 11:56:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9AC90606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Aq2yS91g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793275007; x=1824811007;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=ECaTdLJk1+NJUFeCKq9XKqsWx9P7nQKtBPkNrz3LMl8=;
  b=Aq2yS91g3atFfCeszqItufiVDEztW7JQT2hD0J9wRGzu5PXKQCBAHJ7/
   JoimfshfXGgWzahv5IzIYXy4V0jwbHfMds0umAP2l0Ig+iyaP3GusU0EU
   kXyTp67pIEuEEwL5Np4jqY8Vc+TEI8ekcDm7x9NRDLQ9mCblj+e1y84Lk
   unVRBCUSDiCJqHWEzfEP7uFCdnK+9mjrPYm4Dp6rTYv/WzWPrrl+ZnfSE
   u3e4FXrgXTKw/wXCrHqbD8X81xSJcTlp6fBQcMXWEPKkTNi9ae8b68i41
   6I/1Sko74fvmj+PlNevggCfTCF1LYctlFUVGFTozanIL0qckzjPzOzaqB
   w==;
X-CSE-ConnectionGUID: FjIJi7taR0Cp0kIlFh7CgA==
X-CSE-MsgGUID: qeEf+P3QRFeCcwST9OzocQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11949"; a="2108286"
X-IronPort-AV: E=Sophos;i="6.27,184,1787036400"; 
   d="scan'208";a="2108286"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2026 04:56:47 -0700
X-CSE-ConnectionGUID: s/nwXWPnQHa0rPLrpJ73QQ==
X-CSE-MsgGUID: 6rpluSCQSL+1tvtH1I46RQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,184,1787036400"; 
   d="scan'208";a="5223627"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.149])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2026 04:56:35 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 29 Oct 2026 13:56:29 +0200 (EET)
To: Jiri Slaby <jirislaby@kernel.org>
cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Joshua Rogers <linux@joshua.hu>, Chris Mason <mason@kernel.org>, 
    Josef Bacik <josef@toxicpanda.com>, Tony Lindgren <tony@atomide.com>, 
    Rafael Gago Castano <rgc@hms.se>, Florian Fainelli <f.fainelli@gmail.com>, 
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
    linux-serial <linux-serial@vger.kernel.org>, stable <stable@kernel.org>
Subject: Re: [PATCH 24/24] serial: stm32: don't report a wakeup to a closed
 tty
In-Reply-To: <74e02b49-f596-4433-a132-7799029db2a5@kernel.org>
Message-ID: <84ab00cb-ac35-f1c3-ac9c-fbbdeb210ec2@linux.intel.com>
References: <20261027-tty-llm-v1-0-99b0202ae546@linuxfoundation.org> <20261027-tty-llm-v1-24-99b0202ae546@linuxfoundation.org> <aef066bc-1b1e-b1e8-97f5-6fa8c8d18940@linux.intel.com> <74e02b49-f596-4433-a132-7799029db2a5@kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1863965678-1793274989=:1322"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1863965678-1793274989=:1322
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 29 Oct 2026, Jiri Slaby wrote:

> On 27. 10. 26, 14:02, Ilpo J=C3=A4rvinen wrote:
> > On Tue, 27 Oct 2026, Greg Kroah-Hartman wrote:
> >=20
> > > From: Josef Bacik <josef@toxicpanda.com>
> > >=20
> > > stm32_usart_interrupt() reports a wakeup interrupt as a wakeup event =
of
> > > tport->tty->dev.  That pointer is only set while the port is open.  T=
he
> > > port of a console is not shut down by the last close: it stays
> > > initialized, so the wakeup interrupt is still enabled on suspend.  If
> > > the system is then woken up by the console, the handler dereferences =
a
> > > NULL pointer.
> > >=20
> > > Take a reference to the tty, and leave the event out if there is none=
=2E
> > >=20
> > > Fixes: 48a6092fb41f ("serial: stm32-usart: Add STM32 USART Driver")
> > > Cc: stable <stable@kernel.org>
> > > Cc: Jiri Slaby <jirislaby@kernel.org>
> > > Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
> > > Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>
> > > Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
> > > Cc: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
> > > Cc: Peter Hurley <peter@hurleysoftware.com>
> > > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> > > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > ---
> > >   drivers/tty/serial/stm32-usart.c | 11 +++++++++--
> > >   1 file changed, 9 insertions(+), 2 deletions(-)
> > >=20
> > > diff --git a/drivers/tty/serial/stm32-usart.c
> > > b/drivers/tty/serial/stm32-usart.c
> > > index ad06b760cfca..3bc2ce877585 100644
> > > --- a/drivers/tty/serial/stm32-usart.c
> > > +++ b/drivers/tty/serial/stm32-usart.c
> > > @@ -872,8 +872,15 @@ static irqreturn_t stm32_usart_interrupt(int irq=
,
> > > void *ptr)
> > >   =09=09writel_relaxed(USART_ICR_WUCF,
> > >   =09=09=09       port->membase + ofs->icr);
> > >   =09=09stm32_usart_clr_bits(port, ofs->cr3, USART_CR3_WUFIE);
> > > -=09=09if (irqd_is_wakeup_set(irq_get_irq_data(port->irq)))
> > > -=09=09=09pm_wakeup_event(tport->tty->dev, 0);
> > > +=09=09if (irqd_is_wakeup_set(irq_get_irq_data(port->irq))) {
> > > +=09=09=09struct tty_struct *tty =3D tty_port_tty_get(tport);
> > > +
> > > +=09=09=09/* A console stays set up after the last close */
> > > +=09=09=09if (tty) {
> > > +=09=09=09=09pm_wakeup_event(tty->dev, 0);
> > > +=09=09=09=09tty_kref_put(tty);
> > > +=09=09=09}
> > > +=09=09}
> >=20
> > Could we like add a helper into serial core to do this tty wakeup dance=
?
> > It is duplicated in quite many of these patches.
>=20
> Likely. Or use scoped_guard(tty_port_tty) at minimum.

Also the irqd_is_wakeup_set(irq_get_irq_data(xx)) part seemed duplicated=20
so it's not just about the reference dance what is duplicated in this=20
fragment.

--=20
 i.

--8323328-1863965678-1793274989=:1322--
