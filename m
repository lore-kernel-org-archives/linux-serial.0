Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794640227;
	b=4gMaCLU3GEEqUE84Qeeld31aQMseAwvdCW22J8zEtBsLAbS7ZD83WMfDSPW0qy191Khg
	 5vDQAkhmLfUdbnYtGspvf9dDaOwB98iHSvdXJSdxtAvgWtopScNf18bR+PNWPzEK90aIX
	 A/GRD6JkwO88GpmasmoVuKYJxhKlL+/EezapHr8jnsrEO9A4tm4R6frMMm7UX0EOcErui
	 R9axxrFXwqchFQvafd+/VeA0AfvYizsTxCI8+PPlxNWz4KypN5jJYAS+YCn9c43E5nW0o
	 cY6n74XknP1piXAzmZBdo18gSTHNqM35iQ0JoeniYAmpO85AXoUwR8ASWPndCDZQE1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794640227;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Tt496ll4IbdlqeCDi3ioSW9/vXDsw+lkgrGBEmtKDJU=;
	b=qcbayeHQxMvC5H396j8uFZvDmdBNh9b8lSdMtc/gXf4smVVSVETMvjMfpEae7zmUq2bv
	 g6sN9OSzhJb+2I8mcFc+L3n0K6qzzW5LF3s6Hscl+C2JmgIKlklmRcNTDvWq7eGIVlAhF
	 Qc/A57jRPJT3zGJI887nCNXWWY6FLDY2KrREF9Q62s/E9naH5mgjFvKiAF2Dm1YC9ssd/
	 Uovn18vuyNZeX+P9rzHmsYcQWrwhhU9Q8Emqu05UoJ2Ib6/K1WPE8kmSglnJCGxOVgI4i
	 f44GH8ob9d1gtryvTIEQObb6h4O5g4Aape2wwu1VFnobbqhfOh6GR5p9PUmFA4TRn3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=Wak6pwPF;
	arc=none smtp.remote-ip=209.85.219.47
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A524E60A5BE3
	for <linux-serial@vger.kernel.org>; Sat, 14 Nov 2026 07:10:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A524E60A5BE3
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=Wak6pwPF
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-91f23ddf32fso12082326d6.0
        for <linux-serial@vger.kernel.org>; Fri, 13 Nov 2026 23:10:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1794640226; x=1795245026; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Tt496ll4IbdlqeCDi3ioSW9/vXDsw+lkgrGBEmtKDJU=;
        b=Wak6pwPFiUkKyhQgMf4rS7ScgYnhLHPu/BQFbJsFq7WKKXSUOmiu+EsQFsjVZ8zFDO
         FDrlS7y+5O55UEGv/kTSaX8dffsOnEXEa6/2U/GCtWcFwv0S/O1x4yRSmj13AtftFa/d
         2LHhZ1Xzh9y1vx57sBVWmEQqxXZeF/gRFDaivKFbqeTHuyd1MOWBIFDDx6qnA+nzwI3j
         f0FWi5bqe5XptEAAFE0ZLXHTalZ4ObmYUba1bTQ7a5ucsWoZ5b9b8qD9ay1zcLACOuUw
         HN4jHEZ3DD/E9fTfoTkj/qDM3H/u15Vo16V1SDswP6q5IvcI5vpIGBny10cK9BBE6q/X
         KPYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794640226; x=1795245026;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Tt496ll4IbdlqeCDi3ioSW9/vXDsw+lkgrGBEmtKDJU=;
        b=sZk2A7z81yLiVRtl3Lr59C212nTapHiRlyIqd/vRTzmlps+vZrFLy8ELX74xmbVvqC
         D6x2zMpKirGmBrzyljddhYsZ6VaP9wlSJTcvRJhP78PloNd6bmvX2AOfNbcOlWiz9Lk+
         rSqyEYhHTNfGiTMPbYrDATN0We3G/eQWVTGUc8lKNdzHwRfXb6kE5NFN70LouL1uuCel
         CnLa1UtAYDEOhDenKt5fc4nIrZGBcVnnShxv+xjDw+O6BoOngYEzYrLOnOMB4Udt7NAp
         ClcjwluMBsnyZ4E8jBCC3nP4n40U+THIE7R6DePXMnWHQ8fy6JSz14xOPRKRpWzvWcDc
         i2Fg==
