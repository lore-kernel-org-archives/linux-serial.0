Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB80E17BB06;
	Fri, 20 Sep 2024 14:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726843028; cv=none; b=hFpVH72OfOKDsWekfh8plRoUMt73+qKlr9OnAZE5pPXI+XhpzmtGj/RPces4Ele36RavBN3jUCahxabh2oFDrOGJxSoDQZ7k34qtPAz4P5Q+wcG4N1W2rOkBWfwgpld2sB9Ps/EmTSJhLmX63Iiidl9yFcXPbxd+Zluffg7qyuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726843028; c=relaxed/simple;
	bh=sUHKUamhp6EUEKkcsAy2CiDaBjMKmUsC9OYCqWtNmiA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oeJH0T706H9xzxsq63F8UxWVckUBe5K+z8JsforF3+b/ZDUVTVKCkR+VF6aoAqIIsUL/frbwAq6WudxW97BbN2MMSms4t8Ar4KVBPJKmeqAfZTwvhY8hwKI9sh7tdP40vqSI+h+mO1uR1U5wclSwzIgvJ5KZ7iGO0sFMK/Ya71s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UNw4PDPl; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UNw4PDPl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726843027; x=1758379027;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sUHKUamhp6EUEKkcsAy2CiDaBjMKmUsC9OYCqWtNmiA=;
  b=UNw4PDPlSpklH8AeNgYJ4aKTG35YCBm2YdJj6ep+vrCx/gbvP5LE8hy6
   u+OM80d/ANLQPOaf3P6vocWV192yB5iwDMS/7uC1Q75AVPtkSsP6Ybi8y
   2Y0+YYT5/hCQJEJnG3K1ItcqHbyiOaN2msRBm7St3/3iQ7QlAK3UxoPbX
   A3Zu2of/qA/7WUa7giY63aTWZ5SFDMhkel2IJurRuzv2slv2go3EQ56Xl
   Svk332I3MVKZck4j38OK1YjSg92OjbMVXU1Z36RMzjgu8UCT1v9mrzYR1
   zaVlU9Qfs6CsAAoUcLaYO8LNsRQFdBiBYHYWDHJXXWHnKgokFXIdNkhgl
   Q==;
X-CSE-ConnectionGUID: 4wQx5uvHQOmcVsdJguXahw==
X-CSE-MsgGUID: 1MxiuZsASeStSAuDWO1v0g==
X-IronPort-AV: E=McAfee;i="6700,10204,11200"; a="29639308"
X-IronPort-AV: E=Sophos;i="6.10,244,1719903600"; 
   d="scan'208";a="29639308"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2024 07:37:06 -0700
X-CSE-ConnectionGUID: FDiaL0I7T6aX9GnT4MZ+Kw==
X-CSE-MsgGUID: BTKKQQS4Rb+oZn5zvNyUXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,244,1719903600"; 
   d="scan'208";a="93625142"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2024 07:37:04 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1srekn-0000000AwRe-1Mq6;
	Fri, 20 Sep 2024 17:37:01 +0300
Date: Fri, 20 Sep 2024 17:37:01 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Parker Newman <parker@finest.io>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	Parker Newman <pnewman@connecttech.com>
Subject: Re: [PATCH v2 4/4] serial: 8250_exar: Remove old exar_ee_read() and
 other unneeded code
Message-ID: <Zu2IjYstETvhZEl1@smile.fi.intel.com>
References: <cover.1726838531.git.pnewman@connecttech.com>
 <3edee1e670cc214f73a13c0bf127f4ad8e6bce7f.1726838531.git.pnewman@connecttech.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3edee1e670cc214f73a13c0bf127f4ad8e6bce7f.1726838531.git.pnewman@connecttech.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Sep 20, 2024 at 10:03:24AM -0400, Parker Newman wrote:
> From: Parker Newman <pnewman@connecttech.com>
> 
> Remove the old exar_ee_read() and associated helper functions as well as
> some defines that are no longer needed after the switch to using the
> eeprom_93cx6 driver.

You missed my tag. If one sends a new version of the series, they are
responsible to take care about previously given tags.

I'm going to comment on the rest, but something tells me that you might
need a v3 of the series.

-- 
With Best Regards,
Andy Shevchenko


