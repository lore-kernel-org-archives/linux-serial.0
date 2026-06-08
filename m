Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32084322B72;
	Mon,  8 Jun 2026 11:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780918527; cv=none; b=NvbDCuK8jUEIMSXeZbJMTlZx3DLjeOutjTmaFCJdmgfR47jA6KfqMgoK/DSnT0cro4QwmrN8oUsHk1YSZTbYP4+xHbOaf88943U7bRU7o6CgnVMKSw1+x9dC3Yq7++d31UEdNt9uNxumzzqLuNW9j7E4Zkufy8mmvCmSvZLi4Ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780918527; c=relaxed/simple;
	bh=Qw8fXZ0vajUc2OiursIodvtf/o6TMPUXHTngha4cC1k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mDm65YpgsfD4nFBDyszc60EuLYiiMl3Ij/+BGcJjMMHsfmTJz3F+NUX+euJCf/yX943mjCf3urKhf1QV5mHOxgTfBTdao2nJ+TTLAtATDoDvHAuS/TmnEH4YZ7TXRnax95wUbwQXvPpkvhgnSqHPZdfLx4yyhMUYwlqc+0+M9+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XYIaQGbl; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XYIaQGbl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780918525; x=1812454525;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Qw8fXZ0vajUc2OiursIodvtf/o6TMPUXHTngha4cC1k=;
  b=XYIaQGblIQYLmXKMohK6d6RZYs9d9jjb8jZ0ED/6DZNlbrxcOHKcdr2J
   dkLWWNzHJKgUInfJdKs2NzD9A9s0H/80wDV3epJmsBz6ycoZzZQvf052J
   2S7rafYUHuAGKpg3JPbC+wJKRVo8QOBqSO6iZPUPn/6xZWdiwAdFe/oLD
   T/WSRO4iBtNMGB/BeaI+xbzFSgIKM44vJah+Z3ZBKK/GadKop/8hXxPZT
   HNYNPbDICwRv6tjtu2nqVi5V6yB/GpPB62QZxdsqiP1G8nDSYz2CsY2AV
   Rjh1+KIIlZgZBoGY/17QQfSSWaRSlR7ztUsH+XTpXvV5Fa/xW+3vCixY5
   A==;
X-CSE-ConnectionGUID: ssmqC4tGT1e2HwTR0YcxBA==
X-CSE-MsgGUID: 3wcEm8ctQ9abYffG23Go9g==
X-IronPort-AV: E=McAfee;i="6800,10657,11810"; a="93136778"
X-IronPort-AV: E=Sophos;i="6.24,194,1774335600"; 
   d="scan'208";a="93136778"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2026 04:35:25 -0700
X-CSE-ConnectionGUID: AyRP7u2nTFG1l2xi9Cue5w==
X-CSE-MsgGUID: n8VpTXe8STmTZiG3T16PFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,194,1774335600"; 
   d="scan'208";a="244672757"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.110])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2026 04:35:23 -0700
Date: Mon, 8 Jun 2026 14:35:19 +0300
From: "andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>
To: Matthias Feser <mfe@kbsgmbhfr.onmicrosoft.com>
Cc: Moteen Shah <m-shah@ti.com>,
	"linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"jirislaby@kernel.org" <jirislaby@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"k-willis@ti.com" <k-willis@ti.com>,
	"msp@baylibre.com" <msp@baylibre.com>
Subject: Re: [PATCH v5] serial: 8250_omap: clear rx_running on zero-length
 DMA completes
Message-ID: <aiao9z_rDqJlgu4G@ashevche-desk.local>
References: <BE3P281MB5515563BFB5DE5E093ADAD9DEE0E2@BE3P281MB5515.DEUP281.PROD.OUTLOOK.COM>
 <4b8c59fe-c6a1-47cb-ab3b-855b1edddde2@ti.com>
 <BE3P281MB55153573889A8124C06291F1EE0F2@BE3P281MB5515.DEUP281.PROD.OUTLOOK.COM>
 <ab76b900-6d1c-4218-a14a-59541b92f2c6@ti.com>
 <BE3P281MB5515A937D47F610974FAEFA7EE0F2@BE3P281MB5515.DEUP281.PROD.OUTLOOK.COM>
 <ede98ffc-9e34-46a5-8d8f-87894fbf9d12@ti.com>
 <BE3P281MB55155F2F5795E411F5A65282EE0B2@BE3P281MB5515.DEUP281.PROD.OUTLOOK.COM>
 <ah8i-aGuHTKcRpaA@ashevche-desk.local>
 <BE3P281MB5515D220F1679A21D35D9619EE1C2@BE3P281MB5515.DEUP281.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BE3P281MB5515D220F1679A21D35D9619EE1C2@BE3P281MB5515.DEUP281.PROD.OUTLOOK.COM>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Jun 08, 2026 at 11:00:44AM +0000, Matthias Feser wrote:
> On Tue, Jun 02, 2026, Andy Shevchenko wrote:
> > I'm wondering if this opens a window when dma->rx_buf may be
> > rewritten (or unmapped or something else) before tty layer has
> > a chance to insert bytes to its ring buffer. I.o.w. is this
> > change synchronous to other threads?
> 
> Good point.
> 
> RX DMA can be started from the DMA callback, the IRQ path, and
> runtime resume. These paths appear to be protected by the same
> driver locking.
> 
> At the point where rx_running is cleared, DMA has already been
> terminated.
> 
> So I don't see a window where rx_buf could be overwritten, but
> please let me know if there is a path where this could happen.

I don't see either, that's why I was wondering. Btw, does AI notice
anything of a such? I haven't checked Sashiko myself, others may
have also run some other AI tools for that.

-- 
With Best Regards,
Andy Shevchenko


