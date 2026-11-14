Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794640213;
	b=J9sM1oA6XeQnLVb7dNpFIKUn9kDAiBsAMB7PPKO277ygBeNvMnYqLPWZwvXCmt850HL1
	 X3RzAjSbaqXYS6i9ffR0Ul1lXTI4c84FR/4nHPhnXokyEFNce9ebNawfYSX2a3IiKFZHL
	 46Q/hTCivh6fypfRtNyFZXP9pHSaLBLVNh59lTM1QH5r3bYmJdczVyWO25PQGSGawT4Cv
	 g2rvQuRiZ3b/P7Nxq1/tTo8IskiON+HSdbVgRcv0MpKFZu+n8kD8FShjAT563YGHYmIga
	 lfmZtQBvD8cjocAsrgXeuv/1HQakuTz0B/5Mkp0alzS1Hh/Mls+VTt8izMnTljKaLMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794640213;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=2lEa1LIQv4RtVFSRolNpT9VAJCtG2n7xXC0f3lXhF2k=;
	b=3OGy30M4Eu2gpXpN4NC4aWPjwDnpFjoVUBNr9stZ8rl/OLzREf0PINY3f/gpuiI3KAku
	 tETJa1UHMHNFSmSrFGrP1jU03Cgc0o1DCECpBNdyLBMhChdIM9I8flp6a2Bqyyw5On3Yo
	 ta2gS1AqkHVoJXbquxNAOyLQ3dZKXczhsaoC1w9Zh731zRGQFZFrKyYj2TjCbUmNOvY31
	 /hhndg8f1CWSVO/BlKBbRIGxOguQUxnsblMqQQ25bLK1ChSf3UBSjDl15q3MOXgHjC9Fz
	 W2TnQhHrRMih8tHAV4/Ds0UxG4yzEPaGDO2lRB7T80iQFfJ9iLvlDBlwMyiahi5Jc5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=IWvgx5rW;
	arc=none smtp.remote-ip=209.85.160.182
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FFBF606A8B8
	for <linux-serial@vger.kernel.org>; Sat, 14 Nov 2026 07:10:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2FFBF606A8B8
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=IWvgx5rW
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-55c38cdd5b7so8407571cf.2
        for <linux-serial@vger.kernel.org>; Fri, 13 Nov 2026 23:10:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1794640211; x=1795245011; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2lEa1LIQv4RtVFSRolNpT9VAJCtG2n7xXC0f3lXhF2k=;
        b=IWvgx5rWVunbET9uLh/WovNpGknlsYV5lIdg4Icagusqh+p85F7dtggmh6aP1UwmQV
         O2/aAglFxD7dwePct6/pv31xoAaNYfRomEAuU401zt7IcjwAo8LQEvFPQxR9EMYMPQft
         S4lad0K2TU7KomgQdHOLhS9/yKZFrbtv6COmm5NVaFEIVRVgYjAXW5wlISa8y7n5L8VE
         MKMgh+cuNWCRaPYSddbegpBEH0OYR0deeb7IaaI2f4zY1FXiKRc3LxCvHdQ6Nl2c052K
         R4yoz6h/CESEHnu8YdsCbVGOk2uA+AtMsc3EBfNRbjDG2X73OS8szxIRIT1U/IX4MYoJ
         EjDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794640211; x=1795245011;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2lEa1LIQv4RtVFSRolNpT9VAJCtG2n7xXC0f3lXhF2k=;
        b=pPND6y5KmJHBp7z4LTZQOj7v78n+M88oWEc6qe+j/p4bESOLHxfa0h5f5vwKtkSVo3
         ghHX3WvdakbjfYi/JD5K1e7IZ/nSw+FGEcMkIRl0FCqxTiOPxGWbqYC602H4AGn2Ow9h
         7bBJWTKr7zuMSH9/Lgu5d5Pnlll7i9cgx2OFTFXoD0kFArT7jZHNfTM/GoNWLUiL6P8g
         Gcr+TJv1RqCz4OlRheY2MXX7Ve8hiO898b54/7VvljbkJm9UvlSTlhxOQoIPpglBYVc7
         kDhW9eVnk+ODXpox8/3VyT3+X8c1pRsVpUK9dGOE8b6pdmDw/+1QPnukN8kPLYGBGXHE
         Jkqg==
