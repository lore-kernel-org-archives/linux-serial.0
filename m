Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A81E62F0059;
	Wed, 16 Jul 2025 10:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752661698; cv=none; b=dgv9vVmxCaKTcCGAK14N/wZJALTN2qpvA9f/PnVflxI/+C1YvDJd+m9vns4ez82lUi4zP7s7DVNe0H1mluDEWRdAHOG7NMl39190/z0AwqLGDXcomAqvPecb+RqYXmqTwbVzGe7CNDgZ6+LeL7uPpAZ7IyXpJJusskWyyZ0MQCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752661698; c=relaxed/simple;
	bh=kiyCXcRdDBVQSFSC16x/RWFcYmB4yzwGHVLM9MVw7tI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=flpO7tj/GlpwWJ5Emb5F00K7Mlpv0vSjkNDW9lbG953eqf21xeuhCywH0hvuzTBI/4k0Xj9gvS3Su4DemmIsnpkQrQg4ytVfpCkYg566zYY/yBma7uAX+/U29gQuyoBlJINa411iMUGLsBLt25YiS1OY4X/mzXoiFxDDocizrbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FbdRHDEN; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FbdRHDEN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752661697; x=1784197697;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kiyCXcRdDBVQSFSC16x/RWFcYmB4yzwGHVLM9MVw7tI=;
  b=FbdRHDEN6gQHIACa91RkAAEdsi0mxv1P6JQ7k7MDKy5vDaZ5xPcDOo/a
   GHarasytLfyoNSqaxvlca4IDFlYRh+smlwshucVMyXpu2PovC6wpV0vAu
   1tQ23wHSuRrbYFcM/kudFZtDM+IRN07sz/xMCNxQFin8u9suSc8c3qcec
   Ag2roZyack4pu5nox4xP/XQ2PmuMRVSJKUxsTJob+P/oNcwo2ksOGeZ7Z
   tVvwzrIPn5SMr2mx0raxBDY4LlnRUaO29z52uxTba3RGZrRG9RoP9Xumz
   UMXMhDNJvzF2V1Xo5OkWvmLDCOkGrbZ6XEIg3ufolej0IZGw/ItJIi9Rj
   g==;
X-CSE-ConnectionGUID: AjeauYYtSgy9gQ+Aa8FCUg==
X-CSE-MsgGUID: i7aQl3ZtTAyWMg05Wuippw==
X-IronPort-AV: E=McAfee;i="6800,10657,11493"; a="54839804"
X-IronPort-AV: E=Sophos;i="6.16,315,1744095600"; 
   d="scan'208";a="54839804"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2025 03:28:16 -0700
X-CSE-ConnectionGUID: zeAya05JTRGy3WKrpWQ1Vg==
X-CSE-MsgGUID: FpRgiIpMQQ6CqpQgFS1LXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,315,1744095600"; 
   d="scan'208";a="162019151"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2025 03:28:14 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1ubzMx-0000000FueQ-1thm;
	Wed, 16 Jul 2025 13:28:11 +0300
Date: Wed, 16 Jul 2025 13:28:10 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jiri Slaby <jirislaby@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v1 1/1] serial: 8250_ce4100: Fix CONFIG_SERIAL_8250=n
 build
Message-ID: <aHd-urMzXlOJPDAm@smile.fi.intel.com>
References: <20250716094433.1611477-1-andriy.shevchenko@linux.intel.com>
 <a3240539-04b1-4141-95b8-fde193afa25d@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a3240539-04b1-4141-95b8-fde193afa25d@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jul 16, 2025 at 12:14:23PM +0200, Jiri Slaby wrote:
> On 16. 07. 25, 11:44, Andy Shevchenko wrote:
> > On i386, when
> > 
> >    CONFIG_X86_INTEL_CE=y
> >    # CONFIG_SERIAL_8250 is not set
> > 
> > will try to compile the driver and use the stub simultaneously.
> > This breaks the build. Fix it by making sure that the driver
> > compiles only when CONFIG_SERIAL_8250 is also enabled.

...

> > +ifneq ($(CONFIG_SERIAL_8250),)
> 
> Why not ifdef CONFIG_SERIAL_8250 then?

$ git grep -n '^ifn\?eq .*CONFIG_' | wc -l
427
$ git grep -n '^ifdef CONFIG_' | wc -l
431

Is there a preference in serial drivers?

> Also, what happens if 8250=m and X86_INTEL_CE=y?

So, in such a case if somebody wants to use UART, it will go crazy due to
missed workaround applied. BUT, this is preexisted issue and not related
(directly) to this fix. Perhaps we can combine both with

ifeq ($(CONFIG_SERIAL_8250),y)

and add two Fixes tags.

> >   obj-$(CONFIG_X86_INTEL_CE)		+= 8250_ce4100.o
> > +endif

-- 
With Best Regards,
Andy Shevchenko


