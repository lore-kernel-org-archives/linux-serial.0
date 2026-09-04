Received: from out28-50.mail.aliyun.com (out28-50.mail.aliyun.com [115.124.28.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BFD13B47D2;
	Fri,  4 Sep 2026 09:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788514383; cv=none; b=V5U60EOOvL9ppkCeN/6BPP+RcKCF9P8A0OrGsOodiU5BIsU0gLZZiIPj34CSzc1tp3i1gjFANqgrvk2VNQ8kt+NCZ2dzMzdLAZEsCJKKz7bFgm8j8VcEbSdwUF5Sw0/SYHKP+u189BAsQzACVeDCOcf2bsURDf558PQWHzvnfqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788514383; c=relaxed/simple;
	bh=uDjNDm2BsPA2C7dcfvbpVkSh1CdS1786TX//1NdaM8M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bX7GZaYGyv/OrHavAFTX2yhp0mpSRb+pJ5Vd7HrykfGlWvulcPovLveiEtTnyhNjrHRMAR9xAVgbuBlN8WmPdIhh7PEeORpZ3ScDLBr3w86qLpi+VlW8xm6QZOMtdb5utuZRUxGSYY+cxFHQOHPxJ1bdlnbtHNRPD+CwMNdDpDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=edatec.cn; spf=pass smtp.mailfrom=edatec.cn; arc=none smtp.client-ip=115.124.28.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=edatec.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=edatec.cn
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07477111|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.107521-0.000494494-0.891985;FP=14267351601926324789|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033032062159;MF=zjzhao@edatec.cn;NM=1;PH=DS;RN=9;RT=9;SR=0;TI=SMTPD_---.j5TQ-sI_1788514373;
Received: from LAPTOP-VQRD5F43.hs.edatec.cn(mailfrom:zjzhao@edatec.cn fp:SMTPD_---.j5TQ-sI_1788514373 cluster:ay29)
          by smtp.aliyun-inc.com;
          Fri, 04 Sep 2026 17:32:54 +0800
From: zjzhao@edatec.cn
To: Jiri Slaby <jirislaby@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org,
	zjzhao <zjzhao@edatec.cn>
Subject: Re: [PATCH 1/2] serial: wk2xxx: Add WK2xxx SPI UART driver
Date: Fri,  4 Sep 2026 17:32:46 +0800
Message-ID: <20260904093246.100569-1-zjzhao@edatec.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <8f8a4946-e8e2-4683-b837-c783c40b81c1@kernel.org>
References: <8f8a4946-e8e2-4683-b837-c783c40b81c1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: zjzhao <zjzhao@edatec.cn>

Hi Jiri,

thanks for the review. Answers and a [PATCH v2] follow; v2 also carries
the Sashiko round-2 findings.

> Have you checked that there is no similar driver which could be only
> extended?

Yes. The only SPI/I2C UART bridge drivers in the tree are max3100.c,
max310x.c and sc16is7xx.c. The latter two implement the 16550-style
register set (THR/RHR, IER, IIR/FCR, LCR, MCR/MSR, LSR) over regmap,
which is exactly what the WK2xxx does *not* provide: its register map
and SPI protocol are proprietary (the sub-UART number and a page-select
bit live in the SPI command byte, plus dedicated FIFO burst commands),
it has no modem-control registers and only supports 8 data bits. Folding
it into sc16is7xx/max310x would force a more capable shared layer to
degrade, and it would mix two vendors into one binding. I take the
kernel's own precedent (sc16is7xx and max310x are separate drivers even
though sc16is7xx is derived from max310x) as confirmation that a
dedicated driver is the right model.

> > +	scoped_guard(mutex, &s->reg_lock) { ... }
> why is this one scoped?

The early return inside made it scoped; that was overkill since the lock
covers the whole function anyway. v2 uses a plain guard(mutex) for
wk2xxx_port_reg_update() and wk2xxx_conf_port().

> throttle/unthrottle, set_termios: this can be a guard too, right?

Yes - v2 uses guard(uart_port_lock_irqsave).

> What's the reason not to use any of the uart_port_tx* helpers?

TX needs sleeping SPI transfers, which cannot run while the port
spinlock is held. The helpers acquire port->lock around the drain, so
they are not usable here; like sc16is7xx/max310x, TX is run from the
kthread worker under a per-port mutex.

> Why not guard?  (handle_tx)  /  And kill the goto then.

Done in v2: guard(mutex) + scoped_guard(uart_port_lock_irqsave), the
goto and the tail unlock are gone.

> Should you perhaps cap the loop count as well?

Done - the drain loop is now bounded by WK2XXX_IRQ_MAX_PASSES.

> return IRQ_HANDLED ... bad for shared irqs

Fixed in v2 (IRQ_NONE when nothing was pending).

> Did you mean to use explicit u64?

Fixed - the divisor computation now uses div_u64()/u64 and builds on
32-bit.

> req + rel are optional. Drop them.

Done - request_port/release_port and their no-op helpers are dropped.

> membase=(void __iomem *)~0 ... compiler/sparse not complain?

Rather than fixing the cast I switched the ports to UPIO_BUS (as
sc16is7xx/max310x do) and removed the membase workaround altogether.

The v2 cover letter lists the full change set. Please review; happy to
iterate.

thanks,

--
zjzhao
EDATEC Technology Co., Ltd.
