Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA6C1194AC7;
	Mon, 25 Nov 2024 15:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732549358; cv=none; b=moL/XoHRPZla1oMCMUxmn2vonrU2UN/vFJuh5KI1G8OlMXC3rXoKegXs/ZwDGgIRsPj43SbvSpmskjByv9GnB1Qv2FwQUzA8EkbMs2mFIVChCRFWgUTqohlLG4G8ConpkRywp2SdvN57Zs0RLYXkABI+B5nro7g6Atk1/jx7Ltk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732549358; c=relaxed/simple;
	bh=PHNaIPtpLuflPnpJjfvTbyAjLze0dyFGxfUjiiH5os4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RylIf9gSYH83mkxxWMezvvjdBUiZ/KDYDPsxEMOrXKlca+OA9GzVVeTkpkn9b02K4RHXCTx388QfL4s8SmvftfJSTi/53489sZTbnJwT4M4iCc3K7faJyYBoreTeL7RWiPM8dXzQi1BuWyYUO9o6yxfWpmknz5xMbXMIcKesHwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NDwYwJWA; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NDwYwJWA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732549358; x=1764085358;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PHNaIPtpLuflPnpJjfvTbyAjLze0dyFGxfUjiiH5os4=;
  b=NDwYwJWAmDWfARUU5ia83Xf41rVNBevJEm24/O+lIfOxsS6L4qVQ7zPP
   h8tLyoyPRglsD/v1xtfInynzQcEVB7Y/uIO5znzLuCac0sRHZjrioyr2W
   toie+jHt6WW4336EeFPwDHEUZ19IV1ynuem96Pvga0qFecUOwLdnPXuCm
   OATjHNWUR3oJEtga9AuqmhOhxMTIYQOb2tHT92S7rzlSrX7Yu7maJj/Ln
   l4xq6ZAASHXOi8Pm9ZcNfdThTK+i1MHecMQkzeKaGIU8cZUsXZFkv7YmL
   jNy8pi1dovOGzHXSS9bw8ge4EOPtQ/HBKkigxvgCONM9xBLSDg+m45zin
   Q==;
X-CSE-ConnectionGUID: L5SYgwg5ROmZkFQ+SXbpPg==
X-CSE-MsgGUID: ydSb2VYMSlKA8spWLN4yrA==
X-IronPort-AV: E=McAfee;i="6700,10204,11267"; a="43730032"
X-IronPort-AV: E=Sophos;i="6.12,183,1728975600"; 
   d="scan'208";a="43730032"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2024 07:42:37 -0800
X-CSE-ConnectionGUID: bzEZwAKjQW2g2CdWiyFcbA==
X-CSE-MsgGUID: nyxvDbfiSsecwblypaGx6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="96359634"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2024 07:42:33 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tFbEM-00000000xSn-2zQW;
	Mon, 25 Nov 2024 17:42:30 +0200
Date: Mon, 25 Nov 2024 17:42:30 +0200
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
Message-ID: <Z0Sa5nnKIQm7h-CA@smile.fi.intel.com>
References: <3b75b92805648577ed05ff221d0c56e381aa1c7c.camel@linux.ibm.com>
 <472eb22a-dcb1-4fbb-bf2c-a4173706bc7a@app.fastmail.com>
 <27685942-fb62-44c5-86ed-98beb547ffed@roeck-us.net>
 <744920ba-551c-466b-ac5c-2607b81261a0@app.fastmail.com>
 <Z0QtZky8Sr7qUW7v@smile.fi.intel.com>
 <00f5e842-3ee9-4d83-8836-0ff4f703fa3c@app.fastmail.com>
 <Z0RSZ-YD_BozMs1n@smile.fi.intel.com>
 <be43108e-4135-4927-ba58-141836fde6af@app.fastmail.com>
 <Z0Re61Tk5lN2Xuxi@smile.fi.intel.com>
 <1a7da799-f15b-4714-a3bd-4c0b1f48fc09@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1a7da799-f15b-4714-a3bd-4c0b1f48fc09@app.fastmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Nov 25, 2024 at 02:50:56PM +0100, Arnd Bergmann wrote:
> On Mon, Nov 25, 2024, at 12:26, Andy Shevchenko wrote:
> > On Mon, Nov 25, 2024 at 12:06:16PM +0100, Arnd Bergmann wrote:

...

> >> What I suspect is going on with the f4c23a140d80 commit
> >> is the same bug I mentioned earlier in this thread, where
> >> __serial8250_isa_init_ports() just always registers
> >> 'nr_uarts' (CONFIG_SERIAL_8250_RUNTIME_UARTS) ports,
> >> unlike any other serial driver.
> >
> > But the configuration can give less than old_serial_port contains.
> > See dozens of the explicit settings in the defconfigs.
> 
> I don't see any of the upstream defconfigs doing this
> though, the only ones setting CONFIG_SERIAL_8250_RUNTIME_UARTS
> are those that have an empty old_serial_port[]. 

A-ha, a good catch. I haven't checked the actual contents of the
old_serial_port for those configurations.

> Note that SERIAL_PORT_DFNS is only defined on x86, alpha
> and m68k (for q40), which are the main PC-like platforms.
> I see that all three have identical definitions of
> SERIAL_PORT_DFNS, so I think these should just be moved
> next to the __serial8250_isa_init_ports definition, with
> the entire thing moved into a separate ISA driver or
> an #ifdef around it. This is of course not the problem
> at hand, but it would help separate the x86/isa and
> non-x86 platform device cases further.

It's nice idea, but yes, we can think about it later.

> >> This used to be required before 9d86719f8769 ("serial:
> >> 8250: Allow using ports higher than SERIAL_8250_RUNTIME_UARTS"),
> >> but I don't see why this is still a thing now, other than
> >> for using setserial on i486-class PCs with nonstandard ISA
> >> ports.
> >> 
> >> On non-x86 machines, it only ever seems to create extra
> >> ports that are likely to crash the system if opened, either
> >> because they lack proper serial_in/serial_out callbacks,
> >> or because the default UPIO_PORT callbacks end up poking
> >> unmapped memory.
> >> 
> >> Do you see any reason why we can't just do the version below?
> >
> > Perhaps we may do this way (it seems better to me than previous 
> > suggestions), but it also needs to be carefully checked against
> > those configurations that set it explicitly.
> 
> Yes, at least to make sure that the numbering of the uarts
> does not change. I expect it's actually the same, but don't
> know for sure.

Me neither. And the issue with NULL pointer dereference needs to be retested.

-- 
With Best Regards,
Andy Shevchenko


