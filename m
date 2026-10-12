Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9874941DDE8
	for <linux-serial@vger.kernel.org>; Mon, 12 Oct 2026 19:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791831684; cv=none; b=sw350eYdcy9Gjg3gWZb9hd8blHW0vf+miVqTSlYZmQqfsYqj9yhu2HYgL/jIEwCq35cKmWDHzmF0JaAUyOyhGhHdXc8+zCVQU3YgK9QgEP4WXnzmtarvydI+Rw9Q67MnMq/qOr6h9jpoIpL6UpZpWiSkwl2lts1hgpE0vdAfL/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791831684; c=relaxed/simple;
	bh=I/3G9RrfqlF1+k3pGmht+MrluPip/ogMfm7gOtZD0/4=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=AC5W5iUmw5QFFOcXUNicUWUyuR7GtFn+jNM2QlkZCsRuI9E/LPb2YpgEoqekJtx1YnTxY+r62kDQkIq8rzEWL5h0a4yi/Sk1Gz8fKW8Nfz8bW68BVsnIVQki9o1lLg0lmLSkm5/gBjNoFbRkMfz1RAiWNVWDN+ZSsupDCgy/DQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iOAUOi9t; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iOAUOi9t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0443F1F008A1;
	Mon, 12 Oct 2026 19:01:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791831682;
	bh=LxKgyatGbrK4g4LJsGdCkaVl+l7YhOi6HMvKehPtfUc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iOAUOi9tWO7g7Kau3jXcqXRvmC7AMGvpbApXX60urTpuuJv/0/5XqfH74vNtMTdaT
	 3b0egxEmCxwk/jymC5U9Rcj1BA2hyiZ8rVPJzMaGISsuJUgg9QMJBDfsc9RZAF5/Ae
	 8c7bsJ2v6HEdORA2d81O+HhCoCtEFcR8AD0HzNQYZAqoVMEfu8LmXNeYT1wYk5kVpa
	 /bqL7ocC/9MGeGl8u8ZyoRwVg40pkEg3JrS+dl6mrdGroznKkMuAlgAf57bONpT/+Z
	 J0CNUkoW7fsJFezdRD3srCHctrRi3pkpIRz/txuVpkHXwnf7nlX1Vs1aWIr5U0Ivnq
	 uoQvxhLclS6cQ==
Message-ID: <sashiko-outbox-168561@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 7/8] sparc64: add M3000 Oberon PCIe support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Magnus Lindholm" <linmag7@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261012184826.986050-8-linmag7@gmail.com>
References: <20261012184826.986050-1-linmag7@gmail.com>
 <20261012184826.986050-8-linmag7@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2026 19:01:21 +0000
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] iommu: missing IOMMU TSB clearing in dma_4u_free_coherent for non-=
Oberon
- [Medium] sparc64: IOMMU context leak in dma_4u_map_sg error path
--

commit 4df317d4338c546c969a0d6073e2c04be876d4a5
Author: Magnus Lindholm <linmag7@gmail.com>

sparc64: add M3000 Oberon PCIe support

This patch adds support for the Fujitsu M3000 Oberon PCIe bridge. It handles
Oberon enumeration, flushes DVMA translations, and routes legacy interrupts
using the bridge's ten-bit target ID. MSI queues are left uninitialized so
the existing architecture path uses legacy interrupts.

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

[Severity: High]
Does this code inadvertently leave valid DMA translations in the hardware p=
age
table for non-Oberon platforms?

When freeing a coherent DMA mapping here, the physical pages are subsequent=
ly
released back to the system via free_pages(). By explicitly wrapping the lo=
op
that clears the IOMMU TSB entries with iopte_make_dummy() inside the
if (iommu->iommu_cache_flush) check, non-Oberon hardware skips this step.

This could allow a rogue or delayed DMA from the device to silently corrupt
newly allocated memory. Other unmap paths, like dma_4u_unmap_phys(), appear=
 to
clear TSB entries for all platforms without this restriction.

>  	iommu_tbl_range_free(&iommu->tbl, dvma, npages, IOMMU_ERROR_CODE);
> =20
>  	order =3D get_order(size);
[ ... ]
> @@ -577,6 +619,7 @@ static int dma_4u_map_sg(struct device *dev, struct s=
catterlist *sglist,
> =20
>  			for (j =3D 0; j < npages; j++)
>  				iopte_make_dummy(iommu, base + j);
> +			iommu_sync_mapping(iommu, base, npages);
> =20
>  			iommu_tbl_range_free(&iommu->tbl, vaddr, npages,
>  					     IOMMU_ERROR_CODE);
>  			s->dma_length =3D 0;
>  		}
>  		if (s =3D=3D outs)
>  			break;
>  	}
>  	spin_unlock_irqrestore(&iommu->lock, flags);
> =20
>  	return -EINVAL;
>  }

[Severity: Medium]
Does this error cleanup path leak the IOMMU context?

Earlier in dma_4u_map_sg(), an IOMMU context is allocated via
iommu_alloc_ctx(). If iommu_tbl_range_alloc() fails for any segment,
execution jumps to the iommu_map_failed label.

The cleanup logic unmaps the previously mapped ranges and releases the
spinlock, but it does not seem to call iommu_free_ctx() to release the
context ID. This could potentially cause a resource leak, leading to IOMMU
mapping failures once all contexts are exhausted.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012184826.9860=
50-1-linmag7@gmail.com?part=3D7
