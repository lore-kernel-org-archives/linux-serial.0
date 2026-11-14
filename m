Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794640211;
	b=ui4A4w1XmVb4bWsZT7+EdX7QxRoAFyOKBRXidBmEyYNONG99bBAowpyknSREVMs68Wy7
	 fD/TSlBYpXvifcocOcLxZldfx1J4ikFgNs7DUe7AcCdu0LQvpIinngySR+5lRiRdk7LZd
	 j5dg+PnH33xjfp+Fuap1eoX+IVqD8ZJUuo01/UQeM7gxPNl9k9LfLmYrDHg00pBsLT18F
	 brVtP6u0jDWeJdO5hha4912AWlkDo5X8J+7Vy+wJzrKIKptccsUlEjnjCTiR/7z85luF4
	 WBOAuTrhrki+pvgFXQ8cdGDAAjAuuI80dSqhX7NVETvbjES98sEQg5dui2Nhn9tzNxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794640211;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Ra1qoxU4QdTYWMO3cOdicsi3ZqR2JP+4Yyk7L1wLDNk=;
	b=sCU3QB5T5trNPeF2OZuIMueZBnLAq+/8wovSU82oe7d/x+bV+SuCWSVgqHRf4pD8YXhr
	 knlO/E9wpgR7rnfdBgGdQqEmuwAQnclrVY6NU7d+VYJYcsmp6C4a/YJnV+ArQ9kNmas/B
	 jTes3sOwJvpGPENdP8B1oIi6sUzhCzFarzcIgwqFz6azjbuqQBOrCaSQUTsgFVpbxAqA6
	 aoSo5VsXU8gTSlHlKxRkQHM3w7YD0DcMgqEBLVVPs/LYapl7Et5Q9ZcbA72Q8MPjQTM/u
	 sNY5XUrxQjNuxUeKqJytrvtDPB3m4HI4dSUfBIMvY5MoZ+kg6AH+aLgTC7/0j57fC0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=aVufzMF1;
	arc=none smtp.remote-ip=209.85.219.53
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD004606A338
	for <linux-serial@vger.kernel.org>; Sat, 14 Nov 2026 07:10:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BD004606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=aVufzMF1
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-91ea5600c9cso37046696d6.1
        for <linux-serial@vger.kernel.org>; Fri, 13 Nov 2026 23:10:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1794640209; x=1795245009; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ra1qoxU4QdTYWMO3cOdicsi3ZqR2JP+4Yyk7L1wLDNk=;
        b=aVufzMF1ziuixYF2LwjyH7kreUYrlXQnpmHijWkoeW/lvqdaKolzkN+GuWEZ9Elxku
         RmQM/Qd0JknXCOcyFCsoSHle6c93jvb8DGPwDV82hDd+ity5CVzxo6dZ0JwnEVxsoijw
         l73/guNH+o32V7hOir1Y3NVrZQ9xH7aaOudDuml/feYSeQtX1VB/TBSXbWwRm1zVJ4eC
         4SRSkSm9RnIZsT0C3vyFyDFMvaxtRaYsG/xYd/+qSUNiNbPqs9XXNoyYeqSgIdZ/Bx/E
         u2s5+Pw6kq0V8ZrSXVzNReSYfzUzMeJUxU5+RedW1C1ra4crn5FfH525mKnVav04kDdc
         OjqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794640209; x=1795245009;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ra1qoxU4QdTYWMO3cOdicsi3ZqR2JP+4Yyk7L1wLDNk=;
        b=qqJj9M35oAgi/e5bL5cenkzw3ciWIJ+boi7PkssQaa1wMZ2aAWmWKWZp6REKi6tWBu
         1/fyD+PWxwRDxofkYrIJYMhyaWjfzcT4/CUYXM/Nft6cZO4FEcON4sBXFkgSFm0IYEab
         7oIlMgNXeV6fV4EzhMK6EF5aKr5ZNQGsSmQMkBpzXVPUvqaCFOJKgO08BDGdVuVEzsQ0
         0MKSijkqIb2dtZjEWLsAKFA8jw6hC/FghgDRzemSukZexVxxenGSR+9+pybpx46xySkM
         esy5bgl0aSqL6d5soN4CmogYnfYqW1Pf/mICD7ywFTTErciqbSaejrc4Bsl12eANJNY1
         Uabw==
X-Forwarded-Encrypted: i=1; AL+hErHDAPtuhWhAwmxn7zfDYg67FooRSuIjqPSydoa2lNpfo+6lInmCoMXK48D3pIkl9Sip5wOa4MkohH6PVQI=@vger.kernel.org
X-Gm-Message-State: APuU4Z9i3wE3WrkwoJh4AnXbAEb8jT1y/AaWAyR8iZkWZD5loFkRlUVH
	h90f/ILd9gTqxu8xY5qb/UE4qc+9z+Ht3pExYm6u31XL1VYYXCvwJq2dFw5da66FdrQ=
X-Gm-Gg: AYBFou0Q/v+On/YC4hXCTAkfDkPOJxHsfEAz4myHRLf3Nv2pj0GFTa0W9lvj/NaE1XG
	w+H68HqRzNZniIUNuh3lFhBG3T+ubAz9mCyBR2bJXJIeTIHUdNZIfVsFJu6jiFJJe+WcACVnX0m
	bcQWmEWVuXmz1G1bxEWpz9fj0iftIzBNY93FK71JCaeUNmRwxDoHXCTdcizoHfxWKmYC/NoyVfH
	COO5dAkLxltXFONBnuYFhT6ZVVqwUx7t8eHwbEV8sNHMnYsOXjW1FlAwlUhekTY4jBhL6YO4HY8
	jGooeuDsER2Imw/SZZCixWliaipVIUfmI/UmnXxEA41ZY9Ac3ptLSt9H07aC39AjFgAi3l4UOrk
	S1Z98mhV8hjSiqNDNtT+qbsE1kW8FL4Rr16eEtV1xtuJrr2mOjJrQUND8Zq6l0msoo2kUsCaNWl
	29aVXEp6V7l4VoSQSnjzW3g+oTtleElVYgF80GVrYk8ndX9SGtMimEwis8k3uJm2dDXUBtzJwHI
	ukjucO0np5Z1fzxw1yVv4CmNoAnMsej1t3CKPCgbwo37qsNmrpd4BjBc00Czl9cdRdVqJC8X9Gz
	ZaznKYaL3pV0XzZX+fbixIhfkkrdULEwET5tC8Hq/57ZgAkYCbtKAh/33elx1s6PwOjcBtDdg2S
	nMg3IYZ89vawF9VPkhDOqKSTNzFoyXWS+L3BS
X-Received: by 2002:a05:6214:18f1:b0:91f:1a70:4b0c with SMTP id 6a1803df08f44-91f1a70a6famr79219716d6.4.1794640209017;
        Fri, 13 Nov 2026 23:10:09 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-71-191-145-202.washdc.fios.verizon.net. [71.191.145.202])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f23db3a99sm37730986d6.40.2026.11.13.23.10.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 23:10:08 -0800 (PST)
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
Subject: [PATCH 02/22] mm: publish and clear node memory states via helpers
Date: Sat, 14 Nov 2026 02:09:39 -0500
Message-ID: <20261114070959.3490008-3-gourry@gourry.net>
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

N_MEMORY, N_NORMAL_MEMORY and N_HIGH_MEMORY are set separately in
free_area_init(), check_for_memory() and online_pages(), and cleared
in offline_pages().

Centralize those updates in node_set/clear_memory_state().

Behavior is unchanged.

Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
---
 mm/internal.h       |  3 +++
 mm/memory_hotplug.c | 11 ++++-------
 mm/mm_init.c        | 14 ++++++--------
 mm/page_alloc.c     | 15 +++++++++++++++
 4 files changed, 28 insertions(+), 15 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index cd3675c044e0a..608a83c34c224 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -62,6 +62,9 @@ void lru_add_drain_cpu_zone(struct zone *zone);
 void folio_deactivate(struct folio *folio);
 void folio_mark_lazyfree(struct folio *folio);
 
