Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CB2D3FE33;
	Wed, 20 Dec 2023 15:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="462281547"
X-IronPort-AV: E=Sophos;i="6.04,291,1695711600"; 
   d="scan'208";a="462281547"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2023 07:42:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="1107763887"
X-IronPort-AV: E=Sophos;i="6.04,291,1695711600"; 
   d="scan'208";a="1107763887"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2023 07:42:46 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andy.shevchenko@gmail.com>)
	id 1rFyiY-00000007aev-3jLs;
	Wed, 20 Dec 2023 17:42:42 +0200
Date: Wed, 20 Dec 2023 17:42:42 +0200
From: Andy Shevchenko <andy.shevchenko@gmail.com>
To: Hugo Villeneuve <hugo@hugovil.com>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org, jringle@gridpoint.com,
	kubakici@wp.pl, phil@raspberrypi.org, bo.svangard@embeddedart.se,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>, stable@vger.kernel.org
Subject: Re: [PATCH 04/18] serial: sc16is7xx: improve do/while loop in
 sc16is7xx_irq()
Message-ID: <ZYMLciH4y_Y5ewiL@smile.fi.intel.com>
References: <20231219171903.3530985-1-hugo@hugovil.com>
 <20231219171903.3530985-5-hugo@hugovil.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231219171903.3530985-5-hugo@hugovil.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Dec 19, 2023 at 12:18:48PM -0500, Hugo Villeneuve wrote:
> From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> 
> Simplify and improve readability by replacing while(1) loop with
> do {} while, and by using the keep_polling variable as the exit
> condition, making it more explicit.

...

> +	bool keep_polling;

> +

Stray blank line. Otherwise LGTM.

-- 
With Best Regards,
Andy Shevchenko


