Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2DD518FDDE
	for <linux-serial@vger.kernel.org>; Sun, 11 Oct 2026 20:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791749398; cv=none; b=h73Snju8jcOxFkSuJSi5ZGhPvUPhAMzi2xrvs9XQShO30IWziVp/ItVNqTADe9MAJa1uNoUBZm6mfHKmfv5RF0zJjlQCC7d0lXZUbYsmU+OkZUSuHf2YBfzIm2XWg3imR0RC0OGFqunM8CSlfH5X9MPNCQUz7jeVTJtFqIYM2zI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791749398; c=relaxed/simple;
	bh=zpsuHZXGSB0U6SkrXB7Yzaf6Pv9xWHOzCtHifvVCTBg=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=g7mUB3t6LmCfP7xk3T51WNfomOjcVqyU8uKYv6yYlQR0IvnY29nAHLdRDq7RCfAxgDeYM3VS3r0dRZkja9ZbfLsje061Tb1q1HZXqnK4HsmEqZ8AuuCA9IQNvdRRY2pihJr0t7H+gmItdcl8NW2dDvqRDXzD5pQzb6IPYnE6pmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B/64HCuV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B/64HCuV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 604EB1F0089B;
	Sun, 11 Oct 2026 20:09:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791749396;
	bh=Jw0S/T21m+k0JLJUlq1ASybbdCnZApQHxKIHfPzDGuo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=B/64HCuVEWJaGlKvtu5e1vodMfRMTcJHtNvqrvz85iZyZjk5mv5tZKyx1HqjyaUC2
	 2o0VNsVpAAM3rqU/HhI/P/mvdru3ZlyaneA91O5xIHHXE3t+PWHC7C5Q62Y2tmBF+S
	 MqG2vFQO3IfSybPosrE2eErF3DEvn6R9zve8ezyu5fm27Yu8JEbDooLZgN1Cq5smka
	 SmbLlrewlH/MMM0eXxLETiWUsaBIORKukY+jQCN812wpud9a//38OcZaMwIGpbpvN7
	 HxIL3SMxHhQ3Wze6cgJD0NcwExpEGSIj7xqmwMbzWBT99ILmiuhCpFCvkZRYV1KYW0
	 xb9FESbMlkdqg==
Message-ID: <sashiko-outbox-167446@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 5/6] sparc64: add M3000 Oberon PCIe support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Magnus Lindholm" <linmag7@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261011195729.981243-6-linmag7@gmail.com>
References: <20261011195729.981243-1-linmag7@gmail.com>
 <20261011195729.981243-6-linmag7@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 11 Oct 2026 20:09:56 +0000
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] mm: dma_4u_free_coherent leaves stale IOMMU mappings on non-Oberon=
 platforms
- [Medium] sparc64: missing check for irq_alloc() failure in build_irq() co=
rrupts IRQ 0
- [Low] sparc/pci: missing NULL check for 'reg' property array in DT initia=
lizers
--

commit 789a2867a71401d078d82b2a2031ee8cc4266973
Author: Magnus Lindholm <linmag7@gmail.com>

sparc64: add M3000 Oberon PCIe support

This commit adds support for the Fujitsu M3000 Oberon PCIe bridge. It
preserves firmware link setup, handles IOTSB cache line flushes for DVMA
translations, and routes legacy interrupts using the bridge's ten-bit
target ID.

> diff --git a/arch/sparc/kernel/iommu.c b/arch/sparc/kernel/iommu.c
> index 7613ab0ffb89d..9132f0535ce43 100644
> --- a/arch/sparc/kernel/iommu.c
> +++ b/arch/sparc/kernel/iommu.c

[ ... ]

> @@ -253,6 +281,15 @@ static void dma_4u_free_coherent(struct device *dev,=
 size_t size,
>  	npages =3D IO_PAGE_ALIGN(size) >> IO_PAGE_SHIFT;
>  	iommu =3D dev->archdata.iommu;
> =20
> +	if (iommu->iommu_cache_flush) {
> +		iopte_t *base =3D iommu->page_table +
> +			((dvma - iommu->tbl.table_map_base) >> IO_PAGE_SHIFT);
> +		unsigned long i;
> +
> +		for (i =3D 0; i < npages; i++)
> +			iopte_make_dummy(iommu, base + i);
> +		iommu_sync_mapping(iommu, base, npages);
> +	}
>  	iommu_tbl_range_free(&iommu->tbl, dvma, npages, IOMMU_ERROR_CODE);

[Severity: High]
Does this leave stale IOMMU mappings on non-Oberon platforms?

When dma_4u_free_coherent() frees memory, the hardware IOMMU page table
entries (IOPTEs) mapping that memory need to be invalidated before the
physical pages are returned to the kernel allocator.

By guarding the iopte_make_dummy() loop with if (iommu->iommu_cache_flush),
this clears the hardware translation only for Oberon. For other SPARC64
platforms, the hardware IOMMU entries remain valid, potentially allowing
a malfunctioning or malicious device to perform a DMA use-after-free and
corrupt newly re-allocated kernel memory.

> diff --git a/arch/sparc/kernel/irq_64.c b/arch/sparc/kernel/irq_64.c
> index 3f55c69d5f3bc..b0f3b26656d46 100644
> --- a/arch/sparc/kernel/irq_64.c
> +++ b/arch/sparc/kernel/irq_64.c

[ ... ]

> @@ -642,6 +661,17 @@ unsigned int build_irq(int inofixup, unsigned long i=
clr, unsigned long imap)
>  	return irq;
>  }
> =20
> +unsigned int oberon_build_irq(int inofixup, unsigned long iclr,
> +			      unsigned long imap)
> +{
> +	unsigned int irq =3D build_irq(inofixup, iclr, imap);
> +	struct irq_handler_data *data =3D irq_get_handler_data(irq);
> +
> +	if (data)
> +		data->oberon =3D true;
> +	return irq;
> +}

[Severity: Medium]
Is there a missing check for an irq_alloc() failure here?

The newly introduced oberon_build_irq() wrapper calls build_irq().
If irq_alloc() fails during device initialization or under extreme resource
pressure, it returns 0. build_irq() does not check for this 0 return
value and proceeds to use it as a valid IRQ.

This would cause irq_set_chip_and_handler_name() and irq_get_handler_data()
to operate on IRQ 0. Since IRQ 0 is bound to the system timer interrupt
on SPARC64, could this corrupt the system timer and lead to a system hang?

> diff --git a/arch/sparc/kernel/prom_irqtrans.c b/arch/sparc/kernel/prom_i=
rqtrans.c
> index 5752bfd73ac0c..60fd6b0f47e13 100644
> --- a/arch/sparc/kernel/prom_irqtrans.c
> +++ b/arch/sparc/kernel/prom_irqtrans.c

[ ... ]

> @@ -553,6 +556,7 @@ static void __init fire_irq_trans_init(struct device_=
node *dp)
>  	regs =3D of_get_property(dp, "reg", NULL);
>  	dp->irq_trans->data =3D irq_data;
> =20
> +	irq_data->oberon =3D of_device_is_compatible(dp, "pciex108e,80f8");
>  	irq_data->pbm_regs =3D regs[0].phys_addr;
>  	irq_data->portid =3D of_getintprop_default(dp, "portid", 0);
>  }

[Severity: Low]
Does this code need a NULL check for the 'reg' property?

of_get_property() can return NULL if the property is missing or malformed.
This would lead to a NULL pointer dereference when accessing
regs[0].phys_addr.

While SPARC OpenBoot PROM typically guarantees the presence of 'reg'
properties for PCI root nodes, making this mostly theoretical in practice,
it appears to violate the API contract. Other sibling drivers enforce
this check. Should we add a NULL check in fire_irq_trans_init() and
pci_fire_pbm_init() to protect the new Oberon PCIe bridge compatibility?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261011195729.9812=
43-1-linmag7@gmail.com?part=3D5
