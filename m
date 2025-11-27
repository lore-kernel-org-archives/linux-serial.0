Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 731DC2D12E2
	for <linux-serial@vger.kernel.org>; Thu, 27 Nov 2025 16:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764259545; cv=none; b=qsL+J5ISckaj7akyvRA0GxeF7YT727H8ch/YVXMVrKQ6ToeXDk5ETn6B/BDp/Hh1pF2McGiFHsBkx41Y1lZhPxN70WNkoZVsV+OGb8f5RdWZxBACy48u9ucKWnoklxzu+LjyDZ3ewbB9FJdWuxrnVLi4R8R6xkKdR6I6MhZLrsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764259545; c=relaxed/simple;
	bh=5twPnhjCrdHGInyzmZYiBigTPtrqJffYLDrpevO5RDo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tyj2aIcuFZ/xfRR/9DC9UmzB864DQ7j5TwdIolmoy79Tl+DPvWmTUg17s9ZjzwyPkIW1/thR0LTgizSKtKFnyPJ9sPBw8ENSX90DM/xlAPw6KERcMhRF+1Mzro0g4rq+p/yTMlwyKHKVERGH1b7MvLJe4012IbT5JiNG+00j4HM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UGstQ4xF; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UGstQ4xF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764259543; x=1795795543;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5twPnhjCrdHGInyzmZYiBigTPtrqJffYLDrpevO5RDo=;
  b=UGstQ4xFTYeP7h4s6UfYYsbGZcAalZa3jLfocXRIe/edoJ8/LpPrtn36
   VmcsK75gh/ElNXIwYXql2ZfQ0WTSgXEMdIiu7RzSzPlWyA7QoOhdq4uD1
   vJSnOodZ6nbUSaVgInAIN2t/AFnis7d+mHHzI3kNPYMF+Pqkmsg/VSUmZ
   wO7OengNPGc4/qGhU5+X7vhCiIVfk6Dg/q57qT/okpK1AxMDOVsbVDrkM
   q4IhKbNIhG7R8J3z73Z9fopGPZ4jNsc+rpbGhUW8WZgELRg6kgkRMZDa7
   ncaHQ+qYojA8EsCvMGV0GpbYWfUg7BaYWWQBgiO4PZLZULUacfrnP20HI
   Q==;
X-CSE-ConnectionGUID: yCXLv8HuReeymAoMAgSqhA==
X-CSE-MsgGUID: KerZOx75R7y/pWk9bwybTw==
X-IronPort-AV: E=McAfee;i="6800,10657,11625"; a="65492758"
X-IronPort-AV: E=Sophos;i="6.20,231,1758610800"; 
   d="scan'208";a="65492758"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2025 08:05:42 -0800
X-CSE-ConnectionGUID: mXc+i/zdR8mSgEINFvjSFw==
X-CSE-MsgGUID: szCDs2+CQ2CV1VKOEnhUnw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,231,1758610800"; 
   d="scan'208";a="192389822"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa006.jf.intel.com with ESMTP; 27 Nov 2025 08:05:41 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 67BC6A0; Thu, 27 Nov 2025 17:05:40 +0100 (CET)
Date: Thu, 27 Nov 2025 17:05:40 +0100
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Gerhard Engleder <gerhard@engleder-embedded.com>
Cc: linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
	jirislaby@kernel.org
Subject: Re: [PATCH v2 0/2] serial: add KEBA UART driver
Message-ID: <aSh21GDLStR3uhnX@black.igk.intel.com>
References: <20251017144209.2662-1-gerhard@engleder-embedded.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251017144209.2662-1-gerhard@engleder-embedded.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Oct 17, 2025 at 04:42:07PM +0200, Gerhard Engleder wrote:
> First the serial subsystem is prepared to keep rs485 settings from the
> driver if no firmware node exists. This enables drivers to configure a
> default rs485 mode, which is set by the serial subsystem.
> 
> Second the driver for the KEBA UART is added. This driver supports
> multiple rs485 modes and selects RS485 as default mode. This UART is
> found in KEBA PLC devices. The auxiliary devices for this driver are
> created by the cp500 driver.

I just realised (thanks, Lukas!) that this is for some kind of FPGA which makes
even bigger question here.

First of all, we have the FPGA framework, which handles (re-)configurations of
FPGAs. Second, why do you need a new driver when we have already one, i.e.
8250_dfl that follows some kind of standards?

Third, the expect approach is to see DT overlay provided along with the FPGA
configuration. So, basically your cp500.c should not have been existed to begin
with.

Can you elaborate on these considerations?

-- 
With Best Regards,
Andy Shevchenko


