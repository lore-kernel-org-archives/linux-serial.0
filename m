Received: from ultrarisc.com (unknown [218.76.62.146])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0460B3DA5BD;
	Tue, 28 Apr 2026 09:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.76.62.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777367319; cv=none; b=nku2aJUiR2dCaVDrGAD/NAeOhN9G2rp5NiekrLYMwJYPwTv4+xpBh+7otEThFqAHPNtOKPuRSXlq0cTSza4NcgaZf0gKoCF39RdWkz6c+h6BcaGzQ4kR9qOdk0yVU86YknmKnh36GvLpjvYsC5ahAowRHNOae8cKBpA2NvgW0l0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777367319; c=relaxed/simple;
	bh=r57WeZxTj6pt4VOVxJMhJeP2CSBC7RAURv6QcqEOJxY=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=IDH7CDD4f9jFfgI8TrTm4lyqfnwKTnW/uqDvTLZ3hr/6eaOiLRo+dgIxNT7MjLMtSCkOlvyXlZw2n3pEAdNx3g6vK2WjLjf0ij1mJAGT6MS83sCIrk2DwsscYf8GBt6MJZMd3nO3/nCb8bpVxKJq6P6nHJd/OlSSv33gTD9qz0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ultrarisc.com; spf=pass smtp.mailfrom=ultrarisc.com; dkim=pass (1024-bit key) header.d=ultrarisc.com header.i=@ultrarisc.com header.b=BprzMAnx; arc=none smtp.client-ip=218.76.62.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ultrarisc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ultrarisc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ultrarisc.com header.i=@ultrarisc.com header.b="BprzMAnx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=ultrarisc.com; s=dkim; h=Received:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:
	References:Date:Message-Id; bh=HzVvXkjtHMlQP5m5OfYGE0prQLJfO2WXW
	lW0bXC9e0o=; b=BprzMAnxHu8qpAQ60zB79QIzvsguVv0nazLSx1nLX2+04id0e
	FUH3gZ0Oa576B1u4KcgZkt1g4OMV1vbu87tJeOEc6QhEPfivHB1U53HFkC2KFNEF
	Lpm3nNmAut6F6pv7y1OG62ULfhwdiK6q6NcYY47sqRnzYFpvYOuIptMz2w=
Received: from [127.0.0.1] (unknown [192.168.100.1])
	by localhost.localdomain (Coremail) with SMTP id AQAAfwDXEEIRefBpaBUDAA--.1579S2;
	Tue, 28 Apr 2026 17:08:33 +0800 (CST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v5 2/4] serial: 8250_dw: build Renesas RZN1 CPR value
 from DW_UART_CPR_* definitions
From: Jia Wang <wangjia@ultrarisc.com>
To: =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Jia Wang <wangjia@ultrarisc.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Paul Walmsley <pjw@kernel.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
 linux-serial <linux-serial@vger.kernel.org>, 
 linux-riscv@lists.infradead.org, devicetree@vger.kernel.org
In-Reply-To: <23c80500-f2c1-0eb3-f640-00f7b108059b@linux.intel.com>
References: <20260428-ultrarisc-serial-v5-0-97de63b1e3eb@ultrarisc.com>
 <20260428-ultrarisc-serial-v5-2-97de63b1e3eb@ultrarisc.com>
 <afBhkbGLsuqUitOl@ashevche-desk.local>
 <23c80500-f2c1-0eb3-f640-00f7b108059b@linux.intel.com>
Date: Tue, 28 Apr 2026 17:07:49 +0800
Message-Id: <177736726936.2886867.7725295920724488690.b4-reply@b4>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777367269; l=3351;
 i=wangjia@ultrarisc.com; s=20260309; h=from:subject:message-id;
 bh=r57WeZxTj6pt4VOVxJMhJeP2CSBC7RAURv6QcqEOJxY=;
 b=oJkdrzOOf8Wb25XGDhMGiao3y9Xh8lMSkwBohAqxsvQOl1CRKqKHWrP+FmHIw7loxcZMK6LgY
 nRoHiAv5p1uA9BlB9HLaakkU1FFmDDkawSvPH+sa0Z0CirPA6QVYM39
X-Developer-Key: i=wangjia@ultrarisc.com; a=ed25519;
 pk=XvYkrelqJIIzobY7j+nIg8rsfv5kzaOzuc1UPhd087U=
