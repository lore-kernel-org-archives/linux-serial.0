Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29CB03FC5B7;
	Fri, 18 Sep 2026 09:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789724508; cv=none; b=eX2NBKWSX59pi3F6dzXpK2LEwuRNTbIFdPqRa1XbUBteP+XdhegEzpdnQvSpeLtrg9X0vq7p4ZAiR/XROO1eRDEjpGzfMgc1Lh4UlyFxefshL/D1G0b+24hFIlbnoznwya3kBCFvkpzibaZ7t7xTHlE50sra6LbhJr1RoftxwBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789724508; c=relaxed/simple;
	bh=NdtJRaDGbY7hMtqbi401f0ZdRPXIAcaHSgKiwXmJr98=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=djSpyPMbnYhgLTTb7GmqNaQz/f/dGINPgEhv5nGUCVMCnBvynn8UJGip4UXcRQnGCkbdeY27vv4b9iK3EIIDZhpbbK4wEMRPkwsBtmjgZXnJEB1AaFydmHhih9zfLsBW3X0RwO2XrmnFCSIlF28tC4aH9gn2cSqR5C4+EVVWhas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b2q3HQui; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b2q3HQui"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789724505; x=1821260505;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NdtJRaDGbY7hMtqbi401f0ZdRPXIAcaHSgKiwXmJr98=;
  b=b2q3HQui1+dGcn+CHJND7aHKSZlIiuVXVDxsj3+a0w5o2LlRnmC/FpSj
   Tabt9PK4Rsj63FCO1AEO+p3OiX4HG0a3gesPFCJw0OkzfG8aG5u72VIxK
   ZVLW12qiW5mrA27fdO0mqSPnD8XI8iLka700TC+lRo55KTp3Du0lhkeSi
   btxjbSgaDglBBK9WY7Hd+okCn3G7bOiVN8MBWm4gzR062+fuvLzyNrB/s
   Xe9kVa3kjRU5fBMA/szp3NHIAEAkfDHiLQtAo1oJLhRTLMQcz3V4N+nHJ
   KDqYvTJTuvpeqP+Ke2GCa7tvAuOQ+CtYHncrzkI+RpMYIQi40xPwNmGN/
   Q==;
X-CSE-ConnectionGUID: QRxqkaM+QvCXYoPCkyIdOg==
X-CSE-MsgGUID: Ug7QXzuPQTKETOsIaRAQdA==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="90349578"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="90349578"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2026 02:41:44 -0700
X-CSE-ConnectionGUID: Bj1UG52SQ/mpwKd7nSV5rQ==
X-CSE-MsgGUID: BbzNYCtOQk+Y4TZjJOckRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="2508382"
Received: from carterle-desk.ger.corp.intel.com (HELO localhost) ([10.245.245.170])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2026 02:41:42 -0700
Date: Fri, 18 Sep 2026 12:41:39 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Malathi A <malathi.a2000@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] serial: 8250_uniphier: Use dev_err_probe() in probe
 error paths
Message-ID: <aq0HU0ydof9GLp4_@ashevche-desk.local>
References: <20260918074546.245342-1-malathi.a2000@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260918074546.245342-1-malathi.a2000@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Sep 18, 2026 at 07:45:46AM +0000, Malathi A wrote:
> devm_clk_get_enabled() returns -EPROBE_DEFER while the clock provider is
> not registered yet, and uniphier_uart_probe() reports that with
> dev_err(). Every retry of an intermittently deferred probe therefore
> prints "failed to get and enable clock" at error level, which is only
> dmesg noise.
> 
> Use dev_err_probe() instead: it demotes -EPROBE_DEFER to dev_dbg() and
> records the reason for /sys/kernel/debug/devices_deferred. Convert the
> other two error messages in probe as well, so the whole function follows
> the "return dev_err_probe()" pattern already used by other 8250 drivers
> such as 8250_em.c. Those two codes are never -EPROBE_DEFER, so there the
> conversion is a readability change only.
> 
> Errors other than a deferral are still logged at error level, now with
> the error code added by the helper. No functional change otherwise.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko


