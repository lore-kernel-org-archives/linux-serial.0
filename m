Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794640218;
	b=Z6pRNW6OZoasUHJ9ZF6gqLh2CeX55k+pQQLZsLZog+2hsRYlIbK84EGHHutxerKEe/pa
	 SOqlIayXfvWp2b/V+1XNA1PjLdKtXl8lVmIpqp/kmExOXMUWmfpUEU4MZPPi53b5O0A+K
	 CZ3O90+FQmgpFAb8FQO7cnfJ2NdFRPqXkfn3b5dRJvZ9thGKAuAXNrqdCKfuEW6kbEEYL
	 3szhJEtPPTIjJQ8g1dkBHh++hLb0W4yUgmVtzdP7aHK7n5ShJ3uxgTjoW/d1cys9u9CrG
	 jLMsJZvjEc8xhDwmbXsX6uRXEjPn9DvViZqjl4U1nDN+3gu4OI5q+TpMdMscJTRqyOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794640218;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=pld+EM/EXNXxfgZubwvob88FbJ3qDEqFg5eLGFwAxrw=;
	b=Pn4sWyLQEidEzrR2Pc8v6fztV4iL5dcsJdF92FsXzMla8tg66J+xGqJ6XIvvbmpv00Bc
	 G+TeLND3PwCAoSiL6nLt0RbZK92SG3uw5QD69xb/BgnkuLBMLmWVJIAvaWn/8Rq/y8oTL
	 xxYH/wveK426CX/V2cI1kXgZcsfXwBbh2a4tjeCmHbAXtShgkPW9CbWQHu+S+zjgi7TN4
	 qB0meiCbHQdKsfYuYG/xM1TgzjKT/QU5lay52gPPFoeiyCObiR1YVUct33f7kwY1qWpNT
	 cFsSYjSK3GCQ7z3VSWaT94J26O4Gb/vNIXzVx9BcjIT1WnwTXsp7DOuKMYAep4ZddAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=fZh2cb1L;
	arc=none smtp.remote-ip=209.85.219.45
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C63760A3804
	for <linux-serial@vger.kernel.org>; Sat, 14 Nov 2026 07:10:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0C63760A3804
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=fZh2cb1L
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-91eb46044c4so40932206d6.1
        for <linux-serial@vger.kernel.org>; Fri, 13 Nov 2026 23:10:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1794640217; x=1795245017; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pld+EM/EXNXxfgZubwvob88FbJ3qDEqFg5eLGFwAxrw=;
        b=fZh2cb1LiTzSJJuOnufVWdO5uqn8qMfsQjZkSDcuVrcFCC3Nz081OmFdRyBdfcDXeK
         PtqCPeoNuyEztLDVFQOTRjF70fsbDa/YamFvNQf9kWWfHaCXg82Zwzsa4UJu71zJVFbz
         DrH38E4lxwMsJRxFci+ewX/0oAPjtdvLPYZ5VTYhAzrtXdl3mrASJNk9oDZMBuGQX7J4
         pZnpsmYLNfNkHHM8PmVTtoIUGhudURHAF6PdA0hZAdyipbVro6zJupwZRkdKN0fw+Q0d
         ORi4tocZDqoL6xebdcxuIfScFZIYh9Xs4P3jbWKeSHPO5JkBm9C1FtrFtA0lJ4W59m0I
         fNVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794640217; x=1795245017;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=pld+EM/EXNXxfgZubwvob88FbJ3qDEqFg5eLGFwAxrw=;
        b=nW56ylwLT+4XcyEjyK67dfHeJBvvJbD6tf1AtpNN1xSbyZFJS4nyoFz/l9Zk72+n3B
         hTeIrOt5R3oOeC9uoQAVSttF4juSgpf74v/jsBwqt8krK0TMaM0UPGq9XxpiEkC2q3lz
         IubuFUmYq9SH5RNmSAu3j3WiQQ8OWOGyizNFQ4llMovl9GAB50tKtSphkq27p7WLL/Zc
         ci2CFh6jX4hH2YNbtNm4gD3X+irFFznn5YYhcmpHoUE+BHpO7uKqU1RhVoQ+Rrm7Aq40
         DOD2c8/c2KCjRRUSxDz6U2UL6BwWdsz/W5a0LaW5Z2CpLRsLokAxFjqj05wggvVAQe94
         tdqw==
