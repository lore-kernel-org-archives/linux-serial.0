Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794640236;
	b=43PvskBHCtKs0GlKM0OGZv8/1KtTWvdDTntQS9bSmBpw6Ct0qpLQvRdZd2Hl2jWp4U5e
	 aoIB4N4Wm0CduFijqEO+wklsXMn/22XUaNR6YT3AB6QxRli40Y0xn/MROb1JJNevzi+9y
	 DyWiYBT6/x7VOWrGNYczMTpCwXpgHPfXsuwFXXeZmQEUNow4zHndtiXOHX0NpkpxfkVzq
	 kYlOt1qrbvV+GVu7oiFrAV7NLqQzliU60ibJlBT8te67g0dZ7ETPx+Nlj13ejG6xggVbL
	 KxiAoH6/lrfS10rnFkRg4vHPBVq0b3wxW/lsarWomYXFOscZuJewkLmhUic3cqoJAzQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794640236;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=LMm4cY2G8/N+lvY6+YyUeSTrUdIgOLxyZozNrk1mUY8=;
	b=ULvlTbZs7Y/YSIXxYRqPolE7KqGGeLIQloKSjLwvi/LsQARzFWgty44NdTRGXasl9m2H
	 wZwNcC8Ev9/lONtz/aeSdTVyP4eyHI+5SfDvVnKyUrKV6IRyqRQqVIJoVQG0bgrlgxjwC
	 lHcaOZ7/xHU84P6A4c0m42zKoPROM7dxLuV7R79VTF+PVp3CZcGBnCFCNdslFMy22yCuN
	 WsF2pfPGuo4Sxk2t/XgWr42smuX9mDTlmm9YBRtsTnPsKBYG2M1uZIyQxKrjRhethkR31
	 StSGTGyhPttnJjEktUHsEKHROpSSlU6uj2CJCRWSzvzXOIYTHRMcm3SM0y/mZuMEdPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=NrD2qtKj;
	arc=none smtp.remote-ip=209.85.219.44
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5592606B41D
	for <linux-serial@vger.kernel.org>; Sat, 14 Nov 2026 07:10:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E5592606B41D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=NrD2qtKj
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-91ea0c05c92so32026986d6.0
        for <linux-serial@vger.kernel.org>; Fri, 13 Nov 2026 23:10:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1794640235; x=1795245035; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LMm4cY2G8/N+lvY6+YyUeSTrUdIgOLxyZozNrk1mUY8=;
        b=NrD2qtKjeYgj8rGYN1fwIgSL20IT9bdCQHMOHTKrC9oC+X0gc2vtwbP/0pBFXO/NP0
         HQOX69QwWq4MNb4Li8WvfWTySx3QpG8CmXSfXqHpUcRgG3oSbMC6WqjxDT/m562PtycD
         KuRcCudGGIt3HNVFfi9LLJLq4QR7G6eDIkxjamWnnAZ3uR0790bOBXukHx5SFAIrogr3
         rVV/a3g+hhDNs12AsnzkGTsK4afWNTRGDAIlhg0fF/5oN9rABG187RlzqBsqM/hs+ndi
         B9r6nI/+MN40ZYs8ZXdDilJk4BzjEhxnTnlkpUl5Sv88KAYoSVQ/VQIkHc1QjmG5QWeY
         nXbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794640235; x=1795245035;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=LMm4cY2G8/N+lvY6+YyUeSTrUdIgOLxyZozNrk1mUY8=;
        b=ZunGpaJPlDp/yC/4vOacdRnIwkU3HTN4HHu/SLcOMVnvzi+4fBjyGM8cZ3RUC8foWT
         hG43W8KYiEu5LGVAOO8QR7kBX2vpiTU8QzJs3TOwhfgtMWRO/BmdXMUcXLwcB8XMAUlO
         h5PKqt18PCu7SEaS8nRcrVliViAY0G/BSDmuJDs39Qw1n2nNKiR7/myf/iDd7rM0Ytwj
         GDQzKqk2XX1EoYrnzYTfDQMkZlaUOtXVH4k5bgZ/HEqIIdEIjPa4pcHzciOO09cVield
         uTXxac5LUOGGjGWDyKo2RVO34kmiRzwxIHilbRM9OdgosSGU1u2lYpfv6vfV9w1SwMU9
         WxyQ==
