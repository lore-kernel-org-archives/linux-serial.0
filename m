Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C087056E042;
	Tue,  8 Sep 2026 15:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788883105; cv=none; b=jORhHxemh6y72jO8nYbD4E3YIwlYxh9xv0UA6ONCJ1hlQR3z4t2I3FHZW4+lsWRPAheCZtrpl1D0ChiBWqijXjmX0P9GKeQXB69fCkzkFoBbBVHe8cFWKNlqznNHSG3leFDUyqzHNTHQ+dADusXsQKenY05/s9b1KvM9Noad1VA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788883105; c=relaxed/simple;
	bh=kUrLkyC+/QMgWXSK8kBjT7dW2PxhBp9WV247eIJFVNY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JsMcfVIrgX6TXriwDZFm+ZcT5mFszrU0o6gl+8RpVj4gcj/x8DrFCBEE0pf9Q0gUn5JjeQTYH84kQELiUcjgWl+kXH2ECgzEDPuDLsKxZ1ACBlI0VVQLTyu8g4T3om5zzF4Q3Oglmn2PyhXO7zI4hKEd0eFuV2lCoFXk0e2Jhdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YXxk2Ruc; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YXxk2Ruc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788883103; x=1820419103;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kUrLkyC+/QMgWXSK8kBjT7dW2PxhBp9WV247eIJFVNY=;
  b=YXxk2RuctGASLDAnkcqQYKCQHCfxBPmDxRqEFpjn1unJDyMYlIxGkO1a
   IgB/9tT/oZx/YY9QUvmHQfmI8fpQizh7QSrHds0V+074vmnOAjM+OogN1
   7sEquOptM1TDoC7CtqrIOzLNYS5/tHvrOENedzEetk/heWfRMgjuNNAU+
   bCXXDGUpKaOwqgMgQ3UACpi4/kEI08gUuyEh4JkpzWiZrCXZoiAvBOXfZ
   mgTmzYLNxiJAsQ3ZjvAftjW2Tbm2lVCd7xfYO3gRo2kBOxfrKxyCAO2d7
   Xr1JMVF2lL+kBXLbNCZqq2ug980F6HT+/A9Y/ugNYP9dFkzrSOC6jojPJ
   w==;
X-CSE-ConnectionGUID: Ap7crcdbT76eS53QhAl5/g==
X-CSE-MsgGUID: +3oO8/Y3Ti+b8HVTFS45pQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11900"; a="106660503"
X-IronPort-AV: E=Sophos;i="6.25,269,1779174000"; 
   d="scan'208";a="106660503"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2026 08:58:22 -0700
X-CSE-ConnectionGUID: 4f2Z7aI4R3GOjJ4ANUXnBg==
X-CSE-MsgGUID: 8Qer96TlSL6Hq8q8RR6ebw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,269,1779174000"; 
   d="scan'208";a="274841722"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.92])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2026 08:58:19 -0700
Date: Tue, 8 Sep 2026 18:58:17 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Yicong Yang <yang.yicong@picoheart.com>
Cc: ilpo.jarvinen@linux.intel.com, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
	jirislaby@kernel.org, geshijian@picoheart.com,
	yangyang.8776@picoheart.com, yanligen@picoheart.com
Subject: Re: [PATCH v3] serial: 8250_dw: Prefer SRBR in bogus RX timeout
 workaround if available
Message-ID: <aqAwmQpO_6e2oQZx@ashevche-desk.local>
References: <20260908141524.20302-1-yang.yicong@picoheart.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260908141524.20302-1-yang.yicong@picoheart.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Sep 08, 2026 at 10:15:24PM +0800, Yicong Yang wrote:
> The DW uart could get into the cases where a bogus RX timeout
> interrupt is asserted but no available data. This could be
> workaround by doing a bogus read.
> 
> Currently the driver's using the standard RBR (receive buffer
> register) for this bogus read. However the reading of RBR
> in this case is allowed to raise a hardware error if vendor
> choose to implement in this way (our platform). It's also
> allowed to do the bogus read using SRBR (shadow RBR) for
> workaround which won't raise the hardware error. So change
> to use the SRBR to workaround the issue if it's available.

Okay now.
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko


