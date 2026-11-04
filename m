Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.17
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793788928;
	b=iE5pyow/h1eyacWxYSghEEyRoIDdxpcNykbLwjxdy2bOUTnO5ZcPSfXjH0sDhPgdikna
	 tzY5uKwEcqwnjfyLR77e/sGHkU2lu65TXMsIYIJtALKIOdFidhzL5E+Kgghvp747tv3A9
	 SX6yZwfXed9HyFwNdRw8a2FuIhAl/VKyW5eyOxOhXfEa4c+KRI+32SiOrf1nbv7w4ae/t
	 I4aEQ1DFiq0NTzrhTc159a0Wdw330tHD7t5b0qSVReiRAUR6IpyrK2Ew/xKpmP7AYQAO4
	 K/PxsS2bw0Irns8VuODzPe8dT69DNEWtVqqNObT9mzZ0hLnEGoJQPbgW3DHIir5foxA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793788928;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=CS0Bcd+TO/Jxci+J+a3T0fIVilgOspvq26vn586Zfs0=;
	b=o0KfL8QiZDC44Xb0ZQahGofhOswWerbfgofDHNOHbJoWN7A7sI4S75YbmjQkqxU5t4U4
	 GduxOHM2091mXz/MI1IoJ51cTMKhLBsUwkNCu/dazZxMXrftgzT+XFsdBQhDKAI7Theju
	 4dlg7GZjtB4okK9XsASk5RZ71M2G+5DQq85FJbR+uEtP9dKt6PtEIpKZ1GUiN4KIgPirr
	 Rpz4sDlomBS5N0BLFlpxWa1m9k2sKwLc3tc7WfwMRAhKG8XfPl3vEeGdxhNpQNAuBQXtU
	 2zjleP10c15pE3cD0cE768sBTmlf+lEPKbf0BytTzlyq8LOeqbZGGr4Oy9+lMefMjIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=hvIoOA8Z;
	arc=none smtp.remote-ip=198.175.65.17
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6395E606A31B;
	Wed,  4 Nov 2026 10:42:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6395E606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=hvIoOA8Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793788927; x=1825324927;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=marU6W5CSY6FdRX0Caihl7DYJeuF2MxHXBp7DfI9PNQ=;
  b=hvIoOA8ZHdycdc4tlC4lkAfWn6Wo/6wP2LMdVoXPXZD5GJD4QJsRv8+3
   VaQoa93XDlnl7sk5QfqpY0MMmrMKj9UhIWG9yTA20DJNkm6YAI98pW04U
   bhSX/qvGQRRvsz3Tlq2zqqAaKnoI7FiodKYOGEr3u+udLRcckYVbD426l
   FMsfhijBZ/TjERNzEIZ/Cyc9/Br8nTQSxXiOVCawOqwDTiWqgz9fDu6uW
   5kRWDfHiF1bTx2R2FrHum2zRBpFV3IDSouv66mXLnTc7GOQodHoB0BEmI
   /ndH7uGYlH1HpBj3ku4YRghy29uyQjJgm4ckt4z+cY8oPo6eS8nXgWMm8
   g==;
X-CSE-ConnectionGUID: AYEzO9UgRWu8Zl0fxzYQbA==
X-CSE-MsgGUID: XezJaS1FSkOnsyz2lK2swA==
X-IronPort-AV: E=McAfee;i="6800,10657,11955"; a="2556092"
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="2556092"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2026 02:42:07 -0800
X-CSE-ConnectionGUID: EXafsRbiQzKK3mjg7li3Kg==
X-CSE-MsgGUID: D9BJfz7fQWKrrIZWPtZy0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="6544549"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.24])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2026 02:42:03 -0800
Date: Wed, 4 Nov 2026 12:42:01 +0200
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
Subject: Re: [PATCH v7 07/12] serial: 8250_dw: configure the Allwinner H616
 UART
Message-ID: <ausL-fBU1vAgZzm3@ashevche-desk.local>
References: <20261103-submit-h616-uart-fifo-v1-v7-0-c9e248d685c1@gmail.com>
 <20261103-submit-h616-uart-fifo-v1-v7-7-c9e248d685c1@gmail.com>
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
In-Reply-To: <20261103-submit-h616-uart-fifo-v1-v7-7-c9e248d685c1@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Nov 03, 2026 at 02:40:00PM -0700, James Hilliard wrote:
> H616 has 256-byte transmit and receive FIFOs, but its optional DesignWare
> component parameter register reads as zero. Generic 16550 probing leaves
> the port using the 16-byte FIFO configuration and its trigger-level table.
> 
> Keep PORT_16550A and supply the fixed FIFO depth through platform data.
> The 8250 core derives the transmit load from that depth. Use the shared
> DesignWare receive-trigger setup to describe the 1, 64, 128 and 254-byte
> thresholds, with the normal half-full FCR setting selecting 128 bytes.
> 
> Advertise automatic flow control so CRTSCTS enables MCR.AFCE, matching the
> DesignWare termios path for hardware CTS handling.
> 
> Select this configuration through the platform setup callback. H616
> has debug-divisor and RS485 control registers overlapping the optional
> DesignWare feature probes. Use the fixed configuration with BUSY-safe
> integer divisor programming and software RS485 handling.
> 
> Keep the UART clock enabled during termios changes with SKIP_SET_RATE.
> Its clock is a gate on the shared APB2 source rather than an independent
> baud-rate generator.

LGTM now,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko


