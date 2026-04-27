Received: from ultrarisc.com (unknown [218.76.62.146])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A5D3DF59;
	Mon, 27 Apr 2026 02:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.76.62.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777257115; cv=none; b=uPbCvmMG/3tLYlwEQ2OaYYNWXCa3rFBInuA8zBlqtOIENt3ftEQCCQU5MakT2ZHpJcclONllxAigdTDJbAQwHSEj73uXHFSF9DzlpDqPlPpXGuYPkt2uy2vFAjO3FkrSU2OCYG85MW6z3tAI3V0S2nDcJCNOhxkgCUrvuY3j0ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777257115; c=relaxed/simple;
	bh=WmZ8rFbbC/cJ68Nvw+W0i3Fys8rvFt/pqzQym3PR+9s=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=nLgb0vliEigHXxHKh9d1a5FZpsw3SaseFl9Al53Nzn1hBT3PontCkZ9tar14drCWTIyP3X3LnHIB6ItBKYx9rgF/EyKDRvuGgOaMZ/74fWtIRvsmPIKByIGDs86Y8hprfJjq9U/VPfxNgLd1PWs44v7gWUsSwhRhWDB41p7aORY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ultrarisc.com; spf=pass smtp.mailfrom=ultrarisc.com; dkim=pass (1024-bit key) header.d=ultrarisc.com header.i=@ultrarisc.com header.b=E+zw+5eS; arc=none smtp.client-ip=218.76.62.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ultrarisc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ultrarisc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ultrarisc.com header.i=@ultrarisc.com header.b="E+zw+5eS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=ultrarisc.com; s=dkim; h=Received:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:
	References:Date:Message-Id; bh=oX3N68CM0wO9T+kbhhF9OQgbR+Z8QKW6l
	lshw/JFnd0=; b=E+zw+5eSGz6R12mNTc1QJhO4Hwn5UxedfQBPWBGyQ7n14xYkk
	TF+DA5zppkb0rNavzRnA8oU+IbCMJzazD5COspE/Rq7NMWL6BK4huqb/KcWuag/D
	iUhpp7zV7KFwMxhLFsa74RW7z6aYcUiLvUSsXTf6ADIDxv+LE6jL6ddhJg=
Received: from [127.0.0.1] (unknown [192.168.100.1])
	by localhost.localdomain (Coremail) with SMTP id AQAAfwAnEkO1yu5pWv4CAA--.1685S2;
	Mon, 27 Apr 2026 10:32:22 +0800 (CST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v4 1/4] serial: 8250_dwlib: move DesignWare register
 definitions to header
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
In-Reply-To: <aes_zx9GdaXnDNqG@ashevche-desk.local>
References: <20260424-ultrarisc-serial-v4-0-1765a0b4c4a0@ultrarisc.com>
 <20260424-ultrarisc-serial-v4-1-1765a0b4c4a0@ultrarisc.com>
 <aes_zx9GdaXnDNqG@ashevche-desk.local>
Date: Mon, 27 Apr 2026 10:31:37 +0800
Message-Id: <177725709757.1303892.11056150858190690738.b4-reply@b4>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777257098; l=3809;
 i=wangjia@ultrarisc.com; s=20260309; h=from:subject:message-id;
 bh=WmZ8rFbbC/cJ68Nvw+W0i3Fys8rvFt/pqzQym3PR+9s=;
 b=aMw7phVsLJoQFmtsdyicHU+CjeYJwHnjDphId0LYq0zAsyGnbjr0Q4ahx8BSud1NKhjJDawX2
 1lG4FURtJptCG2DGShE7KqUsJrkC2DcL+x/RvAqqttRyo73LGwbDHIa
X-Developer-Key: i=wangjia@ultrarisc.com; a=ed25519;
 pk=XvYkrelqJIIzobY7j+nIg8rsfv5kzaOzuc1UPhd087U=
X-CM-TRANSID:AQAAfwAnEkO1yu5pWv4CAA--.1685S2
X-Coremail-Antispam: 1UD129KBjvJXoWxGrWkGFy3Cr1fZr1fKFy8Zrb_yoWrJw1xpr
	10gFWDtF1qya13W340qanxtr4IqFyxGw409ryFqrWDtFW8Cw1kKFZF9F43KrWUXrn5JrW8
	ZF1UXw1Yga929rDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnUUvcSsGvfC2KfnxnUUI43ZEXa7xR_UUUUUUUUU==
X-CM-SenderInfo: pzdqwylld63zxwud2x1vfou0bp/1tbiAQAKEWnti78ACwAEsl

On 2026-04-24 13:02 +0300, Andy Shevchenko wrote:
> On Fri, Apr 24, 2026 at 01:39:28PM +0800, Jia Wang wrote:
> > Move the DW_UART_* register offsets and CPR bit/field definitions from
> > 8250_dwlib.c into 8250_dwlib.h so they can be shared by 8250_dw and
> > 8250_dwlib users.
> > 
> > Add an include guard for 8250_dwlib.h.
> 
> ...
> 
> > -/* DesignWare specific register fields */
> > -#define DW_UART_IIR_IID			GENMASK(3, 0)
> > -
> > -#define DW_UART_MCR_SIRE		BIT(6)
> > -
> > -#define DW_UART_USR_BUSY		BIT(0)
> > -
> 
> One nit-pick, though, these three need the similar comments in the header and a
> blank line between them.
> 

Thanks.

Will add comments and blank lines in v5.

> ...
> 
> > +/* Offsets for the DesignWare specific registers */
> > +#define DW_UART_USR	0x1f /* UART Status Register */
> > +#define DW_UART_DMASA	0xa8 /* DMA Software Ack */
> > +#define DW_UART_TCR	0xac /* Transceiver Control Register (RS485) */
> > +#define DW_UART_DE_EN	0xb0 /* Driver Output Enable Register */
> > +#define DW_UART_RE_EN	0xb4 /* Receiver Output Enable Register */
> > +#define DW_UART_DLF	0xc0 /* Divisor Latch Fraction Register */
> > +#define DW_UART_RAR	0xc4 /* Receive Address Register */
> > +#define DW_UART_TAR	0xc8 /* Transmit Address Register */
> > +#define DW_UART_LCR_EXT	0xcc /* Line Extended Control Register */
> > +#define DW_UART_CPR	0xf4 /* Component Parameter Register */
> > +#define DW_UART_UCV	0xf8 /* UART Component Version */
> > +
> > +/* Receive / Transmit Address Register bits */
> > +#define DW_UART_ADDR_MASK		GENMASK(7, 0)
> 
> > +/* Line Status Register bits */
> > +#define DW_UART_LSR_ADDR_RCVD		BIT(8)
> 
> Like this one, the IIR. MCR, and USR bits should be commented. Also preserve
> the sorting by the register offset, so the groups of bits follow the above list
> of registers, where USR bits, for example, should go before TCR.
> 

Will add comments to IIR, MCR, and USR bits and reorder the groups by
register offset in v5.

> > +/* Transceiver Control Register bits */
> > +#define DW_UART_TCR_RS485_EN		BIT(0)
> > +#define DW_UART_TCR_RE_POL		BIT(1)
> > +#define DW_UART_TCR_DE_POL		BIT(2)
> > +#define DW_UART_TCR_XFER_MODE		GENMASK(4, 3)
> > +#define DW_UART_TCR_XFER_MODE_DE_DURING_RE	FIELD_PREP(DW_UART_TCR_XFER_MODE, 0)
> > +#define DW_UART_TCR_XFER_MODE_SW_DE_OR_RE	FIELD_PREP(DW_UART_TCR_XFER_MODE, 1)
> > +#define DW_UART_TCR_XFER_MODE_DE_OR_RE		FIELD_PREP(DW_UART_TCR_XFER_MODE, 2)
> > +
> > +/* Line Extended Control Register bits */
> > +#define DW_UART_LCR_EXT_DLS_E		BIT(0)
> > +#define DW_UART_LCR_EXT_ADDR_MATCH	BIT(1)
> > +#define DW_UART_LCR_EXT_SEND_ADDR	BIT(2)
> > +#define DW_UART_LCR_EXT_TRANSMIT_MODE	BIT(3)
> > +
> > +/* Component Parameter Register bits */
> > +#define DW_UART_CPR_ABP_DATA_WIDTH	GENMASK(1, 0)
> > +#define DW_UART_CPR_AFCE_MODE		BIT(4)
> > +#define DW_UART_CPR_THRE_MODE		BIT(5)
> > +#define DW_UART_CPR_SIR_MODE		BIT(6)
> > +#define DW_UART_CPR_SIR_LP_MODE		BIT(7)
> > +#define DW_UART_CPR_ADDITIONAL_FEATURES	BIT(8)
> > +#define DW_UART_CPR_FIFO_ACCESS		BIT(9)
> > +#define DW_UART_CPR_FIFO_STAT		BIT(10)
> > +#define DW_UART_CPR_SHADOW		BIT(11)
> > +#define DW_UART_CPR_ENCODED_PARMS	BIT(12)
> > +#define DW_UART_CPR_DMA_EXTRA		BIT(13)
> > +#define DW_UART_CPR_FIFO_MODE		GENMASK(23, 16)
> 
> > +/* DesignWare specific register fields */
> > +#define DW_UART_IIR_IID			GENMASK(3, 0)
> > +#define DW_UART_MCR_SIRE		BIT(6)
> > +#define DW_UART_USR_BUSY		BIT(0)
> 
> I.o.w. uncouple these as per above.
>

Will do in v5. I'll move them to their respective register-offset
groups with comments and blank lines as suggested.
 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 
> 

Best Regards,
Jia Wang


