Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794640214;
	b=NLZr2vJp25Yi5M9D/3pFlK+0znrgB/Dx/k2nAAQoda+7Vu0mzet10bsha/5Cp8EugyPn
	 qpI6TV240ASv43aggRPgFdSav/98vCx027bdJOOYsfnAMuZqkPHDK5C+Uium0IzxfPYA0
	 5h4s1b7TIPzvX7ycs3dig+SBGUqVuP67RMcYzt7GB+6X1fA3ufzSrZl5+cX6qgRxx+aaW
	 4mM5wrK/76q7NLmpMpuXk2yW8DjIC4jqL8xX4NXva31P6FHVqGHU1sFLwKk5LGmfpIcJO
	 a3iVO3LIv9cVWypR1TIdLJANnY1MqArmf0xOwC1uLog+7Ql8zGUyZiUyYAWSbUN+LXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794640214;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=dol9r1sYlhR7CIgJNfl3WOVG5mT9B/6UaBUUhYtXcU8=;
	b=Zf03vizW/pqP7wudnk223YRdiCmGsyARzIg3SodaGFRLownxK1+89Zl6I6eKq1CliQjm
	 tQtlLfM8Fbz30EaH2rlD01MVBnLAL8Mgpd3FJTa3st1m6b4N12fwYpMOs6cpj7Llbg2Ww
	 b4RX2I01fC7dyV9raUEorBGKVO2OXtUfS0ikTYHCNMtzLnGAp0RUYvsjc/dWpuPA1aeUB
	 c4IH84iBkr3FkvG8g7tmX6A9otRpfmVMZB6BeUm/cOdmB89HvGvxi7aaPEXxzZH5jrQtO
	 97HW1zMOXkZYyQIvwUzKV6FxCnzeQHGc0A+3lwDziwm2vWojdRWWHDPJMMYa2gbEPxQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=deoAJpuv;
	arc=none smtp.remote-ip=209.85.222.179
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09AA260A260E
	for <linux-serial@vger.kernel.org>; Sat, 14 Nov 2026 07:10:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 09AA260A260E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=deoAJpuv
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-9495c633eb5so58041085a.1
        for <linux-serial@vger.kernel.org>; Fri, 13 Nov 2026 23:10:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1794640213; x=1795245013; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dol9r1sYlhR7CIgJNfl3WOVG5mT9B/6UaBUUhYtXcU8=;
        b=deoAJpuvk5/EHzr+FRoWKty8TA+vc+0SUXmTiCKtNa4uUcimyE81R96fWgRz7/nC7/
         nxOrejc2E0NpG+giC4B/bA9RN9+l3poG1jjFyoVlP+tK1N4FUjhnopETAblwvEegsWoC
         N2vrbbw0sLOK+/H4lTrzKguByBIJzuZwK7nM3cHZBJXYMU6oG+tKG62dAlm+3g1Cg81f
         VstGy/u/BNv0z/ag+mwjSrVmjQoyz5R+W7jxdvdz9gY8a6SZa7GWQvZDoyMKi60knIWj
         bNNh1qF23hvGxiMH1MoODeCtKNf/Hnaz6wjOCTAeFWZ3TQbm8zBv4b+McPCHHjOM7T2S
         JqoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794640213; x=1795245013;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dol9r1sYlhR7CIgJNfl3WOVG5mT9B/6UaBUUhYtXcU8=;
        b=dbVEGlN8vMDwFvpg+Fh+sNH1UNAQ+YOno6JSPuTRQ+XNBuQA59PYx3e5Ptv30wvaFs
         1zVLHkpHRF9lKoKzx5TsxFsT41+44yEONuU88M4tFOy4yWbaso9tK14UsRT2yubkCwt9
         g4Pnh6XeBGhRVI0vYMJ8tfAHCTdjghmbCr2l0KYPTRM9MbskNVorzR1rur7H60NPW0Ai
         69GrJP+SaGO3Auvd3f74LTc0Ii9xFkB2DYBu4+IRE9AkFP8x7+hFjJtcVHJ2W/puVrz3
         KHEFWAvAAcg78BMYckxQYYT9CwccdnydU1sH1/IcHpGR2edTNCmQcxbar6qG2qL7W7YY
         SPrQ==
X-Forwarded-Encrypted: i=1; AL+hErH0lycflBYDPzWgQXAoxiBkdPRGmTK3C99rkWPsV/Zszeuc6TzQb+olixOo1XsjUkcwGytLqvQM8ICrmjs=@vger.kernel.org
X-Gm-Message-State: APuU4Z/jVEJQenEKwhvdqBbnK/bmSjyX9jNDrh9E8jFvz5wLAHUBXjOG
	MPDC0OzJjXSyCCVskq6ipsvJtpEPFXaV8mwWE6xICa/1wKjcF2Pju460MclKovOQD2A=
