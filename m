Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6893179CD;
	Wed, 22 Apr 2026 09:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776850995; cv=none; b=X6rES6KBPDekoHSfl2Gc6K04mqagtNkhp/by6YzcZZxGhfrW3T3AZ/OSMN3kjU4cQuZEwGGHA/guUGGeVdRGVKl36/PbXGVRuy5vwNOD5UgUjX23U1CBs8dtmo3QtPvGquvJbs9IyKapkxCwTyrZy322/fG/3l7XQp8biVT4exU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776850995; c=relaxed/simple;
	bh=NwhBpvrMjhcZ1QYHuKrPIn3Ne+/ARK1VGhWOT4LsTZc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rJY9UBJgnPheJHpNCVOBw8VD/uqhgD0/7PnHia1ZPv3H2oX6H6tQ/cU7wE6t8Y7X1bXe4Nvpq0fgU8MCIh0I3S91mrgMFZHsKLvTDZ9Y9FAASkB4c+WqJR1AKWPkV5n88gV3UC+EjopIvfXKRoQTpYLLxe+V2JMDhjZk3gRsW8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iCjC5Dgj; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iCjC5Dgj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776850995; x=1808386995;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=NwhBpvrMjhcZ1QYHuKrPIn3Ne+/ARK1VGhWOT4LsTZc=;
  b=iCjC5DgjAdaeMbqRCzDGmlYChmnUUrP2Kyn9Qh0hyBOCQFJlNthHE4+B
   j/fbDSdnhEip6b/hoIu2aTmXDZGNWPoZ/5BznX3JUwKSxlQ7890hQmn9z
   b8FjndbUw2rG2WZ+mKzRI1APO6dpCL4n9tO1pDiJ/FyR2ZYRU0nwF9Bwa
   UvGRbbEdiE2lTQXa/kRwAXI9Hr2hLMFC2jtsdj0h8VfBWTnyzMhKgpLTs
   e/mWI+mjT/ihmS0xoEiibsknNLyqOB0EzvEQ3YlXpYY+nDfDcqTA+v50y
   TMpkW7zd1d+v3kU7HlMJr+Ps3aKLiC1GEzJ1SVrk0TJu2zTNSw3o5NykM
   Q==;
X-CSE-ConnectionGUID: JKQ3LqsGQM6rN3zoU0tXkQ==
X-CSE-MsgGUID: /Xw4Tns6Qiiz+OlEb2b+Wg==
X-IronPort-AV: E=McAfee;i="6800,10657,11763"; a="95211709"
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; 
   d="scan'208";a="95211709"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2026 02:43:14 -0700
X-CSE-ConnectionGUID: bgH3XRWkQnamXjtfWhOBSw==
X-CSE-MsgGUID: wo1U15vESyCRvqZgl38CJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; 
   d="scan'208";a="232172466"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.201])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2026 02:43:10 -0700
Date: Wed, 22 Apr 2026 12:43:08 +0300
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
Message-ID: <aeiYLLXTprlzmcpF@ashevche-desk.local>
References: <20260421-ultrarisc-serial-v3-0-3d7f09c2420e@ultrarisc.com>
 <20260421-ultrarisc-serial-v3-2-3d7f09c2420e@ultrarisc.com>
 <979c9543-3ea0-25de-f97b-9c6d2fa3ac61@linux.intel.com>
 <177681947637.2697678.10937675549830278979.b4-reply@b4>
 <aeiKsv3bFPJ94InI@ashevche-desk.local>
 <aeiK-350Uozq3pVa@ashevche-desk.local>
 <177685078199.768471.14774992461649696859.b4-reply@b4>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <177685078199.768471.14774992461649696859.b4-reply@b4>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Apr 22, 2026 at 05:39:41PM +0800, Jia Wang wrote:
> On 2026-04-22 11:46 +0300, Andy Shevchenko wrote:
> > On Wed, Apr 22, 2026 at 11:45:44AM +0300, Andy Shevchenko wrote:
> > > On Wed, Apr 22, 2026 at 08:57:56AM +0800, Jia Wang wrote:

...

> > > > Just to confirm: since you mentioned that the preparatory patch moving
> > > > the DW_UART register defines is already in place, I don't need to move
> > > > them again, correct?
> > > > 
> > > > I will update my patch to use the DW_UART_CPR_* macros and
> > > > FIELD_PREP_CONST() accordingly, and I’m happy to add a separate patch in
> > > > the next revision to convert the Renesas .cpr_value as well.
> > > 
> > > My understanding that you want to send a patch series of 3 patches:
> > > - moving DW_UART_CPR_* values from C-file to h-file
> > > - modify existing Renesas case
> > 
> > - DT binding for new HW (patch 1 of this series)
> > 
> > > - add support for your HW (this patch in updated form)
> 
> Yes, I will follow this order and resend the series in v4.

Thanks, and since Ilpo mentioned, move all DW_UART_* register offsets/bitfields
to the header file (in patch 1 of a new series).

> > And I forgot that you have a DT binging one... So 4 patches after all.

-- 
With Best Regards,
Andy Shevchenko


