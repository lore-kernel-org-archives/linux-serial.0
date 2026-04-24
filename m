Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A45B736164B;
	Fri, 24 Apr 2026 13:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777037283; cv=none; b=j3HrJis4qsuPmKghbAkkuiKh29Zun1Peh+ca9vy1xY4bVxMmLXx3dmUaXDhCOKy6xGUiQHCU5ng8NPuDPi2lCWec/lhQbT0nib4XLM5m9iu6xPwEYx4NGEAAIgtIWBo9XnmQ41iLlvZFbgVw1M1gwg+kpG7vuuWN4kiKrVMFbNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777037283; c=relaxed/simple;
	bh=TgBvaySXJAlZGQpJKL99VsTHVkEs72ypMcQq2IoSJQs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GatBoqErzr5Esyc/tCJMgiR2KZ6gko9/5tgLFPqskYovWR6sdKLMp1FtxAW371VP8DsQk201EJoZIOXylRm4D1v9pd5Cf+FQRjGnXH3tCcjsNyXKKgttRDKeXRuQ5KXC382z5AqRGA7177PtpNkbeykTppSvtnxixn2lzQuBeTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N3GfRH2K; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N3GfRH2K"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777037282; x=1808573282;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=TgBvaySXJAlZGQpJKL99VsTHVkEs72ypMcQq2IoSJQs=;
  b=N3GfRH2Ke0Oa0a8IN46v5zy7Ivfq1lwDFsWMAaecyxtiwMZ1iQX6Qd5s
   7/6WgFCtHYYP4OHHw9HwxdmGvrN1j/5x8DYQFtH8WkapkqdfhgxoqfzeQ
   d62HHt2HAUpWadPM7BCaZrU11mB+pA+S3rQcGxvQfFT9/6b4Xjx3XxWeE
   fN4AKF2egsy+CSSnQpMdM0RKA03ynVnwIKS3Q39jMIKG3oHbZtrZOsezc
   uA/AaQ0eVKWFraXVCjEp6gYo89FBGAfVdrI2zKwoqEyEsniJ65U+ZMi7K
   q0N6JKR/0r0X87ZvCC45FGds/xMnpDLtybBT5K4GSLHB647V6WMsNprA4
   g==;
X-CSE-ConnectionGUID: dVuz3aSxSnilsh085K2e0A==
X-CSE-MsgGUID: iGt7+xeYQySKGlA1G7aQwA==
X-IronPort-AV: E=McAfee;i="6800,10657,11765"; a="78072896"
X-IronPort-AV: E=Sophos;i="6.23,196,1770624000"; 
   d="scan'208";a="78072896"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2026 06:28:01 -0700
X-CSE-ConnectionGUID: UJWsomBYR4K6abvvtjBnPw==
X-CSE-MsgGUID: Cyj4oll4QMqvdi8CvLbxNQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,196,1770624000"; 
   d="scan'208";a="231946987"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.71])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2026 06:27:57 -0700
Date: Fri, 24 Apr 2026 16:27:54 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Jia Wang <wangjia@ultrarisc.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-serial <linux-serial@vger.kernel.org>,
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v4 2/4] serial: 8250_dw: build Renesas RZN1 CPR value
 from DW_UART_CPR_* definitions
Message-ID: <aetv2ljDOpH_Hs4s@ashevche-desk.local>
References: <20260424-ultrarisc-serial-v4-0-1765a0b4c4a0@ultrarisc.com>
 <20260424-ultrarisc-serial-v4-2-1765a0b4c4a0@ultrarisc.com>
 <4548483c-cbba-899e-6b1a-1290d36b59cd@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4548483c-cbba-899e-6b1a-1290d36b59cd@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Apr 24, 2026 at 02:38:56PM +0300, Ilpo Järvinen wrote:
> On Fri, 24 Apr 2026, Jia Wang wrote:

...

> Hmm, maybe there should also be macro also for this one which takes the 
> fifosize as input and converts it to CPR field vlaue (effectively, the 
> macro is an inverse of DW_UART_CPR_FIFO_SIZE()). It would be more readable 
> than the literal.

But this can be done separately, right?

> Also include BUILD_BUG_ON(!IS_ALIGNED(fifosize, 16) + bounds checks) 
> inside that macro to catch invalid fifo sizes (+ don't forget the 
> necessary headers for those two new things).

Hmm... Some devices may have FIFO = 8 or 4 bytes (Intel Quark IIRC has less
than 16 and it's DW IP).

-- 
With Best Regards,
Andy Shevchenko


