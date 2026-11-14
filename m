Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794640242;
	b=JIdiGmta1GEx+FDSCNHzf5gRAe6ntwULOq8UxSN1mkfXJ/HUGrjQsXNVro0SSrh8abxz
	 hlBfZHWOVavDFvmMeED7Xp+MxlIGaUXhywGzMo1xLBQ6sII7Ss8U4545qKfhQbmLO2ov0
	 +ZQeiBQoJV2A8aZWkZ4jmVXpE+ulslEO3hsc8MQHfBO+VerOsFGNWQprdBC5phHQ1v3VP
	 IcBOVH3LPOlhyGv1X5SCoFQ1W1aeBTfM1pTCkUYMdjQLhWDSaF0NjrZ5CMc4HTs34AUs5
	 FsSxj/Vdz0GHqh/3cuJDdT83CUDkpOtLo4jkW6RUx1ajj9SETZLKbfGeXLsqaT25jVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794640242;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Fkzw1dSkiJcsilY2Mokhk9gjBcrzBYNOsKL3JfHFbP4=;
	b=iIju6aVwY0l8Xw+zGvsRgvEhHzzZKnNQ+2ofsNe7TrndnQJfRlgJBoUj4WKHTt8ITm6E
	 ZAl+joSKbQ8Mhe6BEx/b9lmYYJh8T14ztav0TD00X+IXj5KToCNXjo1/6rHkA86loGWbs
	 i58joiSIqnow9GxoUp04PNwBRGIzPVtF3xi3ieV6uH5+F/25g+nkaXI34hFNFujD4yuSa
	 GGGmqOMBdC4eVS4LRog1IVAPg/yARinef87Tgd8V6B0zj+6VBOQG21JY+EASOV9FyPimq
	 FCzYhL2wnKXXlhqsZR/QucZ39TXiXPimiRkzbphAWu8SrP9F9o3EJsJ/kYsb2B8MBtA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=D9A1vsmT;
	arc=none smtp.remote-ip=209.85.219.50
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDBBE60A2634
	for <linux-serial@vger.kernel.org>; Sat, 14 Nov 2026 07:10:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CDBBE60A2634
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=D9A1vsmT
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-91e8938fd01so29669166d6.3
        for <linux-serial@vger.kernel.org>; Fri, 13 Nov 2026 23:10:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1794640241; x=1795245041; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Fkzw1dSkiJcsilY2Mokhk9gjBcrzBYNOsKL3JfHFbP4=;
        b=D9A1vsmTybX5qvyGrrwjuz0qfMhMCmSQaNyn6nnZSRb6LSMt/zZ4S9s3hm+H3FkHCR
         SG2SISoIW0tA/UkIS8ZIjAJYclJ8n15cYdVuyVR0M6TNYjxudXryIGYUlLTffCKApNtT
         L9V7DtX/RDb3IW725jkVaFFLu8fllFC8RUg/BCf/soPXFJdVTjGbGh6Y20jSFnNwtB+1
         d9upU+RfmfzHIX56UPwgbX1+NUg0F/ZhXyF8jpC4BQeYnzkcwImEQnlAEvqtk3JqdpNo
         9XdIJkNyk41TuO3O7wjteZ30+0JtKPuU1KD7fcffJ0Tvt/O93YRyjh6yIdiXMAS5kJPl
         4eRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794640241; x=1795245041;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Fkzw1dSkiJcsilY2Mokhk9gjBcrzBYNOsKL3JfHFbP4=;
        b=aRekMKz1pVPO5Mpq+wxPTCFQW/v8izUWxvKbPnd44WBm9mWKvWTTRA2a7cdWVdwS3U
         bhQJ8kdZNRTiUhTiJ7/5qBXQnNKunKZBMQYTUPNfVsJkDsBn/k/X6rg4NsDaN9uXp321
         jbjnDoccQAzRti7UNjQxEgsRr5QxqsEha9Eg+zVfB9zEhcmJik8hwbr2mYaRO1A8aRD4
         PoHjySqY+edIMYjB0/mAHFoLOivEQHt7zqbwb3z7bQ8wzch5Oh4f1eZ620zv9p2/GXyo
         6vrhAGa3cymNc7CiGnpepHi2AdsfjZWYRpkmyY/sGj/70bbUUI12RSV0hTpMAjeTlutC
         mCEQ==
