Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793825385;
	b=iWX3H6WTVYy0uNMVa89Q7i7s1rQHveKa7EVJSbiOxC/3JJT8I3J1MnBYchcmpONVAqKD
	 xpkDXcaJJFJPqn22dqSAOIK2X1f3yJI45oOgxuYx00Kw94MmslIoKPlUxA3t6tL6mHYO6
	 2mBdyNrczxI8nCOji69fzEiQctuvAQUp2yV3hVhuhYNLgmlIofIQcqDq/hSF4TkSG9anM
	 pYNYar5R1cWUCohNTnHL8QFCPnKxIJgXw+tmvwDims95Pf6KsAVwlq5kV9WkvIeBBrWAs
	 RV0FCNJj0a5hOv3cD2f1LU06xOehsamyPYQ3IJmySmEpYYsulVH2CnwS5a22S17mPGg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793825385;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=UMblCDkeaLJ4fgfQ6iI8HG5CBwVvaHr3bsDOTNNKxfs=;
	b=r1eHRzmbBe5grKrXzhDZqzkm0J7HDqqhb20Pckr+Q016tQv1XyG43qxe7rfrM2fApFpb
	 1DrDXFDvaCQP6LkyWIrlropqSCrHTAHdm5RVrS8S3i1k3hDXshNGXEk8n24ASV5pP02Xt
	 7j4tApuNLCzTbgscOnB2Df0le/JjRB00cgIQ1/cXanei0RQgmqblhlQ739t1cE73Hexxg
	 kDKJ1NXC1eFhauPNGFB1GO7NG6iNkzRsl6VcEvuzDc1DOdzIdFUAePyOmg6ZMwH7Augq6
	 kQz0hgD1NNhdMF4ucIcRmOxcXXUbQ966NtmREuZoFmumsrEp8KJuhZwJsAzDrRgfHPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=BmTArU4P;
	arc=none smtp.remote-ip=192.198.163.18
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE702606CA08;
	Wed,  4 Nov 2026 20:49:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CE702606CA08
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=BmTArU4P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793825385; x=1825361385;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JTdqZrMRPi6WcLGmJnwa/CJMl4RUCZus4mIGMek1G50=;
  b=BmTArU4PLciQsuQaWsj83LMbIlvlugcIi/qan22ZNk4144OEvVJ3s0aQ
   zua/n0ChL0NXCRh7fomWDWJipXWH8Ec/gps/7dk8wYihZlf8Fu0djxPpM
   85Ld71j/HpPlSSpNikhcaotx5Ick1Sb7WjSIivuM3lh1nFyCioZo9KoKO
   sJBj3aGYXAkUcjnNQFWvnxSm5LI54S4YX/cbyj7AtwSLVKMkoFLk0ZHhF
   NXIa2tnFKb6Xuo8uWFmoZq+/+dhkOvZs0nBJUhL+HZ1BUnECsZjL2Tjqz
   wx36QzrSeZ+q8QV2QeMxMuLGoyBhA1DUiVj5gpMV2oR82c6RWQADWrrHZ
   Q==;
X-CSE-ConnectionGUID: Sa3j6XpuT1GpDV7IzRTWBQ==
X-CSE-MsgGUID: hdwdZJygQFKmbKQTzUmKLw==
X-IronPort-AV: E=McAfee;i="6800,10657,11956"; a="2635597"
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="2635597"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2026 12:49:45 -0800
X-CSE-ConnectionGUID: OcTARpEbSGOe3Qh4k5qXIQ==
X-CSE-MsgGUID: TWlF8PfzSsqQNcZHM0fkZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="8676414"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.24])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2026 12:49:42 -0800
Date: Wed, 4 Nov 2026 22:49:39 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Frank.Li@oss.nxp.com,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
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
Message-ID: <auuaYxoZm2T25cU5@ashevche-desk.local>
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
> 
> Use the dmaengine_get_provider_device() API instead of directly
> accessing chan->device->dev to get the DMA provider device.
> 
> No functional change. Prepare make to struct dma_device private to the DMA
> engine.

Krzysztof, this patch was a split from the bundle by a reviewer request (not me
FWIW), and author obeyed. So, you can do the same in cases when you got something
you want to review independently on other content which most likely is a noise
(to you).

-- 
With Best Regards,
Andy Shevchenko


