Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 440532AE69;
	Fri, 20 Sep 2024 15:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726847364; cv=none; b=dqVbBe+I9GAlTlITfoarK6c0P3oj7PodmRYVcGg/tM0huEjAnURhsPQuQBmogMAC29ECNSC5ZGxvvq7Lyp9cNyU8Bgsl2h8gcnMMFU/qEU0QdiVx0JlkXsK2OyfC2o+WGGZ+SZVq6P1TZIL3/1d7VC7MsGwNBzS9oqJvZA1l1vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726847364; c=relaxed/simple;
	bh=O1chZsUdDn48ClY7zZU4LRBrBZnSUfVEQdhGFn+jYD0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZneZ/eN6jccGpa/T8KQ7t/43x7zrSVqmsL2zSOim2W4vpF2Z44dhCKo8cTZsy5A7shG+ps6F7giVOSVETo690ht3Hb+JmZO8Cv+z1TbI8fl3Ej3KG38ACoE+pOFy9Ih+VCuyxI0Vxowbsu+qtdtvPcviDz5mnCrmuxY2q7lnB9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Hodz91Pr; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Hodz91Pr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726847363; x=1758383363;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=O1chZsUdDn48ClY7zZU4LRBrBZnSUfVEQdhGFn+jYD0=;
  b=Hodz91Pr5zyin7fDdmFX0goTSlMioZiH6G1yOSYOVJHym3XtAU6FFx3k
   /fVlR0qzGWR/EQpRmCLxHsF3jnVMH+GhT+GhxhIriHQG7qikwR1gZU6cV
   0aYLZmlL+w+tSgBYW53IEjSmRIQ3TRbPBNabWL9R4gs/scar6p0SRuKYP
   481xqE3XFa8pEb8QSHMMK9fko+4WNh0WMTjWNZZBth57Ka75BDiYlJuLl
   VLxxkOD3sc1bQYRRt2HJ0n3QQI9Fe7c+1E17epugUsvGnavBi8DJWgNkq
   gQW5fOff2fmFjg++AeAUQfDdXmcvyKrsL7cpybH3s0sGMm8UNeUC0p8hv
   A==;
X-CSE-ConnectionGUID: pNc5PTWmQ2OepCbItvRliA==
X-CSE-MsgGUID: rT2bL8lkQD2vltnJyOrs8w==
X-IronPort-AV: E=McAfee;i="6700,10204,11201"; a="43379212"
X-IronPort-AV: E=Sophos;i="6.10,244,1719903600"; 
   d="scan'208";a="43379212"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2024 08:49:22 -0700
X-CSE-ConnectionGUID: 6mdG4o0hS/yYqFSINcS5YA==
X-CSE-MsgGUID: p2RDcGTgRaCl0n/HZZlR/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,244,1719903600"; 
   d="scan'208";a="70621265"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2024 08:49:21 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1srfsk-0000000Axp3-3fTV;
	Fri, 20 Sep 2024 18:49:18 +0300
Date: Fri, 20 Sep 2024 18:49:18 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Parker Newman <pnewman@connecttech.com>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Cc: Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH v1 1/1] serial: 8250_exar: Group CTI EEPROM offsets by
 device
Message-ID: <Zu2ZfpnnY6z4BBG9@smile.fi.intel.com>
References: <20240920154430.3323820-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240920154430.3323820-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Sep 20, 2024 at 06:43:24PM +0300, Andy Shevchenko wrote:
> It's not obvious from the first glance that the list of the CTI EEPROM
> offsets covers three different models, let's group them accordingly for
> better readability.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> 
> Parker, feel free to append this one to your v3 as a last patch.

A bit more hints for usage of `b4`. As I described earlier you may use b4
to gather the tags, but also to inject / append other patches to the series.

Like with this one, after you collected yours, just run

	b4 am -s $<message ID of this email thread>

followed by

	git am ...

as the tool hints you. It will take care about everything you need.

-- 
With Best Regards,
Andy Shevchenko


