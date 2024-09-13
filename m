Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F36B712C526;
	Fri, 13 Sep 2024 19:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726255592; cv=none; b=PgI3wCu5d/K2HJzM9TOmp9b02HTxvDO1XWaEQRTLgMoGRQQxr+5hhaowi5L7x8HSkMt4SC51sjZQd0NxuuenXDYzzxX4T56N9KjQV8XE8TnBac17TZk/jOFh5B2X0ljxQi8jC5AqglON3iuxmgpMPZSB+jt3EGtnAZkQQqrs/ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726255592; c=relaxed/simple;
	bh=qG7jcnA1rEli/ZigmuPTNW11XKmxV75+0YOUYyPr32Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ppt6Rn2A7k84TmrNv6iQx3atFBHRzGsqOs+1O+yOSz9Sr0D13iVzj4OuIh93rRimamx6bWrc367rAh4A643movnYLhDKWuHNeqaKIxK/dbFJYaraK1e3MqNtdEuZ6mO+mTlBhcX1I+9ws1Fa1eBDRim9S2YE3LZBf1GckQOkOz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M0tFFXH6; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M0tFFXH6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726255591; x=1757791591;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qG7jcnA1rEli/ZigmuPTNW11XKmxV75+0YOUYyPr32Q=;
  b=M0tFFXH6ivwpxkk46ttKLEw5aZSBBONejgkmOo/Nj8Vwep5ciQR9dKwz
   HULM2wn/900O4240qFf8dtyX0bLZCJru/CCY+e04a0Q0VqjkK6iHJxCGT
   AYG8jDyoObpy9v8tDZtrRYdCkbEKa/dD/vMOtLSqSeGW8epBi/YmlqzVe
   Vc6h1AYuj5G5TP+xTl3GnmjhMFj8Rt4LPd/gC6hCf2N93/eZF4a0z9XsG
   58uATqfV4m9xeGKwK6I20WR3DOtU0ex12imJcXCkDDrVbVo9ZdLSzCELe
   TEp9QJcgqxTMIYDUS5pTplKj0gZ89DD0FgwmNrRxS38TUztSCAIU2HPr/
   g==;
X-CSE-ConnectionGUID: uICTIistTUG76BIg/n5xdQ==
X-CSE-MsgGUID: Ch0I/b3PRO6d4aTZveTvDQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11194"; a="50584610"
X-IronPort-AV: E=Sophos;i="6.10,226,1719903600"; 
   d="scan'208";a="50584610"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2024 12:26:30 -0700
X-CSE-ConnectionGUID: G7eN8g31T/maWZgoCoZGvg==
X-CSE-MsgGUID: GKCaoW7zS+Gv/awNUxtxEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,226,1719903600"; 
   d="scan'208";a="68674766"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2024 12:26:28 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1spBw1-00000008PC0-3REc;
	Fri, 13 Sep 2024 22:26:25 +0300
Date: Fri, 13 Sep 2024 22:26:25 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Parker Newman <parker@finest.io>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	Parker Newman <pnewman@connecttech.com>
Subject: Re: [PATCH v1 3/6] misc: eeprom: eeprom_93cx6: Replace
 printk(KERN_ERR ...) with pr_err()
Message-ID: <ZuSR4WXoD_2Mb8BI@smile.fi.intel.com>
References: <cover.1726237379.git.pnewman@connecttech.com>
 <127dcc7f60d15a1cc9007c9e5b06a1aa2b170e19.1726237379.git.pnewman@connecttech.com>
 <ZuR8PawGrcDxCioi@smile.fi.intel.com>
 <20240913151228.2b312e9b@SWDEV2.connecttech.local>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240913151228.2b312e9b@SWDEV2.connecttech.local>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Sep 13, 2024 at 03:12:28PM -0400, Parker Newman wrote:
> On Fri, 13 Sep 2024 20:54:05 +0300
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > On Fri, Sep 13, 2024 at 10:55:40AM -0400, Parker Newman wrote:

...

> > if you go with pr_fmt() perhaps it still makes sense to have separate changes.
> > I dunno which one is better, up to you.
> 
> Sorry if I am miss-reading but do you mean the pr_err() and pr_fmt() can be combined
> and the read_poll_timeout() change should be made in a separate patch after?

Possibly, I dunno.

> Or should I be adding the pr_fmt() define in its own patch, followed by the pr_err()
> and read_poll_timeout() in a patch?

No, either altogether, or one patch for pr_err() + pr_fmt() and one for
read_poll_timeout().

-- 
With Best Regards,
Andy Shevchenko


