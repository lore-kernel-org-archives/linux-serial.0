Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D706920C462;
	Fri,  6 Dec 2024 15:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733499871; cv=none; b=eB3ry/E+Q5rBUB9pusP3DFk2z3XOoZ6ePH6gIAzblAaLoXVrJfA/RXTwIe57/xkw3e+oDyeqWl7Gt70uUX8rsauDAfQMKZX4W8h0OX8MYb5zZxAlDLjV4e6p+aiCbyb99aO/RVKMXZoL3mB6nv2LVOeJ7qUiwpMknt4u7rZzZOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733499871; c=relaxed/simple;
	bh=Ny++rUcaXgW8F97ufViqfTwXgVLk2FQNVuzmyCkinHE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H0rdOQqI0Y9mPh8ygNpt7DvUJUsaF0ebvMySWD0QeRMryMe9FeBUog3HEBLJ4n0Maat80NfAYrM6KrJIPMtXvnDolyMK4td9jOPs75e5qbdXGaMzjMzd/PbC1OEn9//jg+2lsmq7jY+z4jF7Y2TKvodNZ8dPDtKG/Q/eei6GIt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HxkoavMz; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HxkoavMz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733499870; x=1765035870;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Ny++rUcaXgW8F97ufViqfTwXgVLk2FQNVuzmyCkinHE=;
  b=HxkoavMzxJ7o7fGaMV6X2JeAtNgUIRmo4SpBYK8QdnwKeN7YedsZEfMW
   cx7d+Cr1BW1DG5ai0OiKmUbRtT1INKhyPY9h7SOWDEL4FgWMpeBiA0KLE
   dg+opkcvT1UZPwXEEcXZ4pbgjN8fVf21CeltRmewrgfCmDcowYhirbfHq
   wVS4EieStdEM1RYpasvz40BlSEmp6RSy0v6cenoYl8rNqxiXkiDklNknn
   5nSwmI6GwLJTcBQA5lU83Us7Wa84J1K0nMTMd+C0dpf19trHPDYzXvtYW
   pJpXaOxXqm1NF0epaULelpnia/Pr5SyWvWzevWaKTkKoRW28DkkqnEzwT
   A==;
X-CSE-ConnectionGUID: mEzt7pyKSbWm9WUwgWb+jw==
X-CSE-MsgGUID: a/wFhheuRaqBoNwCc2asPw==
X-IronPort-AV: E=McAfee;i="6700,10204,11278"; a="33737576"
X-IronPort-AV: E=Sophos;i="6.12,213,1728975600"; 
   d="scan'208";a="33737576"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2024 07:44:29 -0800
X-CSE-ConnectionGUID: qwQ9mNvYQc+xpe82cpP+dQ==
X-CSE-MsgGUID: zgDGVInUTwmnHkjEE9B/5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,213,1728975600"; 
   d="scan'208";a="95246338"
Received: from smile.fi.intel.com ([10.237.72.154])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2024 07:44:26 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tJaVE-00000004YaX-05b2;
	Fri, 06 Dec 2024 17:44:24 +0200
Date: Fri, 6 Dec 2024 17:44:23 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Guenter Roeck <linux@roeck-us.net>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-serial@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
	linux-kernel@vger.kernel.org,
	Yang Yingliang <yangyingliang@huawei.com>
Subject: Re: [PATCH 1/1] tty: serial: handle HAS_IOPORT dependencies
Message-ID: <Z1Mb15vOY4fJjsKt@smile.fi.intel.com>
References: <472eb22a-dcb1-4fbb-bf2c-a4173706bc7a@app.fastmail.com>
 <27685942-fb62-44c5-86ed-98beb547ffed@roeck-us.net>
 <744920ba-551c-466b-ac5c-2607b81261a0@app.fastmail.com>
 <Z0QtZky8Sr7qUW7v@smile.fi.intel.com>
 <00f5e842-3ee9-4d83-8836-0ff4f703fa3c@app.fastmail.com>
 <Z0RSZ-YD_BozMs1n@smile.fi.intel.com>
 <be43108e-4135-4927-ba58-141836fde6af@app.fastmail.com>
 <30a38025-afae-4bdf-a468-21ae2cd5a7b3@app.fastmail.com>
 <4446d7dc-efb0-4395-8fcb-7177d9e07b5c@roeck-us.net>
 <acdab483-05a4-4fa8-ae1c-70ed53402aa2@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acdab483-05a4-4fa8-ae1c-70ed53402aa2@app.fastmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Dec 04, 2024 at 11:17:56PM +0100, Arnd Bergmann wrote:
> On Wed, Dec 4, 2024, at 22:09, Guenter Roeck wrote:

...

> I got stuck in this rabbit hole of running into more issues
> with the 8250 driver. Any time you touch something, it breaks
> elsewhere.
> 
> I've uploaded what I have here now:

FWIW, I have briefly looked at it, some patches I appreciate very much, some of
them I think need more testing and one thing I don't really like is putting
code back to 8250_core. Thinking about that, perhaps we need to restore 8250.c
(or alike) for collecting non-library / non-_particular_-driver-leaf?

> https://git.kernel.org/pub/scm/linux/kernel/git/arnd/playground.git/log/?h=8250-cleanup
> 
> but this probably needs more testing, and a few smaller changes

Definitely!

-- 
With Best Regards,
Andy Shevchenko


