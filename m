Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4CD0498922;
	Mon, 19 Oct 2026 10:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792405509; cv=none; b=lpyw3l7BUWtsrHJh/OYjfwLDgbkw0eEpjcopNUW87CEAKus1kUaBsUr3pmdEHgqMQgdl8enlMzjVhU8jARtvUo4WPJCflaTUT9X6x7OaqlOohnVEThd/303U1c17lLHEIy7M41cisfQSCsM5Y4l+GmnMedwqX+dDOXdmc/VH0I4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792405509; c=relaxed/simple;
	bh=lrvKOD4CrjDosGmOahxy1/uwlMTKm3RDvo0UhHcLKdc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=keUkEgAKZ5YFR+6VCPIfN0WwsaTQ8eS+/lwV0qRa/5XmrbfAwFGEhNMKv5LmENXYV2iaGSktYM73TVsPL+LVlwdIP/jE7VBPmV0PW74/7c/5B3cs6UaBgLq8EGvErgE6Jo5kI5At/lbx8KMhGINb4NbCVzv6nDUqIy8VpdA+uaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l+gCPwl/; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l+gCPwl/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792405509; x=1823941509;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lrvKOD4CrjDosGmOahxy1/uwlMTKm3RDvo0UhHcLKdc=;
  b=l+gCPwl/7/6y/Jv/MOvdz2J+5AMK/jk4z4iLiXQwsmYuYYUTRKFgKNad
   cd0bbBl5OldsWVMGktg3NuY9aVPcRRwFfGxdzU03J/UwvJNzLfxb5TfML
   aRhrExkfxb8JOjYcaNurZ9JgDZfJilEVmbsD2UjGnyEO4qcBhyWGKYryh
   vPo5FZChjUAZVcgEphpWkpfealfxWzGwyXLf6Qpt0CP7xW1Vu3jtwBeVX
   5UQ4SZgkZy1GERpGiD7Com1TyUhLVcEJ6c3Utsd2uatWW/xanxa/d7MXi
   Toq5EtPFEB4uBJ/yPF3TPz1nzc4ITqAkp57Hi7TNSHuiDprJ+ggYG86j7
   Q==;
X-CSE-ConnectionGUID: he3amK3iRwe79Iz/BVYtfg==
X-CSE-MsgGUID: RsZcOVD9Ry6My1YAQP36SQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11939"; a="966194"
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="966194"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 03:25:08 -0700
X-CSE-ConnectionGUID: KCXlyIDqQZ++O0gwYxrbJQ==
X-CSE-MsgGUID: sBMJoexSTWe0UrtfCiONzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="4259176"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.209])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 03:25:05 -0700
Date: Mon, 19 Oct 2026 13:25:03 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Arnd Bergmann <arnd@kernel.org>, Jiri Slaby <jirislaby@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH] [v3] serial: 8250: remove obsolete and broken PORT_RSA
 support
Message-ID: <atXv_0ZdC5xalCKh@ashevche-desk.local>
References: <20261019090017.430425-1-arnd@kernel.org>
 <2026101952-wham-earthly-c149@gregkh>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2026101952-wham-earthly-c149@gregkh>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Oct 19, 2026 at 11:39:20AM +0200, Greg Kroah-Hartman wrote:
> On Mon, Oct 19, 2026 at 10:56:55AM +0200, Arnd Bergmann wrote:

> > For all I can tell, the RSA support in the 8250 driver is not functional
> > and has not been for a long time.
> > 
> > The RSA-DV II/S ISA card[1] was sold by IODATA in the 1990s as a faster
> > alternative to regular ISA serial ports, and it was discontinued in
> > 2002. Linux support was added by Kiyokazu SUTO in 2000.
> > 
> > The driver defines an I/O port base address of -8 (negative eight),
> > which should always get refused by request_region on all architectures
> > for being outside of the valid resource range.
> > 
> > Further, it seems that a patch to setserial would be required in order
> > to set PORT_RSA when not using autoconfiguration.
> > 
> > This patch removes all code related to the RSA support, with the exception
> > of the user-visible PORT_RSA definition.
> > 
> > Link: http://translate.google.com/translate?hl=en&sl=ja&u=http://www.iodata.jp/products/network/rsadv2s.htm
> > Link: https://lore.kernel.org/all/1309211120-2803-6-git-send-email-arnd@arndb.de/

> Any objection for me to sneak this into 7.4-rc1?

This is a good removal change, but I would like to make Link tags neater, if
Arnd sends a v4 sooner, I will tag it for early v7.4 (which is indeed a good
candidate to have this).

-- 
With Best Regards,
Andy Shevchenko


