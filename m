Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A698F6A;
	Fri, 13 Sep 2024 17:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726250052; cv=none; b=j/PMhyFqOgCQL1fmMnnlWNaNStl4MuX3G8yYIUjVvYIFZ4KcYdQH2T87bxVRqGmTLwAylBpF/edt7YZjy2lqhq73/05C7vrB9vT00FM39cVcY3CnkFXeAUjAekKhMPntL992CKlP2BtnHGwMY/3uoqXdiQrD/KKIE/1CuzHNOXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726250052; c=relaxed/simple;
	bh=DPn77RDnAQjza0qPZXvs9M0fX3yEcxk4OayaSfEDzDc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cVGb6Ni3x03cIVoS0fa3vScto6B58snUFtkY1KDPiu3/jB5ane2XTBI2BR9G65mMmaEVCgcDhE7KFe761RelzU/m1kXUFsxEM33Q13YDpSVE6281mM5A4aj2/oJ+TRQQgLMwAA543cOJjzOa573hdmlO0/alrmT8aJz5/sALDA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i/fn7ROv; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i/fn7ROv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726250051; x=1757786051;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DPn77RDnAQjza0qPZXvs9M0fX3yEcxk4OayaSfEDzDc=;
  b=i/fn7ROvO3vn8cLf8gN8BtGDmQGKyj8TCntGr4AqmS9bKQZcdq9icYeq
   wogJv8yXuyKOvcaU2Z/gwvOhDxLaQAW2kuXQiL5RENZUBrR2R7zUcqVVb
   glihGT7sPD+uj1L+xdmdFAd0Jo3t+TK+J8kPzBGXTMA7bfOdpC7MHzQCg
   Y1Nkt8ZhaYqSctIhfbSkaDtHV84uawMGb9g6lZanCcyaJQcxxv3AyvJX2
   0l/PUIzU/qaHXylwJGUmeawxB6FiVnK56tZDFmwGS3b+R4bCDFwi0o7YC
   lMU4lyV7nMN/tkHvDN3GssihvsVVUY690r6n7o88HkmrvtI8aQf0zUuhr
   Q==;
X-CSE-ConnectionGUID: RZ9Zy0yuRK2/9+hG7kNLFg==
X-CSE-MsgGUID: peUYoF1DQGi0BdZIIGXIUQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11194"; a="25043031"
X-IronPort-AV: E=Sophos;i="6.10,226,1719903600"; 
   d="scan'208";a="25043031"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2024 10:54:10 -0700
X-CSE-ConnectionGUID: 18zqhmHBRCOJTpUdfQH4Cw==
X-CSE-MsgGUID: b91DdrCoSpOde/LgZRfLLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,226,1719903600"; 
   d="scan'208";a="72963644"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2024 10:54:09 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1spAUf-00000008NWj-2OFb;
	Fri, 13 Sep 2024 20:54:05 +0300
Date: Fri, 13 Sep 2024 20:54:05 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Parker Newman <parker@finest.io>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	Parker Newman <pnewman@connecttech.com>
Subject: Re: [PATCH v1 3/6] misc: eeprom: eeprom_93cx6: Replace
 printk(KERN_ERR ...) with pr_err()
Message-ID: <ZuR8PawGrcDxCioi@smile.fi.intel.com>
References: <cover.1726237379.git.pnewman@connecttech.com>
 <127dcc7f60d15a1cc9007c9e5b06a1aa2b170e19.1726237379.git.pnewman@connecttech.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <127dcc7f60d15a1cc9007c9e5b06a1aa2b170e19.1726237379.git.pnewman@connecttech.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Sep 13, 2024 at 10:55:40AM -0400, Parker Newman wrote:
> From: Parker Newman <pnewman@connecttech.com>
> 
> Replace printk(KERN_ERR ...) with pr_err() to improve readability.
> 
> Fixes checkpatch warning:
> 
> WARNING: Prefer [subsystem eg: netdev]_err([subsystem]dev, ... then
> dev_err(dev, ... then pr_err(...  to printk(KERN_ERR ...
> +			printk(KERN_ERR "%s: timeout\n", __func__);

First of all, you probably want pr_fmt() to be defined.
Second, I would replace the entire while loop by the read_poll_timeout() macro
from iopoll.h (note to use "true" for sleep before check and drop that one from
before the loop in the driver).
Naturally the pr_err() change can be combined with read_poll_timeout(), but
if you go with pr_fmt() perhaps it still makes sense to have separate changes.
I dunno which one is better, up to you.

-- 
With Best Regards,
Andy Shevchenko


