Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84FC91A6839;
	Fri, 25 Sep 2026 13:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790343474; cv=none; b=beUViK2f7TrjkgQ9gSKR0IHAE2JTpIG7q0Lu66M9vTS5zbwqBUoGq80BaocbcA6ZR+fPCLqBUAhXDoGr4xWn6NUlMTfazQmRb4EscFLjxyam0RCW9UHkojXxvdJr0W5u+PYYfqp+aHE94u6Ye2ElDSPuZZRu+MWvzcj1AO4dUTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790343474; c=relaxed/simple;
	bh=no8+looG0WsomoDxrT8Jj4yE0i92R+oAVoUxuTXdUlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YQf9MJdsyDQ4ht/PpOcDAwqE6iSoH3yAVrekpSulrn9tTFustyVXlFygATUOTvR7IZCgWhRScudLO75vX7cYn7RMuyZZZDY4czb0TH+Xnpz3nnHX+p9+0f11ugaquSbj+5b6B4uQH5P8uTNiTVGPsmJnIKg+YQw3IYQXlALh3ZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F0OvQzGw; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F0OvQzGw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790343472; x=1821879472;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=no8+looG0WsomoDxrT8Jj4yE0i92R+oAVoUxuTXdUlw=;
  b=F0OvQzGwZmhDXInV55FOvDCtl8wYPALwTgi4IpHux++AnWjmllkulSXg
   jIdCNjp2HUoMCZRpL2N8oJ+qLFCu7ukY5Qsy/8TqvpBRa0DOEJ5NFM9wU
   zLrfsD8RD0OipHSFfh+8g4gGyHokyx0E8roKvMc6gy27/2lUVzTRKNK9b
   7J7udgbucVspTyM403ORW4MZieVg+rQpQI/MdfcFTMMqGpJh6vyNwiTV1
   G5lmFJyvhyGAay+cWvGx0sTMDRzO3cHfckfy8wAcge1vDtqRk+wEuIDn4
   icurDRtYBhmZwJ1Lk/IuFHOBJ9p6AbGUzAoPkw9p5o3//n74eUI/9jMCu
   w==;
X-CSE-ConnectionGUID: yEg6YvExTv2dPf/36J5aIA==
X-CSE-MsgGUID: 6tNG9tvDTWeWY5VkMt7i1w==
X-IronPort-AV: E=McAfee;i="6800,10657,11915"; a="101300675"
X-IronPort-AV: E=Sophos;i="6.27,122,1787036400"; 
   d="scan'208";a="101300675"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2026 06:37:52 -0700
X-CSE-ConnectionGUID: LTl/mEoASz21F6/05k7vHw==
X-CSE-MsgGUID: QXWscqDORNukc7p06SItzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,122,1787036400"; 
   d="scan'208";a="279042879"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.27])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2026 06:37:50 -0700
Date: Fri, 25 Sep 2026 16:37:47 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc: Malathi A <malathi.a2000@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] serial: 8250_uniphier: Use devm_clk_get_enabled()
Message-ID: <arZ5KxIp55qA6UA7@ashevche-desk.local>
References: <20260917040511.103232-1-malathi.a2000@gmail.com>
 <97e4ab26-b147-4cf4-97f9-307903f14e61@socionext.com>
 <arUvJyvChXXcasSu@ashevche-desk.local>
 <3ea1f574-ddb5-46a6-9bc1-7a8ea84c54bd@socionext.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ea1f574-ddb5-46a6-9bc1-7a8ea84c54bd@socionext.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Sep 25, 2026 at 08:32:20PM +0900, Kunihiko Hayashi wrote:
> On 2026/09/24 23:09, Andy Shevchenko wrote:
> > On Thu, Sep 24, 2026 at 06:07:37PM +0900, Kunihiko Hayashi wrote:
> > > On 2026/09/17 13:05, Malathi A wrote:

...

> > > I'm a bit concerned about the error path in uniphier_uart_resume().
> > > The clock may have been disabled in uniphier_uart_suspend(), and
> > > clk_prepare_enable() can fail when trying to enable it again.
> > > 
> > > In that case, wouldn't devres try to disable an already disabled
> > > clock on detach?
> > 
> > Isn't there is a guarantee that the .remove() is called with PM runtime on

After reading a code of driver core I see that this is the opposite actually.
The PM runtime might be off.

> > and get, meaning it's called with the enabled clock? But if not the case,
> > we might use PM runtime force operations (resume and suspend in the
> > respective cases.
> 
> My concern was just the case where clk_prepare_enable() in the system
> resume callback fails, leaving the clock disabled before devres cleanup.
> 
> This driver currently only uses SET_SYSTEM_SLEEP_PM_OPS(), so I wasn't
> considering runtime PM here.

So, in such a case how do you see the scenario when system is resumed (Right?
Otherwise we can't do anything, like detaching driver from the device.) and
clock is disabled?

> I don't have a strong opinion on whether runtime PM should be involved,
> but if it guarantees that the clock is enabled before .remove(),
> that would address my concern.

-- 
With Best Regards,
Andy Shevchenko


