Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.17
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794265530;
	b=K+q3gFRJfVqKLmbPcIjYEg0qkpJGWVYozPPXlfA7CiwAINSzYP7CTz2zFAlYbWBtt69l
	 GLMC/JPpBWQn2J4+/xD3vJn1SssysX4i+sXIeEOXS7vfNRoj1ZGbsIZ6EwNEOTaG/rQIw
	 R0DyBEeFgbX59tvFWS1/05aSoJioP1SOwEHAJMZEmNzEJtyQncs5Asa6nP7mnGMYGrzCc
	 7jtQSiHcMkZ4nQt/dMH0PZC9fkRPKr18n35CdpbLF5EevTuEC163fBgJouVCNa2HdLTaY
	 WRFPUxc4ccfrQ49E5BuhfHHvSrqp/EkoYZEiW4LF++AdK6CuSi3YefyagIZs8kzLpCQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794265530;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=4FhdLPD0grYX+522WudA2QHSLtTJRmqNQOiiL/At1p0=;
	b=nZbN3JxnUtADvMLh5VQ8G6YablnR2ed5GUxCE1oaiHCMLGEjAg5U/CNkXrZZk0b3pDWs
	 684OwrYxZQ+Yc0FdEnn4u2mt8WwTwI9DPLWwtkzEFvWOJV88kmOaXjwoAQc7s7gWtii0j
	 SCSQJh7nLzgdUd/ClTTy1ysEAGjS3aBV5kCeg6ccW/zLJtvYTglPBVPMg8p30FYh9VhmW
	 CdPTnpDY+NUeWhsruABg/RsnTgTFEOzC9c9t1p3L33Xu0xd/Zpzs/FFDFCp5xza7YgpOD
	 /iyiaSRG8J2GH+1GTv9sgvpJN0SyNYWpmkKjttGzIhV1n4XXDETpI/G/LjZEXxUhZ3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=cDog95Vw;
	arc=none smtp.remote-ip=198.175.65.17
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1216606A321;
	Mon,  9 Nov 2026 23:05:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D1216606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=cDog95Vw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794265530; x=1825801530;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fA/YuYOZqr8nX95JQI9ayGBQbBahOSJO/lfwcBjsiT4=;
  b=cDog95VwMtwqTZNfRxKUH2i74IhEEGM0vN/T/6svPCn2qc3CFEZ1P2w6
   Ed8g+pa37ROwgiqavvWEUARqsQ3D+rYMk4uaDZyty8tWaxgEZ6e6iUiVb
   DbxKKQMOkbawPCLLeU5ok7cDAcMdBq9N2YhAHWxwPTELA2Bm3cTfPNkBv
   K5rsP5tNjp1Wgm60Tf62lH1hGDJvST5PDKRCJBCUzbhJfHyL/EZQAGUpG
   in1i8Vlv5S8znI6gXBFjTPiD8lYuCmZ2QAY/eS1OOpkutLlPGX5moqZiz
   MSVH+QsL41316pYSKWtFFWhD5iIJd2zoRKQFHlREgTw060+/LU1ntnHG2
   A==;
X-CSE-ConnectionGUID: NUEuXk9AT/2kg4UHPKzLZg==
X-CSE-MsgGUID: NpPTSRPDRy60frr9uzp8iQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11961"; a="3029789"
X-IronPort-AV: E=Sophos;i="6.27,204,1787036400"; 
   d="scan'208";a="3029789"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 15:05:29 -0800
X-CSE-ConnectionGUID: O1fhqldaSzi1N7PVHOdtOg==
X-CSE-MsgGUID: XivK/JkIRVmktnl1NeCaEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,204,1787036400"; 
   d="scan'208";a="9845093"
Received: from amilburn-desk.amilburn-desk (HELO localhost) ([10.245.244.144])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 15:05:24 -0800
Date: Tue, 10 Nov 2026 01:05:22 +0200
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
Subject: Re: [PATCH v8 01/11] serial: 8250_dw: allow port setup to report
 errors
Message-ID: <avJRsij5P7Ch3tqE@ashevche-desk.local>
References: <20261105-submit-h616-uart-fifo-v1-v8-0-14024d2b184b@gmail.com>
 <20261105-submit-h616-uart-fifo-v1-v8-1-14024d2b184b@gmail.com>
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
In-Reply-To: <20261105-submit-h616-uart-fifo-v1-v8-1-14024d2b184b@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Nov 05, 2026 at 01:52:02PM -0700, James Hilliard wrote:
> Return a status from dw8250_setup_port() and propagate failures through
> the DW and LPSS probe paths before registering the UART. Use the existing
> LPSS cleanup path to release board resources and IRQ vectors on failure.
> 
> Keep the current setup behavior by returning zero on both successful
> paths. This separates error propagation from the configuration validation
> that will use it.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
after addressing below piece.

...

> -	if (!data->skip_autocfg)
> -		dw8250_setup_port(p);
> +	if (!data->skip_autocfg) {
> +		err = dw8250_setup_port(p);
> +		if (err)
> +			return err;
> +	}

No, don't change it here, the return value will be simply ignored until the
change that will make use of it.

-- 
With Best Regards,
Andy Shevchenko


