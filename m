Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793789293;
	b=vQxo4+wxOTGjogGKXwE3drLGByTXy3HN/yHtoSMkYmhFDo8SliP3VemAI/boEUt4BXBg
	 7WjV7tg7f3kdYmG7pBbFkgRC6uFs7NKDOuv0mbSP0JL0dQV3kRiIke8nrtbRKljJid3pZ
	 oXICmVmfizQL30Cabq2lMXj+V1uBD+5rKGnewraSYpYLMq52ae78cQMW2H7HOEwfBtxIN
	 yebcSkVLlDFc4C8KWjG4KMbuEZXxpx4ttUGQp6W1rF6pMac8iXxKw4mMernavH8tixgeN
	 2XyZF56+uZEmvyJ1WB/uR92+EZoe2voEng4rhYJvTPqfX+YkyAmbk2daZLAOnVKlEnQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793789293;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=jozP82KH6glhGWXgzZRzNLlRupxlnORo/58rZr7qZ9M=;
	b=KFzIaCCFkgA7zb9McA29wji4nd+R/X5IJLAPq3ZzAgQbtlFD9BKxY3t8TJqJlbM73ieB
	 S4Pw4ZA8APw2YIsOkmkNm2gkng53yaDeJDmbMxfE8WhQgUdzA7ECy7WpHjiMsEyF2UyYe
	 CkzY3PIH9iYGdX8AKn1LLkmW5JW0+PSAkGJE11HG9CXCIQq27zcV92TzKKyPiHk1oNaP4
	 AS0u+I2psXHqNmEdt6vFcFniq7Qn3tQ3U2K5FMgzZ3+NYptGc2eBatIAKDacKlhhKmyZ1
	 LOYEBLdF6rJj9VkbYcYZRn+yCgbLjUvgMCPucQsClsu/uJ6Tg8zYLEWWpy3V4Xw38bw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=fZownUSi;
	arc=none smtp.remote-ip=192.198.163.16
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D720606A31B;
	Wed,  4 Nov 2026 10:48:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0D720606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=fZownUSi
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793789293; x=1825325293;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9WOXcToYwIQoz7fhImQHKUc1KH3haX4Er1ncPbI21WA=;
  b=fZownUSiIhWy1NDFoqIJUMDiCpWvxVAKV9TvP1zyL35DDVrVyUv3NqTF
   k7eAclEu9pQqpNnsBvFTY9cfJNfZ7rBCTBGei803suZ0PnTxsc+6wg5E0
   r9JQmVIsNvawtxyQ0aVv1qbcZkbqFIN7nDuhjfcyL7pDYgC6O+O4rdLLE
   FlOIIlOFwBMgTgGN0wWnqr7Tt7hgolVCkizMtKEovLHiG3CIBgnlb3ej7
   BB1zGqugEXl9WJjGeFjhD/b27uR6gw1NrJaJQ/+49BVWtUI9Tj6jeqXvO
   qa9VhvgW/lp2sxoFjvvr4c65VducQT9JsGUfa9DubZUKn8KLAfxNoHvcH
   A==;
X-CSE-ConnectionGUID: MBCBN/0iTCu/hPZq7aFqwA==
X-CSE-MsgGUID: L+tbilk2TkuqeH2cFzEhug==
X-IronPort-AV: E=McAfee;i="6800,10657,11955"; a="2552440"
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="2552440"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2026 02:48:13 -0800
X-CSE-ConnectionGUID: h8C2zJTFRfq6dw4VZbAfEw==
X-CSE-MsgGUID: AZLoV3SzT9OTjAmHCmqQ3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="8558196"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.24])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2026 02:48:09 -0800
Date: Wed, 4 Nov 2026 12:48:06 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: James Hilliard <james.hilliard1@gmail.com>
Cc: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH v7 12/12] serial: 8250_dw: configure RX trigger
 thresholds for Octeon
Message-ID: <ausNZqZrR3wqQjf7@ashevche-desk.local>
References: <20261103-submit-h616-uart-fifo-v1-v7-0-c9e248d685c1@gmail.com>
 <20261103-submit-h616-uart-fifo-v1-v7-12-c9e248d685c1@gmail.com>
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261103-submit-h616-uart-fifo-v1-v7-12-c9e248d685c1@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Nov 03, 2026 at 02:40:05PM -0700, James Hilliard wrote:
> Octeon uses the DesignWare receive-trigger mapping with a 64-byte FIFO,
> giving thresholds of 1, 16, 32 and 62 bytes. Its setup bypasses
> dw8250_setup_port(), so it does not install the common trigger callbacks.
> PORT_OCTEON also has no static trigger table, so rx_trig_bytes is not
> exposed.
> 
> Supply the fixed depth from platform data when firmware has not provided
> one and initialize the common trigger table before port registration.
> This makes rx_trig_bytes available while preserving the Octeon port type
> and register accessors.
> 
> Select DMA before filling in the default depth, as before when the 8250
> core supplied that default during registration. Thus the new trigger
> setup preserves which ports attach DMA and their existing burst sizes.

...

> +	if (!p->fifosize)
> +		p->fifosize = data->pdata->fifo_size;

In this case I would use ternary Elvis:

	p->fifosize = p->fifosize ?: data->pdata->fifo_size;

-- 
With Best Regards,
Andy Shevchenko