+void node_set_memory_state(int nid, bool high, bool normal);
+void node_clear_memory_state(int nid);
+
 /* mm/vmscan.c */
 unsigned long zone_reclaimable_pages(struct zone *zone);
 unsigned long try_to_free_pages(struct zonelist *zonelist, int order,
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index f04a248d8adaf..490f400498f14 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1184,14 +1184,11 @@ int online_pages(unsigned long pfn, unsigned long nr_pages,
 	online_pages_range(pfn, nr_pages);
 	adjust_present_page_count(pfn_to_page(pfn), group, nr_pages);
 
-	if (node_arg.nid >= 0)
-		node_set_state(nid, N_MEMORY);
 	/*
-	 * Check whether we are adding normal memory to the node for the first
-	 * time.
+	 * Publish this node's memory states, including any newly-normal zone.
+	 * Hotplug never adds highmem.
 	 */
-	if (!node_state(nid, N_NORMAL_MEMORY) && zone_idx(zone) <= ZONE_NORMAL)
-		node_set_state(nid, N_NORMAL_MEMORY);
+	node_set_memory_state(nid, false, zone_idx(zone) <= ZONE_NORMAL);
 
 	if (need_zonelists_rebuild)
 		build_all_zonelists(NULL);
@@ -2146,7 +2143,7 @@ int offline_pages(unsigned long start_pfn, unsigned long nr_pages,
 	 * list. Otherwise this node would still appear in the fallback lists.
 	 */
 	if (node_arg.nid >= 0)
-		node_clear_state(node, N_MEMORY);
+		node_clear_memory_state(node);
 	if (!populated_zone(zone)) {
 		zone_pcp_reset(zone);
 		build_all_zonelists(NULL);
diff --git a/mm/mm_init.c b/mm/mm_init.c
index a9d848c92678b..b4c4dba93652d 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -1763,21 +1763,21 @@ static void __init free_area_init_node(int nid)
 	lru_gen_init_pgdat(pgdat);
 }
 
-/* Any regular or high memory on that node? */
+/* Publish the memory states of a node that has present pages. */
 static void __init check_for_memory(pg_data_t *pgdat)
 {
 	enum zone_type zone_type;
+	bool high = false, normal = false;
 
 	for (zone_type = 0; zone_type <= ZONE_MOVABLE - 1; zone_type++) {
 		struct zone *zone = &pgdat->node_zones[zone_type];
 		if (populated_zone(zone)) {
-			if (IS_ENABLED(CONFIG_HIGHMEM))
-				node_set_state(pgdat->node_id, N_HIGH_MEMORY);
-			if (zone_type <= ZONE_NORMAL)
-				node_set_state(pgdat->node_id, N_NORMAL_MEMORY);
+			high = IS_ENABLED(CONFIG_HIGHMEM);
+			normal = zone_type <= ZONE_NORMAL;
 			break;
 		}
 	}
+	node_set_memory_state(pgdat->node_id, high, normal);
 }
 
 #if MAX_NUMNODES > 1
@@ -1924,10 +1924,8 @@ static void __init free_area_init(void)
 		 *memory-less node. The pgdat will get fully initialized by
 		 *hotadd_init_pgdat() when memory is hotplugged into this node.
 		 */
-		if (pgdat->node_present_pages) {
-			node_set_state(nid, N_MEMORY);
+		if (pgdat->node_present_pages)
 			check_for_memory(pgdat);
-		}
 	}
 
 	calc_nr_kernel_pages();
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 8532af052d74b..834d199ff8429 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -208,6 +208,21 @@ nodemask_t node_states[NR_NODE_STATES] __read_mostly = {
 };
 EXPORT_SYMBOL(node_states);
 
+void __meminit node_set_memory_state(int nid, bool high, bool normal)
+{
+	node_set_state(nid, N_MEMORY);
+	if (high)
+		node_set_state(nid, N_HIGH_MEMORY);
+	if (normal)
+		node_set_state(nid, N_NORMAL_MEMORY);
+}
+
+void __meminit node_clear_memory_state(int nid)
+{
+	node_clear_state(nid, N_NORMAL_MEMORY);
+	node_clear_state(nid, N_MEMORY);
+}
+
 gfp_t gfp_allowed_mask __read_mostly = GFP_BOOT_MASK;
 
 #ifdef CONFIG_HUGETLB_PAGE_SIZE_VARIABLE
-- 
2.53.1-Meta

