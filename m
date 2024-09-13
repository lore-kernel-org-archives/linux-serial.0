Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55FB6823C8;
	Fri, 13 Sep 2024 17:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726249691; cv=none; b=ic39Uu/dTeBqdl4PO5PQRbLNKfiQpXGzDTD803du2wiDm+WDIbR9Bnrhz+YcvYFU+obPtLcJCf4ae5JG4VxvdiUe1z+hiAyTNn/abN8Hmd5M0Lxo7YHsl3ciJz7QIhp+Dg4/HNp0hUCJcURDOJgQzL0G2wsEgyUMFYavcsfkWts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726249691; c=relaxed/simple;
	bh=eHBaGabrVPkz1nCn1EqgEsXsowcWrIbMnyYuN9LVwZE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ntXMqMXIJm/3lJ30IoO3/c5fApNB836pURV6yKZhXRE/rLiIC14L6dOgmlQU3l4AavvNZ+xdvWaUN4DPNGYJGniPHi1RGMTqdFY5XYh6Nad4zEXa8FODN71NnH6Ya3YKCqhUoGdsp2pkln7Q/0FtTAIvSFrunaL2gyqaPXUXNQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L9aOKjto; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L9aOKjto"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726249690; x=1757785690;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=eHBaGabrVPkz1nCn1EqgEsXsowcWrIbMnyYuN9LVwZE=;
  b=L9aOKjtoLoMty/j19job27V68RmOkGWuIcj3nETQUZzBD85zjagWXyDd
   nsfCw2/Ap4PZ60YqP6CO2cbU81K2jZOOtKw/Zx88GDRA0mjtovkXBZTcL
   mTNX0usmHlYokYy9pTnuY6mKEIqciGRgjCe6yGg9q0Y8nb8RWMZsWfsqd
   92cwhyXQNA6/1/JziIrl8fREXzqxHdKBIs+evOUddrY/V9tMbl3oYGcad
   1YcoCL3YCRwnLF5gbetAcfWoAB0LDCiACuvt+B1Cg4YcLdH9F4EqJv8W7
   0Zl9s2PVsQEAcVEmJLUO+arINOXtMa6ud5dxS4Be4vuOKnXTzciUum5JS
   A==;
X-CSE-ConnectionGUID: scDk9hFxT5+yjs4jVqoZJA==
X-CSE-MsgGUID: VO59341sRtCWDC4YXJ/0EQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11194"; a="42669446"
X-IronPort-AV: E=Sophos;i="6.10,226,1719903600"; 
   d="scan'208";a="42669446"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2024 10:48:08 -0700
X-CSE-ConnectionGUID: rUcvZkxrSDeKulvDrheboQ==
X-CSE-MsgGUID: 6XhydrL6QMacok8VfnMY8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,226,1719903600"; 
   d="scan'208";a="72902079"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2024 10:48:06 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1spAOp-00000008NOf-47mj;
	Fri, 13 Sep 2024 20:48:03 +0300
Date: Fri, 13 Sep 2024 20:48:03 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Parker Newman <parker@finest.io>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	Parker Newman <pnewman@connecttech.com>
Subject: Re: [PATCH v1 1/6] misc: eeprom: eeprom_93cx6: Add quirk for extra
 read clock cycle
Message-ID: <ZuR600QgWi6oQcau@smile.fi.intel.com>
References: <cover.1726237379.git.pnewman@connecttech.com>
 <d0818651c4a58d0162a898c3ba3dd8abf9f95272.1726237379.git.pnewman@connecttech.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d0818651c4a58d0162a898c3ba3dd8abf9f95272.1726237379.git.pnewman@connecttech.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Sep 13, 2024 at 10:55:38AM -0400, Parker Newman wrote:
> From: Parker Newman <pnewman@connecttech.com>
> 
> This patch adds a quirk similar to eeprom_93xx46 to add an extra clock
> cycle before reading data from the EEPROM.
> 
> The 93Cx6 family of EEPROMs output a "dummy 0 bit" between the writing
> of the op-code/address from the host to the EEPROM and the reading of
> the actual data from the EEPROM.
> 
> More info can be found on page 6 of the AT93C46 datasheet. Similar notes
> are found in other 93xx6 datasheets.

> Link: https://ww1.microchip.com/downloads/en/DeviceDoc/Atmel-5193-SEEPROM-AT93C46D-Datasheet.pdf

Make it a tag (i.e. locate just above your SoB tag)

> In summary the read operation for a 93Cx6 EEPROM is:
> Write to EEPROM :	110[A5-A0]	(9 bits)

> Read from EEPROM: 	0[D15-D0]	(17 bits)

The mixed TABs/space here (one extra space after :)

> Where:
>  	110 is the start bit and READ OpCode
> 	[A5-A0] is the address to read from
> 	0 is a "dummy bit" preceding the actual data
> 	[D15-D0] is the actual data.

Also leading spaces, please remove them and use TAB, or use spaces only.

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

So, this makes sense to be in a header since everything else related to that
also in the header already.

...

> +	if (has_quirk_extra_read_cycle(eeprom)) {
> +		eeprom_93cx6_pulse_high(eeprom);

No additional delay is needed?

> +		eeprom_93cx6_pulse_low(eeprom);
> +	}

> +	if (has_quirk_extra_read_cycle(eeprom)) {
> +		eeprom_93cx6_pulse_high(eeprom);

Ditto.

> +		eeprom_93cx6_pulse_low(eeprom);
> +	}

...

> +/* Some EEPROMs require an extra clock cycle before reading */
> +#define PCI_EEPROM_QUIRK_EXTRA_READ_CYCLE	BIT(0)

I would move it directly into the structure definitions, just after quirk
field (the same way it's done in the other driver)...

...

>  	int width;
> +	unsigned int quirks;

...somewhere here.

>  	char drive_data;
>  	char reg_data_in;

-- 
With Best Regards,
Andy Shevchenko


