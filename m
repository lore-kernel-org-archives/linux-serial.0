Received: from ultrarisc.com (unknown [218.76.62.146])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D949A3D47AC;
	Tue, 28 Apr 2026 08:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.76.62.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777365419; cv=none; b=I7Oyk6le6UvHQzZLGwSaF9QX6t/xRC3qDpcfvHxD64YFV5TfL0RfD5ABlj7AD9cAvsxbSOMd8Rs01aoiIHRr22kNrKetZchh5NtD+e/593Vvz1rQGaSy8URnyIAGSrrLhOvPzWgzG/L6/IKcie7IRq8FNLpkN2TRHMcDeMcCZkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777365419; c=relaxed/simple;
	bh=BIhqOapgNnxmFfe3qKZl8GPilR7cf2rVzseYikZONhI=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=P47PORNJuKKaj9tZaCM6m4PZfOTwpj6NioT5IkpFR6ZcaRp+qwZrlqIbT3gUnkbWV/oq3zEPZmweDtMAWSF8ToKSLqmLlqQ2qWU8CGCr/5Fk0YrcO1GCVovQoAYoIJxx0qnRTUpvaS4jMR5OXCOGPoUYizLCfuvVzejwlriNBXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ultrarisc.com; spf=none smtp.mailfrom=ultrarisc.com; dkim=pass (1024-bit key) header.d=ultrarisc.com header.i=@ultrarisc.com header.b=R6pxoPtV; arc=none smtp.client-ip=218.76.62.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ultrarisc.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ultrarisc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ultrarisc.com header.i=@ultrarisc.com header.b="R6pxoPtV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=ultrarisc.com; s=dkim; h=Received:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:
	References:Date:Message-Id; bh=KePaejAKmGTlKVZsIEne9HnS+XEQm8GEA
	gV1azEh90Q=; b=R6pxoPtVizSzffiUatA+8a+DF2lQV1xkSXK+o/JvMXqrRD1Gb
	IXeev0BfRHZZQyPJBqMOuywQSG36PeAQ0lh2SR0ylppJOaR99ucLeGCAcptOLpun
	r4QBdVKxEyXL9wFdneBzLBtMACe4TqO67D9v+3Oy5veiS6AWkJ1ZWsnnp8=
Received: from [127.0.0.1] (unknown [192.168.100.1])
	by localhost.localdomain (Coremail) with SMTP id AQAAfwAnYUK5cfBpHBUDAA--.1706S2;
	Tue, 28 Apr 2026 16:37:13 +0800 (CST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v5 2/4] serial: 8250_dw: build Renesas RZN1 CPR value
 from DW_UART_CPR_* definitions
From: Jia Wang <wangjia@ultrarisc.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Jia Wang <wangjia@ultrarisc.com>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Paul Walmsley <pjw@kernel.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-serial@vger.kernel.org, linux-riscv@lists.infradead.org, 
 devicetree@vger.kernel.org
In-Reply-To: <afBhkbGLsuqUitOl@ashevche-desk.local>
References: <20260428-ultrarisc-serial-v5-0-97de63b1e3eb@ultrarisc.com>
 <20260428-ultrarisc-serial-v5-2-97de63b1e3eb@ultrarisc.com>
 <afBhkbGLsuqUitOl@ashevche-desk.local>
Date: Tue, 28 Apr 2026 16:36:28 +0800
Message-Id: <177736538896.2886867.15148210690849632028.b4-reply@b4>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777365389; l=2751;
 i=wangjia@ultrarisc.com; s=20260309; h=from:subject:message-id;
 bh=BIhqOapgNnxmFfe3qKZl8GPilR7cf2rVzseYikZONhI=;
 b=3Qkn6OIgn6PUC+UvtN8XqfDX/d/c+/bwCpge0C2foJyPdr1NP0/c0f13y7Vraca80xZhAfO1Q
 az4DLZaWn6JBfnsAyumzrsf5+bZyYq1UYbj6IBktCBYkZMEa57KXpRK
X-Developer-Key: i=wangjia@ultrarisc.com; a=ed25519;
 pk=XvYkrelqJIIzobY7j+nIg8rsfv5kzaOzuc1UPhd087U=
X-CM-TRANSID:AQAAfwAnYUK5cfBpHBUDAA--.1706S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWF47AFyUXF48uw1xAFy7Wrg_yoW5GF4fpF
	W5KF4UtF48Crn7C340yFy2yF4SqFWrGw1IgFyUuF1Dta15Xwn2gryvvFZxtr97ZwsYyayF
	qFsrtFnxu34Fy3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnUUvcSsGvfC2KfnxnUUI43ZEXa7xR_UUUUUUUUU==
X-CM-SenderInfo: pzdqwylld63zxwud2x1vfou0bp/1tbiAQAKEWnti78ACwAwsR

On 2026-04-28 10:28 +0300, Andy Shevchenko wrote:
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

Thanks for the review. I'll address them and add your Reviewed-by tag
in v6.
 
> ...
> 
> >  #include <linux/bitfield.h>
> >  #include <linux/bits.h>
> > +#include <linux/build_bug.h>
> > +#include <linux/align.h>
> 
> Preserve order, 'a' goes before 'b'.
> 

Will fix in v6.

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

This define will be removed in v6.

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
> 
> #define DW_UART_CPR_FIFO_MODE_FROM_SIZE(size)				\
> 	(BUILD_BUG_ON_ZERO((size) > 2048) + BUILD_BUG_ON_ZERO((size) % 16) + ((size) / 16))
> 
> Note, I dropped first division in order to show the upper limit in a plain
> number since 16 is also FIFO size in bytes.
> 
> Also note, this evaluates (size) three times, which might be problematic,
> but I think we can leave with that for now.
>

Makes sense. I'll fold the upper limit into the macro and switch to
(size) > 2048 and (size) % 16 checks for v6.

In the driver, the macro is used only in static initializers, so the
constants are fully resolved at compile time.

I also checked code generation on x86_64/x86: both IS_ALIGNED() and % 16
produce identical instructions at -O2. I'll still switch to % 16 as you
suggest for clarity.

> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 
>

Best Regards,
Jia Wang 


