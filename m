Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A933E3D98;
	Mon, 19 Oct 2026 10:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792405434; cv=none; b=tWf/D5c8Wqw8mI1C3nMiC65AYRJpQAmHyokzyRaDUdjct3u6j0VzTcFpUuiAdVQ9QIQlF56Qpn2GKbO70A4u1uX3jZJS4ZynjoXplT8fkSR6C+TzEkXkUlLOArVr3slFJI8unYt31yARetB7CBPUH6R8PgyYX1QtdpAB0fhK+go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792405434; c=relaxed/simple;
	bh=9VzqnfsKgVI4xeMFnPXxt+ZOkbS48oKRvMkL140eyeo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O86zN4PYYG33oOlrH20gGpi9GITQ+PorwHsKgiv1WnzrBv1pWFGkam+TUMaTuoRYfrp9K/6+eoQ4JBEztzMIhkKXAUc2pgmlr4pbg+ZfXAlUeKaYi3UTExwVrKB4JsA1gqCKQUkfUGPqkKT9Xm/POWH3N8oi9E+cxWwf1GUQcKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IHasDC4v; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IHasDC4v"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792405433; x=1823941433;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9VzqnfsKgVI4xeMFnPXxt+ZOkbS48oKRvMkL140eyeo=;
  b=IHasDC4vKzP9C9a87LL+E9CbgJnioxXUswkYtNgzAvNAsnRjgoeOq5lh
   zWmtYQLrlX5HshfCxuTRyQODPfD/dSfdCL0lFxdgAug9l26458f3sypb+
   yiPMvN3mcFKjgKPaz3M2DEK6f5fX4fliDKJJMZ5CiacrqpcyhuK2wdHNR
   AsYRXpBzwV6OZKm+8TLfOWp8EeoVXxFWyOlox7u8jwlf4fEPOb9wA2bg7
   SSZZVzaNB1eBNduu87vwMOsck3iAYnLt7JGEa2G/i3e+t2tAUDYpnUhRp
   8hQnJc/W4UrTq8DRaqgtVgQCpfDlSLSbrW8i91mLSCjDfk9AXhrdlp4ni
   g==;
X-CSE-ConnectionGUID: vfJvOX5zQqWHpMZbRK+CwQ==
X-CSE-MsgGUID: g+RdlvUkR/y64QNK8PTKSQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11939"; a="967833"
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="967833"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 03:23:52 -0700
X-CSE-ConnectionGUID: 8fzqUgtpR5SeoJwRSL+ojg==
X-CSE-MsgGUID: OIbKtny1TMKwGPZshtf9gQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="4344007"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.209])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 03:23:49 -0700
Date: Mon, 19 Oct 2026 13:23:47 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH] [v3] serial: 8250: remove obsolete and broken PORT_RSA
 support
Message-ID: <atXvsxjAXcOmsCAV@ashevche-desk.local>
References: <20261019090017.430425-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261019090017.430425-1-arnd@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Oct 19, 2026 at 10:56:55AM +0200, Arnd Bergmann wrote:

> For all I can tell, the RSA support in the 8250 driver is not functional
> and has not been for a long time.
> 
> The RSA-DV II/S ISA card[1] was sold by IODATA in the 1990s as a faster
> alternative to regular ISA serial ports, and it was discontinued in
> 2002. Linux support was added by Kiyokazu SUTO in 2000.
> 
> The driver defines an I/O port base address of -8 (negative eight),
> which should always get refused by request_region on all architectures
> for being outside of the valid resource range.
> 
> Further, it seems that a patch to setserial would be required in order
> to set PORT_RSA when not using autoconfiguration.
> 
> This patch removes all code related to the RSA support, with the exception
> of the user-visible PORT_RSA definition.

> Link: http://translate.google.com/translate?hl=en&sl=ja&u=http://www.iodata.jp/products/network/rsadv2s.htm

Can we get this without translate? As it adds an unneeded layer.

> Link: https://lore.kernel.org/all/1309211120-2803-6-git-send-email-arnd@arndb.de/

Also would be nice to add references to the Link tags like [1] and [2] and
mention them in the commit message where appropriate.

> Signed-off-by: Arnd Bergmann <arnd@arndb.de>


-- 
With Best Regards,
Andy Shevchenko


