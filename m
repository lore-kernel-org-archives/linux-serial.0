Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794640252;
	b=wucS8YdmjGbrrPQmu82DVBwKX5dXen+Fq6OWAglqcQjGoECkhFRl390EZL2ISYuYUSNW
	 VUqCQKI+ybVPJIht0hphrXzAs9iUzc0VkCLZtZXhp1oeVjqWYBF/ZD08AmiP3F+pazpuo
	 vF1AFgtmcEZbTUjQw+EqdSm81G0k5Om4kMOLcbKv4Mw0YdZKM0zGAVykNcBiMs4DUVc9c
	 V4njVrjlkv0GN3DvQZRGol+Ie4xeCL4cBrlSuAqil4PFzDJWtIa7w+z0+AyWIgQf45Ie2
	 +R33yw8M0YlLntKQw18IqWMPRre32X7ijRixhQrUYLiqTuaHxtRKdEHbKAWnlvdnRKA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794640252;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=+HAKXNFyWuVVus4jyGRYSZgEnC6sp/o+JpWnVYJ3k8U=;
	b=whdbJWBAAZ80FQKd5baee/q3Hw4Y0fB+ecSWUs3R/5Ibf81VGgUKSimVK846UviT4LXj
	 WdW+YNx6EbbxKAOB1L2RWqECYzSQuXnzmioM9UkDFLTqojaybTmvdyKLtOnj00ocpEpee
	 tqQimHcRB3Y4iNTAdX4N8ZfxCp4zECD4NHcKKXLy5TyLLi9De3jNplrGlKjw3aODENgxg
	 5I7RCThMe6gvev2pRmF7oDP1TG92RJ/u4GQMy7GysONQVGknN7pVurkuoP80auW8YkvGM
	 cJyuZYhNxeKYRcJqgx2PexnrhPcCLDTdQxgngBRsuyOg6Zss+vX9MA1aI7R1v70A4dw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=Ok0h8iL2;
	arc=none smtp.remote-ip=209.85.160.182
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3733606CDB3
	for <linux-serial@vger.kernel.org>; Sat, 14 Nov 2026 07:10:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B3733606CDB3
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=Ok0h8iL2
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-53fdd2fb171so30461591cf.2
        for <linux-serial@vger.kernel.org>; Fri, 13 Nov 2026 23:10:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1794640251; x=1795245051; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+HAKXNFyWuVVus4jyGRYSZgEnC6sp/o+JpWnVYJ3k8U=;
        b=Ok0h8iL2T10cI+PFEuVIRGMDCQ8NRP8Fvz/7tqv55sIqhrJCRGSWcCpReX+dtqSuP2
         ju0VM52/CASXF7CQSnL43mof+7dO6XSHI47KpeBuNSnTQDrqrEnd3GcKgPAUVOYGauxT
         de4vnDF+SMAr6UXzmWg3c28ZY4rCoWGd8RqnhDnP6NM0npTcE8VtLbuilixq0g2CEYxs
         +svzoJS5VfpJRygWBIcrxBCy0d2NU/KdVMysL9vxlhdsh6BofY6ssX6fsKSm1C5oxNGX
         mwozWZkGrlxN/J/oH5CRgxpsxUUGABpZxa67EC7pTOlS0qAduZMHCi3ioVdjNWNK0FG5
         e9Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794640251; x=1795245051;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+HAKXNFyWuVVus4jyGRYSZgEnC6sp/o+JpWnVYJ3k8U=;
        b=WRpmfmZrfb4Wo/YTaSv6o8kmdz3Fyx25LgDT48DfBH8oe8UbxbiVPKAWWc+n0tIet6
         Czq3pl+JlS3nG2G9pn5dpW+2+7CVrTAstdwXJVnhcsdnGO1Vgc3kZiZIu24arlHhG+iw
         EoCpwjEwAZvXAF1iuKHmJ/k6HtFm0/0lzkD8u2izod5//ggBojlWBafXbeVGiiyam9Lm
         RaWZ/nNwwD7arYGCtk9jbhUtghXD3/FnwDXN7UlIWk+v9mPu+82IGxnNtS+c+srL8sKM
         UF0mqpJ+DkZsp6VF7rZwP/A/anMSxR6Q2DGM8+hdW/WXY1sxi5RUC40ptz//wwQRi91D
         qA6g==
