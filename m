Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792485090;
	b=OZTHKBlL403CkzM5xGZKlc/B0lhAHWQ5zI4qdLnlpNNJ0vjhPgc+meOuoJh3oXQEuhGs
	 6KBBzAkD+vmW7Wiqlc4hZKRo9my+GvWRN6cfjvqveF+CFmessDvh4PqTTY10Oqm0OD9bB
	 DdULQVKTbc4GYOkDo80N9cCgk1spV2mSD6Wlfif9s0Pt2zhNX2WsGUjYBAbvS5moSIYGl
	 x4tfxrAKzolnLQ3bWUCoNvTkgQwOrjrVhcGcW46b6BhsRUFZPw0ZeIm6ibaY/z7y5Qklv
	 hEmRcT+7v66TT4xOJmV1t3RY+iFQQGGduBlLbNwQfIK4TEL/kvtPnyDvsTdfuMYqy2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792485090;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=s+1oChBSSokuHupQL3Eas8zUsbYR10ns8xAR8Q/zsUk=;
	b=jdulvYn3n2mo36iD3z8N1SHTZt00bJV2uKSv+c9vn2FFIkPCGqdiu76ZQfY1CJajyPdI
	 xse58p15fWJyd6tXfTlTvH5SvexC5s/dQ5Njt9TltaTXpW+AzYGxY2YYAOgr05fXu4xLS
	 hvdvMWESXQzkvauWxFR3aE83Lev8j3t1gzJRT8K95KpLI3sLlh9jSfqCKICGE6ejEovT+
	 Bq88QsonTgZkUaxxEAvhWIve+Pdx5Mtml+XuI83aLZw6eVe5AFIf1vND2A2OwJ/rm4B8J
	 m5EOlw4bIsle6PkMm9VlpdDW19Pt/Z4gkIPqOWZGR8Vksfy0k0VK1ZiYa2bndXLBoIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=KIZtFHFU;
	arc=none smtp.remote-ip=192.198.163.18
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B44360A2606;
	Tue, 20 Oct 2026 08:31:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2B44360A2606
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=KIZtFHFU
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792485090; x=1824021090;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZXAjazWBp88/eOGpDfVPxZYET8/clYWgR4YQVUXPHLg=;
  b=KIZtFHFU01o08O+Zkhx/xPUYV/iGvNbtkFoyBznZ2rcPaKQeFH1Y3w/z
   SjuYure56YmZ0OFIGjh+ctWy3MNpfxUHg9nes7nNgGyoJJqV5E8CAmKXi
   qPYsGvkSr1lU+XgO9sT9lF8InteT31oLgMvtW5f5C/J/cQxQV37Irl9eW
   I6dj71HcC5G42sN9YdkWQoUsOi4mWMZ0mSiM+sCyawJRi3tl45MtKJfhM
   MLG8AhBVFwZTA4wx6biYZQv8pe9S6T8DHjkJXSjGpahXPSmPAPRFuPDnF
   JYfP+obSOT6Hxi/P7LJ9dOLnVzShdScunVwZoDkregLpvm6InSxDNR77f
   g==;
X-CSE-ConnectionGUID: IoP0EOCoRNeCcq2Nhg2MCw==
X-CSE-MsgGUID: F7irHwbWQrC3ua35ZvIBxw==
X-IronPort-AV: E=McAfee;i="6800,10657,11940"; a="1209387"
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="1209387"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 01:31:29 -0700
X-CSE-ConnectionGUID: GkX5RfzGSyakXA5bt9nYFw==
X-CSE-MsgGUID: vTIs+iXPRM6JRkmHX8MA2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="3161125"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.72])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 01:31:26 -0700
Date: Tue, 20 Oct 2026 11:31:23 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jiri Slaby <jirislaby@kernel.org>
Cc: Vinicius Pedrosa <vinicius.eduardo.pedrosa@gmail.com>,
	linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	ilpo.jarvinen@linux.intel.com, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev,
	Andre Przywara <andre.przywara@arm.com>,
	Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Enzo Adriano <enzo.adriano.code@gmail.com>
Subject: Re: [PATCH v2 2/4] serial: 8250_dw: Only accept a contiguous DLF
 readback
Message-ID: <atcm2zqDs1P_EDr0@ashevche-desk.local>
References: <cover.1792439398.git.vinicius.eduardo.pedrosa@gmail.com>
 <a79114e72d029732db6764935dde12aa5d497706.1792439398.git.vinicius.eduardo.pedrosa@gmail.com>
 <d992e18d-31ab-4937-8780-9c9dc423082a@kernel.org>
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
In-Reply-To: <d992e18d-31ab-4937-8780-9c9dc423082a@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Oct 20, 2026 at 08:11:06AM +0200, Jiri Slaby wrote:
> On 19. 10. 26, 22:06, Vinicius Pedrosa wrote:

...

> > -	if (reg) {
> > +	/*
> > +	 * DLF is a bit field starting at bit 0, so a real one reads back as
> > +	 * 2^n - 1. Any other value means this offset is something else.
> > +	 */
> > +	if (reg && !(reg & (reg + 1))) {
> 
> Do I understand correctly, that this equivalent to:
>   if (is_power_of_2(reg + 1))
> ?

Yes, and since we check for reg to be "not zero", this will work the rest.

-- 
With Best Regards,
Andy Shevchenko


