Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D883C355F2D;
	Tue, 28 Apr 2026 07:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777360512; cv=none; b=Nn/S/X+z/f1fZYSmkOmJVexYyV9NvdpMNnYiscf1bWU/fVkBT1t3vI+3bu0PUwoc0Xwz1tkiNR+GlmcPMYg+xat0d7h7Dd5llxXPCUdHkwNhq6R0OoCTJR3IOnDRB61WxztmwR6bTrz/7uuHxqHGESttvT2Mm1mR2PxJqBXWPTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777360512; c=relaxed/simple;
	bh=Q7LiYqnlwsUZrSNZmU+aGajjRZKDNMhNNKIUhLLiISw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tujsQeX1mRRVkqofHwkhoDdiNm8iv9u0Pk0h1gK3seOSxu6QqLPiuC1dGd3CVg/VEhKqBOSdfatjmnNihOVk8j/MhcjUDM+DuAo2qCW6XIGDOSG+i0QusD2LJt2luhppjasQIEkaCxQJcFY3cWBfC6lKesiCg1B+xQhdIGvUw1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bSH69yZ6; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bSH69yZ6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777360510; x=1808896510;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Q7LiYqnlwsUZrSNZmU+aGajjRZKDNMhNNKIUhLLiISw=;
  b=bSH69yZ6YmIQx84uwl5BmXiSLEwu/a11OtHnIKqmHfIN1IswZs+im2zI
   s6KpAlNaoaF9A+TorS2XhZGTrP0BUdsSBDmPAMZfjQQByWFp7JkN12dv3
   i8VbICkcfVnQVpCqzu6bVk3lor7dEGKrjKqla7dZcLUdNg39EK66+q/y8
   pM9eGZaSX1sF4aGir9c8BqynqTBdniOBRujMue7poY8kxl6OTUYKdkJW2
   vG1gX+WIVMUj8hWLuTbckJVdBrePlFjp5sWn31IWg3w04OSqjDP8MytdT
   WywHzHpnEwpj208JyE4xBCZoE1VGCTb5IgMldNeGbcI+fnqhg+nCGu2+H
   w==;
X-CSE-ConnectionGUID: s1zFPcPNReaH9xCF8Sbx9Q==
X-CSE-MsgGUID: E4i1uzIzTnahMEckNf9AZw==
X-IronPort-AV: E=McAfee;i="6800,10657,11769"; a="78281054"
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; 
   d="scan'208";a="78281054"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2026 00:15:10 -0700
X-CSE-ConnectionGUID: Bj30AuJCQeefJA5s34H2Uw==
X-CSE-MsgGUID: Tizm7nbvQJmDwmSH4lCy4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; 
   d="scan'208";a="229514829"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.213])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2026 00:15:06 -0700
Date: Tue, 28 Apr 2026 10:15:04 +0300
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
Subject: Re: [PATCH v5 1/4] serial: 8250_dwlib: move DesignWare register
 definitions to header
Message-ID: <afBeeGxD-ABOTqpf@ashevche-desk.local>
References: <20260428-ultrarisc-serial-v5-0-97de63b1e3eb@ultrarisc.com>
 <20260428-ultrarisc-serial-v5-1-97de63b1e3eb@ultrarisc.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260428-ultrarisc-serial-v5-1-97de63b1e3eb@ultrarisc.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Apr 28, 2026 at 01:26:26PM +0800, Jia Wang wrote:
> Move the DW_UART_* register offsets and CPR bit/field definitions from
> 8250_dwlib.c into 8250_dwlib.h so they can be shared by 8250_dw and
> 8250_dwlib users.
> 
> Add an include guard for 8250_dwlib.h.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko


