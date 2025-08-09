Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3215A1D5ABA;
	Sat,  9 Aug 2025 09:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754732856; cv=none; b=AD/eLjcFJykji/tBL2hB6eijaSZUx47LkQKypPWg8rqkjhYjtO0I9onbCDdiqchtwMClXeJj1n9qTZqFcujCe9+weSGXS8+ObRd31AUQe2Q/FNcJWweItNtVER0IY6M8+iF4T575tW22IBJDtL5j3kJtOVpjXp2hUAaGHv6RTEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754732856; c=relaxed/simple;
	bh=JINXn9Zyw+aEkTOgsmUWAuNYs0DmFS5fyd6z0+L/6+E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FMF3FD2JDBYgdp1/jEbkadOHWxOy4Rh9Utgt6tuCRfDzPJQVUkuEoCSex3JH+WKpf6vor3VtNsiiJQXyPOG4fZ1kmKkPS214/Mx6SNJ3DQ6o2l2ppnL9IkxVpGsZydc/pLd+k/M2IQFY25a5VsIZN+QfcKlqawiWUPeFTIc53EI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HP0Tzhzz; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HP0Tzhzz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754732855; x=1786268855;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=JINXn9Zyw+aEkTOgsmUWAuNYs0DmFS5fyd6z0+L/6+E=;
  b=HP0TzhzzWmln7wxLl5g131EaKGEXx5YSjcKbRAwlZDfy/lbXp4lHGPZj
   2d7uEgCtNUpnvsODQ4gRDRRQ4+1v84AjUALi85tpZhBJEd63iQGr4dYBX
   vmxdbVm0inOyc4X2TWj4thf1WBTxpI9vmB5S1umn7zFqq0XGmH6WVAF9N
   4pUjhOIONzuUuymc8bVX4KvG9SggHxVYK31AxTQun2XFdTQdaK9ZU9N2+
   4IR5MAF8/JJZgQkp3l4zLUqTWWJgiACgMEE4k4YE+HHm2LXsxrjK5jDcV
   qbVAkqhWwZmpiSLPChO/fpwpOvj9PJzSDPQLq9Lo4/ySgu5OMJeb39rqZ
   Q==;
X-CSE-ConnectionGUID: /LW/pJEETCOvmfPVJg0sZg==
X-CSE-MsgGUID: xoaNa6OnTjqIrHCrnRBmCg==
X-IronPort-AV: E=McAfee;i="6800,10657,11515"; a="68433297"
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="68433297"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2025 02:47:35 -0700
X-CSE-ConnectionGUID: Mb1Ht4xzTp2hIg69i/K4Gg==
X-CSE-MsgGUID: RPZLRIZARkOlewicNsoGQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="165880184"
Received: from smile.fi.intel.com ([10.237.72.52])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2025 02:47:32 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1ukgAj-00000004cW8-2uf7;
	Sat, 09 Aug 2025 12:47:29 +0300
Date: Sat, 9 Aug 2025 12:47:29 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Abinash Singh <abinashsinghlalotra@gmail.com>
Cc: arnd@arndb.de, gregkh@linuxfoundation.org, jirislaby@kernel.org,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	sunilvl@ventanamicro.com, u.kleine-koenig@baylibre.com
Subject: Re: [PATCH v3 0/2] serial: 8250_platform: Reduce stack usage in
 probe functions
Message-ID: <aJcZMel1baOP-xHF@smile.fi.intel.com>
References: <aJO9fnbydWqu1RpJ@smile.fi.intel.com>
 <20250806215134.4921-1-abinashsinghlalotra@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250806215134.4921-1-abinashsinghlalotra@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Aug 07, 2025 at 03:21:32AM +0530, Abinash Singh wrote:
> On Wed, 6 Aug 2025 23:39 Andy Shevchenko wrote:
> > Have you had a chance to see Arnd's comments?
> >
> Yeah ,I have made comments on that.
> Please check that and provide feedback.
> 
> Hi,
> Apologies for not reviewing the patch carefully before submitting it.
> It's 3 A.M. here, and I’m still up, so I missed it

If others are okay with this intermediate step,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko


