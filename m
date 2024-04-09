Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C441369AC
	for <linux-serial@vger.kernel.org>; Tue,  9 Apr 2024 13:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712670196; cv=none; b=VGiQGDbtgRT+kL4EVVkX7VYMrrET+x2g0Sjuwbt+7TSWDtQPYckcfVU4bIoeMCBMQe0k2cRYd/ykfB82A3msSIwYOhy9YesH+xeCsTQt6grFR8G/QKyr1sOrxsjWQ2uOzZJZRWqxpFHsY64o847NjZ1dU9eOjknVcBMlHejBia8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712670196; c=relaxed/simple;
	bh=Fw6hoqDh7KH0XxyevTd/2LKF5IuxN9N2zmsqTBW8to0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wb8s7VViZEM5HVQAUyQj/DxiFs0lAyl3FyxEE+mwkA9D/5AyCfjL6p3rVyCfdxwdvIyTzutCxqoIs+hr19DdUZhD4XVi7grqNok0QNyvj3FJMTZM98Egj6q94epthoXLhJ2a0b5dQNFgetc7pP4iX+FjtU+qNSGoXf0VKQiXMDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jf4FYDud; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jf4FYDud"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712670194; x=1744206194;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Fw6hoqDh7KH0XxyevTd/2LKF5IuxN9N2zmsqTBW8to0=;
  b=jf4FYDud7Xs7jWF0dZW1U42sI26/wv6FQt9DinCQq45AIeJQp5VVoges
   /v/0lhYgPn/uuM+cpcVDn0Vgi2nn9fkpkwAd2Yf0HwP+OGjAtCsL7If8S
   53yI6YKRAa4794E4fForfAslp9Yo0T+fcfzoRUpHxVAPeGzNE9heuGmCF
   t5mRY3LAvVZnU4u0VbMO4kHdJQwzbkhpYPXKDy16Ac/av/ZKX4r/qjbbH
   8GjGO8zqZn6bevo7VMweyYYGnacxtk90IP3vT6Pw5e0H82p57mN8Qi4Kw
   C9058qB/kH25lV8gerBqTzWBaCiIzk/H/pEjkPEb02UFXb8M2UtM91Ca4
   g==;
X-CSE-ConnectionGUID: CD9J8qZaQE2u/obsZoyikA==
X-CSE-MsgGUID: aHfB8a/HTYmVYlz/Zn2zPg==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="25425519"
X-IronPort-AV: E=Sophos;i="6.07,189,1708416000"; 
   d="scan'208";a="25425519"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 06:43:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="915400190"
X-IronPort-AV: E=Sophos;i="6.07,189,1708416000"; 
   d="scan'208";a="915400190"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 06:43:11 -0700
Received: from andy by smile with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1ruBkj-00000002olH-1EhL;
	Tue, 09 Apr 2024 16:43:09 +0300
Date: Tue, 9 Apr 2024 16:43:08 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: Re: speed_t usage?
Message-ID: <ZhVF7Dntnt1BbsMh@smile.fi.intel.com>
References: <ZfGTIGvFvEMrFwOZ@smile.fi.intel.com>
 <2024040905-stoppage-sampling-b575@gregkh>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024040905-stoppage-sampling-b575@gregkh>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Apr 09, 2024 at 03:36:11PM +0200, Greg Kroah-Hartman wrote:
> On Wed, Mar 13, 2024 at 01:50:56PM +0200, Andy Shevchenko wrote:
> > Hi!
> > 
> > Recently while doing some serial driver cleanup I realised that TTY uses
> > speed_t type for baud rates. What is the appropriate use of it?
> > Either it is going to be killed (replaced with POD), or should / may we
> > spread it over tty/serial and further?
> 
> As it's a uapi interface we can't just delete it entirely, but please,
> do not spread it any further, and try to clean up what places in the
> kernel itself that we can to use a "real" type that we know the size of
> at all times (i.e. u32/u64), not just having to guess like we do today.

Thank you for clarification!

-- 
With Best Regards,
Andy Shevchenko


