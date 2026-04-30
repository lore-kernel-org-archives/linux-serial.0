Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D1E02E11C7;
	Thu, 30 Apr 2026 15:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777561710; cv=none; b=NvTwgAmedBO0ouvlvlFwl3sr5cWLh53V2q6trC40Xw0hvLLNyjdJdgUmsd0XgaVdc7jKMQGaveETlXsytfWzuL+AZIky5pCAVT/O1ZnU71PpJzubZKvxRe8KX9TXP7zKhAMo2de9ZM4rpFDjbjleDdjdkp3L7mynl5ii8PGceJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777561710; c=relaxed/simple;
	bh=M4uDJz3SzY/dIlVFbEa3YhSnY2NqCwPk2QWsFAc+IQc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W7HB6uTPA1l0KG1oaW80lZ2h7G36rUwVB/nDGHtYiqiVRymfRpADOXZ6ob+9QAqdjTh3j20PAJJzbpilMRGHxj8IwHSG8OxX/C2/5QUrLBAKUSEXo+hFWGEs/nEpveWfyzXe1YXnLLr7Tv1sjhPvbutO9ibwa3Vl6nB0x7yK0ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DM3fD1h2; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DM3fD1h2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777561710; x=1809097710;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=M4uDJz3SzY/dIlVFbEa3YhSnY2NqCwPk2QWsFAc+IQc=;
  b=DM3fD1h22vPPpTglPQDezYYDYwDQLAFvqPoerR1On5owLrTT0NmjYk/Q
   z5MwzxzfZXpfutzh2sOXFuFKU/bHqKZZoJYnEeq70AxNVRogK+P6L7y90
   lWjsmmEfNJ1sPWwTL/hvauMqM3MnQYUP6PeO2oM43pyFmmSA1Y3UqTePA
   1y+rhHNi/GNqpKR8hC17HnMeuZzUVNH0cqiCfiSgkB2shLXCYbwcw2tat
   EDIDSHHFtolsZveT8AXCDzeeWvKKWKWfVjOOrTguywSqiAO4fqWwtupWg
   3u4jECKhBj/VYHlrxPEtzxfTkoKTre9GBtJ9EIL78BxHMwdVRoCtjSK9/
   A==;
X-CSE-ConnectionGUID: HXnJXgJzQKGIAn/w58QEQw==
X-CSE-MsgGUID: TsXZN4QpQ2qsP1gIQsmzgQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11772"; a="89205908"
X-IronPort-AV: E=Sophos;i="6.23,208,1770624000"; 
   d="scan'208";a="89205908"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2026 08:08:29 -0700
X-CSE-ConnectionGUID: 5dF3+qqVTOSL8jLtRZfEFA==
X-CSE-MsgGUID: ikS8hpJqSJmPNkMfHWrP6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,208,1770624000"; 
   d="scan'208";a="239611354"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa005.jf.intel.com with ESMTP; 30 Apr 2026 08:08:27 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id EA84695; Thu, 30 Apr 2026 17:08:25 +0200 (CEST)
Date: Thu, 30 Apr 2026 17:08:25 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Hugo Villeneuve <hugo@hugovil.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, ilpo.jarvinen@linux.intel.com,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>
Subject: Re: [PATCH v2 02/15] serial: core: add uart_iotype_mmio/legacy_io
 helper functions
Message-ID: <afNwaUf8esqaqxUe@black.igk.intel.com>
References: <20260428-tty-upio-v2-0-01c1857cf761@dimonoff.com>
 <20260428-tty-upio-v2-2-01c1857cf761@dimonoff.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260428-tty-upio-v2-2-01c1857cf761@dimonoff.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Apr 28, 2026 at 01:53:48PM -0400, Hugo Villeneuve wrote:

> To help simplify code that check on the io type mode of the port.

...

> +bool uart_iotype_legacy_io(enum uart_iotype iotype)

Why do we use 'legacy'? Still in use in modern CPUs...

-- 
With Best Regards,
Andy Shevchenko


