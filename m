Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794640224;
	b=revQLn2Vo7BJCR0lsRq5mwnjlEqOFbM8lHSSwvCrRlOw5lnr1dsILRUYn/5ETa3f5hxz
	 pfK3JMWU6xSyofrjvKe3eb34TlXXovhznCW56IQHw2p3Ggo3iQhvvHdlBJ7YDjuHm5hxm
	 D45r5aorxsF8EtuNPs6QCyeutXtq8tY9Ka4cgnYfyZXebW6RDLUzdy+UEcHR4d/+Ps1qE
	 fRII8/QAllamOBy9d/mUNjLv4CX58aZktEDRzpYNjA0dDBXgGuG7xbW7zGtg8iPAuGmxj
	 odbN1GfJQ9nYjojKq14Ha+03HEARG/hTsVGsJIwm/3Vd+e9Sytrf3GVwHPW9WA+nq4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794640224;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Y6oxwUC9/qQIZVXuymnHKur3Vt67CPiMCpmdjljurXM=;
	b=kv5xZIVIxe6Nt+OygvkEXMW1pLdaIfM2EXlRpb9RsGEAuYunWS+VdX2+ro9smOUphJyg
	 RU4byDORljjeNG0ofXOgKE86P4x21Ds9lq18fPNTbKswwZE7SnfnwOxRyp3Wj2Zv0DV+D
	 XxlNSa1VyFK8kDWlzCev1HfoAH6cJZU5p8VjjZgh42ZvTeTwyWNswr4GgTMgcknbCqIf4
	 m4PM3Pp8PEi3KlKYQSVNq2cah+DpbdIgKyYm5ATWJideAfR2nUK8p7IaIxDUpqLDzhynU
	 wZzaeCo+pmdz1RGwSb2PYFDHr1/LTeb5CHdRpXVwbdufJtEHl62UNNGUcStfROHeINA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=XlayBPV+;
	arc=none smtp.remote-ip=209.85.219.44
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D485606A33D
	for <linux-serial@vger.kernel.org>; Sat, 14 Nov 2026 07:10:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0D485606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=XlayBPV+
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-91ecbdf5343so39949136d6.0
        for <linux-serial@vger.kernel.org>; Fri, 13 Nov 2026 23:10:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1794640223; x=1795245023; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Y6oxwUC9/qQIZVXuymnHKur3Vt67CPiMCpmdjljurXM=;
        b=XlayBPV+6O94G4EvOv/apyiTo3m5/u93nKnLcvDMZ5IZPd0h+zJdRRruMsVEzi3WoC
         z+Si2hEa+Ua87rapVuCjiDYM3x1e6qBeqGGKaT+0sgS14MzxbWyx2Ucw9pF8mizmV1OF
         i/t/Oeuq2KCow2Q0aWnwaQcVV2jadem/GeVnEOD0NFZfkI+oaWFfXNpjKd+lsCUarnli
         6377+lF8LMdQhAtCoZ7vh4YMKQp23DrTIh9X0RMqS66GPLHgLk13lDoRAz5VubUIW3tN
         IQtaAGEJaTre22tDiHAkUzUrRrP/waHscFQx+6pylgrnkPGeI2Z6Qg3IFhDHNBbaaDlL
         nLIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794640223; x=1795245023;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Y6oxwUC9/qQIZVXuymnHKur3Vt67CPiMCpmdjljurXM=;
        b=QlZuxOjHtFrXOOnf6cUf9gIkEbKseGqdxV11JVywykJS3mUI3DezVEa5rb7GHGCkkQ
         Gnm7h5JOEgcL/gchM8aSX+rF9RcvSX3qq4j0naDE5uCEDvridbWQ5T2iCJzQEdh3Df66
         8HOK4myIgvM7faH0Lzyt5FtKYseenjs/ePvCNveHlI8VsCADtoskYB0SJdwffBi4gBe4
         GehgFbaBFRFs1rDIzfcRiq1OmSJXH6nl/AY8Sh04HxIvdrLVkFAKIlmOTbJZziTwyCyA
         q2Jf2jmF/kZ6tMbvIxG7LaMZBT+N+Lz4Zn+EBaBgx6xCM0v1tRBxDhjkz9BiscZ4Iqe0
         Qf+Q==
X-Forwarded-Encrypted: i=1; AL+hErHf8ZS0SWpabn9TSijCZO25oWv7iIK0OjA+6/Mfw3+HmpYbEGplsKNUVgIuK6S0DN+bVS3ciAk+93pfvek=@vger.kernel.org
X-Gm-Message-State: APuU4Z/GoVQkQkghIrpC0GUTfHOviJWTTtuNZLtZWLHnIX+J6UfgHpWc
	EAToO9dk8WG4BrE6do4n4HMmiTkQMUjYJo+fENWWWXCKivq9a7jSZ1ljWemZKbbFun0=
