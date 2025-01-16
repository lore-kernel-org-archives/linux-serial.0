Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C1581D63EF;
	Thu, 16 Jan 2025 09:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737021188; cv=none; b=GPqYb1432krUtrsSlgPNJXYv405cJ0oRzwMOj/x0O9VgmLp/yxWn3rCvAjvFikilRt/tUblsyk8KO/t3f0oi9+vPeheST1Dz7bT8PerR2h+8s6ZvEBcOs4ZZPbiDCNZIiHjHLb+VkfrpDOs36qB/mDjYjgTRfo2N5Y2LcDM2PtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737021188; c=relaxed/simple;
	bh=fHUyZmn9mL1HyIhpk+D8LC4Re5LYvGt0wFtjeL6wdz4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gyeW5pQDI6PPyOz1LdYil4LvJYuOOibjKCVIQOaT2viC1IAZ3LdtcD35Yg0oun1lnI0xKHWuW2PeSlMDyFfFZu2Ey7qJfi1GbNdVqG6DkY46Ucu+2NBZyiHVkY5F45c/40iA/IrZrUoXZEh5RIsiUjuMjX7wfpY6CmCcP3cz48w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: CxmYLlDKT4Gq6Gg1SoiRuw==
X-CSE-MsgGUID: QqM94wvPQcWljHjllOlkiw==
X-IronPort-AV: E=McAfee;i="6700,10204,11316"; a="47985548"
X-IronPort-AV: E=Sophos;i="6.13,209,1732608000"; 
   d="scan'208";a="47985548"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2025 01:53:06 -0800
X-CSE-ConnectionGUID: 9023VpLSQSK3qvUP7LwlnA==
X-CSE-MsgGUID: uy1w48lVTMGbHjmIIFiv0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="142698679"
Received: from unknown (HELO smile.fi.intel.com) ([10.237.72.154])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2025 01:53:05 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andy@kernel.org>)
	id 1tYMYf-00000001ckY-1WXI;
	Thu, 16 Jan 2025 11:53:01 +0200
Date: Thu, 16 Jan 2025 11:53:01 +0200
From: Andy Shevchenko <andy@kernel.org>
To: Jiri Slaby <jirislaby@kernel.org>
Cc: Andre Werner <andre.werner@systec-electronic.com>,
	gregkh@linuxfoundation.org, hvilleneuve@dimonoff.com,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	lech.perczak@camlingroup.com
Subject: Re: [PATCH v1] serial: sc16is7xx: Extend IRQ check for negative valus
Message-ID: <Z4jW_TUQ8RNr1FWX@smile.fi.intel.com>
References: <Z4jLU75SU53VGsRU@smile.fi.intel.com>
 <20250116093203.460215-1-andre.werner@systec-electronic.com>
 <be1bc254-da95-47c2-b81c-e630c0f924b2@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <be1bc254-da95-47c2-b81c-e630c0f924b2@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Jan 16, 2025 at 10:42:14AM +0100, Jiri Slaby wrote:
> This is threaded weirdly.

Yeah, new patch (version) — new email thread.

> On 16. 01. 25, 10:32, Andre Werner wrote:
> > Fix the IRQ check to treat the negative values as No IRQ.
> 
> Care to describe on what HW that can happen?

But how does this relevant? The whole idea is that neither I²C nor SPI
frameworks do not guarantee the IRQ field never be negative. This is
the fix to the previously submitted patch.

...

> > -	s->polling = !!irq;
> > +	s->polling = (irq <= 0);


-- 
With Best Regards,
Andy Shevchenko