X-Forwarded-Encrypted: i=1; AL+hErEwR+L4Ycm4i/XKYsD3dQSYT7PDDQ6WdXb6qt/sXr2mb2ejcY4QV3j30W3YNbLpl4o01wG3aXUMeBpquNc=@vger.kernel.org
X-Gm-Message-State: APuU4Z8d8QuzezCQxAy29WBx1FAZx9qBx2FS5wVS3sUZuQbiXbawcMNI
	8q5HjKsRvNyN7Av89H91Yv0KiaWq/4+2E7hu6gT9UiD+4RQPfZpJ+t343bc8CFmSlIA=
X-Gm-Gg: AYBFou2kiCtZiTHRCCCukB6ijyMx97JmUm18OB+p5x4qf+DVGHOlct8GUoboFyuUaN0
	y45w7oHQQc9aaZvfhGA4uWDimZlJA5DV66vp7CmtvfqiyK3zqYli0hQTRdXtMBt/CCQK5OknGCb
	GTKA570wQzUUGLjrLJe2NVCugg+UvbQg5obwhfCNQ92yAlI5Apzy8VUCfMyRaZk8HdtBpv27+Vq
	EyUqn9OiT5Pfx83Zh/nLYwCL9FNEpc0ZVVOq8qOFBLISA9xq7i21t4/vTOKrozvhT1KwSVkEy2m
	J4z+9TXytFHYjkr0t3TxjZgf6leIaTGlFlSxYvhIJzFbg4fE4xjBO9dhXXJghjFV2h8DppctIhX
	SE/YofH2EmmrsGeDyFdGiM4mUG5GV/O+UCX3XAiRUArDBWoEPm+qlxPm2R/yCZUllmQxpnyokH/
	+zqevx91JlmRFWefRMaQeLxDlFk1WuFsTkcbsMPkUvbXIEmRdqZBZPGT1GKJHZImtExazda0pYP
	iiQUwqEMuw2aowGkW8TMdiuXLv49m6O0aoUjyA9rM603Zmoh8nviKWYnnGl2QWWLrYJJzWfe3Tr
	Ly9kbNW+Ku5dDEkPNnMNehVOELEBv2YLcWOzfkdVoJIeanYYc1SfXG9xEIim/217dUXm6akjOHP
	s+EfpfzPFoILbsS0=
X-Received: by 2002:a05:6214:c2b:b0:91c:9086:ee07 with SMTP id 6a1803df08f44-91f2420df31mr81654406d6.38.1794640240818;
        Fri, 13 Nov 2026 23:10:40 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-71-191-145-202.washdc.fios.verizon.net. [71.191.145.202])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f23db3a99sm37730986d6.40.2026.11.13.23.10.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 23:10:40 -0800 (PST)
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
Subject: [PATCH 17/22] mm/vmscan: restrict reclaim to common memory
Date: Sat, 14 Nov 2026 02:09:54 -0500
Message-ID: <20261114070959.3490008-18-gourry@gourry.net>
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

Reclaim serves the ordinary allocation domain.

Restrict it to N_MEMORY_COMMON:
  - start kswapd only on common nodes, at boot or hotplug.
  - walk only common zones in direct reclaim and when throttling it,
    so no reclaimer waits on a node that has no kswapd.
  - walk common nodes when MGLRU registers an mm and when its debugfs
    interface iterates or validates nodes, using first_node_state()
    and next_node_state() in place of first_memory_node and
    next_memory_node.

