Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.7
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794260058;
	b=FEoKpscCVvhUbIxSR0NidBv2rdau9aKGGBtI+iYq7OWSF//kfw6zwsHaZEOyliV88aAN
	 2bAt7E1pY9DvDTcPzDrFh2bSxpPEaiuKLCIzNNZdPfZBJHSOCJGYBHWSBwRQBNazhkKTr
	 GMVOcNqjFl+LptOqcWuU5RuPvyn/1Os7DuK7tbIC5IR5KLzTHakKSnyLQ8a2TUpcUfPp2
	 Hp6I6VWOeXKzIQxYPwdNy0Nojh/LDqoAEkA7eXVljlrlOxxh3kWFy+V/wRvDlVqVxeIak
	 8SMadrPijzWGEOjmvvCgVrLXg9FAP6qunpL3x8/UQ+3X8ycvcidf3pL+uGGdS8Z/x/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794260058;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To:
	 Organization;
	bh=QfByDf2RsTrjJm0CVgpMKp92gWvQsy/fjtZd4c4Rb3Q=;
	b=ht/B8RdPqohOi6tr1+USrGzrY9EXBBpyOS9C2OjgTjNX23tYL+MxYtwFceeVAd1sc3kp
	 e0W4ts4/cfACPyqdLPduRMOHnBKBmMQK+pn3rE7dHvtrYvo6sIKb3xz+kHFK2lQbV3ZNg
	 i5+HsovTAkkh8n8Pm7vkVqHpjT1s9/TWdo0FAdfMJWcLT+nEv1OlenxgAWuLQzUPLYHLK
	 ibmRWlFqZ90g9/rhBgtP8kZ8LKWgdUbaJfDcSAg7/DnYyNAopkWfvApH48CX3jv/17Nn0
	 v7u4Shen3A3ei27MFfLn+M5ORr93rtvHXo3pG9qw6IHhwNO2SYPBtP3iGRAfNK/HvTg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=HYwbvL3F;
	arc=none smtp.remote-ip=192.198.163.7
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51750606A31C;
	Mon,  9 Nov 2026 21:34:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 51750606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=HYwbvL3F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794260057; x=1825796057;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=+H0fI5ElDVnQFoWv0tS3BdagyzkHK3qkCKRp0pDVItU=;
  b=HYwbvL3F8yzOJmAZww7ZZDfiCzUP0lIysyy7+FRewWjuCoAylievgn66
   8JDYL/fVSyLdr/nzXIpM+Bp0lh9Y5ByLAE2wIJFSX/LUGBszNMW55qPyu
   3JxeNTZCl6HWj4F8SM/av4jZPZ5rdhSGU8H1/p4i7OI+x2RQ9FqufEwB3
   YoG16VAKTif470g8qV4gPmhdlHP+zVn9XJQT4uc5hiCaD2HGsNWD1km8N
   Vd6oiMXqTmLWh9IoZ/s+fkp4s3g54crNtnGRX98y6VSYxEhyu07hyDjcA
   MJVVwEZxQZdyM83flSKDgOf73p/sCvs4RnHVv4vdhx5+ZtsKjTrbQTZ+4
   g==;
X-CSE-ConnectionGUID: eYbZW75AQGmAU2hCdOHesA==
X-CSE-MsgGUID: +Bqc9mrqQ1m8DkD4bmZy6Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11961"; a="2863213"
X-IronPort-AV: E=Sophos;i="6.27,204,1787036400"; 
   d="scan'208";a="2863213"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 13:34:16 -0800
X-CSE-ConnectionGUID: vmPDcpCiQWWqL9I9M0mIrw==
X-CSE-MsgGUID: qQnXhozBSuaUZeRIYgxPPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,204,1787036400"; 
   d="scan'208";a="7966257"
Received: from amilburn-desk.amilburn-desk (HELO localhost) ([10.245.244.144])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 13:34:14 -0800
Date: Mon, 9 Nov 2026 23:34:12 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: =?utf-8?B?S3J5xaF0b2YgxIxlcm7DvQ==?= <cleverline1mc@gmail.com>
Cc: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-serial <linux-serial@vger.kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	Miroslav Ondra <ondra@faster.cz>
Subject: Re: [PATCH 1/2] serial: 8250: Add RX trigger levels for U6_16550A
Message-ID: <avI8VFpnwlK7eadS@ashevche-desk.local>
References: <20261109-8250-select-u6-64bit-v1-0-04bc8332fa34@gmail.com>
 <20261109-8250-select-u6-64bit-v1-1-04bc8332fa34@gmail.com>
 <469362ef-f0c5-45f2-746a-b4a3c51876a4@linux.intel.com>
 <800f8d42-e35d-47ec-bbe6-e437a86d6e70@gmail.com>
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
In-Reply-To: <800f8d42-e35d-47ec-bbe6-e437a86d6e70@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Nov 09, 2026 at 04:37:43PM +0100, Kryštof Černý wrote:
> > On Mon, 9 Nov 2026, Kryštof Černý via B4 Relay wrote:

...

> > Reusing U6 entry for DW UARTs seems misleading.
> > 
> > We've better mechanism coming up for defining rxtrig in a one pending
> > series so this constant friction with the uart config types can be put
> > into rest.
> > 
> > Please build on top of that other series and help in testing and reviewing
> > it.
> 
> Thanks for the information, I started the work about a month ago
> and not sure if the patch existed before. I will test the other series on my
> hardware. I like that approach more.

+1 to what Ilpo said. Please, make a joint effort with that patch series (test,
review, et cetera) to get it better.

-- 
With Best Regards,
Andy Shevchenko


