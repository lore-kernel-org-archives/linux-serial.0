Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D082F3B9D9F;
	Wed, 29 Apr 2026 09:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777453540; cv=none; b=gWN42vCNY6Qr52DEciPBGP3yyM0e9MF+X4jdifbEOdEboyvkETVNE+DELsVBPiZO9myP4XFqvBOxT1iFStsNWm5Ity7lF7nmnusTF/Cwkln+LM5q68s20y14vpqDE+Phws4I1Kvkm3cJ+LkN9v7JsOq8qSRXixhx2H8r5dlnk5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777453540; c=relaxed/simple;
	bh=1hxYCiayBlxyU/sHOL5JNJjVec/HYOBaNVT0PyswTsY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gNkyNslrhy/mFoeIR1RnogYuvGRghiL4Fvjz/IVG2zEdH4ciYWnXjc9y0Lew/Dyl0qxhaFFhkxKD5NQDJ5mo327ZsI+jmqL2YXhvgyx5MZqONCKc5BBN5AMHFFtgMGvh0gvNfpQdVvf58/7L+aUYsYx+R07X1GHcnrVdYEPmhj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hvc7elpg; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hvc7elpg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777453539; x=1808989539;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=1hxYCiayBlxyU/sHOL5JNJjVec/HYOBaNVT0PyswTsY=;
  b=hvc7elpgxIqMjNz+DeWzJlgEf2LvaJh2Qp3RBe7dSvEev95xhtZ7p2vJ
   s5jjIqajDqmpY6yGJ0R8TjZdRNk3R0+0Su3lfYPT2WeEFm+T2mLQK12mj
   z51plgMr//3PXPGWVoK+YQN8w/Hz4udeZdAEDDwMGcKk8uKJ55ZqXVtmH
   2R3VKyiN9IUu1ZUo7BpG4UdHsXhgrQoQhvsp70O161IPzPS3fVvkPHMbq
   PUmCvQ244YiAwnTmuHdVFpuNNW4a04LCw1kaKEzvZU5vC/hqWvMUsa7RC
   7lHwUThIJkZ01f07Xl1Fz24IxyfkaFRNEzjHsI1xIG2hvlaDN3O6wrSZK
   g==;
X-CSE-ConnectionGUID: 233sDmciSemBTfMHOKcvPQ==
X-CSE-MsgGUID: uzpZyJjhRuiJMsE6eX9pVQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11770"; a="88975639"
X-IronPort-AV: E=Sophos;i="6.23,205,1770624000"; 
   d="scan'208";a="88975639"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 02:05:38 -0700
X-CSE-ConnectionGUID: UEKWoQTOS4SMxFcTkePYlw==
X-CSE-MsgGUID: hxUwmqDhRbaVY3Ybs6Knpg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,205,1770624000"; 
   d="scan'208";a="234080178"
Received: from ettammin-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.141])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 02:05:35 -0700
Date: Wed, 29 Apr 2026 12:05:32 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jia Wang <wangjia@ultrarisc.com>
Cc: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-serial <linux-serial@vger.kernel.org>,
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v5 2/4] serial: 8250_dw: build Renesas RZN1 CPR value
 from DW_UART_CPR_* definitions
Message-ID: <afHJ3DArX34FQMuY@ashevche-desk.local>
References: <20260428-ultrarisc-serial-v5-0-97de63b1e3eb@ultrarisc.com>
 <20260428-ultrarisc-serial-v5-2-97de63b1e3eb@ultrarisc.com>
 <afBhkbGLsuqUitOl@ashevche-desk.local>
 <23c80500-f2c1-0eb3-f640-00f7b108059b@linux.intel.com>
 <177736726936.2886867.7725295920724488690.b4-reply@b4>
 <afCS7GEG7gtyC7RH@ashevche-desk.local>
 <177742420562.3222151.9689419292413018986.b4-reply@b4>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <177742420562.3222151.9689419292413018986.b4-reply@b4>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Apr 29, 2026 at 08:56:45AM +0800, Jia Wang wrote:
> On 2026-04-28 13:58 +0300, Andy Shevchenko wrote:
> > On Tue, Apr 28, 2026 at 05:07:49PM +0800, Jia Wang wrote:
> > > On 2026-04-28 11:41 +0300, Ilpo Järvinen wrote:

...

> > > Thanks. I tried that approach, but the statement-expression form does
> > > not work in this case because the helper is used in static initializers.
> > > So I'll keep it as a plain expression macro for now, and just rework it
> > > into a cleaner multi-line form.
> > 
> > Still you can move FIELD_PREP_CONST() into it.
> 
> Right, I'll move FIELD_PREP_CONST() in. By the way, does your Reviewed-by
> still hold?

Not for this patch, as it seems we get too many modifications and discussions
around. Let have a fresh look in v6 (the rest of the patches are okay, please
keep tags there).

-- 
With Best Regards,
Andy Shevchenko


