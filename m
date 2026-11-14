Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794640216;
	b=Fb0n+ji2BlH0NGij/AOTcvI6c0HAdpoD+1CPpFecu3dhZOKQnN7RggKOsglPpHv8Twfq
	 UWPFARVRVOwjXXBDMV4or78W1qe8AkcHrkNOavZHcUHSHGG44Qg0lPwTbitZpuPK9Sg+2
	 dIDANyfUkaJp8ev4lCoelgpfUxZWmUusl1ma3D8cBXy5ZK8Vc9QHPYux3d5Wik4AxW5AP
	 DPVc+irB5+umplnvll14gQsqEFE7c8ihiKblM8BeEBXeOoacFvPBAuMECVA2Hxjij2XWs
	 Op1GCCMJTf9c/cv4okiI2sc4Z4N+qn/8YZdRFezbK+pJPtiudYLHo+UHM61PC1+EdTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794640216;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=l21X+DxpKDHlSbVBLdY73zXQHc1CePcjyPM6zZHy190=;
	b=iW5FOpbc8jfyn+S9xbj1iBeoifOb8aNmsXoBAsTsJ8NgEErol43V6quNsUPyF7t8alWZ
	 /qvXr2xqwJrHE4yZGzZZ6Cky0MIf+QXu7IXD/c+yr8uQZGWq0zgBgdsTYWqvd7VILGPVu
	 t2A8xovQfozJYraZ+1OsNv8ntyaMk7hVNzzIR6dYQw2bnRSR8FRbFjtioIqweBSAt8lht
	 Dmel3jVI1xzCrDeZzUuizJ2x0D9m02PKjMbcBCPu2j5CzhJ2KhhBY+RJlJqKRhUF5ieVa
	 apmvk8ldH5wEKKfXMr4jOPuUoKQHgs/4wmQxULOtY1vKKehrSTkP62jK7SnZclWqWxw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=d7KKfvBB;
	arc=none smtp.remote-ip=209.85.219.46
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F0260A262F
	for <linux-serial@vger.kernel.org>; Sat, 14 Nov 2026 07:10:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 38F0260A262F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=d7KKfvBB
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-91f2b826fe9so19621826d6.1
        for <linux-serial@vger.kernel.org>; Fri, 13 Nov 2026 23:10:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1794640215; x=1795245015; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=l21X+DxpKDHlSbVBLdY73zXQHc1CePcjyPM6zZHy190=;
        b=d7KKfvBBW5/5gvjm+2xpumHZ1G9opFmCK0hLy80god6602rP4hD7WpJOGpuokt5mAL
         oS0dK1kG353je+Plx7acyy3uDD+xG+fq13pPPunFf2FrrH3HCYFO6byP3Sxtv2jFPZRS
         xkvrHljmRCgifnLPU7TTzNYxo6K/0+6E/ugTWtazA660Z6j34/gCIt06b/pby46TMW4f
         tuIOIKSVgbsNBqf2nKWyrmyI0gqtvTjJCJgKoGlUlvqVhTxSTJN+XkpcJKcwx1Td3Q6t
         AEo832DgjwwYB1HZ/pxFbAs31Gd3WOnHnsRaeSVQ8XmVN/B1qBnlz7xTmeoX3z8P3pSY
         IBDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794640215; x=1795245015;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=l21X+DxpKDHlSbVBLdY73zXQHc1CePcjyPM6zZHy190=;
        b=qb2yL6cOX8hZf2Bv5GW5YZvNKQCIOAiE2uamufLdOIsx60RUZLL5541wnFgADXteIU
         Mcos7u3GDM1xMB6Nm6ud7RpQc5hsONu7aW2LSkX7EieOiq0kPMNPZxpEUJQ4S2HzCRNR
         LlYnUhj4tyIIIGPZK/WmKPx2wzSRLNQwp0lNEx98oiu5dxx+1m2yOyqR8OLoximOpsdz
         0dANEL3iqcN2TgbTFAuUVixd/aIz8oo1uFGk5j0g4zoGetYWElS3lPYpBVcjbr/dnBq0
         QEj+ID/I7SuFzmECpVni5rvHgxcuDuSqbnxNiFh4PfvJoiBuxNqbfG09j5i3oAdnRYem
         sjLA==
X-Forwarded-Encrypted: i=1; AL+hErG2gqKAUsChWocqcR5lkAOO/b5rykCUR9s9j8+D6KZHQ8LwNXOWTAHdUdE1ptqaTtrvh9dLGS3kNJK4qYw=@vger.kernel.org
X-Gm-Message-State: APuU4Z+rNuBop6dS25JIr/rg1rGpnd230Mb0EQ6r6xbmEaZ5OrbDBSQF
	39sNpQQme6nW3PcZ9lkfqGrAL5P9dqlPuy3iK1BCc7aL/MqZXAqPGol3KGg7HaTP9Zs=
X-Gm-Gg: AYBFou2BteqzkY9vzb4Y3UWXPbC/lWj3VD9ialFgOM4XIKuIUw5VVXQvosmm5dYqwC6
	Pu4crkaV7WahKtL5JeAagXOwrseF74v5dcvm7Rn/81jq1d92ZdkrrEKLId3dzex76txNmSdlIGj
	jge8fWAnuv8jBrchdIoS6Cj8mWyjdzC0OeXhEIgwkT9RhT3TYEaTsKujUwND1Cbb3MZGpup15Yy
	NtbZ1EIB+3EVm6jz2B2PgN6mK351GQdn8DJxGOJK8p7nBfYQjJXqJ/lXi7/rS45/ypZaG5HIGH9
	StWkK9WbgXBEpyHipA2lXekwjxURQgLxYiTVVI4ogxIb4OzXNeKGnx8mSzkh5daVbvCL48dwEYV
	Pbul/EHQrFQcNvNfu+pGU9rU6BHgmaMOf8R4T4G6m588IHZ88CONNDA32goub6SbXvLAKsK3VoG
	EslQG4udSY95eZ1QPjc9HNcm7zN8+VJvu71eQA4VoYPp23miG831wtE0gu+h8ZP7U5/73sdM0X6
	+U5W7yBcDByAdYw68aCfj+a7JGKuZQua/gGhAY+d4Yg1RwwiaqGNF8VFBxhrRlqn3eYqnHcAQhQ
	JoMth2JCw6S0LCyWGumHKkgjK0VXpuG5jebflUGAEPnAQhKz5DrmNSWJQUCt3OOozFGwmiVwLO4
	Gm257CYlDpCQpKYc=
