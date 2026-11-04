Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.10
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793825459;
	b=HQ7U7F6hm4SaIizPWt1xNNlzHroZpRkUMJ3551XonN3atpJXWal9j766vv864Y7x7rTx
	 JhXM/2zlIFQqr8rNxYx24PDAwZcKQ4yIoo5xT4+/B29340nZlZGQ1+KX9P+cJeqP/VxMP
	 igL52muAsFVSLtTNlCS6D3NwCAp0gDc2GppspZUPEWdWAZBh6rGBqccjChpUw1mjUzQkI
	 7fVhdkxxMf2Sh6c48cTsi5DKhl61YKia41F6T+6vK2f8NXv8rWUad4IzDBbnru5O8qPyh
	 4ctHlUMMkVaCoi74kwQtFhY0k4RFlGTrv26HIbf/opROllSM/qCOUaIYazeuR+sM3cw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793825459;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=SzDYjlN/1fmf+R4Ld7BlWsMG6VMrX/udiUQllvw7PDQ=;
	b=2AoUJYclhLzla0/10ln3A0w3fnOO+GyfDgYQm6KVga5AJbjOw6lZ7B9B7HP4sLUup8RV
	 QAmOyQIhHK2pJnzJUHbHtUZ7BI9nX4GAmrm9brEXw+pYvmQv+dBEzbJ10w4iRzFRAVYjL
	 t5cs5utCN2S+dsx5kO5PrmTKnblOjfuU3xlNFsyqAadxj1W9uiGnb5Gxaotj6HJaQJ5Ps
	 LPMEoNO3QqBKcAhXMHxHT+QyJJE+iT7cOfLAp+ZkvuAwXMNPlJgDjyN+QGW8PUmgByuFt
	 eBS1lgJgdf7yAzCR0MYIcEwk54SYLJBuHdiU8m+9Bh6liao7lLNWI/NWQug1izkV+sw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=UCdSn5Wv;
	arc=none smtp.remote-ip=192.198.163.10
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6AA4606B2E4;
	Wed,  4 Nov 2026 20:50:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C6AA4606B2E4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=UCdSn5Wv
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793825459; x=1825361459;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=AUcOYkNi8p4zno7vK1wmZulX0t70u9NV7Xu5zTUi8Xs=;
  b=UCdSn5WvvCNZM+BgJJ3N2COSw1r2vy6hcjm/Xab0ZYOl4KoZ0D3u3agJ
   2LKy1quAat8u44OtDhNPTbHEs4IIDRXB76TA0JWVvtjLgSERnb/VCqUlt
   v+Tub9bYNeXZR26i0cpK//mxaRqMXzmIbjJ4SGXYMy4qkiy6Yumtbcr0j
   uZJrSViqXnvmcBdQHlJy5JCVRJ+GQ+178LfRe7n/Qt2xC54wZsBYSqjZ5
   j8EImCzasyC8Ko6k1vbRAGdeCaUWWkJMIkBcN4GbJ96+o6tSb26dmHOE3
   PzYbjblTYcl74JSkHkrJExyH91c2A1nhDB80TDRzRTevV7joxXTUh1gL0
   A==;
X-CSE-ConnectionGUID: tm8ebUj7QNC35Meb59SyLA==
X-CSE-MsgGUID: VS3+uhKbSBa2MN3zEsMV/A==
X-IronPort-AV: E=McAfee;i="6800,10657,11956"; a="2496211"
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="2496211"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2026 12:50:59 -0800
X-CSE-ConnectionGUID: nAWtiO3+RGuHQfrolZcIsw==
X-CSE-MsgGUID: e+LGNCzdTAa8pjppG5+1cg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="6818364"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.24])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2026 12:50:56 -0800
Date: Wed, 4 Nov 2026 22:50:53 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Frank.Li@oss.nxp.com
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Frank Li <Frank.Li@nxp.com>,
	John Ogness <john.ogness@linutronix.de>,
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>,
	Zhaoyang Yu <2426767509@qq.com>,
	Haoxiang Li <haoxiang_li2024@163.com>,
	"open list:TTY LAYER AND SERIAL DRIVERS" <linux-kernel@vger.kernel.org>,
	"open list:TTY LAYER AND SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
	imx@lists.linux.dev
Subject: Re: [PATCH v2 1/2] tty: serial: pch_uart: replace chan->device->dev
 with dmaengine_get_provider_device()
Message-ID: <auuarQPdDEnqq1th@ashevche-desk.local>
References: <20261104145211.3209669-1-Frank.Li@oss.nxp.com>
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
In-Reply-To: <20261104145211.3209669-1-Frank.Li@oss.nxp.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Nov 04, 2026 at 09:52:06AM -0500, Frank.Li@oss.nxp.com wrote:

> Use the dmaengine_get_provider_device() API instead of directly
> accessing chan->device->dev to get the DMA provider device.
> 
> No functional change. Prepare make to struct dma_device private to the DMA
> engine.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko


