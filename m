Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6BB2476CF6;
	Tue, 18 Aug 2026 13:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787059153; cv=none; b=bBZldqYP/RaQ41HILqaXjWGtdBakPX4ITxTLAA3HOg8SspkXFEth8XRUxNZZ63tS/0SxV2+TDU31EveYRNNOILL7d2qhAXY3G4P6Ju+5cj6qDk6SQkz6cmLGCVlOJOkuD44SlVBleofAHP832/DOLtWLP00A/iz30qAsXVvG1+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787059153; c=relaxed/simple;
	bh=7o0bCXJ3zFgyZjYiBn2RoQM0YeoWFCE+GM2ErpipPuw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DKUOPrPJYLTQMH8Mmqe+xJoCx4d3ijGLqLOC7h7sok7DGVO15Tnx1Gp9a1vDpZMBI3A11PtaMqxKBGh4ATvckAgUgZgFvWjTaQX99vHlslXTrWyj43wvZGo7xVT3qRsnylUO7jjoyPcmVOETpl2o8bhlFzV1uoRypz4sMbpTrvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VlSqdKXG; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VlSqdKXG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787059152; x=1818595152;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7o0bCXJ3zFgyZjYiBn2RoQM0YeoWFCE+GM2ErpipPuw=;
  b=VlSqdKXG22F/yRPhg6iSEXz5BRzhTHInydkPcUsUfR+E87u6Z16EIwd9
   mLmXYPh9gUWDlejNOS1KTMnqjNMq0jztx2tlHicSPWoFibfSfH9Y2RKzI
   g0JB1xEcnhYXEKOE5j5RMOhfGybwH4I+2/N0V6BZXGyhWK0YTMY3PZ4xp
   lSKBLin2POOEiZSfnPN8VWnJ8JbOeM7U+/Gx253cvriQ4BbSvFR5YuWdB
   9lUC5wk1EBPl6TiOt8x/MnToMlTRwkh8reHMFmW77PBOa5Tq25B0eYtn5
   Tmkf4kWhPHa5lwdll8u36TCUCAip/SZiS/aD4car9MmK8JCvXUh228jzm
   g==;
X-CSE-ConnectionGUID: 292mbCb7Qj2K5fD9R/ngug==
X-CSE-MsgGUID: meCC1I4cTWaM8kwxBqYvYQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11878"; a="97887967"
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; 
   d="scan'208";a="97887967"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2026 06:19:11 -0700
X-CSE-ConnectionGUID: S73CqSpkSbaKvw4BsJSCkA==
X-CSE-MsgGUID: aYSC+sRUQDeGlPJMh2/VWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; 
   d="scan'208";a="263894223"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.209])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2026 06:19:09 -0700
Date: Tue, 18 Aug 2026 16:19:06 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Linmao Li <lilinmao@kylinos.cn>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Crescent Hsieh <crescentcy.hsieh@moxa.com>,
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] serial: 8250_mxpcie: fail the probe when a port
 cannot be registered
Message-ID: <aoRbyv7V4mdTG5cy@ashevche-desk.local>
References: <20260818093918.3190686-1-lilinmao@kylinos.cn>
 <20260818093918.3190686-3-lilinmao@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260818093918.3190686-3-lilinmao@kylinos.cn>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Aug 18, 2026 at 05:39:17PM +0800, Linmao Li wrote:
> When serial8250_register_8250_port() fails the loop only breaks out and
> the probe still returns success.  The entries it did not reach keep the
> zero devm_kzalloc() left there, and the entry that failed keeps a
> negative error code.
> 
> mxpcie8250_remove() then feeds all of them to
> serial8250_unregister_port(), which checks neither: line 0 unregisters a
> port this driver does not own, and the negative line indexes
> serial8250_ports[] out of bounds.
> 
> Fail the probe instead, unregistering the ports registered so far.

This is behavioural difference. Before it was "register as much ports as we
can", now "don't register even a single one". If one of those UARTs worked in
the previous case for whatever reason, this patch will break that.

-- 
With Best Regards,
Andy Shevchenko


