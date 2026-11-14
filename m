Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794640228;
	b=ZuLEvkPaN0vKyWflZbCnzvB2cdSjwUv4B4zSlQBp4cTVErekBIYHi5x7dzYEpPpqasbA
	 Tu4WrzWw3518fCmObRq5KTX45HPV7K34618Y35D53HpwOZtQZfzChUnlJ86/mQNtHtC+Q
	 lDqKImkMMfPmhpGwHvXbyarWnZSpUs0ywDAkR9mWF+bBdN7P+gfCea9T4akF2xQ3WuVkz
	 J9HlYLhKaD+v8VQOm7zBHO+wneJt3k/3sP4bjUpByYE2xZ0O2DVght8R1KLldnStIR1Vc
	 hxwWZqZFxAPbjRa6Q1MgWNZFd2bJhfDjt57B9bwOxwowgWPXpsO4bYZw8WuUx4r24Ig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794640228;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=ug/CLwAsG6XPyYIr9OCoTcVisBprjwnxP+sIccpst3I=;
	b=aj1r/rNs20Q68ksRbwA8l3WXcG9yThc1GNxxVcq3ejEXP5qtHqcTB7UwW8rsSsBwxsOE
	 dUfNJMmQBgGq5aWZHHV3AqnjawFbvpyU1vYYpD1dBoVMv+qd/aOKV+PpzW0Acf0QS41Kw
	 KT9k5MNHfWe8CPCl/CcE0camWkTuI2r8MUmFe/z67SGMJdNZVlhfkJbJv8uTGF9q9D+zR
	 a4cViDfDJQ32jG/jKs8SnURKJgIfjMHphP+IVMAkziJl9Y5r+4jTKKZ46KTmPLdW42Acz
	 HgmwLrndghAWoAKLRWGaw3YtYQRtscNxZBPYavXG6PUdMwDlbFGSk5xDGZ05s6nafUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=e0f1NE1E;
	arc=none smtp.remote-ip=209.85.219.45
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DC8260A5BFC
	for <linux-serial@vger.kernel.org>; Sat, 14 Nov 2026 07:10:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5DC8260A5BFC
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=e0f1NE1E
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-91eb449364cso32557636d6.2
        for <linux-serial@vger.kernel.org>; Fri, 13 Nov 2026 23:10:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1794640227; x=1795245027; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ug/CLwAsG6XPyYIr9OCoTcVisBprjwnxP+sIccpst3I=;
        b=e0f1NE1Exmdl9VHCTyMwen0H8NFFA5ewM0qJqz9IIPFvpUDfghWuuQsLrxK1SzRsz7
         hUQ5k4c56+KPd+CCYf2/vIqRWl8gHz2BKZUrM5Ij4T2/PSEWok0NnE0FUoNCiSoWO8Mq
         GMGUsUR317UBvVBakiAaXs2gi4djBungqVsPEPVmsCYYKAXaOtbrEV2mN7H/GYUItFZG
         FKQhip0+198HqCVpa7oWo0gCnkVC8uPd0d1wG9uCGO/6pyKs254gzQjdaZ9eM/glICrr
         l+E2ixDmEv243sGYSgL1CoNQGZsrUgbQgXYKwaNyBH+knN+wWZHgnaTTI9p959iurBvU
         zUHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794640227; x=1795245027;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ug/CLwAsG6XPyYIr9OCoTcVisBprjwnxP+sIccpst3I=;
        b=GCAoh/nUSOZHuV9emC6DVPG/98I0oc7eLF4i/iqYvxd4ij56IpiJ2hGpxtqVHMefew
         WILiWtWdIFLVvweabYAzbc85ccwpXKEG6H78+rO2ob4dx7b+x1T0ZNYhlUCmFNiMrRNj
         OtSJ2Fm49zLFshEqLdxsEVQm/dLOvr1/fAZXLX75Tq0A2q2sYVZhVzriG2LBUfzqHT3K
         7M2vpFfFS2MA0O8EGL5eUoHu3p0v2AOQ3gsRVzDFxNGCCnNt01YDu8w3NHJvqolYft1+
         AZXRhRRUlWLhjy1vfielaVbbNMjLVzRUC0Oc+U3Fc422DL8zrS2thhIuKVEZkZ+pRa+0
         Hrsw==
