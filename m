Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6EAFDF6C;
	Tue, 30 Sep 2025 12:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759233698; cv=none; b=pKn6b/BBpxjHTcn4DFVm/TY+DyD7HkNIVkhNF0IupZMJXVtnc5VnltwrlbrwByaye+jpMEDFBG0DkASXQyTfyq9WdTIeXsBR8R5ZHKxNddFm5ECbJjAhCFy04bvh1Bf1Ma5OpNCF3X+pIc/dIBgOiqsWK6FRnnn2gmjuWKvA6+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759233698; c=relaxed/simple;
	bh=AWIPVrrqT+LyROqrCNhV4Nm3UljWQSbVr4QGgV0DR9U=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Z5VODjo48z+N/a/IppjMjoFx/REWA2iGihUsNoNMdAUW7URZi/v0fgUknmVo5TDjSEu9LhAy16k3cuNB9xsAuyFkLdpiDkqd1cPr7MGVgyOFv8OhzdHm/BKyg/qqraoYjmhdyZvYQmBusTQsIevVva/+H9ygdSrXmDGrrRvvJBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Nl/R+VE/; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Nl/R+VE/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759233696; x=1790769696;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=AWIPVrrqT+LyROqrCNhV4Nm3UljWQSbVr4QGgV0DR9U=;
  b=Nl/R+VE/XKEUrfnHkzNV2whqxUqW0McApCdsca7B0LYrJAexfbLxV0Tx
   iw1K4ZjUgRQLFXhuPjNzELkc1sbu4nNLw6F5/6u6s6kV3w+D9bi0n68nu
   PmpI4Q5k6l3G3LaberPS2cjqUD+9gx3Iqa72SVhaCGTEovcS+lkiDICrb
   2UXDV0XE2A3E7aM2kPXXTsPEamXhVMyeFTIicQesQfF3hMnmIqoSsT+H7
   qRj2jCdUxOFAaQZ/cSVFDxgo/+/2N/8cS6NlJ6Ggkae/iiHnkQlfBezHC
   1W1sXFCIO3OQHQEn1DpzbfVvr1sRzQx53gQU8zygLw+qR/vv2799uoeOb
   Q==;
X-CSE-ConnectionGUID: Dnj8QL1RRzahNsOAZb5Xlw==
X-CSE-MsgGUID: YGH6nqAwTve2CNWZZINP9A==
X-IronPort-AV: E=McAfee;i="6800,10657,11568"; a="72106746"
X-IronPort-AV: E=Sophos;i="6.18,304,1751266800"; 
   d="scan'208";a="72106746"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2025 05:01:18 -0700
X-CSE-ConnectionGUID: TpF6ZX8KRayIH6/wwMSaDQ==
X-CSE-MsgGUID: BtiOjuZkTOGZWvVYNrZu1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,304,1751266800"; 
   d="scan'208";a="178909874"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.162])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2025 05:01:12 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 30 Sep 2025 15:01:09 +0300 (EEST)
To: Jiri Slaby <jirislaby@kernel.org>
cc: Binbin Zhou <zhoubinbin@loongson.cn>, Binbin Zhou <zhoubb.aaron@gmail.com>, 
    Huacai Chen <chenhuacai@loongson.cn>, Rob Herring <robh+dt@kernel.org>, 
    Krzysztof Kozlowski <krzk+dt@kernel.org>, 
    Conor Dooley <conor+dt@kernel.org>, 
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Haowei Zheng <zhenghaowei@loongson.cn>, 
    Huacai Chen <chenhuacai@kernel.org>, Xuerui Wang <kernel@xen0n.name>, 
    loongarch@lists.linux.dev, devicetree@vger.kernel.org, 
    linux-serial <linux-serial@vger.kernel.org>
Subject: Re: [PATCH v5 2/3] serial: 8250: Add Loongson uart driver support
In-Reply-To: <a985f144-7489-4a99-bcb7-90e7b21d9885@kernel.org>
Message-ID: <0bb67e09-94b2-ed89-2711-b6bda00f6f14@linux.intel.com>
References: <cover.1758676290.git.zhoubinbin@loongson.cn> <9823e7afe713450e210dab9dba6fa18683dc1fe0.1758676290.git.zhoubinbin@loongson.cn> <a985f144-7489-4a99-bcb7-90e7b21d9885@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 29 Sep 2025, Jiri Slaby wrote:

> On 24. 09. 25, 8:29, Binbin Zhou wrote:
> > Add the driver for on-chip UART used on Loongson family chips.
> > 
> > The hardware is similar to 8250, but there are the following
> > differences:
> >   - Some chips (such as Loongson-2K2000) have added a fractional division
> >     register to obtain the required baud rate accurately, so the
> >     {get,set}_divisor callback is overridden.
> >   - Due to hardware defects, quirk handling is required for
> >     UART_MCR/UART_MSR.
> 
> So how hard would be to implement this in 8250 using existing (or new)
> callbacks+quirks?

??

Isn't it exactly what this submission did? It implements custom in/out 
functions which handle the xor for the relevant bits?

-- 
 i.

> > --- /dev/null
> > +++ b/drivers/tty/serial/8250/8250_loongson.c
> > @@ -0,0 +1,202 @@
> ...
> > +struct loongson_uart_data {
> > +	int line;
> > +	int mcr_invert;
> > +	int msr_invert;
> 
> These two should be unsigned. They should be u8, actually.
> 
> > +	struct reset_control *rst;
> > +};
> > +
> > +static unsigned int serial_fixup(struct uart_port *p, unsigned int offset,
> > unsigned int val)
> 
> Both 'val' and ret type should be u8.
> 
> > +{
> > +	struct loongson_uart_data *ddata = p->private_data;
> > +
> > +	if (offset == UART_MCR)
> > +		val ^= ddata->mcr_invert;
> > +
> > +	if (offset == UART_MSR)
> > +		val ^= ddata->msr_invert;
> > +
> > +	return val;
> > +}
> > +
> > +static u32 loongson_serial_in(struct uart_port *p, unsigned int offset)
> > +{
> > +	unsigned int val;
> 
> u8
> 
> > +
> > +	val = readb(p->membase + (offset << p->regshift));
> > +
> > +	return serial_fixup(p, offset, val);
> > +}
> 
> thanks,
> 
