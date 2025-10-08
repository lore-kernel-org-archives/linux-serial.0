Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD1119ABD8;
	Wed,  8 Oct 2025 09:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759915035; cv=none; b=CBg6jcuYF43OGOOo7YTuFdl2IflM4wVchyzaxNJ7wW5ahOqjBAOXKcjATQpFVk7gcsGzlQzfUkz8m3/NueTsQhUWaJrHXwpswcqE+5SmUEVVlEJABf/bmKNROshfVfWD6dqXKdH4VO5VMOmKg5m3wM0s/YPZI7uE2BM7DS7JcV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759915035; c=relaxed/simple;
	bh=UJBMrej11XzbXsvnlctuIBebZdWti2HuRWZw9fy5OmM=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Ny9oBxAIn+K4kY1j37gK5k83HzSPH+rPNKEJezPhQ+q8jo+3jBv6/MpOE9bp7gBJ4O1bqubFzeTN5gjtNYLzZitYfIHi7xjfniv0s/cw1qquswKRa86gC4FWh+cptaMLWdjVB6sTj+LMUgmmQaCtBjUwRxfEXA9WIHpuE+Zmkbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LYoc2F4l; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LYoc2F4l"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759915034; x=1791451034;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=UJBMrej11XzbXsvnlctuIBebZdWti2HuRWZw9fy5OmM=;
  b=LYoc2F4loj7gR3CrVYZVru1utCnX4McmZWg3pgTFjeiixk+RQQPSKjSf
   77q159fcPvnaiJ3u11JBHd3BBnDNJzuevrQ4RNJ9StSzy6AAm86WDKiGO
   jZwT/7Ruf5492n9fsMDC2F4KQTi5cQE38mtNWMFQd+RfzCL3WsHMDP72V
   kwlZ0o0+g+4acxktpJKxO3kBhRSJNlTJnIg95spEPtqr70tio/ijieZBM
   iGO9zaRgVFyOzTCyOl1KuCMu7aFNnJYISkhaENve9onkz9l5finNmZQsD
   2LxSiH0zSM/BKKfjyvPb0ZFJVoP1ld9Ip9j8HykOIrSXUpG0mduRrXWN2
   Q==;
X-CSE-ConnectionGUID: trqo5SNOSCSOd8muh5Arww==
X-CSE-MsgGUID: wLM9+KNLQSmQgyFXcdO/aw==
X-IronPort-AV: E=McAfee;i="6800,10657,11575"; a="79749589"
X-IronPort-AV: E=Sophos;i="6.18,323,1751266800"; 
   d="scan'208";a="79749589"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2025 02:17:13 -0700
X-CSE-ConnectionGUID: /irxMPa9REmrqQ6JkMvRKQ==
X-CSE-MsgGUID: WwkbSFBtS6OGo7yZBowrfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,323,1751266800"; 
   d="scan'208";a="179983002"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.117])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2025 02:17:08 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 8 Oct 2025 12:17:07 +0300 (EEST)
To: Marnix Rijnart <marnix.rijnart@iwell.eu>
cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Jiri Slaby <jirislaby@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
    linux-serial <linux-serial@vger.kernel.org>, regressions@lists.linux.dev
Subject: Re: [REGRESSION][PATCH] serial: 8250_pci: Fix broken RS485 for
 F81504/508/512
In-Reply-To: <CAAn10+fRb8VXnDEsSuCj782rp43ZEeov2yXnB2pYxXGNc-2niQ@mail.gmail.com>
Message-ID: <31584fa9-ab08-cda9-3dea-6448f570ee4c@linux.intel.com>
References: <20250923221756.26770-1-marnix.rijnart@iwell.eu> <0ab2436f-5c0d-966f-7095-d281292c494c@linux.intel.com> <CAAn10+fRb8VXnDEsSuCj782rp43ZEeov2yXnB2pYxXGNc-2niQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-693490741-1759312473=:982"
Content-ID: <17191169-2b4a-1393-f629-1f12e2fa023d@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-693490741-1759312473=:982
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <67c9aa2a-e373-e0ea-558b-d5f572446d89@linux.intel.com>