X-Forwarded-Encrypted: i=1; AL+hErEPFM8UP+FztVr4V0REIk8T38ZX16kTl+WR9fOcFVHCHSl9I4NpuCs+DY1t6phQgNexLSw0wlZni+9dO8M=@vger.kernel.org
X-Gm-Message-State: APuU4Z91av15p8Wb/w8cTUVnkYFHce6vm0Qd/+9I8You6MTDShAXAF1S
	kryE1gUO8J4Q19jtDwD0JtmE068AQ52PlJjWmmMW6Ik+fVJrNTxicIC1FLUTMTfLWUA=
X-Gm-Gg: AYBFou1rZnXBq5/vI9MlXlRsVPMu9uIC06ceNIsli2Mr3GPoF+7S2z9+ai+feetcOwr
	XIuEK/tS2bERzVks7NwUnqc0LyQHbw28m5RCgDnL1/Q5AZq0EEkLxFJ+wFFhW6MOeasq+KHoxv3
	umhN911uvdVRrVcJ828Bt2jplGPyTKkat0rs2SEpMEjlK7SdLjPac0QvVdLursIZj3HwMp19B99
	WoVGxiFBob/NthRR57gApEb7lVGvEexLnn6xZNJ+JtNZ/hdvAqIMftl/27fzyaE6g43dPVV3e2w
	u1OZI5m9lgLyudH9locxx/xuZHgOqSlAlYwlopFk6D6Kei45J7eaj5pPU+IBL/+MNHN92lqBlSQ
	U2lcj37vdIpnEXXcsD6tOy8DTE47apawMMxcn2zrf/ZsjclxIyVhbHub55d4dOgNojVaajKmH0A
	YDyz05wlAQ0fyTjzAGy43g6Suakb5bobVL1rlOEsQKoW5HQbhflC334Qqce3nf8w431qYZRnBVw
	OpvhuF3zksSvIuyn0PamiSxBPK0G9vFmhWRBXIOePImx9sKVDdRWZ4ifvYOCszFSCZyaCO9Hh9r
	2q6+yh1B02Vuq6T+Gz8+PeJ00fAAq98m14bOL0GgSAGW4AxyHKlEu6cjB/Dgyjes/q1zWL6U5y7
	BV8bqJaFRu2ZTeDM=
X-Received: by 2002:a05:6214:dc1:b0:91f:1bc7:b779 with SMTP id 6a1803df08f44-91f24251f4dmr78714166d6.56.1794640227399;
        Fri, 13 Nov 2026 23:10:27 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-71-191-145-202.washdc.fios.verizon.net. [71.191.145.202])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f23db3a99sm37730986d6.40.2026.11.13.23.10.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 23:10:27 -0800 (PST)
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
Subject: [PATCH 11/22] mm/mempolicy: don't NUMA-hint folios outside common memory
Date: Sat, 14 Nov 2026 02:09:48 -0500
Message-ID: <20261114070959.3490008-12-gourry@gourry.net>
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

The NUMA balancing scanner installs PROT_NONE only on folios that
balancing may migrate.

folio_can_map_prot_numa() already skips ZONE_DEVICE folios. Skip folios
outside the common memory pool (N_MEMORY_COMMON) as well. Do not inject
hint faults on those folios or migrate them.

Convert the zone_device check to a common memory check (which includes
the zone device check explicitly).

All memory is common at this point, so behavior is unchanged.

Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
---
 mm/mempolicy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 662ab420fe03c..619970f0eb954 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -863,7 +863,7 @@ bool folio_can_map_prot_numa(struct folio *folio, struct vm_area_struct *vma,
 {
 	int nid;
 
-	if (!folio || folio_is_zone_device(folio) || folio_test_ksm(folio))
+	if (!folio || !folio_is_common_memory(folio) || folio_test_ksm(folio))
 		return false;
 
 	/* Also skip shared copy-on-write folios */
-- 
2.53.1-Meta