X-CM-TRANSID:AQAAfwDXEEIRefBpaBUDAA--.1579S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWF4xWFy8Ww13uF4kJFyxZrb_yoW5Zr15pF
	yfKa1Uta18GF1kG340y3y2va1SqF1rGw10qFyUur1UAan0vrn2qw1qvFZIkrZ7ZFZ5CayY
	gFsFqrnxu34rt3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnUUvcSsGvfC2KfnxnUUI43ZEXa7xR_UUUUUUUUU==
X-CM-SenderInfo: pzdqwylld63zxwud2x1vfou0bp/1tbiAQAKEWnti78ACwA0sV

On 2026-04-28 11:41 +0300, Ilpo Järvinen wrote:
> On Tue, 28 Apr 2026, Andy Shevchenko wrote:
> 
> > On Tue, Apr 28, 2026 at 01:26:27PM +0800, Jia Wang wrote:
> > > Replace the magic CPR value for Renesas RZ/N1 with a composition using
> > > DW_UART_CPR_* bit/field definitions and FIELD_PREP_CONST().
> > > 
> > > Introduce a helper macro to convert a FIFO size (bytes) into the CPR
> > > FIFO_MODE field value, with BUILD_BUG_ON_ZERO() checks for alignment and
> > > bounds. Use it to replace the literal FIFO_MODE values in the RZN1.
> > 
> > A couple of nit-picks below. After addressing them you can add
> > 
> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > 
> > ...
> > 
> > >  #include <linux/bitfield.h>
> > >  #include <linux/bits.h>
> > > +#include <linux/build_bug.h>
> > > +#include <linux/align.h>
> > 
> > Preserve order, 'a' goes before 'b'.
> > 
> > >  #include <linux/io.h>
> > >  #include <linux/types.h>
> > 
> > ...
> > 
> > >  /* Helper for FIFO size calculation */
> > >  #define DW_UART_CPR_FIFO_SIZE(a)	(FIELD_GET(DW_UART_CPR_FIFO_MODE, (a)) * 16)
> > 
> > > +#define DW_UART_CPR_FIFO_MODE_MAX	0x80
> > 
> > You used decimal values elsewhere (id est 16), use upper limit in decimal
> > as well.
> > 
> > > +#define DW_UART_CPR_FIFO_MODE_FROM_SIZE(size)				\
> > > +	(BUILD_BUG_ON_ZERO(!IS_ALIGNED((size), 16)) +			\
> > > +	 BUILD_BUG_ON_ZERO(((size) / 16) > DW_UART_CPR_FIFO_MODE_MAX) +	\
> > > +	 ((size) / 16))
> > 
> > I don't see the need in having that maximum being defined separately (we don't
> > have that for 16, no need to have it for 128.
> > 
> > Since some ISA:s have one assembly instruction to get both / and % divisions,
> > it's better to use that instead of IS_ALIGNED(). Can you check code generation
> > for x86_64 / x86?
> 
> Do those BUILD_BUGs even generate code, especially when they are expected 
> to only appear in a struct initializer?
> 
> > #define DW_UART_CPR_FIFO_MODE_FROM_SIZE(size)				\
> > 	(BUILD_BUG_ON_ZERO((size) > 2048) + BUILD_BUG_ON_ZERO((size) % 16) + ((size) / 16))
> > 
> > Note, I dropped first division in order to show the upper limit in a plain
> > number since 16 is also FIFO size in bytes.
> > 
> > Also note, this evaluates (size) three times, which might be problematic,
> > but I think we can leave with that for now.
> 
> I'd put also FIELD_PREP_CONST() into the macro itself as I don't see much 
> value for this macro outside of those .cpr_value initializations.
> 
> IMO, the entire macro would be cleaner looking as a truly multi-line 
> construct. Can we use static_assert()s in struct field initialization 
> (I'm not sure), something along these lines:
> 
> #define DW_UART_CPR_FIFO_MODE_FROM_SIZE(size)			\
> ({								\
> 	typeof (size) __size = size;				\
> 								\
> 	static_assert(IS_ALIGNED((__size), 16));		\
> 	static_assert(__size <= DW_UART_CPR_FIFO_MODE_MAX);	\
> 								\
> 	FIELD_PREP_CONST(DW_UART_CPR_FIFO_MODE, __size / 16);	\
> })
> 

Thanks. I tried that approach, but the statement-expression form does
not work in this case because the helper is used in static initializers.
So I'll keep it as a plain expression macro for now, and just rework it
into a cleaner multi-line form.

> -- 
>  i.
> 
>

Best Regards,
Jia Wang 


