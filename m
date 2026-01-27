Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C25592FE598;
	Tue, 27 Jan 2026 13:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769518916; cv=none; b=GAB+6JDTlRmaPQECeLNIt7i/tb4IpgY2l1A4Z38c+x4mGsIOIA2bU8dWKxHETg4TUe8SmnonTWDrLntUtW7oGNc798IdkatGOMGTRYytVca+jtTxM7pcRV8alnNda7g4kWH7LZe0gIg8Bt82MWgJi+/8RUdW4CnR8QOzUdRH42k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769518916; c=relaxed/simple;
	bh=Av3ohVPsLWIsZCHAoNwuJE9KiQjY5XpDhWMwU8NZRz4=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=DUZ271kXLNJR+v1BLVy83f0/E0xCAOQiEkEguz8HmuTH/LZayigIsgPr3/ADjQVA+8gqt621pn7NvNUI2EZ7a+Ikp5lZXDRMX96XJ1fjXmZer8Fcx5NxG6/LogeVLzTd4ehz+3U6ZmLupxgD0BZb/EG72b1cJlaZbZ74Tugl0uA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eTSkM3mg; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eTSkM3mg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769518915; x=1801054915;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Av3ohVPsLWIsZCHAoNwuJE9KiQjY5XpDhWMwU8NZRz4=;
  b=eTSkM3mg41JxgJQP4BDIYta1C74C5WO/weJqGPjj7ffX4qzZeHanhWhB
   o3FE+Y1uvk+LDKtXr+AlNfzWs5tw0cVyiDX6S0krnUGj3pbjO8mfD3Z4s
   0p0kQBwJsjIZs9CDSXkhka66w1Tvl7uIPa3dBGX/F8oBqvKnCQ1YZJEA5
   7mDRuQdB/4oHCjVXIqGpjFZ44h7W4xHDmPfh75DvWDW4sP/vtV/vL0KfC
   TY+gt5FdaiTztrd4lYrwHutyRuIsvlLQ9U00CZc5hvaQL26EMbWsmJSUv
   7MnDzkGeNQEoS/KRInvH1oCuUefK1tEoy23v8xOdkMMUqgyb4IvzmA1eD
   Q==;
X-CSE-ConnectionGUID: YWW+2Gt/SEenItlcrgey7Q==
X-CSE-MsgGUID: JLBJ6vHzSVCiIBWLpeBNfQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11684"; a="93370932"
X-IronPort-AV: E=Sophos;i="6.21,257,1763452800"; 
   d="scan'208";a="93370932"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2026 05:01:54 -0800
X-CSE-ConnectionGUID: BqXrklCBQoWCezCmogd7wQ==
X-CSE-MsgGUID: AC/8t59bTLSoqabYv8f2QA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,257,1763452800"; 
   d="scan'208";a="212085697"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.67])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2026 05:01:50 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 27 Jan 2026 15:01:46 +0200 (EET)
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Jiri Slaby <jirislaby@kernel.org>, 
    linux-serial <linux-serial@vger.kernel.org>, 
    qianfan Zhao <qianfanguijin@163.com>, Adriana Nicolae <adriana@arista.com>, 
    LKML <linux-kernel@vger.kernel.org>, 
    "Bandal, Shankar" <shankar.bandal@intel.com>, 
    "Murthy, Shanth" <shanth.murthy@intel.com>
Subject: Re: [PATCH 4/6] serial: 8250_dw: Rework IIR_NO_INT handling to stop
 interrupt storm
In-Reply-To: <aXPyiOMxClprdOQM@smile.fi.intel.com>
Message-ID: <be94eddc-0395-7215-df1e-ba5e718701f8@linux.intel.com>
References: <20260123172739.13410-1-ilpo.jarvinen@linux.intel.com> <20260123172739.13410-5-ilpo.jarvinen@linux.intel.com> <aXPyiOMxClprdOQM@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-249583868-1769518906=:1055"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-249583868-1769518906=:1055
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Sat, 24 Jan 2026, Andy Shevchenko wrote:

> On Fri, Jan 23, 2026 at 07:27:37PM +0200, Ilpo J=E4rvinen wrote:
> > INTC10EE UART can end up into an interrupt storm where it reports
> > IIR_NO_INT (0x1). If the storm happens during active UART operation, it
> > is promptly stopped by IIR value change due to Rx or Tx events.
> > However, when there is no activity, either due to idle serial line or
> > due to specific circumstances such as during shutdown that writes
> > IER=3D0, there is nothing to stop the storm.
> >=20
> > During shutdown the storm is particularly problematic because
> > serial8250_do_shutdown() calls synchronize_irq() that will hang in
> > waiting for the storm to finish which never happens.
> >=20
> > This problem can also result in triggering a warning:
> >=20
> >   irq 45: nobody cared (try booting with the "irqpoll" option)
> >   [...snip...]
> >   handlers:
> >     serial8250_interrupt
> >   Disabling IRQ #45
> >=20
> > Normal means to reset interrupt status by reading LSR, MSR, USR, or RX
> > register do not result in the UART deasserting the IRQ.
> >=20
> > Add a quirk to INTC10EE UARTs to enable Tx interrupts if UART's Tx is
> > currently empty and inactive. Rework IIR_NO_INT to keep track of the
> > number of consecutive IIR_NO_INT, and on third one perform the quirk.
> > Enabling Tx interrupts should change IIR value from IIR_NO_INT to
> > IIR_THRI which has been observed to stop the storm.
>=20
> ...
>=20
> > +=09u64=09=09=09no_int_count;
>=20
> Why so big?
>=20
> ...

No particular reason, it's a leftover from debugging this issue.

> > +=09=09d->no_int_count++;
> > +=09=09if (d->no_int_count > 2 && quirks & DW_UART_QUIRK_IER_KICK)
> > +=09=09=09dw8250_quirk_ier_kick(p);
>=20
> Usual way is to use modulo. And perhaps use 4 for the sake of avoiding
> division:
>=20
> =09=09if (d->no_int_count =3D=3D 3 && quirks & DW_UART_QUIRK_IER_KICK)
> =09=09=09dw8250_quirk_ier_kick(p);
>=20
> =09=09d->no_int_count =3D (d->no_int_count + 1) % 4;

This doesn't look equivalent code as it only fires on 4th NO_INT, but I=20
guess the difference doesn't matter that much so changing to your=20
suggestion so that the kick will only occurs on fourth NO_INT interrupt.

--=20
 i.

> where 4 may be defined with meaningful name. With that u8 is more than en=
ough.
>
> >  =09=09return 0;
>=20
>=20
--8323328-249583868-1769518906=:1055--