X-Forwarded-Encrypted: i=1; AL+hErE9zj5F3d0LMK6IdIfX+EG4YupMi01CCitgdLS3ecVa0GoXVYQncp3dBvAmalla6wjOi/IzkmQBsFyoEX8=@vger.kernel.org
X-Gm-Message-State: APuU4Z/KURXeDiCf4ruxMQGwBcolT+CYCMFVTg69xR7gxhNkGqHrBmhs
	OLEUcJ2wPdXRo8AWUmAsMuT5DFHMTiQDWYpJnhC2bWkXQyNE4DyyHxoqZcouWv479kY=
X-Gm-Gg: AYBFou1ZXIKaLYa3OcIUgf+P057eWa4oi7ZOshLWRYUIpWrmfzPtfZj+rL1t81jK5Qz
	sFPhbwHVeBXpIo8HeAgcpViecghgP4fZSsQKn5D82FFZZ4VoK3LdmnwjCIZbvKKZkRTRR3v+Y2p
	Abzc48XZ31Pn0Oto6a6UVAOLUi0vAJqkRQm9vlMwBmhwMq9yhkncwz7yFVBi0JGnEMBdLMZNCil
	a4RrSssWOpWk2Amq2V2SQHX4EmoyRfpGuJzpqlUTg6ST/jzSe5IBZWIwm0RKky5vNEaTUWe27Sz
	1ykRLILpknBRWd2ocw8R9TXlGhGOflQT4QB8EiuYjhlOlwuoKGmFjT3SbGXTn2ovrRgPuE1I87R
	njKnNyTELik5s28c0sjIPaHE7KhvAl4jHx8PalO7kprxHsaM8isu8eX0NKBBvOMKStgpl0cILBf
	U7f9O/PajxoNlHpuXGRjCg2025igOxC+sbddwejCKOYEWK6cJ+2QMUPiviquPnmvqELrZB4myqN
	qtyRJErgcUc4DCkEEDxraz/YuTAvP22qRdZFqKGjZ0/Tz7OFAh1LCYdWw2+9brWAbT3ZxCCQjwE
	l12NJ+ePptTCifY8bkHuUt58tMh9DFB1IrisfOMixVNlxrU3zYh8aA+sShS0EEYJpAw2yDz/42B
	5LkJZFVuIzBZqaRs=
X-Received: by 2002:a05:6214:1d2a:b0:91f:17be:7c90 with SMTP id 6a1803df08f44-91f2424c199mr78511936d6.55.1794640234508;
        Fri, 13 Nov 2026 23:10:34 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-71-191-145-202.washdc.fios.verizon.net. [71.191.145.202])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f23db3a99sm37730986d6.40.2026.11.13.23.10.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 23:10:34 -0800 (PST)
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
Subject: [PATCH 14/22] mm/page_alloc: count common memory nodes for kswapd recovery
Date: Sat, 14 Nov 2026 02:09:51 -0500
Message-ID: <20261114070959.3490008-15-gourry@gourry.net>
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

When a zone recovers above its high watermark, free_frozen_page_commit()
clears a hopeless kswapd state if more than one memory node exists,
since allocations could then have fallen back to another node without
triggering direct reclaim here.

Only common memory provide fallbacks, so count N_MEMORY_COMMON nodes.

All memory is common at this point, so behavior is unchanged.

Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
---
 mm/page_alloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 580feeb608b7a..6d98e213460a9 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -2949,7 +2949,7 @@ static bool free_frozen_page_commit(struct zone *zone,
 		 * kswapd work again by resetting kswapd_failures.
 		 */
 		if (kswapd_test_hopeless(pgdat) &&
-		    num_node_state(N_MEMORY) > 1)
+		    num_node_state(N_MEMORY_COMMON) > 1)
 			kswapd_clear_hopeless(pgdat, KSWAPD_CLEAR_HOPELESS_PCP);
 	}
 	return ret;
-- 
2.53.1-Meta

