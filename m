Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794640220;
	b=ITLdNlUJWdE9AtGznf6D6j3rRElHoyWqMSv0zcZWHzuhduYNGv+caEsyhRmWz7LjQfmb
	 9W91spDHczsl4MdeLV3OphTMQtdBZloyixRcQj0bNCT6+4wJ3lKu94g5hB7yFclo1V700
	 cC6TIKKWbI3WGeri58ij4pRbGejpsx2F/YJ/UiNXRkYW6rLh9NZTfIgVmHfnoxgJmLE/0
	 cF7wmEbsBoULLR7vfuYOHANEn+PnpuPAxhSVRTtuNF2N2zSYlGvHRghc+6eKD1uRvtsme
	 uHrmMpKk9SvU+Bks8brxgMqN/bKLWEBO1IiaAa4dT/+gE3yWxdiL4WbNBB8xKA2yVZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794640220;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=KKsqfMs+Khz2jHdLUAmVstaMz+t2qjUPbSjoMCe8lqE=;
	b=3cod/SwrTv/smVe8fqDAFVm2n9Y87QV2unU+7QDOcVW/J9v3a7H3I87u8mQrdfcmaMvT
	 PbBs+FtWV4ezRXMp5k9Tfsp8dabojBJ5MZZX5PTIJm4WBiskMhd3qTFAw+ymudG2HJUzP
	 4BBYtWM6oMyee25PxXIIld9xlY99ZS6aYzoXsFghLIieTfS2mcnete3lj5HNhVyONilVL
	 R96FaPs3283ojp3lcmfKOdElX3GVzky5j7Fs/BRsUGkaapD4at7GsFMvZD+lfe5BVbX2m
	 Ve+jC+Ms7GUhiWvQyi6L1XEfLhwmhZnPugSN726HvuYSzrnipq9ccQNpwaoAp4s0WWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=DqwCNYMH;
	arc=none smtp.remote-ip=209.85.219.43
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D078A606A88E
	for <linux-serial@vger.kernel.org>; Sat, 14 Nov 2026 07:10:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D078A606A88E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=DqwCNYMH
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-91eb46044c4so40932636d6.1
        for <linux-serial@vger.kernel.org>; Fri, 13 Nov 2026 23:10:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1794640219; x=1795245019; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KKsqfMs+Khz2jHdLUAmVstaMz+t2qjUPbSjoMCe8lqE=;
        b=DqwCNYMHewOC4msVcjcbomSD/RH/iBIkH1g2hmEJMOaualbLATe3pKbpO0F6X+Ys6j
         XI5ID0YU9Rl5GHP2YBUfgaG11qLowljKPp1L/CE3dS0a7sJ0FEZuYrwPHARVno8an/I2
         fKqYLyHw8DCH+YmeSLrTExiH4Rbiy5ZRGzSoqF1J+HyLIWvHk//8j6jliUzRu9EJ90gV
         bzdYIc2cA9NWG2hMcp+mPZpHos6QTVFNDUkTMHEywINAJzvZ14tVQfxCeMwvw86df8Un
         AilmmGsmKQFnPRbl1anjv+ix9zx5Y28uQSVyExIBRJx781NleEdiHu8g5v6XoaUTedMN
         vgEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794640219; x=1795245019;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=KKsqfMs+Khz2jHdLUAmVstaMz+t2qjUPbSjoMCe8lqE=;
        b=OoxOfxWFb7diMb9gdHIFldh947N6n5NgzrtGCGWDjhp9EObJ/1cOzs9WaupzoI0bf4
         TNV99tkYK5Xa1nPMG40IcdvArOxL55ew5jbMmvr+Uh+aiYxHXiSbeogO4GrGf2Jo/F51
         y7+U24jxNRJ3V1Nf7H71RBwqJiSVKBRDU4CE1klAAtbdF12QJD7Xjfd5KfDkh9K4D9aa
         iEIqfX5UqDOju7vEFFHQQzPfZEROe1LrGUTa8v6Ai3UYyZcXU+MsObcNkbr2y152qeDl
         ejKPq4KXvcKuHligG3vAIktzfOv21txFDgIn512BnPDI64+XYys3Q3s/3wbozA7vdR+o
         SsXw==
X-Forwarded-Encrypted: i=1; AL+hErE4y0yy1n83pRGmNq+A2ZufyA900fX3u82fif0tYqUlqFDKw0xIKkRJ5HTZ0paBIn409R0mDF63D7XGII4=@vger.kernel.org
X-Gm-Message-State: APuU4Z8Qvz1K78OWrGdJn22vbM3tN5P8H8hosXVu5EArdkyHYdCM1jUg
	Gkw2RbEkFtNgESExolhE7cS/NyJPFNR27xxKDvMs5DY4T9a0jKJsOC9OWgy7cLCPgYo=