The fallback zonelists hold only common memory, and all memory is common
at this point, so behavior is unchanged.

Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
---
 mm/memory_hotplug.c |  3 ++-
 mm/vmscan.c         | 26 +++++++++++++-------------
 2 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 29ff2c46499b3..410a29732bae7 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1207,7 +1207,8 @@ int online_pages(unsigned long pfn, unsigned long nr_pages,
 	/* reinitialise watermarks and update pcp limits */
 	init_per_zone_wmark_min();
 
-	kswapd_run(nid);
+	if (node_state(nid, N_MEMORY_COMMON))
+		kswapd_run(nid);
 	kcompactd_run(nid);
 
 	if (node_arg.nid >= 0)
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 061fbd168d982..bb7b1c50bfb78 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2932,7 +2932,7 @@ void lru_gen_add_mm(struct mm_struct *mm)
 #endif
 	spin_lock(&mm_list->lock);
 
-	for_each_node_state(nid, N_MEMORY) {
+	for_each_node_state(nid, N_MEMORY_COMMON) {
 		struct lruvec *lruvec = mem_cgroup_lruvec(memcg, NODE_DATA(nid));
 		struct lru_gen_mm_state *mm_state = get_mm_state(lruvec);
 
@@ -5562,7 +5562,7 @@ static void *lru_gen_seq_start(struct seq_file *m, loff_t *pos)
 	do {
 		int nid;
 
-		for_each_node_state(nid, N_MEMORY) {
+		for_each_node_state(nid, N_MEMORY_COMMON) {
 			if (!nr_to_skip--)
 				return mem_cgroup_lruvec(memcg, NODE_DATA(nid));
 		}
@@ -5587,13 +5587,13 @@ static void *lru_gen_seq_next(struct seq_file *m, void *v, loff_t *pos)
 
 	++*pos;
 
-	nid = next_memory_node(nid);
+	nid = next_node_state(nid, N_MEMORY_COMMON);
 	if (nid == MAX_NUMNODES) {
 		memcg = mem_cgroup_iter(NULL, memcg, NULL);
 		if (!memcg)
 			return NULL;
 
-		nid = first_memory_node;
+		nid = first_node_state(N_MEMORY_COMMON);
 	}
 
 	return mem_cgroup_lruvec(memcg, NODE_DATA(nid));
@@ -5665,7 +5665,7 @@ static int lru_gen_seq_show(struct seq_file *m, void *v)
 	DEFINE_MAX_SEQ(lruvec);
 	DEFINE_MIN_SEQ(lruvec);
 
-	if (nid == first_memory_node) {
+	if (nid == first_node_state(N_MEMORY_COMMON)) {
 		const char *path = memcg ? m->private : "";
 
 #ifdef CONFIG_MEMCG
@@ -5765,7 +5765,7 @@ static int run_cmd(char cmd, u64 memcg_id, int nid, unsigned long seq,
 	int err = -EINVAL;
 	struct mem_cgroup *memcg = NULL;
 
-	if (nid < 0 || nid >= MAX_NUMNODES || !node_state(nid, N_MEMORY))
+	if (nid < 0 || nid >= MAX_NUMNODES || !node_state(nid, N_MEMORY_COMMON))
 		return -EINVAL;
 
 	if (!mem_cgroup_disabled()) {
@@ -6492,8 +6492,8 @@ static void shrink_zones(struct zonelist *zonelist, struct scan_control *sc)
 		sc->reclaim_idx = gfp_zone(sc->gfp_mask);
 	}
 
-	for_each_zone_zonelist_nodemask(zone, z, zonelist,
-					sc->reclaim_idx, sc->nodemask) {
+	for_each_zone_node_state(zone, z, zonelist, sc->reclaim_idx,
+				 sc->nodemask, N_MEMORY_COMMON) {
 		/*
 		 * Take care memory controller reclaiming has small influence
 		 * to global LRU.
@@ -6604,8 +6604,8 @@ static unsigned long do_try_to_free_pages(struct zonelist *zonelist,
 	} while (--sc->priority >= 0);
 
 	last_pgdat = NULL;
-	for_each_zone_zonelist_nodemask(zone, z, zonelist, sc->reclaim_idx,
-					sc->nodemask) {
+	for_each_zone_node_state(zone, z, zonelist, sc->reclaim_idx,
+				 sc->nodemask, N_MEMORY_COMMON) {
 		if (zone->zone_pgdat == last_pgdat)
 			continue;
 		last_pgdat = zone->zone_pgdat;
@@ -6756,8 +6756,8 @@ static bool throttle_direct_reclaim(gfp_t gfp_mask, struct zonelist *zonelist,
 	 * for remote pfmemalloc reserves and processes on different nodes
 	 * should make reasonable progress.
 	 */
-	for_each_zone_zonelist_nodemask(zone, z, zonelist,
-					gfp_zone(gfp_mask), nodemask) {
+	for_each_zone_node_state(zone, z, zonelist, gfp_zone(gfp_mask),
+				 nodemask, N_MEMORY_COMMON) {
 		if (zone_idx(zone) > ZONE_NORMAL)
 			continue;
 
@@ -7736,7 +7736,7 @@ static int __init kswapd_init(void)
 {
 	int nid;
 
-	for_each_node_state(nid, N_MEMORY)
+	for_each_node_state(nid, N_MEMORY_COMMON)
  		kswapd_run(nid);
 	register_sysctl_init("vm", vmscan_sysctl_table);
 	return 0;
-- 
2.53.1-Meta