X-Gm-Gg: AYBFou1j3oI+fc08l7K2Cwyfpbpia9eQZL+ggSHV3d0TbCYujmi/2R12gwTE5AEIMo4
	7Eagdf7pkxAmv2s82N9YrBZKT+z6eIDaLgWAV6Ei3gsu/mhDS8HG4Zo+Y1hjo/OUYt6OmwLSfPg
	9NQ92o1qoI13pXdV6i2mAk28G6SnBbDDtYRuo2iw/Z7giKzEH8zcGwEB5ruGSukgdrufR4dnU2I
	6m47iKG21Avswe0w0MMHgf9yDgjPahyxuCWkp3w1hh6A+K7ieZoPRAbZgyyzbEjlHjHj2+a10R7
	KuhdOS6PSD5Gj5RL3jnGjcqSslT1iHs56GSkqCmWK02DjmJBws4YYewpcNz4zIluytAMzEvqvWM
	gjCn9pgjqQyJHTJUULaV6+LJGMEe4CCj6HQlW2TOqDr+A0Nrnz6GQaLcQATeTAJgKcg+ySIrbNV
	LigEEfVvL6R/AXN9tz6kzlk2AhOANbt58qtcsSp+g9W7bqQRZbeqsB1DllCNVOyaggeQmTAApVz
	JJs0UoMZV4jckKvV860F4Mmr5IxHqlU5A8CIzO9OI215uSEGU/sCnE7G1crnv+ylvRFxCNnUYcf
	rDDLYZKezso7Mo1pX1CLLZjBnrJ28RJifJPvbhvjS7PgqrN0ikkxUNkblvcL1sHoDjtQSzlLeVi
	OpvphO9tYEru05jI=
X-Received: by 2002:a05:6214:2462:b0:91f:3182:e94e with SMTP id 6a1803df08f44-91f3182ea72mr35908656d6.8.1794640223087;
        Fri, 13 Nov 2026 23:10:23 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-71-191-145-202.washdc.fios.verizon.net. [71.191.145.202])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f23db3a99sm37730986d6.40.2026.11.13.23.10.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 23:10:22 -0800 (PST)
From: "Gregory Price (Meta)" <gourry@gourry.net>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	linux-doc@vger.kernel.org,
	driver-core@lists.linux.dev,
	linux-serial@vger.kernel.org,
	linux-pm@vger.kernel.org,
	damon@lists.linux.dev,
	linux-cxl@vger.kernel.org,
	akpm@linux-foundation.org,
	david@kernel.org,
	liam@infradead.org,
	vbabka@kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	rdunlap@infradead.org,
	gregkh@linuxfoundation.org,
	rafael@kernel.org,
	dakr@kernel.org,
	johan@kernel.org,
	jirislaby@kernel.org,
	kasong@tencent.com,
	qi.zheng@linux.dev,
	shakeel.butt@linux.dev,
	baohua@kernel.org,
	axelrasmussen@google.com,
	yuanchu@google.com,
	weixugc@google.com,
	baoquan.he@linux.dev,
	baolin.wang@linux.alibaba.com,
	yury.norov@gmail.com,
	linux@rasmusvillemoes.dk,
	pavel@kernel.org,
	lenb@kernel.org,
	hannes@cmpxchg.org,
	brendan.jackman@linux.dev,
	ziy@nvidia.com,
	sj@kernel.org,
	muchun.song@linux.dev,
	osalvador@suse.de,
	nico.pache@linux.dev,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	lance.yang@linux.dev,
	usama.arif@linux.dev,
	kas@kernel.org,
	xu.xin@linux.dev,
	chengming.zhou@linux.dev,
	gourry@gourry.net,
	joshua.hahnjy@gmail.com,
	rakie.kim@sk.com,
	ying.huang@linux.alibaba.com,
	matthew.brost@intel.com,
	byungchul@sk.com,
	apopple@nvidia.com,
	rientjes@google.com
Subject: [PATCH 09/22] mm/ksm: restrict merging to common memory
Date: Sat, 14 Nov 2026 02:09:46 -0500
Message-ID: <20261114070959.3490008-10-gourry@gourry.net>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261114070959.3490008-1-gourry@gourry.net>
References: <20261114070959.3490008-1-gourry@gourry.net>
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

KSM is an opportunistic MM service and should leave memory outside
the ordinary memory pool alone - as it already does for ZONE_DEVICE
folios at each acquisition point.

Use folio_is_common_memory() at those same sites, which still rejects
ZONE_DEVICE folios.

Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
---
 mm/ksm.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/mm/ksm.c b/mm/ksm.c
index 623a2cdb39242..25b2c2f944862 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -831,7 +831,7 @@ static struct page *get_mergeable_page(struct ksm_rmap_item *rmap_item)
 
 	folio = folio_walk_start(&fw, vma, addr, 0);
 	if (folio) {
-		if (!folio_is_zone_device(folio) &&
+		if (folio_is_common_memory(folio) &&
 		    folio_test_anon(folio)) {
 			folio_get(folio);
 			page = fw.page;
@@ -2571,7 +2571,8 @@ static int ksm_next_page_pmd_entry(pmd_t *pmdp, unsigned long addr, unsigned lon
 				goto not_found_unlock;
 			folio = page_folio(page);
 
-			if (folio_is_zone_device(folio) || !folio_test_anon(folio))
+			if (!folio_is_common_memory(folio) ||
+			    !folio_test_anon(folio))
 				goto not_found_unlock;
 
 			page += ((addr & (PMD_SIZE - 1)) >> PAGE_SHIFT);
@@ -2595,7 +2596,8 @@ static int ksm_next_page_pmd_entry(pmd_t *pmdp, unsigned long addr, unsigned lon
 			continue;
 		folio = page_folio(page);
 
-		if (folio_is_zone_device(folio) || !folio_test_anon(folio))
+		if (!folio_is_common_memory(folio) ||
+		    !folio_test_anon(folio))
 			continue;
 		goto found_unlock;
 	}
-- 
2.53.1-Meta

