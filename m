Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FA591C2AA
	for <linux-serial@vger.kernel.org>; Thu,  8 Oct 2026 13:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791466703; cv=none; b=VPgA6hL6dhQegVnMMEpvIYUMjdDPr/TQ9fIOMxqY5k/lTQfmniVkCmXpwTGgjLarmXxZpBTBLnaXYVwh2noig1+pSqdejHif+QSPfwEprymX/AHSwgtyxMIjL6tuBPooEgtjoarhiLPdh5gG7XMq69WHZYmT+jpnyA17LEIi34w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791466703; c=relaxed/simple;
	bh=+m8UkgRzKiqSxkTM0qS9zwhNtb/dJW/V7VSfdQfemZQ=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=U6InXe1novIFtbHtdCbVjTCiiWIr+dCoxUm67l01fF1e3OvoF7Hrqe2KlfmcRlQA3lmTW9y7sb/PvGhvlR4AZw5pkBwqDbZXu9YWPZrSOiftTuYGqxP20xo24kDe9KGrtRmbIjFHQ9NbWLoV6h7+UKx0Q86FVGglWSFc4488hjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H9QIe5xd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H9QIe5xd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E47D31F000FF;
	Thu,  8 Oct 2026 13:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791466702;
	bh=G13WZnpCoDuFDawwZshCS2Z/SYryoCU5rHgUp3RUdaM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=H9QIe5xdyHjcm+zjk/L0EjfuKyykKU7zTHbSnSnEgaoQblzCvC84BdN/AfecxCPH/
	 9ZxWDUWN6mEoLrplk2pk8bsnVE5W4U+0pG3xYLHVvDZJfHHKp8DKVYK/THzVLTO+WA
	 OR23j72n+xjODzxydGEfmZec3TvL//vRHLpTbJKk9J2oN2yINkNVPtoWal+CsqENV4
	 nchbDfUdU/sy96XEG8EsTSDCrTxCM/9IQb0XlHXLSzmQp/KMnpYgrYmzA6yEbAwY8G
	 ZzMZNWCPUmvh5In0YDph2WeZPKHlvKu3pIrvhXEyN5rRM8RYjWQkimymciW6+hmCTa
	 nEhZ5FInIFxHQ==
Message-ID: <sashiko-outbox-164226@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] serial: 8250_pci: Add support for ASPEED BMC VUARTs
 over PCIe
Reply-To: sashiko-reviews@lists.linux.dev
To: "Phil Rosenthal" <phil@phil.gs>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261008-aspeed-vuart-v1-1-d2be17c99cd7@phil.gs>
References: <20261008-aspeed-vuart-v1-1-d2be17c99cd7@phil.gs>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 08 Oct 2026 13:38:21 +0000
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] tty: lockless read of UART_LSR during resume destructively clear=
s receiver error bits
--

commit c43e6e51b74f249795f1e627ed53624daf3d509b
Author: Phil Rosenthal <phil@phil.gs>

serial: 8250_pci: Add support for ASPEED BMC VUARTs over PCIe

This commit adds PCI driver support for ASPEED BMC virtual UARTs, allowing=
=20
them to be used for the kernel console and getty. It polls the ports due to=
 a=20
lack of interrupts on the tested board and probes for the VUARTs using cust=
om=20
initialization and setup quirks.

Link: https://lore.kernel.org/r/20230823173104.3219128-2-ninad@linux.ibm.com

> diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250=
/8250_pci.c
> index 6e53d6d72a8e2..8c243c4fd58a9 100644
> --- a/drivers/tty/serial/8250/8250_pci.c
> +++ b/drivers/tty/serial/8250/8250_pci.c

[ ... ]

> +/*
> + * A live 16550 can read LSR as 0xff, but never IIR, whose bits 4-5 are
> + * reserved. Only read IIR when LSR looks absent: reading IIR clears a
> + * pending THRI, and this also runs on resume while the port may be in u=
se.
> + */
> +static bool pci_aspeed_vuart_present(void __iomem *base, unsigned int of=
fset)
> +{
> +	void __iomem *regs =3D base + offset;
> +
> +	return readl(regs + (UART_LSR << PCI_ASPEED_VUART_REGSHIFT)) !=3D ~0U ||
> +	       readl(regs + (UART_IIR << PCI_ASPEED_VUART_REGSHIFT)) !=3D ~0U;
> +}

[Severity: Medium]
Does this lockless read of UART_LSR destructively clear receiver error bits?

While the comment correctly notes that reading UART_IIR clears a pending TH=
RI,
reading the Line Status Register (UART_LSR) on a 16550-compatible UART will
instantly clear the receiver error flags (Overrun, Parity, Framing, Break).

> +
> +static int pci_aspeed_vuart_init(struct pci_dev *dev)
> +{
> +	void __iomem *base;
> +	int i, n =3D 0;
> +
> +	if (!(pci_resource_flags(dev, PCI_ASPEED_VUART_BAR) & IORESOURCE_MEM) ||
> +	    pci_resource_len(dev, PCI_ASPEED_VUART_BAR) < SZ_4K)
> +		return -ENODEV;
> +
> +	base =3D pci_iomap_range(dev, PCI_ASPEED_VUART_BAR, 0, SZ_4K);
> +	if (!base)
> +		return -ENOMEM;
> +
> +	for (i =3D 0; i < ARRAY_SIZE(pci_aspeed_vuart_io); i++)
> +		if (pci_aspeed_vuart_present(base, pci_aspeed_vuart_offset(i)))
> +			n++;

[Severity: Medium]
Because pci_aspeed_vuart_init() is mapped to quirk->init, won't it be invok=
ed
by pciserial_resume_ports() during system resume?

If the port receives malformed data or experiences FIFO overruns while the
system is resuming, will this iteration clear those error flags locklessly
before the driver's interrupt handler or polling routine can process them?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261008-aspeed-vua=
rt-v1-1-d2be17c99cd7@phil.gs?part=3D1
