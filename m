Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 202262745B;
	Fri,  6 Sep 2024 12:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725626817; cv=none; b=CS3vbSR/w6kYPBARYTU6ySqHjKETenR8wuGBzv8//wnWoXg+g18Xn8Spu8gU92ExLPMeLbuxKjNUJvWnUu+U7hcSHPjaV49e/EBcNrzBcAw3/I4BT3RTYKxqueV9O0RY3DCfk7Zh5TOwsWFGb13qgqMK82RN5vH3TXUoGOnDkwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725626817; c=relaxed/simple;
	bh=/XZTcQNtG+IZxyO6e2tb51gbAtM2zivjLfErdoGLLDs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tTP4UdO9VdqXa6Ct5lBAd1kpBIaBe0mTrGLRLAUjak6eXYMrlKWz0cMHQynzMhrD8afxkIMqv2T50TXOFcjdcA/ckACCDMsrPrihKF62KltF/k8FG2i+2s0DfBazJdJmDNAnUmrIdOd/ba2cXfSPlEurp1zeaaag8EjSmNU6BjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZyqBRwd2; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZyqBRwd2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725626816; x=1757162816;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/XZTcQNtG+IZxyO6e2tb51gbAtM2zivjLfErdoGLLDs=;
  b=ZyqBRwd2A+eMcIpyExrX5KBBdVLNBSEk0kz1qHUcNvSOwXB4/tZSYgiS
   qjeB5ipcmhirPnlhCL32dKxzWSj5MFtxuWDYTXaN5sij+ii2V0Sqain1b
   tD3Yllr4o2DLwuwqRxgM/LG33uYDP3N2CbP+qpsoTuMztt/3jMxnvPHlp
   MyMIUDxIvZbfYcwaOAi+WViyDnmlbjcn7jlMEMCbotE3c9BMz+eBh7K44
   6EYujfXUw0HiVLiojq1PUU2lNNCrqt9pkO/mdu/KXtUDHVNwEXDRXsRnN
   55CU5FSppf3CFlj9pjC9i2MRe/6F+R08OUlJD2jcBYay5kWYrcG7ocRtD
   A==;
X-CSE-ConnectionGUID: Z6Kl5V7GQw+L3t9lqn7wqA==
X-CSE-MsgGUID: mZZkp+vwQS6qMOqaBUmILg==
X-IronPort-AV: E=McAfee;i="6700,10204,11187"; a="34958716"
X-IronPort-AV: E=Sophos;i="6.10,207,1719903600"; 
   d="scan'208";a="34958716"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2024 05:46:55 -0700
X-CSE-ConnectionGUID: SA/+jLtOTHK2rAbFnu0Jrg==
X-CSE-MsgGUID: HFN8Du0ZQwKZZMAoDKWMiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,207,1719903600"; 
   d="scan'208";a="65926319"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa009.jf.intel.com with ESMTP; 06 Sep 2024 05:46:53 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id BB76C1BE; Fri, 06 Sep 2024 15:46:51 +0300 (EEST)
Date: Fri, 6 Sep 2024 15:46:51 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Parker Newman <parker@finest.io>
Cc: Parker Newman <pnewman@connecttech.com>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH v2 00/13] serial: 8250_exar: Clean up the driver
Message-ID: <Ztr5u2wEt8VF1IdI@black.fi.intel.com>
References: <20240503171917.2921250-1-andriy.shevchenko@linux.intel.com>
 <20240503143303.15bf82bc@SWDEV2.connecttech.local>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240503143303.15bf82bc@SWDEV2.connecttech.local>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, May 03, 2024 at 02:33:03PM -0400, Parker Newman wrote:
> On Fri,  3 May 2024 20:15:52 +0300
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> 
> > After a rework for CONNTECH was done, the driver may need a bit of
> > love in order to become less verbose (in terms of indentation and
> > code duplication) and hence easier to read.
> >
> > This clean up series fixes a couple of (not so critical) issues and
> > cleans up the recently added code. No functional change indented by
> > the cleaning up part.
> >
> > Parker, please test this and give your formal Tested-by tag
> > (you may do it by replying to this message if all patches are
> >  successfully tested; more details about tags are available in
> >  the Submitting Patches documentation).
> 
> I was able to test the Connect Tech related code and everything is
> work as expected. I can't test the non-CTI related changes but they
> are pretty minor.
> 
> Tested-by: Parker Newman <pnewman@connecttech.com>

Sorry for blast from the past, but I have some instersting information
for you. We now have spi-gpio and 93c46 eeprom drivers available to be
used from others via software nodes, can you consider updating your code
to replace custom bitbanging along with r/w ops by the instantiating the
respective drivers?

-- 
With Best Regards,
Andy Shevchenko


