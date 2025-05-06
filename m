Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FFC627F4C9;
	Tue,  6 May 2025 12:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746533338; cv=none; b=deWqiIoqpAVCSPDyzqV67uvJnEuozRcdyw9kTX9CTM3IqoYktQmNO0geEcD8ySlIjn+uERnA6JL6Pj0+kx1f8LjSl0jQt+xXAX3FK4HlC5mTxgJqSwRY1rFhxxieUdwcqKUYESb0/jN8PL5wJTpc/mXW7c48YTS1YgEFJ94+36k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746533338; c=relaxed/simple;
	bh=qWEQKN50Sfhev29R+1iiRJnG9Ap2n+NOPh3MBXCQJgg=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=QzBp/i4a9iKfsEtmLzjPBiEBFK6Ct5JlBAJlp7MO4gdXJ090Ue3OE7uQLFa4Zfb8ylAhaG+2nDWmVqwyOLkvwY9EoPI2W+HPMlgQZCMF+/5DWT/nn+5QqJOVaJq3d3yprpgYFjBbkwK4LTnG/aUMCkDkyewALfdzcVuf3D4fKJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GEvW4hTI; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GEvW4hTI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746533337; x=1778069337;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=qWEQKN50Sfhev29R+1iiRJnG9Ap2n+NOPh3MBXCQJgg=;
  b=GEvW4hTIcb8YgGnDbL0QkQuWF9UkEbckf2RAJbrBd12pYkJP1SzqeDDH
   u4gfMIqj+Ji4ZN/UUS0JzZ/Xs6empqr4bVFUEKPDMf476DKg1+pvmkx5g
   SaY1zyEZY8kL12gtNNB+JBGKqXRS19TNkISwsl5gA5fR12qqSKVpVaKbJ
   9mPG5xxF6ipZ/yNLoTOOeyVJ6EayVqBnixqS1Ck6kp8BTsWJE1pchlEKp
   tIXw8RtxNDEW3nQrxZYSe8RikgrVbLmyE/FJJYqNtyjzLQG7NdP3iwI7g
   WVyn+71OrE2rvkaSvYzJXMPi8Ya+F4qnmB0wNrHHC0LVL3Q4Ew0sQCtnc
   Q==;
X-CSE-ConnectionGUID: 2d71jEmDQqKv6zwcJBkfkg==
X-CSE-MsgGUID: rw0UmB39SteVvhISkmoU8Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11425"; a="48106480"
X-IronPort-AV: E=Sophos;i="6.15,266,1739865600"; 
   d="scan'208";a="48106480"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2025 05:08:56 -0700
X-CSE-ConnectionGUID: 43eUpEGxTxibNHy2EkAEag==
X-CSE-MsgGUID: ggD0ZOv0TrOdeUhfCxxZtg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,266,1739865600"; 
   d="scan'208";a="136537055"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.207])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2025 05:08:50 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 6 May 2025 15:08:46 +0300 (EEST)
To: Yunhui Cui <cuiyunhui@bytedance.com>
cc: arnd@arndb.de, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
    benjamin.larsson@genexis.eu, 
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    heikki.krogerus@linux.intel.com, Jiri Slaby <jirislaby@kernel.org>, 
    jkeeping@inmusicbrands.com, john.ogness@linutronix.de, 
    LKML <linux-kernel@vger.kernel.org>, 
    linux-serial <linux-serial@vger.kernel.org>, markus.mayer@linaro.org, 
    matt.porter@linaro.org, namcao@linutronix.de, paulmck@kernel.org, 
    pmladek@suse.com, schnelle@linux.ibm.com, sunilvl@ventanamicro.com, 
    tim.kryger@linaro.org
Subject: Re: [PATCH v5 3/4] serial: 8250_dw: warning on entering dw8250_force_idle
 unlocked
In-Reply-To: <71a295db-72ea-bf2a-338f-416b178f5305@linux.intel.com>
Message-ID: <f4fe790b-8dcd-1002-f6cd-0fbf451d28e1@linux.intel.com>
References: <20250506112321.61710-1-cuiyunhui@bytedance.com> <20250506112321.61710-3-cuiyunhui@bytedance.com> <71a295db-72ea-bf2a-338f-416b178f5305@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-505674580-1746533326=:1921"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-505674580-1746533326=:1921
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

Also, you should also improve the shortlog (in Subject) to something less=
=20
vague, e.g.:

serial: 8250_dw: assert port->lock is held in dw8250_force_idle()

On Tue, 6 May 2025, Ilpo J=E4rvinen wrote:
> On Tue, 6 May 2025, Yunhui Cui wrote:
>=20
> > Read UART_RX and check UART_LSR_DR in critical section. Unsure if
>=20
> Unsure if -> Ensure the
>=20
> > caller of dw8250_force_idle() holds port->lock. Don't acquire it
> > directly to avoid deadlock. Use lockdep_assert_held_once for warning.
>=20
> Add (), although the last two sentences don't seem that useful, IMO.
>=20
> >=20
> > Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> > ---
> >  drivers/tty/serial/8250/8250_dw.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >=20
> > diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/825=
0/8250_dw.c
> > index af24ec25d976..f41c4a9ed58b 100644
> > --- a/drivers/tty/serial/8250/8250_dw.c
> > +++ b/drivers/tty/serial/8250/8250_dw.c
> > @@ -13,6 +13,7 @@
> >  #include <linux/delay.h>
> >  #include <linux/device.h>
> >  #include <linux/io.h>
> > +#include <linux/lockdep.h>
> >  #include <linux/mod_devicetable.h>
> >  #include <linux/module.h>
> >  #include <linux/notifier.h>
> > @@ -112,6 +113,13 @@ static void dw8250_force_idle(struct uart_port *p)
> >  =09struct uart_8250_port *up =3D up_to_u8250p(p);
> >  =09unsigned int lsr;
> > =20
> > +=09/*
> > +=09 * The serial_in(p, UART_RX) should be under port->lock, but we can=
't add
> > +=09 * it to avoid AA deadlock as we're unsure if serial_out*(...UART_L=
CR)
> > +=09 * is under port->lock.
>=20
> I'm left to wonder who/what "we" is here? Could you change it something=
=20
> more precise.
>=20
> > +=09 */
> > +=09lockdep_assert_held_once(&p->lock);
> > +
> >  =09serial8250_clear_and_reinit_fifos(up);
> > =20
> >  =09/*
> >=20
>=20
>=20

--=20
 i.

--8323328-505674580-1746533326=:1921--
