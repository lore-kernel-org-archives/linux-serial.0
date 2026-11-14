Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794640248;
	b=oq7ATic5DBPSC5RGbFpoqUH4+1eoe5o0oqKVFha7BCKxEhU35BCNvStNU/oh2iLaJj4S
	 XReMiACkvsuJGZNcMApnPaiHhLNHaftIYljUcCVXqqMcWy64U303bKkRCWsyJoJv07FUb
	 t62fWO99MemcRnpk3XJNh6iqX93df3KBmqKTvcrMgpTB4aaWFxhDbUbUIk+hT/WWLESAJ
	 SGcpEHNY9B1KdXXf0FBka7XvWwRk79E8z3LBXJmbfBCr9lh19+ZZc9oaAbkwFYv8glToH
	 aWKFtmg+0O7959w9VwukRG03plwJdQRCFGSiNi3jlvVa2vLxXRQVyzZyXMxrnGzEXSQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794640248;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=2WARPg/nf2WwBmWaZN6JnUP4gbZP7FMkF0eRnIkIgZ8=;
	b=3W0gzBHsIFS24G/O/NC8mO0rey4C3jb/dLqgiXq9JviMQvyi2K0OcDwlJytr7zgIHuKi
	 6PsaIvTExdhSVAZVHADhLFFXUNgD91UzcFkkDyrF87PXxnkdI7TuclxKZovv/vZXC+pH2
	 F9g99MztPULV4uWBK6HZ7DI97IxzvCW6WF7nub2++VJ1+shj8zuRt11mZtHLMesq3TzOh
	 siCrUQB44cZjyG9P4qNmL5utzqF3XRo0yOdRnjE6y0OeGLQzcWDyTwn3T2Y+/bF6j3z6L
	 SJo8VHpWPE1BMZD2n3KFy6CIUYAqC+YTp6cXoDpHL3sxkguEZ2OiTSHdYK+EtdzkAKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=BLBdnt0i;
	arc=none smtp.remote-ip=209.85.219.53
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DB5E60A380A
	for <linux-serial@vger.kernel.org>; Sat, 14 Nov 2026 07:10:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1DB5E60A380A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=BLBdnt0i
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-91ec396c93dso42909426d6.1
        for <linux-serial@vger.kernel.org>; Fri, 13 Nov 2026 23:10:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1794640247; x=1795245047; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2WARPg/nf2WwBmWaZN6JnUP4gbZP7FMkF0eRnIkIgZ8=;
        b=BLBdnt0iRNFdOZZN6B0cCDu/hXyt7k9PsSJY3QJCW3ekKrAX8pBPAbkT3WVRuWwYMw
         zSddppBa0D0C7Cm3/JDK/25sp4KjGdI2ObCcZ3l+uuVPtSgiCU952hXfESBUlw1mczJg
         KHLuORDxaFQGrfgG+HMb2PbJ8MbRDgOlPMNKfZQHAiNb7/kvjLe5uSwFHyHGL1c1Wn5u
         n/yf9bUliz7p0g7CF/tctqSCoW6EGDPz3Wmzti2CG/xreKkeI7Dz0p26HxXLxyI8SqoP
         jC1f5E71FBV3WJAhSXNNIB1HwWVEvPiiJHfQHn1hk40/DTFMdowDbXfXF0FkV7eRjWMi
         Jwaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794640247; x=1795245047;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2WARPg/nf2WwBmWaZN6JnUP4gbZP7FMkF0eRnIkIgZ8=;
        b=JKVvTAH8nfxs447QK4T5DZT+t9A54c9q0oNnkGW7SGfjTLvr6s0JpsceEavyUjliTN
         Qvad0WA5aNee7s3/goIjLC7vq3hninrFQ/Q911/CR1nWhyqNY72N2+plw9nxE0oOlPQo
         o1B+8y9WJOoR/4Wip6wbLJ8vm0H462Aymkhn7rKq1bOTTmSKVhj0fGGHmQrVWp9fBqaD
         QCL6+9NtA3ItJG5zpKYAAZWS/P+YNXSaxCd4FPVnPQ5OdYoeTJd/niLv9In2X6jTlo4I
         uiaClKWwUHisX0OjGigyYJZA4kG33agPX9hA9C4Tumo/uzv8s2Q4JLdXOIGULP2Kwpid
         XrPQ==
