Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794640208;
	b=d0TiiCdegU2yQRMlq2BUMkFJOsCYKXdcAvrBFB+7EOafv5nGnt4WdQj7PRULKo7iwOd9
	 qnULNRIKV8ARevFXjVfeoY94fEC87MG590Ih7uHc8UHJ4DJcVXeLAM1XshDIGlsgkQ5DD
	 3JGSlZd7buEjTj1nRtsyXN6cw0QRcmECJRozsZnOKug3xsaJVaFsj6TU+3XLnA3yDRTln
	 qO8NqlX8t5rjpQo1xpH5Xt7E/cSGaNgEhNRW1ag1MiUTKlIHJORgAGZbwl7f+MkNeYg3Y
	 HK65kmwJLRMf+klAvmBNQheRjnGiDOcSfgfJLeqmMBIEqWsCtp0GhDU1CBTAvDAOPLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794640208;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=8m1rh8YCtMa/eK/x1h9nBhdh93CAkPykNk2YYLlQM4w=;
	b=cekYp+uP6U9Wu1JbXynN5Ou6Pu6Zqn37R4jzseEX8Nge6OY5GRymYNacUI3GHmFZL4Gt
	 LyJs6SglySxz+ECQfnzLbK78fgQGD0XkwKhUf3j2f1vilrcs1knpXpvE1UEUXUU+phR1W
	 h+QrUL7CSoPesxUhVZywxA2MQjiFlIzzTMmXQUc8VOfb4mSr1/sK101r5MJCly4ywXJxd
	 euHj5VoPvUpeLSrDSwXhrwQywaGreoOurSYV24Cw6/7ET2Xp2+QFjEsLeVj7k6JcTSyBC
	 Kqg3Qt+GzP8rBHxACKgwke90r8fYwtvcKDC/ooRMYgnZco5yAdu2tzN/Jtzw+jMSo+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=hoob40N4;
	arc=none smtp.remote-ip=209.85.222.173
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09C9B606A884
	for <linux-serial@vger.kernel.org>; Sat, 14 Nov 2026 07:10:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 09C9B606A884
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=hoob40N4
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-9495d543c42so136146485a.3
        for <linux-serial@vger.kernel.org>; Fri, 13 Nov 2026 23:10:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1794640207; x=1795245007; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8m1rh8YCtMa/eK/x1h9nBhdh93CAkPykNk2YYLlQM4w=;
        b=hoob40N4CCfTxfMdgC6CFysWnaULLntOcf9b2zCWEP5AR7y1f+WYOGFQXrxSjlDRs9
         0O09WPsD+TZAe73gRgp4+nuCoy0PbKNfeUT8XBA9E9E1//bFKkOCGLZhW/eUZqlkldgY
         7h1QJvXNbbWn49jHkYVK+4J5BGlhPBOe3wbPpRu8/Smskm8AI7Cx7iHZRAizXaPe7Jpr
         YqjyeIeN2YPCaR0ZM6LQFlUPvXj/ekdyJtG7ifkqZ+qqhwHzcjRNVxKF47izKtWdDiTe
         DxeRBtRv1MhPuSC18fnedwpg1XVkUMVgladnz5HAiA0MSdz92SK/WdDOVEfMderwFx3X
         d4Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794640207; x=1795245007;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8m1rh8YCtMa/eK/x1h9nBhdh93CAkPykNk2YYLlQM4w=;
        b=uTUsIz6MH0kBi5+bw0jXjpioG2Fi1x8V4M3YSEoCCaJCfDN/b2iL5yhFkA/zUT/DB3
         Xj1gngBDHccxp7RqQXEdP1E5y9H4qOI5biXOJNcF4BWTevJFIH3KrCZ574VmUlAsu76Y
         9h3DBhr9TT/G07Vl7wPqH1boSF8NY3Mu/U1lWjFqUFc3+S8EV047xBKuCHeYr9/NUXE7
         Wr04usp5ebTQi0ZLXV9IF0PmkRrB/sCpzNy6MwBcAqmrYFgzFE3vcccvS5ApW709v+fS
         /L1XwQXqiCMxTEwRXuhFK0pw7wddFcdUFU4NiT37yKOHmcSvmFql5E5KnuA3POlpZp6w
         dMMg==
