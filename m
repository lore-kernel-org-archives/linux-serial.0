Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0492121A447;
	Fri, 24 Apr 2026 15:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777043796; cv=none; b=QXEKmwRGPtWDDdWpUjtO9jGeTCAgBXLdZfAzeO3iLpZtHuk7FB1ZtvI3mXW8fP9SDn6fxtT8pS71Th+zFwZL/VR6TjjXXpO4BGiyvCfHK9O4zdKw7CSI34ORXLlsbugPq5HDl5yGUiKshqIQkfJO9h9WKkUAUI97wXXX8v1nqBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777043796; c=relaxed/simple;
	bh=IChu/uXn2KIrqkBTPczQ+N31CwRbH1SiSkO5kUF/m3g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZD1N6wTFo4ttbpk9lupZbgs6FVGuFqMbV6S5gECjLMsjnyAabmFF6H3g8TpbkpgFD1hHyxx13yw/HaeKJDE3fQG3jphlfXumTloO4lqLVQ5hEn+AO8V9u7GUyNX0mKZEVEmrSimVwHk9ADmy5rXhQd6P7HiFiOUR873PrxeVeiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VEJKU/5c; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VEJKU/5c"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777043795; x=1808579795;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=IChu/uXn2KIrqkBTPczQ+N31CwRbH1SiSkO5kUF/m3g=;
  b=VEJKU/5cMmuLULKgsDwdeaDE5nED2tE/tdHskIz8YLRVlxlGx3f4L6hW
   9UEc4jFSRPbTu15YhzRB4K58PqtRbvefski661ODOLkIQ0dxZsySSwpk8
   eptBCTZryVeeJ4AEzJLBFReIyBLmL8N9uhfNDcE29M+1a1VUjluCLxbna
   k+Fj9uffHOaZPurd3qmxwuItuEqTW2EU++JRp7xVq9f6oD3KNXfBBWyHZ
   NsOhVAxwOaGUQ8+K+B8mfRG/iofke0917KRpu9YIyLLJc+G5s33oRdJPT
   1TqLyPilAeIQ3h1bIp921Bc2oi7QLUPMJC89ozzsh7x7MPka75L+KHej6
   Q==;
X-CSE-ConnectionGUID: IsJo7p+rQni+E8Fu/VekFA==
X-CSE-MsgGUID: YGDdPI29TCuT475+t0f53A==
X-IronPort-AV: E=McAfee;i="6800,10657,11766"; a="100678667"
X-IronPort-AV: E=Sophos;i="6.23,196,1770624000"; 
   d="scan'208";a="100678667"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2026 08:16:34 -0700
X-CSE-ConnectionGUID: Yvpr7tkGRTWVSuqnQ105Rw==
X-CSE-MsgGUID: M2VX0kIvSmqcW43HYmcNyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,196,1770624000"; 
   d="scan'208";a="226448405"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.71])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2026 08:16:31 -0700
Date: Fri, 24 Apr 2026 18:16:28 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Jia Wang <wangjia@ultrarisc.com>,
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
Subject: Re: [PATCH v4 2/4] serial: 8250_dw: build Renesas RZN1 CPR value
 from DW_UART_CPR_* definitions
Message-ID: <aeuJTMqADw8J0x0u@ashevche-desk.local>
References: <20260424-ultrarisc-serial-v4-0-1765a0b4c4a0@ultrarisc.com>
 <20260424-ultrarisc-serial-v4-2-1765a0b4c4a0@ultrarisc.com>
 <4548483c-cbba-899e-6b1a-1290d36b59cd@linux.intel.com>
 <aetv2ljDOpH_Hs4s@ashevche-desk.local>
 <363a636d-f014-cc29-6be4-ec3041f43855@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <363a636d-f014-cc29-6be4-ec3041f43855@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Apr 24, 2026 at 05:09:46PM +0300, Ilpo Järvinen wrote:
> On Fri, 24 Apr 2026, Andy Shevchenko wrote:
> > On Fri, Apr 24, 2026 at 02:38:56PM +0300, Ilpo Järvinen wrote:
> > > On Fri, 24 Apr 2026, Jia Wang wrote:

...

> > > Hmm, maybe there should also be macro also for this one which takes the 
> > > fifosize as input and converts it to CPR field vlaue (effectively, the 
> > > macro is an inverse of DW_UART_CPR_FIFO_SIZE()). It would be more readable 
> > > than the literal.
> > 
> > But this can be done separately, right?
> 
> It's logically part of the cpr_value literal to defines conversion (of 
> course one could introduce it in own patch without users but I don't see 
> much benefit from that).

No objections.

> > > Also include BUILD_BUG_ON(!IS_ALIGNED(fifosize, 16) + bounds checks) 
> > > inside that macro to catch invalid fifo sizes (+ don't forget the 
> > > necessary headers for those two new things).
> > 
> > Hmm... Some devices may have FIFO = 8 or 4 bytes (Intel Quark IIRC has less
> > than 16 and it's DW IP).
> 
> Perhaps but according the DW databook I've at hand, there are no values in 
> FIFO_MODE field for such FIFO sizes. So what would CPR contain in those
> cases for FIFO_MODE field?

On real HW it returns 0s for all registers above 0x07 (multiplied by 4 as
a stride). But I also checked the values of xmit_fifo_size and it shows 16.
What 8 is it is the DMA max_burst. Hence the proposed assertion should work.

-- 
With Best Regards,
Andy Shevchenko