X-Forwarded-Encrypted: i=1; AL+hErGBaqsKlPkPvgYUB9ohMaSxldAZDUNdLhOji4WpPQjA5gjs8uJodrlM9bQvroO23TQ2PXoEoxSIjsZy4V8=@vger.kernel.org
X-Gm-Message-State: APuU4Z9joJsSVesfVcBtWsC4dO12LuJ89/qLnIpum46cFFND9FezzlQu
	m7V3cd/pouZH2bEx3K7sla/2fOG76xDNnFPtRSzX0AyKVvDy54UzfD/O/0PXBbFLg6E=
X-Gm-Gg: AYBFou2Wo2nptobdSnMGpruGPg6tVFyrwTvL87pqverQNSDh6B3ZF3+z4/2tAUYGUYF
	8ZPOyYVPq4MolCcEK8ITpUtVL93ld6gDk+XFD1X8f9kCfgmuSoEncDcc5K7dOEVaHedsbKWdcsb
	Hqh+06rHLbTAWNS2Hwkst/dE3NmjJkp67ht88Pvx3taxcQ3/4WY32NbLg72a3YfwuR9j/TW/w84
	mbUfGusNRxDQLXPonrTW4OQhR/4eOVJIBO9c1YVCxwsoBbBgFbXU/PxRTLIejmoMQX/+erTLQfX
	hLR4kJ1RnwtWaDQcCJCjT108v4Mfw8/VsDBo5JZOm/qhdIkifU5Q/T/bpyDR4SPUFKoQaTUp8S8
	I18fCmEA3J58nK2Ils+8fgIMAftfE65OYfTNKYIQsS2o/ew8Y1Arp352m2ooC7N99bPhuVAAwT3
	nsDYeSa7XvnUAgWLOXfy3WXkQ+BqZqFoz+AKkxi+z5qdxou3+oPvVyYU0LNTUsO4lwmcnQontb2
	Remkn6l+5wAMhi0n7scaYtfBu/rfSkmk8fm3aOluRZXP+ZCRPyD9KxcPf+2s+C08wdAcks8xD0k
	Q/lKvZPnE3ukQwbLFGDaql1hVLjwIC4zfM5G/a9Sa9yyUAEpRCNOqGH/0Nw6cYoXJD2tBtkc390
	ixE+2uJj/s73Wix4=
X-Received: by 2002:a05:620a:801c:b0:93e:c12c:fbb7 with SMTP id af79cd13be357-9494bc76c5amr813866785a.68.1794640246800;
        Fri, 13 Nov 2026 23:10:46 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-71-191-145-202.washdc.fios.verizon.net. [71.191.145.202])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f23db3a99sm37730986d6.40.2026.11.13.23.10.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 23:10:46 -0800 (PST)
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
Subject: [PATCH 20/22] PM: hibernate: size the image from common memory
Date: Sat, 14 Nov 2026 02:09:57 -0500
Message-ID: <20261114070959.3490008-21-gourry@gourry.net>
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

hibernate_preallocate_memory() and enough_free_mem() count the free
pages of every populated zone as room for the hibernation image, but
the pages used to store the image can only come from common memory.

Count free pages only in zones on N_MEMORY_COMMON nodes.

The image metadata estimate is a separate sum.  The bitmaps track the
page frames, and every zone's frames are tracked (regardless of node),
so that sum still needs to be calculated for all populated zones.

Every node with memory is common, so hibernation is unchanged.

Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
---
 kernel/power/snapshot.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
index d5dba0e50b2eb..8aeb086a3fd3d 100644
--- a/kernel/power/snapshot.c
+++ b/kernel/power/snapshot.c
@@ -1866,8 +1866,10 @@ int hibernate_preallocate_memory(void)
 	saveable += save_highmem;
 	highmem = save_highmem;
 	size = 0;
-	for_each_populated_zone(zone) {
+	for_each_populated_zone(zone)
 		size += snapshot_additional_pages(zone);
+	/* Image pages come from ordinary allocations. */
+	for_each_populated_zone_state(zone, N_MEMORY_COMMON) {
 		if (is_highmem(zone))
 			highmem += zone_page_state(zone, NR_FREE_PAGES);
 		else
@@ -2011,9 +2013,10 @@ static int enough_free_mem(unsigned int nr_pages, unsigned int nr_highmem)
 	struct zone *zone;
 	unsigned int free = alloc_normal;
 
-	for_each_populated_zone(zone)
+	for_each_populated_zone_state(zone, N_MEMORY_COMMON) {
 		if (!is_highmem(zone))
 			free += zone_page_state(zone, NR_FREE_PAGES);
+	}
 
 	nr_pages += count_pages_for_highmem(nr_highmem);
 	pr_debug("Normal pages needed: %u + %u, available pages: %u\n",
-- 
2.53.1-Meta