X-Gm-Gg: AYBFou2d+N3snxFfn2OQtk0rlgYlOUQPaMD96017teSZYgy6gi5Q9udfSJ91be5Ewh5
	y1nYPS7sK3D/rdK0AeBKUnTpCC+WWUQGrlKbD26B97wzK8NPL0uQxm9q9Tk+9q63sNXBNrMcBxU
	ScYCVULXgxNlxAL8IayJYKpzE6nGXngY9U4I/thN3aq0qKGcarOwU2i8NX9+uaU309d9BVIqevs
	Ltw0i+0riONy5XLn7Nksqw1HP9n55FJjeCVDRMmDN+Z09OT3Er/uLAwuVgegxitgomX+mxGOALI
	q+kD+ghUAcrJBdz6UM4XoYEymHXKKUU6zcJ+748R0NR9nn9xKIJUtKC83shu7jU8ZI/lsAKKOz8
	bZ/E8Xk8tjYqZgvbREuAOhj5HkJHAeH7XBkaYXmABE6QOl/3Pf5ehn+4tw+Ws4vOHFL5PMhmJCX
	GoVVt1By941aeiH5ndUlHEqw1+mblWw2GojUgQB4vq9/fZFVhlgrqCHnSJ5J6W8vQNggpkTNETY
	0Oe3SzuOkbmrOpJy1IbxptmcPgVda4r3FUp83l5Z5DbH16SjNC5sj4kQmnX+F+JIl+Zd+/BCsur
	drUvt8y4Igc2pX81naz7uCUiiRqF/ek1JW3Sqa9J2K3zgClQPEL9ohOssxM2JFV+OrGqVUfaFrU
	4h6ONvs/fuWavRBU=
X-Received: by 2002:ad4:5d68:0:b0:91e:a6e7:b445 with SMTP id 6a1803df08f44-91f241e127bmr84458226d6.9.1794640218986;
        Fri, 13 Nov 2026 23:10:18 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-71-191-145-202.washdc.fios.verizon.net. [71.191.145.202])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f23db3a99sm37730986d6.40.2026.11.13.23.10.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 23:10:18 -0800 (PST)
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
Subject: [PATCH 07/22] mm/memory_hotplug: migrate offlined pages to common memory
Date: Sat, 14 Nov 2026 02:09:44 -0500
Message-ID: <20261114070959.3490008-8-gourry@gourry.net>
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

do_migrate_range() / alloc_migration_target() is only capable of
allocating memory on N_MEMORY_COMMON nodes. The destination nodemask
presently starts with N_MEMORY and removes the source-node.

In the current code, if the destination mask becomes empty, the source
node is restored to allow migration during partial offlining.

Consider this configuration:
  Node0 = N_MEMORY_COMMON
  Node1 = N_MEMORY, not N_MEMORY_COMMON

Node 1 keeps the destination mask non-empty, despite being unreachable.
This leaves migration with no usable destination because the source
node is not an eligible allocation target.

Restrict the hot-unplug migration target-list to N_MEMORY_COMMON so it
reflects the nodes the allocator can reach.

All memory is common at this point - behavior is unchanged.

Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
---
 mm/memory_hotplug.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 490f400498f14..29ff2c46499b3 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1904,7 +1904,7 @@ static void do_migrate_range(unsigned long start_pfn, unsigned long end_pfn)
 		folio_put(folio);
 	}
 	if (!list_empty(&source)) {
-		nodemask_t nmask = node_states[N_MEMORY];
+		nodemask_t nmask = node_states[N_MEMORY_COMMON];
 		struct migration_target_control mtc = {
 			.nmask = &nmask,
 			.gfp_mask = GFP_KERNEL | __GFP_MOVABLE | __GFP_RETRY_MAYFAIL,
@@ -1919,9 +1919,9 @@ static void do_migrate_range(unsigned long start_pfn, unsigned long end_pfn)
 		mtc.nid = folio_nid(list_first_entry(&source, struct folio, lru));
 
 		/*
-		 * try to allocate from a different node but reuse this node
-		 * if there are no other online nodes to be used (e.g. we are
-		 * offlining a part of the only existing node)
+		 * try to allocate from a different common node but reuse this
+		 * node if there are no other common nodes to be used (e.g. we
+		 * are offlining a part of the only common node)
 		 */
 		node_clear(mtc.nid, nmask);
 		if (nodes_empty(nmask))
-- 
2.53.1-Meta

