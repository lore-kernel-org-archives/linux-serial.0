Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5320232785
	for <linux-serial@vger.kernel.org>; Wed, 26 Nov 2025 13:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764162622; cv=none; b=cLZ+fLvHLNW4PUitqiDruQOq4E90hMq3z4RQ+7Gn2lK0U+BBKkgsmq0OypmooEuUYBNswB6acgerQSTG62ykJwDqD+k4IPyZrtBI2XXAu/41k9u1yBtLNAGno3Iq4ba5W+7J+TtAK/f6DelyxAm5969lsrNUWcuMZi3DKcMrRfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764162622; c=relaxed/simple;
	bh=L875NzwoLLjB42h8lY2SInlUesYbxAOBuWwi513+utg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ngRHSaxJ1lJoKsppVpnXlfFMuA3B1IngBAVLgR5v93KGwurUWQeRaknh8pC5vDt2ftuJw5ap3J+kjfs40vWeCGaiXVSO+BkRfNMsFNeNOcsHYW2thcuRB4xauH4D4GwLci8eq6FnIe6OlVqtyDQeFipECVc56NG37zeGRNXSsY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k7IaZo8o; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k7IaZo8o"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764162620; x=1795698620;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=L875NzwoLLjB42h8lY2SInlUesYbxAOBuWwi513+utg=;
  b=k7IaZo8os061fw+EbSBbIHNQgdilNtZ+jocguL1kczWJ4TweR62ZfbH4
   UXF+YIiCWU6S6h0tZ7rsWi3xZ2JNIjYnEIdYBU4W6N3q5Mezo6hwEyC0K
   OD135VRpm4XudI3P+dOIIxYa1DDtPR3pL3wYKX2lkNtD9vrv5hI5FCPLJ
   OJcTEBIai2DbuMP/A8NE9BLe87M6hBaaw9GhiklC9uwSlfM4uXY/4HWmB
   Z8rNNFytRq/2SJEbtjjzbjaApmx/ieMGyvUt1DFE65RibkM6bDmY7iG9D
   X8TyxH4WryC8+tvdFjHX+4K449FUf7AMYxGeeCNjKQAlDzFTbkmM5jlKp
   g==;
X-CSE-ConnectionGUID: cpNk7WmyQxyGuwmggbnFLw==
X-CSE-MsgGUID: qQRK8NSBQyGQGpZf3Z5Axw==
X-IronPort-AV: E=McAfee;i="6800,10657,11624"; a="77563822"
X-IronPort-AV: E=Sophos;i="6.20,228,1758610800"; 
   d="scan'208";a="77563822"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2025 05:10:20 -0800
X-CSE-ConnectionGUID: vZ5tEFUnR1SLAvIvSn2ihQ==
X-CSE-MsgGUID: E6qderM1TcW9Wz7DRdwM1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,228,1758610800"; 
   d="scan'208";a="192725255"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa009.jf.intel.com with ESMTP; 26 Nov 2025 05:10:19 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 6BBC6A0; Wed, 26 Nov 2025 14:10:17 +0100 (CET)
Date: Wed, 26 Nov 2025 14:10:17 +0100
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Gerhard Engleder <gerhard@engleder-embedded.com>
Cc: linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
	jirislaby@kernel.org, lukas@wunner.de,
	Gerhard Engleder <eg@keba.com>
Subject: Re: [PATCH v4 1/2] serial: Keep rs485 settings for devices without
 firmware node
Message-ID: <aSb8OTRLUsgcXUjO@black.igk.intel.com>
References: <20251023151229.11774-1-gerhard@engleder-embedded.com>
 <20251023151229.11774-2-gerhard@engleder-embedded.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251023151229.11774-2-gerhard@engleder-embedded.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Oct 23, 2025 at 05:12:28PM +0200, Gerhard Engleder wrote:
> 
> Commit fe7f0fa43cef ("serial: 8250: Support rs485 devicetree properties")
> retrieves rs485 properties for 8250 drivers. These properties are read
> from the firmware node of the device within uart_get_rs485_mode(). If the
> firmware node does not exist, then the rs485 flags are still reset. Thus,
> 8250 driver cannot set rs485 flags to enable a defined rs485 mode during
> driver loading. This is no problem so far, as no 8250 driver sets the
> rs485 flags.
> 
> The default rs485 mode can also be set by firmware nodes. But for some
> devices a firmware node does not exist. E.g., for a PCIe based serial
> interface on x86 no device tree is available and the ACPI information of
> the BIOS often cannot by modified.

While the code is okay per se, the above statement is not fully true.
We specifically have device properties and software nodes to provide
the missing bits.

> In this case it shall be possible,
> that a driver works out of the box by setting a reasonable default rs485
> mode.
> 
> If no firmware node exists, then it should be possible for the driver to
> set a reasonable default rs485 mode. Therefore, reset rs485 flags only
> if a firmware node exists.

-- 
With Best Regards,
Andy Shevchenko


