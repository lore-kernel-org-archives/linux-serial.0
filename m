Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61377230BC0;
	Fri,  2 May 2025 09:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746178735; cv=none; b=ba6w18iChT8RF3VkznhV0YXaj45yKF+MmURBEXPotLEk+JrOieegKU2nxmFFPfkKBTkT/sspMUk0e1wK+lMKCSbMo5k5QR6/1yn1j7xLWi3z+UiEHVt6aHnBNncryJ5Mk/fU6+8tlknbmVnbLKmNJkMddQs7AF7Or9xdPXrlXlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746178735; c=relaxed/simple;
	bh=rwimjCFZIEK6IiRjQcWFRhle+PT2+gsG7qIuqDDE9jw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qqyA6EZK2prk7wAqRiysqshPCY1hKlRV48hBOxQIQJNd/bU7u+tKymXBASn6bvYfrFFAMcKPzfzLXGL/e9boBeBjMSYa5YLd9Xe22wXlSEAKN1Uh7TazTIzz5vtkdN7TfvFx1Sck1qjZ1xxsdKRBDaX8STgnZ1erCJiNhiIhhVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iYYwamRs; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iYYwamRs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746178733; x=1777714733;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rwimjCFZIEK6IiRjQcWFRhle+PT2+gsG7qIuqDDE9jw=;
  b=iYYwamRsxJ/WsxuvkPDYn7CLqIxXiuUhLKqiOlPTYiMSvBQTI3oN3FhP
   /ThzzPrHaLFyzuJgQtp+eajkDS7pItN5+Z2EFLScVd19t8bstbBmeryKB
   jzsgpdMwTItPsfZ1GeDrq5GybwYfXUYaq55meTR/rkJQDbjRHYuBJCUt9
   d2FcqP0Qm+i7O8AWiCIr7c9C1ZlIVp3sOda34hA2Dw2DG1XaidOxIZY4n
   1ZaMECQZWOyXUdhugTq90vH7KtIWwHA2dgedEg2sCl10cNi9Gu+ZmliOc
   Tan9nGkF++VVOKAVjXIDSBDhHj+ooaLID7eYyRaD24zVdBzNQuzT/+aVF
   w==;
X-CSE-ConnectionGUID: 0bpqy63XQvW39jx76bRXTw==
X-CSE-MsgGUID: 148UoPQBSNWRflpfWof/wg==
X-IronPort-AV: E=McAfee;i="6700,10204,11420"; a="58526498"
X-IronPort-AV: E=Sophos;i="6.15,256,1739865600"; 
   d="scan'208";a="58526498"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2025 02:38:52 -0700
X-CSE-ConnectionGUID: MU4AK4eWSt6Dx0w45zqaAg==
X-CSE-MsgGUID: aOZwKdC/T7mkYX/GcryvGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,256,1739865600"; 
   d="scan'208";a="134515801"
Received: from smile.fi.intel.com ([10.237.72.55])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2025 02:38:50 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1uAmr0-000000029HQ-3XlH;
	Fri, 02 May 2025 12:38:46 +0300
Date: Fri, 2 May 2025 12:38:46 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Judith Mendez <jm@ti.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, Hari Nagalla <hnagalla@ti.com>
Subject: Re: [PATCH RFC 0/2] Introduce PRU UART driver
Message-ID: <aBSSpsT_7UsqN6bl@smile.fi.intel.com>
References: <20250501003113.1609342-1-jm@ti.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250501003113.1609342-1-jm@ti.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Apr 30, 2025 at 07:31:11PM -0500, Judith Mendez wrote:
> This patch series is sent as an RFC to get some initial comments
> on the PRU UART driver.
> 
> The ICSSM modules on am64x SoC and the PRUSS module on am62 SoC or am335x
> SoCs have a UART sub-module. This patch series introduces the driver and the
> corresponding binding documentation for this sub-module.
> 
> The DTS patches for adding PRU nodes and enabling PRU UART will be added
> in a later v1 version of the series if accepted.
> 
> This driver has been previously tested on the following boards:
> am64x SK, am62x SK, and am335x SK boards.

The first and main question here: Have you checked the existing zillion of
drivers and become with an idea that none of them not even close to this one
(based on RTL)?

-- 
With Best Regards,
Andy Shevchenko


