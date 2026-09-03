Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4188E495514;
	Thu,  3 Sep 2026 11:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788435679; cv=none; b=e8bwWPNQLYX5tiSk6frVh4SW1rVTEPSeHMoe05VXJnu0Lo4pyn+ESSgYCFTSvZcB3Q5woZIlNlnldLzNpDzYvaUsQeMua+EOcWXNTSlQ79CmBl86sK5JuArofSjOlWptEv7w7dlX8dRtN/w6RuJItkKNKVq8T72Ah9xmGgoIWT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788435679; c=relaxed/simple;
	bh=JSuJrngTC4olOG03288V/nmLwz2wwieT77d/P4LnfNw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PmoytiPDr+ZOPYyAnLfG87aUSP5vNLQQmdyQkMqyzvntgTJXwrCc3jZkxEXgOt1YQy70eS1X5QVqQcastYA4058mGOXbJud0bn2G/zB+dFJybkG6U/btB8LsHB7PyhrXqzBn+YP8OiNRUEkXRWwoTRzERm1alz1SYPrxRunllro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ers6gETO; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ers6gETO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788435669; x=1819971669;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JSuJrngTC4olOG03288V/nmLwz2wwieT77d/P4LnfNw=;
  b=ers6gETO8ILbcMJb30hBdA5cRb70xbXXtjmtpmnMrqLZDf9Pw0uSNZ3r
   zmqIAUIgx5x889AyikDj7Evm82qvOtXjLITDCIeJ0P/3WEAFFPyextNh6
   omDYIBCSFwm9AF6stJZhY30ciO+EnJXP4QTx/TmvBfp0syGTVTH+RUtw5
   S4CEuwTUuc3xASw51Hn4NllaUzBW5+PBkuzk0RyRmJZ4juBOFdnGiP7qr
   3Vl3HjsLOL8JIGvQyTDiJcnVLM2W4zo1M8/wocyUF9OStEYvhJV0LwjJa
   3LG/PgvPt2lDmtVSNnRylNxKwcyarlessTa6+5JFWFR+REBuhhUsOqg48
   Q==;
X-CSE-ConnectionGUID: 1vwjF52/Te6RGSUL1Hx08A==
X-CSE-MsgGUID: qxJCJcL0RDi82Dhyz9vVUw==
X-IronPort-AV: E=McAfee;i="6800,10657,11894"; a="88762626"
X-IronPort-AV: E=Sophos;i="6.25,259,1779174000"; 
   d="scan'208";a="88762626"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 04:41:03 -0700
X-CSE-ConnectionGUID: q2c9BakcQlmPlwKURwZPPg==
X-CSE-MsgGUID: IwhtTsApS+ukKqW3wbyOpg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; 
   d="scan'208";a="265355126"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.28])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 04:40:57 -0700
Date: Thu, 3 Sep 2026 14:40:54 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: zl020895 <zl020895@163.com>
Cc: longzhao <longzhao@ambarella.com>, Arnd Bergmann <arnd@arndb.de>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	soc <soc@lists.linux.dev>,
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	devicetree <devicetree@vger.kernel.org>,
	linux-clk <linux-clk@vger.kernel.org>,
	linux-gpio <linux-gpio@vger.kernel.org>,
	linux-serial <linux-serial@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Brian Masney <bmasney@redhat.com>, Lee Jones <lee@kernel.org>,
	mfd <mfd@lists.linux.dev>
Subject: Re: Re: [PATCH v5 10/12] serial: 8250: add Ambarella UART driver
Message-ID: <aplcxoINt0YAjvxL@ashevche-desk.local>
References: <20260818-cv75-v5-v5-0-7bbb12f0360f@ambarella.com>
 <20260818-cv75-v5-v5-10-7bbb12f0360f@ambarella.com>
 <aoRpc2RK2_X3CdAi@ashevche-desk.local>
 <162c0385.2c076.1a018b82fa7.Coremail.zl020895@163.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <162c0385.2c076.1a018b82fa7.Coremail.zl020895@163.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Aug 19, 2026 at 02:31:59PM +0800, zl020895 wrote:
> 
> Thanks for the review.

> This is Ambarella 8250-compatible IP, not Synopsys DesignWare. We
> first tried 8250_dw after Linus asked us to move to the 8250 library;
> you then told us not to touch 8250_dw and to use 8250_ambarella
> instead. That is what this patch is.
> Background:
> https://lore.kernel.org/r/CAD++jLm6HzEU1TM-c=Vtjv3FJEBecVP7TyxSgq_Q0zF-YwT6NA@mail.gmail.com/
> https://lore.kernel.org/linux-serial/an8KvvHWX0naH3Xw@ashevche-desk.local/
> https://lore.kernel.org/linux-serial/7E774305-3920-4BB7-BA46-E0772D6BED84@ambarella.com/
> I will also switch to uart_read_port_properties() and trim the
> 8250_dw-derived boilerplate.

Thanks for the register descriptions, it was helpful. After going through them
it seems the v3 as you made it is good enough (sorry for going back and forth).
What it needs is better commit message explaining that while it's not a Synopsys
DW IP, it was made to be quite compatible with that (on register level) and hence
no new driver is required, just a small quirk.

-- 
With Best Regards,
Andy Shevchenko


