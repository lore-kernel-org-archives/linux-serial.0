Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794640238;
	b=NotyxiEzlIkDVnBWtfGl0l79gXAAkcA9RClScQlgJUC3ESDIerFlav23JynasaD3KkHL
	 3lEXNCsGry272Lx+qRV3p2d8o3gt/jXnRIYHZwkccf2Q5/b0uwX/BnmCW9dV+DlBeSlFW
	 md37KODSx80nsFlpmTYdl7p8ru2IyFCjVzJeEXfHOd5Tfsz3xDnx1sbjNGViosX4fGIWo
	 X3HRO4qeC9UCOn+HROTxXUqFvojjTQgHTVhqhBe2iGUuYb5DrATW07Kn5SfyMRGGlcTWi
	 mn5uNas6F+R4uZMv1OFkPq5bmtXIzyFTLVT5Ms/LJR2O3ojyceF/PQTzSDY8AMB5AlQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794640238;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=kuOKXOl2seY2nuHPa7QaSgImf7rgxxNJypl2yP4/rNE=;
	b=JXxGdI6KcNkTEFSEDKRzC7kIVpC1Q1dh0K9kQMORJiTb+nFc65ET1UTBBL8b0uLjQJNr
	 oP9g6VUKLKcQjo2zbcdbBGOVDSWecxQa7/zDgZK0uu9qUYJp53RMHlPqeOlxrekVm6mHV
	 YbUjbDZZiRW8LcDocLw+KRHoDR4047xgb2hgTl9lYnyFPlNe/QchRHacZetZlJf1oYEKh
	 5HZTGe6OrBOs61AsoNjsRNjvx+z7OMBvmAH6XP7EyPLA5oojfvECaBGp3kBOXbpBiAul/
	 aZPCoHL29X5HSP57r+ZVDPzIF0KpTntkiWuC34G3EralVFHaErvG+SEESqh9/KmQk3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=SHqBm5if;
	arc=none smtp.remote-ip=209.85.219.47
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91738606B42C
	for <linux-serial@vger.kernel.org>; Sat, 14 Nov 2026 07:10:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 91738606B42C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=SHqBm5if
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-91ec2d42231so30642896d6.2
        for <linux-serial@vger.kernel.org>; Fri, 13 Nov 2026 23:10:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1794640237; x=1795245037; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kuOKXOl2seY2nuHPa7QaSgImf7rgxxNJypl2yP4/rNE=;
        b=SHqBm5ifuCi19eDdU6VNqfmX84OjLjh+oaxxPBrlTMKU80mySufaDtPUSv6TTq+zz3
         +Co78G47v6fONadDGxWKcNGUQvCgSrwXJFg8TppF+aZFOOUhKhDRDlDN+xaZiBXJsiWL
         7noGrim9jrxIISpyaZ75eU1EtKup7BugNNCXeDRghcA0y55HF5VFSXgx+LF7yGQw43gl
         GLL3BdlC928/BgZG2pu06rv3+OF8ZRWEogeefHb19bWYkkkKNU3yHRNuGBA6IGU7rTay
         OtcyhxTBnFmqdGbB+seDvJevG79lSnyMnw54BDiFQvk2elI7rbEALpd9fiaBlOif5Kem
         3c0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794640237; x=1795245037;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kuOKXOl2seY2nuHPa7QaSgImf7rgxxNJypl2yP4/rNE=;
        b=LAJsPTgI9WQQBTflTtAO0rjHAFU0rI0fkBrnjYDGOhMS00OBjrGDJ/SYwYDp5f94nQ
         yqYgxY7R4QHE8NZzQpZG9/kFRwdLhRLmhQ3OE3uj9VpwoiGUcQcIedbu2cCcb7WhvINL
         cb4X8eQaVwS61cLLbfMQAiWbqzuWDHBmrFxVnOQB9fGp+k7Yg7EvhuyK+P8FoiAlb1QE
         ITBtfjqNACYU5EGKqDyN4577ljC/2Rccbel58gP3UdAWP4285qwvTd8eeIX+a/f+7orK
         l2inzRiTtlWvICeUMTBzabk9cm8caGnEZbCxhnSclannaqAec4whK4DKj/xcUlWHykmp
         MvWw==