X-Received: by 2002:a05:6214:8581:20b0:91e:a16b:7f59 with SMTP id 6a1803df08f44-91f241f7044mr56496996d6.32.1794640215081;
        Fri, 13 Nov 2026 23:10:15 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-71-191-145-202.washdc.fios.verizon.net. [71.191.145.202])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f23db3a99sm37730986d6.40.2026.11.13.23.10.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 23:10:14 -0800 (PST)
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
Subject: [PATCH 05/22] mm/mempolicy: keep interleave and tmpfs mount policies on common memory
Date: Sat, 14 Nov 2026 02:09:42 -0500
Message-ID: <20261114070959.3490008-6-gourry@gourry.net>
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

Use N_MEMORY_COMMON for boot mempolicy calculations and their per-node
sysfs entries (weighted interleave weights). 

Restrict the node set mpol_set_nodemask() applies to set_mempolicy()
and mbind() masks to N_MEMORY_COMMON nodes.

Later when an N_MEMORY node is omitted frmo the N_MEMORY_COMMON set,
they will be stripped from mempolicy nodemasks as they're not eligible
(similar to memoryless nodes today).

All memory is common at this point, no behavior change at this point.

Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
---
 mm/mempolicy.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index b10c098e9c2a3..662ab420fe03c 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -213,10 +213,10 @@ static void reduce_interleave_weights(unsigned int *bw, u8 *new_iw)
 	int nid;
 
 	/*
-	 * N_MEMORY can change while wi_state_lock is held. Remember the
-	 * nodes contributing to sum_bw so all passes use the same set.
+	 * N_MEMORY_COMMON can change while wi_state_lock is held. Remember
+	 * the nodes contributing to sum_bw so all passes use the same set.
 	 */
-	for_each_node_state(nid, N_MEMORY) {
+	for_each_node_state(nid, N_MEMORY_COMMON) {
 		node_set(nid, nodes);
 		sum_bw += bw[nid];
 	}
@@ -439,9 +439,9 @@ static int mpol_set_nodemask(struct mempolicy *pol,
 	if (!pol || pol->mode == MPOL_LOCAL)
 		return 0;
 
-	/* Check N_MEMORY */
+	/* Check N_MEMORY_COMMON */
 	nodes_and(nsc->mask1,
-		  cpuset_current_mems_allowed, node_states[N_MEMORY]);
+		  cpuset_current_mems_allowed, node_states[N_MEMORY_COMMON]);
 
 	VM_BUG_ON(!nodes);
 
@@ -3400,11 +3400,11 @@ void __init numa_policy_init(void)
 
 	/*
 	 * Set interleaving policy for system init. Interleaving is only
-	 * enabled across suitably sized nodes (default is >= 16MB), or
-	 * fall back to the largest node if they're all smaller.
+	 * enabled across suitably sized common memory nodes (default is
+	 * >= 16MB), or fall back to the largest node if they're all smaller.
 	 */
 	nodes_clear(interleave_nodes);
-	for_each_node_state(nid, N_MEMORY) {
+	for_each_node_state(nid, N_MEMORY_COMMON) {
 		unsigned long total_pages = node_present_pages(nid);
 
 		/* Preserve the largest node */
@@ -3476,7 +3476,7 @@ int mpol_parse_str(char *str, struct mempolicy **mpol)
 		*nodelist++ = '\0';
 		if (nodelist_parse(nodelist, nodes))
 			goto out;
-		if (!nodes_subset(nodes, node_states[N_MEMORY]))
+		if (!nodes_subset(nodes, node_states[N_MEMORY_COMMON]))
 			goto out;
 	} else
 		nodes_clear(nodes);
@@ -3508,7 +3508,7 @@ int mpol_parse_str(char *str, struct mempolicy **mpol)
 		 * Default to online nodes with memory if no nodelist
 		 */
 		if (!nodelist)
-			nodes = node_states[N_MEMORY];
+			nodes = node_states[N_MEMORY_COMMON];
 		break;
 	case MPOL_LOCAL:
 		/*
@@ -3903,6 +3903,9 @@ static int wi_node_notifier(struct notifier_block *nb,
 
 	switch (action) {
 	case NODE_ADDED_FIRST_MEMORY:
+		/* Weighted interleave spans only common memory. */
+		if (!node_state(nid, N_MEMORY_COMMON))
+			break;
 		err = sysfs_wi_node_add(nid);
 		if (err)
 			pr_err("failed to add sysfs for node%d during hotplug: %d\n",
@@ -3934,10 +3937,7 @@ static int __init add_weighted_interleave_group(struct kobject *mempolicy_kobj)
 	if (err)
 		goto err_put_kobj;
 
-	for_each_online_node(nid) {
-		if (!node_state(nid, N_MEMORY))
-			continue;
-
+	for_each_node_state(nid, N_MEMORY_COMMON) {
 		err = sysfs_wi_node_add(nid);
 		if (err) {
 			pr_err("failed to add sysfs for node%d during init: %d\n",
-- 
2.53.1-Meta

