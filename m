Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 781881E4AF;
	Tue, 11 Jun 2024 14:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718114510; cv=none; b=GkG+gWodqvobWW+BRypLMfADNXZZK4i4Q3x15c4z6Cl8LK3FtbLZP2ppdt3hUyGim5dwJDYu7Vkn4T5zv5OnP7Qvx7TrMsK3PbqJP26CKXzSuuqMa2dHGTikg1LIeYcoIl5/HrEBrZSZlHUyuDIFx80yZp5Gj0HnD+8eFZZ6bOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718114510; c=relaxed/simple;
	bh=/eF3+dH82g2GsNZ69rvGK6Tn+zGBo8LFU2rgwfQ7mrw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NU9z2MmN2CMMhmxL1w8fRa/AkJpVXK4/JeAnm9k+M27PETnHYz2c30l+VZ1sadwIWjCO1YtPNprCTv8t2SIiRR7sROVdiDpVKwda3JF/nv6eyWHpp+3UZMqQtq9DmNwbS9RLWsM8Ri+rMIpfA/c+kqw5qKNxl7/HdipRjG7hPiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F9TKxwLt; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F9TKxwLt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718114508; x=1749650508;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/eF3+dH82g2GsNZ69rvGK6Tn+zGBo8LFU2rgwfQ7mrw=;
  b=F9TKxwLtyWL5t9WTobKHi9gENHN4nA0DlpbUXjOKgeyotMvGfw0XDCwU
   h9SJKrooSbBkifbXYuGUdy6sPs9Wbl8wlktd+rX+0XNGSBk03XuszIDvu
   6+9ebPz4rN9myVlunSYDA1SLn1wjksEVHFHBfcEijnbfTazWCNFD38QEU
   eUuHl+LGIE7Oq+1d6XY2Hf7ctSIUueAZMMfttbz1c2K1mQih/iAGkyUU8
   VI0hovu++K1b2J2cO2CsZBFJmJoqRunS0Bfc2QpCGzxpVivnQ5s+GpcHD
   vLEcXld3D2+tY21pJCqEMVSA8XZdo6I5NBwcr27K95F0LnuubA3YYxNGG
   w==;
X-CSE-ConnectionGUID: ZIjt1dg5Qr6xT+wu8ZH4Nw==
X-CSE-MsgGUID: UL0ssncyT6SeAcB++5VK9w==
X-IronPort-AV: E=McAfee;i="6600,9927,11099"; a="25450374"
X-IronPort-AV: E=Sophos;i="6.08,230,1712646000"; 
   d="scan'208";a="25450374"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2024 07:01:47 -0700
X-CSE-ConnectionGUID: 1Yt1XmWOTa2EL5X4tuahZw==
X-CSE-MsgGUID: 3SllhWrMTDKcAHtIii7CYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,230,1712646000"; 
   d="scan'208";a="44348659"
Received: from unknown (HELO tlindgre-MOBL1) ([10.245.247.195])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2024 07:01:41 -0700
Date: Tue, 11 Jun 2024 17:01:05 +0300
From: Tony Lindgren <tony.lindgren@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Petr Mladek <pmladek@suse.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Tony Lindgren <tony@atomide.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] printk: Track command line console positions to fix
 console order
Message-ID: <ZmhYoV4ZrNwmIDS4@tlindgre-MOBL1>
References: <20240606114149.118633-1-tony.lindgren@linux.intel.com>
 <ZmgIB2lQaW9oqn3O@pathway.suse.cz>
 <ZmgfZr5ccHATnkAA@tlindgre-MOBL1>
 <ZmhM1VPWhuTggsgf@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZmhM1VPWhuTggsgf@smile.fi.intel.com>

On Tue, Jun 11, 2024 at 04:10:45PM +0300, Andy Shevchenko wrote:
> On Tue, Jun 11, 2024 at 12:56:54PM +0300, Tony Lindgren wrote:
> > On Tue, Jun 11, 2024 at 10:17:11AM +0200, Petr Mladek wrote:
> > >     I would expect:
> > > 
> > > 	serial8250:0.0	-> ttyS0
> > > 	serial8250:0.1	-> ttyS1
> > > 	serial8250:0.2	-> ttyS2
> > > 	[...]
> >  
> > I believe this would be the situation if you make CONFIG_ACPI is not set
> > in the .config.
> 
> This is interesting. So, we still have the DEVNAME differences depending on
> the kernel configuration? OTOH, I can't imagine either how we can get the
> device names more stable as long as some drivers instantiate the platform
> device instead of using 8250 core parts (port, base, core) directly.

Seems we can add translation as needed though. For example, we could add
console=serial8250:0.0 translation to the PNP port. Or console=0x3f8,115200.

Regards,

Tony
