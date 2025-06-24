Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD7CC2D29C6;
	Tue, 24 Jun 2025 14:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750774254; cv=none; b=i7AX/gyQhCqmeiWBE9oDZBvnrNzuycEO37Gh9nU4AwDxn4GsG5XuIrEs1D4hv+4BRt54ZBiCq1uzExA9dulqD0uqJdJjgrpbRrwDPy0PZHj8Lc3aXG02R8bQvvV6cgtzhsD3HGq5Lw8x8P2ZKsLjtF+LSIMLI+FnrHiFwmzRObY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750774254; c=relaxed/simple;
	bh=kvg8ZSzdzy4ZAlY9Jtb16Hr3q2fqGRxZSErdE4DnJDM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kc26FHAy9spnvCKKNds/iOUXlwLNiCT8kwCZAlTxyAs8eCFYaDB8fYhfJ1KUAaHXdw8twP5cs4s/jOJMWp5+S2HgSTW+T3v4QZOHpaPpI0ao4iNFekKTSA7faF6EI1X2t/zW5aRvrmyzhO7L83zYjB+NoBKc9Vxqz19a5RWhNdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ja9Gum9F; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ja9Gum9F"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750774253; x=1782310253;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kvg8ZSzdzy4ZAlY9Jtb16Hr3q2fqGRxZSErdE4DnJDM=;
  b=ja9Gum9FKoWkMPoHm9y2/ef4vga65Hn8cwxuE985mM4+QE00sXL1JuUl
   4oQE3WonDrQrwy2P7ItBYwFVqvlQTqyXpPgDxAFy4OtROCv6N+n61v9F2
   xTqUlkh6xa254DWOqcnUbokUu89x8ZfaIbaD13meYdwo4w4q5O+X3cAkv
   d77Ma/vUVH27YTao+1880HyCDua3hX461bdWKTfECtsVNIZVAA6jD9s3c
   wfcWjx26osXi7scWD17Xr/JLjdaFmREHpdHQmRWBeQlYtAErMPHolOcoS
   9CIaYkcSaMtZ74AzzVtrILbKcEvRwBRA2LxcHNKhJJC9E7PwaLbhLA7Wb
   A==;
X-CSE-ConnectionGUID: 3EQRr+AIRv2rqc6iE/VNtw==
X-CSE-MsgGUID: LIA/vs3KTAOpXo0rqgILXw==
X-IronPort-AV: E=McAfee;i="6800,10657,11474"; a="53154293"
X-IronPort-AV: E=Sophos;i="6.16,261,1744095600"; 
   d="scan'208";a="53154293"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2025 07:10:51 -0700
X-CSE-ConnectionGUID: IX+YlaPYQA6IyLNbz83O3A==
X-CSE-MsgGUID: um49lFH4Q/qdsP6gI3UVUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,261,1744095600"; 
   d="scan'208";a="156215262"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa005.fm.intel.com with ESMTP; 24 Jun 2025 07:10:50 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id DD578224; Tue, 24 Jun 2025 17:10:48 +0300 (EEST)
Date: Tue, 24 Jun 2025 17:10:48 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Cc: gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: Re: [PATCH v2 1/5] serial: 8250: extract serial8250_init_mctrl()
Message-ID: <aFqx6E4s5RvNampF@black.fi.intel.com>
References: <20250624080641.509959-1-jirislaby@kernel.org>
 <20250624080641.509959-2-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250624080641.509959-2-jirislaby@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Jun 24, 2025 at 10:06:37AM +0200, Jiri Slaby (SUSE) wrote:
> After commit 795158691cc0 ("serial: 8250: extract
> serial8250_initialize()"), split serial8250_initialize() even more --
> the mctrl part of this code can be separated into
> serial8250_init_mctrl() -- done now.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko


