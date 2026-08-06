Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B2242BC36;
	Thu,  6 Aug 2026 22:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786054731; cv=none; b=dpLKSa69DNzh+I8JNGreL4jjB6fOO0SbQQxYASlQy1r6agh9yEhkB3lBQTqiUN6YXjRntlQ9fAFQgCQtYnxs01aR/9RDWXjiwyGMf0S7X26Dq9XU7ixO+Crgs1To7bAcKIovsrftkZIxAThbsDvhoKChImpJ4e3r+mzT/2V6BGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786054731; c=relaxed/simple;
	bh=LQIsGtEGbmjyEedPF3KPCBla1mVRaZ7NjQYIuuWPAgc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cUTUmO9/021S2P3nUI4blfMYjSARRncWEvp4m4ZQQCNEVAD9srtD61bJ8JgGdZiD8tJQABHJkKR/E77aFhQyGeSBFduHguU4XeHBDClCn5PbFIp0Qp5frvBaHnNZL1H1o/D+wQilBsfGcLzmzRJXuPiHAJS1gpdErFKiRVFvLjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jVdfLyhA; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jVdfLyhA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786054729; x=1817590729;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=LQIsGtEGbmjyEedPF3KPCBla1mVRaZ7NjQYIuuWPAgc=;
  b=jVdfLyhAeKCthS70/0NPyhdd1TkdW2unMXTDxBmB7O/8oDE2oT/K/od+
   LXNNa2NzHa0gn267jJ/0zi48v7ene4A8s/dR4DS22xbu/eCj+D+0F5xCy
   lhQqTBWzP62wZmE3vxICg11BiivlLVES0wyi1+3+evWACmHNdjmGjjS8y
   tYPnd1x5fZf/i6gpvLfXpPYaq3s6qg0Lu47j/3mTleF+679w5EKzJetW1
   XWnDBkmwXmigw5p3RjIBee1PJ3+iWlZDJQOqjMJq2e+beL2kEW4WcWtoq
   Zk8jm1iGb8xITK9rj3cteExf6nw0fd4eRFp5VC++RN+Fg4Yua4ww0Tzz0
   w==;
X-CSE-ConnectionGUID: wn+JUoulSPOz6YsF2kUExA==
X-CSE-MsgGUID: kOmMuQ6WSGSUeU/JgtybEA==
X-IronPort-AV: E=McAfee;i="6800,10657,11867"; a="98171518"
X-IronPort-AV: E=Sophos;i="6.25,209,1779174000"; 
   d="scan'208";a="98171518"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2026 15:18:49 -0700
X-CSE-ConnectionGUID: lHhH0hubRGaBW7e+wQ0MrQ==
X-CSE-MsgGUID: 4YXb9YJ1Ti+cJ0oZbFsUDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,209,1779174000"; 
   d="scan'208";a="255982319"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.50])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2026 15:18:44 -0700
Date: Fri, 7 Aug 2026 01:18:42 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Christian Marangi <ansuelsmth@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Benjamin Larsson <benjamin.larsson@genexis.eu>,
	John Ogness <john.ogness@linutronix.de>,
	Peng Zhang <zhangpeng.00@bytedance.com>,
	Jacques Nilo <jnilo@free.fr>,
	Rong Zhang <rongrong@oss.cipunited.com>,
	Gerhard Engleder <eg@keba.com>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Binbin Zhou <zhoubinbin@loongson.cn>,
	Lubomir Rintel <lkundrak@v3.sk>, devicetree@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	linux-serial <linux-serial@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] serial: 8250: Add Airoha SoC UART and HSUART
 support
Message-ID: <anUIQroijnwmCs69@ashevche-desk.local>
References: <20260724183007.188172-1-ansuelsmth@gmail.com>
 <20260724183007.188172-3-ansuelsmth@gmail.com>
 <6ade8574-1ba6-3a9a-e1ab-4f0ce9c1d8ab@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6ade8574-1ba6-3a9a-e1ab-4f0ce9c1d8ab@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Jul 27, 2026 at 11:51:01AM +0300, Ilpo Järvinen wrote:
> On Fri, 24 Jul 2026, Christian Marangi wrote:

...

> > +static const struct of_device_id airoha_8250_dt_ids[] = {
> 
> Add include for of_device_id.
> 
> I think linux/of.h is the one you want here, as it will be including the 
> new linux/device-id/of.h.

platform_device.h covers it.

> > +	{ .compatible = "airoha,en7523-uart" },
> > +	{ .compatible = "airoha,an7581-hsuart" },
> > +	{ },
> > +};

-- 
With Best Regards,
Andy Shevchenko


