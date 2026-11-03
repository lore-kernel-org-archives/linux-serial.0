Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793706371;
	b=Kf4Ev7a7iaCbWmFX+376oILUiw32so32TMxSfS9hWHSMu+/4wXZbRpyKDLakRZ6OYZWA
	 gFJv/i+C3B0N9Uh6Z7LXH2VxPhQJOLHtbRaQEgk+WHQgi8gzPQS3a4HTfxeuwlknQ2inw
	 qqmbYYdMgSmWJg2eiM/kx7Ag0yTxpzpyDAp1W5IdtzFkrg+vGbBjrG+92dA4RUwzvQCU7
	 PSxidXabGWVjhWIOmrg6fTH0yIObxVPJSTSzASn2qgKCTXBCWi/iLb9Qg6e+/6xlZnvAa
	 eGyUpVceHVAITqcZZvSqJZ3zGGeML9xTMuQYX7PIJVLnnTGHYkEAi08NgPUKPgRd8Xg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793706371;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=zRXqrOpqPdyVMxadAbJbOQp1pF8T1j8qh7t5p4OQo+c=;
	b=Jjhc/A+W2jDZmjm1+5xWY3tefdPMQVdSHrFSDyal2ApQByGC7Eqoq1pTqpWbZlVZGa30
	 VEpuN7Spr3zw7zCdbGTH5/6Lx170jnV8I9mOdapvUyL4Oc/pyE4cLy5mbp5zXF2+2q975
	 JDhnJyIDg4L4axGgkuL4lEnfcqs1F2dW4wlnoxhnV6bhtKGN5m/PvHyfM5DyiYpwFGvWt
	 Xw55cfuhtCBD6+BLwk9uqxoXuznYnvRVrpxBSiTsaEKf3MsUWENXSarftxOANgpxXWouv
	 qUMAvnhMBSWvVi4kjV25LFuWrYdxpaxe1minpqe4kHbdGxnB6NhJI4xYiC6/2x/+JkQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=AhfGHXuB;
	arc=none smtp.remote-ip=198.175.65.11
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1921606A33B;
	Tue,  3 Nov 2026 11:46:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C1921606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=AhfGHXuB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793706371; x=1825242371;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=k34J5bk1+MbWLLiN/cBv7+iaC1FJgNw6KnASGpx22VU=;
  b=AhfGHXuBASUCsFOab01Sha8XssuHLx//1MzS+LmdGqZmfYdyN/VuXqNf
   2mBzDT7SQnS0LVyiVUh4NYmAGuGUFWpvbJbvooY5h9G/x9ZMJcWmq6Mxf
   jtY8ilphIKpa4N7/mbXvp9LZmjeV7ZTD/bqn0jvx6vaSzD5FQTCkvCI3o
   8WY4AIe1nqVrJzuBnGpeRgqy3/Ktngem29IyHrmooNGqDYJ4NVVK8b00G
   HJ7AizWIoC9o2hdlPvZlDzfMWK2y5HyrIfhaEVYonOwqbevC7L7fqsILo
   eKM5Fw1qLJ2GkT6ZjWNvRyYp9Oeb4gSvI1nRlX4Ahc85MA0mDkh1ZMePC
   A==;
X-CSE-ConnectionGUID: YcHudSiDTI6GUMIO5/D/Aw==
X-CSE-MsgGUID: j9e2YDKsRIaqA8/+Al69NQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11954"; a="2306705"
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="2306705"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 03:46:10 -0800
X-CSE-ConnectionGUID: +50rtPemS3qs1F87pbe9vA==
X-CSE-MsgGUID: 5a1QMZAXRhCgk3MDdtV4fg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="6494861"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 03:46:07 -0800
Date: Tue, 3 Nov 2026 13:46:04 +0200
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
Subject: Re: [PATCH v6 2/8] serial: 8250: share the RX trigger conversion
 helper
Message-ID: <aunJfAPQMuiiH2N1@ashevche-desk.local>
References: <20261102-submit-h616-uart-fifo-v1-v6-0-25afcb346b0c@gmail.com>
 <20261102-submit-h616-uart-fifo-v1-v6-2-25afcb346b0c@gmail.com>
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
In-Reply-To: <20261102-submit-h616-uart-fifo-v1-v6-2-25afcb346b0c@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Nov 02, 2026 at 12:55:17PM -0700, James Hilliard wrote:
> Drivers can supply receive-trigger thresholds through the RX trigger
> callbacks without adding a legacy port type to uart_config[]. Extract the
> threshold search into serial8250_bytes_to_fcr() so those drivers can use
> the same conversion as the generic 8250 implementation.
> 
> Keep the implementation in 8250_port.c and export it in the SERIAL_8250
> namespace. Include the unsupported-table check and preserve the existing
> nearest-lower selection and highest-encoding fallback.

...

> -static int bytes_to_fcr_rxtrig(struct uart_8250_port *up, unsigned char bytes)
> +int serial8250_bytes_to_fcr(const unsigned char *rxtrig_bytes, unsigned char bytes)
>  {
> -	const struct serial8250_config *conf_type = &uart_config[up->port.type];
> -	int i;
> -
> -	if (!conf_type->rxtrig_bytes[UART_FCR_R_TRIG_BITS(UART_FCR_R_TRIG_00)])
> +	if (!rxtrig_bytes[UART_FCR_R_TRIG_BITS(UART_FCR_R_TRIG_00)])
>  		return -EOPNOTSUPP;
>  
> -	for (i = 1; i < UART_FCR_R_TRIG_MAX_STATE; i++) {
> -		if (bytes < conf_type->rxtrig_bytes[i])
> +	for (unsigned int i = 1; i < UART_FCR_R_TRIG_MAX_STATE; i++) {
> +		if (bytes < rxtrig_bytes[i])
>  			/* Use the nearest lower value */
> -			return (--i) << UART_FCR_R_TRIG_SHIFT;
> +			return (i - 1) << UART_FCR_R_TRIG_SHIFT;
>  	}

Strictly speaking cosmetics should go into a separate patch (for-loop iterator
locality, (--i) morph).

>  	return UART_FCR_R_TRIG_11;
>  }

-- 
With Best Regards,
Andy Shevchenko


