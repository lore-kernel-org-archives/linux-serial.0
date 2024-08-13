Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95D6813A888;
	Tue, 13 Aug 2024 08:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723537268; cv=none; b=spu6yOZtrUODgnyNQsO+VwXLpwGoDCzWs8KGxB0KFqlHLJPZOcUemY0lv4AeJQkvhWkqcMI2PjGF8vDRc982oAYJekxhI79BCB6AMWpC6BY1WTSc731EW2CRnYiJe9qjUAI2Tjulf8A2a+/DboIbJ6iBXy5Ao/y351KNEYsr7P0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723537268; c=relaxed/simple;
	bh=MwR/i54AGq714aniA0FuCdtDeNXlyfbxwYQv9zdJGA4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g3q/O66PSv823HAseyTR843FSZtvhgDzMWg9WGfxLPAmYErGeluZZ7VmTDx/mAbQc/Y5bcP3UrZSDou0mxFiL8TjNMG1/3dOyGMjkPT+bB+9zj4nqPXDXIc9qC+digC3Xx6EJ+HOPfpy4bbKWQb2jWev8qrjS3ZzBY15OZ075FY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g/xKyXyZ; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g/xKyXyZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723537265; x=1755073265;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MwR/i54AGq714aniA0FuCdtDeNXlyfbxwYQv9zdJGA4=;
  b=g/xKyXyZMgCV973aW7PXr7Lb943i4cHxSpU7siuadnQTF8RvJJ9QXmMU
   7YwWugath/9qBFsagHBm06Pc7sMTDK+C+BydvxGIAvav2fGZ9stLN6QNE
   P+2ehDTxdNlXbqXfngtTKC2jTaRbSlWZdR2MiBTdEmIVRME2bC/lSchCr
   UWk1PCmnWZu7zq0tIw/VLZsYEV7smUgo5+WLgCBOPvIjUo0+SvaQjMGFF
   5RdOqz0ooeoQagntRMUEmTM6j4l/kbXRqkVugriPJ9X81ovtXqLbh+4qy
   c8XM1UQ9zNPqp9kI6TkhAsG6Dp5JNi8dm3tpbeTfDsbd9iZPKFS07XSFV
   A==;
X-CSE-ConnectionGUID: uBMsUojaRVez0qMDsm6+Ow==
X-CSE-MsgGUID: ud8/JSiqQE6qbDqtEY2jXA==
X-IronPort-AV: E=McAfee;i="6700,10204,11162"; a="21243568"
X-IronPort-AV: E=Sophos;i="6.09,285,1716274800"; 
   d="scan'208";a="21243568"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2024 01:21:05 -0700
X-CSE-ConnectionGUID: FMN1jIIzS3OkmFQHqXOaqQ==
X-CSE-MsgGUID: iWydtte/TY2Q80j/6i9U/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,285,1716274800"; 
   d="scan'208";a="58665976"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2024 01:21:02 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1sdmm3-0000000Eeo6-31di;
	Tue, 13 Aug 2024 11:20:59 +0300
Date: Tue, 13 Aug 2024 11:20:59 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Stefan Wahren <wahrenst@gmx.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	Jiri Slaby <jirislaby@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>
Subject: Re: [PATCH v1 1/1] serial: 8250_bcm2835aux: Switch to
 DEFINE_SIMPLE_DEV_PM_OPS()
Message-ID: <ZrsXa-UWUL694hbf@smile.fi.intel.com>
References: <20240812143514.953612-1-andriy.shevchenko@linux.intel.com>
 <ad11903f-7ded-492f-a680-3ddcfcc7e0b6@gmx.net>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad11903f-7ded-492f-a680-3ddcfcc7e0b6@gmx.net>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Aug 12, 2024 at 10:40:15PM +0200, Stefan Wahren wrote:
> Am 12.08.24 um 16:35 schrieb Andy Shevchenko:

> > The SIMPLE_DEV_PM_OPS() is deprecated, replace it with the
> > DEFINE_SIMPLE_DEV_PM_OPS() for setting the driver's PM routines.
> it's possible the implementation doesn't use the optimal macros here.
> But this sentence is a little bit confusing to me, because the code
> doesn't use SIMPLE_DEV_PM_OPS().

Thanks, fixed in v2:
https://lore.kernel.org/r/20240813081954.1408792-1-andriy.shevchenko@linux.intel.com.

-- 
With Best Regards,
Andy Shevchenko


