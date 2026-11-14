Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794640240;
	b=dLoee+dJvuemGjjiQHnf9YJHfQnwVtI1tqi7HXidm4X4RA8xg/9FN/+XJ1RGJpFxLTYR
	 VRcxoPxuRX9ws6BHhbv1lCwlcH6Ter92zOaprHXkq2k7KPUswmGPFgCybsBEDD07oPYgv
	 xy2nRykXh/piee07n3E+1DtF6/bvI/nDKa4AGxnrB7f704Pd8W6wFdgRLPod7VuvJk4Z1
	 yOT1SKt808j31ZMLKpH4YReLfVMz/T8SZt9F8rpE8DnJ/Gj8P+rUrt5cXo1aETfTnRhuF
	 qAxnvVJaPGa5fCIQ3uZktqAmrPiqbeZEh1VvC/IP3mG1ZSBavbJI5s70GxAKq++UJDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794640240;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=TW0pg36vCDijleVRTyqZR6UjU0iehYYk3FdVNC+q6Cw=;
	b=AFIrU4zgaqzUz0rksIJVuutRITYmyP5kFhCJeMRZTCCvlNBSieZ+Bpc+jZhXREbcid3r
	 TD7i9HIdpIztkfRoJ7ystpOyseyL5MeqMLZ2RXNHVz9QZA+YV19JpGLJeWixzCa1Tg9Vw
	 6hwrXz5OtGlVVm+qlCumzG7Z+xPq4EhI1gXohCezKceuk6HrI8VsqUmBiZSnvlhtTWau0
	 B+H/vd7ipMLoT7y86jP/RPY4zyAnAVcM+LFWDrapid94JfS+GD4gKGIArWZKl3nz8fuk9
	 VrIeq9DBVhKMtGk+40eEquEa76nZmr9iWWb+P+IgRT1iChVCLx8kHajMCLtl6iIaFtg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=Q3DA2nko;
	arc=none smtp.remote-ip=209.85.219.54
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4E2060A2618
	for <linux-serial@vger.kernel.org>; Sat, 14 Nov 2026 07:10:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D4E2060A2618
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=Q3DA2nko
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-91ef011e338so29793646d6.1
        for <linux-serial@vger.kernel.org>; Fri, 13 Nov 2026 23:10:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1794640239; x=1795245039; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TW0pg36vCDijleVRTyqZR6UjU0iehYYk3FdVNC+q6Cw=;
        b=Q3DA2nkof5TccLKEKOkpoD4tlAOwkqtDIAn0I7af3oHWDqV3MDanG1m+HE/Hze03RB
         qgl3c5vxWVmkXsR09wn3vLHdDsQxs6n5d5kmh2vSTwdxhuPGurTHI/rf19CMjpalpwLk
         Bat76O/tF4T0TriwTFkD4rF4Myqr5UPy8AlQL4K/O+nVeq1syIpOIfYk8TaDUdAHd5w3
         QDiVsq+WKJug4sgJGFgXNDsZz1FuysrzHgEgwFF25lm8FzKJWbtQrAoKggIMdZvxF0BJ
         30S+RNohN7c+/TVaM/HNeDtJjy04gi9aW1TsyxUlWnJ0PK27ITnaJvWinVawe5+Yuzex
         YAhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794640239; x=1795245039;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=TW0pg36vCDijleVRTyqZR6UjU0iehYYk3FdVNC+q6Cw=;
        b=aAtBuR92x05UhX3Zmese2bbfl2qiysVz5Bp4zJ4VqY6YIX6eV8q0SM8CN7P3PiXxSW
         WHVx1S/+exqyaYM8rrnxuFwPQctRE/2WBIAwLsS1yGXbV8xGlG5QerPXZ/Y2efhORzqH
         wPojS/94NIuyJSzFFgSKzVksTKaKpaME/Onc01b7rj2SH4DjzKA1raehd/+tjn6+HUku
         SjClAKykBOoNk5uOTFkS+ir713Zrtgy92NlQ2akfKBb5GSMUxv7723kHJDrD4qDAHWUF
         NB8j6l8KJjnuHT//ftq0Naj9DEt5nhPTrXOUERl0RiI+FIFUmW/4X5NfLBQp2SiBdOUW
         YghA==
