Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D61E3C277E;
	Fri, 10 Jul 2026 10:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783678163; cv=none; b=osZo2pCFwdVTwPrhZSljVG7gTxBc7mrykO3PAPPwP2g0kJF/jWukXQKEfXZsyfK94PBZ9XrvrpEQwzM65FIiEDm/kEo3hzlcAiqsXkOTz+wXUomCm2wrZzAtj3mE09bLTCBrsKHXBKxAtmAtLVoingX7DHxjdf1zpL22oku4v3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783678163; c=relaxed/simple;
	bh=XR/AKWm9S/bmj9R9xWPMyTJeT0hkkYbgIdFX+BFmVaU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZyZGBrSiGoUzwk/f6q4vw8Jf19bvk8q4d2lbp15u/46nd7EUe+iF8FBu8VeHtG5FqRZgLyRspJSxUD48IkeKgnsJeApUc6yeDfIwEx3eLlgI+GihepeTSR/lZ0DOJ2Vk6WTKqV4jvt3NEL1JvotnfiGxhZALPzF63TvOR+6cWXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VMM2JGq/; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VMM2JGq/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783678162; x=1815214162;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XR/AKWm9S/bmj9R9xWPMyTJeT0hkkYbgIdFX+BFmVaU=;
  b=VMM2JGq/nhc5yOiOzHQCg5NdeBW3khGvnk+GHNX57ngiMStO65qQSUSQ
   he28S/3lUF+9NzlhhetvN3DmegYdDIewrwlSdYO9+nh/Tn29zIlFbwjC1
   ebp0RJL3zMLzcHQbGCSyYPio4uNP0rqrvJGntxbgwb6lDimQE24KRoozq
   97uFN681m8hc90aUP6gPOfrZBG0eHw3PCmMrZSoW5RvgdZEc406RMFnO2
   JA3oIoQURUHeu4AbAZvmiLG7rljKvu9NGHSS5k6/Ohsj8RDiHA0WzMpPt
   i6Evv43507G9+bKJy30epAKjfcJIt5D8GsOBTZiA9ewrS03Yq/FuZZX/J
   A==;
X-CSE-ConnectionGUID: tlvP+TnwTeq2iLsWXkrnlQ==
X-CSE-MsgGUID: dTSOxMTsR3OWc31Kyxjs3A==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="109921648"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="109921648"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2026 03:09:20 -0700
X-CSE-ConnectionGUID: lssv4d2ET0CBZjyOXT6OfA==
X-CSE-MsgGUID: AUwfa79ARf6ngIC2ZTogHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="279256841"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.100])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2026 03:09:14 -0700
Date: Fri, 10 Jul 2026 13:09:11 +0300
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
Subject: Re: [PATCH 3/4] serial: 8250: map UAPI port type to internal enum
Message-ID: <alDExy46n55IVHeN@ashevche-desk.local>
References: <20260709205656.319531-1-ansuelsmth@gmail.com>
 <20260709205656.319531-4-ansuelsmth@gmail.com>
 <alAUrANx15gyOgdZ@ashevche-desk.local>
 <6a50169d.41a38e5f.1bb169.a6d5@mx.google.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a50169d.41a38e5f.1bb169.a6d5@mx.google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Jul 09, 2026 at 11:46:02PM +0200, Christian Marangi wrote:
> On Fri, Jul 10, 2026 at 12:37:48AM +0300, Andy Shevchenko wrote:
> > On Thu, Jul 09, 2026 at 10:56:51PM +0200, Christian Marangi wrote:
> > > There is currently some confusion when a new 8250 UART device needs to be
> > > defined with the related index for uart_config[] to be directly defined in
> > > UAPI header.
> > > 
> > > There isn't any specific reason to define the index directly in UAPI header
> > > unless it's also needed to be defined for userspace usage.
> > > 
> > > To try to address this confusion and making it clear how these specific
> > > index should be defined and where, create a dedicated enum in 8250.h
> > > with all the current defined values in UAPI header and document how these
> > > id should be defined.
> > > 
> > > Rename the define in 8250_port.c with the new UART_ prefix.
> > 
> > This will bring a wide field for the all possible conflicts and doesn't really
> > solve the issue. Why not simply kill the UAPI part of the definitions for good?
> > (Move the all, except the first 13) to be internal to the kernel.
> 
> I mean... With correct review from maintainers, conflict won't happen. I don't
> feel it's that easy to kill UAPI header... userspace stuff and we don't
> kill userspace.
> 
> The previous suggested solution was to stop declaring stuff in UAPI header
> and start declaring in the internal header making the situation even worse
> and error prone with id conflict. This can really be prevent only by
> correct review of the change. (or keep using UAPI)
> 
> Maybe other have better ideas on this. On net we have a similar problem and
> the implementation is mostly similar with duplicated reference and some
> BUILD_BUG magic.

The whole point of UAPI list of the supported types of the ports is busted from
the very first case when we start re-using gaps. Meaning that if there is any
current userspace software that relies on that information, it's already in a mess
state. There is a Debian source code browser, you can check how many programs
use that list for something real (behind the assigning types to the unknown ports).
I believe none. And the assigning unknown port should not be considered valuable
these days as we expect to have kernel drivers for most of the modern HW.
That's why I just recommend to find a great common denominator and leave only
those (and I think this split is exactly between the files in UAPI) in UAPI
and hide the rest completely from the user space. Yes, big change on paper,
but with 99.99% probability no functional change at all at the end of the day.

Submit and RFC patch.


-- 
With Best Regards,
Andy Shevchenko


