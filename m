Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 547FF3E0255;
	Fri, 10 Jul 2026 08:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783671671; cv=none; b=OyVtwvYMSjEZyn0GRmz3aq4WpD+0TutH0DFcuPLogtmV7nEvNCwJsvAd7tDZ+K4gGAGS743DDfv0Qc9KPekLgXBJnnlliOU8YHv4gHWsOmxpU3Xc2GD8sYw6gON/pHu1QT2F3uPXfLpuIcMCuACKfvYAwW3AvPnU86kKeTaVlnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783671671; c=relaxed/simple;
	bh=pBrycRR6DWm1J7z2nRQaGxJWAsRmCbxjaFUKGUDaepE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JEnSMlxiUzy2kynk/XFMMiyCeyH5iACc3aMzwwm8fAEJPRHdleTdHNpP7Ui/8UVSnd90anlVsDdwbvRAwqh/xXP8TqSK3gUzhSspPFBROU4lq4byPp8n9jTldqtMrl42JPGa5QFd1DYu2byGkVRusBaPqYeojfb/m8XIBKQWH/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Nky/z5Z/; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Nky/z5Z/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783671670; x=1815207670;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pBrycRR6DWm1J7z2nRQaGxJWAsRmCbxjaFUKGUDaepE=;
  b=Nky/z5Z/kmmp0pchISAtl56rONTTb2sCRNrWSfxDY9mbQ1cUE/CaUxt2
   bUhWRuwewt1+KqEZ7PJrJej6M0qrlk0tbApmBpG8r28SxULqYBJe//ckZ
   0cy7Iax14UZI+VWSYb5HdWaEgf3YWsRGie1CwXJhDGIflOCkrSI25KUMX
   jjfKaKw7WqbHiKuY5ey7ptwb2zUuZnWgvfwxHJYUhifYDVskCp1gsJmsl
   Ilw/f12TH4ieqT1lzuwdj1CXZVCf9a8HLIDWsd7N5eegQ3w/pEC8Oac1O
   FQwtmip6S3q3rmZlbif83kjp1ZGtDsnYQNuQ6Qwjk0ClEbAw+2EkCNk37
   g==;
X-CSE-ConnectionGUID: KGFtGL0RQm6OAKey756qBg==
X-CSE-MsgGUID: pu/qCCSYR1KqKLuoa+A6Wg==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="88197535"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="88197535"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2026 01:20:55 -0700
X-CSE-ConnectionGUID: 7VSVUrYUQYqP2c81jnBTpw==
X-CSE-MsgGUID: tLeIWpBvR2203uq7ve0tgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="254328183"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.100])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2026 01:20:51 -0700
Date: Fri, 10 Jul 2026 11:20:48 +0300
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
Message-ID: <alCrYPnk-0FmDnqw@ashevche-desk.local>
References: <20260709205656.319531-1-ansuelsmth@gmail.com>
 <20260709205656.319531-3-ansuelsmth@gmail.com>
 <alAT4QMOi8U2ITho@ashevche-desk.local>
 <6a501516.a1b3dc3f.1e550b.96ea@mx.google.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a501516.a1b3dc3f.1e550b.96ea@mx.google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Jul 09, 2026 at 11:39:32PM +0200, Christian Marangi wrote:
> On Fri, Jul 10, 2026 at 12:35:02AM +0300, Andy Shevchenko wrote:
> > On Thu, Jul 09, 2026 at 10:56:50PM +0200, Christian Marangi wrote:
> > > Some driver might need to access the current baud rate to correctly
> > > configure it.
> > > 
> > > Export the serial8250_get_baud_rate() function to limit code duplication.
> > 
> > Why?
> > 
> > We have _get_divisor() / _set_divisor() for exactly that purpose, no?
> 
> I can only see set and I'm not following how that helps with any driver
> that needs to get the baud_rate?

You operate on the divisor settings instead of baud rate. Otherwise, can
you elaborate why no other (out of dozens!) driver needs this? What do
you try to achieve with the baud rate settings exactly?

-- 
With Best Regards,
Andy Shevchenko