X-Forwarded-Encrypted: i=1; AL+hErGYbiAKeZ72JwINP6lX8Q7ygKyUgTXNrSX/g/PgHlQi8kzSjyTmbrHXWTXD1pXjHYS9VNvgKPSeUejB0/8=@vger.kernel.org
X-Gm-Message-State: APuU4Z9SZdnf8EZ8JxT1F/Mw9rYq+sUvuiibpbjIYQ8PhDCpwUET80Mz
	UAjujavRXUuTkjGtYEvBWZMQwIq6UEebxpBer4qZkqKqDN+B54jTKzPvbld2kYR8VNM=
X-Gm-Gg: AYBFou0D2G7JzBWIrDJOXwMP1APlxzoYCvbQ3Xd/FfiOe/6eALJHM5E0ePHFj9eG4yn
	kDY7mIANpy3VQbTQB+5T5A6wvtXr0b4ZyJVOP5MfXhbcp83oEPbmIwPMo2VsE+9vLd8nSVsFi00
	Q20/3Z8oK1N/3I3wgKTkfNdmM1DIEHqFgUk+kV64FLkUqBuD2h/rlPh+2KlNTZYCPHFL5ZUYHB9
	qA5WBYmDdilKhMtrJEh+JbX+F0fv7uHxKkAJrT0yqWR3R2A785AEywpfM832+hUN2u4bQDhYq5R
	jUi8/GDrptBErY5HM11IfGIB3GUv1I36SzFJJYYbLenYGkG2LX9T6NcdtS6EVFS5pT1WXp/JRDu
	F2KO69xDCSGbANx7SvMAHTLwIM2fUs/5qSEX8YAtK/Ka3kNG+XSSQSD/hGSwytFL15i8vyq73gE
	+1oxak2TT+DZGhpm0nMC6qIxDOd+g93G7Cet/Erp1tHM1uLMfdGRimbZznUtK9dD5K38pHmyctC
	QZDvC8r9CaHDc3FISnFb2aPtbwzAsLsJ+gBW5KlVUcU2oXT9TU1eM973/c2FcDogbGD8xpaWrug
	GVl4z0b9u3YIBrBccM6elAH3Xg9wnJa5pw2gur7p/JXnTgTpprVWproV8haaDscsCiCVZi0aaUL
	9qKqI/mrPDjFCU2I=
X-Received: by 2002:a05:620a:6606:b0:93a:2d07:142f with SMTP id af79cd13be357-9494b9aec7amr802433485a.7.1794640206954;
        Fri, 13 Nov 2026 23:10:06 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-71-191-145-202.washdc.fios.verizon.net. [71.191.145.202])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f23db3a99sm37730986d6.40.2026.11.13.23.10.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 23:10:06 -0800 (PST)
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
Subject: [PATCH 01/22] mm: add node-state-filtered zone and node iterators
Date: Sat, 14 Nov 2026 02:09:38 -0500
Message-ID: <20261114070959.3490008-2-gourry@gourry.net>
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

Add node-state-filter helper functions/macros so MM walkers can select
their node eligibility explicitly.

Add nodemask intersection and nodemask/state iterators using the bitmap
intersection helpers, without allocating a temporary nodemask.

Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
---
 include/linux/mmzone.h   | 46 ++++++++++++++++++++++++++++++++++++++++
 include/linux/nodemask.h | 28 ++++++++++++++++++++----
 2 files changed, 70 insertions(+), 4 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index c161d563ce8fd..5ff190d870830 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -1845,6 +1845,13 @@ extern struct zone *next_zone(struct zone *zone);
 			; /* do nothing */		\
 		else
 
