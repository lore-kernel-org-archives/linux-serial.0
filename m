Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B911F5845;
	Thu, 20 Feb 2025 12:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740054467; cv=none; b=uzIb4y69sq84OejLwwaKyjhzOEYrQNPPWp+tPvDquA+WyI5/MbjdT0R0IG04xoPLSmjGj5bOBGNeEm6rMAsW4tL8b4D+xFyxS9TOhaxmUEkF59vmZEIOn7GyT/2E3lDKdFET6TKnhiVhSCLIj+useXD3vckVM6pRefO1UHlwkHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740054467; c=relaxed/simple;
	bh=z/5AJyHI0LKzLrcja6hFJ29UKN9qzCXhiR8+FdJShR8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O2e/GWh9TbWZZylN1EnbNiAwLoYzyYT/Y6pkELMOdvBVhuhw3GvyRCVVjrvP4+JiLLizmXC5CKFy3P+ODAKyIVBE2U7kpz0BZs8rIRaS+P0jvwLKAvho/rmSMHVXD9qCnfLftwU3CK2Wjygkin5YeTu1lKr8dMit6WsPcUgJcCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=COjHGeFW; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="COjHGeFW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740054466; x=1771590466;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=z/5AJyHI0LKzLrcja6hFJ29UKN9qzCXhiR8+FdJShR8=;
  b=COjHGeFWeAdnQDfnh2c8J4gM0F5Bcc/AkVAJyhPlMhsvAY9a+YM8IE3J
   p63KFIQ3D9/RUIFUaMGTdCzPsyzFzRC8HZuYcgByqa9ulF/m2JkQ4fem/
   GhejUoNgIj8ZKVgxV3dauSzQ7nc5L/pdw8v+6SvnggtpCGvS6rQVZ5XJX
   GI57lCeZyhNFh96r5++ZT1eGfiPmknfZhZvh8o45T+NarcMgy4yzUsZk1
   jvapP8xroBiG3hxvdNOKg4+vRB5nN6ZejgNqFIVYijCuU6BECf9CgroBc
   Ts4skMFjb8nI1aC4CAmjEuSMOqwLBqFr7Z95KE5FVM00NPUwy957yXeQS
   w==;
X-CSE-ConnectionGUID: vpN4F/9zTxypfuxZ4K2SdQ==
X-CSE-MsgGUID: jBcRMazQQPOnEhwHlEpkbg==
X-IronPort-AV: E=McAfee;i="6700,10204,11351"; a="44479677"
X-IronPort-AV: E=Sophos;i="6.13,301,1732608000"; 
   d="scan'208";a="44479677"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2025 04:27:45 -0800
X-CSE-ConnectionGUID: Q+Bm36xURVGaUGWHyBrZBQ==
X-CSE-MsgGUID: RaXisJl/R4qNBFrq0aJzTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,301,1732608000"; 
   d="scan'208";a="145876971"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2025 04:27:44 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tl5eX-0000000DKRw-0wts;
	Thu, 20 Feb 2025 14:27:41 +0200
Date: Thu, 20 Feb 2025 14:27:41 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Cc: gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: Re: [PATCH 26/29] serial: 8250: use serial_in/out() helpers
Message-ID: <Z7cfvXUCHXVXK_mp@smile.fi.intel.com>
References: <20250220111606.138045-1-jirislaby@kernel.org>
 <20250220111606.138045-27-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250220111606.138045-27-jirislaby@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Feb 20, 2025 at 12:16:03PM +0100, Jiri Slaby (SUSE) wrote:
> There are serial_in/out() helpers to be used instead of direct
> p->serial_in/out(). Use them in various 8250 drivers.

Is this just a mechanical (compile-only) conversion?
IIRC 8250 DW code is twisted in some cases and it might
be a possibility of dead loops, but I don't remember it
by heart and haven't checked myself before writing this
reply.

TL;DR: this needs a thorough review.

-- 
With Best Regards,
Andy Shevchenko


