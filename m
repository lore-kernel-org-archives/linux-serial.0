Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E45A6144D2E;
	Tue,  4 Jun 2024 13:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717507082; cv=none; b=MdVa1+ax1LfQu3ko2jbhAcKJrNXDVS84O7tGuQtlcZxckoojYGdOlj7pnHunM90s4yRM7hcD3T+V7JCYrDFW1jKL2RT5My0mXpv0/Z80hJrAtGo/Zi0D77lNOZpzYtWjSrzuTI/fLSKnX8nNLncbFk4ZMVeYFYc6oQIHvBl0RmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717507082; c=relaxed/simple;
	bh=lH1YSHW+QRtl0PgeKbxOgI/6+SHrKNvBO9ZLRDA4uzw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t5zHCvnQFcX6GttsljEUCvS1BBob5oOZUW6KFdQLa2wx4REExlLWs5myRCjnw5czRlH5l8a/6vY8txzxz5FVWIzU7oIxyvTpY2o1M336V9cE8hR1c6cTWI6sbpIsNuOEjTXF0C1Mfu8INwHx4rSJE9ekJ16wcmc3vFe67oUVC00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lDoW2IOo; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lDoW2IOo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717507081; x=1749043081;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lH1YSHW+QRtl0PgeKbxOgI/6+SHrKNvBO9ZLRDA4uzw=;
  b=lDoW2IOoc+MgLuenK33eRCe/PyOyz/o+KvHkp3MT96+44SVO7j3ZJHh/
   3JaDoNK4z5RFvA/b5TndDC5CBBNVHSBTVQTP9GGuzS9aoBqTaCYgE6J8m
   40V+IwuZWmSb87eo2CIrMFF9Ge5+5pJ7ZagJ49DN4FjxuuXAr+FFBfiUb
   FSMq6aN3PcytviqNtRdiV9X+Dvrg1uVLYN51Kun273XeHMKMVo/LG8WKb
   QeqxD4YpeJOe4O1LLXzOIfVErn5Kxr4E+k0hM9yHa/XSes2XvDg3jEW6A
   6tWcYCeC13p9MvchkwC2lYn/k3SztW2c3VTKEnuIbzujRzC71gXcQxf0v
   w==;
X-CSE-ConnectionGUID: H6GjsBv/Q0mYKrWfFnA3yQ==
X-CSE-MsgGUID: zBr33mITRBKwbplH7aMNgg==
X-IronPort-AV: E=McAfee;i="6600,9927,11093"; a="14275845"
X-IronPort-AV: E=Sophos;i="6.08,213,1712646000"; 
   d="scan'208";a="14275845"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2024 06:18:00 -0700
X-CSE-ConnectionGUID: npG3c61kQDeJTyufGWscDw==
X-CSE-MsgGUID: x8TPzEm0SRi7mLbo0hmLQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,213,1712646000"; 
   d="scan'208";a="60426903"
Received: from unknown (HELO tlindgre-MOBL1) ([10.245.247.168])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2024 06:17:54 -0700
Date: Tue, 4 Jun 2024 16:17:47 +0300
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
Message-ID: <Zl8T-0zpTYy5GFau@tlindgre-MOBL1>
References: <20240327110021.59793-1-tony@atomide.com>
 <20240327110021.59793-2-tony@atomide.com>
 <ZlC6_Um4P4b-_WQE@pathway.suse.cz>
 <Zll0Mg-Ovqx0n7Zd@tlindgre-MOBL1>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zll0Mg-Ovqx0n7Zd@tlindgre-MOBL1>

On Fri, May 31, 2024 at 09:54:42AM +0300, Tony Lindgren wrote:
> On Fri, May 24, 2024 at 06:06:21PM +0200, Petr Mladek wrote:
> > A solution might be to store "devname" separately in
> > struct console_cmdline and allow empty "name". We could
> > implement then a function similar to
> > add_preferred_console_match() which would try to match
> > "devname" and set/update "name", "index" value when matched.
> 
> This sounds nice, the empty name can be used to defer consoles that
> are not known early. And on console_setup() we only set the devname
> for such cases.

Yup reserving a slot for a devname console at console_setup() time
in console_commandline[] allows keeping the consoles in the right
order again :)

> To me it seems we additionally still need to save the kernel command
> line position of the console too in struct kernel_cmdline so we can
> set the preferred_console for the deferred cases.

Then with the command line consoles in the right order, there's no need
to save the position separately.

And I think then we can also revert commit b73c9cbe4f1f ("printk: Flag
register_console() if console is set on command line"). But I need to
test the fixes some more before sending out.

Regards,

Tony
