Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 690A51487C5
	for <linux-serial@vger.kernel.org>; Thu, 22 Feb 2024 15:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708614638; cv=none; b=VMEyEJmBKZIrzN7MU4ZeBtLDRX7qearxmkk0p1R74GCPni8TfzWV98IEHDKnxNxT2tJlFLtqisxofG3ZE5AXrqu/dseLskorvTmXYtPJJfWX/4WhHXanG/1AwersBeqYeKIL+Et6vLsGDhCiAiUsc52OCsYNUnQXIzj42Wgnyag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708614638; c=relaxed/simple;
	bh=wkS1ug1mUO/Sg3KTqrvVDF6HmF09b7krrg3Vtb26Ezg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZVdjRCfY9b9kTaYHaFeVliL3vqSnE/IbVcKO8xRpzo2v/TZaGNOPLtj/b3RfGRAGE46j+CzKK6p2Ctsg+1jY2Sio5YEd6F5LEujUEfysE6xsYEaYi8/jq/O6Q4NDxSBOAdZWq3Lc80W7aKwooEdMClvH3sUKAthTISZOVlA4P5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fmICuCH5; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fmICuCH5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708614636; x=1740150636;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=wkS1ug1mUO/Sg3KTqrvVDF6HmF09b7krrg3Vtb26Ezg=;
  b=fmICuCH5+IUu0lmi2Us7/gb73uv3r+6Zi5ckdFSPfObKdlNOv6zqHNMk
   xevGAecjRnyUQxwobEVyp08bx/mj5dp9nDq9KM7ownt3xitAbe7UHh6fC
   nOWI4iLAwBvw9dlmmpvV9XV4oKXJht/3kcxcjiz9GhPJg/ce4vVWXK71L
   oh9W3eXAjI0j0f/2U8TNOF5TpeVk8xRlNXPB153yR6U3VNcJIqoM009Iv
   R7GUyhukNgzrXL2s9+NQGYOY2Zt5QC/2P/9nIcJm61nHSs9KKJAfyhJ1O
   ORbD66Pu71pLu8UI/kTZEgzPzZj50wDGGl0z760btA7597UdqQWaEBYre
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10992"; a="2707936"
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="2707936"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 07:10:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10992"; a="913540219"
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="913540219"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 07:10:33 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rdAiV-00000006ez2-08dQ;
	Thu, 22 Feb 2024 17:10:31 +0200
Date: Thu, 22 Feb 2024 17:10:30 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-serial <linux-serial@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] serial: 8250_dw: Emit an error message if getting the
 baudclk failed
Message-ID: <Zddj5gUFc8tDxQyy@smile.fi.intel.com>
References: <20240222111922.2016122-2-u.kleine-koenig@pengutronix.de>
 <786cecc3-4723-4b96-679e-1ea9736d3f6b@linux.intel.com>
 <rxbnydqttxdduseprrnugirdvndznbfpi3q2nxctxdelhoc6t6@7aj4jmzvorv4>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <rxbnydqttxdduseprrnugirdvndznbfpi3q2nxctxdelhoc6t6@7aj4jmzvorv4>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Feb 22, 2024 at 02:36:22PM +0100, Uwe Kleine-König wrote:
> On Thu, Feb 22, 2024 at 01:50:40PM +0200, Ilpo Järvinen wrote:

...

> Thanks. Is the expectation now with your tag that Greg (added to Cc:)
> picks up this patch? 

Why you haven't Cc'ed him to begin with? We have get_maintainer.pl script for
that. (You can see what script [1] I'm using to get patches published, another
approach can be switching to b4 relay.)

[1]: https://github.com/andy-shev/home-bin-tools/blob/master/ge2maintainer.sh

-- 
With Best Regards,
Andy Shevchenko


