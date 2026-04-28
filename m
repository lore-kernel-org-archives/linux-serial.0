Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B821B3101C8;
	Tue, 28 Apr 2026 08:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777365698; cv=none; b=EpBgAPBbgEcaUidO9mlHJu2YK7RwJx9M9eAposxij8ny6z4RCzrhKPF6CJeRj5aLg09RVpkvkAkqC+Z984qOs6YvZ1pYzg/HTsa3keQ+sHYTdRLK+hKlTb+/KYM+Cc7yNc1rattjo++wgZXUdQnrWXP4m+9xwN+GAUtrrDjjUBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777365698; c=relaxed/simple;
	bh=XPTCEcTHbkekBt6T4R3aXPqOPTdwjmg9/9WWoig2Tmo=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Y+OMPftWb5FWQZbAXy/Qs7jucBXDzz7XPt3vc/s4l/CS91A4C7iGnNqpuORI0nPRMHrkzCF6oRT/cSl3hYdOHWWwS7Jf6u/YOJvr0tIEAjSnI+uXWjxUhend9qlPW9zUvHjGUu9jFNdySy6S86/Q4KDQyaNMCCT1dp+YVWj50rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CSCcT/j2; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CSCcT/j2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777365697; x=1808901697;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=XPTCEcTHbkekBt6T4R3aXPqOPTdwjmg9/9WWoig2Tmo=;
  b=CSCcT/j2vkl7FrcvTreT3O3pxYsiBFeMFOCZBGE8buClXtL/+ZnrftZB
   yH4e4j0E34c+cWxCQ1uBY1+fdn/g+uayKXg1LUsjugOgeHwBPzODKrdQU
   bcoIOlzWFBOpDsuUvNnp1+KY5iO4ZYnx0yPV2mVqWdpkcRhHo6EWbJWmZ
   lGk5GPIUbXpKl94GYBxGVzAVGWGR/wU13EmxemKImiMnjb5Nl+/jnmRO1
   xqW0siKAdeXxzMuu8tz3EXDvAz0FnEO6XIo0+SmMVajy4BLmwWIPrx1ZF
   C5ZEILsmeP3LUuE470S+wi7oViN5PBKdxMO1/dewG3cGQFYoY/pvJhIqI
   w==;
X-CSE-ConnectionGUID: pTwBDUegRUKaG8iblSqgdQ==
X-CSE-MsgGUID: eO4YKIsaQc+iT9nYRYJHrA==
X-IronPort-AV: E=McAfee;i="6800,10657,11769"; a="78378969"
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; 
   d="scan'208";a="78378969"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2026 01:41:36 -0700
X-CSE-ConnectionGUID: 1x1HMCQuSp+u6ywDASTGNA==
X-CSE-MsgGUID: but3WnWeQfyNuUnb2Rt03Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; 
   d="scan'208";a="232884984"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.1])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2026 01:41:31 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 28 Apr 2026 11:41:27 +0300 (EEST)
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
    Jia Wang <wangjia@ultrarisc.com>
cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Jiri Slaby <jirislaby@kernel.org>, Paul Walmsley <pjw@kernel.org>, 
    Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
    Alexandre Ghiti <alex@ghiti.fr>, Rob Herring <robh@kernel.org>, 
    Krzysztof Kozlowski <krzk+dt@kernel.org>, 
    Conor Dooley <conor+dt@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
    linux-serial <linux-serial@vger.kernel.org>, 
    linux-riscv@lists.infradead.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v5 2/4] serial: 8250_dw: build Renesas RZN1 CPR value
 from DW_UART_CPR_* definitions
In-Reply-To: <afBhkbGLsuqUitOl@ashevche-desk.local>
Message-ID: <23c80500-f2c1-0eb3-f640-00f7b108059b@linux.intel.com>
References: <20260428-ultrarisc-serial-v5-0-97de63b1e3eb@ultrarisc.com> <20260428-ultrarisc-serial-v5-2-97de63b1e3eb@ultrarisc.com> <afBhkbGLsuqUitOl@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 28 Apr 2026, Andy Shevchenko wrote:

> On Tue, Apr 28, 2026 at 01:26:27PM +0800, Jia Wang wrote:
> > Replace the magic CPR value for Renesas RZ/N1 with a composition using
> > DW_UART_CPR_* bit/field definitions and FIELD_PREP_CONST().
> > 
> > Introduce a helper macro to convert a FIFO size (bytes) into the CPR
> > FIFO_MODE field value, with BUILD_BUG_ON_ZERO() checks for alignment and
> > bounds. Use it to replace the literal FIFO_MODE values in the RZN1.
> 
> A couple of nit-picks below. After addressing them you can add
> 
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> ...
> 
> >  #include <linux/bitfield.h>
> >  #include <linux/bits.h>
> > +#include <linux/build_bug.h>
> > +#include <linux/align.h>
> 
> Preserve order, 'a' goes before 'b'.
> 
> >  #include <linux/io.h>
> >  #include <linux/types.h>
> 
> ...
> 
> >  /* Helper for FIFO size calculation */
> >  #define DW_UART_CPR_FIFO_SIZE(a)	(FIELD_GET(DW_UART_CPR_FIFO_MODE, (a)) * 16)
> 
> > +#define DW_UART_CPR_FIFO_MODE_MAX	0x80
> 
> You used decimal values elsewhere (id est 16), use upper limit in decimal
> as well.
> 
> > +#define DW_UART_CPR_FIFO_MODE_FROM_SIZE(size)				\
> > +	(BUILD_BUG_ON_ZERO(!IS_ALIGNED((size), 16)) +			\
> > +	 BUILD_BUG_ON_ZERO(((size) / 16) > DW_UART_CPR_FIFO_MODE_MAX) +	\
> > +	 ((size) / 16))
> 
> I don't see the need in having that maximum being defined separately (we don't
> have that for 16, no need to have it for 128.
> 
> Since some ISA:s have one assembly instruction to get both / and % divisions,
> it's better to use that instead of IS_ALIGNED(). Can you check code generation
> for x86_64 / x86?

Do those BUILD_BUGs even generate code, especially when they are expected 
to only appear in a struct initializer?

> #define DW_UART_CPR_FIFO_MODE_FROM_SIZE(size)				\
> 	(BUILD_BUG_ON_ZERO((size) > 2048) + BUILD_BUG_ON_ZERO((size) % 16) + ((size) / 16))
> 
> Note, I dropped first division in order to show the upper limit in a plain
> number since 16 is also FIFO size in bytes.
> 
> Also note, this evaluates (size) three times, which might be problematic,
> but I think we can leave with that for now.

I'd put also FIELD_PREP_CONST() into the macro itself as I don't see much 
value for this macro outside of those .cpr_value initializations.

IMO, the entire macro would be cleaner looking as a truly multi-line 
construct. Can we use static_assert()s in struct field initialization 
(I'm not sure), something along these lines:

#define DW_UART_CPR_FIFO_MODE_FROM_SIZE(size)			\
({								\
	typeof (size) __size = size;				\
								\
	static_assert(IS_ALIGNED((__size), 16));		\
	static_assert(__size <= DW_UART_CPR_FIFO_MODE_MAX);	\
								\
	FIELD_PREP_CONST(DW_UART_CPR_FIFO_MODE, __size / 16);	\
})

-- 
 i.

