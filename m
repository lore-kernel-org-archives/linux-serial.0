Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F8C24756DF;
	Fri, 16 Oct 2026 13:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792157345; cv=none; b=uQAdjHikEN6Wn6Fw90Zby45r3GA9T6hLWlkMRxVCn7e+x5/7DE4DsxipjwzsSlNHhx1zN7fHRXXpvqyE4uNPog86nDcfq+cMB1/6gG9s2TswQBgjx8P/9qoczUJEUrk157TOjeiE5hIvDW3pJWKHiO6zVQ898QVSMsQDeAhlD04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792157345; c=relaxed/simple;
	bh=qrmyAJan3ddL+IKZXWZokvY60Dv+5gWUoDVjnOeoLQ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oQy9hvPanXrzlQD+gN9gK3yAL+ISqRPCsNxKm9zVyIw/cdSN98diPXwFkSNh+dt4w5isGJAdLavFZvR3avv2+eO6pTRGhnVoSfQAb2CiTOQ37GUe+z12B7ioAGljQAKK2dAvyz26w+2LiPYtVLVqZb002jZa7AMujPN8uNq2W0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PTYsndNr; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PTYsndNr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792157344; x=1823693344;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qrmyAJan3ddL+IKZXWZokvY60Dv+5gWUoDVjnOeoLQ0=;
  b=PTYsndNrMSQpfh1t0DL2SsfXUV0T8YM8rR56hG0og/X5f7/5GcCDp27h
   MkPheWTnd4KDM1uAkQoDJSRbB5JkQoX5usk/g7qsO5kXK0GJbWLOrFxXz
   8oSAV1+NW33j6GvHSk5Ln+RbyMVvitqtKhuLGZi16gFlXJ5QdaNTHCEIG
   KN8pMGQHbNc8CctukFNlDLBCSGf4halt3d6qRd4TdhOeYiO8FWUQ++prp
   4BsyeNqab5ZlEIla+RC+GFo8P+BOzf/5YzdPDTwPWOfakzkpoRoF87mRz
   /ixoW7hPPhg1fgyXnnyzFR+B3ShRBXwQfRcM8G8DC8/231KDfRCmNezIO
   g==;
X-CSE-ConnectionGUID: xgHCNzzqSGykkeXxVhWVlA==
X-CSE-MsgGUID: CFt7GvAqRKWf0gdK/APe8A==
X-IronPort-AV: E=McAfee;i="6800,10657,11936"; a="840117"
X-IronPort-AV: E=Sophos;i="6.27,161,1787036400"; 
   d="scan'208";a="840117"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2026 06:29:04 -0700
X-CSE-ConnectionGUID: vuUJ7bOGQ0e1Bv2Ol6WUdg==
X-CSE-MsgGUID: Ra7ZWSNhQ12RHc3GdKsrVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,161,1787036400"; 
   d="scan'208";a="2192496"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.35])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2026 06:29:02 -0700
Date: Fri, 16 Oct 2026 16:28:59 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev
Subject: Re: [PATCH 1/2] tty: serial: remove hub6 multiport support
Message-ID: <atImm4Ixv_PwUqLb@ashevche-desk.local>
References: <20261016130328.1037616-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261016130328.1037616-1-arnd@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Oct 16, 2026 at 02:59:47PM +0200, Arnd Bergmann wrote:
> 
> hub6 support was added in linux-0.99 and the hardware was already old at
> the time, being discontinued in 1990. The code for it has always been a
> mess since it adds another dimension to the I/O addressing in the driver
> that has leaked into many individual files.
> 
> Hugo and Uwe have attempted several times this year alone to isolate
> the hub6 handling into the 8250_hub6.c file, but I feel that none of
> this has been a real improvement over the original standalone loadable
> module support.
> 
> Any machine that would have used this ISA card in practice is likely
> 30 to 40 years old, and with i486 support now removed, it is clearly
> safe to just kill this all off.

Please!

> The only bit that has to remain
> is the ioctl interface, to ensure the serial_struct field is always
> zero.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
But there are some minor issues to fix, see below.

...

>  {
>  	unsigned long old_iobase, old_mapbase;
> -	unsigned int old_type, old_iotype, old_hub6, old_shift;
> +	unsigned int old_type, old_iotype, old_shift;

Move it line up, so we will have reversed xmas tree order.

>  	int retval;

...

> +	/* hub6 is no longer support */
> +        if (new_info->hub6 != 0)
> +                return -EINVAL;

Please, fix the indentation, should use tabs.

-- 
With Best Regards,
Andy Shevchenko


