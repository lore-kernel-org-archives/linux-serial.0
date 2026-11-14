Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794640246;
	b=tKyw3mdJJyWQBFVfy8OWgufKDPasq3b2iF9aoqD0lPaU8oJz3fVz0JPFFej5ZO6c3Xc/
	 2bUbojvbmkl964GGzoJEHNFGxYeN/MAu6enG2eeIv2umM3PgBFaOmJhxDEsvtwpHijEQz
	 UN4ldWVjU2wzahtm4bwc+3lYSDrkgxM/3fu3yxXCaGpQLQrRh1RM2Ewwdon2IfdmQj+3E
	 5ywyP6uCa7ARiPN1/CadH4eHD7DtngiRJ2Yz41B9XU0oidAnse6LX3uDIHq540RXgEDI+
	 Gky+lHQn7PVYbtfzh2AZgZMXine9y9qH/QbERP7OHJCFya74csMVDDiGgKkPmGYZosA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794640246;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=YEak+iwgBd7H+tAUDcNraVIKxkIkqE3kGPmkcYQNtnc=;
	b=ZsiQiNg8BmKd7sGkAFujfyzV24FTYZb7WQ/uXBZhIHz4jDUZZQAmevnRX1UM+SMow6UG
	 bUA+7qQjMwv4xqFlQBw7fs5p+OtOFDYH2ddeOsfc5ioCoAHuIEb0qydNopJPn3jFbr50L
	 H1RPyjMn6zgLVhoUG4YtEyVt305adeG95gPk+OZkQy9aRBQph0MESBoEujveH/auJLs4K
	 3tUxsP6Vxwulg0mS9MBqh/8chuBoQycmIWqbBI1X21A9ZiGgRpVE8o0LDmloNHIlpWKde
	 3tGQSO7+E64OVi/eoaXNPSa+rzzYUOcIUYJGk9RfYu4qulp3xiyxbUXzHuvZyKlbK3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=vA6Z457O;
	arc=none smtp.remote-ip=209.85.219.47
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE79A606C0FC
	for <linux-serial@vger.kernel.org>; Sat, 14 Nov 2026 07:10:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BE79A606C0FC
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=vA6Z457O
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-91ecbdf5343so39952496d6.0
        for <linux-serial@vger.kernel.org>; Fri, 13 Nov 2026 23:10:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1794640245; x=1795245045; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YEak+iwgBd7H+tAUDcNraVIKxkIkqE3kGPmkcYQNtnc=;
        b=vA6Z457OaKIInkkgqCLFmLHWy8VkPxMPUJrmpqeT4EKmn4j55dJGJtm+KTlKszz4wA
         UVrXxbHJUqTl2q4EWTfsddFD0AVrEgctyu7/vealCMDaACIsjVaRi6fltMovNlc/ghTa
         MZxX0LaX68Na8PnWlYi+EO7zzd8dcS8Jgcy5MuKBon/qrGxyjrHOWRez095sA3iW/r3i
         BnupImPHFtuPKI6KKpj+dxkyO29yAsiGaFeOIXhXHt/49b+fLZ6RmF7WRM1rxS8LQxHZ
         Z3iuplIcBrJiSL7Vvv0lbDuimSfZhQq6LtlRDtpKViJ9Yo9UH/x4VBFOcBISh0iqvNYA
         6IsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794640245; x=1795245045;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YEak+iwgBd7H+tAUDcNraVIKxkIkqE3kGPmkcYQNtnc=;
        b=yuJ1dsdzlc4GDBc+sJ7PG2VlY7BgCDEhFjv6c/+EmlcM2AiKil/XKqTMW7JBqPfJB6
         PvWCa0em6CdwxxTpIhHPMxmYkC4YhoIk9TpbLWpbZMdTrfSQ4OtlrAicP8J1bqtRvm/N
         P23wRThuKPK8ppvWMTvQQx0reBe862C7WTZroUqpdG9jF+iTfrmSpZDQo+SV+sK45jj9
         8Ntg6ZlAHdZqffW8m0obBD+Wkw31wsZrZJLQov0Clx/ymVMcsLir1c3Mfi/JizEJlPJb
         jRkAZt9p0FtWmCV5PLZMm7HNJQOoR/5lAG8w5CZ6wruGX1iJYSXseK+3hIygs9cU7fNq
         UVVw==
