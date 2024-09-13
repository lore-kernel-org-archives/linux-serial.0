Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AAC1446AF;
	Fri, 13 Sep 2024 18:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726250815; cv=none; b=uTzcv1DoTZYw254deMAV5BxPg3BW6R14+bcf9yfu/BKrUr7TaUANlPajNNUbnNNx5rk98OfqZZreeQ/OJlOY45Mfq23BwpT+jnrAQVCoT7elzOxGkqcER2swBBZbZMWzqRGCm2r+KZlhwFmPefQnBc0P1K14dc+y75IipELd/o4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726250815; c=relaxed/simple;
	bh=hODeVcKESQQ+bysOclnLLpr1fN1atctGk9DXPTCBdzQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eYKE7eH3i/og11sY2wLtjetVJSiekdreda7UIyCa7CxYvEQEYh+HVrrTSHBkSFxv7SW8/Jy39Vf1675i/4VopO4q350dMhpR/ykRAj6/Z1GrcrQ0dlfMaq9ZR5qSaI3+n/s7rJUDKjx4sJ4E80bWz7Djh0Y4PbZHFSW1lwUKIQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Uwys8dWt; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Uwys8dWt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726250815; x=1757786815;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hODeVcKESQQ+bysOclnLLpr1fN1atctGk9DXPTCBdzQ=;
  b=Uwys8dWt1N3A0ACDaeP1lRnbwC+4Q5XZhqsWMyrhi//je9wqRpedEhN9
   gNBjLMu2n1JlAFaKWy/79NqcVOlvKEKKwK6BZLQcz6iysImWrMISI8zd3
   NxUZWiFx6aNDyqpDDKA8AYkcfN+EL7pu8ptJMajoe//8ViyGQtkq413ub
   AYRtSk4TS6sDpLlqNewQ3GAoId5vfu7CIh6DpDhDltLMPz08GKo9olqiI
   XOu9YoiUAuLTdY83etfomjG9kvSA6xmLPQJeG2holvjaVSqtfUYbx1JZl
   TY+wdxTtClvSbQ82N2gE8CTYcl+M2XCXBv8uTC7tzMlR4dwyOmuwAdwi7
   w==;
X-CSE-ConnectionGUID: 9gKdYi1QSp6I/HdoaY5V9Q==
X-CSE-MsgGUID: zqjLgIi8R4Gl/6STAKR0ew==
X-IronPort-AV: E=McAfee;i="6700,10204,11194"; a="25288281"
X-IronPort-AV: E=Sophos;i="6.10,226,1719903600"; 
   d="scan'208";a="25288281"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2024 11:06:54 -0700
X-CSE-ConnectionGUID: +/2pBTv9TBauH7SK5OAjeA==
X-CSE-MsgGUID: oXgjKCtbQMOmA8rNxzioSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,226,1719903600"; 
   d="scan'208";a="98822694"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2024 11:06:52 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1spAgy-00000008Nj4-3whr;
	Fri, 13 Sep 2024 21:06:48 +0300
Date: Fri, 13 Sep 2024 21:06:48 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Parker Newman <parker@finest.io>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	Parker Newman <pnewman@connecttech.com>
Subject: Re: [PATCH v1 4/6] serial: 8250_exar: Replace custom EEPROM read
 with eeprom_93cx6
Message-ID: <ZuR_OERZZY3QoAtH@smile.fi.intel.com>
References: <cover.1726237379.git.pnewman@connecttech.com>
 <78dead78311ea619e0be99cc32ee0df1610a480d.1726237379.git.pnewman@connecttech.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <78dead78311ea619e0be99cc32ee0df1610a480d.1726237379.git.pnewman@connecttech.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Sep 13, 2024 at 10:55:41AM -0400, Parker Newman wrote:
> From: Parker Newman <pnewman@connecttech.com>
> 
> Replace the custom 93cx6 EEPROM read functions with the eeprom_93cx6
> driver. This removes duplicate code and improves code readability.
> 
> exar_ee_read() calls are replaced with eeprom_93cx6_read() or
> eeprom_93cx6_multiread().
> 
> Link to discussion with Andy Shevchenko:

(the above might need to be rephrased a bit, see below why)

> Link: https://lore.kernel.org/linux-serial/Ztr5u2wEt8VF1IdI@black.fi.intel.com/

Make it real tag by moving...

> Note: Old exar_ee_read() and associated functions are removed in next
> patch in this series.
> 

...somewhere here.

> Signed-off-by: Parker Newman <pnewman@connecttech.com>

...

>  #include <linux/property.h>
>  #include <linux/string.h>
>  #include <linux/types.h>
> +#include <linux/eeprom_93cx6.h>

Keep it sorted.

...

> +static void exar_eeprom_93cx6_reg_read(struct eeprom_93cx6 *eeprom)
> +{
> +	struct exar8250 *priv = (struct exar8250 *)eeprom->data;

Unneeded explicit cast.

> +	u8 regb = exar_read_reg(priv, UART_EXAR_REGB);
> +
> +	// EECK and EECS always read 0 from REGB so only set EEDO

Please, use C comment style as everywhere else in the file.

> +	eeprom->reg_data_out = regb & UART_EXAR_REGB_EEDO;
> +}

...

> +static void exar_eeprom_93cx6_reg_write(struct eeprom_93cx6 *eeprom)
> +{
> +	struct exar8250 *priv = (struct exar8250 *)eeprom->data;

Unneeded cast from void *.

> +	u8 regb = 0;
> +
> +	if (eeprom->reg_data_in)
> +		regb |= UART_EXAR_REGB_EEDI;
> +	if (eeprom->reg_data_clock)
> +		regb |= UART_EXAR_REGB_EECK;
> +	if (eeprom->reg_chip_select)
> +		regb |= UART_EXAR_REGB_EECS;
> +
> +	exar_write_reg(priv, UART_EXAR_REGB, regb);
> +}

...

> +       priv->eeprom.data = (void *)priv;

Unneeded cast.

...

> +	eeprom_93cx6_multiread(&priv->eeprom, eeprom_offset,
> +				(__le16 *)&osc_freq_le, 2);

Okay, this should be done better I believe:

	/* ...Find better names for variables... */
	__le16 f[2];
	u32 osc_freq;

	eeprom_93cx6_multiread(&priv->eeprom, eeprom_offset, &freq, ARRAY_SIZE(freq));

	osc_freq = le16_to_cpu(f[0]) | (le16_to_cpu(f[1]) << 16);
	if (osc_freq == GENMASK(31, 0))
		...

	return osc_freq;

(Also no need to break on 80 characters)

> +	if (osc_freq_le == 0xFFFFFFFF)
>  		return -EIO;
> 
> +	return le32_to_cpu(osc_freq_le);

-- 
With Best Regards,
Andy Shevchenko


