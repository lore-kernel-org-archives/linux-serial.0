Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.8
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793793183;
	b=XqyGmQ+fsi+X7MLozYW0epPqqO8wS66U/ErP168YxK/ccMWI0fPiTKxFlW8Wsg1ksgtV
	 nfXZ40SLFqNbmML6/oyA1la1dXH6WT+jPxbwxOxgGgvmBRIJjpoNcdeAstCD7vHU4/Vyj
	 xoUztC47wjGMfE8p9LLMDpSFqGu0f5vUTy7dY/68UEeI9XrbR8vLhCIUr39hlQi44Ib5C
	 R4N+Z7gUPNjKquLzlFHROnRP/chkCcEro8A9SVEkgi+VSGniMwLsZgDpezwedV6HGSwsN
	 S2UfcYHDe1n00cDEE4QAGbFvnrB9lk9CivHD7L3VWfB+hHyWQvzOYh1qvtezjuPlWbA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793793183;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To:
	 Organization;
	bh=OafKhfZup0pb9AMVxWuUAMn398HyLxVtsw22Ue9382Q=;
	b=Mf622e9F77FhZHQOK0ngR3lufkJxVDD/gxatVwED7CINZdkwNk6Lo/A02aTsMH+vJJJj
	 jc2bi9292BHDm3zQ/gzx6l9+lI71wIXZggOz/Ou99RT1P/qhUs1uc3ZfjAKneZ3LOaAKv
	 WYOeP8G0evrDVoyIV4191bDLQOUUXSs8JJ7KarUAXvBz/iJ/HVTofIVguHurODC9rEZuG
	 eFteEr45daUIvlm5xzgMw2+NJxCcWmAQ3SJtWO+2hpkggql6qyjf+qrugKUKl5AVN9j8y
	 zgt/v+WQfNr62/VRPIPKzO7rLv9Baf4KwjEtl7L8qncpj9OtMuHLigAK7RfbT16fi8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="KW/OpBVB";
	arc=none smtp.remote-ip=192.198.163.8
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73CBE606A31B;
	Wed,  4 Nov 2026 11:53:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 73CBE606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=KW/OpBVB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793793183; x=1825329183;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=G+7AqyJrDdzfRSDzQ6UDHvBk+LUddlp2efD50yRE/Pk=;
  b=KW/OpBVB3FoS+43H6uKwABBzXqNVzWgyG15hgt+o3/i3NMF2EGrJRNZG
   zbcofnMbnnsqwnFxZ9ehsM4N2cs8d693JbBcU71Hg0TWTNHnAug3nL14+
   2YHQAumQpRBA8Q1j4o+dkP7Mihk0P4rh9LKaGnsP2NezMFMXg805UVNLN
   hwuM/2SShhOBU/rp6fbQdbeujDKT5dksSXbQO1qSiYOCHRk6yoQKKWoY8
   QF/lIghwpQFp1k++Y2pBpV/HmpK54OfjaH20B7MWcn9kcbtDx/Pelsa02
   S9TkQWwvKJSBHeg0XmmFEy+oA6HNav7zOQiqkcCn7DROd2Qbmu0/HNjTg
   g==;
X-CSE-ConnectionGUID: D/oxNBWYQke/6G0IU8fp5Q==
X-CSE-MsgGUID: n6YblDEaSM2m4gRiu2c2oA==
X-IronPort-AV: E=McAfee;i="6800,10657,11955"; a="2430394"
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="2430394"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2026 03:53:02 -0800
X-CSE-ConnectionGUID: ArT8u6cTSDmxMjwbYfNTHA==
X-CSE-MsgGUID: vtoBEoDEQZOuxnY8UQZsYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="6719717"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.24])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2026 03:52:59 -0800
Date: Wed, 4 Nov 2026 13:52:56 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Johan Hovold <johan@kernel.org>
Cc: "Maciej W. Rozycki" <macro@orcam.me.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>,
	Crescent Hsieh <crescentcy.hsieh@moxa.com>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	John Ogness <john.ogness@linutronix.de>,
	Karl Mehltretter <kmehltretter@gmail.com>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH v3 2/2] serial: core: Don't clobber the baud rate on
 hangup via B0
Message-ID: <auscmHSl2QlHVI2z@ashevche-desk.local>
References: <alpine.DEB.2.21.2611030057510.15685@angie.orcam.me.uk>
 <alpine.DEB.2.21.2611032050590.15685@angie.orcam.me.uk>
 <ausSmrErzTXfKNGU@ashevche-desk.local>
 <ausW1pwp2eBCqVsM@hovoldconsulting.com>
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
In-Reply-To: <ausW1pwp2eBCqVsM@hovoldconsulting.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Nov 04, 2026 at 12:28:22PM +0100, Johan Hovold wrote:
> On Wed, Nov 04, 2026 at 01:10:18PM +0200, Andy Shevchenko wrote:
> > On Tue, Nov 03, 2026 at 10:07:58PM +0000, Maciej W. Rozycki wrote:

...

> > > -			baud = max(min, 9600);
> > > +			baud = (port->hup_speed ?
> > > +				port->hup_speed : max(min, 9600));
> > 
> > Outer parentheses are redundant. Also use Elvis.
> > 
> > 			baud = port->hup_speed ?: max(min, 9600);
> 
> No, don't.
> 
> Don't use the ternary operator at all as it tends to make code less
> readable.

I disagree. Elvis is readable as in Python, for example, or a simple English.
"Assign foo to baz OR bar" <——> "foo = baz ?: bar".

-- 
With Best Regards,
Andy Shevchenko


