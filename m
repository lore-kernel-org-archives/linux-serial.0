Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8351C4184F;
	Wed, 20 Dec 2023 15:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="462283009"
X-IronPort-AV: E=Sophos;i="6.04,291,1695711600"; 
   d="scan'208";a="462283009"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2023 07:52:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="805306455"
X-IronPort-AV: E=Sophos;i="6.04,291,1695711600"; 
   d="scan'208";a="805306455"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2023 07:52:52 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andy.shevchenko@gmail.com>)
	id 1rFysL-00000007apN-0A7P;
	Wed, 20 Dec 2023 17:52:49 +0200
Date: Wed, 20 Dec 2023 17:52:48 +0200
From: Andy Shevchenko <andy.shevchenko@gmail.com>
To: Hugo Villeneuve <hugo@hugovil.com>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org, jringle@gridpoint.com,
	kubakici@wp.pl, phil@raspberrypi.org, bo.svangard@embeddedart.se,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>
Subject: Re: [PATCH 12/18] serial: sc16is7xx: replace hardcoded divisor value
 with BIT() macro
Message-ID: <ZYMN0NFVVZvnlu-4@smile.fi.intel.com>
References: <20231219171903.3530985-1-hugo@hugovil.com>
 <20231219171903.3530985-13-hugo@hugovil.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231219171903.3530985-13-hugo@hugovil.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Dec 19, 2023 at 12:18:56PM -0500, Hugo Villeneuve wrote:
> From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> 
> To better show why the limit is what it is, since we have only 16 bits for
> the divisor.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

-- 
With Best Regards,
Andy Shevchenko


