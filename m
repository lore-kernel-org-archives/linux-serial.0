Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794640250;
	b=Ufzyg9JfbUgNDMNFZnrBXN0m2wzLA3PhyFCx6SN24oWlsYAva4sAWDtvwpO6mzgmkKl3
	 kx7ax7zTTH3mCyD4pe+pO50OLepFdoRk+rP8Ip1DC4NiBwZ+UWKjCsOSNv59rUPbNkMVm
	 cSM/E24W2Fiscp2j4GUsTh/HCD29cDbvMr4Oq6Ohi1fsd7GTWTPPXKU8YRIPT0eHLbStd
	 HGQnu7339MT1e7xTtWnvSkzPSUBMT1qyvzpqOU/Q75Di2LJR7RQ0UeXR3SMhxNN7XySWS
	 f6D+X+kKEm5VfZM+xgfHfjWDSUoksQX0TSPJ4S7dvvv+f9GHezyEnbPOcMUHeZ5MRkA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794640250;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=SG9odMntLujN1bfv7U8SkJUk66Dld0t8e7Q+mOyqXTQ=;
	b=rAWlQZVIF1rmnUkua8fvBToUbmVmvrX+OKRsMrnaB/raDMPh+6Tm4f6gcGf+zuwh/Ezi
	 ZVVmOy48V/bK9pIM7N8Ot/ti8gc3uDfKVkGlxdW4OdfeK2QJdaAjDofnrW39fNfDUKKv8
	 KuzyyYM4+K1Vv15MFK9InSAfccUIwjEmtYGk9Mb4/Q0XST2mvrbMrS+m6H1e5FFZDiAhm
	 COIQHjYe3gn0Ju1M4Psk7Djcu5BuzWeGuRqtmUf38wj2YxiYyLy+GLBTtC1u6Idflxr/x
	 FQXAoCg6UXaPe6v4Nhdc5jMGbBzg7Sb8eiFZ+TuKtecAPq6x/phxDyhSYCE1MwtdPUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=nUe3qafv;
	arc=none smtp.remote-ip=209.85.219.49
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0A73606CD9F
	for <linux-serial@vger.kernel.org>; Sat, 14 Nov 2026 07:10:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C0A73606CD9F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=nUe3qafv
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-91ea5600c9cso37050446d6.1
        for <linux-serial@vger.kernel.org>; Fri, 13 Nov 2026 23:10:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1794640249; x=1795245049; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SG9odMntLujN1bfv7U8SkJUk66Dld0t8e7Q+mOyqXTQ=;
        b=nUe3qafv9syivid2So3rSgvuH7DZPXQ+C2hNnSKPxSgCSgNstQOq5ZauJDPuC8EzGe
         EPc3rvJ8i7VX8Vx4z3rdkuz4b5/v9ZapBbQpvdki/go/ijbQrxbYSU1NDWob3cDW97LD
         LnMvjnQ9of22Wo+EjgkaA7b+zyM2DJPnxYp2a89EeFLotBMzHlXVjFeFCTHrKTeY5NcQ
         91ghXJtB51aOfQmHtaFyRmryRQlu5a3ABAK7+f8sC33jgP5MHGfXKYht3G8gkN0Q90UI
         KipjlM6Ftuf2DaQAouZwIsVVWwkNGIDa3kAx+zcyykQArICxW/XrYq3vejy92XQ0eKEp
         S3Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794640249; x=1795245049;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SG9odMntLujN1bfv7U8SkJUk66Dld0t8e7Q+mOyqXTQ=;
        b=bsaE6CViHooshWqpAwHHZCZFkVXq4a0gmFlDoB67H/nutbMl5OyNKEgZAOxmHyMAU5
         GWFCq/glIlI86T7Vm8gh61DJUvJaID81yTcyEf8uoNVZlA/RuBfd1GgwtdLDffeDWozU
         KpKR+V5xngHrm3cnDqhg7AvyYF8jmPDocJgHS8vewtNyl6jSt0Fwf45fUG3gTL9Z9xAm
         I+2jGFRzdplaXnWspgzCBvP8RbEEGnwlelQyL0uTpFHJxAYlgtYxI9yVBFC+UNlfbEk1
         V7HOw883eqcm8TQ+T6SEQJq1KBqWHNvjno22EPv5YNg3hbv7NxZnokVXLYPmhQc6iaE2
         UeLQ==
