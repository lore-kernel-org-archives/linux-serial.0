Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 850D023A566;
	Thu, 30 Apr 2026 15:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777561636; cv=none; b=utctkWfIdj58R6KDoRIlj7NBKo8yRT8sylWOhlNz5vik4lCzDQsnPHpm4XRIN9D8mc0ji5hfgV/4NaIznP0ylLsr3EYOr0sDIwR17SqDo+xbfg/j7UxYlAhthWg/+NdMin9QbYDg+lDnwUYKtzYe26Q9Hx1OIVO+uxeDVnjPBN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777561636; c=relaxed/simple;
	bh=ku6j8SUaRtnyIN+0BuklJ64MeIIZdiMfVlA1ps0IYeE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=btHb2i1KZj04xgvDdsQkOPnWkQ2bgVXIOsmk4/xFYeyO1EJB6ztF/34t66ViibYKdLm9w8VBBWh12BY9TlrdYIXiZqetMouoze1YQJMoKr2ONUF3XnmS1f6zucJrGfrI+lJgbqJjbX9iDlu+oK6u9MJBFQP7GH/XSUW5zjlzSXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kd6Vf2Td; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kd6Vf2Td"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777561636; x=1809097636;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ku6j8SUaRtnyIN+0BuklJ64MeIIZdiMfVlA1ps0IYeE=;
  b=kd6Vf2TdtMkZrgSROPpKm9rSXiyvgsoleLr6IN3uXUpxPEWqR/utzJ+1
   TFl2zCIR40kijC9385BlzN3vEpnCmSHkO6i3mFz7sG9JI/Tn230Md9nEF
   e4Y7DnOJvqlOoGVhQ0itVa5FWmn4j/L1hki2vlmCd9G0YK2SbiWTa8fC7
   fsUukaMma1ZZg8xOm7I5/05d/KrgdDbMd7dkrL0a9HrIOZ9CvmXSeM/fx
   qvrqPGryHG/xgYyCv3HZBBOmgjTjYHTmZkxnVk0gwh1VIdiAfTZy0MwXY
   Rw7b7jbvy/ElQAF1suh86B3xGu/5bxh4tKvyjQWZRdDWNJhcAiVJKOTzP
   A==;
X-CSE-ConnectionGUID: uLZ2HuHJRYCoW8Hq0/Vmhg==
X-CSE-MsgGUID: N+/FWUbVTQ6wGEHjw61TcA==
X-IronPort-AV: E=McAfee;i="6800,10657,11772"; a="77542774"
X-IronPort-AV: E=Sophos;i="6.23,208,1770624000"; 
   d="scan'208";a="77542774"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2026 08:07:15 -0700
X-CSE-ConnectionGUID: LQv26qXcSiWYhqYAMpZ01Q==
X-CSE-MsgGUID: 532oPKHnTWahoOFjaSKUsw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,208,1770624000"; 
   d="scan'208";a="234862709"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa007.jf.intel.com with ESMTP; 30 Apr 2026 08:07:13 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id E9D4A95; Thu, 30 Apr 2026 17:07:11 +0200 (CEST)
Date: Thu, 30 Apr 2026 17:07:11 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Hugo Villeneuve <hugo@hugovil.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, ilpo.jarvinen@linux.intel.com,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>
Subject: Re: [PATCH v2 05/15] serial: core: replace snprintf with more robust
 scnprintf
Message-ID: <afNwH01y_6Dk2hVb@black.igk.intel.com>
References: <20260428-tty-upio-v2-0-01c1857cf761@dimonoff.com>
 <20260428-tty-upio-v2-5-01c1857cf761@dimonoff.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260428-tty-upio-v2-5-01c1857cf761@dimonoff.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Apr 28, 2026 at 01:53:51PM -0400, Hugo Villeneuve wrote:
> 
> Use scnprintf() so we could perhaps one day get rid of snprintf() entirely.

Ah, now I understand the approach in earlycon. Hmm... Still not sure which one
I prefer (it's not related to the contents of this patch anyway).

...

>  	default:
>  		strscpy(address, "*unknown*", sizeof(address));

Side note: This may use 2-argument strscpy().

-- 
With Best Regards,
Andy Shevchenko


