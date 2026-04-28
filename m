Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 726643F54C7;
	Tue, 28 Apr 2026 10:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777373939; cv=none; b=i82dEWh/zNajLy3+quJNW3F2F22aasyx2EeaNKDeOaKqtFTa5izDSkrHX9hWSiUb1BgiTu/0+1CHpu7fqW3XLSXdbdsNtYWEVGAcegiM8eNRyKZ+v5ti+gYmQO2EW0hY5amMBbx63mCtvZhV8EndJ6hiZpYmm8xNK09VnrLW+/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777373939; c=relaxed/simple;
	bh=MGoeypASKD4rtePXz/VKClp1Ph4phRySb1UqKEwoHIs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QAPEdFzcy29XvB+Qns2e4QPxozk8K+DEXwFAS7pHUlNPwuwwOWvL83LvFT+MImATYfpfFUFCwra0ClAKNxChMU36K31JGZfJB06FG9CHK/QTS9g6fr0QBDB+RtZaPIaM/2J8226F/5ycpODy+uSuLhPfbqfluWfzuUKT4BI+Na8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bV2HyjaQ; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bV2HyjaQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777373939; x=1808909939;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=MGoeypASKD4rtePXz/VKClp1Ph4phRySb1UqKEwoHIs=;
  b=bV2HyjaQEqvrwmOzoUlVZ9YJ9UUBudOnPSxUY5cU/Q7FYVABgOqi7fTI
   SSIgEcl+BLQtqPiWGzXwgRGWZio/oGV5+TkCTQteOs7LYwKD1wocD3xUy
   27HMvTyV8ZxUJdy2SeTRF3gOKsvqWj8hTq2THFX1jsOFAG4EouO94C50c
   ZN/vTeI7A1UE1c8kaTWiP9uRBY0v8rgfwPjKT8WQ4nCDyu6VXw/JaZRY6
   OLygnOc3TQewGNMnCb8hLVWLsV6W3k/Iw6hgrTy4Ax2hN9Er5H0E70JUs
   PWVr3g6Xi6n6lkEXfLMAhuS7g1MUFqqWmJ2PrXg+umj0NQpwia7VcXxI0
   A==;
X-CSE-ConnectionGUID: N37+bIkIR9SozKyHPwRckg==
X-CSE-MsgGUID: wzocW7Y6QVuFMDasLI1Xbg==
X-IronPort-AV: E=McAfee;i="6800,10657,11769"; a="81883651"
X-IronPort-AV: E=Sophos;i="6.23,204,1770624000"; 
   d="scan'208";a="81883651"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2026 03:58:59 -0700
X-CSE-ConnectionGUID: +MQNRSAzTpyEIDA78i1obA==
X-CSE-MsgGUID: JyjeK03hQvy4AyL355vWuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,204,1770624000"; 
   d="scan'208";a="232914395"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.213])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2026 03:58:55 -0700
Date: Tue, 28 Apr 2026 13:58:52 +0300
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
Message-ID: <afCS7GEG7gtyC7RH@ashevche-desk.local>
References: <20260428-ultrarisc-serial-v5-0-97de63b1e3eb@ultrarisc.com>
 <20260428-ultrarisc-serial-v5-2-97de63b1e3eb@ultrarisc.com>
 <afBhkbGLsuqUitOl@ashevche-desk.local>
 <23c80500-f2c1-0eb3-f640-00f7b108059b@linux.intel.com>
 <177736726936.2886867.7725295920724488690.b4-reply@b4>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <177736726936.2886867.7725295920724488690.b4-reply@b4>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Apr 28, 2026 at 05:07:49PM +0800, Jia Wang wrote:
> On 2026-04-28 11:41 +0300, Ilpo Järvinen wrote:
> > On Tue, 28 Apr 2026, Andy Shevchenko wrote:
> > > On Tue, Apr 28, 2026 at 01:26:27PM +0800, Jia Wang wrote:

...

> > #define DW_UART_CPR_FIFO_MODE_FROM_SIZE(size)			\
> > ({								\
> > 	typeof (size) __size = size;				\
> > 								\
> > 	static_assert(IS_ALIGNED((__size), 16));		\
> > 	static_assert(__size <= DW_UART_CPR_FIFO_MODE_MAX);	\
> > 								\
> > 	FIELD_PREP_CONST(DW_UART_CPR_FIFO_MODE, __size / 16);	\
> > })
> 
> Thanks. I tried that approach, but the statement-expression form does
> not work in this case because the helper is used in static initializers.
> So I'll keep it as a plain expression macro for now, and just rework it
> into a cleaner multi-line form.

Still you can move FIELD_PREP_CONST() into it.

-- 
With Best Regards,
Andy Shevchenko


