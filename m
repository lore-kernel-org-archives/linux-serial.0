Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C330189904;
	Mon, 26 Aug 2024 17:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724694014; cv=none; b=GsfC1JnuGjiQRWaUZ4io0QZenLbtv8U7XtfPOWaVdCiLGilJi+ix65tSrkqeDSdb+KRGJTAVPX2kDcXn6w0P5qQHUFuIh3qwd9uSn9oulPAl9PcmMe8/YsPWIVSVJsEP6Zmq4DCA3ylP9Gu7VPmrqd9CsFfFpceGmzGZmxLJznQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724694014; c=relaxed/simple;
	bh=gwT6Ot10uOyvXraU6Qq6T/jgc+QSEpqw4P7mEwczYn0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r/HpR+FtVPXIcE1wPf763H14ajRji2TxKrHadB6xxvpokpvdqHbM5KR08+JS7278K7qC8n0zuNxcBi6k2nCNzCpt6O+2EkqateVo94J5LK9kFDIxRHDomxeqRFC3jsQ/J0/rtlTTQTJh0PLM/qTe3Bg8/cSVBiUxkONezop6hFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: KFYrbepxTVe8uo/oAiY//A==
X-CSE-MsgGUID: UkNyfGasSXW+d1Ak45wOiA==
X-IronPort-AV: E=McAfee;i="6700,10204,11176"; a="27017228"
X-IronPort-AV: E=Sophos;i="6.10,178,1719903600"; 
   d="scan'208";a="27017228"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2024 10:40:13 -0700
X-CSE-ConnectionGUID: G3LKR41ySiKW0wWVGeQ7kQ==
X-CSE-MsgGUID: 0SrGY5CwTPunxvDqSNJ8sQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,178,1719903600"; 
   d="scan'208";a="66922061"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2024 10:40:10 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andy@kernel.org>)
	id 1sidhH-000000021k5-3gDS;
	Mon, 26 Aug 2024 20:40:07 +0300
Date: Mon, 26 Aug 2024 20:40:07 +0300
From: Andy Shevchenko <andy@kernel.org>
To: Lech Perczak <lech.perczak@camlingroup.com>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Krzysztof =?utf-8?Q?Drobi=C5=84ski?= <k.drobinski@camlintechnologies.com>,
	Pawel Lenkow <p.lenkow@camlintechnologies.com>,
	Kirill Yatsenko <kirill.yatsenko@camlingroup.com>
Subject: Re: [PATCH v4 0/3] serial: sc16is7xx: cosmetic cleanup
Message-ID: <Zsy998mgOAyJa2xn@smile.fi.intel.com>
References: <9c1f8fd4-a2a5-4f92-9e86-2cf0103b1908@camlingroup.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9c1f8fd4-a2a5-4f92-9e86-2cf0103b1908@camlingroup.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Aug 26, 2024 at 05:40:28PM +0200, Lech Perczak wrote:
> When submitting previous, functional fixes, Tomasz Moń omitted those
> two cosmetic patches, that kept lurking in our company tree - likely
> by oversight. Let's submit them.

Reviewed-by: Andy Shevchenko <andy@kernel.org>

I haven't looked into the details of the changes, but feels good.
What you can do to confirm is to run this via C preprocessor and
show the diff here or assure that it's empty.

-- 
With Best Regards,
Andy Shevchenko


