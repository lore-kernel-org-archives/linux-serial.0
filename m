Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794307567;
	b=DBEvkXXZYIREPDopw5Tn3Hk73iOVfDIzELhV1fvjvIFQLMJ6CM/Eezz+TFglNVB1hwpT
	 DRDF2qNnyrFSt6osZEEboGD7Tni0O5bGC7XV8LQKHx9zoTwVXuXIMqYe3/KvJDdaNsde0
	 I7PbZck2wd2Fts7J9uSjtIuO0oiM8+NLMjfCcx7rUHo0hDzwPstviw9esXaSXvZuh0X9R
	 qI0VQ231mKnSgohRU/zLFDOgMyWUg5cxoIPSISc+1rd1xpaBmETHM8MdfXZ5w/dgRj5S+
	 eroOaMo1li5v6KR5YC6crPyWJKPyXxP0GwKxuBj7XnB4Uy2n71IbMxZ0K3Gv2EydXJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794307567;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To:
	 Organization;
	bh=tNxEQju2LcZIyxz7a4fO9kHpfCTH3NncFJlSbex+Jnw=;
	b=MdJJTuVMS50tMeqNw1678XbW/xV+S2EADx6moIOfeVIMLn9vpg+CWNe47OVWOgooyMXT
	 +z9cXVBppBWRHmdAUQ4s3+8oSqVsa9Q846yjPnZ3t40skdG3nQo7gEMAV/AvbdN4C+x9N
	 dx+sjDtUL5sIKHbKJvi18CL5HmoO85HIzUnTbQShaUUelmcCDkDC/9wztuFns1Zz8va3y
	 yWe8agbfq5R3N7QtCKl2BtLsjMAzM8CV2TfU/kka7+RQIbaIcks7L3530dLZpW7WLd6i1
	 Fmvto6cw2NTdst6ymtODcQShYVg6LeIQNXirps022DEjw/FZ/aJ+HS1ALCvKgeJraUA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=da8bzCYn;
	arc=none smtp.remote-ip=192.198.163.11
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33BB7606A325;
	Tue, 10 Nov 2026 10:46:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 33BB7606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=da8bzCYn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794307566; x=1825843566;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=FOTnvyPMVWU/3v7yqUSpO+cSeARwquhqeXdYqmJpiGA=;
  b=da8bzCYnQIz6Qyuf7wd59MtewXMLLfWGS/7//AL/gt0Inm1QLhZqwI1t
   SALS5dpVGQteV2br+dB/Oeerat7tLvXL1mpLUQ8RIElMXqJxr7naVlD8B
   LAzr1nA/TNY885XHbfQqlVn7D7pxhBE/tUIQq8w+65Q7BNvKNO7NqeWzK
   F+iOKsJ1+BX0ahJ/rs5o+j4vL86dh/n8eSjPlsYM1dkcj6F47Shefe7OG
   ChFm5qrAOl66jnrWM6jKWsEl2hDoadflUJtoURNJjwqhhqfv3FXm1KDsx
   Jz71llANFLlTYRzUXeQ4Fhpgj2qz8dAst/keMveL6wPewCndMrHUpLUHc
   A==;
X-CSE-ConnectionGUID: 7BG+rXpMQjW5J2BQsgIrnA==
X-CSE-MsgGUID: bNvcvMKoQYmVgKJrfq47/A==
X-IronPort-AV: E=McAfee;i="6800,10657,11961"; a="2967249"
X-IronPort-AV: E=Sophos;i="6.27,205,1787036400"; 
   d="scan'208";a="2967249"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2026 02:46:05 -0800
X-CSE-ConnectionGUID: 7AaCaPv6Rdqyr1iheOqhVw==
X-CSE-MsgGUID: BWqKdvW+TAuUWnqaGHQ7CA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,205,1787036400"; 
   d="scan'208";a="8419291"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.244])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2026 02:46:02 -0800
Date: Tue, 10 Nov 2026 12:45:59 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: =?utf-8?B?S3J5xaF0b2YgxIxlcm7DvQ==?= <cleverline1mc@gmail.com>
Cc: James Hilliard <james.hilliard1@gmail.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: Re: [PATCH v8 00/11] serial: 8250_dw: share RX trigger setup and
 describe Allwinner UARTs
Message-ID: <avL1521B9qlNh8iO@ashevche-desk.local>
References: <20261105-submit-h616-uart-fifo-v1-v8-0-14024d2b184b@gmail.com>
 <873c22a2-fd3f-4927-a06f-16a73c30de86@gmail.com>
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <873c22a2-fd3f-4927-a06f-16a73c30de86@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Nov 10, 2026 at 10:54:40AM +0100, Kryštof Černý wrote:
> > Based on tty-next at 6628e7d4c6b2 with the posted RX trigger callback-lifetime
> > fix [0] and DW BUSY-safe divisor fix v4 [1]. Platform setup runs before
> > installing the BUSY-safe divisor setter.
> > 
> > [0] https://lore.kernel.org/r/20261024-submit-serial-8250-rxtrig-lifetime-v1-v1-1-731b78d5003d@gmail.com
> > [1] https://lore.kernel.org/r/20261027-submit-serial-8250-dw-divisor-v1-v4-1-41714a75e15a@gmail.com
> Hello,
> thanks for the work, I wanted to upstream my changes [0], but got redirected
> here instead. This fixes the issues I have had in a better way.
> I have tested the whole series, so I reply to the cover letter, didn't make
> sense to me to reply to all messages with tested by, but I am not sure if
> that is the right way.

You are doing fine, thanks!

> Tested on Unipi G110 controllers (Rockchip RK3328, CPR-described
> 64-byte FIFOs, ttyS1 and ttyS2) on top of tty-next 6628e7d4c6b2 with
> the two prerequisites. rx_trig_bytes now reports 32 instead of 8 by
> default, and 1/16/32/62 select the matching hardware levels, checked by
> chunk sizes in internal loopback and over a real RS-485 bus between the
> two ports at 9600 and 115200 baud. Changing the level mid-transfer
> kept all data, and the level survives termios changes and is kept when
> set while the port is closed.
> 
> Tested-by: Kryštof Černý <cleverline1mc@gmail.com> # RK3328
> 
> [0] https://lore.kernel.org/all/20261109-8250-select-u6-64bit-v1-0-04bc8332fa34@gmail.com/

-- 
With Best Regards,
Andy Shevchenko


