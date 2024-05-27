Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F0EA73471;
	Mon, 27 May 2024 16:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716827475; cv=none; b=Kf9K+2bD7XSnJ3tV5H5RwnvHgPYKYtmmdWC8FzWMlqWcnjrR0PcpBjm7vYmSKk7lsM7uSNuotumsuNvWoqXehNHxxbXK3aRE9thHsdfqasHZAhboG4jMo3Ji3YAC/LCUS8BRxVFiMkqh48xduCsiEpaFsIJTQ2hFPAI6LbRSe8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716827475; c=relaxed/simple;
	bh=kHiQLHbetuxnlitKhP5pqkXLjWuAvxC6iOHciLI0M8s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tr0e9Ec0m70ZpsxVrzYqqnCvqfo215c/wbauKD/2/JL5DxFLuCCeNLESjEKH6YDChuB7R0yb/AhoI4fcQTLs5ume/3Q5YU3ae/X5FhYoAbnEmyO6BWbnqWHgLyNWWe+mJFKDGymNbsswTQtq13JnZP1xMoIP/UfzB6B4eRkiQ9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WI07Fnqb; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WI07Fnqb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716827473; x=1748363473;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kHiQLHbetuxnlitKhP5pqkXLjWuAvxC6iOHciLI0M8s=;
  b=WI07Fnqby95kK8z1I5NjuUtl0ynOyutIafv1HeoCI2/SiAcjB0nw97lP
   bPOaeLhQxOLjQw7CGRSBv+Ks5JMZNCkhRqqWUmh1tMFExcP4WwHmRucjm
   6J8IybtDUptNcOd5/XjF3kMpJlZHqFo9GAfFcxmL5yUQYl/IcPkle1JtW
   DxjiX3yYHsL/VEDvfOjP3z7w/wlkx+z0IylaTv6Nq6LGLdaaxCBDw6LJd
   KhMQlbwjaihcHXtvk5w2foc0zh9EkKdkKVCAh1FB0RWIkd96FhVx0J6N5
   rD1G41r7SPUhgRFbsiPXN1kLHrk63X3RUE2afIGDj+AeULGyNbj6QM1HS
   Q==;
X-CSE-ConnectionGUID: 3Arsl4kaT5K1mZDLxrG4lg==
X-CSE-MsgGUID: erw5N53jQg656h0CKpMNtQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="12932131"
X-IronPort-AV: E=Sophos;i="6.08,193,1712646000"; 
   d="scan'208";a="12932131"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2024 09:31:12 -0700
X-CSE-ConnectionGUID: PvjWJ3gBSWq0qo3gmJ8euQ==
X-CSE-MsgGUID: 4H5QHxAfS0aPFz5735Kw0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,193,1712646000"; 
   d="scan'208";a="34886155"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2024 09:31:08 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1sBdFZ-0000000BJzV-1GlW;
	Mon, 27 May 2024 19:31:05 +0300
Date: Mon, 27 May 2024 19:31:05 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Markus Schneider-Pargmann <msp@baylibre.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Tony Lindgren <tony@atomide.com>,
	John Ogness <john.ogness@linutronix.de>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	Ronald Wahl <ronald.wahl@raritan.com>,
	Thomas Richard <thomas.richard@bootlin.com>,
	Thomas Gleixner <tglx@linutronix.de>, Arnd Bergmann <arnd@arndb.de>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Vibhore Vardhan <vibhore@ti.com>,
	Kevin Hilman <khilman@baylibre.com>, Dhruva Gole <d-gole@ti.com>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH 3/5] serial: 8250: omap: Set wakeup capable, do not enable
Message-ID: <ZlS1SenIEFnH6TX2@smile.fi.intel.com>
References: <20240523075819.1285554-1-msp@baylibre.com>
 <20240523075819.1285554-4-msp@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240523075819.1285554-4-msp@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, May 23, 2024 at 09:58:17AM +0200, Markus Schneider-Pargmann wrote:
> The driver sets wakeup enable by default. But not all uarts are meant to

UARTs

> be wakeup enabled. Change the default to be wakeup capable but not
> enabled. The user can enable wakeup when needed.

-- 
With Best Regards,
Andy Shevchenko


