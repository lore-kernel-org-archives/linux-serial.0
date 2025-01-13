Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F9502045A1;
	Mon, 13 Jan 2025 09:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736762390; cv=none; b=UgGrKiydxePM1xyduTp3E6d9su7oDidPbwtc2zfzCGSVIObUzR8GOLNzlWH8Q9yhRxkBm85QF3G4+w5bTT84wgGUowOX9Knl5Og05tOWlHj6KHKgnniGShYP3e03AixW2lGIAg/oxKh6Jk8GxegCdMB/3BTQwNd4yYI6fyyEdUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736762390; c=relaxed/simple;
	bh=ouxShzMm5u2j9IidKtK1k10IGg7ZY7t1ipBOjy62xYY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MKAPUWGySFH465cmyaQ6eYP7LPJEwGkYioLbh/jHHLUkQa3JumKXu0q9E4JdGEmbQEeqJeCDDnRg5woPCW6Sde3q3gbkb2CY5Am+mVdLjYhGoOTVofQQPVxwA2kFk7z6PDTql/LtkplwqeocySpXhnEdbtFdA5GQvu8zoJymOgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ludXUZAO; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ludXUZAO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736762389; x=1768298389;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=ouxShzMm5u2j9IidKtK1k10IGg7ZY7t1ipBOjy62xYY=;
  b=ludXUZAOiQQOrlp1VHceYXMaRrK4LBGqWGwiFm1bXE07RrmSWqaW0sqo
   GM+bhSWD5TC4PT6mdQDzwPsp1ySWauB9s8RLoWNkRbbXEG34nkNoQSF8x
   72vH0LcYu6jZTwAA+lkwjNnIgWjgPM610zUuTt/2EK57FI6tjBn+WlU62
   d9/ks1QLZZRWRbe/Qhgm9n5ADUQjL0XRsKEfSWMQ9VTeAY7fVojzSE3Dh
   sa1sMCy0U7QcZaOZOLYHnZyCmW/aCF76B3J3KjWiOmMjQguz2PdNqdaUw
   fTkq+GcqQLOzFA6rPHzzclfW5RQGFbg2ahO/Qm5DCHnCExJf7vNDh5I5h
   A==;
X-CSE-ConnectionGUID: jm+U/AX3SP+FXDzGXjqMpg==
X-CSE-MsgGUID: u6Kk2YLDSVWUYhUQh0/TVw==
X-IronPort-AV: E=McAfee;i="6700,10204,11313"; a="47506318"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="47506318"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2025 01:59:49 -0800
X-CSE-ConnectionGUID: wVVuQwqvTJ6HkTC6EtCPTA==
X-CSE-MsgGUID: iYez5S/dT2SZ0vm+iLv5NQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="108487447"
Received: from unknown (HELO smile.fi.intel.com) ([10.237.72.154])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2025 01:59:45 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tXHEU-00000000PhB-1Izy;
	Mon, 13 Jan 2025 11:59:42 +0200
Date: Mon, 13 Jan 2025 11:59:42 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: WangYuli <wangyuli@uniontech.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, Arnd Bergmann <arnd@kernel.org>,
	Niklas Schnelle <schnelle@linux.ibm.com>, pnewman@connecttech.com,
	Sunil V L <sunilvl@ventanamicro.com>,
	"Paul E. McKenney" <paulmck@kernel.org>, zhanjun@uniontech.com,
	guanwentao@uniontech.com, Zhuozhen He <hezhuozhen@uniontech.com>,
	Guowei Chen <chenguowei@uniontech.com>
Subject: Re: [PATCH] serial: 8250_it8768e: Create iTE IT8768E specific 8250
 driver
Message-ID: <Z4TkDgYSSm7nwUhY@smile.fi.intel.com>
References: <41B1320691916DE6+20250109120808.559950-1-wangyuli@uniontech.com>
 <11805e8c-c97b-4297-9c04-462fa1932ce1@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <11805e8c-c97b-4297-9c04-462fa1932ce1@app.fastmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Jan 09, 2025 at 01:40:14PM +0100, Arnd Bergmann wrote:
> On Thu, Jan 9, 2025, at 13:08, WangYuli wrote:
> > [ General description per its product manual: ]
> >   The IT8768E-I is a highly integrated Super I/O using the Low Pin
> >   Count Interface. The device’s LPC interface complies with Intel
> >   "LPC Interface Specification Rev. 1.1”. The IT8768E-I is ACPI &
> >   LANDesk compliant.
> >
> >   Integrated in the IT8768E-I are five logical devices, which can
> >   be individually enabled or disabled via software configuration
> >   registers, and four 16C550standard compatible enhanced UARTs
> >   perofrmacing asynchronous communication. The devices also provide
> >   GPIO port controlling up to 12 GPIO pins.
> >
> >   The IT8768E-I utilizes power-saving circuitry to reduce power
> >   consumption, and once a logical device is disabled, the inputs
> >   are inhibited with the clock disabled and the outputs are
> >   tri-stated. The device requires a single 24/48 MHz clock input
> >   and operates with +3.3V power supply. The IT8768E-I is available
> >   in 48-pin LQFP.
> >
> > It has been determined that this chip is currently employed within
> > YIHUA STS-320 intelligent teller terminals utilizing
> > PCBA F21-2401 D2000 MB VerA LF motherboards.
> 
> Can you explain why this isn't done as part of
> drivers/tty/serial/8250/8250_pnp.c?

I assume you meant 8250_platform.c. PNP is for devices went through legacy PNP
enumeration, most likely having IOPORT instead of IOMEM.

Recently 8250_platform.c was expanded to cover ACPI IDs and it seems they have
proper ID allocated for their device, so that's where it seems best to fit.

> I see nothing unusual in here that requires a custom driver.

+1.

-- 
With Best Regards,
Andy Shevchenko


