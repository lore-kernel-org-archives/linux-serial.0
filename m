Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C051D534
	for <linux-serial@vger.kernel.org>; Thu, 11 Apr 2024 14:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712847217; cv=none; b=jEPHKmDsxHwXVvSspvArCiMsO/uWXJgEltHARkZZbKQdeZyesBXCz4S/HRh6qQjERu4lpL1tARZnsLZpmDNfbOqNLHOZTow4BRAkYe3Wo1NIdjp+71mFEYoI3Sag3D6AsZecQ1lf44lsG3MmD8zKlMwEUCCp5iNv6SR4dSkVwsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712847217; c=relaxed/simple;
	bh=ZpHSd37phWC8OBSuiKJwJvzQ6fOrCaYaa0oNtpIRLfo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XzKCvcENxYUpHfav/C9Q4BwJlRdQXjhBvS1Ku0QTUXH9WUgZ+bz86kAzRrABPnJuSiiMbXBLhJUZLK9dLJ/YL701nQR03b3SOdTxr9FXHLhWP2AAGYvsfnoDy7rZQOwtbKnTwOmANwI3OkG5k4yF9XgOEXZ7Qvg2PBfVcgJZVtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fgSGCrKR; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fgSGCrKR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712847217; x=1744383217;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZpHSd37phWC8OBSuiKJwJvzQ6fOrCaYaa0oNtpIRLfo=;
  b=fgSGCrKRbq05YAgQlVRHrbjn/GN4FAsBov0GiwChF91FlMAaB3h2+0RU
   e9BFZC9E8JDgvvZG0P3inr6ikXOIvT/GATvvGT+mbC3K5e5BFwUgeS/zD
   77i9FxxrlxvBdrKtZ1QuTTGD1fuW1jyWp7iJ/4itNK6nipTWunZgkBaTn
   1u0VWSSMCxOBrPr0j50LWOvJJwQrJhsXGkX5aBNWkNI3co18X2TKWmlNW
   QulAZvDRC9GIFcXdH9LjZoJJofkA9mdM4CZwZgirW5MrT8KpJVdpQUAgl
   bx8zFERoyOj8mzPj//sGRmJyOJfVwJf3djfWhJ/an6d8R45JGKGimgeHA
   g==;
X-CSE-ConnectionGUID: hpVAQCqJR3uvhoK1DqA/fw==
X-CSE-MsgGUID: dIBgmiQXQjCBAjNZTBDN/A==
X-IronPort-AV: E=McAfee;i="6600,9927,11041"; a="12050052"
X-IronPort-AV: E=Sophos;i="6.07,193,1708416000"; 
   d="scan'208";a="12050052"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2024 07:53:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11041"; a="915465142"
X-IronPort-AV: E=Sophos;i="6.07,193,1708416000"; 
   d="scan'208";a="915465142"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2024 07:53:31 -0700
Received: from andy by smile with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1ruvns-00000003Nu2-2qx7;
	Thu, 11 Apr 2024 17:53:28 +0300
Date: Thu, 11 Apr 2024 17:53:28 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Tony Lindgren <tony@atomide.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org
Subject: Re: [PATCH] serial: core: Fix missing shutdown and startup for
 serial base port
Message-ID: <Zhf5aHnL5mGapB1J@smile.fi.intel.com>
References: <20240411055848.38190-1-tony@atomide.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240411055848.38190-1-tony@atomide.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Apr 11, 2024 at 08:58:45AM +0300, Tony Lindgren wrote:
> We are seeing start_tx being called after port shutdown as noted by Jiri.
> This happens because we are missing the startup and shutdown related
> functions for the serial base port.
> 
> Let's fix the issue by adding startup and shutdown functions for the
> serial base port to block tx flushing for the serial base port when the
> port is not in use.

I tried to test this on the current max3100.c driver, but this doesn't change
anything to me. The scenario is that:

- load the driver with dyndbg on
- attach device (I have done it via SSDT overlay)
- call `stty -F /dev/ttyMAX0` to see it works
- call `stty -F /dev/ttyMAX0 115200` to setup speed
- test case:
  a) run `cat /proc/interrupts > /dev/ttyMAX0`
  b) press Ctrl + C
  c) (most cases) press Ctrl + C
- repeat the previous step several times

The outcome (with or without this change) is that
- it repeatedly calls start_tx()
- most of the times as you may notice it requires actually to press
  Ctrl + C _twice to stop the queueing

The testing environment is the tty-next + this patch.

I admit that max3100 may be buggy, but this change doesn't fix anything for it.

-- 
With Best Regards,
Andy Shevchenko


