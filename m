Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02D7045C03;
	Wed, 20 Dec 2023 15:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="482018936"
X-IronPort-AV: E=Sophos;i="6.04,291,1695711600"; 
   d="scan'208";a="482018936"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2023 07:48:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="776380819"
X-IronPort-AV: E=Sophos;i="6.04,291,1695711600"; 
   d="scan'208";a="776380819"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2023 07:48:24 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andy.shevchenko@gmail.com>)
	id 1rFyhQ-00000007adt-0dll;
	Wed, 20 Dec 2023 17:41:32 +0200
Date: Wed, 20 Dec 2023 17:41:31 +0200
From: Andy Shevchenko <andy.shevchenko@gmail.com>
To: Hugo Villeneuve <hugo@hugovil.com>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org, jringle@gridpoint.com,
	kubakici@wp.pl, phil@raspberrypi.org, bo.svangard@embeddedart.se,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>, stable@vger.kernel.org
Subject: Re: [PATCH 03/18] serial: sc16is7xx: remove obsolete loop in
 sc16is7xx_port_irq()
Message-ID: <ZYMLK1yXFCsGlzoP@smile.fi.intel.com>
References: <20231219171903.3530985-1-hugo@hugovil.com>
 <20231219171903.3530985-4-hugo@hugovil.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231219171903.3530985-4-hugo@hugovil.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Dec 19, 2023 at 12:18:47PM -0500, Hugo Villeneuve wrote:
> From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> 
> Commit 834449872105 ("sc16is7xx: Fix for multi-channel stall") changed
> sc16is7xx_port_irq() from looping multiple times when there was still
> interrupts to serve. It simply changed the do {} while(1) loop to a
> do {} while(0) loop, which makes the loop itself now obsolete.
> 
> Clean the code by removing this obsolete do {} while(0) loop.

I'm just wondering if you used --histogram diff algo when prepared the patches.
If no, use that by default.

-- 
With Best Regards,
Andy Shevchenko


