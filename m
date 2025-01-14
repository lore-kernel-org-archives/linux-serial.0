Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 654F08615A;
	Tue, 14 Jan 2025 14:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736866605; cv=none; b=hrNj1YPNEtXA+15/Wbnev1F2bfOUXqubbQQ0Am+MIa7N+C7z724ZF4pVN2Un12BpAJZE+U90YZl9tSoqvUUM/2oUckACt+cqD45L3QFJpVeJtBqTOQSgoDxj791fioYM/n0DSaMK/UfLlbGaCOTLY+m+zS4IjuFqyy/DJ79X6Mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736866605; c=relaxed/simple;
	bh=lZqPtOu21pGFo3DKRIX7IeK9UAXmqyYL8+QzSi5WSVo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rolxMSdszjD311Brfudhfw2tWqpZoiaK6LlkpnNihzaB/yUiEoKJfGoKZi9x1857HQGMg2vxsXjxYycmgiqhvdiFmJ2pEIn1QLXaf/umOJ52VjRl8gOwkcjjMgMlD30QsQ16O99kvZWe0x7W6XQ/Z0mLTVPm89cxUXB//2Q0uu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: aHxFE2tTT7m3vQ3ZBvO8GA==
X-CSE-MsgGUID: w1epo5k8T62muGIkRfEz1A==
X-IronPort-AV: E=McAfee;i="6700,10204,11315"; a="41103959"
X-IronPort-AV: E=Sophos;i="6.12,314,1728975600"; 
   d="scan'208";a="41103959"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2025 06:56:44 -0800
X-CSE-ConnectionGUID: IakiGuqrQ1uqqnpNeuX9Ug==
X-CSE-MsgGUID: nUR/Tlk2QwqrWmhiIcarQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="142108199"
Received: from unknown (HELO smile.fi.intel.com) ([10.237.72.154])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2025 06:56:41 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andy@kernel.org>)
	id 1tXiLO-00000000sTe-09vi;
	Tue, 14 Jan 2025 16:56:38 +0200
Date: Tue, 14 Jan 2025 16:56:37 +0200
From: Andy Shevchenko <andy@kernel.org>
To: Andre Werner <andre.werner@systec-electronic.com>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org,
	hvilleneuve@dimonoff.com, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	lech.perczak@camlingroup.com, krzk+dt@kernel.org,
	conor+dt@kernel.org, robh@kernel.org
Subject: Re: [PATCH v7 2/2] serial: sc16is7xx: Add polling mode if no IRQ pin
 is available
Message-ID: <Z4Z7JUP2vMEX9JsW@smile.fi.intel.com>
References: <20250114070449.34226-1-andre.werner@systec-electronic.com>
 <20250114070449.34226-2-andre.werner@systec-electronic.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250114070449.34226-2-andre.werner@systec-electronic.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Jan 14, 2025 at 08:04:49AM +0100, Andre Werner wrote:
> Fall back to polling mode if no interrupt is configured because there
> is no possibility to connect the interrupt pin.
> 
> If no interrupt pin is available the driver uses a delayed worker to
> poll the state of interrupt status registers (IIR).

...

> V6:
> - Use polling mode for IRQ numbers <= 0 which encounter no valid IRQ
>   were found/defined.
> V7:
> - Try to improve and unify comments as requested.
> - Fix typo in commit message: pull -> poll

Please, rebase your series on top of the recent Linux Next.

-- 
With Best Regards,
Andy Shevchenko


