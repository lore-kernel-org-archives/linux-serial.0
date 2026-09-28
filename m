Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F361397;
	Mon, 28 Sep 2026 08:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790583472; cv=none; b=plszoQwZcyknbFYFZTm4P7XaufSvU+SbWe32QrBaX0AD3M9bJD0nuVgiw6DS7eYy0TpgDMarEITwcPj3b6RSLfeYEAH854wAwoY4lyC/eyNRb/TjMJJbfYmW+sCnNP5t5EQndggLTRVoAw9CxcnA8VVdawR8mRuU4oJpPc1/otE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790583472; c=relaxed/simple;
	bh=m84zE9OYT/4/mg3UMD5noec+OVCVO69MTWjSInZPnRA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cXyLYgWhHEKkWJrwF8x8SdR+KXiNYqT50eGjY5/W7isXIO31Uy2pCufTJ93whiu+KaJtz9xdkOGQtxcLGqxZcZDl6hReVWXkN90x1spoWyH9Aitg03HB/Ecy4q314RJCeDXXF7xUy/OKnQly8YK1sPi0teOSeOKzr2mIcEcFXXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m22rFIzE; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m22rFIzE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790583471; x=1822119471;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=m84zE9OYT/4/mg3UMD5noec+OVCVO69MTWjSInZPnRA=;
  b=m22rFIzErdAx2pFOE0OOnPaU9PFQCu3CZNliNTzcemk3Lxf7WAgudoR1
   dQsVS67KBli8eWrqDiSH0USDcvJLYLuTTZEhRB63OHH6yFu+NJEIPXsL+
   /BgMrpfu8uuQpNBXHBsegTmsDj72NhEg5RhStqGmE7IzdGiPYJcL4R1qK
   S7NOWAObsQOhRkrsM6ZbHCxKCW59IUzVwRogIfL/frDb7RWefFI6HOv3Q
   i5MQqVMb/4fXm2r/ysINYkPWk/uZOc0FZshoggqp+XRBUIjasGIeKh9ep
   x8UZ0FNRvvd+waD57Q5gUN8FnJ9QERJPb67f3j5yVgCJW4jby38SD7D15
   Q==;
X-CSE-ConnectionGUID: CvvpFwiTTjWtSHR5SbOZbQ==
X-CSE-MsgGUID: 81jBpbgdT5yy9UHcn2xPtQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11918"; a="108765615"
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; 
   d="scan'208";a="108765615"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 01:17:50 -0700
X-CSE-ConnectionGUID: CeWcrxcESIeMqahqFfMzRQ==
X-CSE-MsgGUID: 9X8b0+/DQIq/f5pNi/jD8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; 
   d="scan'208";a="274220060"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.42])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 01:17:49 -0700
Date: Mon, 28 Sep 2026 11:17:46 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Andy Shevchenko <andy@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Tate Whiteberg <whiteberg@arista.com>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH] serial: 8250_mid: Add missing module namespace import
 for SERIAL_8250
Message-ID: <aroiqrAK1LWQ-nQp@ashevche-desk.local>
References: <20260927-tty-8250_mid-ns-import-v1-1-84d0482e1c5d@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260927-tty-8250_mid-ns-import-v1-1-84d0482e1c5d@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Sep 27, 2026 at 01:01:17AM +0200, Nathan Chancellor wrote:
> After commit 1c305d5f1daa ("serial: 8250_mid: wait for LSR tx empty
> before setting termios"), modpost errors (or warning with
> CONFIG_MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS=y):
> 
>   ERROR: modpost: drivers/tty/serial/8250/8250_mid.ko: module uses symbol 'serial8250_wait_for_xmitr' from namespace 'SERIAL_8250', but does not import it.
> 
> Add the missing module namespace import to clear up the error/warning.

Oh, indeed, good catch!
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


