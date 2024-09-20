Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8425817B427;
	Fri, 20 Sep 2024 14:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726844140; cv=none; b=a59DBX2PtRvcGwN0qfnj7YBiys2JDW2pSO1mAotuiQEQSl+TFp1RNUY0iies0ce2wCeVaJJbU9iPU4DEuOuN681BDydv3LLJSdu/Rp5LiuVgK6QUvQfG26OW2O1+cLWxiklGpz7VOctKSoxoHEwt8nNTO707jJcM3tX/jZtq4nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726844140; c=relaxed/simple;
	bh=nUJJa/OW8Uq6R+3FcGg0aOa0tqovjtnMTvW9iYDo0QQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NcJM2RtHaxEyzq7HiDZRtDwj47KoPb7VVtJGZie5qF115p/gd6AQ9p8eSEwBS5q5dONx76qGrVfSatnONv7gg9P97wpT+62noE5DN1kJlmeBLec/ZTzDlZUEO7DAE3tztTtlCmELLXLSzfc1fQVZ3JEHBbeYESv3S18oIwjU3q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T3eFlslZ; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T3eFlslZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726844139; x=1758380139;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nUJJa/OW8Uq6R+3FcGg0aOa0tqovjtnMTvW9iYDo0QQ=;
  b=T3eFlslZodPtc6ScUyHn19yDkmElFWykzEsmN1gfKrh9bx5cWs0vlNGd
   pH53tG6ecG5A5zkhSc5ahW8f7YanZRQR3CsSqYO1QlqxVDYTPHG+8M7HK
   Y2h5a3+8mu9AsTqbZN9KEgMyv09/up+BSx/0GNatx8CfIvoGoGPJK7B0Y
   cJLcdqMYwWockq9XgOXmwi9EQNidARL/1PsitCzcjYlHrtCeosir5NsEh
   XDArU6BpFGJJaaqUQcVcGo+Ck7TSs7bfbYRlSjbtmxWacuGo6Mi62KABM
   SwNX1NW4wQtoQzSy1By4aMKZ81kqMYwj2k6EPtfKYj5HeUQic5cfnqGS5
   A==;
X-CSE-ConnectionGUID: WC5R3x1qRlCCf+jY6ZTowg==
X-CSE-MsgGUID: S9/0HVYQR9meawDsG64kZw==
X-IronPort-AV: E=McAfee;i="6700,10204,11200"; a="25680119"
X-IronPort-AV: E=Sophos;i="6.10,244,1719903600"; 
   d="scan'208";a="25680119"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2024 07:55:38 -0700
X-CSE-ConnectionGUID: rf5Xv9kmSUuwHIUPtA5y1A==
X-CSE-MsgGUID: vf92MA3mT1ebcYB5CHEZNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,244,1719903600"; 
   d="scan'208";a="71171790"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2024 07:55:36 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1srf2j-0000000AwmM-1vID;
	Fri, 20 Sep 2024 17:55:33 +0300
Date: Fri, 20 Sep 2024 17:55:33 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Parker Newman <parker@finest.io>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	Parker Newman <pnewman@connecttech.com>
Subject: Re: [PATCH v2 3/4] serial: 8250_exar: Replace custom EEPROM read
 with eeprom_93cx6
Message-ID: <Zu2M5Y_scTkhSyzx@smile.fi.intel.com>
References: <cover.1726838531.git.pnewman@connecttech.com>
 <87719d2113970b6ff4979329fb96346a0aca9775.1726838531.git.pnewman@connecttech.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87719d2113970b6ff4979329fb96346a0aca9775.1726838531.git.pnewman@connecttech.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Sep 20, 2024 at 10:03:23AM -0400, Parker Newman wrote:
> From: Parker Newman <pnewman@connecttech.com>
> 
> Replace the custom 93cx6 EEPROM read functions with the eeprom_93cx6
> driver. This removes duplicate code and improves code readability.
> 
> exar_ee_read() calls are replaced with eeprom_93cx6_read() or
> eeprom_93cx6_multiread().
> 
> Add "select EEPROM_93CX6" to config SERIAL_8250_EXAR to ensure
> eeprom_93cx6 driver is also compiled when 8250_exar driver is selected.
> 
> Note: Old exar_ee_read() and associated functions are removed in next
> patch in this series.

Looks perfect!
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Let's wait for others and CIs to test all this and then after v6.12-rc1
is out (presumably within ~ten days) rebase your series (as I suggested
in another reply) and send a v3.

Good work!

-- 
With Best Regards,
Andy Shevchenko