X-Forwarded-Encrypted: i=1; AL+hErGFcxLuZ+E5sM51uRqCZE6e6sQi2IYIRxFIoGytFo4x1JR9o6co7yiB8rlA1i3TGPpWdRg9YnL5LppERqY=@vger.kernel.org
X-Gm-Message-State: APuU4Z++otf7h+FiBXjYEq2g2wH8zIsIwQLsp8+f/HZ7ZCY3dP3sjKxv
	p8q22RdQjesb8H8QFBfxDrfPeXhHxQfcJJ57w0dgdsIOeipsg0/Q0tZn8zhKK18GJmY=
X-Gm-Gg: AYBFou3nySW+Pq/vGxvWLSk998JtV6XZ0Y4ItJzJxCXYywbPjgTAxiNoo0unDk/gpXj
	53SAdN5r8a/eYtiUH3TKkGYDLJmBqLRB2IG2sOHNsmZNpqCz+FwLXAqLYli4/8yw3CAXBsQNXGq
	WpHVxCOpg2Ct0pGst+C4mkEjvT1IfsngcdLPlfER8xV2JMB7QHZCvi0hsJAqbO40E0bGC3yuWTk
	FhInulFDC8iJx7EtL8WC1pqgBD0wvf6wNfS+VbvMu9knze4fIl75KV9otVUyaDzZOEsgkyC2xqr
	giMbG3eq29ANq80+Ly1DDkj3cXPati89MTZGad0aICVK5LCaOOmRNXw6cFBySpUPHlL1Kz4YqWO
	IdV2Bx2jEzls4oD1SbwIE5XDHbi04tPmrZf0iu2YhLEXrEEKODbWQmsq5uezxNYrjrUNyMpWAF0
	b5LQPrlD35/jahgVG5XQSiIJAwjQ0eaN8s5gSNQgpvHztbyMUQ5mAU8iLq0DEmMdTS3aw8XdD5y
	JENewaPiNmMXXk0p0z5Clklc80lxRsamnz+j+W5pgDWrSNp5vjaKqAOleqVoClteEOQNMDH3e9K
	k4rN9OuZv8pFos9lypaZI7hJ57ohEuoegOwwlbDi48wWjza/ocu4qq13csRuRac28K/rRlKwehI
	i3gFrWVZKzemm2Ps=
X-Received: by 2002:a05:6214:e8a:b0:91e:7bb7:fd65 with SMTP id 6a1803df08f44-91f24292699mr81332616d6.56.1794640225203;
        Fri, 13 Nov 2026 23:10:25 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-71-191-145-202.washdc.fios.verizon.net. [71.191.145.202])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f23db3a99sm37730986d6.40.2026.11.13.23.10.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 23:10:24 -0800 (PST)
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
Subject: [PATCH 10/22] mm/khugepaged: restrict collapse to common memory
Date: Sat, 14 Nov 2026 02:09:47 -0500
Message-ID: <20261114070959.3490008-11-gourry@gourry.net>
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

Collapse is an opportunistic MM service and should operate only on
common memory. The anonymous scan and isolation paths already filter
zone device for the same reason.

Replace the zone_device check with page_is_common_memory().

collapse_scan_file() gains a folio_is_common_memory() check. Page-cache
folios are never ZONE_DEVICE, so there it only filters memory outside
N_MEMORY_COMMON.

All memory is common at this point, so behavior is unchanged.

Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
---
 mm/khugepaged.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 4bbe319ef86fa..b4bd29f25c145 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -628,7 +628,7 @@ static enum scan_result __collapse_huge_page_isolate(struct vm_area_struct *vma,
 			goto out;
 		}
 		page = vm_normal_page(vma, addr, pteval);
-		if (unlikely(!page) || unlikely(is_zone_device_page(page))) {
+		if (unlikely(!page) || unlikely(!page_is_common_memory(page))) {
 			result = SCAN_PAGE_NULL;
 			goto out;
 		}
@@ -1673,7 +1673,7 @@ static enum scan_result collapse_scan_anon(struct vm_area_struct *vma,
 		}
 
 		page = vm_normal_page(vma, addr, pteval);
-		if (unlikely(!page) || unlikely(is_zone_device_page(page))) {
+		if (unlikely(!page) || unlikely(!page_is_common_memory(page))) {
 			result = SCAN_PAGE_NULL;
 			goto out_unmap;
 		}
@@ -2741,6 +2741,12 @@ static enum scan_result collapse_scan_file(struct mm_struct *mm,
 			break;
 		}
 
+		if (unlikely(!folio_is_common_memory(folio))) {
+			result = SCAN_PAGE_NULL;
+			failed_pfn = folio_pfn(folio);
+			folio_put(folio);
+			break;
+		}
 		node = folio_nid(folio);
 		if (collapse_scan_abort(node, cc)) {
 			result = SCAN_SCAN_ABORT;
-- 
2.53.1-Meta

