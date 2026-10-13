Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C69E1F4176;
	Tue, 13 Oct 2026 13:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791898948; cv=none; b=MCX0uz+NbC9WoWrn1OrhCUMHUu+XTGWderEbaB4FiPrhuklyMqL43pSEFbeUSLFCE3bjr1ngldZXcFKVrZlzNTlGMTGhhGiOOuobDKjkgwqTNtnAj2e0SRJQCgUBPi5LNCQ0GP5ioZg9betMrV/F8NtHIKyiGhRLJxoa0vuJUvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791898948; c=relaxed/simple;
	bh=47Ugmu/MXcINVLz36piL1JROl9v9e1tY83Sfw+DVcuU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YGu8SNnsKyLeIPoALxaWqsuSH9Eok0I4T5UIXmVB5ty6vWQZOxKRjBuYxsnmFAK8BhhINyN01F/gNbmwCC98nFaDoMgdIv6ly2jLJr3RAD2T7tahqA9Nbuxj6E6YsfPnUFGyAqHQ9Ss7YFqkIvmlK/5NIZih+hsZdWpj0Eb9+D4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KkUp03N+; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KkUp03N+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791898946; x=1823434946;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=47Ugmu/MXcINVLz36piL1JROl9v9e1tY83Sfw+DVcuU=;
  b=KkUp03N+ITvZEvt2JAuPCCybFBGCkdRtXBXDYlrZ+6gD87wEG7eAt7sM
   I+s3cdnOIDztVRAFke+CYsjYH0SfBCYP/LFDgEM8iZjvYXdIIKZZKQ58q
   Nkw9cd5yW9drpikYmdiKAVCR52UKs/LTn2plees+CQdZpScXt8QtzIwII
   rIKTKTy0mJxP1u5X71bqFCINu6tdjrPI7wv2IimNyJZIGuan5dTRKx6M2
   AVcnmVhjH+WthNxG9QQWytHnjxYTlfnWXwBu8OW1dIZPpGoIwvxmF2dK2
   S54AOxsWt+Dui0E1YWXgLmxfIx4b1rbIiTjtGxEZ+BP6uTiVqav4BxmXx
   A==;
X-CSE-ConnectionGUID: quUdVjy2SHeHGQJAtflHYg==
X-CSE-MsgGUID: U4mD7TgHTRCO7KpRfX/NjQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11933"; a="633434"
X-IronPort-AV: E=Sophos;i="6.27,155,1787036400"; 
   d="scan'208";a="633434"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 06:42:25 -0700
X-CSE-ConnectionGUID: 1rsirYx7QQWSpEQLINJRXw==
X-CSE-MsgGUID: c9T0gSdUTQCfhwUxRTS5/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,155,1787036400"; 
   d="scan'208";a="1090773"
Received: from ncintean-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.48])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 06:42:16 -0700
Date: Tue, 13 Oct 2026 16:42:13 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jiri Slaby <jirislaby@kernel.org>
Cc: Alejandro Colomar <alx+linux-hardening@kernel.org>,
	gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Richard Cochran <richardcochran@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Ryan Chen <ryan_chen@aspeedtech.com>,
	Billy Tsai <billy_tsai@aspeedtech.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Ray Jui <ray.jui@broadcom.com>,
	Scott Branden <scott.branden@broadcom.com>,
	Al Cooper <alcooperx@gmail.com>,
	Paul Cercueil <paul@crapouillou.net>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Chaitanya Vadrevu <chaitanya.vadrevu@emerson.com>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	Helge Deller <deller@gmx.de>,
	Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>,
	Thierry Reding <thierry.reding@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	Masami Hiramatsu <mhiramat@kernel.org>, Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>,
	netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-rpi-kernel@lists.infradead.org,
	linux-mips@vger.kernel.org, linux-mediatek@lists.infradead.org,
	linux-parisc@vger.kernel.org, linux-tegra@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2 6/6] serial: 8250: make port operations work on struct
 uart_8250_port
Message-ID: <as41NVTyPHp8cMS-@ashevche-desk.local>
References: <cover.1791873876.git.jirislaby@kernel.org>
 <c59fa203f325e0fe7601ea0fbc0d222c8b37f9eb.1791873876.git.jirislaby@kernel.org>
 <as3etnbZatn4sbfx@ashevche-desk.local>
 <c6b08f53-b5ee-44c8-93d1-54fdf5994ed2@kernel.org>
 <as31PsESOgLUhMB6@ashevche-desk.local>
 <b404f3d7-1b2d-418a-8634-72c61ce33f8b@kernel.org>
 <as4JDXOIGvCbAnE_@debian>
 <f808883b-464e-4de8-a0c1-f799fd3d755e@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f808883b-464e-4de8-a0c1-f799fd3d755e@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Oct 13, 2026 at 01:06:41PM +0200, Jiri Slaby wrote:
> On 13. 10. 26, 12:51, Alejandro Colomar wrote:
> > 	alx@debian:~/src/linux/linux/master$ time rg -n ARRAY_SIZE | wc -l
> > 	58957
> > 
> > 	real	0m0.512s
> > 	user	0m0.490s
> > 	sys	0m0.974s
> > 
> > It's around 50% faster, which I wouldn't call orders of magnitude.
> 
> If you pipe rg's output somewhere, it no longer works in parallel.

Ha-ha! It means it's useless, as it outputs (as of your example) directly to
the console without any pager, so one can't simply look backwards (it's limited
by the terminal emulator scroll-back buffer).

> Are we really about to discuss this?

Up to you, I think `git grep` wins anyway by several reasons (at lest for me).

-- 
With Best Regards,
Andy Shevchenko


