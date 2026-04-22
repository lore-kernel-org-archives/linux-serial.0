Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEDC735C181;
	Wed, 22 Apr 2026 08:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776847546; cv=none; b=end0i1TUZ/f3LkFixRrisFaygKTwZuS0J6UEANaDrNAa3rrxwF+KZsG9y527+WfieH81Iva2xqJqQhegIZVDf16AaeDNUKEnjP3u7hxxCTlohK83uxl+IH93ujAJBLo8uYc4UXXare05QDX6DDkLu3JVtp2rT9KKB3fCBBjvuTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776847546; c=relaxed/simple;
	bh=kAZKGbEkF2qeX8pzpvk4+B4omyz2ngu8foo9/1Gq4O0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OY3xFejrUwtsIBep0AoiSeDrqqvi0XO3OinFXGjdjcrlM7U2hiqHUjVCYbl+JwTBs5vEIarS3YEbmCLJ5UJ8iF4b87XpopiTa7BhAGkeKCbADuyV6fh/FjBhb8c/4qhnDa5VEvHXPTdbLIeR1YUxweK5r4+m9q5Mf5RTHqjAqzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T8mehlTs; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T8mehlTs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776847545; x=1808383545;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=kAZKGbEkF2qeX8pzpvk4+B4omyz2ngu8foo9/1Gq4O0=;
  b=T8mehlTsLGQFd9FI4LZ7TbstLzNqndw8DBtbwojNbVGdgDoHZkXe35no
   8ZksT19dgTlvc+DfflfHqF+HAVIIHQHoFp8BqcjWNzeswHR3NEy6u8gg3
   6Uv9J/Pmn2m8GVj3DFSRyaQiZm9VE0VPqOhIRlioEzAd14XVg3f2z62xU
   7ovQzb2aac10Ae6f6g5qvS9fe1X/yVE11LMxrWk6sC3FCJaP9qDiN5G3W
   1E5QRcZ52DsCE0TuwBtCqp517KNgx0H6MXGT+QK7uBX7jFQEICnzu6q1E
   GRTlKngxeJlso1OAI8O8+ERNTbbFSijmy1QMG+v82D2XGOptSNO89P/M1
   w==;
X-CSE-ConnectionGUID: /DFxPcO8TX6N21lkiU0JYw==
X-CSE-MsgGUID: T7de502sTqaKIEgEPd6v+Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11763"; a="77980678"
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; 
   d="scan'208";a="77980678"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2026 01:45:44 -0700
X-CSE-ConnectionGUID: Zo5CQ7RfTUyM4hs6DgTCow==
X-CSE-MsgGUID: g4Nkvgz1RXOHPSJj0XIlTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; 
   d="scan'208";a="225805165"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.201])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2026 01:45:40 -0700
Date: Wed, 22 Apr 2026 11:45:38 +0300
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
Subject: Re: [PATCH v3 2/2] serial: 8250_dw: Use a fixed CPR value for
 UltraRISC DP1000 UART
Message-ID: <aeiKsv3bFPJ94InI@ashevche-desk.local>
References: <20260421-ultrarisc-serial-v3-0-3d7f09c2420e@ultrarisc.com>
 <20260421-ultrarisc-serial-v3-2-3d7f09c2420e@ultrarisc.com>
 <979c9543-3ea0-25de-f97b-9c6d2fa3ac61@linux.intel.com>
 <177681947637.2697678.10937675549830278979.b4-reply@b4>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <177681947637.2697678.10937675549830278979.b4-reply@b4>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Apr 22, 2026 at 08:57:56AM +0800, Jia Wang wrote:
> On 2026-04-21 15:18 +0300, Ilpo Järvinen wrote:
> > On Tue, 21 Apr 2026, Jia Wang wrote:

...

> > > +static const struct dw8250_platform_data dw8250_ultrarisc_dp1000_data = {
> > > +	.usr_reg = DW_UART_USR,
> > > +	.cpr_value = 0x00022022,
> > 
> > Please construct the cpr_value by ORing DW_UART_CPR_* defines together.
> > For fields, FIELD_PREP_CONST() may be useful.
> > 
> > In order to be able to use the DW_UART_CPR_* defines, they need to be 
> > moved into 8250_dwlib.h (I'd move all DW_UART register defines in a 
> > preparatory patch).
> > 
> > I know the existing Renesas' .cpr_value doesn't follow this convention but 
> > that could be converted as well (in another patch, or leave the Renesas 
> > entry conversion to me if you don't want to do that).
> 
> Thanks for the review.
> 
> Just to confirm: since you mentioned that the preparatory patch moving
> the DW_UART register defines is already in place, I don't need to move
> them again, correct?
> 
> I will update my patch to use the DW_UART_CPR_* macros and
> FIELD_PREP_CONST() accordingly, and I’m happy to add a separate patch in
> the next revision to convert the Renesas .cpr_value as well.

My understanding that you want to send a patch series of 3 patches:
- moving DW_UART_CPR_* values from C-file to h-file
- modify existing Renesas case
- add support for your HW (this patch in updated form)

-- 
With Best Regards,
Andy Shevchenko