X-Forwarded-Encrypted: i=1; AL+hErFgtOZuAr19W7tVeUwAUEtoi4UpqxXg6KyEBl4KmRf21tqDWac414h8I2RFI89yKp9tVIt8qTbuBPNlgrE=@vger.kernel.org
X-Gm-Message-State: APuU4Z+mH62OyWwn1U5/3zkCsf/KRkSWNvhsygPrebiUjyMBpoBLHswd
	f8DaXvD4Fgd8KitGp7kYl14Ew0SSpNiXF08eWCD/bbn2urgHZ5NjRz8O7R33fxmV4K8=
X-Gm-Gg: AYBFou3qwm2HceQFQUQgveGmnHm30UkjHKKlze2va+wYEUTPoVSkPzNMWTQmbGS1el8
	1foP8TsDAtoQB9q0DgA9vUNlxTvI7oprZjzScFOS2GAerf5y4edB8k2wF3zSeHMAdWLK9KvDPWD
	Rqm1PoiGKWMW7GXSs+GADKUkXnQ7Yb7hT8/fvKi+Hs0tgeVHy2wXW85LrcIMiCXbYIq8ENpbTfe
	qNpQ+Y925s9I6dPwueb5c+XjwL+iPG5Q+OVljEDT1K2aJAQ/l2WfDfBJCN48BadWR05TJbF73ah
	9eYMICswmzgtCC4p02ei4ubGpIN98VCU01YAqzskJ4wMWzfNxUsOchaHyFMqGciuWCS7EwrhUCm
	cKJOWAsrhIDxbE6ETo4yLmdnARPDv92Ze++dAXi1APsFwHSJ6GVRVtrnyP2wBR6gbYflpfEAe24
	9EDpKfAdV3/UncvrcO96W34N4wcFklpUvfBXMIWCz3Kc3nwmbw0dHOZvyZeIVXRDmvyvwlUGGxc
	UlM2VvJQPh6cejn+I/m9iCRyztE4sqxVY8PN33jAThzDGdNpafCKq0ssSnwqC9YERjNEmTXjS1+
	q2d/2qFOG2ff5KrIwKcFrmGlCfzblensAqx3LoHMKng95O62Hi085Jcf1WULGtkjVNBJXAgFekj
	RqW2exwGJ2RDti3s=
X-Received: by 2002:a05:6214:3b85:b0:91c:15ce:66ce with SMTP id 6a1803df08f44-91f24194ac5mr80511276d6.11.1794640236685;
        Fri, 13 Nov 2026 23:10:36 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-71-191-145-202.washdc.fios.verizon.net. [71.191.145.202])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f23db3a99sm37730986d6.40.2026.11.13.23.10.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 23:10:36 -0800 (PST)
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
Subject: [PATCH 15/22] mm/oom_kill: compare OOM constraints against common memory
Date: Sat, 14 Nov 2026 02:09:52 -0500
Message-ID: <20261114070959.3490008-16-gourry@gourry.net>
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

Ordinary allocations reach only common-memory zonelists. Compare policy
and cpuset constraints against N_MEMORY_COMMON, so nodes outside it
neither make an otherwise global policy appear constrained nor inflate
the constrained capacity.

All memory is common at this point, so behavior is unchanged.

Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
---
 mm/oom_kill.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index 5d48bd862c27b..1ec22bdad1fd4 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -274,9 +274,9 @@ static enum oom_constraint constrained_alloc(struct oom_control *oc)
 	 * get_page_from_freelist().
 	 */
 	if (oc->nodemask &&
-	    !nodes_subset(node_states[N_MEMORY], *oc->nodemask)) {
+	    !nodes_subset(node_states[N_MEMORY_COMMON], *oc->nodemask)) {
 		oc->totalpages = total_swap_pages;
-		for_each_node_mask(nid, *oc->nodemask)
+		for_each_node_mask_state(nid, *oc->nodemask, N_MEMORY_COMMON)
 			oc->totalpages += node_present_pages(nid);
 		return CONSTRAINT_MEMORY_POLICY;
 	}
@@ -289,7 +289,8 @@ static enum oom_constraint constrained_alloc(struct oom_control *oc)
 
 	if (cpuset_limited) {
 		oc->totalpages = total_swap_pages;
-		for_each_node_mask(nid, cpuset_current_mems_allowed)
+		for_each_node_mask_state(nid, cpuset_current_mems_allowed,
+					 N_MEMORY_COMMON)
 			oc->totalpages += node_present_pages(nid);
 		return CONSTRAINT_CPUSET;
 	}
-- 
2.53.1-Meta