X-Forwarded-Encrypted: i=1; AL+hErFvZpkB6+h0V/m4MJCYtbjdTZVQoz8ajVutTs3rT/1x2DaFBKQ/jBJwA/2KZTqXEVDemYwuE40vuDUhIoA=@vger.kernel.org
X-Gm-Message-State: APuU4Z/OFTuqEvZE3COgndN0CgTEC+qJo0MzpgqxWzx4DdlshSKXYkFu
	Y5jzO54wsZq0MNGHzl9z0GcDn6p1vKiuY3OqV7rFB1kgLsiwDuhQJpsBLx033tjnPcw=
X-Gm-Gg: AYBFou03EFEmtusUWpxIcW213+HeW9WrwvMbArDEjQNE3B+W/6wd/QlD7XJOOVWACrW
	9VIIoHrYsHWIvmB2XmTECv27vfLEnexExf4jB2MiWnvZzfXdM+UA/JHRMh6nDrW6pd4T4fPDu8x
	QQ936eY/1FJ7AaYHOCp2ZH8YJX3p/6CTjMuE4/aeDuCnJdYhhLI5MqYYnyiXnmm5226c14bm2HW
	ZRZ/jFS3K3sczr40HMm1AdmAdiHLZy9CZ1teO2vCAlaJ69PuTiY3sl+3XtxdCKyw2kIHgAK8RXq
	fV7hTa1acuf/hSrBzTuFnFvmwk13Q6XmkpftZD+B1qHyh4rJSK4bE15XChjaZDyB9JH+vpMScQ9
	1m9obn2qm7njPDu4+1bzHATNmgiTkbU53GaKJDwcXHeG1vUKiUUkO12PxnXiiOtxB2LEA3ei11z
	OjhXMGbZlv7sMQeKdPqoPGNYftfIXKh/DjiiCS9Yrz3NUTmo209RORur5ekg5k/mOcFbDRgXvJf
	QMbb6lcpkXtG7KhArPms/tiTEBnh+6r+A3gMmLQ0Zkvjj9luHvKnqPewk8thI3PVNCvGAp0IOh6
	DktqZakigxD9sDVYIBGhn+csv3is/56IV5Tj5fcYR0mE64Bkdgr8CxAHo6BKE4sPaKwRVonBxDg
	lhgnTiOUY/JD7VPhS
X-Received: by 2002:ad4:574d:0:b0:91c:913:462c with SMTP id 6a1803df08f44-91f23f211e7mr73834306d6.0.1794640248788;
        Fri, 13 Nov 2026 23:10:48 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-71-191-145-202.washdc.fios.verizon.net. [71.191.145.202])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f23db3a99sm37730986d6.40.2026.11.13.23.10.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 23:10:48 -0800 (PST)
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
Subject: [PATCH 21/22] mm/khugepaged: base the recommended min_free_kbytes on common memory
Date: Sat, 14 Nov 2026 02:09:58 -0500
Message-ID: <20261114070959.3490008-22-gourry@gourry.net>
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

set_recommended_min_free_kbytes() reserves two pageblocks per populated
zone to help THP allocations avoid fragmentation. The reserve serves
ordinary allocations, which use only common memory, so count only the
zones on N_MEMORY_COMMON nodes.

Every node with memory is common, so the recommendation is unchanged.

Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
---
 mm/khugepaged.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index b4bd29f25c145..fac314b89a234 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -3149,7 +3149,7 @@ void set_recommended_min_free_kbytes(void)
 		goto update_wmarks;
 	}
 
-	for_each_populated_zone(zone) {
+	for_each_populated_zone_state(zone, N_MEMORY_COMMON) {
 		/*
 		 * We don't need to worry about fragmentation of
 		 * ZONE_MOVABLE since it only has movable pages.
-- 
2.53.1-Meta