X-Forwarded-Encrypted: i=1; AL+hErGpxeXplh3jzOk/B9RM8YvK+3tUAb7osKkOTH8THRFS0f/BPctoEsjtISyIkbgrUBwSA+69ND3bNepIexI=@vger.kernel.org
X-Gm-Message-State: APuU4Z9UZzxnLQudWZA36d01IUsPl0VRhBaDsKOcMFTWbvAbOYlGyq34
	W2Sk/R9gel4rDLVIRdC/yfcnUfXO/SziDXznbuDklJ4HFFdOqie2bRo/7kWiiUAhExM=
X-Gm-Gg: AYBFou3y9/BXMGiGYlHbnL2uP7+FhkKuiznXXCDVbNscDuXQlatZKwpP8XBJE2rsh6m
	EvvGhnVpyV8WjUsdeXWNyt6hOh4swin+bBxDWBGOWN2eYGuto3C7cGcKakgSNBWOem5dSlo4Uay
	Sur4pFtzvl16iQvctv1QHcRrKnTaTVaNi+ZLylaZgAXFTLqggpdYzgtj5pbD1VDP/OAMCSIwmdH
	gpjOfdf3TsB4StI+WkB0PB3RmVRCCAeTeI7Fc3GHuA1ZbM2LTw5LUlzs/htF5UC9w5HJ7FZ+vDR
	A7IE41iglv+t6VBw3sR//I680hPAAYfjfwRuS7u7ejzhC0YrGsHGT3Jt6L9UkMCANifYNmlp432
	frhVsCjp/A3UAuKZV2qY0QsWSFA4j9Pl2sx2WmsuqMDvM2GNLe9r4HMHTWavluufphhVojM/Mrf
	GHCA/9lxP4evA1iLJqPYdTF0x8QJmVJiWoPeNMfLp4dfE1ewQX1L5hGKzZX7sLjGpBxIaGaNICA
	eGIKZzoEH8DSJlbQwC6eID8hbsX/mIr1EuffJy7yP1jZTRa45WD5UVtxOJ+xmxhYbGBsOhZebwu
	8jElc4ViKaTxCFA4kYcVOr2dgH569Qoov0E6AwA4HhFwAnkuYBCQy4oTPI6PkhNIvFvF6Go/daE
	s8yACax7NyhYsO2o=
X-Received: by 2002:a05:6214:2f93:b0:91e:b7fd:8ce7 with SMTP id 6a1803df08f44-91f2425d524mr70448086d6.28.1794640244861;
        Fri, 13 Nov 2026 23:10:44 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-71-191-145-202.washdc.fios.verizon.net. [71.191.145.202])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f23db3a99sm37730986d6.40.2026.11.13.23.10.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 23:10:44 -0800 (PST)
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
Subject: [PATCH 19/22] mm/migrate: restrict move_pages() destinations to common memory
Date: Sat, 14 Nov 2026 02:09:56 -0500
Message-ID: <20261114070959.3490008-20-gourry@gourry.net>
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

move_pages(2) places user memory on a node the caller picks. As with
memory policies, the destination should be general purpose memory.

Reject a destination outside N_MEMORY_COMMON with -ENODEV, exactly
the same as a node without memory is rejected today.

All memory is common at this point, so behavior is unchanged.

Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
---
 mm/migrate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index 28a8d7734735b..fed910c9ba9ee 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -2400,7 +2400,7 @@ static int do_pages_move(struct mm_struct *mm, nodemask_t task_nodes,
 		err = -ENODEV;
 		if (node < 0 || node >= MAX_NUMNODES)
 			goto out_flush;
-		if (!node_state(node, N_MEMORY))
+		if (!node_state(node, N_MEMORY_COMMON))
 			goto out_flush;
 
 		err = -EACCES;
-- 
2.53.1-Meta

