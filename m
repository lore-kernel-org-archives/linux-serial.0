Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D798F481A1;
	Wed, 20 Dec 2023 16:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MxXSCy0r"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703088397; x=1734624397;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=XYPJJPL5clzH4NBZgsCRD+JOT9e5OWBGHYD09Rhmisk=;
  b=MxXSCy0r5qtLIN21a8ChvukFYzHxh0QSombJ+BUoR2/Q3gy/I4w7yDcP
   PrsvO+KMq2V8jrTKziC3VxYVl/NDDh3AQVTUXmQBGhqEHklycCzNsHe05
   bEr6q7wFkn8zubYgZUba9PGdhs/xupU8HX9pOEBun7SnfkEjhKjAnkiPD
   2mCzJTnG0Ha0CLKVlfDSEOzL+Vz2w4XKrtkzi5J2yxR9wc0TeZs2bt6EK
   9Inuqsgy+kDAusRnTwlJhpr9cMmA0j6xGF/hm98pmVKN49ShpcDq5q14v
   N8o0OKAsvxafgZlQyEQcf7Nq/j/CZu6xF8frgjeqgMgyAwcCETUG5Zg6d
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="2674467"
X-IronPort-AV: E=Sophos;i="6.04,291,1695711600"; 
   d="scan'208";a="2674467"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2023 08:06:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="776385088"
X-IronPort-AV: E=Sophos;i="6.04,291,1695711600"; 
   d="scan'208";a="776385088"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2023 08:06:33 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1rFz5a-00000007b03-0esJ;
	Wed, 20 Dec 2023 18:06:30 +0200
Date: Wed, 20 Dec 2023 18:06:29 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Hugo Villeneuve <hugo@hugovil.com>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org, jringle@gridpoint.com,
	kubakici@wp.pl, phil@raspberrypi.org, bo.svangard@embeddedart.se,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>
Subject: Re: [PATCH 00/18] serial: sc16is7xx: fixes, cleanups and improvements
Message-ID: <ZYMRBbPEwIa8K4NI@smile.fi.intel.com>
References: <20231219171903.3530985-1-hugo@hugovil.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231219171903.3530985-1-hugo@hugovil.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Dec 19, 2023 at 12:18:44PM -0500, Hugo Villeneuve wrote:
> From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> 
> Hello,
> this patch series brings a few fixes, clean-ups and improvements to the
> sc16is7xx driver.
> 
> Some of the patches have been suggested by Andy Shevchenko following this
> dicussion:
> 
> Link: https://lore.kernel.org/all/CAHp75VebCZckUrNraYQj9k=Mrn2kbYs1Lx26f5-8rKJ3RXeh-w@mail.gmail.com/

Thanks, good series (need a bit of additional work, though).
What I really miss is the proper split of the driver. See
0f04a81784fe ("pinctrl: mcp23s08: Split to three parts: core, I²C, SPI")
as an example of a such.

-- 
With Best Regards,
Andy Shevchenko


