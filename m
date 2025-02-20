Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A24261FDE08;
	Thu, 20 Feb 2025 15:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740065263; cv=none; b=goXG9H5Z1Oa26wj/uX+ByZ76nq5ygG7IFI1ZkjWak4AIwxI7IKCt3Ksp9GfG96cgk2cV8xyxzMnTjVnLeGhh+IyKIIU23EiDO80VbjxehHwe6HYQI06Ykprr0DpWfEfF4ktR4/2LuFSP+n7mvBmc0+t1Mmu0xuxP8BR0L9XtjwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740065263; c=relaxed/simple;
	bh=m1j9pVe50EmwhieBaHz88aACdf31p01e6DOvHsva5BE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LwbP/hiJ277PJ5BJn/dSnZ2KgjaFd3gt4e50OaWFQk6ON9UJDYALHABAOB2sEI4byiO/RRSd96tLcvrSJkX3ydfHSxLvUsQqQZ/EYKw116/924w/uw24eDz5ennQ1lzOmnFb9iOgn+hBA81uhTLF2aDRVYJXa6gJJyXUxq7lvi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bIMO1cTR; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bIMO1cTR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740065262; x=1771601262;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=m1j9pVe50EmwhieBaHz88aACdf31p01e6DOvHsva5BE=;
  b=bIMO1cTRZJ2imD9qrb26SMDqp3mdIn6ppFWLoEBPLkc7doPIe84aAkw6
   NSVZuGFXQ8arxQdKOKmri/YL2SdyWuzxabMf0mkEjjoCTbS3zwtfSerB5
   bVMjzV9cXKQ3wFkND/m6oeJpFW7a9YO0PU/YKRGH5krm8A5oHCOU43KTH
   +rgX9LgqHi/+oqB2zGOYBELizkPepi6WfnoZ23mD0WVLDt/MF7vSK8Mdf
   6zD49bgHrS74rcQ/02Z0jaAImx2lVvLRNxqUaZJt3a0K71yfa5vsk3/o1
   TkDLXGYK17gYKOJGI49tf/tSxEB2oGTMaxo/QCDqT66Nl4JCHABtzaRlF
   g==;
X-CSE-ConnectionGUID: guI+dRxDQ+iaeoN4cVKW8g==
X-CSE-MsgGUID: llVgETIPRb6Rxqb25i8Skg==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="52279934"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="52279934"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2025 07:27:41 -0800
X-CSE-ConnectionGUID: 7/KyD8eNRvKtdwWOVqLJLg==
X-CSE-MsgGUID: HuAX0+2mSMeYYOPdNUxDVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="145963578"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2025 07:27:39 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tl8Sf-0000000DNJI-09Lm;
	Thu, 20 Feb 2025 17:27:37 +0200
Date: Thu, 20 Feb 2025 17:27:36 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: Re: [PATCH 26/29] serial: 8250: use serial_in/out() helpers
Message-ID: <Z7dJ6I3Qu5Ho35o5@smile.fi.intel.com>
References: <20250220111606.138045-1-jirislaby@kernel.org>
 <20250220111606.138045-27-jirislaby@kernel.org>
 <Z7cfvXUCHXVXK_mp@smile.fi.intel.com>
 <2025022032-movie-citation-b267@gregkh>
 <Z7dCvmLLk6P9rbs7@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7dCvmLLk6P9rbs7@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Feb 20, 2025 at 04:57:02PM +0200, Andy Shevchenko wrote:
> On Thu, Feb 20, 2025 at 03:39:40PM +0100, Greg KH wrote:
> > On Thu, Feb 20, 2025 at 02:27:41PM +0200, Andy Shevchenko wrote:
> > > On Thu, Feb 20, 2025 at 12:16:03PM +0100, Jiri Slaby (SUSE) wrote:
> > > > There are serial_in/out() helpers to be used instead of direct
> > > > p->serial_in/out(). Use them in various 8250 drivers.
> > > 
> > > Is this just a mechanical (compile-only) conversion?
> > > IIRC 8250 DW code is twisted in some cases and it might
> > > be a possibility of dead loops, but I don't remember it
> > > by heart and haven't checked myself before writing this
> > > reply.
> > > 
> > > TL;DR: this needs a thorough review.
> > 
> > Wonderful, are you going to do it?  :)
> 
> Why not. Just give me some time.

Just done it, I think we need small improvements as I suggested in the separate
reply. Otherwise I like the idea to unify this.

-- 
With Best Regards,
Andy Shevchenko


