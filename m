Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32D8F3DA7C0;
	Tue, 28 Apr 2026 09:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777370222; cv=none; b=ZJKH+hcLiQb0t3yLkfUT0rpJWoJZrm2MJGNF5S3F9WzEVqa0IH1vwhY1quYB6aapvgE2qET2WCKGGRtmbBNRhAlPyTtNn5bOOw0rWmzQe3ScYCEzVR8/zh+hOQFM51+sOtBqjs55SvCIiFAeD6Q+3Hdrh9Fzw6uuU2fvBgPxgbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777370222; c=relaxed/simple;
	bh=Ha+uGxaP82d+IWAl6Mt2Hx6NTPV5qymXpcVcAZonoFQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kkGIADf9sPNA4Nb3m70amUS8X7C8n+KZ5GDD1U+tsHv2m5y48jqxt7kpEJTgfMNFx7uNWBf0opHiKheJHXjyGOUe5zrekpas01VvQyYSKtYhIevc2+7tzzHK/dC9YNFg5Ye5roUEs7ORlNkhLwUBMj30kURpJBIBYZMkHOnpMJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gOzY7NY1; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gOzY7NY1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777370220; x=1808906220;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=Ha+uGxaP82d+IWAl6Mt2Hx6NTPV5qymXpcVcAZonoFQ=;
  b=gOzY7NY1OEqveZ5QHHYBeX9HfLpfCv8fKRKGO1DoVrBc7Q6fRjBFLGeP
   woBcMIpgwSuVVUZfKOBphxifoMdrB26QfJA5wh3X2vb4oCTpxFnlKuFCk
   ujkktUaomGshpC0WQVCsrr0BUedMm9Dvgd6y7VuT6mqVlzXNE5UulSrFm
   aJijcNGYCSa+hEvaMPjYjk7fxpA9Tb39o1+Z8ohp4kPwSpdg8bD2m4aYH
   hm0uEynXmAom8VelI6Va/bOKs5+wi45eO1+Xtm9Zzw83iR9CJOO8K8ALo
   DE5XAVn/OhgtjCotUmP0roPeacNRBc1QfxkM9rrssL0xMOKISEc9J1kVa
   g==;
X-CSE-ConnectionGUID: 3MfAb1klSXusm08ftXmIfw==
X-CSE-MsgGUID: ldPeHojfS7GTfwONJ3NmgA==
X-IronPort-AV: E=McAfee;i="6800,10657,11769"; a="82126267"
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; 
   d="scan'208";a="82126267"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2026 02:56:59 -0700
X-CSE-ConnectionGUID: nmnsMzkYTFGCqpHEev4R3A==
X-CSE-MsgGUID: K2gH5t/hRHK/h8eS3uxZkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; 
   d="scan'208";a="232902873"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa006.jf.intel.com with ESMTP; 28 Apr 2026 02:56:55 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 26CF595; Tue, 28 Apr 2026 11:56:53 +0200 (CEST)
Date: Tue, 28 Apr 2026 11:56:53 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jiawei liu <liujiawei4419@gmail.com>
Cc: linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
	jirislaby@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] serial: 8250_pci: skip WCH PCI serial devices
Message-ID: <afCEZY31cb-eJXrJ@black.igk.intel.com>
References: <CAGDm1S3mCv_7usfP0dx9jqj+mt_vBD4z8gu5wVyPbXB2Kh-mgg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGDm1S3mCv_7usfP0dx9jqj+mt_vBD4z8gu5wVyPbXB2Kh-mgg@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Apr 28, 2026 at 04:26:34PM +0800, Jiawei liu wrote:
>     WCH PCI serial devices implement vendor-specific extensions
>     beyond the standard 16C550 UART. These are not supported by
>     the generic 8250 PCI driver, and binding them may lead to
>     incorrect or suboptimal operation.
> 
>     Skip these devices during probe to avoid misbinding.
> 
>     Signed-off-by: Jiawei Liu <liujiawei4419@gmail.com>

Besides the broken way on sending patches — spend your time reading
documentation and reviewing others' code first, please, — this change
breaks the cases where it works.

100% NAK. Try again when you will have a driver that supports them including
mentioned vendor extensions, before that this patch won't ever be accepted.


-- 
With Best Regards,
Andy Shevchenko