X-Gm-Gg: AYBFou3EHdKHcp1ABIGjCJSreqIM/0s2De1c0ISZaxP0j+gjtg6C5wbPMy9nnsIueGZ
	xbOlJIl5hILNLEatGq21xvIoKyxuNFJlhdnGI9uIMJ/Oq0JLRUFJ5K8fKJ+PA4TBc6kG8bVvFAF
	W8NdWyRswJfjSThkcf39MlH13pHHFcPRZS2ag/8bUIexA7QCmGHoUca6o/sLI/oKonb66aIkj4A
	B60xkYappWk8lVDAp7VPVcrxpvvaxDreSWjuxcQG58lEdH2O6ivoxhfQ6tHqSNW2+NOFihmf546
	UtDE1dwJUY3p4Qyb034N5kmBq9o66X0/hEmlT2IYXPaQ+clEmI3UujTPuf4HsIBg0hxuJqR+ypk
	37sciQD7e5vStqbraXt16ZoA4OxuQ96LD0dAPgQBV14Hj0lZ47+FjLLN6BF/Yf5BdLrpfZpwdOJ
	XSaqhiTbci1ZC+eTXvgigaiJ+FApwgaVwUzBCsnGG+/vpxTkkRQp1fmNbGu51auXYnqUC1+SSWC
	NBuWNb51sV22H/jNvmDrCY8qWJYCbgZfCYcprxE5XZb+SZH4tuYIGR3xnNTdl2JMGCHEkYIWiQp
	BY154QZ+3deh4cSxz+jy9Ms7rPehNDuwwgVPtbpNni+1zEzTl6DLf/jONllTfRh+SoUDYixX/Zo
	va/A4ZFQs6nS4g6E=
X-Received: by 2002:a05:620a:7087:b0:949:402b:f18e with SMTP id af79cd13be357-9494bc7e777mr835710585a.66.1794640213010;
        Fri, 13 Nov 2026 23:10:13 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-71-191-145-202.washdc.fios.verizon.net. [71.191.145.202])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f23db3a99sm37730986d6.40.2026.11.13.23.10.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 23:10:12 -0800 (PST)
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
Subject: [PATCH 04/22] mm/page_alloc: build zonelists from common memory
Date: Sat, 14 Nov 2026 02:09:41 -0500
Message-ID: <20261114070959.3490008-5-gourry@gourry.net>
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

Zonelists decide which nodes an allocation can reach.

The fallback lists hold every node in N_MEMORY, and a node's
__GFP_THISNODE list holds its own zones whatever the node's state.

Ordinary allocations should reach only common (general purpose) memory.

Build the fallback zonelists from N_MEMORY_COMMON, and __GFP_THISNODE
zonelists only for a common node.

The build_local_zonelist() refactor lets use reuse the code to build
a local-only zonelist for nodes outside the N_MEMORY_COMMON set later.

Every node with memory is common, and a memoryless node has no zones to
list, so the zonelists are unchanged.

Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
---
 mm/page_alloc.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 6ffa972811462..580feeb608b7a 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5906,17 +5906,14 @@ int find_next_best_node_in(int node, nodemask_t *used_node_mask,
 }
 
 
-/*
- * Build __GFP_THISNODE zonelists
- */
-static void build_thisnode_zonelists(pg_data_t *pgdat)
+/* Build a local-only zonelist when this node is eligible. */
+static void build_local_zonelist(pg_data_t *pgdat, int zlidx, bool eligible)
 {
-	struct zoneref *zonerefs;
-	int nr_zones;
+	struct zoneref *zonerefs =
+		pgdat->node_zonelists[zlidx]._zonerefs;
 
-	zonerefs = pgdat->node_zonelists[ZONELIST_NOFALLBACK]._zonerefs;
-	nr_zones = build_zonerefs_node(pgdat, zonerefs);
-	zonerefs += nr_zones;
+	if (eligible)
+		zonerefs += build_zonerefs_node(pgdat, zonerefs);
 	zonerefs->zone = NULL;
 	zonerefs->zone_idx = 0;
 }
@@ -5960,8 +5957,12 @@ static void build_node_zonelist(pg_data_t *pgdat, const nodemask_t *candidates,
 
 static void build_zonelists(pg_data_t *pgdat)
 {
-	build_node_zonelist(pgdat, &node_states[N_MEMORY], ZONELIST_FALLBACK);
-	build_thisnode_zonelists(pgdat);
+	int nid = pgdat->node_id;
+
+	build_node_zonelist(pgdat, &node_states[N_MEMORY_COMMON],
+			    ZONELIST_FALLBACK);
+	build_local_zonelist(pgdat, ZONELIST_NOFALLBACK,
+			     node_state(nid, N_MEMORY_COMMON));
 }
 
 #ifdef CONFIG_HAVE_MEMORYLESS_NODES
-- 
2.53.1-Meta