X-Forwarded-Encrypted: i=1; AL+hErHog0DvWDFKy1CQKqFcbZjrVm4lwc3/6+0FmcL05P3PNIr9OHHrfvnwWjXVmBPxU8AzRIvQEc6uflRRroA=@vger.kernel.org
X-Gm-Message-State: APuU4Z8J9PKnUoL1f85ROIl9vOViV8mVyuuEWyn9lMW4uDWTlRiFecAF
	5uIyjJQ+EJlgjNJU6xyD8nR2HkDueBhGn7EpBHykvJq8UvwTa99MGPPaTrKrexN/3Q8=
X-Gm-Gg: AYBFou1yUzDrwQ7Y8YMx94aJxNnbC0AxIsejXyyNUV0Yirp9swDYLlRMmuBwRjO4VYq
	P4a+w9pe2OJ79NmbeY/LBzMh+Dz3tFIR7QyiYlHEP6671gYK6i5G5nKSgtiRnx93X0rSH3z7GVs
	G3RGkJSsuRn8sg94oMzF3LgDsMaDEzezqoMKqM3UAhNenx6nA7/MvLiEQ+Mlj+HpWArVkKZm+DB
	4XggHy8624VOji76jQOq8lHDZrNuAv9VvO/5n1fMhZRKthanT44Dpiu/qu+y5R8R1o9wctjxPRA
	xuQ/O8X0vxbH31yn8l/DPi9Fgzokg7VIfoNWavM5DYZDtlWN7To1KJwtiw2wOg/Fo69y9emRG68
	z5vE761rnuT9dC09vaMz9UikHYqMwhnVdY+7YGCxXAl4yFfIjn82uFpoDRoQS8/uARJGTSUhbGT
	Jh04o762BChdDMpV+cTIAeLpYghKZkfA5S3lMBq9g7er9iPyCMzMbGz51UV1vS4cB+eze8wNwDy
	aTw7g/TvqnN8bnhIxVFJx7guOvIqYEn2XqXnSdH4BTwx8EUiwlxS3dvePVqNdYbh0TqWUd2nCt8
	oihrkJ2FiJMMh7sKtvKDiNbBObhZq1YqKoW8A46C8qjaW1EEKSvCh5g3qGrpJkco99u9lAlL4td
	e/t/rXALc8rk2BB82lihEeyFc8E1TKrMqT1PM
X-Received: by 2002:a05:622a:355:b0:535:f9dd:cb9b with SMTP id d75a77b69052e-55ac817ffbemr80325101cf.26.1794640211080;
        Fri, 13 Nov 2026 23:10:11 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-71-191-145-202.washdc.fios.verizon.net. [71.191.145.202])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f23db3a99sm37730986d6.40.2026.11.13.23.10.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 23:10:10 -0800 (PST)
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
Subject: [PATCH 03/22] mm: introduce the common-memory node state
Date: Sat, 14 Nov 2026 02:09:40 -0500
Message-ID: <20261114070959.3490008-4-gourry@gourry.net>
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

N_MEMORY is overloaded with two meanings:
  1) a node has memory.
  2) a node's memory is reachable via ordinary allocation or
     an arbitrary MM service may use that memory.

Allow N_MEMORY to mean #1, and introduce N_MEMORY_COMMON to mean #2.

N_MEMORY_COMMON nodes contain "common memory" capable of being managed
arbitrarily by the kernel MM based solely on zone membership. Following
commits convert relevant N_MEMORY users to N_MEMORY_COMMON.

Add folio_is_common_memory() and page_is_common_memory() for MM services
that walk folios. Following commits convert folio_is_zone_device() and
page_is_zone_device() callers accordingly.