+/* Populated zones on nodes in @state. */
+#define for_each_populated_zone_state(zone, state)	\
+	for_each_populated_zone(zone)			\
+		if (!node_state(zone_to_nid(zone), state))	\
+			; /* do nothing */		\
+		else
+
 static inline struct zone *zonelist_zone(struct zoneref *zoneref)
 {
 	return zoneref->zone;
@@ -1937,6 +1944,45 @@ static inline struct zoneref *first_zones_zonelist(struct zonelist *zonelist,
 			zone = zonelist_zone(z))
 
 
+static inline struct zoneref *
+next_zones_zonelist_state(struct zoneref *z, enum zone_type highest_zoneidx,
+			  const nodemask_t *nodes, enum node_states state)
+{
+	z = next_zones_zonelist(z, highest_zoneidx, nodes);
+	while (zonelist_zone(z) && !node_state(zonelist_node_idx(z), state))
+		z = next_zones_zonelist(++z, highest_zoneidx, nodes);
+	return z;
+}
+
+static inline struct zoneref *
+first_zones_zonelist_state(struct zonelist *zonelist,
+			   enum zone_type highest_zoneidx,
+			   const nodemask_t *nodes, enum node_states state)
+{
+	return next_zones_zonelist_state(zonelist->_zonerefs, highest_zoneidx,
+					 nodes, state);
+}
+
+/**
+ * for_each_zone_node_state - iterate zones in intersect(nodemask, node_state(state))
+ * @zone: The current zone in the iterator
+ * @z: The current pointer within zonelist->_zonerefs being iterated
+ * @zlist: The zonelist being iterated
+ * @highidx: The zone index of the highest zone to return
+ * @nodemask: Nodemask allowed by the allocator
+ * @state: The node state the zone's node must be in
+ *
+ * The state filter is part of the iteration rather than a trailing if, so that
+ * this expands to a single for statement: a macro ending in an unbraced if
+ * silently steals a following else from the caller.
+ */
+#define for_each_zone_node_state(zone, z, zlist, highidx, nodemask, state)	\
+	for (z = first_zones_zonelist_state(zlist, highidx, nodemask, state),	\
+		zone = zonelist_zone(z);					\
+		zone;								\
+		z = next_zones_zonelist_state(++z, highidx, nodemask, state),	\
+		zone = zonelist_zone(z))
+
 /**
  * for_each_zone_zonelist - helper macro to iterate over valid zones in a zonelist at or below a given zone index
  * @zone: The current zone in the iterator
diff --git a/include/linux/nodemask.h b/include/linux/nodemask.h
index 607373bd83ee6..28a456c3f5964 100644
--- a/include/linux/nodemask.h
+++ b/include/linux/nodemask.h
@@ -386,6 +386,10 @@ static __always_inline void __nodes_fold(nodemask_t *dstp, const nodemask_t *ori
 	for ((node) = 0; (node) < 1 && !nodes_empty(mask); (node)++)
 #endif /* MAX_NUMNODES */
 
+/* Iterate the nodes present in both masks without a temporary nodemask. */
+#define for_each_node_mask_and(node, mask1, mask2) \
+	for_each_and_bit(node, nodes_addr(mask1), nodes_addr(mask2), MAX_NUMNODES)
+
 /*
  * Bitmasks that are kept for all the nodes.
  */
@@ -411,6 +415,10 @@ enum node_states {
 
 extern nodemask_t node_states[NR_NODE_STATES];
 
+/* Iterate the nodes in a mask that also belong to the specified state. */
+#define for_each_node_mask_state(node, mask, state) \
+	for_each_node_mask_and(node, mask, node_states[state])
+
 #if MAX_NUMNODES > 1
 static __always_inline int node_state(int node, enum node_states state)
 {
@@ -435,15 +443,21 @@ static __always_inline int num_node_state(enum node_states state)
 #define for_each_node_state(__node, __state) \
 	for_each_node_mask((__node), node_states[__state])
 
-#define first_online_node	first_node(node_states[N_ONLINE])
-#define first_memory_node	first_node(node_states[N_MEMORY])
+#define first_node_state(state)	first_node(node_states[state])
+static __always_inline unsigned int next_node_state(int nid, enum node_states state)
+{
+	return next_node(nid, node_states[state]);
+}
+
+#define first_online_node	first_node_state(N_ONLINE)
+#define first_memory_node	first_node_state(N_MEMORY)
 static __always_inline unsigned int next_online_node(int nid)
 {
-	return next_node(nid, node_states[N_ONLINE]);
+	return next_node_state(nid, N_ONLINE);
 }
 static __always_inline unsigned int next_memory_node(int nid)
 {
-	return next_node(nid, node_states[N_MEMORY]);
+	return next_node_state(nid, N_MEMORY);
 }
 
 static __always_inline void node_set_online(int nid)
@@ -481,6 +495,12 @@ static __always_inline int num_node_state(enum node_states state)
 #define for_each_node_state(node, __state) \
 	for ( (node) = 0; (node) == 0; (node) = 1)
 
+#define first_node_state(state)	0
+static __always_inline unsigned int next_node_state(int nid, enum node_states state)
+{
+	return MAX_NUMNODES;
+}
+
 #define first_online_node	0
 #define first_memory_node	0
 #define next_online_node(nid)	(MAX_NUMNODES)
-- 
2.53.1-Meta

