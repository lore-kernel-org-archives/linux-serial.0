Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47CCA405C9;
	Tue,  3 Sep 2024 16:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725380353; cv=none; b=tLEjPndOH7eM56NW7rE53YgaZwW1LYb24+4d/mrkkX32GyibpjTch0FAbv9EVTqtAEVzXxHrLITT7ziWpXEOjnyDVDSNf+ZZ7lBxN8TACkUrg6TFtvPcw05pF8zPmB8YQLzpgGVuWXM6NHreE8e8cdoWK4k1t4MFxjGMYuGavFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725380353; c=relaxed/simple;
	bh=7PP+0mnwl58stNlb1VVDx5bSn5dAYK88Hlv7Mydk/j0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i4oew2Kx9QsZerTxtmWrGtDOoh6ZRAFtlR7hV7HtTatFGo7Oi3bftUTzZG1f+whLYKOXZ8vrN9ji22EQ+ZbswwT7YH8tXIfj+5kJuwn3ASroIcBDpdNVfItTC1XTsTLa0JzdZ65qQ/oOkDcan2LLAP/LXkNN+CVR7jhl2lKULDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bchnjGj7; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bchnjGj7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725380352; x=1756916352;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=7PP+0mnwl58stNlb1VVDx5bSn5dAYK88Hlv7Mydk/j0=;
  b=bchnjGj7Y+nM75tWlz7l1aI9qAFYkWPq/q2QWcNP5tfxjs8QXgkdz4pX
   VX4vUVh6VUTXjny11HSXyeWpkM6434R2mNkb6STz3AiXD0qyUlQ2t0wO4
   76g4+Dr931DsGdvIEd+E8a1z3DJ5+SUWVcFhI3LyQh329CMnyJ2p6fdXV
   JNdOwFfc4Lz3MMAw9nUVMeqoMDTJFEDqKJuV8WGbQYzlR8ldVss5/qcwS
   yjbtF8aWGfP+bKdpL3vY507cqiEmoX24Ux0otgNnzzWfjstvDd5VlyMX9
   YomrlZZehE/jFTnUw7ois8QzxTAnp1XPIChCzQNVZnM0QfBv3RnmO8P3H
   Q==;
X-CSE-ConnectionGUID: 6872LyU+QOWFFL8MyxAOUQ==
X-CSE-MsgGUID: S/yt/xHSTQe87tSYZUTCCg==
X-IronPort-AV: E=McAfee;i="6700,10204,11184"; a="13350169"
X-IronPort-AV: E=Sophos;i="6.10,199,1719903600"; 
   d="scan'208";a="13350169"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2024 09:19:11 -0700
X-CSE-ConnectionGUID: MuLc0WaHS0CsYw5dJZPt8A==
X-CSE-MsgGUID: cudFreshTlCFr9WA3XMQaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,199,1719903600"; 
   d="scan'208";a="95700617"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2024 09:19:09 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1slWFF-00000004laX-0mjJ;
	Tue, 03 Sep 2024 19:19:05 +0300
Date: Tue, 3 Sep 2024 19:19:04 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
Cc: Liao Chen <liaochen4@huawei.com>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, gregkh@linuxfoundation.org,
	jirislaby@kernel.org, joel@jms.id.au, andrew@codeconstruct.com.au,
	andi.shyti@linux.intel.com, florian.fainelli@broadcom.com,
	tglx@linutronix.de
Subject: Re: [PATCH -next] serial: 8250_aspeed_vuart: Enable module
 autoloading
Message-ID: <Ztc2-OuaL2IJI6QW@smile.fi.intel.com>
References: <20240903131503.961178-1-liaochen4@huawei.com>
 <4nyenalsjnerwjwcuk5zwm52rptnc5jhjhz3yhsmo7qt3gffhs@qadnsjic7p24>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4nyenalsjnerwjwcuk5zwm52rptnc5jhjhz3yhsmo7qt3gffhs@qadnsjic7p24>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Sep 03, 2024 at 05:49:54PM +0200, Uwe Kleine-König wrote:
> On Tue, Sep 03, 2024 at 01:15:03PM +0000, Liao Chen wrote:

...

> I wonder if you found this entry missing by code review, or if you have
> a machine with that UART and so you actually benefit.

Using arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier.dts in QEMU
I never experienced an issue. Seems due to defconfig having it =y.
(used arch/arm/configs/aspeed_g5_defconfig)

> Otherwise looks right to me.
> 
> Acked-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>

-- 
With Best Regards,
Andy Shevchenko


