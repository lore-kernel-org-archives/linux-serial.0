Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC784499AB;
	Thu,  9 Jul 2026 21:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783632913; cv=none; b=ShcE+p1KUZEAB5h2cDPkQ3jYLt2WOaO6MOVnX9IUhQy8TmYoVUkzKtIvaznfpE9rOJafoFLr03+Rhmc9BJgyxlJtoMdPKqwGt/LmCMsDslykwPiafTMLY37zEHAnhFXWjP8O1Oy2N4uZAEXsGsTCs81iOS8QysUYxbkeKbKY30U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783632913; c=relaxed/simple;
	bh=JLW5GuV+gvOj/bsv+KPy/7xcdxgQ182iUP0Ur57DyKo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eTw4VcMxrpUjyw4h6mINCv9FFDLzUzrObgjuyPFLmfXr51JAlrogXbJ1kvzrgDlzUHP6yrRRjIiqpgDVhlEdBiOaYi9k1Fzbrr3E8XwOweFfaVfH/B5S5zMeslRBNNUBIvp8vVvOD2U5W09etncIaV/b7QmUUGGFcRN6Vh6v2w0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Sqbn7HBA; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Sqbn7HBA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783632911; x=1815168911;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JLW5GuV+gvOj/bsv+KPy/7xcdxgQ182iUP0Ur57DyKo=;
  b=Sqbn7HBAtixLhrkBV3vh5rsumHZW0cdu0qqGCoDwZ6E2edIUBKOskEFy
   3GCyFSM016ezuGu4rhMhn2XxqqXjZ/ohJFUK0W/c1JD+X6RWzIrS/BZ9e
   VlHTORwRjm/2uc6i3ZxOVGm8JmKpt3R3W+16DPJQOTqnZdosWtslXfY20
   6v7edWFp5xD61qJcNVYCh71CSIuCFqlCRW54lE1aCCTlVYk8uPSnefPaW
   cyTmbE2WNb1OnV1C4S8rUb0wLcj96Mgei+31+ccp7X902r1ERo/NirBou
   ULBFjR+1ILoRO3Pim+0hMv6GlzdCJEDQxIkfb85ebxVR9gLzm6gxBqYXt
   g==;
X-CSE-ConnectionGUID: 0951tug3Q0qj76nLH1XIdQ==
X-CSE-MsgGUID: z3w4iBS2RgqWVa0UVpy3Qw==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="109878264"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="109878264"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2026 14:35:10 -0700
X-CSE-ConnectionGUID: ag+i8oY+ThyC+jVOR3zH3g==
X-CSE-MsgGUID: xC2ZAminQj6zU5iZNQbemA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="254220255"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.100])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2026 14:35:05 -0700
Date: Fri, 10 Jul 2026 00:35:02 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Benjamin Larsson <benjamin.larsson@genexis.eu>,
	John Ogness <john.ogness@linutronix.de>,
	Marco Felsch <m.felsch@pengutronix.de>,
	Gerhard Engleder <eg@keba.com>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Binbin Zhou <zhoubinbin@loongson.cn>,
	Rong Zhang <rongrong@oss.cipunited.com>,
	Lukas Wunner <lukas@wunner.de>, Lubomir Rintel <lkundrak@v3.sk>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH 2/4] serial: 8250: export serial8250_get_baud_rate()
Message-ID: <alAT4QMOi8U2ITho@ashevche-desk.local>
References: <20260709205656.319531-1-ansuelsmth@gmail.com>
 <20260709205656.319531-3-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260709205656.319531-3-ansuelsmth@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Jul 09, 2026 at 10:56:50PM +0200, Christian Marangi wrote:
> Some driver might need to access the current baud rate to correctly
> configure it.
> 
> Export the serial8250_get_baud_rate() function to limit code duplication.

Why?

We have _get_divisor() / _set_divisor() for exactly that purpose, no?

-- 
With Best Regards,
Andy Shevchenko


