Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46C1835F180
	for <linux-serial@vger.kernel.org>; Tue, 16 Jun 2026 07:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781596645; cv=none; b=uCk734yMhItFRUjzeD/PLABvasgvBJt+Ki39c6WeNhYzNZRnlsrjchBtWAGeq+/q2+M2nJ3dD7q4IVu50vChZzbIwp0yyKgADEqRNBc+09Q/X97PyY0gzUL20QGcg+pZ7nHYMr/PNzr/ILQ6/Ivqh34XlFIvUt1Bt3YFIBed/xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781596645; c=relaxed/simple;
	bh=UqRqC3Q+2H8XCIOuyq/QEVDq69PyqjwHUo+h3eZzEXo=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=uAbYJnbmq/oK0Zzmqx6i9DQD3BUNJXb3PuQwwjQRVjTgZKEen8NLJwAGQkLN7GYF/JsjfOsZ22lCTJZcQYdJsFPJN8S4SqpcuiRWFkaJH+uJhbNjl+HurdqifWOtRZly2aBsVOB4N/NDGD3J7jDQ41/OGwP3LBlXPm39KGVxraA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jd/Xvh54; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jd/Xvh54"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781596645; x=1813132645;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=UqRqC3Q+2H8XCIOuyq/QEVDq69PyqjwHUo+h3eZzEXo=;
  b=jd/Xvh54PiGxb+mngw+rj0+9JTSTjONikwdSGCa2/c5W0ZQjFeeb1I2Q
   XPeTYZFC5WDWycJFgW9ZDP0vEJJJmR4m2NtaWrnUwtkv2tLaWKBA5nJ5F
   w4+YHG8wCzXvtEoaNIGTtqCgebAb/bEKGLbiWpb/AsI6gpuFEdOSVX6gu
   PMDnXz1zdwAOlVTMHsReGoaSS/crufSwgHYmqkXmEhLyIQmhXnfho0sYF
   pnSwWDyv4qaJMEOfWPdFK3CKR577+bn1ur0XbjRyybkpvbCKw7ZE1JRC4
   JBR3ns8EjqSeNHgtcZISgyszlrnYKst9WpsdnxTJTo30BDULFmbeY239S
   Q==;
X-CSE-ConnectionGUID: ljSPregnQTGyjBWTTXHG+A==
X-CSE-MsgGUID: 8CZWcsFnSgqJqz3HkNYFPQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11818"; a="85989428"
X-IronPort-AV: E=Sophos;i="6.24,207,1774335600"; 
   d="scan'208";a="85989428"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2026 00:57:24 -0700
X-CSE-ConnectionGUID: vivHlCdyQ2yraadEmToEQg==
X-CSE-MsgGUID: /5L/djnTTlS0FcJSbMypMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,207,1774335600"; 
   d="scan'208";a="252675988"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.171])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2026 00:57:21 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 16 Jun 2026 10:57:17 +0300 (EEST)
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
cc: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>, 
    stable@kernel.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
    wander@redhat.com, chris.friesen@windriver.com, 
    linux-serial <linux-serial@vger.kernel.org>
Subject: Re: [PATCH v2 6.12.y 00/10] serial: 8250_dw: backport BUSY deassert
 series
In-Reply-To: <2026061641-cozy-creatable-9a9e@gregkh>
Message-ID: <6f3f1c55-be29-7b37-32d3-fab59ea6474c@linux.intel.com>
References: <20260513065028.112468-1-ionut.nechita@windriver.com> <c9f3545f-4522-4b78-7398-b364a4033a77@linux.intel.com> <2026061641-cozy-creatable-9a9e@gregkh>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-778637447-1781596637=:1303"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-778637447-1781596637=:1303
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 16 Jun 2026, Greg Kroah-Hartman wrote:

> On Wed, May 13, 2026 at 01:16:31PM +0300, Ilpo J=E4rvinen wrote:
> > On Wed, 13 May 2026, Ionut Nechita (Wind River) wrote:
> >=20
> > > From: Ionut Nechita <ionut.nechita@windriver.com>
> > >=20
> > > Hi Greg, Ilpo,
> > >=20
> > > This is v2 of the 8250_dw BUSY deassert backport to 6.12.y,
> > > addressing Ilpo's review feedback on v1.
> >=20
> > FYI, this came up yesterday related to guard()s vs unlock variants:
> >=20
> > https://lore.kernel.org/linux-serial/cover.1778592805.git.jnilo@free.fr=
/
>=20
> Yeah, I'm not going to take these now, I'd like to see a lot more
> testing and some actual reasons why this is needed in this tree.  So far
> windriver's track-record for backports is really low/bad so I'll just
> drop them from my review queue right now.

To be fair, it was me who strongly suggested that the backport should do=20
the guard() conversion as well, which contained the bug linked above (and=
=20
the cause there too, was my handiwork), while they initially kept using=20
open-coded lock/unlock variants which would not have been subject to that=
=20
problem.

But yes, you guys are the stable maintainers so what to take is your=20
decision.

--=20
 i.

--8323328-778637447-1781596637=:1303--
