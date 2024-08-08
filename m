Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52BAE18E75D;
	Thu,  8 Aug 2024 14:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723126349; cv=none; b=g/M47FewsMG/4OMWkMl7Wj7HP+dARotJAqzaninxsCH8gpzlgeMtdLYdA32Yxns7lTZ65MrKaIGTKYk0Q24Tt1Eflq/Jdp2GUJ4Rej7Zid1upum0MoY1DOJ960nj1HVq8G1jQilUchzVpAv/6fLSfVjUuDNLSNwDAl+iV1/0Qp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723126349; c=relaxed/simple;
	bh=crdPOpLEKqkfofJJeWgoWCBIjEsxYH2NeKPeOVYwwA8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R6QCUq/ghAhrQZrB48/QuAXb8xxlpjPD8LqMFCzljEvgU0XyqRKPOBL5RViULqLfg4zabnx4oSZwekSECvms9KedNe3loQcfzCt9vLF/BtfxC60KxqArIp+ognmPl6STntWsTHkx8wenhV5RLE2DulPn1ArEQLUJrvi9U+PWTCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j8lAciza; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j8lAciza"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723126348; x=1754662348;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=crdPOpLEKqkfofJJeWgoWCBIjEsxYH2NeKPeOVYwwA8=;
  b=j8lAcizavYReNobAveqp3IaS9DvI0Aie4SOVHW2k5VFDSpWvcpvGGDKt
   VzCRSl90sjb6/5qfDQLPnrIZDhheKPX8Gpe8fqK7uiWiRgEugXJXcFiQT
   dVGI4bOgSnAHZevS0lzHgjyic9JTBbPQ/6QjZNwj53SChUnITrzxrsKCb
   i/PVy/aCc1i+RfYkKHBcRW9GrrLI+OOgNWWuqRx65wba5t85/dwejANPY
   cblEBh/XJ+DGZvbxGwG64+OZrJXW4UNU7FX6fkPNJlRYMu8ZEDKPlIGu3
   2quXNOdYaHElEjqIqSRiVtsDFpaCcTtWC+FD8ELV/4cAyuyhOXE1N+51k
   w==;
X-CSE-ConnectionGUID: Xz9UM+9vRfa7caXfQLS8jg==
X-CSE-MsgGUID: ZrfkhaNPRrmtNaSfmFT9TQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11158"; a="21062502"
X-IronPort-AV: E=Sophos;i="6.09,273,1716274800"; 
   d="scan'208";a="21062502"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2024 07:12:26 -0700
X-CSE-ConnectionGUID: wYBuk7I7Tc2Qi4QVZNQxBg==
X-CSE-MsgGUID: wP0LG6SYTW2Ar8r/dhHB0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,273,1716274800"; 
   d="scan'208";a="56914561"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2024 07:12:23 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1sc3sL-0000000D8aw-0DAc;
	Thu, 08 Aug 2024 17:12:21 +0300
Date: Thu, 8 Aug 2024 17:12:20 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Sunil V L <sunilvl@ventanamicro.com>, Arnd Bergmann <arnd@arndb.de>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH 1/2] serial: 8250_platform: remove ACPI_PTR() annotation
Message-ID: <ZrTSRJugLFvORX5L@smile.fi.intel.com>
References: <20240807075751.2206508-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240807075751.2206508-1-arnd@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Aug 07, 2024 at 09:57:43AM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The acpi_platform_serial_table[] array is defined globally without
> an #ifdef check for CONFIG_ACPI, so ACPI_PTR() makes no sense
> here:
> 
> drivers/tty/serial/8250/8250_platform.c:271:36: error: 'acpi_platform_serial_table' defined but not used [-Werror=unused-const-variable=]
>   271 | static const struct acpi_device_id acpi_platform_serial_table[] = {

Yeah, that patch went into kernel without my review as I was on a long leave.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko


