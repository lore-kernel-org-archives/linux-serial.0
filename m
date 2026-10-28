Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.17
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793180336;
	b=0QlFYwh354Vsy/d7klSF2YtTPxlfKyWKmKy0g1rjLvvimJw62Gg/YhdmM6wIwqAoT1RY
	 fILFxhkbpTozrdqLynmQniabVyGWC4qIqqvTUlTOigLbbhi2cqV7chb5ePTEOkeLQfaaJ
	 cCMpJlyvLbsYREQsiGgPY1S5FvalvfQ5sTADMw+F25uV6irTnOlJz2io7LKopsZIYDK2t
	 ZoXkt6i7sWikJI/NCFOCTFRDKSXy9ZK+Rf6vdXixKj4Fh4UOfeFyiNhTH3qQxV6tvyn17
	 YqTRFwBFQ+azFxCfN0F3rbg4KwZA++Ercey3eh6RPETqr0I5g/Dw62o4/fyAnTOJI2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793180336;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To:
	 Organization;
	bh=4Opxk4J3P/lQRYSzRzcyGA3GhbNDdUkf3ywTfHyPD5I=;
	b=bp9rdv20O+q4fxYZZDQCXva7JgUFyVzaGJ0YDc1OKTwuVA/wq9YTRvLgYK0SFApDM6HL
	 /begwz/hND0czaPtk2i7iBoF7jI7cun/lFwhnll0z+ZEv7X3XDApdDpkdvrX3HEb8yxl3
	 lvxcy4UT2+aiRtwvFXUjKDhS+kbPfIJgAhm1KqUi5Ka0d4bJ0Di6nJSIRzCbOlIu0vYl3
	 UiVSomfC2mwGgnoa2i8Gttr8/XG1at9c5Wo4ZKWTvLkTxpLnYRv44nzLtXiLOWL9N5RJi
	 YKYGYTQ/gUixgHNTMWSLeqLFnLmEm0VF5DTnQGp7OMbu6uzgHwPnhkB/UrIiuhFSn6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=l1POeTUT;
	arc=none smtp.remote-ip=192.198.163.17
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC18606A324;
	Wed, 28 Oct 2026 09:38:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0CC18606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=l1POeTUT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793180336; x=1824716336;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=bypaJ8cdN/DdWj3569Ofb4Ox5IIISGZCyAhXfZcSDWs=;
  b=l1POeTUT10RAH8l4x3l5iUUYlF9LFWlTO8F3N2HK6j5asWXWYrnc3tP9
   yCtXgSujteg4xvKJQw/FR2hnIXepAzhnxhqKJ0o1639ySPPGLqbSYxFaV
   gqbzD7tWtyNsIjvnt3CVRGiq7PN6gwbghg4QE8zgmYJeb1yVPrbEnhLoJ
   WED5pHLMod9JRCMiF3ZBS6ph2E3g0x5H/FdE/VfhQO0R9Z09LrR+M7flu
   TYqCap/48SYzP6DqtKw/Tg4ZShlvdDZXXJumFPUGcMURcU0zZRRpdWVv1
   tqAAKLWCCYkIJU45VkmaiITQoQIw/Rzg/RNJHwrP0k0HOC2qGLc0NS8h+
   w==;
X-CSE-ConnectionGUID: HOM2rQfsRSqEzWLjC+hz6w==
X-CSE-MsgGUID: /6qJXO0WRFyHTuN8Td8DkQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11948"; a="1909713"
X-IronPort-AV: E=Sophos;i="6.27,182,1787036400"; 
   d="scan'208";a="1909713"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2026 02:38:55 -0700
X-CSE-ConnectionGUID: IcTlcG6QQJ2R3jBJHMmH1g==
X-CSE-MsgGUID: ugfwFS9kTnCQm0j4AQ8Pbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,182,1787036400"; 
   d="scan'208";a="4725820"
Received: from abityuts-desk1.ger.corp.intel.com (HELO localhost) ([10.245.244.117])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2026 02:38:52 -0700
Date: Wed, 28 Oct 2026 11:38:49 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: James Hilliard <james.hilliard1@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-serial <linux-serial@vger.kernel.org>,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev
Subject: Re: [PATCH v4 2/5] serial: 8250: share the RX trigger conversion
 helper
Message-ID: <auHCqZ8_SGSknC_n@ashevche-desk.local>
References: <20261027-submit-h616-uart-fifo-v1-v4-0-d37e018fd0a6@gmail.com>
 <20261027-submit-h616-uart-fifo-v1-v4-2-d37e018fd0a6@gmail.com>
 <805ee11d-c385-f509-456a-35205d8963b4@linux.intel.com>
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <805ee11d-c385-f509-456a-35205d8963b4@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Oct 28, 2026 at 10:30:07AM +0200, Ilpo Järvinen wrote:
> On Tue, 27 Oct 2026, James Hilliard wrote:

...

> > +static inline int serial8250_bytes_to_fcr(const unsigned char *rxtrig_bytes,
> 
> This looks way to complicated to be inline function so I think it should
> be kept in 8250_port and exported from there.

Fine by me! James, my tags I gave in another reply stays if you move to
exported function.

-- 
With Best Regards,
Andy Shevchenko


