Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58CDA9454
	for <linux-serial@vger.kernel.org>; Sun, 16 Feb 2025 20:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739736799; cv=none; b=sTpcBEfe1DBGtOxrJRD2sfxKAu7Ny9Q3qlaAFr4k1f+xStjzdwIzgt9jvu6Ge1a+Dk+y+z8Kq34uflhE/z5MKNLiX1LtIdDqdxSfcVQNkC3qlKIPhzRo9QLJo1qnV+FthDg8cnNYVnHT1rItQtpXV9JppwlSBfuQpjILR+2gXNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739736799; c=relaxed/simple;
	bh=/3goS/B/0TuHOpIkgJCW7Ile8lPR4M0Pq2wcji6Mp9I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pX4cx5bzIfafSAvYQrf+KXaLz3TobFwU07zeGAVp4toY/7bl0Xil4OrAUEKENOiio114lpE8nKslcsYBj3704Ipu4jkrQ8aZ6F3muw4ZeGvVORY/8xObKeQBX1Fq5J/CYeFI5ruNzhE7GUcxVUaJGQbu3xn+o16iERc+RQScPvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RnTP4Dfi; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RnTP4Dfi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739736798; x=1771272798;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=/3goS/B/0TuHOpIkgJCW7Ile8lPR4M0Pq2wcji6Mp9I=;
  b=RnTP4DfiB4OSBVYV2FkNo4qcYvyLQv2WeLmPFFtKj9mesozMKjtlHX9L
   dqRfOM+yt/GnUP6zrDWJlAnBmhfEoqhWCD4T2y0rJhSpJbJRjK03cjEjP
   HEErouEhu7e0HGgYbomGxK5q5G9Sm2TvlhT9wb3IUCgvkTTueCcl40JBd
   b3iUzuOjKuACMkLQsEFD6elU4DP/xEtbGdPQZUEa1OyjcRNdZ451M0kPt
   eKokbeqg4Exs6Km1Np0UZgPOQ0Win5B9hDWUemjfWc8QTaO9/W1sQI10R
   EZvhtHK8qcF69ZwZlLZE8Un3FEpQTM+QtL7IJf2lcfNvPokUwmm/R5eOe
   w==;
X-CSE-ConnectionGUID: IeDycitPSTiC7EMvl6cX9g==
X-CSE-MsgGUID: V/d4WT0oQX+xE/8OGV6MzQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11347"; a="40557481"
X-IronPort-AV: E=Sophos;i="6.13,291,1732608000"; 
   d="scan'208";a="40557481"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2025 12:13:17 -0800
X-CSE-ConnectionGUID: yjMVYenURReTGD/qT+6iVQ==
X-CSE-MsgGUID: fjBnY6UJQka6YMu6LpWoSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="144859915"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2025 12:13:15 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tjl0r-0000000CCkJ-06EO;
	Sun, 16 Feb 2025 22:13:13 +0200
Date: Sun, 16 Feb 2025 22:13:12 +0200
From: "andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>
To: "Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>
Cc: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
	"intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
	"intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
	"Kurmi, Suresh Kumar" <suresh.kumar.kurmi@intel.com>,
	"Saarinen, Jani" <jani.saarinen@intel.com>
Subject: Re: Regression on linux-next (next-20250210)
Message-ID: <Z7JG2BAR0taUWHAU@smile.fi.intel.com>
References: <SJ1PR11MB6129D6C5644D4A6C858A4F04B9F92@SJ1PR11MB6129.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <SJ1PR11MB6129D6C5644D4A6C858A4F04B9F92@SJ1PR11MB6129.namprd11.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo


The fix landed upstream, will be in next Linux Next.

c213375e3283 ("serial: 8250_dw: Call dw8250_quirks() conditionally")


On Sat, Feb 15, 2025 at 04:16:58PM +0000, Borah, Chaitanya Kumar wrote:
> Hello Andy,
> 
> Hope you are doing well. I am Chaitanya from the linux graphics team in Intel.
> 
> This mail is regarding a regression we are seeing in our CI runs[1] on linux-next repository.
> 
> Since the version next-20250210 [2], many machines in our CI are unable to boot.
> 
> Unfortunately, we have  not been able to collect any logs (even from pstore).
> 
> However after bisecting the tree, the following patch [3] seems to be the first "bad"
> commit
> 
> `````````````````````````````````````````````````````````````````````````````````````````````````````````
> commit bfd3d4a40f3905ec70b17dbfa9b78764e59e4b4f
> Author: Andy Shevchenko mailto:andriy.shevchenko@linux.intel.com
> Date:   Mon Feb 3 14:14:56 2025 +0200
> 
>     serial: 8250_dw: Drop unneeded NULL checks in dw8250_quirks()
> 
>     Since platform data is being provided for all supported hardware,
>     no need to NULL check for it. Drop unneeded checks.
> 
> `````````````````````````````````````````````````````````````````````````````````````````````````````````
> 
> We also verified that if we revert the patch the issue is not seen.
> 
> Could you please check why the patch causes this regression and provide a fix if necessary?
> 
> Thank you.
> 
> Regards
> 
> Chaitanya
> 
> [1] https://intel-gfx-ci.01.org/tree/linux-next/combined-alt.html?
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?h=next-20250210
> [3] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?h=next-20250210&id=bfd3d4a40f3905ec70b17dbfa9b78764e59e4b4f 
> 
> 

-- 
With Best Regards,
Andy Shevchenko