X-Forwarded-Encrypted: i=1; AL+hErF7H4qyNt3XmgoqC3Lz/KHIarFbjhQ6tJCiJr24t6NscLjaU+x4xfvkKghlCaWX/IotTb8g+FsHLvQk5M8=@vger.kernel.org
X-Gm-Message-State: APuU4Z/cXE86twdM22Q9Q2MPmKe+wuebi/uBqzAGD3i/b8bdeAvcztWs
	SvvDg88dSVBnnqCgzW010VFzlLcNYWR/AbhG1DxzitnDh626SjqMnwQL0GnILKrYwNc=
X-Gm-Gg: AYBFou0jUbosrC7+QzmRxODuCgSdOc7RODvE5FYzGDl4gL9D3chOfrSgye8uuhSQAYn
	YPIVc9XBJcfTo6dLfUIw3KtljlOw2YO2R0/kux0XgZALw3QnSwtLdW8gtPMgUwiwNeC6OKCa+on
	oSTuvo1F0Oedp85MDsIBEDukFML8kd06VDKMJSj4YG/M0XGEsd3juJrN5nV3mp6q3Z8/7AxiLRw
	2puX3muWNpHJJq88txHVjNTec7vXHndVXiFDJOaYAEZnFsdq7z+h9zYz+rswBKAvNDBODUTNUnG
	4sJlCn1DBRw87NG4ri9PkcnXrW4ZACAnutvW/2deeCLH89qqvDa2b3RmgApcduUNWhlq7axDeQK
	jVBEMCWAzQ56v0CuwGPATPfj6qNTWXEqAjoan161eiARl81P9dp2ItYMCg36g9SIc/uU3YAzgJG
	bM7fgcV+cz3J6Zt5oG3TvrZvvRn7odbQfEN2+3aZ5jSgabs7ZkR3yCeG6jhu0x2NCBfqNdEvnuF
	NpCM9pniL1n4hFhhacDj3r0tmEIvS/QoCYQeOd3Cx9lbjIn4KIFGAtxhQz2Sx/1DofTVtaSRR5N
	Mwsu/LBt167fyehPY9Fkq8o+gj1Gxc/G6E72NsTOOKlEiuV577u/6DBtI4/rRuasF5Q/BXZiFf4
	6a10GeGD951Fxo0+lACVqU4Ot60DWdck92bMa
X-Received: by 2002:a05:6214:6347:10b0:91e:cf4d:f868 with SMTP id 6a1803df08f44-91f2420f9c3mr56246926d6.22.1794640216984;
        Fri, 13 Nov 2026 23:10:16 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-71-191-145-202.washdc.fios.verizon.net. [71.191.145.202])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f23db3a99sm37730986d6.40.2026.11.13.23.10.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 23:10:16 -0800 (PST)
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
Subject: [PATCH 06/22] mm: base hash distribution on common memory nodes
Date: Sat, 14 Nov 2026 02:09:43 -0500
Message-ID: <20261114070959.3490008-7-gourry@gourry.net>
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

hashdist is useful when large kernel hash tables can be allocated across
multiple NUMA nodes. The tables come from ordinary allocations, which
only N_MEMORY_COMMON nodes serve.

Count N_MEMORY_COMMON nodes when applying the single-node optimization.

All memory is common as of now, so behavior is unchanged.

Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
---
 mm/mm_init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/mm_init.c b/mm/mm_init.c
index b4c4dba93652d..0c076bf5bf380 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -685,7 +685,7 @@ __setup("hashdist=", set_hashdist);
 
 static inline void fixup_hashdist(void)
 {
-	if (num_node_state(N_MEMORY) == 1)
+	if (num_node_state(N_MEMORY_COMMON) == 1)
 		hashdist = false;
 }
 #else
-- 
2.53.1-Meta

