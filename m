Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794640244;
	b=OsBcKQRYhxKLVO+VnkU0Gq55ujsmcrnxMglhksg/Q/0viQDeYz6zhWBGT5D0Syl/VNuY
	 Xw0oxpOdp0ZsB2Zz/C9wm49sv+a5Jc0VlRuRENrANUDvL4nQbj5abtuj/+XnYXw/VDuNb
	 q4Q+zPeK5dZy1e7X+WGGMNGjrsSS8DfkowVOm/ehNYu/WNszWZNQb/NMAoKHD86Tvolb/
	 pYzWNJ4uTJDC4DA6JFkSB2sbndpO4cXOIY7FN3oWIRl25pMeFFaud60UH4OOLic/t/+E5
	 kI2d7F2ZY7eP2VzdcAaOpo1You2pbpl4Z7/6ihrnkYHDL/Oqs7TvBF2WG/yCSeQf7FQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794640244;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=QgwyyRUkaLESkoMsTNOOlPxwzMonfztNgfKNstfbYo8=;
	b=EmN+V8ZUX52r3FVKkMAZzqssM4NXCiZcg/9FIFiifOsK1JbIUZOiILa4PHiwK3CpjpM2
	 2zBSNZXkRffW5UAPcN794v7+ckCwMj/yLH2hL/GpCTZPUhk5Qjvmm2HwffO6DCdkC67mM
	 Bk+NA5IjyCXIXx5LsHr3Pdi++GdBHYYNcHxulMBWDYbVwPHXzeqVvuQqjfOIS7GLOabge
	 VWpPwzQqCK4ZHzylwssLAXTnKOBnNcdc6UoId0pSC6aftnL541os0mNsthmXwdUndqvbI
	 VM1Ww6xMBTF5LJD4Zi1HCnS/hZMDGc2MIFM7W8qxr5smhLBossE0pdS7JQGBmMhmQ3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=nYHBg8wX;
	arc=none smtp.remote-ip=209.85.219.49
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1EBE606C0E2
	for <linux-serial@vger.kernel.org>; Sat, 14 Nov 2026 07:10:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E1EBE606C0E2
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=nYHBg8wX
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-91ebf4cd218so27851536d6.3
        for <linux-serial@vger.kernel.org>; Fri, 13 Nov 2026 23:10:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1794640243; x=1795245043; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QgwyyRUkaLESkoMsTNOOlPxwzMonfztNgfKNstfbYo8=;
        b=nYHBg8wXg0qd2OLFeULJZyli7YFLsh+SFzWO7/iy4xXg2aPrsY9G1bQFvrVonOQERw
         aJvSir47vDAVcOgXfyYlBuf0S/W33PrQG26IQfhl+qNXU2KzfyzFtuWqKl3GekADzeHo
         f3OEdVAQ/VfmVo1riPrmlWvEzE4RXvsnxw8s6Waq+F5o/EZvtL4RgvH6N+X+EDg3nNwF
         ADDhjLO6m5evIpLDrNbPNg1ue+RdJAenZ34bGDvXtXkXkzaJ+Bgdqhq+877eIIeEC9CU
         ZVFYfcl2OalMDy77ozKSNndUYB0lOWbg/ZrCb9l9LNs8lgUX++ZjAjf15SyaMF68dMMD
         BPWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794640243; x=1795245043;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=QgwyyRUkaLESkoMsTNOOlPxwzMonfztNgfKNstfbYo8=;
        b=UbAdsdOgcDA/0JQoSkSjLewmmgq2Vtk+KtgxVTwBQ44bgP2Tt+mFZqwPV6KW0g59Qa
         +BoJinocVxMpOsxqaht3PsLxhkn/nKf9IoFvF8WpOaFjyBPmetjMbwavY//CUBrA9Tbn
         B7LZSYs0KVv4SgFLG5SpbBIszxBtMPUlzjU+Kqf+H+kypTE8Y3Mj8BiuYrm8zdt1QKRO
         IFVFpcbVY2A/R/CTNpmXRq9KogKf1/IW0KB3n4rLbx1cQJRIgApisEA/YASH5TQyWLkj
         pb44HHQaQxOwVryb/jXfjcXFiV0mb8znAHn3Q60bekeUuG0vKcMs5yAG+Fd1sqR5B1Gg
         WgJA==
X-Forwarded-Encrypted: i=1; AL+hErEe6cx0IAv55aS3FL01OM5UlSk9YPe/0eHcER0hZp4BBphoU8lyGc/nJHbNJEPDaOzHLdto36j4NlqvZ20=@vger.kernel.org
X-Gm-Message-State: APuU4Z/U0WtQIvu0ZXJIc/XStVaBRlBIuySmmn4lTuAur7xBCzlkIIXR
	NYBn/62+J6pBtujYkKa+hmdb7jIFOjHAJQzF8rS5mENV8rTNIfWRAeANUvBiAnkcfog=
