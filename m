Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BC9F3D411A;
	Tue, 28 Apr 2026 08:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777364359; cv=none; b=fCuVRcd1yJFpm2RHEiGv9b6wmPXvJexshuULOeMoe4XYJNNcHg/LwpzV4liYY747mFhnq79cDT0WM2SZqCXiT0gtUoBWYl9MhjoUQWHiNJwvWeyjKSz23gKJIINLYoKH4GFJioAxHgi0ZRmJKTL1s4N09XPraUjTZBEsSZyVPiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777364359; c=relaxed/simple;
	bh=LPlcOO4oTr6lzEKDfTYi1Sv2tWWa1TpBzwz0HZv8geQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NoehGia3DC5IyyIcckfSn2tH38sSSQFw+g2w3td0eWqyGv8NMfCV7YvxNokrQzRoE+dOcv/jMqZfrQe5srZ2aA3ZsxlplbxT8qetLBpMvzjB4CqjPthZKm56vANoTKHRARHGtL03sKGcG58AU/Urn7a7Wk7cEMibv0QWDY65KOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aS82/cLG; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aS82/cLG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777364358; x=1808900358;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LPlcOO4oTr6lzEKDfTYi1Sv2tWWa1TpBzwz0HZv8geQ=;
  b=aS82/cLG+n5ntQ/JrtG7kgt38+jzUx/VmnRuYspdpoJ+Ph3ggFXaGFOt
   DclLxbklz7qUfA+2k7/XVGT3sdnAxypDKQn3Zgny9uU5UNUSXI5La63sy
   lBn0o1n6z4O28FoOh7lcXn9OfvCotDuvTEABSRoGPd7oZdYVm1iZFRmYz
   yZXDeGPQHNkkVrkeL66il+GJchNNbiII1t+j9X/Aa0KIjRvAkxxlpbI5G
   IaIx33CdJ98gNe4fU3gxsP5cv19XGIW0jX396WCSeYAkEAdEnx/eCYWqH
   8EZvL3plA82yBnboV7yVOMC/giZu5bSjklDLQNc1hj8HplQl9E15nlf2U
   g==;
X-CSE-ConnectionGUID: makpklzUSS2QrJYA6jow8Q==
X-CSE-MsgGUID: wkP8jJQWToisOnVUNsuegw==
X-IronPort-AV: E=McAfee;i="6800,10657,11769"; a="65795857"
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; 
   d="scan'208";a="65795857"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2026 01:19:17 -0700
X-CSE-ConnectionGUID: IatilBlqQmimrRvkgbIzXQ==
X-CSE-MsgGUID: DjGukAhZRVSuOyhPJS1zNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; 
   d="scan'208";a="233759413"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.213])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2026 01:19:14 -0700
Date: Tue, 28 Apr 2026 11:19:11 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jia Wang <wangjia@ultrarisc.com>
Cc: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v5 4/4] serial: 8250_dw: Use a fixed CPR value for
 UltraRISC DP1000 UART
Message-ID: <afBtf0gx8r2Z9a2E@ashevche-desk.local>
References: <20260428-ultrarisc-serial-v5-0-97de63b1e3eb@ultrarisc.com>
 <20260428-ultrarisc-serial-v5-4-97de63b1e3eb@ultrarisc.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260428-ultrarisc-serial-v5-4-97de63b1e3eb@ultrarisc.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Apr 28, 2026 at 01:26:29PM +0800, Jia Wang wrote:
> The UltraRISC DP1000 UART does not provide the standard CPR register used
> by 8250_dw to discover port capabilities.
> 
> Provide a fixed CPR value for the DP1000-specific compatible so the
> driver can configure the port correctly.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko


