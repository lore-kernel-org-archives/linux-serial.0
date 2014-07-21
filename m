From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] exynos: serial clear and set big endian fix
Date: Mon, 21 Jul 2014 18:01:51 +0200
Message-ID: <5011135.PCJ33lEv6t@wuerfel>
References: <1405957832-6444-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.13]:58458 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932543AbaGUQB6 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 21 Jul 2014 12:01:58 -0400
In-Reply-To: <1405957832-6444-1-git-send-email-broonie@kernel.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linaro-kernel@lists.linaro.org
Cc: Mark Brown <broonie@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, Mark Brown <broonie@linaro.org>, linux-serial@vger.kernel.org, Victor Kamensky <victor.kamensky@linaro.org>

On Monday 21 July 2014 16:50:32 Mark Brown wrote:
> +#ifndef CONFIG_CPU_BIG_ENDIAN /* little endian */
> +static inline void __hw_set_bit(int nr, volatile unsigned long *addr)
> +{
> +       __set_bit(nr, addr);
> +}
> +
> +static inline void __hw_clear_bit(int nr, volatile unsigned long *addr)
> +{
> +       __clear_bit(nr, addr);
> +}
> +#else
> +static inline void __hw_set_bit(int nr, volatile unsigned long *addr)
> +{
> +       unsigned long mask = BIT_MASK(nr);
> +       unsigned long *p = ((unsigned long *)addr) + BIT_WORD(nr);
> +       unsigned long val = le32_to_cpu(*p);
> +
> +       val  |= mask;
> +
> +       *p = cpu_to_le32(val);
> +}

This is still wrong, because there is an associated bug: you must never
access pointers to MMIO registers from C code.

The correct way to do it is to use the readl()/writel() functions, or
readl_relaxed()/writel_relaxed() in case of drivers that don't need
to synchronize with DMA transfers.

I think what you want is something like

static inline void __hw_set_bit(int nr, unsigned long __iomem *addr)
{
       addr += BIT_WORD(nr);
       writel_relaxed(readl_relaxed(addr) | BIT_MASK(nr), addr);
}

which is also endian-safe.

	Arnd
