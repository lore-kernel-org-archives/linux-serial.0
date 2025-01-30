Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C8241474DA;
	Thu, 30 Jan 2025 08:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738225659; cv=none; b=ebpSZzSoGMiTk02WnhhGh+WMGSL9NrjObdmwE4De1Q7Xg7EB8+nCxXX38iDl9KP3G2qHqG1TAAuIUp+BG82g8vyV504R8es6g4UYV/BAnrmAam8BcYPSlolfzNEJXf1r6BBfRfgWWjfhy/9683cDeVg/QFer2FoJXTascnm/bGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738225659; c=relaxed/simple;
	bh=zOHzA3WIRnWRYd8zYSHICptJqDMxtviZfBL5dLN0Ck4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G9+MB1hxO6M4zEV4Q6Cu1A2VJoGii0Fqb5vK+Kw54bmtYsDsfqB5+8EbRdRFmRV5iPcFhnUNCDoA5pJ1Z75FRzJFvQKbujGGgWRzAZb9cd0j/tlGDXU8E7QItrZVB80WIfHg4Z8qMd0dJltRLLOXpq0G2x6FOdXjujKMkRCKw7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LOU72cZF; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LOU72cZF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738225657; x=1769761657;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zOHzA3WIRnWRYd8zYSHICptJqDMxtviZfBL5dLN0Ck4=;
  b=LOU72cZFCwX4bkokqjOZDr1GcHoEBqKLrEjtmuuvzJWhv+BdKrcV84ej
   nUXOqn8n0IwLP5qYGu+5r/uvE/GsK9QigqIBXS7u0i/Rk5mOTl79Mr1/t
   jNgUs1UmEwv4k3fNgNK6KVu2wgcKwh2c+x7EpKZA5EevS9DF6rWCGflvd
   dMjQWRLLHDf88L+zsYDheg5vr1JnRnmami+xrq55g795gShuWrdRGpffx
   CFgQSRBscKY3F+XKycwth1+RbRbU8IamcIJY0KNdTDGynfU3XlQw0PI2k
   1hlGONeiA4Wf4OC1RV4sZEOz90GrCJ5wn8qYyqD26swxzudXYPOiKZafP
   g==;
X-CSE-ConnectionGUID: C2gz+z2+SpaomTHr8RGjeQ==
X-CSE-MsgGUID: Bhwa/j1hSEWsHIyxGwY9jA==
X-IronPort-AV: E=McAfee;i="6700,10204,11330"; a="38649779"
X-IronPort-AV: E=Sophos;i="6.13,244,1732608000"; 
   d="scan'208";a="38649779"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2025 00:27:37 -0800
X-CSE-ConnectionGUID: 5nz1vCDUTaSrJIal1+RIVw==
X-CSE-MsgGUID: quipAQiYQQqx09CcBDV6sw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,244,1732608000"; 
   d="scan'208";a="114297897"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2025 00:27:33 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tdPtZ-00000006ctb-2XVl;
	Thu, 30 Jan 2025 10:27:29 +0200
Date: Thu, 30 Jan 2025 10:27:29 +0200
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
Message-ID: <Z5s38S7sJ2mka3-1@smile.fi.intel.com>
References: <20250129162700.848018-1-dianders@chromium.org>
 <20250129082535.1.Ia095eac1ae357f87d23e7af2206741f5d40788f1@changeid>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250129082535.1.Ia095eac1ae357f87d23e7af2206741f5d40788f1@changeid>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Jan 29, 2025 at 08:25:50AM -0800, Douglas Anderson wrote:
> This reverts commit 0c57dfcc6c1d037243c2f8fbf62eab3633326ec0.
> 
> The functionality was supoosed to be used by a later patch in the
> series that never landed [1]. Drop it.
> 
> NOTE: part of functionality was already reverted by commit
> 39d0be87438a ("serial: kgdb_nmi: Remove unused knock code"). Also note
> that this revert is not a clean revert given code changes that have
> happened in the meantime.
> 
> It's obvious that nobody is using this code since the two exposed
> functions (kgdb_register_nmi_console() and
> kgdb_unregister_nmi_console()) are both no-ops if
> "arch_kgdb_ops.enable_nmi" is not defined. No architectures define it.

Fine with me.
Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> [1] https://lore.kernel.org/lkml/1348522080-32629-9-git-send-email-anton.vorontsov@linaro.org/

It might be possible to use Link tag here in a form

Link: URL [1]


-- 
With Best Regards,
Andy Shevchenko


