Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC08D1D1E70;
	Wed,  2 Oct 2024 14:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727879258; cv=none; b=K3tZ9hAO3eqfsgbnBfXo2gAVGSmWgbMRsXLo1KBg9fnDzMobwwqgQ0+VhBBhXdfHnFBnkZPFZzovSNFMP5dcxj6KmBW009ZYRiX4fXP7XxifddnY69h9B+Ot+/WjqJXkgskRpvYi2vvA12YbeU9w1qge3vp/JvPMjiCOk8IBHB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727879258; c=relaxed/simple;
	bh=MwDcBOPD9KXEudvZezMAvLuCevi7PAa5G4JUxpIWOwo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hj2vQr+snmpcHkS8+ZvkUCzPFG7FZu00nLTbDrU7myeDLWBhu5nexJasxPlUXP+eggi/4tjStNnkwb6kvsV+O8aMymGnK1BWvV+UfrrPwtJplBNCWY5vaLITn8xVcIfnK0cZR+3nJDJwohmUjJ9vD66CsvdoHiAx7g995ZJH2tY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Gpjz4Wyi; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Gpjz4Wyi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727879257; x=1759415257;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MwDcBOPD9KXEudvZezMAvLuCevi7PAa5G4JUxpIWOwo=;
  b=Gpjz4WyiNdD5FGMUWglt5YfzFtznf+wrGNfSMTC7k1so4a7njlk6pTIV
   9X17ZONKLz9iZ1pjN6HlSN9UQrgW6zjjSbK8zbYWaY9AkgaCDHxuCCjS9
   +0TqDU9BUDs9TfLmjoQngFwl3isbPLf9220iJQwPMeTObIDuTTsXMeaKR
   5xYom8fG5u6x2+aIJSXpi8/zdYg2iFwSDvTKthYsRKaowT+0rLKWZ34TU
   Iy3rk0EdS1Dwj//SUk6FFgduLINB6UdnueEZu1W81EGu6WV1W5HRsum24
   /KV7ayb5lRbtokb1MciMzGfQ+Tcg9M9N/dpk7owbgmyVRiAkwCfUDhpAP
   w==;
X-CSE-ConnectionGUID: CsgcnPfuRbi+tRVqAKsFlw==
X-CSE-MsgGUID: 2h/oLMNkRIWK7WWn+2/QZw==
X-IronPort-AV: E=McAfee;i="6700,10204,11213"; a="44508527"
X-IronPort-AV: E=Sophos;i="6.11,171,1725346800"; 
   d="scan'208";a="44508527"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2024 07:27:36 -0700
X-CSE-ConnectionGUID: SKFxyeinTw+5/W3iTrZL+g==
X-CSE-MsgGUID: I2pOoM+PTCCbkRhDwBq7Ig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,171,1725346800"; 
   d="scan'208";a="74040246"
Received: from unknown (HELO smile.fi.intel.com) ([10.237.72.154])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2024 07:27:35 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1sw0KB-0000000FhXo-44TX;
	Wed, 02 Oct 2024 17:27:31 +0300
Date: Wed, 2 Oct 2024 17:27:31 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Parker Newman <parker@finest.io>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	Parker Newman <pnewman@connecttech.com>
Subject: Re: [PATCH v3 1/5] misc: eeprom: eeprom_93cx6: Add quirk for extra
 read clock cycle
Message-ID: <Zv1YUyzL41GTqsOA@smile.fi.intel.com>
References: <cover.1727873292.git.pnewman@connecttech.com>
 <62eca5d814da3734cfa984a78e0978efefbbc827.1727873292.git.pnewman@connecttech.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62eca5d814da3734cfa984a78e0978efefbbc827.1727873292.git.pnewman@connecttech.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Oct 02, 2024 at 10:14:07AM -0400, Parker Newman wrote:
> From: Parker Newman <pnewman@connecttech.com>
> 
> Add a quirk similar to eeprom_93xx46 to add an extra clock cycle before
> reading data from the EEPROM.
> 
> The 93Cx6 family of EEPROMs output a "dummy 0 bit" between the writing
> of the op-code/address from the host to the EEPROM and the reading of
> the actual data from the EEPROM.
> 
> More info can be found on page 6 of the AT93C46 datasheet (linked below).
> Similar notes are found in other 93xx6 datasheets.
> 
> In summary the read operation for a 93Cx6 EEPROM is:
> Write to EEPROM:	110[A5-A0]	(9 bits)
> Read from EEPROM:	0[D15-D0]	(17 bits)
> 
> Where:
> 	110 is the start bit and READ OpCode
> 	[A5-A0] is the address to read from
> 	0 is a "dummy bit" preceding the actual data
> 	[D15-D0] is the actual data.
> 
> Looking at the READ timing diagrams in the 93Cx6 datasheets the dummy
> bit should be clocked out on the last address bit clock cycle meaning it
> should be discarded naturally.
> 
> However, depending on the hardware configuration sometimes this dummy
> bit is not discarded. This is the case with Exar PCI UARTs which require
> an extra clock cycle between sending the address and reading the data.

...

> +static inline bool has_quirk_extra_read_cycle(struct eeprom_93cx6 *eeprom)
> +{
> +	return eeprom->quirks & PCI_EEPROM_QUIRK_EXTRA_READ_CYCLE;
> +}

> +

Seems to me the redundant new line at the end of file.


-- 
With Best Regards,
Andy Shevchenko


