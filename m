Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91ABB3DD525;
	Thu, 10 Sep 2026 09:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789032836; cv=none; b=PJkCy4PW94XpH5LtsdwQ+uM9YCi1IZEzCF/xLlvNbm0ciBibF/rN/XazRa9EAO7n7qrlyfg6UczESHVg1b2KWE6dCn9/t0GwNip1ig8bXd+DCdlxikhzEtJYf9MAdmEcB6ZQDjqVPoQNO+b5wmATsa9nIf956wI0vBTnVwNy974=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789032836; c=relaxed/simple;
	bh=FjcDcqvU0235HfXhQqh3BNVRPpVFE3oJFo7uUnHGA88=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=j79tny9sOKOC8csXtjX0sySq32l3SvVfTxPP2J8rF3aKb+AT9LnQ2RpBxpKITfOVFIZGt1yohdSxiQjIKnGZTXrV5ILRpC3QlDyF+yX+QjyLmQhFhMKpsywznRLvASz96WP0L5ahXJ0VvBLGpgBnuTuQJc8TGg1LN9+3T36ZW9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cY8PFmEo; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cY8PFmEo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789032833; x=1820568833;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=FjcDcqvU0235HfXhQqh3BNVRPpVFE3oJFo7uUnHGA88=;
  b=cY8PFmEozMPmjnX10Z3PYZoWfUn60dxbjVOu5MErTglZ+2bT4eNbcFsr
   Ep4+X3Z3OPA1ivNK4wk6UGsYfwWAll9MIlGFwvI1zWqFeFfbGuthNI944
   XBCzvfvpQaLJH7jqNMHn7zpKTWMbRy1+5l/qp571/2oHDLr0LP9rXErQY
   Olepj3FGmGSUpBa5Rx3pXNKEzOhEWAEIwrBzSsHc2WdIMx/Le02yGV346
   9xgbCmKqEWbIQFZF18Lpc4Zk7Ce0K3nwjOVakvG9qZJP2z3GYdvS4VF+l
   YoKhhTYd/IlnYZJZMJt8Gvkfe0JODFVUzGpTO2yCat7VvwFJktLJBBVhk
   A==;
X-CSE-ConnectionGUID: IBZ2LolpTYmMfkJPoQqhVQ==
X-CSE-MsgGUID: G9L0dvZAR7+xJiGGNR1M1Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11900"; a="89509912"
X-IronPort-AV: E=Sophos;i="6.27,95,1787036400"; 
   d="scan'208";a="89509912"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2026 02:33:50 -0700
X-CSE-ConnectionGUID: 3jn/nBKeSJK4lhAyBYfZeA==
X-CSE-MsgGUID: IkjzOK7hQjS96BFYssBhzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,95,1787036400"; 
   d="scan'208";a="272089790"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.221])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2026 02:33:42 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 10 Sep 2026 12:33:38 +0300 (EEST)
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
cc: zl020895 <zl020895@163.com>, longzhao@ambarella.com, 
    Arnd Bergmann <arnd@arndb.de>, Krzysztof Kozlowski <krzk@kernel.org>, 
    Alexandre Belloni <alexandre.belloni@bootlin.com>, soc@lists.linux.dev, 
    linux-arm-kernel@lists.infradead.org, Rob Herring <robh@kernel.org>, 
    Krzysztof Kozlowski <krzk+dt@kernel.org>, 
    Conor Dooley <conor+dt@kernel.org>, 
    Michael Turquette <mturquette@baylibre.com>, 
    Stephen Boyd <sboyd@kernel.org>, Linus Walleij <linusw@kernel.org>, 
    Bartosz Golaszewski <brgl@kernel.org>, 
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Jiri Slaby <jirislaby@kernel.org>, 
    Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
    Lee Jones <lee@kernel.org>, mfd@lists.linux.dev, 
    devicetree@vger.kernel.org, linux-clk@vger.kernel.org, 
    linux-gpio@vger.kernel.org, linux-serial <linux-serial@vger.kernel.org>, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: Re: [PATCH v6 11/13] serial: 8250_dw: add Ambarella CV75
 quirks
In-Reply-To: <aqJ35vMBiBZo2iUE@ashevche-desk.local>
Message-ID: <b199eb38-b1a2-4db6-81d8-37bab09a75b7@linux.intel.com>
References: <20260904-cv75-v5-v6-0-e918514cb3b1@ambarella.com> <20260904-cv75-v5-v6-11-e918514cb3b1@ambarella.com> <aqJrSnr0rwv4BOJ3@ashevche-desk.local> <122573f8.8232.1a08a9765fc.Coremail.zl020895@163.com> <aqJ35vMBiBZo2iUE@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 10 Sep 2026, Andy Shevchenko wrote:

> On Thu, Sep 10, 2026 at 05:12:52PM +0800, zl020895 wrote:
> 
> > > Wondering if we should undo this in the port's .shutdown() callback.
> > I saw the shutdown path already covers it: dw8250_shutdown() calls
> > serial8250_do_shutdown(), which does
> > 	up->ier = 0;
> > 	serial_port_out(port, UART_IER, 0);
> > so both the IER shadow and hardware IER are cleared, including ETOI.
> 
> Depending on the answer to Ilpo the enabling may need an updated comment
> summarising the above.

I'd prefer removing the entire "Force them ..." sentence, it feels really 
basic detail about how ->ier works. I believe that would resolve your 
concern if relates to what shutdown does for the flag (clears it while 
the comment as is says nothing is supposed to clear it).

> > At 2026-09-10 16:33:14, "Andy Shevchenko" <andriy.shevchenko@linux.intel.com> wrote:
> > >On Fri, Sep 04, 2026 at 02:38:18PM +0800, Long Zhao via B4 Relay wrote:
> 
> ...
> 
> > >> +	/*
> > >> +	 * Ambarella keeps variant IER bits (e.g. ETOI) set for correct RX
> > >> +	 * timeout behaviour. Force them into the 8250 IER shadow so later
> > >> +	 * generic IER updates do not clear them.
> > >> +	 */
> > >
> > >Wondering if we should undo this in the port's .shutdown() callback.
> 
> 

-- 
 i.

