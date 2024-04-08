Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A29141995;
	Mon,  8 Apr 2024 15:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712590893; cv=none; b=alhfYJTuKluOmS1lB9s2QQoW8/eQXTknwaC9j2+kurfpeq1E+BpPHLiSo5AP0si940gK9CqxvOhYlj/O9d11pO1XHZDtnzy7P3SYT2GIE6E6+zqaZRYTI21mpvrZ8N4r6mCd4d/DS8HndFLroZdCOqlPTueJTyFuadExGTNrUWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712590893; c=relaxed/simple;
	bh=E3uWjqBGI1fCpvx4YHq4VUFoutTIGcoIeKTDxInRsCk=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=rF3qIP0jCt4p9eAuGF7HNmzCbs06BNjrYeBfv005/aHQRW48TUlP/tK4PFpGLxNU/CKdZJQg9YZD6rV0dxcA6JGzjf8Jt8oxlapW2/oYLSbYB5ssOvORt0RlwEGrAqVY81/Kp842+1zhsApIpZdSiDUIFbpkCZgJ+oyLe7bdDqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A2ILJ6//; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A2ILJ6//"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712590891; x=1744126891;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=E3uWjqBGI1fCpvx4YHq4VUFoutTIGcoIeKTDxInRsCk=;
  b=A2ILJ6//oVWuZg4h5pgl3wptQOdjQmNrauRE1NPp6fr0H8YzhqAqyAFe
   Qe+O3PLEc8flP1XQn2PlJMwLs0ttfZxlrkiiSfwB/ch0N5C82bmaA2tv2
   4c4C4/7XZDyy0nm2RZB6Ksk0GXGN4rGofJUUBOrCWgGXi/RxOw49jmItR
   s6Y/9XSpHeEDoO8TDtQw/LPc7jagr3iFVkkakLeUaHvck0PONM51QGP86
   NDVEo20REYsCZy7rhbbIUn9rUF2fkx5Lg673mJjQUbwI+rj9UWlY+vgTb
   U/JCjDHifUg7lbt/680weH6U4OFDZHENF/yt0JGF9P6UaejNL9zCgvl6G
   Q==;
X-CSE-ConnectionGUID: QQyNBBt/TLy+HZRfVtt6Qw==
X-CSE-MsgGUID: cZGpN1DxT9qpCk07mbhgRA==
X-IronPort-AV: E=McAfee;i="6600,9927,11038"; a="18446836"
X-IronPort-AV: E=Sophos;i="6.07,187,1708416000"; 
   d="scan'208";a="18446836"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 08:41:31 -0700
X-CSE-ConnectionGUID: ZQ6MJe+9Rw+BtzQ6fkAwdA==
X-CSE-MsgGUID: mTxnbnCKTwaJdTK/CAYhrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,187,1708416000"; 
   d="scan'208";a="20050831"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.28])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 08:41:28 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 8 Apr 2024 18:41:24 +0300 (EEST)
To: Niklas Schnelle <schnelle@linux.ibm.com>
cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Jiri Slaby <jirislaby@kernel.org>, 
    linux-serial <linux-serial@vger.kernel.org>, 
    Arnd Bergmann <arnd@kernel.org>, Heiko Carstens <hca@linux.ibm.com>, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] tty: serial: handle HAS_IOPORT dependencies
In-Reply-To: <a98fdeca857f4eb1e3513a8658ef55f89ac45e8b.camel@linux.ibm.com>
Message-ID: <6251fc72-21ca-aba6-c70a-eefdbc046951@linux.intel.com>
References: <20240405152924.252598-1-schnelle@linux.ibm.com>  <20240405152924.252598-2-schnelle@linux.ibm.com>  <1a14ac6e-30e9-048e-50cc-c1c3aacc2118@linux.intel.com> <a98fdeca857f4eb1e3513a8658ef55f89ac45e8b.camel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-270381069-1712590779=:14302"
Content-ID: <4b597578-0a35-f46c-87f0-dea8ba894f82@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-270381069-1712590779=:14302
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <933d7f4f-41e8-a08b-e3ae-4e09ab1be8f6@linux.intel.com>

On Mon, 8 Apr 2024, Niklas Schnelle wrote:

> On Mon, 2024-04-08 at 12:54 +0300, Ilpo J=E4rvinen wrote:
> > On Fri, 5 Apr 2024, Niklas Schnelle wrote:
> >=20
> > > In a future patch HAS_IOPORT=3Dn will disable inb()/outb() and friend=
s at
> > > compile time. We thus need to add HAS_IOPORT as dependency for those
> > > drivers using them unconditionally. For 8250 based drivers some suppo=
rt
> > > MMIO only use so fence only the parts requiring I/O ports.
> > >=20
> > > Co-developed-by: Arnd Bergmann <arnd@kernel.org>
> > > Signed-off-by: Arnd Bergmann <arnd@kernel.org>
> > > Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> > > ---
> > > Note: This patch does not depend any not-yet-mainline HAS_IOPORT chan=
ges
> > > and may be merged via subsystem specific trees at your earliest
> > > convenience.
> > >=20
> > > Note 2: This was previously acked here:
> > > https://lore.kernel.org/all/2023053050-prodigal-shine-4d1c@gregkh/
> > > Given this was almost a year ago and didn't apply then I didn't
> > > carry the Ack over though.
> > >=20
> > >=20
> ---8<---
> > > diff --git a/drivers/tty/serial/8250/Kconfig b/drivers/tty/serial/825=
0/Kconfig
> > > index 47ff50763c04..54bf98869abf 100644
> > > --- a/drivers/tty/serial/8250/Kconfig
> > > +++ b/drivers/tty/serial/8250/Kconfig
> > > @@ -6,7 +6,6 @@
> > > =20
> > >  config SERIAL_8250
> > >  =09tristate "8250/16550 and compatible serial support"
> > > -=09depends on !S390
> >=20
> > Why? Your changelogs gives zero insight on this change.
>=20
> I used this for compile testing since I build on s390 natively and this
> would have hidden the missing HAS_IOPORT dependencies I'm pretty sure
> it was added because of the I/O port problem too. I'll either add to
> the commit description that it is no longer needed or drop this. Any
> preference?

Okay, we might never know the reason for sure if that's old enough.
I think the best approach would be to put it into own patch so this=20
guessimation is limited to a single liner patch instead of it being=20
hidden among the other clearer cases.

--=20
 i.
--8323328-270381069-1712590779=:14302--
