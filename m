Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 880E01EABC3;
	Mon, 21 Oct 2024 12:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729512235; cv=none; b=FEnNsYNWc1przAz+I8nvPm9EBpsgxGlLlCXI4XL4HpTjiX1+uFCekf+nqwWAYvexGDW1Ab/hYbifj5SYMP4ByMa4oUKZuSu4Y8cdD5Cs1IBNlexa0NeZSC9I4UCS6zQKw0pQrsTykWX47fGPZTwrt7TmAEXoUtA5DbfE9b1lY6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729512235; c=relaxed/simple;
	bh=64w73gIGV4oF+vq2Rcl+l60DIPus9XsF4mUZMhA7ah8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eX39RDy0yuphNDLtVih14sj7Ehe+BOvsH/3sa+LSZEND3xGlR5+djSpcZp/RhZ/bOqzeYp05bz/aQpERSLTQgG608g05PBms+ukGsidL2R5ebzvwbPlm0+hcIpAsp8Qcks7hDcKcw1gYZmbifPee8migfsahLTC1OVx/oEFM96k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bdRyjnGi; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bdRyjnGi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729512234; x=1761048234;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=64w73gIGV4oF+vq2Rcl+l60DIPus9XsF4mUZMhA7ah8=;
  b=bdRyjnGiwe1K7RTfhOMaNK/U3ovTrYJl7y2qkZVEmC9AV4y8jk2Fn8HM
   OZOQz6sCz7hqlA7OzAGYc/AxHsmqbdIotU8HGfE1BVsfIVztTJsAVjBad
   IEE6UzUwqJvmNYdM7do6dzi2I8u7CSa0hzBkXs6iESEuM8gBkJaE/iyK4
   cfwmKoKU+eoQ1VEyc8uYbgVq3hWo+PybOooIAAUX4Jrwnzy9qATPxhrNR
   0mCE8/1PNYROYfV9WoxmSNGvNFclUrM1jT5E7lbYvODe+SOYh8vjhV5XH
   wnroxWoND7vGZ7DouJ0MKGJEwA6oFIXpO0Xcb9CieSv79gGLJodS081t4
   A==;
X-CSE-ConnectionGUID: aKlS3UKjSiKKESDvAe7fuQ==
X-CSE-MsgGUID: Z+0KMbLcRIe/oIvniRyYOg==
X-IronPort-AV: E=McAfee;i="6700,10204,11231"; a="31855354"
X-IronPort-AV: E=Sophos;i="6.11,220,1725346800"; 
   d="scan'208";a="31855354"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2024 05:03:43 -0700
X-CSE-ConnectionGUID: l0ULbCs3Qqmf1AxmMyh5ow==
X-CSE-MsgGUID: rf2wPc2FSPOFTqBlYa6gWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,220,1725346800"; 
   d="scan'208";a="79456680"
Received: from smile.fi.intel.com ([10.237.72.154])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2024 05:03:38 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1t2r8I-00000005US1-2Urn;
	Mon, 21 Oct 2024 15:03:34 +0300
Date: Mon, 21 Oct 2024 15:03:34 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Inochi Amaoto <inochiama@gmail.com>,
	Chen Wang <unicorn_wang@outlook.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Inochi Amaoto <inochiama@outlook.com>, Yixun Lan <dlan@gentoo.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-serial <linux-serial@vger.kernel.org>,
	devicetree@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2 2/2] serial: 8250_dw: Add Sophgo SG2044 quirk
Message-ID: <ZxZDFiUANo0Jqaai@smile.fi.intel.com>
References: <20241021072606.585878-1-inochiama@gmail.com>
 <20241021072606.585878-3-inochiama@gmail.com>
 <29d8e2a6-d0e7-0f74-1f5c-4f285ec1e9ee@linux.intel.com>
 <tm7jtf3swggiilznwo3xcqjlhd2a7cguwk3nay3bhmaxo23mf5@qw2fyjwapoxe>
 <3dafd285-f56f-de2a-1544-b6ce092607b5@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3dafd285-f56f-de2a-1544-b6ce092607b5@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Oct 21, 2024 at 01:17:55PM +0300, Ilpo Järvinen wrote:
> On Mon, 21 Oct 2024, Inochi Amaoto wrote:
> > On Mon, Oct 21, 2024 at 11:52:38AM +0300, Ilpo Järvinen wrote:
> > > On Mon, 21 Oct 2024, Inochi Amaoto wrote:

> > > > SG2044 relys on an internal divisor when calculating bitrate, which
> > > > means a wrong clock for the most common bitrates. So add a quirk for
> > > > this uart device to skip the set rate call and only relys on the
> > > > internal UART divisor.
> > > > 
> > > > Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> > > 
> > > Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> > > 
> > > I wonder though does this mean the numbers userspace can read from kernel 
> > > are bogus and if something can be done about that?
> > 
> > I am not sure whether the clock rate can be read by the userspace.
> > At least it report the right baud speed by using stty.
> 
> Okay, I meant baud & other settings. Thanks for checking it.

oBut there is clock rate for user space. I think Ilpo has a point.

Documentation/ABI/testing/sysfs-tty:21:What:            /sys/class/tty/ttyS<x>/uartclk

-- 
With Best Regards,
Andy Shevchenko


