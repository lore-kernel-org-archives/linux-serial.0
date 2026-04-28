Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE003CD8D3;
	Tue, 28 Apr 2026 07:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777361614; cv=none; b=MqPGHxrxJHuZo0iZo4lIrxwUqc5AswzyX8knBWQz8h4CzHGDbadJUJr0inl93E57ahcVlxbpsSG2ow2O6KIOF2BbdZqT/5yBo3p1PVA7iBT03UsmX4Hq+N74KQNSUD2bYNInIJQY2Ls+PJ/M9VPn3vy/ORqbsyNMnImi9eMGBck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777361614; c=relaxed/simple;
	bh=MK6PmkSEdvtScRmUKQM3w4fDnnpQBBwaPmKjSxuKsS4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B/Uf4OYdUmR171zmINaF30XLtJZsnQzV4BlHtxW98oPAcp+yD2GiPu79xm6YE6xCFqpvioqc06+fvaoe2ApFnANq/FTYkXfgLR93E+FrbvKcQrRln3wkMklPI9AgDmeYmMidRAm5Z+Kkw/ipeSZH74DFWrHRH7LA3+8cn3lTxto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OjqG8hMh; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OjqG8hMh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777361613; x=1808897613;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=MK6PmkSEdvtScRmUKQM3w4fDnnpQBBwaPmKjSxuKsS4=;
  b=OjqG8hMh1ilPwCIYkVzZY0GYp13i150DWaWRXv6WRhIj6+550GXn6KMA
   foD/vPoBa380WqsDhAOohME+IeCER+P3oa9HC2lG4/6Qa5qZZFQgSml7U
   f+x7PHhs8O/Mb+dBQlEd01zc7ucja66hcOgicCv9ShUOqGlerBYpRIwZ8
   tBmjgAaxg3+rsuXj33FzVqUKe82+uB+6VxlbdBe7OOyHZNdlYdbmFWUx/
   sK7dQF3kqFzAy9Cy37CP8wyz8nzLEe7NLa/Yfl6/ORoPh+ylyBJd26jmX
   iFG+gLep/W8S9cLmsWm5bPfcKp8YtX1MVp8U5LEzHQ6jnZdPT9sj2coXg
   Q==;
X-CSE-ConnectionGUID: G+KtVwf1S2aGAhC8KjkNpg==
X-CSE-MsgGUID: ztrU7haBSmSrhuxfoHht4w==
X-IronPort-AV: E=McAfee;i="6800,10657,11769"; a="78180232"
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; 
   d="scan'208";a="78180232"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2026 00:33:32 -0700
X-CSE-ConnectionGUID: il6yA7OZS3m9QcqjjpRplw==
X-CSE-MsgGUID: 2A1ZeTQdRzKlO3AF/jHWPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; 
   d="scan'208";a="264264159"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa002.jf.intel.com with ESMTP; 28 Apr 2026 00:33:31 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 8898595; Tue, 28 Apr 2026 09:33:29 +0200 (CEST)
Date: Tue, 28 Apr 2026 09:33:29 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: =?utf-8?B?67CV66qF7ZuI?= <mhun512@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, Ijae Kim <ae878000@gmail.com>
Subject: Re: [PATCH] serial: max3100: unwind port allocation on add failure
Message-ID: <afBiybvKnYZuNfQB@black.igk.intel.com>
References: <20260428070742.40072-1-pakmyeonghun@bagmyeonghun-ui-MacBookPro.local>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260428070742.40072-1-pakmyeonghun@bagmyeonghun-ui-MacBookPro.local>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Apr 28, 2026 at 04:07:27PM +0900, 박명훈 wrote:

> max3100_probe() reports errors from uart_add_one_port(), but then
> continues initialization and returns success. The device is left with
> per-port state in max3100s[] even though serial core did not add the
> port.
> 
> Return the uart_add_one_port() error instead. Free the per-port state
> and, when no other chips remain, unregister the UART driver that probe
> registered.

NAK.

Please, try to understand why we do like this and how important is to have at
least some of the ports available (yes, I understand that this is not a robust
solution, but it might help in the unlikely cases when some of the ports are
failed to get instantiated.

-- 
With Best Regards,
Andy Shevchenko


