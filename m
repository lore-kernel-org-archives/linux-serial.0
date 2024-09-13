Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FFDB839EB;
	Fri, 13 Sep 2024 18:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726250864; cv=none; b=DBCimyOJ84tsdCOeP0lV/z+6jEGxxPaZjEyFil9BiXN5vt+yKkAEXHSKaQ7NkV4KRInmpUlVBPl+q6JfbB1Aw8BPktBNUuXftGq7N5h9BPRyGDp2Zk6XejRPTvCH+38BiQW6SFv1UStPJKR1kmJpg4/a/ZwLy/y1rdUgPnfwSxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726250864; c=relaxed/simple;
	bh=OGY0G5ORBw6aovYscCFflyB/ubDM90LxER4heo3XwSs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pl4jjv1AwkmHZjPlk7/MF8EUrarfhaiqxJdUP4NWqRrym5lhoWsyp/5Vmtu3HF5IREnSznS43AtyUFPfqmiEtXmDSXI18HMNH9EzgeHIFPynh/ONeWNd7VR3mWii5yvU8ljS6EtmP9VADIK4mMu52NXJEdDx/mqJNREaQbNW8yI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N2MnrEeF; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N2MnrEeF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726250863; x=1757786863;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OGY0G5ORBw6aovYscCFflyB/ubDM90LxER4heo3XwSs=;
  b=N2MnrEeFSzObckwgOmGEGNLW+rrdsRdPbWX7pxTvrr4xhDmducddGwNt
   IeTZljEdMd+ig1RJTgzlDOC6LhXzcGCU1Ytuk0O+PJlJQGvudlUojDscQ
   ajZRSjy+UG+h95uaHdj5Ur4osbumg2DhJRRSG4ieXHE1R+H17GHjlxXE4
   Bp6j4N00wEUOBHLInaS0DbOqg/htU9yL5AXvZLKKnEG8O39bgS75k36JF
   4ORGMXq0mAhGynfxUhz4xvKthg9Z6FO+Lt/dBSpyc76YfHSLHbNN0UEWR
   RUZPRNULLkjLNO4bxX1AA3ApcxViz7UEjm0azRgyAHbvnphgRhvUYmOc4
   w==;
X-CSE-ConnectionGUID: x4YP40CiTG+MkegLZ9Jc/A==
X-CSE-MsgGUID: GUa+34KxS8aMXzp0g3B7WQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11194"; a="29058889"
X-IronPort-AV: E=Sophos;i="6.10,226,1719903600"; 
   d="scan'208";a="29058889"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2024 11:07:42 -0700
X-CSE-ConnectionGUID: Xx3ILxHbTFaCKz0SI/9t+g==
X-CSE-MsgGUID: B8qlfP3kS12YqkJBccThXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,226,1719903600"; 
   d="scan'208";a="91407274"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2024 11:07:41 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1spAhm-00000008NkJ-21H9;
	Fri, 13 Sep 2024 21:07:38 +0300
Date: Fri, 13 Sep 2024 21:07:38 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Parker Newman <parker@finest.io>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	Parker Newman <pnewman@connecttech.com>
Subject: Re: [PATCH v1 5/6] serial: 8250_exar: Remove old exar_ee_read() and
 other unneeded code
Message-ID: <ZuR_avdHfhIsDEU9@smile.fi.intel.com>
References: <cover.1726237379.git.pnewman@connecttech.com>
 <3d7342999229210b18d1e163362999cac78a52d6.1726237379.git.pnewman@connecttech.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3d7342999229210b18d1e163362999cac78a52d6.1726237379.git.pnewman@connecttech.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Sep 13, 2024 at 10:55:42AM -0400, Parker Newman wrote:
> From: Parker Newman <pnewman@connecttech.com>
> 
> Remove the old exar_ee_read() and associated helper functions as well as
> some defines that are no longer needed after the switch to using the
> eeprom_93cx6 driver.

Nice!
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko


