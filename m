Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.13
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793706209;
	b=b/B5s59HZ4BrEnbQzT7W62JPndNjuJSWN0E7fmM+3YACj7Pye7ZS9rsz5Z/gN7VvX+ZF
	 3BFNXttcH2FkDL7pk0rxqEewp75hqi2mOKJfcJ758ITDEaYgB4H9IK4UWyr4n4NBMkenl
	 dTIfclIaOJYI4HBjRFeuu/yZsDA7X+aSNs/eWTP9cFCITtJSgsBgAs3GU2juV+SsvkEnA
	 08ui3Usns+N04DJHCWw8wVjZsZ5eoSPRJ+JCyKmdNtSP2RH3+PWAhX4HYI5LFULnGVh99
	 a3IEs4yBClTzQT0Vkk3OwqJwieqGoE2HudtF0TPwcxsU9tOiyHYZud7uNUuc6O0AObA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793706209;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=wNK5yE+IKNHGruns60ZbB24xYrrfVH266RRG8NSyk88=;
	b=sWwA81/SwS7gNGbjIwZHXYh+hNWVxWj7ie9jKCFqiQjALgZjeT0jS9pStRrQDiG6eshF
	 6pq4kAMP7bwIRGaHw822Z002qE304qupzf6aRQiwSQmdLFLNXzFtH5epOCNp6Kite2QZR
	 FpxDcNh3wkBZb2YRO2Okz04ZSONFNpwWDzHJw2US9iBdKlHyoOgunTlI1nr0ypRouLRuN
	 l9xjojGSxRnQy6qsQTWcdx9JdN31P7/Fd1AIbExDo5ZJ00pNGrhnBAmE/VF/UNIV1HqKU
	 UOoos87T4HK8vT9LkR4G0Z3YcL58q8ABzLvgIJZDYs3CzOcKoqko6t/a4SvtDgy9lHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=aAEEOYGb;
	arc=none smtp.remote-ip=198.175.65.13
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56236606D802;
	Tue,  3 Nov 2026 11:43:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 56236606D802
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=aAEEOYGb
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793706209; x=1825242209;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=R33tyjVH912C46YNAFlpD0lwhhatqNbKNycpwT/u6J4=;
  b=aAEEOYGbU30BV2lyfOht2ih5/h4vqg5XttNIeGCtgiPoNwYF1M9eIuvq
   rwQOvj9zi48pO4PQDaZ57hlbSyLOx6w9o7VluaLYWb/ZyNT08lwJxq02d
   YylDAWMyzDK9DOVRowrkI1yXfBWj3pGqltw1dEJDjZEP/ChXfy48DYWcd
   gygbYLS9ANwTpTvcwtoo1gxMQOy4/OtvILmZU40JcBJAjGdtiTWfBfKZE
   93RDJnhOjKQbTfvs0Q4Vfkjmag67dzOCd25aptHq5YTusXaR15otezDhT
   pqrQuQi719W/mJ/v5AsvnBnhAfJsv2jpSVshCjm7/WSvFdLEjJiUZGsbG
   g==;
X-CSE-ConnectionGUID: sVc7Rl0eS06+mMF+YTsw0Q==
X-CSE-MsgGUID: xvMzu2ATTOCXpLrqW8+wmA==
X-IronPort-AV: E=McAfee;i="6800,10657,11954"; a="2303793"
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="2303793"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 03:43:28 -0800
X-CSE-ConnectionGUID: 07rTJIgmQNOYDJMCTvmoWA==
X-CSE-MsgGUID: FLQemTavQVC7wR+jV2LW6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="6308772"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 03:43:24 -0800
Date: Tue, 3 Nov 2026 13:43:22 +0200
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
Subject: Re: [PATCH v6 1/8] serial: 8250_dw: select port setup through
 platform data
Message-ID: <aunI2triZPyB3_Dv@ashevche-desk.local>
References: <20261102-submit-h616-uart-fifo-v1-v6-0-25afcb346b0c@gmail.com>
 <20261102-submit-h616-uart-fifo-v1-v6-1-25afcb346b0c@gmail.com>
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
In-Reply-To: <20261102-submit-h616-uart-fifo-v1-v6-1-25afcb346b0c@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Nov 02, 2026 at 12:55:16PM -0700, James Hilliard wrote:
> Select feature discovery and DMA attachment through a platform-data setup
> callback. The generic callback probes the optional registers and attaches
> DMA when a FIFO size is available. Integrations with a fixed configuration
> can supply their own setup before the port is registered. Allow setup to
> return an error so integrations can reject invalid configuration before
> registration.
> 
> Replace skip_autocfg with the Octeon setup selection. Octeon is a 64-bit
> platform and continues to skip optional-register probing while retaining
> its DMA setup. Select the DMA setup helper directly for this integration.
> Keep generic setup for devices without matched platform data as well.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko


