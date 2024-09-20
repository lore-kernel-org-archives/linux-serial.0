Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E61CC13B;
	Fri, 20 Sep 2024 15:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726845976; cv=none; b=CRkxM0KmSun9uaOSUaHTmt1YOThV9FTudiTYRuPsihwGXoo7QxEsezagl5Oa/mnPbERb8DGb+kTNcrKGucShTM52/NKB3cU/FKPo87TGlFcd6llH9tGexkFkPahzHnVPW4mymbJ9R80Cy12nOIPdfgEpIhuZoDJLnOrd367sO/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726845976; c=relaxed/simple;
	bh=rjPgjuJ8yWQyJ6DbGNz8WzlxtoTVmXlT8Xdhz6vEGQ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c8oyzotnOJOGXCjyJDcXRGI6Laz2BTM/8t5qRMl/rIERiNl1Ov0VF/dLsiPrq62VFUHekOvgkbwklodPixUeOh1A3LLtgPQhczslOTBb5bBVSn54PmhWemoLkAix/4fsbRB3h351bX5vCMmpGZY9Pjs6VQeF6RjtsuvnJtetZ4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kKVpW9sn; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kKVpW9sn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726845975; x=1758381975;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rjPgjuJ8yWQyJ6DbGNz8WzlxtoTVmXlT8Xdhz6vEGQ0=;
  b=kKVpW9snOVwNdrDz2v/GK3Shrk2SyL8S9zptyjL9ZX/vg6grxrQofZCC
   lHqpxKOKXOsqngDia9GN7Q+oCBtx/yL5/K3qShVBMIIWcAWuQD0zGmLVh
   79RAi4r/2EfJ5Q7h/0QM2NfkEIC7lpKabQM3I1ifCr4lqrjCcN0sG6tK2
   XbhEX2XI3C/dIpy4HNxpUjKAMpXY41hkQMJA50NO9Jy1e0VUwwps2ceS2
   jL+ugtwS7C47y/DCrJClImnON6nQ4U+XR+zcelhAFhgaV0php+rfl29KN
   1o/sct0ATSdpX+S2q37QJmFq24SmDBD3cGOrsoZMiNxlQrnsdmiOj5nPo
   g==;
X-CSE-ConnectionGUID: jDwPxrlxSS2CmbT7ztCh6w==
X-CSE-MsgGUID: ah9WY0awQYiPZteAbc9GZA==
X-IronPort-AV: E=McAfee;i="6700,10204,11200"; a="37231992"
X-IronPort-AV: E=Sophos;i="6.10,244,1719903600"; 
   d="scan'208";a="37231992"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2024 08:26:14 -0700
X-CSE-ConnectionGUID: SqMWRtclQPGi3AdjxXEtKA==
X-CSE-MsgGUID: 756vvMZRRPKcQ3Q+3j4/2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,244,1719903600"; 
   d="scan'208";a="70780121"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2024 08:26:11 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1srfWK-0000000AxHe-30In;
	Fri, 20 Sep 2024 18:26:08 +0300
Date: Fri, 20 Sep 2024 18:26:08 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Parker Newman <parker@finest.io>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	Parker Newman <pnewman@connecttech.com>
Subject: Re: [PATCH v2 3/4] serial: 8250_exar: Replace custom EEPROM read
 with eeprom_93cx6
Message-ID: <Zu2UEAY1jweup6tS@smile.fi.intel.com>
References: <cover.1726838531.git.pnewman@connecttech.com>
 <87719d2113970b6ff4979329fb96346a0aca9775.1726838531.git.pnewman@connecttech.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87719d2113970b6ff4979329fb96346a0aca9775.1726838531.git.pnewman@connecttech.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Sep 20, 2024 at 10:03:23AM -0400, Parker Newman wrote:
> From: Parker Newman <pnewman@connecttech.com>

...

> +	osc_freq = le16_to_cpu(ee_words[0]) | (le16_to_cpu(ee_words[1]) << 16);
> +	if (osc_freq == GENMASK(31, 0))
>  		return -EIO;

Just noticed that you have
#define CTI_EE_MASK_OSC_FREQ_LOWER      GENMASK(15, 0)
#define CTI_EE_MASK_OSC_FREQ_UPPER      GENMASK(31, 16)

So, please modify them and the above check using these.
Something like

#define CTI_EE_MASK_OSC_FREQ		GENMASK(31, 0)

	osc_freq = le16_to_cpu(ee_words[0]) | (le16_to_cpu(ee_words[1]) << 16);
	if (osc_freq == CTI_EE_MASK_OSC_FREQ)
		return -EIO;

P.S> If I am not mistaken the definitions were only used in this function.

-- 
With Best Regards,
Andy Shevchenko


