Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E5B3C1F47;
	Thu,  9 Jul 2026 21:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783633082; cv=none; b=NX3tnPppM1ON5g7Ky6sv6ivGFQ3k/KMyaa7XbmCPyrvjPh5tq4Vq37YNnjk6ClJFmxEiOjRGhydGWO6tFHHwe1kP2nnH2jjaVykp6gUG+6PCTAUYzfO6b+e0mLjD0UnEOo3zGL0vFxK2VQA+DLs4507f42AAV+OhAWQQtjHUWsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783633082; c=relaxed/simple;
	bh=Wzzc1x7NFGy0k2Enw7jaZtQ3c8SVSnjzLdO5T3BOosw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nb4X+iCJJ1qxrda9/nuo3vndDjOoPgsd8XRDJPMuCcuYOAq7RHZnZtRQyES8W2y7yTzJmYTsvRMVnSqcZAaCUCEqmREv2OJXI3QR68Zl2hFP3f1VaN0cmNDcRY0BTx/IF45VmXgm39WaVcSHtmSaN6g/lcIUXsW1HCJjEN7Cgts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jMb6xUYB; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jMb6xUYB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783633081; x=1815169081;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Wzzc1x7NFGy0k2Enw7jaZtQ3c8SVSnjzLdO5T3BOosw=;
  b=jMb6xUYBdYu7tEAbYgI0CHQlOXQ4zes8yBSSEeVFDUZUV7JxLb6xeBLA
   rcsNZXGjVsfRslc0vaOJDNrzmatF7aP8mRTqUpFQi1UNOus2OBKaEnvTC
   MOZz5i8YnIoL6gPQfGIgGzizxf8M4Br8dKaB6em6LMRIMRh22gI8/Oii6
   9yza66wehYc+YZ4zHy85aFWvo6KSNUnun3WUs8VRc2RLsPpy7TSwKqpfG
   v0u65CbQzb+Kx0pMvr5d0GgLQgFNQf288ecBPQs2QN9IMrrewHGivaTd3
   uxiSJ1rw2J2ZLJJ1MBaUg7GEjyQSz/92HIqfGSkXfrzVSkAq7efwtO0X8
   Q==;
X-CSE-ConnectionGUID: yMJdL9uWTlWqQ5d1nkG0EA==
X-CSE-MsgGUID: k1+qssdXQ9OTysOKCxNBxg==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="101882373"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="101882373"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2026 14:38:00 -0700
X-CSE-ConnectionGUID: FmyUnPDgQ/inMT7RwQxh7w==
X-CSE-MsgGUID: 5ZLKeGyOTDOvbUQEP5sTFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="254808888"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.100])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2026 14:37:51 -0700
Date: Fri, 10 Jul 2026 00:37:48 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Benjamin Larsson <benjamin.larsson@genexis.eu>,
	John Ogness <john.ogness@linutronix.de>,
	Marco Felsch <m.felsch@pengutronix.de>,
	Gerhard Engleder <eg@keba.com>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Binbin Zhou <zhoubinbin@loongson.cn>,
	Rong Zhang <rongrong@oss.cipunited.com>,
	Lukas Wunner <lukas@wunner.de>, Lubomir Rintel <lkundrak@v3.sk>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH 3/4] serial: 8250: map UAPI port type to internal enum
Message-ID: <alAUrANx15gyOgdZ@ashevche-desk.local>
References: <20260709205656.319531-1-ansuelsmth@gmail.com>
 <20260709205656.319531-4-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260709205656.319531-4-ansuelsmth@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Jul 09, 2026 at 10:56:51PM +0200, Christian Marangi wrote:
> There is currently some confusion when a new 8250 UART device needs to be
> defined with the related index for uart_config[] to be directly defined in
> UAPI header.
> 
> There isn't any specific reason to define the index directly in UAPI header
> unless it's also needed to be defined for userspace usage.
> 
> To try to address this confusion and making it clear how these specific
> index should be defined and where, create a dedicated enum in 8250.h
> with all the current defined values in UAPI header and document how these
> id should be defined.
> 
> Rename the define in 8250_port.c with the new UART_ prefix.

This will bring a wide field for the all possible conflicts and doesn't really
solve the issue. Why not simply kill the UAPI part of the definitions for good?
(Move the all, except the first 13) to be internal to the kernel.

-- 
With Best Regards,
Andy Shevchenko


