Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9842E4AA1CE
	for <linux-serial@vger.kernel.org>; Sun, 18 Oct 2026 13:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792331388; cv=none; b=KL/Koic8XKb9+si7ABj+g2AAvgSl5WjipsBAsCLuk7+RTjPJYINzX3panDGXhkILM+FIzfxhml/1gc5De0qcsxV9XjFlGMVKhfYDMd0cagXGlb4bhMtFVFpSv2oqzWWlkVCkxuhUCtWa+onjJO4VE5J/hB2iS8PF/+2kssPx3YM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792331388; c=relaxed/simple;
	bh=MI5rNeMwhZ43wprmCG+DEgAxLuM2IMPTCnPCyH9xbeQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CqgMatEo4NKf0sNJzzAeWw8j8d33gPltsNh7LZ57dfKpdlWOkd6R3qyOCWBounomEfLnaICE8Wyhv0bd87zqlg8Lu1H/jt5fq/rGhy3UZUBCQLijH3RXhgCkGAJBu95SNB/sK/Cu8ilIUwN5NRAkYU32gCyf9pazeJn7BW93JpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EqzmN5Zg; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EqzmN5Zg"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c2055573c8cso147211166b.3
        for <linux-serial@vger.kernel.org>; Sun, 18 Oct 2026 06:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792331383; x=1792936183; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=j0iP+m3EX5ucikvDp402dsq76Smx73BsFN2IxwK6/bU=;
        b=EqzmN5ZguXXrxRgfMiQuvwrgNp3aYl+s7JPYNRhp2TEmQvuz6/5VSkk5ZRmeRO3gFw
         ErsDvtsdDTrunOsyotzqPXmQSJRiFqbUIS+vHISuVi0DUQlNvx0SkEbdqlmuptYGU9K1
         LOY+8wRkHo9x0g0azzBrWqOyaJvHRkz58vGvihPYW8ne8cTmGmDclJQYmGBbXJS32MmR
         mubntJ+S6eIsd7EID55y8+1j2XLedAbYmbzbpG2Gc0lGcLXQ4R71f0l/6yiUBpc6HUCC
         Y+2YgsDKxAbTnJbhjvlaZMaaPInTn7g82H6OjosOV1Kf9tSSgfDtS48FIzsyKKRlXUfZ
         wu0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792331383; x=1792936183;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=j0iP+m3EX5ucikvDp402dsq76Smx73BsFN2IxwK6/bU=;
        b=mIdwas8KELyv1+1iGNL9NwOvl0BdPmuQ0lie4epgskkXwbudoso1LGOKtxEQo0P67d
         EL3txzdR++cbqdSgqD/aYoO/E3BWWgRJf7FCLw3Ao+SZQFgwHOJ39nAGotryCAGNSM7+
         tGn94O4SH+tfGlMve6AqWtEVNGga7GvuguWAQLpkD/5bcXkItKlPw4EbIndOZvJs2aB4
         WvP0pVjlzU7wfTIcOJh4QQzN8z+dfN8BYnk+59xMOOleaChJe6OgC7mkF9iCeDWS62xL
         kzu5rij9jBAgvAAMvHIvQj9mEwpRLvOvNkYj2eOUvR1da6qSr6BhTudUbkbNW7nhAmYZ
         RO/g==
X-Forwarded-Encrypted: i=1; AKwUvBzO+ijhgjLDRrdsTy5u3LK0Hu97zxbweAV/0BMzapygmvGtiNjs66q+jP5o7s+/Fi09hU+xnNeKPkDT2Gw=@vger.kernel.org
X-Gm-Message-State: AFq9FYLsDrcOaBLW8s8GMo4QQg2odhaQq3KomhM+3V9jIvIwtux99mjQ
	opfdrNouEAXPnXyGp+IYVzaPaoXeFgizJx2lZtg7qzkaqQMrmOUHvnRw
X-Gm-Gg: AYBFou2u4p2fsLc38ORxGYjoe+3m+gTAeWOmrqy3Z0ECo8iaFKMG3CmAjdVHwYHGqI7
	V9ZLWf2gQAwd/7bvjdW8mn94T3MQ2Y+b9p2sYuswPsfJxlqjuKRfWdmMBO2v60nKXO93IH3mSO0
	EzW51OcHbTcDKv4dSRYvmUfx/3obU05ThbqOGT7UvM8j+XK0oTs9MRrsOWrU2l7ExK5DBorEW2Y
	vxIyCV5vhQafBFO1zqstRgvK/vx0xr3XxVGItj7Smz60o/Lh+uVak1KshckB16yQqEAFt1z0vUg
	8sxo8juqwMY+A8JuIacql8G5QJa9lnHB4VCmxAXl/o80TA70/8ZomhWM9KDRTBtWppmfpKzuLG9
	q6Sftx6FKrZlqTQ/56Tx0vb1XN/Yk3L6Oyze5LOso3tbojBkdapw5uJUfP7ISOVBkQVzQXjL34b
	90Xu5rGTwwtq/NOO+fUODda/XQCCSPkrhPDXEKrHbfPaIFKKgCKW62DvlieHhdY9idmAtZAKQmh
	IHaCotGiY+pRUik39jOARZY5RehVmYkHeQlv4o9
X-Received: by 2002:a17:907:c22:b0:c41:1e13:8891 with SMTP id a640c23a62f3a-c419df3e64emr310042766b.9.1792331382777;
        Sun, 18 Oct 2026 06:49:42 -0700 (PDT)
Received: from buildhost.darklands.se ([2001:9b1:ff:d701:51eb:176f:63d9:53f8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c40919c0402sm267678266b.61.2026.10.18.06.49.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 06:49:41 -0700 (PDT)
From: Magnus Lindholm <linmag7@gmail.com>
To: davem@davemloft.net,
	andreas@gaisler.com,
	sparclinux@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	linux-serial@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	krzk@kernel.org,
	oleg@redhat.com,
	linmag7@gmail.com
Subject: [PATCH v4 07/10] sparc64: zero newly allocated IOMMU page tables
Date: Sun, 18 Oct 2026 15:45:09 +0200
Message-ID: <20261018134738.1016106-8-linmag7@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261018134738.1016106-1-linmag7@gmail.com>
References: <20261018134738.1016106-1-linmag7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

iopte_make_dummy() replaces only the physical page field, preserving
all attributes. Applying it to an uninitialized table leaves validity,
permissions, context and reserved bits dependent on prior page contents.

Zero the table allocation before installing dummy page addresses. Keep
iopte_make_dummy() unchanged for unmap callers that preserve attributes.

This initialization pattern is already present in the initial Git
import; the Fixes tag identifies its earliest recorded version.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Magnus Lindholm <linmag7@gmail.com>
---
 arch/sparc/kernel/iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sparc/kernel/iommu.c b/arch/sparc/kernel/iommu.c
index a23105b64fb9..66aaafbf1621 100644
--- a/arch/sparc/kernel/iommu.c
+++ b/arch/sparc/kernel/iommu.c
@@ -130,7 +130,7 @@ int iommu_table_init(struct iommu *iommu, int tsbsize,
 
 	/* Now allocate and setup the IOMMU page table itself.  */
 	order = get_order(tsbsize);
-	page = alloc_pages_node(numa_node, GFP_KERNEL, order);
+	page = alloc_pages_node(numa_node, GFP_KERNEL | __GFP_ZERO, order);
 	if (!page) {
 		printk(KERN_ERR "IOMMU: Error, gfp(tsb) failed.\n");
 		goto out_free_dummy_page;
-- 
2.43.0

