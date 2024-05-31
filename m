Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 168E07FBAE;
	Fri, 31 May 2024 06:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717138498; cv=none; b=Ip7+UhdlfVkBCv+keSJ/NzzrYK1E3K7Lt7dMcfryv8hkeJW6t92TQt+Dxm2AUMUkKbH0Q9fUESau58OAeKkC77DKRrL4KFEzjr+ildxobEN72t28BykTsjhWBx/EozHQPgy+2HZDGicP/lDOY3SvZ284WN0KJfqQ6S5UZvlEH18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717138498; c=relaxed/simple;
	bh=vj/iKG5SOv70qFtt9ZacYP3jJGUG03ItpLbMK39Ejt8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mEVxeDd7GZjlvLxTzxo8mDVsPgqMbOK5QbeUCQgAbz6C4qGf1DYtcQ8L1ctag5XUTq1BTKvzwYYz938FevAz2GSQI3wJkgFbhWXnRUt2EBEb52RzgQoE27IpB8OO7jDOLNt9o/7TWuM2YEWr3zVxlU/78qE1fGL4jj8aD2Z1ZIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BcVRHzov; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BcVRHzov"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717138497; x=1748674497;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vj/iKG5SOv70qFtt9ZacYP3jJGUG03ItpLbMK39Ejt8=;
  b=BcVRHzovUhu8czM/PT5y8VV+EVAdY4Q8XEKIl6GWnJTrhVK7havS+Ks3
   PYO2Djc8o4MxuAw9Aqe6M2zcL2II3uHHD7WxF8f1OttZ7NdrzPnnBEXhV
   PL+A25/45kL0Ds01VIzxTwTuu8BK3dkCPMbDjMOI2c+MZ48GxDD7Toloa
   dRl6PxdWVAUJYLPzxogj6nRI9bAtxUKgrYku33Dqa4BDqwS0iqaMzA+kQ
   l1q4I+y2zouLRFkb8Ducme5lAWFy/N+FK4noGF2mI7uHoKSv/EmZyhwFg
   +/NyRebqxboLU85oNBG/tbMZH4CIVk4VEbBt8SlefvL4iWQSiGmjL5Rax
   w==;
X-CSE-ConnectionGUID: 0auM96zMRDO20Koa43zoOQ==
X-CSE-MsgGUID: 6ndYnhpjRiO1SP16efHrrg==
X-IronPort-AV: E=McAfee;i="6600,9927,11088"; a="13507510"
X-IronPort-AV: E=Sophos;i="6.08,203,1712646000"; 
   d="scan'208";a="13507510"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2024 23:54:57 -0700
X-CSE-ConnectionGUID: 7bYeZLVjRP201gzqW9q7GA==
X-CSE-MsgGUID: inShIAHCT7W0bVAdMoLxrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,203,1712646000"; 
   d="scan'208";a="73549945"
Received: from rrware-mobl.amr.corp.intel.com (HELO tlindgre-MOBL1) ([10.125.108.14])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2024 23:54:50 -0700
Date: Fri, 31 May 2024 09:54:42 +0300
From: Tony Lindgren <tony.lindgren@linux.intel.com>
To: Petr Mladek <pmladek@suse.com>
Cc: Tony Lindgren <tony@atomide.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	"David S . Miller" <davem@davemloft.net>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Dhruva Gole <d-gole@ti.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Johan Hovold <johan@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Vignesh Raghavendra <vigneshr@ti.com>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, Sebastian Reichel <sre@kernel.org>,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v7 1/7] printk: Save console options for
 add_preferred_console_match()
Message-ID: <Zll0Mg-Ovqx0n7Zd@tlindgre-MOBL1>
References: <20240327110021.59793-1-tony@atomide.com>
 <20240327110021.59793-2-tony@atomide.com>
 <ZlC6_Um4P4b-_WQE@pathway.suse.cz>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZlC6_Um4P4b-_WQE@pathway.suse.cz>

On Fri, May 24, 2024 at 06:06:21PM +0200, Petr Mladek wrote:
> A solution might be to store "devname" separately in
> struct console_cmdline and allow empty "name". We could
> implement then a function similar to
> add_preferred_console_match() which would try to match
> "devname" and set/update "name", "index" value when matched.

This sounds nice, the empty name can be used to defer consoles that
are not known early. And on console_setup() we only set the devname
for such cases.

To me it seems we additionally still need to save the kernel command
line position of the console too in struct kernel_cmdline so we can
set the preferred_console for the deferred cases.

Regards,

Tony
