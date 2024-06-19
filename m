Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2863682D9F;
	Wed, 19 Jun 2024 12:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718800534; cv=none; b=MyM0dc49oBHW305MY6uBkialO8hV0NyGpbfgU51OsOOeq8WFRlQTCiBlNoxmFvZkb83eFR0bgJUT4Oa0ktgS/nfbsGOmo+O8VphAtKCnNCTjd8CMCKDzafQwh7pz4v+Uac7xIgq0gEi7up38l2LF8JhsRiKKpOAl2k1Wd9ixO80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718800534; c=relaxed/simple;
	bh=bWkehLKbyMN0TQm5ThBcwF/VhXENZa2oHWDKQhP00EU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qwFu51IH+jiDvhP55h1GLYxHutCLJ5fuEzs70+th1cKeZNV8unnYCDufI1YD+BERzn+7WTMNLD2ARvMG4WmyJoogjrY1+CZr+oFDE20GwIc2KZniDeTia9FQkQj2nwtA525jgkVF4DGyffxHPCf0AdGWd46ly2AnrGoYG74D2Ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mRiBkAy5; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mRiBkAy5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718800532; x=1750336532;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bWkehLKbyMN0TQm5ThBcwF/VhXENZa2oHWDKQhP00EU=;
  b=mRiBkAy5AE4cRnwgDVQF3cun2CcBxpItuAQ1uXEmamAaXzowfp94mNla
   WrDTlgAQMz1bTh5bGsl0tEUKmNFPAAwWDb4Y/L57YmjK9juoMNsH5W3xw
   f2m3tSO/hWiwjZudyvzVfvRgC6DbE24aWi08a1nDCzlL2X5pa2lqocAut
   O9y9NKMAY9ooSinzxNBfohYk26PfqgL6wc2nQ7M9REL+1lA5S8dhZD7kw
   FHWJoYC0zL2em6+czaIY6HRyl3WbH3tl71FXXle9HOwYcMZAuAutIb20b
   6Mdly1jIxEAnrgiGrAzcju9nAkSJaZWCNzBMo8tRWKi4Ch0zw3jTRLNVo
   A==;
X-CSE-ConnectionGUID: F32MiXT9RQOESDrQzIegNw==
X-CSE-MsgGUID: XuTwuLIbRhW2dPckvIA73w==
X-IronPort-AV: E=McAfee;i="6700,10204,11107"; a="19607363"
X-IronPort-AV: E=Sophos;i="6.08,250,1712646000"; 
   d="scan'208";a="19607363"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2024 05:35:31 -0700
X-CSE-ConnectionGUID: obv0HVmfRq2JhlnVUf/i1g==
X-CSE-MsgGUID: bzqRP8+KRG+tpAt3p5kEWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,250,1712646000"; 
   d="scan'208";a="46450978"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO tlindgre-MOBL1) ([10.245.247.16])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2024 05:35:27 -0700
Date: Wed, 19 Jun 2024 15:35:22 +0300
From: Tony Lindgren <tony.lindgren@linux.intel.com>
To: Petr Mladek <pmladek@suse.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Tony Lindgren <tony@atomide.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] serial: core: Rename preferred console handling
 for match and update
Message-ID: <ZnLQin5blQ7QDxrz@tlindgre-MOBL1>
References: <20240618045458.14731-1-tony.lindgren@linux.intel.com>
 <20240618045458.14731-4-tony.lindgren@linux.intel.com>
 <ZnGQ8JAu2OQf0GX8@pathway.suse.cz>
 <ZnJg6KQeIs95UFAB@tlindgre-MOBL1>
 <ZnKGGoboxRMwkeWm@tlindgre-MOBL1>
 <ZnLKSEzKBTXYvOMe@pathway.suse.cz>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZnLKSEzKBTXYvOMe@pathway.suse.cz>

On Wed, Jun 19, 2024 at 02:08:40PM +0200, Petr Mladek wrote:
> On Wed 2024-06-19 10:17:46, Tony Lindgren wrote:
> > On Wed, Jun 19, 2024 at 07:39:04AM +0300, Tony Lindgren wrote:
> > > On Tue, Jun 18, 2024 at 03:51:44PM +0200, Petr Mladek wrote:
> > > > It seems to try whether c->devname matches a number "X", or "ttySX".
> > > > It even tries the sparc-specific transformations in
> > > > serial_base_add_sparc_console()
> > > > 
> > > > But this is the original format which does _not_ include ":".
> > > > It never will be stored in c->devname and will never match.
> > > 
> > > Good catch, this won't do anything now with console_setup()
> > > checking for ":" for deferred consoles. So we should revert commit
> > > a0f32e2dd998 ("serial: core: Handle serial console options").
> > 
> > Heh actually we can revert a lot more, basically leaving only
> > the renamed serial_base_match_and_update_preferred_console().
> 
> I wonder if it would be cleaner to revert all patches adding
> the feature and then add back just the minimalist solution.

Yeah let's do that. Otherwise it's hard to see what's going on :)

Regards,

Tony
