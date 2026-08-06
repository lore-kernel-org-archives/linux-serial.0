Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C70D443030F;
	Thu,  6 Aug 2026 22:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786057027; cv=none; b=EabQww3oyPOTMCoMoKhQe0wGRxR7DtY4+5av9BGJ6AtLfX84d292vzVy6pinmuvPDQPpxBvKf893jCHWL52znbuTd2uC0l/H/6WacOg8XvpK5616KNnNn64UeAqzvGCzqoz8s7p8YvUvaHl2tcWlPEPR2C90AzD8UUFuIGaDzdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786057027; c=relaxed/simple;
	bh=jQOJqi9bTdO/dq6p7lR9k0QHrFDQB08MkkF6c/xlOOM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eqFM1v88swDL26thEpsbX347zqEdQTSzcwHyL0yEMCptVTcYMKbjxkmhjv8Z5ZTrnyaxyGO6OOUwa7pJiPhnkgwid9r7wkkWbKTzyRUGcRvuiadedqVBF1Wq/l2VB8u7iT25X2CxGQdMDc37ZFORqzm6plVeRq3dj170aQ13gAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KiMhuX1d; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KiMhuX1d"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786057025; x=1817593025;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jQOJqi9bTdO/dq6p7lR9k0QHrFDQB08MkkF6c/xlOOM=;
  b=KiMhuX1d3TVOQmui/x9sAJZSfE6nWrnGYTlsUoKoBEWgDSHeB+n+D3Sb
   Z5WFXRl1LQ4EKPWzl4zQVR1bnmBd0N93SKfN4hB1tqeRzxPVv00M2QhaD
   JKvWIWoZSCFoWL0caivzMU1FBkiRZV19ZR83d1HDkuLJs0hlAWnA0cMap
   fa/1LcWbKbVOYTq/9RLaPCZOXcc4sN+V+63xvg8YPbItW1KrUks8E8qJ2
   XwUqjr06RW094aJ1lym68sCW+Igo0zTWw8Chd9CpOdtnc0M6j3NrRmJ2f
   gxHte0wKpxzNV2fmAWvXz8RAVCPaj1v/POBFkoRjGN6Mth1G5ww4qGy1e
   A==;
X-CSE-ConnectionGUID: wNx6mBuaTiqHvssyMhgsJg==
X-CSE-MsgGUID: B/g745aMT62795oNhbnlPw==
X-IronPort-AV: E=McAfee;i="6800,10657,11867"; a="90341252"
X-IronPort-AV: E=Sophos;i="6.25,209,1779174000"; 
   d="scan'208";a="90341252"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2026 15:57:04 -0700
X-CSE-ConnectionGUID: R9oOwjKZTl2yoRXvMc4Dng==
X-CSE-MsgGUID: C4AoCkP3RciHbb2QftmHXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,209,1779174000"; 
   d="scan'208";a="258374825"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.50])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2026 15:56:59 -0700
Date: Fri, 7 Aug 2026 01:56:56 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Benjamin Larsson <benjamin.larsson@genexis.eu>,
	John Ogness <john.ogness@linutronix.de>,
	Peng Zhang <zhangpeng.00@bytedance.com>,
	Jacques Nilo <jnilo@free.fr>,
	Rong Zhang <rongrong@oss.cipunited.com>,
	Gerhard Engleder <eg@keba.com>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Binbin Zhou <zhoubinbin@loongson.cn>,
	Lubomir Rintel <lkundrak@v3.sk>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH v2 2/2] serial: 8250: Add Airoha SoC UART and HSUART
 support
Message-ID: <anUROK08QJ-lVlrX@ashevche-desk.local>
References: <20260724183007.188172-1-ansuelsmth@gmail.com>
 <20260724183007.188172-3-ansuelsmth@gmail.com>
 <anUQhbuHSDRs04bq@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <anUQhbuHSDRs04bq@ashevche-desk.local>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Aug 07, 2026 at 01:54:04AM +0300, Andy Shevchenko wrote:
> On Fri, Jul 24, 2026 at 08:30:06PM +0200, Christian Marangi wrote:

...

> > +	/* Set DLAB to access the baud rate divider registers (BRDH, BRDL) */
> > +	serial_port_out(port, UART_LCR, up->lcr | UART_LCR_DLAB);
> > +
> > +	/* Set baud rate calculation defaults (BRDIV ([BRDH,BRDL]) to 1) */
> > +	serial_port_out(port, UART_AIROHA_BRDL, UART_BRDL_20M);
> > +	serial_port_out(port, UART_AIROHA_BRDH, UART_BRDH_20M);
> 
> The above three calls repeat serial8250_do_set_divisor(), don't they?
> 
> 	/* Set baud rate calculation defaults (BRDIV ([BRDH,BRDL]) to 1) */
> 	serial8250_do_set_divisor(port, baud, 1);

Or with the united definition

	serial8250_do_set_divisor(port, baud, UART_BRD_20M);

-- 
With Best Regards,
Andy Shevchenko


