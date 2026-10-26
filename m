Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793007233;
	b=su54OQiKAjUuwLSb6g+kpOE/Ztaem+mMTBOdMNK+toEh3n9nKmxVd59Wtpimy+O2I/ML
	 2kT+j90jBG9rUVejyCLJcfaLdsK/TYOmcZG5/yxUNL1/7j3Ehz3ooWG55Y2SuvmxDuPT+
	 jEnrY0jz6n9bLRlNxnqRMn4uCt8DBUWmKsRYe+5FOM0YXUq94defOnpPs5c+4b8A7N/o3
	 cdRm1prH+NHTrqi3v7sMTWugeoLTn/OT4c9i3QJQFsmHuGSQqQuA1rBUCNTc1I8yY+s4D
	 qEINBkhs0kdEqg6+rJO6SP2isoflDHoj98MwiCartEt9JmgrbMq0a2pPLVTp1T3qXlQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793007233;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To:
	 Organization;
	bh=0WRy0PlXijTVPaZN+8guL59byar3K3OLJbxaZMhuvdo=;
	b=3T8KUjw0sj+AdA7DDqgLJMCm0hkE5hOJe25y5lmazxBwYqua/IDsrVj3U8i+fUSRhZ0r
	 OQfJ1U+Qu+FYcWaCfD7MQUfdd2g1xcves2PcIoaZrwwQW4wQDHujeMhUVxMAr6otLnUvn
	 sc8lepGeMNuVKC/v+JuwFnkqrViWBN/K7t9jRXj1XXOXmzZf3FI/+o5tUbeNY4Hwlq6xb
	 ThK7x5KFe4gppEPua6zVos+fJm90CAiTlMfKiqbAHyZYSHMMMOx3xEKiuRSQXiJVBnWfS
	 3+9Znnn20lsINnfPLtw1qnK1MWcyyqWV9b/dhNDLyI1rDlSUyHI8kqnb/IoJjMC5RMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ZQe2ijxF;
	arc=none smtp.remote-ip=198.175.65.9
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 143FF606A31B;
	Mon, 26 Oct 2026 09:33:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 143FF606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ZQe2ijxF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793007234; x=1824543234;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=f84sV62ooKOvjIhQKXtEC/TuKGIbIDblS98potdMs0c=;
  b=ZQe2ijxFuR9wM1a3qrmGobGQm7HTNiGEN1ja9VDRGDQfyu9nCUXFeweY
   NfYUy9CZR2BG4Xkw6/sLA1lv5pDIEh1eGcYb1t5zSPvuam7dmhluSCJDA
   o/LcuUWjZdoUxaNVkuzMssT18boQdDcmfDJEwUnxs4e+xgOWKHUCFXq4o
   Qgf9P8eNhLYAaYmiePIssrPU8CDeXaNSorV+waujs5tXSah9C9VCc3F4k
   7zn5/0NUtar5RBLbiq40I5M/Xeg31dwDCPLH3uAm1umGaElbrvL5bXH6p
   U71NfIG3oMwYEE8xXuijjq3R53m1/ed+n9HJ2Xu/UD3KTrXVBneS7ns6t
   g==;
X-CSE-ConnectionGUID: 6vfQUDqvS7ufzVOjWCC7RA==
X-CSE-MsgGUID: 7nl/8RzZTneI8E7hFrWYkQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11946"; a="1546616"
X-IronPort-AV: E=Sophos;i="6.27,179,1787036400"; 
   d="scan'208";a="1546616"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 02:33:53 -0700
X-CSE-ConnectionGUID: fVvhHvtoSG2AkfgtDxVUUQ==
X-CSE-MsgGUID: OqFYijmUSTSItatMUaeiwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,179,1787036400"; 
   d="scan'208";a="4200056"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.93])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 02:31:59 -0700
Date: Mon, 26 Oct 2026 11:31:56 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: James Hilliard <james.hilliard1@gmail.com>
Cc: "Maciej W. Rozycki" <macro@orcam.me.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Raul E Rangel <rrangel@chromium.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Tony Lindgren <tony@atomide.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Richard Genoud <richard.genoud@bootlin.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Jacky Huang <ychuang3@nuvoton.com>,
	Shan-Chun Hung <schung@nuvoton.com>,
	Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
	Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Timur Tabi <timur@kernel.org>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v5 2/5] serial: serialize asynchronous write wakeups with
 the port lock
Message-ID: <at8eDFj2WNaXDaot@ashevche-desk.local>
References: <20261024-submit-serial-8250-dma-cancel-v1-v5-0-9e52968928d2@gmail.com>
 <20261024-submit-serial-8250-dma-cancel-v1-v5-2-9e52968928d2@gmail.com>
 <alpine.DEB.2.21.2610250459200.42255@angie.orcam.me.uk>
 <at4bw-G8czG-G7Wl@ashevche-desk.local>
 <CADvTj4psJcY2T1PG9H8_hJWjz62R7unj3PPgv3FrVquUMFVhGg@mail.gmail.com>
 <at5qKehogAjTa-fA@ashevche-desk.local>
 <CADvTj4qSgE6Rc--mWuqAcc8HTqN9EFOS_JM8Hp8e_=ka_ZLa6w@mail.gmail.com>
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADvTj4qSgE6Rc--mWuqAcc8HTqN9EFOS_JM8Hp8e_=ka_ZLa6w@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Oct 25, 2026 at 04:11:08PM -0600, James Hilliard wrote:
> On Sun, Oct 25, 2026 at 2:44 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Sun, Oct 25, 2026 at 02:25:46PM -0600, James Hilliard wrote:

...

> > Some people might want to test the stuff. And sending too often you actually
> > will get the opposite results, people will be tired to even start reviewing
> > and/or testing your code as it's changed way too quickly.
> 
> My thought process was that people wouldn't want to be testing code that
> had known bugs flagged in Sashiko reviews.

Sashiko reviews are not visible in my or any other mailbox. To see them I have
to go to some URL and so on, meaning to waste time to see why on the earth the
new version has been sent. It's better before addressing Sashiko comments,
reply to all people involved and to Sashiko's original email, so it will be
visible in the previous version why you issued (actually about to issue) the
next version. And before even issuing it, wait for a while, people might
disagree with Sashiko judgement or your replies on how to address that.

TL;DR: this mailing list is *not* a playground with you and Sashiko, the whole
community is behind it.

> > Settle down first
> > with something, put on the cover letter the answer why not all Sashiko's
> > comments are being addressed (for example, due to amount of patches or the
> > series being focused on a certain issue).
> 
> So, in general I've been always attempting to resolve known Sashiko issues
> in every subsequent re-spin, so that would be a bit tricky since I wouldn't be
> aware of the Sashiko issues until after the series has already been sent.
> 
> Usually the subsequent issues that get flagged are new issues only discovered
> after each new re-spin.
> 
> I do have a bunch of UART/DMA related patches that don't have flagged Sashiko
> issues so it probably makes sense to try and review those first while the larger
> series that have Sashiko flagged issues are still stabilizing.

Yes.

> > > [0] https://github.com/sashiko-dev/sashiko/pull/389

-- 
With Best Regards,
Andy Shevchenko


