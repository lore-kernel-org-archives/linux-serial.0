Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04240148832;
	Thu, 30 Jan 2025 08:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738225963; cv=none; b=T0Zv1aJuUC8fswJICekvObFs7MC1KxPTaDQEvHF7CoFxkKt0DVWl4ndXuM2BYTCq91pzhy2FN84q4FqPRPgKHV3EjBe/lixABEuuz06RxeT0wpIDGfKetOhYLrfpKSJLmvnFNqFNN2F7Ro/gt9SAoh1DRvhzjSaeKWw9kEPG7Z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738225963; c=relaxed/simple;
	bh=KGZn6Xt9v0IKvMBO/XZlgfWkSXISMGsYFaHeuoOmrSM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XEdpVEXYJCN1CYCQpZWhvdH9o0ZNm/u213H1rUOuA+xYY+vm7ibptLrDV9bJwuOX8SdKIyYPsKytjGZ3FaNc5PcKinn0Dz2AmdFgTLebQG9ozQJi1f/9gt8HMHbXUracfQB+WrEZqkG3GRvE8hR375ZlNeLIPplWkdAeOaEvi58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Tdz1WU4N; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Tdz1WU4N"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738225963; x=1769761963;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KGZn6Xt9v0IKvMBO/XZlgfWkSXISMGsYFaHeuoOmrSM=;
  b=Tdz1WU4N+/N3pymK5rHLunob92AHSw1jTGuflUkggBMyQQDldpyrw+Pt
   17D76t5T9Ld8ki613y++FrfzS5LE+27XDqzS4OF44PMj8lrWAUqs5VtS5
   X5V09txXM07XJx64tdlsKu0kCLx0kPZzcXU1iTVSgAMJdGS5HK5SNJ7rL
   PazlB9ANOsJk+aCPqjfEE7Sy6K0znIeW33UGS2MwS2AOMUZLdgmqLJbIb
   4f5FFyAXSAaqwuRFTvNkcuMJoGCx4DqXGsOXu9jG5zv6xeza0aY0w2Yfy
   36CHEdaN7wOlLdU31hrOf8pRfs2n4sSHMYSNdkfkRGKIfHJE4YU0hT73K
   g==;
X-CSE-ConnectionGUID: dMRdtSosRDiW4JLc0Pipsw==
X-CSE-MsgGUID: eC/NbXjGTpyGInoLc4qr1w==
X-IronPort-AV: E=McAfee;i="6700,10204,11330"; a="56186019"
X-IronPort-AV: E=Sophos;i="6.13,244,1732608000"; 
   d="scan'208";a="56186019"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2025 00:32:42 -0800
X-CSE-ConnectionGUID: MsL1juu8Rza5VqiPNSHU4A==
X-CSE-MsgGUID: IFKHj+vcReOFJ/dMDX0nAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,244,1732608000"; 
   d="scan'208";a="109066052"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2025 00:32:38 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tdPyT-00000006cxf-3VBL;
	Thu, 30 Jan 2025 10:32:33 +0200
Date: Thu, 30 Jan 2025 10:32:33 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Douglas Anderson <dianders@chromium.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Daniel Thompson <danielt@kernel.org>,
	"Dr . David Alan Gilbert" <linux@treblig.org>,
	kgdb-bugreport@lists.sourceforge.net,
	Anton Vorontsov <anton.vorontsov@linaro.org>,
	Sumit Garg <sumit.garg@linaro.org>, linux-serial@vger.kernel.org,
	Arnd Bergmann <arnd@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Jason Wessel <jason.wessel@windriver.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Robert Marko <robert.marko@sartura.hr>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] Revert "tty/serial: Add kgdb_nmi driver"
Message-ID: <Z5s5IThpnMNdY62v@smile.fi.intel.com>
References: <20250129162700.848018-1-dianders@chromium.org>
 <20250129082535.1.Ia095eac1ae357f87d23e7af2206741f5d40788f1@changeid>
 <Z5s38S7sJ2mka3-1@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z5s38S7sJ2mka3-1@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Jan 30, 2025 at 10:27:29AM +0200, Andy Shevchenko wrote:
> On Wed, Jan 29, 2025 at 08:25:50AM -0800, Douglas Anderson wrote:

...

> > [1] https://lore.kernel.org/lkml/1348522080-32629-9-git-send-email-anton.vorontsov@linaro.org/
> 
> It might be possible to use Link tag here in a form
> 
> Link: URL [1]

Hmm... I'm not sure what this Link is supposed to mean. You might be forgotten
to update an URL to point out to the cover letter? (This is the link to patch 9
in the series and looks a bit unrelated).

-- 
With Best Regards,
Andy Shevchenko


