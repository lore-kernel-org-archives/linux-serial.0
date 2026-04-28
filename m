Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F5E43B9D80;
	Tue, 28 Apr 2026 07:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777361304; cv=none; b=ewXZh0w1LQnr1X+X9hFXMTyCVR7Gsi7NzwHFhkYF3spSUgQBXEzfiuaBo0qwwmzvu4OKSLqkp7dsV+uZHN6op7ajks7YCJsB0HYsCeB1wz8LiqzA7OFV23xIV/tJJzu9vLskUCoaHM+91/piIlg2zPhGn8VY79GQuxLD1OfJ1cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777361304; c=relaxed/simple;
	bh=cnLBWFAgnHpFzq+M5i9HhlcSIKs0qTNVPCZxbnKABas=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H7+nlufHdPomtIkJZwTu1nz2SN0c5E9UCGYxf56hxSN0UumnNEAxig+Azw8+b0EXbVXL1Zxu/c1AOq44hrgW7/GNg36qZQAvvgwr/YIcZEPdC0kDZBzDpE4hh69LA+Wh7JX1Hcx8ANkILueDVOdli3ftIQ96IsUEmDaOtGLuusM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bFldBH8d; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bFldBH8d"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777361303; x=1808897303;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cnLBWFAgnHpFzq+M5i9HhlcSIKs0qTNVPCZxbnKABas=;
  b=bFldBH8dt5SYO/yvTJKuiCgCHc0sL3UP+mlkqKOv7lQS832xaD/j6KxA
   wnojNKcU4Gq1KmUUUIheLOFOZt8tlY+hM63cvcFw3ue4kem3fq3sMiPRG
   hqHTlHwtVfd5xzrop5lOBb7rvvLPrS3vIHkZwF5BJENCYu4pWuW92sg1w
   DCVS4ojWS4p72aOy7t3quvhDDIxJOc2/Gm1XzAVdJ6IeJqRMtOWj0gG/s
   iOhOFhMJglNnkXgSByf8x/VQmkS0lZIubLv0m2ImjFqfZMk5EnG9AhIx2
   IYPxW8iEhpf11hN3MHOnBdauVjDK6T9naU+YpslrsNFWDft5e7oXHVNK3
   g==;
X-CSE-ConnectionGUID: Lay9ylI6QBW44wIvAf4A4A==
X-CSE-MsgGUID: Eyivc4t3S7Ge3lDYAnTKPg==
X-IronPort-AV: E=McAfee;i="6800,10657,11769"; a="78281983"
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; 
   d="scan'208";a="78281983"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2026 00:28:23 -0700
X-CSE-ConnectionGUID: J9bnrosjRwSdZz5Wa0Qxlg==
X-CSE-MsgGUID: NPcAeaqjSKeFyRyPDBE/0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; 
   d="scan'208";a="229518477"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.213])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2026 00:28:19 -0700
Date: Tue, 28 Apr 2026 10:28:17 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jia Wang <wangjia@ultrarisc.com>
Cc: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v5 2/4] serial: 8250_dw: build Renesas RZN1 CPR value
 from DW_UART_CPR_* definitions
Message-ID: <afBhkbGLsuqUitOl@ashevche-desk.local>
References: <20260428-ultrarisc-serial-v5-0-97de63b1e3eb@ultrarisc.com>
 <20260428-ultrarisc-serial-v5-2-97de63b1e3eb@ultrarisc.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260428-ultrarisc-serial-v5-2-97de63b1e3eb@ultrarisc.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Apr 28, 2026 at 01:26:27PM +0800, Jia Wang wrote:
> Replace the magic CPR value for Renesas RZ/N1 with a composition using
> DW_UART_CPR_* bit/field definitions and FIELD_PREP_CONST().
> 
> Introduce a helper macro to convert a FIFO size (bytes) into the CPR
> FIFO_MODE field value, with BUILD_BUG_ON_ZERO() checks for alignment and
> bounds. Use it to replace the literal FIFO_MODE values in the RZN1.

A couple of nit-picks below. After addressing them you can add

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

...

>  #include <linux/bitfield.h>
>  #include <linux/bits.h>
> +#include <linux/build_bug.h>
> +#include <linux/align.h>

Preserve order, 'a' goes before 'b'.

>  #include <linux/io.h>
>  #include <linux/types.h>

...

>  /* Helper for FIFO size calculation */
>  #define DW_UART_CPR_FIFO_SIZE(a)	(FIELD_GET(DW_UART_CPR_FIFO_MODE, (a)) * 16)

> +#define DW_UART_CPR_FIFO_MODE_MAX	0x80

You used decimal values elsewhere (id est 16), use upper limit in decimal
as well.

> +#define DW_UART_CPR_FIFO_MODE_FROM_SIZE(size)				\
> +	(BUILD_BUG_ON_ZERO(!IS_ALIGNED((size), 16)) +			\
> +	 BUILD_BUG_ON_ZERO(((size) / 16) > DW_UART_CPR_FIFO_MODE_MAX) +	\
> +	 ((size) / 16))

I don't see the need in having that maximum being defined separately (we don't
have that for 16, no need to have it for 128.

Since some ISA:s have one assembly instruction to get both / and % divisions,
it's better to use that instead of IS_ALIGNED(). Can you check code generation
for x86_64 / x86?

#define DW_UART_CPR_FIFO_MODE_FROM_SIZE(size)				\
	(BUILD_BUG_ON_ZERO((size) > 2048) + BUILD_BUG_ON_ZERO((size) % 16) + ((size) / 16))

Note, I dropped first division in order to show the upper limit in a plain
number since 16 is also FIFO size in bytes.

Also note, this evaluates (size) three times, which might be problematic,
but I think we can leave with that for now.


-- 
With Best Regards,
Andy Shevchenko


