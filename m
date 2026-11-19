Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.17
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795083940;
	b=zcdVVF+nVlkCmWihBIBmciNPaoHD/pXRboUHqtFf225GtbtKUJqB2KdVHPcMJSdfdLct
	 u+tFK7+RZlVv4oLNuPtTIoPBnYdgOdJmq1wHjC6NLxU28nvm2qf7OnR1uqsR3s0bHXaSC
	 nlmfUVxGq8GjnDmQnkAlBE2YdY/lW+oF2z87h2yikg7kP/JZNhfLSwYTxB5tM5ciDG3Df
	 urv3oiZ5I2AMI46ZFp+W2Q3YmlPWX1frp6zDxRwVd+B0PbpPWzwnGse/Docnbgw7KQgPP
	 bFnVFSGemhGzM01tiBoFdiTwJ6O67HuPsDr7tuqh5vLlQhp0I7bUsMEvpG7HRwyX+0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795083940;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=0I4Mwk4IXM4zAlr6pd9BRUhCAw7KmrVe0Rsn3YFL2tQ=;
	b=1FQdGAULzs6tkvMKOC8idj3XKWJ42ZAhTaaWujifp1Krb7KwktYEf8iKJjIA+HVh+gP/
	 3o0MLRbtYG2v2WSJfiTVry0jwmnnU/JN3t5BLAP9XyixIIqW0w391cjlA7qLs5nxtnac0
	 pM506umVWv9SwU9HUoLfOL/5A5yzn0gmhAv2RbTd6k2et+PSAO2ieh6R4geYAfPAIBujP
	 Z9wBQltiUj5QF96GO7/TswhLb0JfzbUbeiYI+bwVu3pQ54w9NbvF4D9FN6m06S7Wlwsdq
	 /bQ1DckIV7/xmFjg2k3Rx0L8vNx+0ylY9kMdIgmksc7KFRs1BIVRKq/X9jPpfviUtgw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=eMs96tkh;
	arc=none smtp.remote-ip=198.175.65.17
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFAB8606A324;
	Thu, 19 Nov 2026 10:25:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CFAB8606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=eMs96tkh
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795083940; x=1826619940;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vjRhQnsg4hnWDgfh2Qs20hB1/ie+fe+LcnnqHirVeEo=;
  b=eMs96tkhv9pn1BprjjijSWjDs9jZB8Y8yJrpZu3M8EHnsBTLuaV6YqX3
   QUYvKXrVxOlXMAfX1PCpujXNMV3PFZ1v1e7tP7kSoY5/h28mIumcNqzXu
   Ts+mn5jmHbx8E3XqKVY7M68HcQsMdRcu/r0VI0Vj/noO5vEJwFrPGpfM4
   8c+flaGoCoYUuwgoTxMePfMGcGt1RsDr/y9Tx+lwZNHWpLm/aadzgPE3Q
   5mmrFCYJlZIVBHBqHMtNrCbDRy2/BIE3Kv6QE5mkke1KMT5GAMXePiV49
   Z/DFfhG+DjVje6SXZhOgvWnh7bpmSAB5L+KauAD5UD8LtlukKazXTK9gR
   A==;
X-CSE-ConnectionGUID: 9zyEraVBS9OwreitGIO/ug==
X-CSE-MsgGUID: huBAoCVPT2CKHqiz/EGqcQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11970"; a="3936613"
X-IronPort-AV: E=Sophos;i="6.27,220,1787036400"; 
   d="scan'208";a="3936613"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2026 02:25:39 -0800
X-CSE-ConnectionGUID: 80syGAwTSc65i+qCDRM27A==
X-CSE-MsgGUID: dvSv/5xBQ5avf4yp3GbB+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,220,1787036400"; 
   d="scan'208";a="10266515"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.61])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2026 02:25:36 -0800
Date: Thu, 19 Nov 2026 12:25:33 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: James Hilliard <james.hilliard1@gmail.com>
Cc: Viresh Kumar <vireshk@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>, Dan Williams <djbw@kernel.org>,
	Serge Semin <fancer.lancer@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	dmaengine@vger.kernel.org, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v10 3/7] dmaengine: dw: embed a virt-dma channel
Message-ID: <av7OnVY0gvndgPed@ashevche-desk.local>
References: <20261119-submit-dw-dma-synchronize-v1-v10-0-3a737597a0d1@gmail.com>
 <20261119-submit-dw-dma-synchronize-v1-v10-3-3a737597a0d1@gmail.com>
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
In-Reply-To: <20261119-submit-dw-dma-synchronize-v1-v10-3-3a737597a0d1@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Nov 19, 2026 at 03:01:37AM -0700, James Hilliard wrote:
> Move the DMAengine channel and its lock into an embedded virt_dma_chan.
> Keeping channel registration, descriptor queues and callback delivery
> unchanged separates the mechanical member changes from the conversion
> to virt-dma queue management.

> Link: https://lore.kernel.org/r/av3oxznSW_5oH8la@SMW015318

You should not put arbitrary Link tags. The point of having a Link tag has to
be clarified. The text in the commit message should refer to it in a form of
[1] and that piece should be added to the end. But I think you just want
the Suggested-by: tag?

-- 
With Best Regards,
Andy Shevchenko


