Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BEC51DE3B6;
	Thu, 16 Jan 2025 12:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737030403; cv=none; b=hRhhisBk7xYzQGtPyKOnkUQAs+STxQTH85qcUNyz8bHkFIQnAm+2bfPab3TdYT4R0kNsAagIvx5EeUbS9IiL4HfID+SLLYpHsXoAVykhaNHk0GY2ThciCuvMntm4Mfq88ofSkYQpYMWDFcbV1SA44p9GbHVsXqbYlAoNAWkSiTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737030403; c=relaxed/simple;
	bh=F2ZVEXZ7JZHgWfiaydY+HrCORK5YO8uKcZcJMC1o4JM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e8ShdZ8r7L4os3WwNhYaeph/CgDSW5TbpoX9cwgjwCmtGPraGbkBLwXgdNXmTs+uo39yckv7v2svFlssJviAx/xzSUdddKp++l/jiU0eKxNkjll1YV/S94iRuq60rEFqtDWfEhQ+1TVtiml6J34w7dmthYaDlynpv3Jz3PQVF7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Xb0fIbMH; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Xb0fIbMH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737030402; x=1768566402;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=F2ZVEXZ7JZHgWfiaydY+HrCORK5YO8uKcZcJMC1o4JM=;
  b=Xb0fIbMH+9jNHbh50NC7qwNsWXqy3HrP/IQbi3QI+fxu0d2Jx7ADr7rq
   y6+iAJcOZuPMH0WFxKG8fueFV6HdatJBQUH8UywNf6hLlz/ZlJvLhEPLE
   sLbRSw+xQpDEAUfSKR5EEKbxqAQETcaiPEzJAZuQWerstrNQtaiGX9sa2
   oyMWqhBccKU4fu6tB8ZiGIMjkQU8EA5j0nKllWty0wQbLHWmU1XOYczci
   HYxiutp1UAg4eWBoGjfx6+40yjfqVj2Wa1fZugIwEqnxUOeANPxbB/PYg
   VotE+VrC+3+jA6TatrVHKqGFwcGfANnT7WV6AzwRqtAq0mDMjbMMpSzla
   A==;
X-CSE-ConnectionGUID: DJ9WmytVTGKLd7M0ds39uQ==
X-CSE-MsgGUID: j0W2sUBuSS+FV9canOvRyw==
X-IronPort-AV: E=McAfee;i="6700,10204,11316"; a="54827009"
X-IronPort-AV: E=Sophos;i="6.13,209,1732608000"; 
   d="scan'208";a="54827009"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2025 04:26:42 -0800
X-CSE-ConnectionGUID: 0e15t8+TQQqRgWNVRs3fMQ==
X-CSE-MsgGUID: ybzbBef6RVqcTS4lIZOLZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="128735713"
Received: from unknown (HELO smile.fi.intel.com) ([10.237.72.154])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2025 04:26:38 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tYOxI-00000001fGO-00uI;
	Thu, 16 Jan 2025 14:26:36 +0200
Date: Thu, 16 Jan 2025 14:26:35 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Guenter Roeck <linux@roeck-us.net>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-serial@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
	linux-kernel@vger.kernel.org,
	Yang Yingliang <yangyingliang@huawei.com>
Subject: Re: [PATCH 1/1] tty: serial: handle HAS_IOPORT dependencies
Message-ID: <Z4j6-ysRfyThWq6R@smile.fi.intel.com>
References: <744920ba-551c-466b-ac5c-2607b81261a0@app.fastmail.com>
 <Z0QtZky8Sr7qUW7v@smile.fi.intel.com>
 <00f5e842-3ee9-4d83-8836-0ff4f703fa3c@app.fastmail.com>
 <Z0RSZ-YD_BozMs1n@smile.fi.intel.com>
 <be43108e-4135-4927-ba58-141836fde6af@app.fastmail.com>
 <30a38025-afae-4bdf-a468-21ae2cd5a7b3@app.fastmail.com>
 <4446d7dc-efb0-4395-8fcb-7177d9e07b5c@roeck-us.net>
 <acdab483-05a4-4fa8-ae1c-70ed53402aa2@app.fastmail.com>
 <Z1Mb15vOY4fJjsKt@smile.fi.intel.com>
 <e855900a-28d2-424b-8b3e-63c3c10c2848@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e855900a-28d2-424b-8b3e-63c3c10c2848@app.fastmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Dec 06, 2024 at 05:02:04PM +0100, Arnd Bergmann wrote:
> On Fri, Dec 6, 2024, at 16:44, Andy Shevchenko wrote:
> > On Wed, Dec 04, 2024 at 11:17:56PM +0100, Arnd Bergmann wrote:
> >> On Wed, Dec 4, 2024, at 22:09, Guenter Roeck wrote:
> >
> >> I got stuck in this rabbit hole of running into more issues
> >> with the 8250 driver. Any time you touch something, it breaks
> >> elsewhere.
> >> 
> >> I've uploaded what I have here now:
> >
> > FWIW, I have briefly looked at it, some patches I appreciate very much, some of
> > them I think need more testing and one thing I don't really like is putting
> > code back to 8250_core. Thinking about that, perhaps we need to restore 8250.c
> > (or alike) for collecting non-library / non-_particular_-driver-leaf?
> 
> Thanks for taking a look!
> 
> I thought you might have different ideas on where some of the
> code needs to go,  as you were the one who moved it out
> previously.
> 
> However, I think the two bits that I ended up moving back
> really belong in the core:
> 
> - serial8250_setup_ports() is needed to get the
>   serial8250_ports[] into a sane state. Ideally this
>   array would just be statically initialized, but I don't
>   think we can actually express that in C code.
> 
> - serial8250_init()/serial8250_exit() are required for
>   registering the driver itself (serial8250_reg) Having
>   that part in the ISA driver made no sense to me.
> 
> The bit that is definitely ugly is how serial8250_isa_init()
> gets called from serial8250_init() and univ8250_console_init(),
> and I would prefer to remove that, but any attempt to do
> that made it worse.
> 
> The problem here is that we can't just rely on link order:
> For the console initcall and  serial8250_isa_init_ports(),
> we have to call this before the core driver initialization,
> but the serial8250-isa platform device has to be registered
> after the core driver does. If we link both files into
> a loadable module, there is an additional problem of
> not being able to have more than one module_init() call.

So, that's what I meant under resurrecting 8250.c or so, we can leave platform
driver to be still platform driver and call the respective init and exit
routines from the (newly) created module that will have the main
module_init/module_exit calls along with non-library common code.

-- 
With Best Regards,
Andy Shevchenko