Expose the state via `has_common_memory` so userspace can identify
the memory available to ordinary allocations and common MM services.

Add has_memory to the docs while we're here.

Every node with memory is common, so N_MEMORY_COMMON equals N_MEMORY
and there is no behavioral change.

Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
---
 Documentation/ABI/stable/sysfs-devices-node | 16 ++++++++++++++++
 Documentation/mm/physical_memory.rst        |  8 +++++++-
 drivers/base/node.c                         |  2 ++
 include/linux/nodemask.h                    |  9 ++++++++-
 mm/internal.h                               | 15 +++++++++++++++
 mm/page_alloc.c                             |  3 +++
 6 files changed, 51 insertions(+), 2 deletions(-)

diff --git a/Documentation/ABI/stable/sysfs-devices-node b/Documentation/ABI/stable/sysfs-devices-node
index 2d0e023f22a71..a93de328f8fe8 100644
--- a/Documentation/ABI/stable/sysfs-devices-node
+++ b/Documentation/ABI/stable/sysfs-devices-node
@@ -10,6 +10,15 @@ Contact:	Linux Memory Management list <linux-mm@kvack.org>
 Description:
 		Nodes that are online.
 
+What:		/sys/devices/system/node/has_memory
+Date:		December 2012
+Contact:	Linux Memory Management list <linux-mm@kvack.org>
+Description:
+		Nodes that have memory.
+
+		This memory may or may not be reachable via standard
+		allocations, see has_common_memory for details.
+
 What:		/sys/devices/system/node/has_normal_memory
 Date:		October 2002
 Contact:	Linux Memory Management list <linux-mm@kvack.org>
@@ -29,6 +38,13 @@ Description:
 		Nodes that have regular or high memory.
 		Depends on CONFIG_HIGHMEM.
 
+What:		/sys/devices/system/node/has_common_memory
+Date:		November 2026
+Contact:	Linux Memory Management list <linux-mm@kvack.org>
+Description:
+		Nodes whose memory ordinary allocations may use without
+		requesting the node explicitly.
+
 What:		/sys/devices/system/node/nodeX
 Date:		October 2002
 Contact:	Linux Memory Management list <linux-mm@kvack.org>
diff --git a/Documentation/mm/physical_memory.rst b/Documentation/mm/physical_memory.rst
index 2e67e8b23a994..fd5c5d136180f 100644
--- a/Documentation/mm/physical_memory.rst
+++ b/Documentation/mm/physical_memory.rst
@@ -168,7 +168,12 @@ nodes with particular properties as defined by ``enum node_states``:
   The node has regular or high memory. When ``CONFIG_HIGHMEM`` is disabled
   aliased to ``N_NORMAL_MEMORY``.
 ``N_MEMORY``
-  The node has memory(regular, high, movable)
+  The node has online memory (regular, high, movable).  This is a topology and
+  accounting state. Presence in this mask does not mean ordinary allocations
+  can use the node's memory; see ``N_MEMORY_COMMON``.
+``N_MEMORY_COMMON``
+  The node is on the page allocator's fallback zonelists, so an allocation
+  that named no node can be satisfied from it.
 ``N_CPU``
   The node has one or more CPUs
 ``N_GENERIC_INITIATOR``
@@ -184,6 +189,7 @@ For example, for node 2 with normal memory and CPUs, bit 2 will be set in ::
   node_states[N_NORMAL_MEMORY]
   node_states[N_HIGH_MEMORY]
   node_states[N_MEMORY]
+  node_states[N_MEMORY_COMMON]
   node_states[N_CPU]
 
 For various operations possible with nodemasks please refer to
