Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792497067;
	b=A3HEUo7Qyqjb5nh3JnocZ1jMH4hOLqD6IKjXLI/xruL4hIMGKe1qtllbUS01M+uG7GxK
	 AosCFcpPaCRagWJemDdSfSbfT1Dq4GVuXPgaHOIC9gQg7dyaN8AhfyL7YkgqJJUNMQshU
	 1d9JaM+7BKWNFEIXy7QJtgookDLZlJfkTI9qISR3rhCPplvDRxwZw50X/7lj/EWVVnurs
	 ovos+4SrYUdGYu2bdXC4sPioJy4JCft2C2ChO9CZ0+frrAEspqTs7VAZOerA7t+0VSDx6
	 s+4ECicc6lvLStYmWbu32jlJSWhLZj10dIhlNW3Lebn8PTGDvLqryVXhYoaNBxZWpsw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792497067;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:Date:To:cc:
	 Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type;
	bh=kjIus0/Z7THMqH+fmdFt+9x90O1BbsB0s2G1vUB5BlU=;
	b=4Ogf2OGx2fOpqiiZ/eIaaeHARC4cI6ofnmT3kOZEKKKN9L9/qLC9aEhj9cYPCM0ShahH
	 2lyxiAMvSaIuqyTamETZpFD+ShlySidmx9p+0QGxC45zHtymcIEju0VyXCOVP5NaXOpCR
	 jXr7Fq+Uierfv8ELRZG75qi/vEMfrXnbFCnQOaRx/BrZVd+sj+QELYho3wEhYNAeX1hiI
	 /6lIO9UAL8EMz1JfE1GkgYEz5eYyG71SUVdXcWz4Ry0A/69lZY6j+SbhyXA7sx+/wOYGz
	 /mlCkvvrxO0skeimWQ+xwKptiPTSr7ZGH3KiPmHQEzTOnZZE7GSgPVVGCOghKY942EQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=lUwWStw7;
	arc=none smtp.remote-ip=192.198.163.11
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D74606A319;
	Tue, 20 Oct 2026 11:51:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 41D74606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=lUwWStw7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792497068; x=1824033068;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=vZOZVuw0ZwLdXOpr1UleOlDXx5oOWBvkj4gsvs1vsuA=;
  b=lUwWStw708zBGMj1ZE8dkplhKeQnBnmoQ2vo6Nfp7SIFI5PaFv2h+gEC
   dtWslWb7whElHx8vp6K6NKc4TcnpelkICvInopLNbTtXp+2AynHM3NSQL
   AKps9D8L6YbUPWx7SVa8DaFhzGCazOpWH/i5SYibaqov44RK0PcIjGwNJ
   bnlm94NuvGmc6N6i2xuKJnf0mU3KmspHi4JjWYywJ1zKoy9LTx/KKuasS
   hmnBeIkbyphq0K1olPNe4SuJeMq2PVSXvA8BFjsCd9QNlM7df5hFCyfMs
   vhANBfB4sXBQGpMjAx7QukPIVLaxTtxq3f/ZPjDcPngc88+Qk5Go5SLMa
   w==;
X-CSE-ConnectionGUID: 6wJtUXUrRLqCaGuzqKg1Qw==
X-CSE-MsgGUID: U1Xu49YHSJqkHI+5RS94cg==
X-IronPort-AV: E=McAfee;i="6800,10657,11940"; a="1098546"
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="1098546"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 04:51:07 -0700
X-CSE-ConnectionGUID: Rgz5036KQxSUgIH5S/JUhg==
X-CSE-MsgGUID: lWP5tft+RLebTMNLYPQWxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="2852905"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.181])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 04:50:59 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 20 Oct 2026 14:50:53 +0300 (EEST)
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
cc: Jiri Slaby <jirislaby@kernel.org>, 
    Vinicius Pedrosa <vinicius.eduardo.pedrosa@gmail.com>, 
    linux-serial <linux-serial@vger.kernel.org>, 
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>, robh@kernel.org, 
    krzk+dt@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, linux-sunxi@lists.linux.dev, 
    Andre Przywara <andre.przywara@arm.com>, Chen-Yu Tsai <wens@kernel.org>, 
    Jernej Skrabec <jernej.skrabec@gmail.com>, 
    Samuel Holland <samuel@sholland.org>, 
    Enzo Adriano <enzo.adriano.code@gmail.com>
Subject: Re: [PATCH v2 2/4] serial: 8250_dw: Only accept a contiguous DLF
 readback
In-Reply-To: <atcm2zqDs1P_EDr0@ashevche-desk.local>
Message-ID: <09812a6a-dd0d-9c47-e1ad-5220f1954648@linux.intel.com>
References: <cover.1792439398.git.vinicius.eduardo.pedrosa@gmail.com> <a79114e72d029732db6764935dde12aa5d497706.1792439398.git.vinicius.eduardo.pedrosa@gmail.com> <d992e18d-31ab-4937-8780-9c9dc423082a@kernel.org> <atcm2zqDs1P_EDr0@ashevche-desk.local>
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 20 Oct 2026, Andy Shevchenko wrote:

> On Tue, Oct 20, 2026 at 08:11:06AM +0200, Jiri Slaby wrote:
> > On 19. 10. 26, 22:06, Vinicius Pedrosa wrote:
> 
> ...
> 
> > > -	if (reg) {
> > > +	/*
> > > +	 * DLF is a bit field starting at bit 0, so a real one reads back as
> > > +	 * 2^n - 1. Any other value means this offset is something else.
> > > +	 */
> > > +	if (reg && !(reg & (reg + 1))) {
> > 
> > Do I understand correctly, that this equivalent to:
> >   if (is_power_of_2(reg + 1))
> > ?
> 
> Yes, and since we check for reg to be "not zero", this will work the rest.

For is_power_of_2(), 0 is not a power of two. And it also wouldn't make 
sense to have zero bits in the bit field as it's same as no bit field so 
using just is_power_of_2() should be enough.

It could be that's what Andy meant, but the wording left too much room 
for interpretation.

-- 
 i.

