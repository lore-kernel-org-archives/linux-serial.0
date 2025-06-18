Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A813A93D;
	Wed, 18 Jun 2025 05:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750225542; cv=none; b=gV3mRYXeuJ7hGrv3AnnKxPDnnZhm2Er7fpySOqAFjI2LKLULo7iX3iaUIHSJDyutOF4VT80NZosESEjEaJAhyLBQyZnmnqLLt9w3rLSM9c3KX1/RHG0sN31d5fxXWTPXWHp4H6CHApdOHngUBBVJIvax3IVrYaf8nd9Q+Gp6img=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750225542; c=relaxed/simple;
	bh=PACc4hXvVgZJX33h5x/67CNeMX9qDdrkcUhytfm53YE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UfwvZeiUSYvZ56r8nXB0J+7PVT8xjvMzlll2GjIAHMOIzPVlyH0nrUAvml1Q+Vq0zyKpWytLk4qzra//+T2hb74VamEqPYa8zghZSZT0n6hDirDf72j4r3yTCEQmbvDMCj4V9pXlo87BDoG7f5QWKVtA0+Zp7UFP24f8NZkoueI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TxM/3Zb6; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TxM/3Zb6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750225541; x=1781761541;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PACc4hXvVgZJX33h5x/67CNeMX9qDdrkcUhytfm53YE=;
  b=TxM/3Zb6NS8NnzyAkO/bCOAjJ5OizgnLd6+yoR+hxc+6pi5zSVMf4E9X
   CBZWbmMdk/TutenNdBrNGO/CE2LcEhkclXCYjOSFWaxJgQ8Tnme54MTF3
   v6DIq4mh0dfz/Xc8CURtJqkN9rL0tIvByNGGp7SXD8fgDmcxZghfsErBn
   tUORKP6jd28ZTzBHm0w7h3uS1jaheUxXgDlQc5edUpEtEbOT/qSROObgP
   ZSuD0vEoZ28G4Zt5H/l6GmAyht36vFaLf6MaO7ZgPeSxMwxExc0dzsb+i
   cTwWYewfawd23l6K6bYma387WanCOXaw3nOlZUVzKsMUHTaeMUJvIXs+5
   Q==;
X-CSE-ConnectionGUID: LhUIoVguTQCKfA7E3Ozjcw==
X-CSE-MsgGUID: x/+GwMBHRo+A+mhmWQzaUg==
X-IronPort-AV: E=McAfee;i="6800,10657,11467"; a="63846708"
X-IronPort-AV: E=Sophos;i="6.16,245,1744095600"; 
   d="scan'208";a="63846708"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2025 22:45:41 -0700
X-CSE-ConnectionGUID: brZPEcg+S9apzLw1U49EDA==
X-CSE-MsgGUID: hZhAsm2dTdWEvpG5AnmwUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,245,1744095600"; 
   d="scan'208";a="150030509"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa008.jf.intel.com with ESMTP; 17 Jun 2025 22:45:39 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 31BAC12D; Wed, 18 Jun 2025 08:45:37 +0300 (EEST)
Date: Wed, 18 Jun 2025 08:45:37 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Cc: gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 31/33] serial: 8250: invert condition to avoid a goto
 label
Message-ID: <aFJSgfTrP0VTZ423@black.fi.intel.com>
References: <20250611100319.186924-1-jirislaby@kernel.org>
 <20250611100319.186924-32-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250611100319.186924-32-jirislaby@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Jun 11, 2025 at 12:03:17PM +0200, Jiri Slaby (SUSE) wrote:
> Use of "goto" in this code is frowned upon:
>  +-------
>  |if (port->type == PORT_UNKNOWN)
>  |  goto out_unlock;
>  |CODE;
>  |out_unlock:
>  +-------
> 
> Instead, simply do:
>  +-------
>  |if (port->type != PORT_UNKNOWN)
>  |  CODE;
>  +-------

Wouldn't this patch be a churn since you mentioned a guard()() conversion?
Basically with guard() in place the code would be better to change if it's
left as is.

-- 
With Best Regards,
Andy Shevchenko


