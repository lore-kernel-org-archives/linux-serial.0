Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F1E2302756;
	Fri,  7 Nov 2025 09:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762508469; cv=none; b=saa1XNu7K0AlorOxv9Nkw+sHz1OJbm//YxUgcOhNpXg+9Md0lj39jNtKCknIBNHJvSPJUjuqCZl0QuK41kjo6A6iez5Jfj7hHacw1acVDJhRGsjxiqi7AgovfVRSx9c9277sb52XKyvvZPIdcAQTeSJIZY3BQvXUNbd10iM+dHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762508469; c=relaxed/simple;
	bh=UtTf9hJf9opUF8mRymLZsocYE6Cnuzz56eNW1DnxA80=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Sex1sEuXGxhoCI9QXjk/8VAMCYup81y1bQCG/nTbmMo6Ux/Kpt5ouX8C63F5VSdzT1W4F3dKbrspplbNo4/YdFZxONjLbAvwvWSkkCLGTzC5CwKruDcpHgcCnFjwFmyf4a9MVH18RmrdYfK4RZUNh332X4dvKa8KTSOnwwTrHbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BC+tbVG7; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BC+tbVG7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762508463; x=1794044463;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=UtTf9hJf9opUF8mRymLZsocYE6Cnuzz56eNW1DnxA80=;
  b=BC+tbVG7n17X7BHbWADDqXUSP8kwC5Hh/yTWxpB/8qzAqcAsObGKnJZJ
   wkHUgVi47L3HYRvAthwmt/2Ku0noVGV5PQsORc5mdV9sN2LLpQOxiJS9q
   S7OrO20kck1n6lM0xF+D5jAtvoPJgZJji2UXpRNWJUk0QWbPgkdQD4PgJ
   okJaokButWBWVR1hAdevrqANyGoaJ47MfxBIP4n8bbNgAX9aqykyJeJNE
   5PIg35dWPoiE15WwP3ZHkdUu3Jr8PApwTAtdxUT7vGzrqeeIXtHpq4W2y
   6EomOzILie6hzqldLYkCRRJ/gM788AB7cWATCNb8LSwRWu4P1l7yh8ZQU
   Q==;
X-CSE-ConnectionGUID: kiJAvG0QQcWOP2Tvv4kyyQ==
X-CSE-MsgGUID: /CV5/uOVQySpFRFDAMhH/w==
X-IronPort-AV: E=McAfee;i="6800,10657,11605"; a="68517648"
X-IronPort-AV: E=Sophos;i="6.19,286,1754982000"; 
   d="scan'208";a="68517648"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2025 01:41:03 -0800
X-CSE-ConnectionGUID: /mmooqtbRN+faEpSdUcJ/g==
X-CSE-MsgGUID: jW5SlXnWS0S7HmSIlbm1OQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,286,1754982000"; 
   d="scan'208";a="188718242"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.71])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2025 01:40:59 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 7 Nov 2025 11:40:55 +0200 (EET)
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
cc: Alex Davis <alex47794@gmail.com>, Stephen Rothwell <sfr@canb.auug.org.au>, 
    Borislav Petkov <bp@alien8.de>, 
    Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Jiri Slaby <jirislaby@kernel.org>, John Ogness <john.ogness@linutronix.de>, 
    linux-serial <linux-serial@vger.kernel.org>
Subject: Re: [Regression] depmod fails on kernel 6.17.1 rc1
In-Reply-To: <aQ2rM3KOrCaMqXi6@smile.fi.intel.com>
Message-ID: <df393daf-c4c6-33b7-c2ab-6f6ccf0c8ebd@linux.intel.com>
References: <CADiockCvM6v+d+UoFZpJSMoLAdpy99_h-hJdzUsdfaWGn3W7-g@mail.gmail.com> <20251106160235.GBaQzGm8W2Gt_VMy-s@fat_crate.local> <aQzJveMYT6O3EHeK@smile.fi.intel.com> <20251106162436.GFaQzLxBW-_50ndwtr@fat_crate.local> <3fe70726-80d6-a84a-4101-446fd8b49209@linux.intel.com>
 <ddfbc4bf-658f-3eda-5b4f-f111ecd932f5@linux.intel.com> <aQzliw1B5DPKcwi5@smile.fi.intel.com> <aQ2rM3KOrCaMqXi6@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1671782446-1762508455=:1070"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1671782446-1762508455=:1070
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Fri, 7 Nov 2025, Andy Shevchenko wrote:

> On Thu, Nov 06, 2025 at 08:14:35PM +0200, Andy Shevchenko wrote:
> > On Thu, Nov 06, 2025 at 08:00:36PM +0200, Ilpo J=E4rvinen wrote:
> > > On Thu, 6 Nov 2025, Ilpo J=E4rvinen wrote:
> > > > On Thu, 6 Nov 2025, Borislav Petkov wrote:
> > > > > On Thu, Nov 06, 2025 at 06:15:57PM +0200, Andy Shevchenko wrote:
> > > > > > > So I'm seeing this with an allmodconfig build too:
> > > > > =09=09=09       ^^^^^^^^^^^^
> > > > > > > depmod: ERROR: Cycle detected: 8250 -> 8250_base -> 8250
> > > > > > > depmod: ERROR: Found 2 modules in dependency cycles!
> > > > > >=20
> > > > > > I'm surprised it took so long to people to start complaining.
> > > > > >=20
> > > > > > So, some of those are modules? Can you share the
> > > > > >=20
> > > > > > =09grep 8250 .config
> > > > > >=20
> > > > > > part?
> > > > >=20
> > > > > See above.
> > > >=20
> > > > https://lore.kernel.org/all/87frc3sd8d.fsf@posteo.net/
> > > >=20
> > > > I wonder if 8250_rsa.o can be put into 8250_base.o where most of it=
s=20
> > > > callers are anyway?
> > >=20
> > > This seems to resolve the build issue for me:
> >=20
> > I prefer this solution to anything that suggests to merge the 8250_rsa =
in
> > another module.
>=20
> Oh, I meant "merge the source of the 8250_rsa", and here we are talking a=
bout
> merging the object file, which is totally fine! Sorry for the confusion i=
t
> might made.

The suggestion in that link was to merge the modules (8250.ko with=20
8250_base.ko) and that certainly isn't a great idea.

My patch only moves 8250_rsa.o from 8250.ko to 8250_base.ko and breaks=20
the symbol loop by passing what is needed from 8250.ko in function=20
arguments instead of directly referencing them in 8250_rsa.o.

> > If it fixes for the reporters, feel free to add my
> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>=20
>=20

--=20
 i.

--8323328-1671782446-1762508455=:1070--
