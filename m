Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.10
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793180415;
	b=LVX0I8LBETAPRDdyn2jyF2Zb26HXllRaC/GbrJkCbi4HFtL/Teb+pgJITGXz0N1L66UA
	 mgoCCITy304Bk1yq0Aijn/ctOXk+8W8x+BEAW7+xTYIbTdhpzt6tQN+e+sKTNGWcQYrQl
	 97udgKBaFzIzwUfmYT1lHVKU3zpv2GGjZ30wsr2Z4YqL3iHSqYQSzNNbsxNvMDXzXqHmB
	 2CAf47xVjMhg5AmfRdItXe4dKAWxTFRGT5eKF7T3wWcD469+B5IVq/5MsNufgDNbEqOx6
	 /ZUU10LEt2QqyFUGP+Ml8RJeq6ODaFYsuQVQNWDhI+K3Hu2Ni4aUEdctJUGMD2ANmQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793180415;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=Yr7vo+fVBon7I3trLOUfnB9wqi3Kp5C3SbSgaKixCUs=;
	b=Z6OD/qGxBigDSAkDN0bZnff9AJL1N1NjAcCYN2LKQgq9ZJ3Iq3rx2N2wfUsuOdT//Kzn
	 LKfRyHY87zlJ+b9vb4I5ozAqcX8DQ6cj6wVzqMEQbE0q+4yLyGT1VPni0xHy4afVl5ytE
	 RuXjwce0mQpCdMSxLk9AQoG6pxKLD41VgkEPxAkr0sU0Hd2p4NrsJebpGUoibrML4hrcN
	 2OGG+RKPyIXiLQzqVpLRaNrSSeu7QqqTb+ajlzfMAp84Jk1DvEvtf8JOfYp4S8VS1clbs
	 mOblfYpgZIWlQZ1rwRiqFuy1X9q+nEK1ECs8ajhI6MbzQdGhzdLkyfa2qUC3bCOfLBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=fLLRjBZ+;
	arc=none smtp.remote-ip=198.175.65.10
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBCDB606A31C;
	Wed, 28 Oct 2026 09:40:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BBCDB606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=fLLRjBZ+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793180415; x=1824716415;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EmTJDFG1OVFNRYcrPeKwvBgsRAc5MJM+e8SIzVNVGsA=;
  b=fLLRjBZ+p0MHtXpXliHf40fJ0R0RThQmoXTWywRa+U8/kfjXVnoBi26f
   LvOFXco6Dhetfj+lCy5MEs0QIdRHdplfppple/O+ppUFp346u1e/HoneJ
   zDS3GB4GtTLj1Cx84hSGRjnDicJy3x4td4J4pi+N9LsAjhNjDtqwyygDh
   cr2Xz2tlmugb2/N2AZgKYxcnL71d8ii7cgmlwVgEnwGZJuMKGbPu/pDAH
   5Flf+ARICNQb0KTPSSfsRsQe9uxvUoJgUw2eEs64Yj8Vp+f57yl85A/F2
   wT7AibM8LXEnYjkgCCgHgLj4aQcmrEtgM1k/782l1GAYCeqMnnjDkASTe
   w==;
X-CSE-ConnectionGUID: nDN/X3DDQnepA/k7HzrhEA==
X-CSE-MsgGUID: IbwGsGjDRti/MWCTCK/iag==
X-IronPort-AV: E=McAfee;i="6800,10657,11948"; a="1788423"
X-IronPort-AV: E=Sophos;i="6.27,182,1787036400"; 
   d="scan'208";a="1788423"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2026 02:40:14 -0700
X-CSE-ConnectionGUID: PKQU2Xj1T3m4vmaxgjChxw==
X-CSE-MsgGUID: hrIrWirVSpeNIiBVTI7E7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,182,1787036400"; 
   d="scan'208";a="4805839"
Received: from abityuts-desk1.ger.corp.intel.com (HELO localhost) ([10.245.244.117])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2026 02:40:10 -0700
Date: Wed, 28 Oct 2026 11:40:07 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: James Hilliard <james.hilliard1@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH v4 1/5] serial: 8250_dw: select port setup through
 platform data
Message-ID: <auHC9-louZoF5Nlk@ashevche-desk.local>
References: <20261027-submit-h616-uart-fifo-v1-v4-0-d37e018fd0a6@gmail.com>
 <20261027-submit-h616-uart-fifo-v1-v4-1-d37e018fd0a6@gmail.com>
 <auG4rIHPQZXKOd6j@ashevche-desk.local>
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <auG4rIHPQZXKOd6j@ashevche-desk.local>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Oct 28, 2026 at 10:56:20AM +0200, Andy Shevchenko wrote:
> On Tue, Oct 27, 2026 at 05:05:29PM -0600, James Hilliard wrote:

...

> > +	if (!IS_ENABLED(CONFIG_64BIT))
> > +		dw8250_setup_port(p);
> 
> I believe the Cavium OCTEON  is 64-bit only platform, so you can just drop this
> conditional altogether.

Yes, confirmed. The only single ifdef is required when we use __raw_readq().
The second can be dropped. I will send a patch for that.

-- 
With Best Regards,
Andy Shevchenko


