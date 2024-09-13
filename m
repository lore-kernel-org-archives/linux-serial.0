Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63A7E7F7C3;
	Fri, 13 Sep 2024 17:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726249732; cv=none; b=Cu//KEa1798n6akkov3n54E4eMcbKyf4LIbiftshpFPcKEgJuOl4YtUzegSXu7Pdr3CUd7MTRR7NLNAVl9VADvzUWgHiBwQPsP4VxYFaXG2a3wxjqBNBRs9tj8hb5NhyK+cjB6NQ+b+HNuepE1cckpJW23oUttWOlFBOnuUEbaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726249732; c=relaxed/simple;
	bh=KWNw400y492+BISxUL2yZV0O5pLBUz740lsF1ZP9EME=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bbHVt7n8JWVlcfeSojj00YIwVZMfBsxVTiWfoWm7C7cItglmbN5YLAmVWgX0CPU6FcxNbGojnFX9KAPQLjtasmTkmWZ8SH1GULHtndqmPk8LykfPNgVaQrrHjmpfLp82megThbZwDL7pIeUA0Zo3P55hfP2LwaJ51VvCXXOlGhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Gv1JKqyK; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Gv1JKqyK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726249731; x=1757785731;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KWNw400y492+BISxUL2yZV0O5pLBUz740lsF1ZP9EME=;
  b=Gv1JKqyKFNfh2pSEy454Gat3kJggACPaVMnPz+wio4y2ah4Jen9QfA5k
   qq2WFh8fBQgMwDKSpshSww/EQ4kpbTRskSlDK3I9nNHSTWUm+n0xqOR/m
   MA7HVj7ypfGxB0t+aFvZ+qcd5CluWOClef+Txw1DnsaP01e1B3nzMXUqj
   NQMhruHM5Ll+2bgMcwNkd4+/GrPhV3O0A+hlLhPv0wMGRqO43C4oKEPDI
   gP3dwIwxlfYgKM5mRIboqgIkC6ICU41iPpGK6MBMMzZKOL8DRgpPpq+x1
   G0KmyTUYQfCFVpgeuwDqkm7OvE3EYF+283Ga5tl/Wmj9PdU6HAKFsoTeh
   w==;
X-CSE-ConnectionGUID: i0ph15PwQRqT9E0n/8tinw==
X-CSE-MsgGUID: 66YvjhN3RiSjY1TaHpnYkA==
X-IronPort-AV: E=McAfee;i="6700,10204,11194"; a="24985040"
X-IronPort-AV: E=Sophos;i="6.10,226,1719903600"; 
   d="scan'208";a="24985040"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2024 10:48:51 -0700
X-CSE-ConnectionGUID: diYB6DOHQSWISScA1BEnxA==
X-CSE-MsgGUID: Dog+MS7TQF+zz0mcG6Rsuw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,226,1719903600"; 
   d="scan'208";a="91400420"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2024 10:48:49 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1spAPW-00000008NPU-0gHw;
	Fri, 13 Sep 2024 20:48:46 +0300
Date: Fri, 13 Sep 2024 20:48:45 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Parker Newman <parker@finest.io>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	Parker Newman <pnewman@connecttech.com>
Subject: Re: [PATCH v1 2/6] misc: eeprom: eeprom_93cx6: Switch to BIT() macro
Message-ID: <ZuR6_aPZdB80Kb77@smile.fi.intel.com>
References: <cover.1726237379.git.pnewman@connecttech.com>
 <ef318e16db5c0743c792950d0f2504d80b52a106.1726237379.git.pnewman@connecttech.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef318e16db5c0743c792950d0f2504d80b52a106.1726237379.git.pnewman@connecttech.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Sep 13, 2024 at 10:55:39AM -0400, Parker Newman wrote:
> From: Parker Newman <pnewman@connecttech.com>
> 
> Use the BIT() macro rather than (1 << (i - 1))

Missed period at the end.

-- 
With Best Regards,
Andy Shevchenko