diff --git a/drivers/base/node.c b/drivers/base/node.c
index dcdc8626627a8..cc6696d1390f3 100644
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -965,6 +965,7 @@ static struct node_attr node_state_attr[] = {
 	[N_HIGH_MEMORY] = _NODE_ATTR(has_high_memory, N_HIGH_MEMORY),
 #endif
 	[N_MEMORY] = _NODE_ATTR(has_memory, N_MEMORY),
+	[N_MEMORY_COMMON] = _NODE_ATTR(has_common_memory, N_MEMORY_COMMON),
 	[N_CPU] = _NODE_ATTR(has_cpu, N_CPU),
 	[N_GENERIC_INITIATOR] = _NODE_ATTR(has_generic_initiator,
 					   N_GENERIC_INITIATOR),
@@ -978,6 +979,7 @@ static struct attribute *node_state_attrs[] = {
 	&node_state_attr[N_HIGH_MEMORY].attr.attr,
 #endif
 	&node_state_attr[N_MEMORY].attr.attr,
+	&node_state_attr[N_MEMORY_COMMON].attr.attr,
 	&node_state_attr[N_CPU].attr.attr,
 	&node_state_attr[N_GENERIC_INITIATOR].attr.attr,
 	NULL
diff --git a/include/linux/nodemask.h b/include/linux/nodemask.h
index 28a456c3f5964..7ace610bdd654 100644
--- a/include/linux/nodemask.h
+++ b/include/linux/nodemask.h
@@ -402,7 +402,14 @@ enum node_states {
 #else
 	N_HIGH_MEMORY = N_NORMAL_MEMORY,
 #endif
-	N_MEMORY,		/* The node has memory(regular, high, movable) */
+	/*
+	 * N_MEMORY indicates online memory exists on the node - it is used
+	 * to manage per-node meta-data and topology decisions.
+	 * N_MEMORY_COMMON indicates whether the node can satisfy arbitrary
+	 * allocations and whether a service should manage that node's folios.
+	 */
+	N_MEMORY,		/* the node has memory */
+	N_MEMORY_COMMON,	/* common pool (fallback zonelist) */
 	N_CPU,		/* The node has one or more cpus */
 	N_GENERIC_INITIATOR,	/* The node has one or more Generic Initiators */
 	NR_NODE_STATES
diff --git a/mm/internal.h b/mm/internal.h
index 608a83c34c224..af6fc27a9fc98 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -65,6 +65,21 @@ void folio_mark_lazyfree(struct folio *folio);
 void node_set_memory_state(int nid, bool high, bool normal);
 void node_clear_memory_state(int nid);
 
+/*
+ * Common memory is available to generic MM services. ZONE_DEVICE folios do
+ * not qualify even when their NUMA node is common.
+ */
+static inline bool folio_is_common_memory(struct folio *folio)
+{
+	return !folio_is_zone_device(folio) &&
+	       node_state(folio_nid(folio), N_MEMORY_COMMON);
+}
+
+static inline bool page_is_common_memory(struct page *page)
+{
+	return folio_is_common_memory(page_folio(page));
+}
+
 /* mm/vmscan.c */
 unsigned long zone_reclaimable_pages(struct zone *zone);
 unsigned long try_to_free_pages(struct zonelist *zonelist, int order,
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 834d199ff8429..6ffa972811462 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -203,6 +203,7 @@ nodemask_t node_states[NR_NODE_STATES] __read_mostly = {
 	[N_HIGH_MEMORY] = { { [0] = 1UL } },
 #endif
 	[N_MEMORY] = { { [0] = 1UL } },
+	[N_MEMORY_COMMON] = { { [0] = 1UL } },
 	[N_CPU] = { { [0] = 1UL } },
 #endif	/* NUMA */
 };
@@ -215,10 +216,12 @@ void __meminit node_set_memory_state(int nid, bool high, bool normal)
 		node_set_state(nid, N_HIGH_MEMORY);
 	if (normal)
 		node_set_state(nid, N_NORMAL_MEMORY);
+	node_set_state(nid, N_MEMORY_COMMON);
 }
 
 void __meminit node_clear_memory_state(int nid)
 {
+	node_clear_state(nid, N_MEMORY_COMMON);
 	node_clear_state(nid, N_NORMAL_MEMORY);
 	node_clear_state(nid, N_MEMORY);
 }
-- 
2.53.1-Meta

