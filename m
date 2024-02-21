Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C8769DE5;
	Wed, 21 Feb 2024 19:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708542262; cv=none; b=A8gv7XrJRmoCCKmh969yK067ZqxGwCxQjXu72P2M6F5+PVoZwlYfZXywUPLm7VrhGD2M69ZxUf6pSxx6GNcwXRfNLi9nlAMniOQHOqUDKXL8tt2X29pGcpkKM5PVzcO9IW66tbdiar4cJzehyohNXh6aZ2UdjuZDrjyJU+O5wgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708542262; c=relaxed/simple;
	bh=n0Imwz+1JuSXsvn3CWF5sPHjqL1Uh/DLyBWeFpnGhgQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BjdW/pIansBR9TvHWgGscJYCNpWNId87hT6bCt1aIA9gmBIGfEaKcA1BH0+XVY94r9KPyW9bp0boFN1XuxFIj5uq2joeTMR1ouMpIgNqE98Wv/Mrh0kPFUHx77NmT+kdzRYO731rQXG/0O7XUmUNOS81uEFaUXo3nzDL+5Z1aVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RYUcvh/C; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RYUcvh/C"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708542261; x=1740078261;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=n0Imwz+1JuSXsvn3CWF5sPHjqL1Uh/DLyBWeFpnGhgQ=;
  b=RYUcvh/CHe8ihovYlm0paZspfeMumEk+7Kl/uYbpPimOLhqsVs3aDOz4
   mY+Ot/T4fWMEcjyFazGOGwmJD/3D6LZw+KlbDfJ8VnAQkB7kED+5O2Bn+
   mbv8FarzCrRgQTzpdUdXu075iFyBP8xLL6lfywgPIRsK49v+UBxpcoj4a
   0HsR0IqXiemNNSNXO1dZcvishG6GUyZvWws/EJEWfj6AelEgbdyQfqvN4
   +dJrTV77ejzvT54hz4SAQ0fP7iEd363cO5tZ4oyR2JTW8EWfUyXBU58bl
   FWjag22n8C1tVrJkWfNoV369rdJpiNHtudcaCyD4QrH7g/ePQMIPyyRS2
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10991"; a="2873061"
X-IronPort-AV: E=Sophos;i="6.06,176,1705392000"; 
   d="scan'208";a="2873061"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2024 11:04:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10991"; a="913355053"
X-IronPort-AV: E=Sophos;i="6.06,176,1705392000"; 
   d="scan'208";a="913355053"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2024 11:04:13 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rcrt3-00000006R6t-0QGW;
	Wed, 21 Feb 2024 21:04:09 +0200
Date: Wed, 21 Feb 2024 21:04:08 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Hugo Villeneuve <hugo@hugovil.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-rpi-kernel@lists.infradead.org,
	linux-mips@vger.kernel.org, linux-tegra@vger.kernel.org,
	Jiri Slaby <jirislaby@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Al Cooper <alcooperx@gmail.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Paul Cercueil <paul@crapouillou.net>,
	Vladimir Zapolskiy <vz@mleia.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Andi Shyti <andi.shyti@linux.intel.com>
Subject: Re: [PATCH v1 01/14] serial: core: Move struct uart_port::quirks
 closer to possible values
Message-ID: <ZdZJKIrkeasBwL3i@smile.fi.intel.com>
References: <20240221183442.4124354-1-andriy.shevchenko@linux.intel.com>
 <20240221183442.4124354-2-andriy.shevchenko@linux.intel.com>
 <20240221135452.6fdeb71e60509cca1be016c3@hugovil.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240221135452.6fdeb71e60509cca1be016c3@hugovil.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Feb 21, 2024 at 01:54:52PM -0500, Hugo Villeneuve wrote:
> On Wed, 21 Feb 2024 20:31:17 +0200
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> 
> > Currently it's not crystal clear what UPIO_* and UPQ_* definitions
> > belong two. Reindent the code, so it will be easy to read and understand.
> 
> two -> to.

Ah, thanks, will fix!

-- 
With Best Regards,
Andy Shevchenko


