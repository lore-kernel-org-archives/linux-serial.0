Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE5C1E868;
	Fri, 20 Sep 2024 14:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726843522; cv=none; b=T/6ExRMThtJuXJ8NRf4WXk6CWKqKrXy+1oMT40nGSBG3qTtLvMHNo//aQBsytVrF3H9wDMs5DGwqrsjq3uk736Ukz6PXSnZndhoLN7YaAnCXyoiN6XYxK42z18RTrJL0kJ6ChyY6p+Bo8Dp4+MsJ8NR+1oEqLAcOMMMTj01Ph0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726843522; c=relaxed/simple;
	bh=Dsjd+Uk2q1/c3GCoG/lSbGtlmVucp4pY/9PN7QQK5iU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NIjMktO9IaoWybb3FfcPQk0jJxHaRnzVTIv8fW5cRcRUClG3G1w5hWW4y1c2DeL6p9GsNWxuupgdrJFgNgDbDoWcbGKr5q51b8g8QwMtZuEY4xSUsVCOO4L++e4UaDlioEZvB3S+I+d4hiFQGXyCRz4zHUyHlt/EYICdJde6rZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UlupB3Zr; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UlupB3Zr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726843521; x=1758379521;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=Dsjd+Uk2q1/c3GCoG/lSbGtlmVucp4pY/9PN7QQK5iU=;
  b=UlupB3ZryPxnZmRXtfz5VBDpbPrc68TIkedkQhLkE5R5YDihE9si7eCn
   rUthm6qDXfeRKG7cuZH3llM+nzmDySPXMWrreU7N2pFL1/9Psb9DJQQkD
   u1xKOpBA/6Hnw24Iu3qGJO7kNrmhX4g82EMyhXm65rIfRHRGkIOMDG4Ml
   S2g6lIDBqhIhXWRx5+vqTUEE3k9uY49Wy3ab6yO3v+8+gnaCPuQqjbrlT
   7WOVI+CzsdxzxmUYwJJsL32P78BdtaSm8g56a3NmonPoDfw3WNVBQ0uhS
   qDEYPsXqPzF2+snXS54H8TDsrP1c9lr46Ow6cK7/OPQje94ZtHk+VrW3n
   g==;
X-CSE-ConnectionGUID: Uuis3Xo8Qmar+vrolnDyuw==
X-CSE-MsgGUID: YAhOodQ+SEW2HtLuO2vi2w==
X-IronPort-AV: E=McAfee;i="6700,10204,11200"; a="25800035"
X-IronPort-AV: E=Sophos;i="6.10,244,1719903600"; 
   d="scan'208";a="25800035"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2024 07:45:20 -0700
X-CSE-ConnectionGUID: 30/Q/0PdTXqTOQ7osd+wLg==
X-CSE-MsgGUID: uBCIDCPUTmeIM6lKr+vOQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,244,1719903600"; 
   d="scan'208";a="74865292"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2024 07:45:18 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1sresl-0000000AwaK-212V;
	Fri, 20 Sep 2024 17:45:15 +0300
Date: Fri, 20 Sep 2024 17:45:15 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Parker Newman <parker@finest.io>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	Parker Newman <pnewman@connecttech.com>
Subject: Re: [PATCH v2 1/4] misc: eeprom: eeprom_93cx6: Add quirk for extra
 read clock cycle
Message-ID: <Zu2Ke5ttvrqXICDB@smile.fi.intel.com>
References: <cover.1726838531.git.pnewman@connecttech.com>
 <b92bd58e016a14ae95e259ffbdcfc5e5da6a7aca.1726838531.git.pnewman@connecttech.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b92bd58e016a14ae95e259ffbdcfc5e5da6a7aca.1726838531.git.pnewman@connecttech.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Sep 20, 2024 at 10:03:21AM -0400, Parker Newman wrote:
> From: Parker Newman <pnewman@connecttech.com>
> 
> This patch adds a quirk similar to eeprom_93xx46 to add an extra clock
> cycle before reading data from the EEPROM.
> 
> The 93Cx6 family of EEPROMs output a "dummy 0 bit" between the writing
> of the op-code/address from the host to the EEPROM and the reading of
> the actual data from the EEPROM.
> 
> More info can be found on page 6 of the AT93C46 datasheet (linked below).
> Similar notes are found in other 93xx6 datasheets.
> 
> In summary the read operation for a 93Cx6 EEPROM is:
> Write to EEPROM:	110[A5-A0]	(9 bits)
> Read from EEPROM:	0[D15-D0]	(17 bits)
> 
> Where:
> 	110 is the start bit and READ OpCode
> 	[A5-A0] is the address to read from
> 	0 is a "dummy bit" preceding the actual data
> 	[D15-D0] is the actual data.
> 
> Looking at the READ timing diagrams in the 93Cx6 datasheets the dummy
> bit should be clocked out on the last address bit clock cycle meaning it
> should be discarded naturally.
> 
> However, depending on the hardware configuration sometimes this dummy
> bit is not discarded. This is the case with Exar PCI UARTs which require
> an extra clock cycle between sending the address and reading the data.
> 
> Link: https://ww1.microchip.com/downloads/en/DeviceDoc/Atmel-5193-SEEPROM-AT93C46D-Datasheet.pdf

JFYI: You may also convert this to Datasheet: tag (we have a history of it
mostly in IIO subsystem), basically replacing word Link by Datasheet in the
above line.

> Signed-off-by: Parker Newman <pnewman@connecttech.com>

Code wise LGTM now,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

(Do not forget to embed this tag into a new version. With this the `b4` tool
 is quite helpful, so the workflow is to checkout a new branch in your local
 Git tree, like `git checkout -b exar-93xx46 v6.12-rc1` then taking a message
 ID from email of this thread — any should succeed, but cover letter's one
 for sure — run the following `b4 am $<message ID>`. It will print the hints
 what to do next, something like `git am $<patch_title>.mbx`. Then you can
 continue with `git rebase --interactive v6.12-rc1` if the code or other
 stuff in the commit message needs to be updated.)

-- 
With Best Regards,
Andy Shevchenko