On Tue, 30 Sep 2025, Marnix Rijnart wrote:

> This is my first interaction with the kernel community, so I did my
> best to read up on the expected practices but maybe I missed
> something.

Hi,

No need to feel down because of it. We try to help submitters to improve=20
their patches and even more so when the submitter is a newcomer.

(And I'm sorry this reply got stuck into my postponed messages for more=20
than a week.)

> I didn't add a Fixes tag for commit 4afeced because it doesn't cause
> the bug by itself, it's the interaction between it and an older commit
> (456d523) that create the issue together. What's the right way to tag
> this?

It is fixing the newer interacting commit too as it failed to consider=20
the older commit properly.

You can add two Fixes tags in such a case.

> I didn't Cc stable because I understood this to be only required for
> point release regressions within a stable series
> (https://docs.kernel.org/admin-guide/reporting-regressions.html).
> Release 6.8 introduced this regression. Should I still Cc them?

If a problematic commit is old enough to be in any stable kernel, please=20
add Cc stable. (If the problematic commit would have been added only in=20
the latest cycle and only be in -rcX releases, stable needs not to be=20
Cc'ed.)

Here's some guidance on submitting patches that are to be included also=20
into stable kernels:

Documentation/process/stable-kernel-rules.rst

> If these tags need to added, what's the best way to do so? Resubmit
> the patch (as a v2)?

Yes, update and send v2. Also remember to include the changes you've made
in v2 under --- line (it's sort of version history of the patch itself,=20
see the ML archives for examples if you don't know what I'm talking about).

--=20
 i.

>=20
> Thanks,
> Marnix
>=20
> Op di 30 sep 2025 om 13:32 schreef Ilpo J=E4rvinen
> <ilpo.jarvinen@linux.intel.com>:
> >
> > On Wed, 24 Sep 2025, Marnix Rijnart wrote:
> >
> > > Commit 4afeced ("serial: core: fix sanitizing check for RTS settings"=
)
> > > introduced a regression making it impossible to unset
> > > SER_RS485_RTS_ON_SEND from userspace if SER_RS485_RTS_AFTER_SEND is
> > > unsupported. Because these devices need RTS to be low on TX (fecf27a)
> > > they are effectively broken.
> > >
> > > The hardware supports both RTS_ON_SEND and RTS_AFTER_SEND,
> > > so fix this by announcing support for SER_RS485_RTS_AFTER_SEND,
> > > similar to commit 068d35a.
> > >
> > > Signed-off-by: Marnix Rijnart <marnix.rijnart@iwell.eu>
> >
> > The Fixes tag is missing?
> >
> > (And Cc stable tag will be necessary as well).
> >
> > > ---
> > >  drivers/tty/serial/8250/8250_pci.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/=
8250/8250_pci.c
> > > index 152f914c599d..a9da222bd174 100644
> > > --- a/drivers/tty/serial/8250/8250_pci.c
> > > +++ b/drivers/tty/serial/8250/8250_pci.c
> > > @@ -1645,7 +1645,7 @@ static int pci_fintek_rs485_config(struct uart_=
port *port, struct ktermios *term
> > >  }
> > >
> > >  static const struct serial_rs485 pci_fintek_rs485_supported =3D {
> > > -     .flags =3D SER_RS485_ENABLED | SER_RS485_RTS_ON_SEND,
> > > +     .flags =3D SER_RS485_ENABLED | SER_RS485_RTS_ON_SEND | SER_RS48=
5_RTS_AFTER_SEND,
> > >       /* F81504/508/512 does not support RTS delay before or after se=
nd */
> > >  };
> > >
> > >
> >
> > --
> >  i.
> >
>=20
--8323328-693490741-1759312473=:982--
