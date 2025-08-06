Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AD052D3EEB;
	Wed,  6 Aug 2025 20:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754512775; cv=none; b=n/8swqOrqJvZuC5NsKguQk6kDgo+/UP9GmveZRKYEiafNi6Ti6aaEXaVXiLbdzCz77uGpRX+UzEhcyOR7B+CVvA5zzpeaPnLMKTSPtpYrLaqp28CPq4MCJRUWZOHxRW7f16U+VcSVdt4NHl1wjTaFYhzSHEFufnp0Amp0v3PS30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754512775; c=relaxed/simple;
	bh=U/I9I/AY/SKv28Op9UFpRMmc8CRJsxKxCW7fPeER7yA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LFR40+FWy1wA3Cck+JSYz37lgZdmlKhKP8gNv4+PzrbmPYQCfBWbj+6PwqxjkNW12GzaPMmGs/UBafvCTa3psMGtTChX18czRdNVFV/tMElVwZG5JFLNwFrpEwJzCVr53kl0WcvJgZ5EAYzih2CY/ty9iTXABI4z/7Ay6mQKyMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bkWofbiE; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bkWofbiE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754512773; x=1786048773;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=U/I9I/AY/SKv28Op9UFpRMmc8CRJsxKxCW7fPeER7yA=;
  b=bkWofbiErScl5wTJqDl2dU4jAgLKSb6EcWGHmIek6rKwcLe8sCuopgLU
   6rs50bB3U46ZeYnhtkguTgF2wx7ZZTtbcddyLRYtnHc+YrQ03KytriaX/
   y7EIT2/guc8+vGhKDhr3TVCPHXDsr/XcZXd1GPLfBPBpzgSwQqo7AIQ3n
   ZZKy8n/iFYnT5RsphRy8QEnoqxrBnQ7/cpVJzzGRrKgd7bNJCgY1nxhQA
   +DLkm8oRgUp7PLow1TC4wdT+ZWgSg7ztsHla7iR57GjbiPKe0XKLlwIfo
   gZ+GViKz7gCa0lcpiCyM8gMk5klRYtqCfGdLjtbBFO6+bzYWiutngOlfj
   A==;
X-CSE-ConnectionGUID: jWxGoumoT56i0Br2qNkQTQ==
X-CSE-MsgGUID: Bs+Br7r+QeORQmCWWD3zgA==
X-IronPort-AV: E=McAfee;i="6800,10657,11514"; a="59457578"
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; 
   d="scan'208";a="59457578"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2025 13:39:32 -0700
X-CSE-ConnectionGUID: DuEzPzBYR3mRVYIBjWdXyQ==
X-CSE-MsgGUID: aCCzP4NERHKajpHwq5qVKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; 
   d="scan'208";a="164069469"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2025 13:39:30 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1ujkv0-000000046su-3JUb;
	Wed, 06 Aug 2025 23:39:26 +0300
Date: Wed, 6 Aug 2025 23:39:26 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Abinash Singh <abinashsinghlalotra@gmail.com>
Cc: arnd@arndb.de, gregkh@linuxfoundation.org, jirislaby@kernel.org,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	sunilvl@ventanamicro.com, u.kleine-koenig@baylibre.com
Subject: Re: [PATCH v2 0/2] serial: 8250_platform: Reduce stack usage in
 probe functions
Message-ID: <aJO9fnbydWqu1RpJ@smile.fi.intel.com>
References: <aJKDp1LBpzswp5lX@smile.fi.intel.com>
 <20250806201047.754240-1-abinashsinghlalotra@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250806201047.754240-1-abinashsinghlalotra@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Aug 07, 2025 at 01:40:45AM +0530, Abinash Singh wrote:
> Hello,
> 
> I’m very happy and grateful to receive such valuable feedback and
> support from you all.I’ve carefully reviewed the comments and
> have applied the suggested changes in this v2 series.
> Please let me know if there is anything else I can
> improve or correct further. I truly appreciate your
> time and guidance.

Have you had a chance to see Arnd's comments?

-- 
With Best Regards,
Andy Shevchenko