X-Forwarded-Encrypted: i=1; AL+hErFHNd6zqAxHeEhGU8JRu/IWFnE4mEJRR0ijvMZi+lLDiWXv2fR8pnebtuTw1g+uY2oITYIbDhisUtKlV48=@vger.kernel.org
X-Gm-Message-State: APuU4Z+TU8gGuAKJ+PXIm/MiKNbifno3Tjiu8U3OA0j0X2auMbGZ5G54
	whnh1Qworbqi7zJWKEA/xxKDiIeEQGaFQunaXiXTUWKfL8gOz0+h+wm1QHA+7tGWAg4=
X-Gm-Gg: AYBFou2YB8fM7WNRa0++LPepQ8VhGmarY5nDoVuZgHg1pHWnnE66YgVZHFvo2Ajwpi4
	feZMuIxhy2lVYn29IzOVvjHKLTLBy2Ni/QoTIbutiEkQdkWgoWBgcqLjtuSW9HZg3n6Ek/K2UrX
	xZNre+vyBDZuUGj8cf3r0tF3Ur9iZI5Bc/Obd9zBbwnyKHf/62b1heJjUXvk3Veeqb01TC9rkFL
	5KKbIXHUXXcHqUItBBzCGaXWdJN3A41q/2QSmC0/1dD1sVjII4A0es8hunw+8evV8xLMsWpTCk9
	Cgs9fO4GXgRvEBmMZSMaV7G/021xwoxk+2WXGpXFLsCzS9sk7+JInm/doOrcbgvsQQOkhMnr7Nf
	JPeP25EOBbcqLCDDZrTMK7107MB8kZLPTF7Tgvh1zSU3uaZmFi0QwhrtLoKIAUkdz9ux71w0X4l
	aWh0PHic66Ue2CdWKsWmirhLQh4BnN45ZaZqOVfzqRx9hrq60aCWgbwZkTxYGRE6yCeZE1I+IG5
	jEn337dIz6UcQv9qPvEuQIAHKtj5Qyp9/lqLOWVoUjuRpazQQUe5YPeTr/4WKYAKoyd4gqVQgnB
	Qazi6vyQOOX64iKBz4jwXOOrW84+VEB9El+bDFwcyXG/jzZEL+5LPay3brwuwQfYw8qPKAyM0G3
	Vl9xzGef380DZaVWsqTwpl8Eq5ITnez2M4VXv
X-Received: by 2002:a05:6214:1311:b0:91f:2208:b683 with SMTP id 6a1803df08f44-91f2428c6aemr76715686d6.55.1794640238785;
        Fri, 13 Nov 2026 23:10:38 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-71-191-145-202.washdc.fios.verizon.net. [71.191.145.202])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f23db3a99sm37730986d6.40.2026.11.13.23.10.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 23:10:38 -0800 (PST)
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
Subject: [PATCH 16/22] tty/sysrq: use common memory for the manual OOM zonelist
Date: Sat, 14 Nov 2026 02:09:53 -0500
Message-ID: <20261114070959.3490008-17-gourry@gourry.net>
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

SysRq-f constructs an OOM request with GFP_KERNEL and supplies a
zonelist for allocation-constraint checks. The request represents an
ordinary allocation, whose fallback domain contains common memory rather
than every node that happens to have memory.

Select the zonelist from the first common-memory node instead of the
first memory node. All memory nodes are common at this point, so
behavior is unchanged.

Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
---
 drivers/tty/sysrq.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
index f4571d05b4962..824f5836b47d7 100644
--- a/drivers/tty/sysrq.c
+++ b/drivers/tty/sysrq.c
@@ -386,7 +386,8 @@ static void moom_callback(struct work_struct *ignored)
 {
 	const gfp_t gfp_mask = GFP_KERNEL;
 	struct oom_control oc = {
-		.zonelist = node_zonelist(first_memory_node, gfp_mask),
+		.zonelist = node_zonelist(first_node_state(N_MEMORY_COMMON),
+					  gfp_mask),
 		.nodemask = NULL,
 		.memcg = NULL,
 		.gfp_mask = gfp_mask,
-- 
2.53.1-Meta

