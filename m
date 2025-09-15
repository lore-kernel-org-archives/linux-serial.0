Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 172E3321F3F;
	Mon, 15 Sep 2025 14:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757948052; cv=none; b=Qe8/fsVsFU47shlvqvU9olBCAdmXW2Hy8vn5PQU6rsJqTv5tC2pT6nyDiqHIxipU/q71AKhaal+11DtqQmYzsVxhYgT5A9Lh79A/n1QYKh9BuJQy6PMlqHFdOPgsjt3/QCiThLWGYbqvc8RXl1j97JXsGHpxfQtvLs1ZGDK/dzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757948052; c=relaxed/simple;
	bh=5zvV9UB2aUF1HHaCSUBXMQThneYkRcHlnJ3H82rt5bI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ncA4Bkbs9aCqn+08S5f2xD8VyAC6G9lobn2YOmUgIPwGKxDV2ScfvHK8PLHan5fKh/FemRVVmimBh5IBFUUhWH+IBdmU2kOF7Tswm//rmaUBzEa4IA9y5p9zIlrbW1caIODtsyATuHOoj7REZz8NlFELB745be7c2FW7DuRG2LU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=huqOC9Do; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="huqOC9Do"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757948051; x=1789484051;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5zvV9UB2aUF1HHaCSUBXMQThneYkRcHlnJ3H82rt5bI=;
  b=huqOC9Dor9qLp3BNVidfYTMJdkgnh1qUdBK3I1g2ahR1WiidIBSCNPaw
   4iHKgRQ33AUi2Jw2DfQzMS9Pgx6sK+bh89mN5qmPA9P3COedxLfrNH4ed
   pii9/jHQ0PVUwUrNReHWEQ3eBCVSGnsByFZqRWtwi+DFEq0x7jFln5Ez/
   4M64+Y0ZK6N9tCMWLR1h/i+sQ/b5U1CrSEPaDt3acEtS+kqgiuEF+ynB7
   2CkFtpNZBpvr68YKhLl+MOprb0dRSlE4ur4bgDyIOLtLYv7yrgRSKGzho
   DWKoT0CZSVJhxhs/YvNEfg0ECSpuQlEbTIPW9dBvcCmdVfQXGri/J+fiU
   A==;
X-CSE-ConnectionGUID: 01KJqS+tR5yM/0Ots+3yOg==
X-CSE-MsgGUID: LdixdzM3QmOWdEnqOsCJ2w==
X-IronPort-AV: E=McAfee;i="6800,10657,11554"; a="82795224"
X-IronPort-AV: E=Sophos;i="6.18,266,1751266800"; 
   d="scan'208";a="82795224"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2025 07:54:11 -0700
X-CSE-ConnectionGUID: E3GBIukpQ82WZ5mySMLIug==
X-CSE-MsgGUID: D+8ffKhCR6CpAUOP6jo9fw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,266,1751266800"; 
   d="scan'208";a="174734971"
Received: from smile.fi.intel.com ([10.237.72.51])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2025 07:54:07 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1uyAah-00000003HCK-2SRS;
	Mon, 15 Sep 2025 17:54:03 +0300
Date: Mon, 15 Sep 2025 17:54:03 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
	Yu Jiaoliang <yujiaoliang@vivo.com>,
	Changqi Hu <changqi.hu@mediatek.com>,
	Sam Shih <sam.shih@mediatek.com>,
	Steven Liu <steven.liu@mediatek.com>,
	John Crispin <john@phrozen.org>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v2 1/2] tty: serial: 8250_mtk: enable baud clock
Message-ID: <aMgoi8sQlNhc3CXq@smile.fi.intel.com>
References: <2de07b0a6d51d5d3bf3e55cd03cf75adfc91ee7d.1757941345.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2de07b0a6d51d5d3bf3e55cd03cf75adfc91ee7d.1757941345.git.daniel@makrotopia.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Sep 15, 2025 at 02:06:37PM +0100, Daniel Golle wrote:

...

> -		data->uart_clk = devm_clk_get(&pdev->dev, NULL);
> +		data->uart_clk = devm_clk_get_enabled(&pdev->dev, NULL);
>  		if (IS_ERR(data->uart_clk)) {
>  			dev_warn(&pdev->dev, "Can't get uart clock\n");
>  			return PTR_ERR(data->uart_clk);

Consider making this to be either dev_warn_once() / _ratelimited() or
better to have

	return dev_err_probe(...);

This will allow to avoid flooding the logs when clock is not yet ready.
The proposed change can be done in the separate patch.

-- 
With Best Regards,
Andy Shevchenko


