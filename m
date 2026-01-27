Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A12346E47;
	Tue, 27 Jan 2026 12:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769518118; cv=none; b=gsbbU/tIghTnUzBGvwTEnisBNTSMUwgkSY0bVXKb1yMAEA9Yx15fhFdY6AGyjneI6uHmPVBQRnWbOxAbEjLJjosVXpOpmCTJYUBmLEICDa4LbZGrKqLbie0OXlevZuOxnCXgthg0neFmeg+QuSwe89gxS7zY3q5TGCLs3PlF6Ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769518118; c=relaxed/simple;
	bh=GqWUGXJtTrHBklS29/A0qTtPq4CvYGqnNNgT6G9PqsE=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=MkLlRgfp7zLUYPjZmQW8dsdR7MZkzB6jN0IgV61VKnfPEvJhikBlczeqQFHf8MD86H2bzn9GlRsmQjtxUeb5fSb+kfZ+794E0cpOBscrWU8b6WyonTXDOS8g835b1r6br5cCM2Q9kGi/ujRBoeolDz1Vp64ZpAploBAjTPmqfV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Fd1IQNr6; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Fd1IQNr6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769518117; x=1801054117;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=GqWUGXJtTrHBklS29/A0qTtPq4CvYGqnNNgT6G9PqsE=;
  b=Fd1IQNr6dL6QFxP94yyh9lLoNiDMgd42YR8f8QnxmadrcOSirY3uBDSj
   +7GLvwYoIeShd1bbBkdYTT7owJoWwfsVU7LFsWK/ttEXhP2oTwWMoHbfm
   +KV89AnZavBdQVwLrMKHo5HeLbMU3UDa+/oaoh+8DmUkwNyyRrxJNJq+U
   0T/Kx5EwsGWWa0ZN7I+scpKGVXeWlZeC+2GYXGut3QSTL3lSj226LWcaB
   TaKPhFFVPUX7P6bCJuVXBFhaEsFtFfyLfjLVmVybvE3hNhaIbkwK06Axu
   xxuSQSZPJE1jTrD8wrpDB5nlaqK79+1mUWr2JgKnbCu1q4WX7wkO6pn4f
   A==;
X-CSE-ConnectionGUID: bRdFqFxvStao+sXAldh84g==
X-CSE-MsgGUID: WccyPUsHQFGV5jSfnbb1gQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11684"; a="74574196"
X-IronPort-AV: E=Sophos;i="6.21,257,1763452800"; 
   d="scan'208";a="74574196"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2026 04:48:37 -0800
X-CSE-ConnectionGUID: UbEoc7xbQi6fuYTYcFmGjw==
X-CSE-MsgGUID: VsEdJa1EQfaCKkFkxBpeiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,257,1763452800"; 
   d="scan'208";a="207212867"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.67])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2026 04:48:33 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 27 Jan 2026 14:48:30 +0200 (EET)
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Jiri Slaby <jirislaby@kernel.org>, 
    linux-serial <linux-serial@vger.kernel.org>, 
    qianfan Zhao <qianfanguijin@163.com>, Adriana Nicolae <adriana@arista.com>, 
    LKML <linux-kernel@vger.kernel.org>, 
    "Bandal, Shankar" <shankar.bandal@intel.com>, 
    "Murthy, Shanth" <shanth.murthy@intel.com>
Subject: Re: [PATCH 3/6] serial: 8250_dw: Rework dw8250_handle_irq() locking
 and IIR handling
In-Reply-To: <aXPwmfqPlUkI2zuw@smile.fi.intel.com>
Message-ID: <2aa4aaa4-07b5-2003-eba7-6e1e6fa89611@linux.intel.com>
References: <20260123172739.13410-1-ilpo.jarvinen@linux.intel.com> <20260123172739.13410-4-ilpo.jarvinen@linux.intel.com> <aXPwmfqPlUkI2zuw@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1047078821-1769518110=:1055"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1047078821-1769518110=:1055
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Sat, 24 Jan 2026, Andy Shevchenko wrote:

> On Fri, Jan 23, 2026 at 07:27:36PM +0200, Ilpo J=E4rvinen wrote:
> > dw8250_handle_irq() takes port's lock multiple times with no good
> > reason to release it in between and calls serial8250_handle_irq()
> > that also takes port's lock.
> >=20
> > As serial8250_handle_irq() takes port's lock itself, create
> > serial8250_handle_irq_locked() that allows caller to hold port's lock
> > across the call. Take port's lock only once in dw8250_handle_irq() and
> > call serial8250_handle_irq_locked() directly.
>=20
> Sounds to me that the latter can be split to a prerequisite patch.

It's not easy to split this DW-side IIR rework and locking changes. What I=
=20
can do is to make 8250_port change separately. I guess I'll do just that=20
and only the 8250_dw change in this patch.

> > As IIR_NO_INT check in serial8250_handle_irq() was outside of port's
> > lock, it has to be done already in dw8250_handle_irq().
> >=20
> > DW UART can, in addition to IIR_NO_INT, report BUSY_DETECT (0x7) which
> > collided with the IIR_NO_INT (0x1) check in serial8250_handle_irq()
> > (because & is used instead of =3D=3D) meaning that no other work is don=
e by
> > serial8250_handle_irq() during an BUSY_DETECT interrupt.
> >=20
> > This allows reorganizing code in dw8250_handle_irq() to do both
> > IIR_NO_INT and BUSY_DETECT handling right at the start simplifying
> > the logic.
>=20
> ...
>=20
> > +#include <linux/bitfield.h>
> > +#include <linux/bits.h>
>=20
> + cleanup.h
>
> >  #include <linux/clk.h>
> >  #include <linux/delay.h>
> >  #include <linux/device.h>
>=20
> ...
>=20
> > --- a/drivers/tty/serial/8250/8250_port.c
> > +++ b/drivers/tty/serial/8250/8250_port.c
>=20
> >  #include <linux/ioport.h>
> >  #include <linux/init.h>
> >  #include <linux/irq.h>
>=20
> > +#include <linux/lockdep.h>
>=20
> I would still keep more order.
>=20
> >  #include <linux/console.h>
> >  #include <linux/gpio/consumer.h>
>=20
> Giving the context we have, the better place for a new inclusion is somew=
here
> here.

Feels to me something that is in the eye of the beholder, but whatever, I=
=20
can move it from one's "correct" place to somebody elses "correct"
place. :-)

> >  #include <linux/sysrq.h>
>=20
> (Also perhaps sorting headers in a separate patch helps with finding bett=
er
>  places for the future inclusions?)

Yes, later (not in this series).

> ...
>=20
> > +EXPORT_SYMBOL_GPL(serial8250_handle_irq_locked);
>=20
> Wondering if we can start exporting with a namespace...

I'll do that. I picked "SERIAL_8250", is that fine or should I use e.g.=20
"8250" instead?

--=20
 i.

--8323328-1047078821-1769518110=:1055--