X-Gm-Gg: AYBFou1uCYpCYUBJedDhvg68hpxnDysucpd3V/xrdFNuhPBVs7mOQ0kCYNk1AE93pAo
	kbcweCDoorv/MHuIQHFqZnvWwIbwLGqXIGwhmnKNbb+MDnCs2h3VCCSjzdYZnPn+sUP3j4BR2FX
	hGF4d4NVIgrF0jbRq1ZjLz8eeYXNkwZqXVFk87+3ugtPWPtiL0K9/5BPp1NpIDmb+see8x8m2mK
	iS3gKATjECfM+QSC1dt4vxZu1qtjedJeaSj7OE37EaCmIhPSrtYW51dEVT3Y9URrywoo0XeAOsr
	Yjt4bheFK6eeYfwY2AUnqaIiR7rH5ZDqP+DQEnhDQHjW9ihH3sSsZ+gB/2FWW7lHoO+pdtMmxqd
	yZDoRYSnUzIGvzPJbDV+PSL4ASMMwl17UpD25qUInbtXT5evqAlApTPMP5ef6AkZ41pBH4FkUvH
	2WWhMOoWLVA1ULxhQ2Da3OiSW1LESOhktdODGyZMkKr7bRhatF7Oh/h3BtNLR/xexlsjOr1WIYu
	/eEU64HA0LJbfLzBezsqiy8QwiJLa6jwCoKB1LKzCaAMZHdMdxyCWeWCvsFS5ApW2jkUXIe2jRB
	9YtKVJhIDS63C3vJzr1VBjsmy0nU4hP43zE2oT/Y0D3hl5bwepGCA4rT7Y8oslMTnfDaQKtR5CS
	vTWE1H1w1Sv6jvB8=
X-Received: by 2002:a05:6214:8503:20b0:91f:1498:4e2b with SMTP id 6a1803df08f44-91f24194a18mr55953066d6.9.1794640242842;
        Fri, 13 Nov 2026 23:10:42 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-71-191-145-202.washdc.fios.verizon.net. [71.191.145.202])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f23db3a99sm37730986d6.40.2026.11.13.23.10.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 23:10:42 -0800 (PST)
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
Subject: [PATCH 18/22] mm/compaction: restrict compaction to common memory
Date: Sat, 14 Nov 2026 02:09:55 -0500
Message-ID: <20261114070959.3490008-19-gourry@gourry.net>
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

Compaction serves the ordinary allocation domain.

Restrict it to N_MEMORY_COMMON:
  - start kcompactd only on common nodes, at boot and hotplug.
  - walk only common zones in direct compaction and when deciding
    whether more reclaim could let compaction succeed.
  - compact only common nodes for /proc/sys/vm/compact_memory,
    and trigger proactive compaction only on common nodes.

The fallback zonelists hold only common memory, and all memory is common
at this point, so behavior is unchanged.

Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
---
 mm/compaction.c     | 14 +++++++-------
 mm/memory_hotplug.c |  3 ++-
 2 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/mm/compaction.c b/mm/compaction.c
index 426563acf7acf..6a40e1a9ba78c 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -2496,8 +2496,8 @@ bool compaction_zonelist_suitable(struct alloc_context *ac, int order,
 	 * Make sure at least one zone would pass __compaction_suitable if we continue
 	 * retrying the reclaim.
 	 */
-	for_each_zone_zonelist_nodemask(zone, z, ac->zonelist,
-				ac->highest_zoneidx, ac->nodemask) {
+	for_each_zone_node_state(zone, z, ac->zonelist, ac->highest_zoneidx,
+				 ac->nodemask, N_MEMORY_COMMON) {
 		unsigned long available;
 
 		if (cpusets_enabled() && (alloc_flags & ALLOC_CPUSET) &&
@@ -2855,8 +2855,8 @@ enum compact_result try_to_compact_pages(gfp_t gfp_mask, unsigned int order,
 	trace_mm_compaction_try_to_compact_pages(order, gfp_mask, prio);
 
 	/* Compact each zone in the list */
-	for_each_zone_zonelist_nodemask(zone, z, ac->zonelist,
-					ac->highest_zoneidx, ac->nodemask) {
+	for_each_zone_node_state(zone, z, ac->zonelist, ac->highest_zoneidx,
+				 ac->nodemask, N_MEMORY_COMMON) {
 		enum compact_result status;
 
 		if (cpusets_enabled() &&
@@ -2973,7 +2973,7 @@ static int compact_nodes(void)
 	/* Flush pending updates to the LRU lists */
 	lru_add_drain_all();
 
-	for_each_online_node(nid) {
+	for_each_node_state(nid, N_MEMORY_COMMON) {
 		ret = compact_node(NODE_DATA(nid), false);
 		if (ret)
 			return ret;
@@ -2992,7 +2992,7 @@ static int compaction_proactiveness_sysctl_handler(const struct ctl_table *table
 		return rc;
 
 	if (write && sysctl_compaction_proactiveness) {
-		for_each_online_node(nid) {
+		for_each_node_state(nid, N_MEMORY_COMMON) {
 			pg_data_t *pgdat = NODE_DATA(nid);
 
 			if (pgdat->proactive_compact_trigger)
@@ -3366,7 +3366,7 @@ static int __init kcompactd_init(void)
 {
 	int nid;
 
-	for_each_node_state(nid, N_MEMORY)
+	for_each_node_state(nid, N_MEMORY_COMMON)
 		kcompactd_run(nid);
 	register_sysctl_init("vm", vm_compaction);
 	return 0;
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 410a29732bae7..c8ff60e6417ba 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1209,7 +1209,8 @@ int online_pages(unsigned long pfn, unsigned long nr_pages,
 
 	if (node_state(nid, N_MEMORY_COMMON))
 		kswapd_run(nid);
-	kcompactd_run(nid);
+	if (node_state(nid, N_MEMORY_COMMON))
+		kcompactd_run(nid);
 
 	if (node_arg.nid >= 0)
 		/* First memory added successfully. Notify consumers. */
-- 
2.53.1-Meta

