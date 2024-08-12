Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B881804F
	for <linux-serial@vger.kernel.org>; Mon, 12 Aug 2024 17:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723482488; cv=none; b=P7aIJ/zhQNpEjI+CdB9hrn0dQ6iK5HxtVKnaZaJUlSBgkQofeY7p9pQsxJFJpcbASEOAB2I8v/by8CykKNwKocMsYZZnjKEejpIlcQgjf/wb6cHGufY+TpjxRv7qAk7O3HwndciZYstoeSwclwc73J9FR5wgnV4oqlg4D1w0kVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723482488; c=relaxed/simple;
	bh=hjPBP5urSlJXYsn9NpLGl2AlP7f+7wnnNLfXhodHPb4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EeRWS+pitEm+5i9kZALimcRDFNFLtoktgbvNlaAsh41aDWQViSk3D79bHY63RWhKLi234pPli31nF+oHRDa8RtzKM5DDK2iALN9c1NZlM7aXK4UAF/dgwIWzRkkJfIIQ3NipFaBHJc9l33CHztp9DpWEAeVjHfPz7Ni7IYk4b/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: kd5vMTGfR8euv7rBczza5Q==
X-CSE-MsgGUID: 42KOMieVSJWe8aPhpPLvjQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11162"; a="47009129"
X-IronPort-AV: E=Sophos;i="6.09,283,1716274800"; 
   d="scan'208";a="47009129"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2024 10:08:06 -0700
X-CSE-ConnectionGUID: bLH1gl09QuW5GS/QYyYw+A==
X-CSE-MsgGUID: q3yyFBAjSvqFu+U/KxI0sg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,283,1716274800"; 
   d="scan'208";a="59041247"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2024 10:08:04 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andy@kernel.org>)
	id 1sdYWX-0000000EQIP-0kAk;
	Mon, 12 Aug 2024 20:08:01 +0300
Date: Mon, 12 Aug 2024 20:08:00 +0300
From: Andy Shevchenko <andy@kernel.org>
To: Lech Perczak <lech.perczak@camlingroup.com>
Cc: linux-serial@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Krzysztof =?utf-8?Q?Drobi=C5=84ski?= <k.drobinski@camlintechnologies.com>,
	Pawel Lenkow <p.lenkow@camlintechnologies.com>,
	Kirill Yatsenko <kirill.yatsenko@camlingroup.com>
Subject: Re: [PATCH v2 3/3] serial: sc16is7xx: convert bitmask definitions to
 use BIT macro
Message-ID: <ZrpBcEVOM78RXQnl@smile.fi.intel.com>
References: <16b7bff3-71ec-4042-a9a8-755f32b85716@camlingroup.com>
 <8cfa1c75-03f8-4071-b277-752006b576ac@camlingroup.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8cfa1c75-03f8-4071-b277-752006b576ac@camlingroup.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Aug 12, 2024 at 06:56:53PM +0200, Lech Perczak wrote:
> Now that bit definition comments were cleaned up, convert bitmask
> definitions to use BIT macro for clarity.

In the Subject and here: BIT()

...

>  #define SC16IS7XX_IIR_ID_MASK		0x3e     /* Mask for the interrupt ID */

While at it, why not convert the MASK(s) to use GENMASK()?
It's logically coupled change, no need to have a separate patch.

...

>  #define SC16IS7XX_LSR_BRK_ERROR_MASK	0x1E     /* BI, FE, PE, OE bits */

Ditto.

(maybe more that are not visible in the context of this patch)

-- 
With Best Regards,
Andy Shevchenko


