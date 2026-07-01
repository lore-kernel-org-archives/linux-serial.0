Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C557481A91;
	Wed,  1 Jul 2026 12:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782909739; cv=none; b=UdWoDM9qDdSNxpklbIEkqDZ/87KVzErbFNTPGmRpGb+HrTpXkp2NaNvrowdcVYzfqOZUZcQqVBOChIPQnQ/tSWlRyo1Cv1Pb2tHk6wHbX6u/JB0Ld9hprUYjeutLJRzi0tCy9oszbSTicysy49R+EH493s0FWLAjoII6E0Llf9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782909739; c=relaxed/simple;
	bh=DQH/SKJd5ANobM8keViDHsKklrmodf0XNYj10Vj2JBw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=plIUcYjxL3HCaLeIGEBWdsxe6a0kXfVWQnesDoCOBSaejRJnu95qDLZ/WWQmJH9gXPbjR5SjNi3+8rcJ5fuOkek9KCE8vtImYuj3RFKNn+cTuEWIhagJcBQOjQ82AcFnkd5fnF7XB2/mcrGPw00w6iOdIG+9kzX5XQy4Rq2YKCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d1HgIVYc; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d1HgIVYc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782909738; x=1814445738;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DQH/SKJd5ANobM8keViDHsKklrmodf0XNYj10Vj2JBw=;
  b=d1HgIVYc6fl2Lgtr9JtJ2Z4tNQWjRo5+LDGwjrWrJ71bpNiwjHDlyaPn
   OSrgIvMrZkkxTXZhL6+t7UrRIz63m/0DF83RivrGu6k0WCKYM4usNXnnV
   ZfHPx14ClsgJaFu2spj3eklEWaoHbdwWY/X5QAluqytFY18iElD5tEGCA
   Lk77y548hSRqjayy4pdFdR9/nGePzgKfwXPpvnq3S4TCKqiBEfFktEaBJ
   qxPbseh6EN5hjWKgjCjR1CL99CHlcdZb5ss67ch1SF4Wq4sf4Z8KHwmdw
   jrnCqctohr0P2zD1h6NyN35P+tsdu+/hrLx0P3X5O4DE7/1lX5TRBtcQE
   A==;
X-CSE-ConnectionGUID: WWNeIPN9Sr631Bl7nGOj9A==
X-CSE-MsgGUID: 1PbN1qM3SyWmbXKr3yyL9Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11833"; a="83633731"
X-IronPort-AV: E=Sophos;i="6.25,141,1779174000"; 
   d="scan'208";a="83633731"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2026 05:42:18 -0700
X-CSE-ConnectionGUID: JG1pKWXjQpitSvQbJCjGhQ==
X-CSE-MsgGUID: Z6WMxabqQXWeggaITtHUFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,141,1779174000"; 
   d="scan'208";a="250837569"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.65])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2026 05:42:16 -0700
Date: Wed, 1 Jul 2026 15:42:13 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Crescent Hsieh <crescentcy.hsieh@moxa.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, FangpingFP.Cheng@moxa.com,
	Epson.Chiang@moxa.com, Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v2 01/15] serial: 8250: split Moxa PCIe serial board
 support out of 8250_pci
Message-ID: <akULJR2QmPs_lx-t@ashevche-desk.local>
References: <20260701034128.218569-1-crescentcy.hsieh@moxa.com>
 <20260701034128.218569-2-crescentcy.hsieh@moxa.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260701034128.218569-2-crescentcy.hsieh@moxa.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jul 01, 2026 at 11:41:14AM +0800, Crescent Hsieh wrote:
> The Moxa PCIe multiport serial boards are currently handled as part of
> 8250_pci.c. In preparation for adding Moxa-specific UART features and
> optimizations, move the Moxa PCIe implementation into a dedicated
> driver.
> 
> This introduces drivers/tty/serial/8250/8250_mxpcie.c and wires it up
> via Kconfig and Makefile, while preserving the existing probe flow and
> device IDs.
> 
> This change was suggested during earlier reviews by Andy Shevchenko [1][2].
> 
> No functional change intended.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

-- 
With Best Regards,
Andy Shevchenko


