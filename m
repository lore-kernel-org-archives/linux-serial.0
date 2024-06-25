Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5667D1494B2;
	Tue, 25 Jun 2024 09:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719306456; cv=none; b=dI6k3tk2hg14+TM7dsnebZ9OT3WYisVP1omWS3hND3JwyjhxGZUseIAN+U+PzJ+VseQG/LzhxpSXRszAqvHR7iIvBT+wH/AewG4pQfevshtU7ypDKOC4S5tgrCHEAxltCxgOZsy4zISoik2XoyTakr4lUnQBwIkj2pNqVCESAJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719306456; c=relaxed/simple;
	bh=FPBLWpIySdiT64ZGcbMIqX3pSE/qddtPDIhVXAyZM3c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gh/+CVGY0IGeK6fgWtNaUDc/89oNODVZfIecjEJ83LmvFnvtKs3Qi7/ym27Cz0eT2KQOg87P39cy5tSF03clq8701d+kOaggj8oTJ0tHMEsmY05kD0Y8XZOnXaZxbfvQ+V6DgD4LuzyQGFzWfKeHbA7KM2FY9fw4s6e8RxOpU3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IQpc9bDc; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IQpc9bDc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719306455; x=1750842455;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FPBLWpIySdiT64ZGcbMIqX3pSE/qddtPDIhVXAyZM3c=;
  b=IQpc9bDcZWMVMq5VwjieZ7g78xIWj0emc+O2VcUffoiO9O+6Xf0/SY4Y
   JuShBzHFCT5jfkqviIr6PHIIpylmZYMZtZRWQ6byWptx2gQO6uA7hitbn
   cEmbJor+n4mQ9zdI7KgjsoXxrUgooVP/pOCK7x8Xc+5qK0L5DSI4f/KdA
   LkkbyFE+TzUqHMFJk407u512VohgGrQcsPXvkDoSYE4YtnI0sNTKVYg5q
   KNTBNR0hbaF9kmF+zDcamLbejHq4zg+htrjN7TQYI2Q+ovY57N+uDDVii
   FYF6olfT3VwrvurHJfvGXDDs4HsulIKGm2qgwYupeG2vYAZsqrV5E5IYd
   w==;
X-CSE-ConnectionGUID: xu4WKmI4SwGOVs3v+T5B3w==
X-CSE-MsgGUID: DX3oCvBFSDCu+flgiVnUeQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11113"; a="33847333"
X-IronPort-AV: E=Sophos;i="6.08,263,1712646000"; 
   d="scan'208";a="33847333"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2024 02:07:32 -0700
X-CSE-ConnectionGUID: aXM/UFz4SgGQ+hH8ddWv5w==
X-CSE-MsgGUID: j6iP4eI7RfCJZrqSM/8SLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,263,1712646000"; 
   d="scan'208";a="44227663"
Received: from unknown (HELO tlindgre-MOBL1) ([10.245.247.67])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2024 02:07:28 -0700
Date: Tue, 25 Jun 2024 12:07:22 +0300
From: Tony Lindgren <tony.lindgren@linux.intel.com>
To: Petr Mladek <pmladek@suse.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Linus Torvalds <torvalds@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Tony Lindgren <tony@atomide.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/4] Fixes for console command line ordering
Message-ID: <ZnqIykv2_4xb1Q6E@tlindgre-MOBL1>
References: <20240620124541.164931-1-tony.lindgren@linux.intel.com>
 <ZnWRup3MvcVQ4MX8@pathway.suse.cz>
 <2024062403-skid-gotten-7585@gregkh>
 <ZnpRozsdw6zbjqze@tlindgre-MOBL1>
 <2024062551-hubcap-bauble-fae5@gregkh>
 <ZnqBYAV7iplmeh1R@pathway.suse.cz>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZnqBYAV7iplmeh1R@pathway.suse.cz>

On Tue, Jun 25, 2024 at 10:36:17AM +0200, Petr Mladek wrote:
> On Tue 2024-06-25 08:20:06, Greg Kroah-Hartman wrote:
> > All now reverted, thanks!
> 
> Great, thanks Greg!
> 
> Tony, could you please send a new patchset which would provide
> the new solution on top of this revert? It might make sense
> to wait until the revert reaches mainline.

Yup will do.

Thanks,

Tony
