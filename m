Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 632F73F7AAC;
	Mon, 19 Oct 2026 08:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792399119; cv=none; b=CQWxyFeZzB1csPZcKVdhdjZjNq5kQXA3PiZFdUkyqVpWGn4T5AHt5dau2oZQiRFuegrE1YgtqS7z3t4HSEInoZnteV37+KQzerH2yxB4UD1ImNHTd4cv9qT9YsP9ySxYr2XBF8R/MyEU4U1OHQaJ+oPSbneKoVtE9U7r4BEaGdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792399119; c=relaxed/simple;
	bh=XA1A2IIHw4o7SLmRgWiGcPv/uCAK121PMRqCz04TzZo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MjdVll5FsrbXjxMqOgZBykkFkN0PCTcU2P0rEn9nwSWF/4SzuCWQ84U5oXRXtex9e4khvMObuw2eHXEhrfs0VINsLottFaKd7/2ZGUzGzYuaAx2pdo53nHPegye+x2kE3RZ4N3lATR90GqkcLJhu/weBoyN7zVSIySGkMIrBXlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YZy6oNuA; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YZy6oNuA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792399118; x=1823935118;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=XA1A2IIHw4o7SLmRgWiGcPv/uCAK121PMRqCz04TzZo=;
  b=YZy6oNuAzNikkw3e/Oyi1azxpzOz14LI/QMNuJcx41gbM1QetlnJlGVc
   2MiBzOzC4s5Tg3BfcZV2lrjRmRkTyD5Zz+++YHYoXfbWhkqDgir78P8pl
   nYpvdzt6wuiQJj3ENVeB5i7C8fQu0OL7LCWYFTKdGxta37e/irhz4Cmmz
   5vQB5D/pvw4rrqHtRYOta3yJGBISM05oyWG8krh0xtJd22/w05Vawce9W
   whpfPQgu8qiRNfZOCSxQ3VJnZp0MnE57DK33B47tpIUFSewJb4EtMDdD2
   LT1N2JINpIu7amrL8GRt2aoqQcvuRY2xQtfEan8q1v8GGnX8ruY4ZPyhW
   g==;
X-CSE-ConnectionGUID: l9WUzvOkQGarwBZFj21rYQ==
X-CSE-MsgGUID: NGVsLkvZRPG2gNOltp/dkg==
X-IronPort-AV: E=McAfee;i="6800,10657,11939"; a="979018"
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="979018"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 01:38:38 -0700
X-CSE-ConnectionGUID: DvakjlgDTqKzmamS6MZ+rA==
X-CSE-MsgGUID: QcNNV21KTYSyf7ORGohkRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="4325289"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.209])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 01:38:35 -0700
Date: Mon, 19 Oct 2026 11:38:33 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
Cc: Arnd Bergmann <arnd@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev
Subject: Re: [PATCH 1/2] tty: serial: remove hub6 multiport support
Message-ID: <atXXCYimAdgGhZsa@ashevche-desk.local>
References: <20261016130328.1037616-1-arnd@kernel.org>
 <atXLd6SdHNr0UcjI@monoceros>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <atXLd6SdHNr0UcjI@monoceros>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Oct 19, 2026 at 09:51:40AM +0200, Uwe Kleine-König wrote:
> On Fri, Oct 16, 2026 at 02:59:47PM +0200, Arnd Bergmann wrote:

...

> > Fixes: a300273c458c ("serial: 8250: hub6: Add cleanup code")
> > Fixes: c526404a4a92 ("serial: 8250: Fix corner case for port matching")
> > Fixes: 7ab80d1e7243 ("serial: 8250: fix compile error with hub6_match_port() when compiled as a module")
> > Fixes: da7b5fd4e17f ("serial: 8250_hub6: add missing include for hub6_match_port()")
> > Fixes: 3d406299d882 ("serial: 8250_hub6: add hub6_match_port()")
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> 
> I wonder about the amount of Fixes: lines

We have patches up to 23 Fixes lines IIRC.

-- 
With Best Regards,
Andy Shevchenko