X-Forwarded-Encrypted: i=1; AL+hErGFF3gXVnBuzknhfH0xS+GvqGhpU8QCUe4jwoupCkLhZqCdYGu04xbnZcaD/mFlF/esCdIv8cfQvxZedTM=@vger.kernel.org
X-Gm-Message-State: APuU4Z/iU0CS91TvD9Fv1fQqxsFq35VFdbNESKEA4yP1FRjN2atD4y42
	5ykWdUMRCCRUUuKm/6e3pqiBPwhKFOC3ZXGW0MgepRg7XvxOWjlWELYVnRE7D8fS5i0=
X-Gm-Gg: AYBFou0TNvyG6ZrONj62n/JQWsgXJGJPKa3u6LEStdqz+8aEBRiTkunSVqiBkowVrJ/
	KO2E6Z5qpvwYWIQxLaC2HNDiWtkJ/vYBKrPdLqJmTOuvWZvcIiWBrli68Pem6hpDYYK47eRSpbu
	yNGb67hBBgkcbDvHoTfMT5DBZ/0iEmv3rAkUtz67K6HbUzRRq77WMFAL79Is6FXTo+WG/yAAX/X
	VDW6nTxRRxE1lBulMCx3wZbvezNsT1MhPI4+3eV22qge7oJ6bwt1Wn/PP+wakZSItUtRxlPyF3b
	f8CnoVZ2GqA4KczMT/ts7Vsmq+88Ru978fK0ljM1u0ivZrbeD3730NhIpsb830BSMidzc1X2TzS
	JUkyqyxNyZHzq8Y+v3I99jkQWv4hSWvUb2gpwgqiCgHpDTqIBGBp/iSBhiPjhm+iowYXeSTAQei
	ZPp3W0cdJBeR6zbz56eXTFtExzY24h5pmZOkr2s1r/eLqMsZriHbxscMZLVKgEYugarphDjwDbr
	4/IRpEADXnWmypSHKOXXCj5pGQBclCUZxDgkEiCFkTGB0TO3YLo1i3a2OolXRe4Sv/Ncn7QQPIg
	elLM9v+4HO/HZhHS8Y9KE1kPdtdgVRZaRCvYWjA/m63+FY6oNmpT+/dH+zoTwYMnvkF5O9LOVIy
	wKHzpp5iZkIrmOLs=
X-Received: by 2002:a05:622a:191b:b0:535:a5fc:3b58 with SMTP id d75a77b69052e-55ac8b9ba4dmr73074831cf.68.1794640250752;
        Fri, 13 Nov 2026 23:10:50 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-71-191-145-202.washdc.fios.verizon.net. [71.191.145.202])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f23db3a99sm37730986d6.40.2026.11.13.23.10.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 23:10:50 -0800 (PST)
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
Subject: [PATCH 22/22] nodemask: remove the now-unused first_memory_node/next_memory_node
Date: Sat, 14 Nov 2026 02:09:59 -0500
Message-ID: <20261114070959.3490008-23-gourry@gourry.net>
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

Both helpers hard-code N_MEMORY, which says only that memory exists.

Every caller now names the state it means, leaving no users of either
helper. Remove them so new code has to pick a node state explicitly
rather than silently getting N_MEMORY.

Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
---
 include/linux/nodemask.h | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/include/linux/nodemask.h b/include/linux/nodemask.h
index 7ace610bdd654..eea0ff7601303 100644
--- a/include/linux/nodemask.h
+++ b/include/linux/nodemask.h
@@ -457,15 +457,10 @@ static __always_inline unsigned int next_node_state(int nid, enum node_states st
 }
 
 #define first_online_node	first_node_state(N_ONLINE)
-#define first_memory_node	first_node_state(N_MEMORY)
 static __always_inline unsigned int next_online_node(int nid)
 {
 	return next_node_state(nid, N_ONLINE);
 }
-static __always_inline unsigned int next_memory_node(int nid)
-{
-	return next_node_state(nid, N_MEMORY);
-}
 
 static __always_inline void node_set_online(int nid)
 {
@@ -509,9 +504,7 @@ static __always_inline unsigned int next_node_state(int nid, enum node_states st
 }
 
 #define first_online_node	0
-#define first_memory_node	0
 #define next_online_node(nid)	(MAX_NUMNODES)
-#define next_memory_node(nid)	(MAX_NUMNODES)
 
 #define node_set_online(node)	   node_set_state((node), N_ONLINE)
 #define node_set_offline(node)	   node_clear_state((node), N_ONLINE)
-- 
2.53.1-Meta

