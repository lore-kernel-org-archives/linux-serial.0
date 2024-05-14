Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A57F385936;
	Tue, 14 May 2024 12:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715691347; cv=none; b=QXHOOdCEpbhtC0vnr9hpbGwBE483wg8j2D22z0bjj83710Z5YDqGC9BqpyrBL46psJcrbfd5V5tW4nNVV0VJ93NPu2DY2DBqiWE4G0s7B7DJEnHu+5y2gcjJKu714mt+aaBF+28VPj4vgtH4gqPkv8HY4D4coazwxuEPT5K3Vb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715691347; c=relaxed/simple;
	bh=JegKl63JU3+HoS2Kj0zGHv+XRNw+qSIozCHP8J1ApPI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BA0UVPPhJifoF+RFdq27vrM6PzlsbPV+egfth/1y4BtWOlBbOPX6/jkd9I3z9G3giPv8AXN3fg//vsOfDm2KaWVhUinyhDiAEgOV98fyt+4l6DJiJuS1xieOEBOQaH5oO6wVKDYFSbhJn5Cm0uvrW2nK3wUqU7ZlKbFPPck3zys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d2qWrFSc; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d2qWrFSc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715691347; x=1747227347;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JegKl63JU3+HoS2Kj0zGHv+XRNw+qSIozCHP8J1ApPI=;
  b=d2qWrFSc8IYzxZ/o4HnbgkBouX07xnjnG7beQwzRMB5+272r4aancIU8
   0C7UC94br6cZpbjQcs0OskfTx76J+RwzIYMUJ+cmq3bepDGVmQbg5Z1y8
   2DxnMT1Dj2af527TrKR1m2FdLPrXh7CWm3iafoUkmUQZMPMBi8m4y2nuI
   c/CyaVl4b7Zd0cCZmUGfRjlnxhHh6In5vJ1y9oWNHZSFCpFt24I6DbpkA
   vkal3+ARIk0PvcszX1DwZ7X+0+awNhHiaPXs8HinlDnQm98mXf/15Gkwm
   cvgj7JVFxFQr+gu09HK3GXGqrRATJMW7M1oQwqfrmaQPXE/n47qgD8UUH
   w==;
X-CSE-ConnectionGUID: 1g1UUzU7Qt2JEn5otc8Bnw==
X-CSE-MsgGUID: KgtgbEBrQrOtdL0J3bZvcQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11073"; a="11613731"
X-IronPort-AV: E=Sophos;i="6.08,159,1712646000"; 
   d="scan'208";a="11613731"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2024 05:55:46 -0700
X-CSE-ConnectionGUID: uPqxZQ7UQ16yfGxkcY/2QA==
X-CSE-MsgGUID: WEZl111KQGCg7ZvqYT9c5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,159,1712646000"; 
   d="scan'208";a="31232243"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2024 05:55:45 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1s6rgz-00000007Qy8-3M37;
	Tue, 14 May 2024 15:55:41 +0300
Date: Tue, 14 May 2024 15:55:41 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Philipp Hortmann <philipp.g.hortmann@gmail.com>
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
	Peter Collingbourne <pcc@google.com>
Subject: Re: [Bug] staging: rtl8723bs: Bluetooth stops working after patch:
 serial: 8250_dw: Do not reclock if already at correct rate
Message-ID: <ZkNfTRv0Lk8-_M1s@smile.fi.intel.com>
References: <8fe72cec-adba-42dd-9185-15e777714a81@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8fe72cec-adba-42dd-9185-15e777714a81@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, May 14, 2024 at 06:32:37AM +0200, Philipp Hortmann wrote:
> Hi,
> 
> I have a ODYS Trendbook next 14 with the wlan/bluetooth module rtl8723bs.
> 
> Bluetooth stops working with the following commit:
> commit e5d6bd25f93d6ae158bb4cd04956cb497a85b8ef (HEAD)
> Author: Peter Collingbourne <pcc@google.com>
> Date:   Thu Feb 22 11:26:34 2024 -0800
>     serial: 8250_dw: Do not reclock if already at correct rate
> 
> Please find dmesg below. Module has issues to load firmware.
> 
> To enshure that this is the function breaking commit I applied the commit
> reversed on top of the latest kernel from the staging tree. Then bluetooth
> is working again.
> 
> I can support with further tests. I do not have a good proposal for a fix as
> I expect a lot of side effects. Please send me proposals for a fix.

The revert is in the tree IIRC.
7dfae6cbadc1 ("serial: 8250_dw: Revert: Do not reclock if already at correct rate")

First appeared in v6.9-rc5.

-- 
With Best Regards,
Andy Shevchenko


