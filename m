Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794641745;
	b=ofLm4FVeAC9lt9GVfh1kd6dlWaBmXQ1t717uISJQZ+/yNsOXp5t7EgB/Z+csM0Oi7S9Q
	 iRdEbd5er7F0w1j1e0Caicy0G+GfTuVDyfokYhgCt5WSXRT7S+wVjSVt6c2t4KThBR2du
	 8eDp7SGH5KgFQ/URNR8NTXYqJmJFwqWsvxsQ1UeO33rzd2PoU61cUBUskJOtnxcZi0sMj
	 Z7mJj8WwlbHxxwgBRYhiUv1H2/EAlpOSUNP2q1ZZ2u/ZktrjnfOf0eqnTYqM1wIM+L5aR
	 nDQ2irl+qkCyWC8bmy0JfvAMScndV6iZHZKpqpj/t4uWb2wQlT0I8bh5H3WeD0zti+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794641745;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer;
	bh=cahiVRSoQzf74nfMrEDmS6N07dyHDuJ9YLLjX1noXVU=;
	b=H0k/C1LaPqdKd7mpICKwAgNSldr/vgRwNlyoxd86x81L4yBc9xoC4qCurdl3qyc3coEi
	 7pibhQgy+rj4Pwz4KHfYNTbg5Qv5FbTQ0hxNuCRd0t4HiFrDR4i8F3s4mRdVV5qw00p81
	 /lViJVyaTrSI7sGyvvggN1anpYzIB/zR2zwDmxqxNav3V21IOaOIGzSkIa0fag9fC+jHB
	 kFTISh5SjTe1/vTTrSnV/VVpvJEvz7BhBmhBdKQDn/yng7eOXbDyoZePZc6oVi1ZeYYV0
	 I+K6Fgc8JdC3yX75zm07U77YrhIB9ETZUmqmjLO3NumABk3x9xCD1g8LUXXrIiUdjkg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=tHUmCCnA;
	arc=none smtp.remote-ip=209.85.222.174
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11EFD606A323
	for <linux-serial@vger.kernel.org>; Sat, 14 Nov 2026 07:35:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 11EFD606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=tHUmCCnA
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-930c0f9c1b1so273335185a.1
        for <linux-serial@vger.kernel.org>; Fri, 13 Nov 2026 23:35:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1794641744; x=1795246544; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=cahiVRSoQzf74nfMrEDmS6N07dyHDuJ9YLLjX1noXVU=;
        b=tHUmCCnAIOlSRqPnope6qy/HDBmtp05h3zARNLDDt9oEoYBK05I02mM4Dw+hbkYgdM
         f4q28vLTW7w5KLZKYy+AaL2CQNavoO0Dc9VGMbNZQ3XD5RwHiJmKuu0IzhfyJFzILKwY
         BdGBfcw3Lb0Ms2if9Hwkz4C+9J4YGzhvMGbsk75XJUNWKlIf9iP5iC02SbnLkyzg3u/5
         awiLZJgw54s9niTJeCDEGZcU4MRbaRIAQA7ljcJtGkQhUIVx9SN1VNe/hVQ26D8SEEG7
         60MxCibY6twX5qPfiIQQepeDxTC+YSSHGHtaKj+175U0ZtrLK2c+vNLU0aHXL9kxu2gW
         gjQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794641744; x=1795246544;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cahiVRSoQzf74nfMrEDmS6N07dyHDuJ9YLLjX1noXVU=;
        b=dwqMukf+A7uw6Yg9sbPL3dc/QlyQIccM8F84qRVl2nuMQwyqkiBFW4jlQZCjSalHIu
         c/Ml7RKqRcsxVbBYauGe07Kmwsm6bvYXL/9C4LbdqzDnSHEQwUXIcJNfwrZbDIdEybus
         Q2axej3Mpk0g2BcxsTLCWETkJDFl+hsfQnNZgBMSKmiCmUKU46xORdlCZ9S2XREnTc+j
         qe+4C6jj6Dj6dRW0RW/8g8D/120laHnqnZesao9+01bffu5qziW5O76yOIpKXtTLsGIu
         v4t4LdbdiVIqYQY2QkqFryPzCBCk0uM3mChh8oPKl8pn4Jgs9z8P0XCvWoeb7l76bxxB
         Ev6g==
X-Forwarded-Encrypted: i=1; AL+hErEp4/OrVJg2uwKeTRfyCSy14ARGjhk2NMCBYnsl6C9VSEfdiNV8XWR3NF3VpMQQM55ElATLzKrTssDXw2o=@vger.kernel.org
X-Gm-Message-State: APuU4Z+ym1qjttvdTDJB2CldA0aJYtjCTETgGBVL5qAIjsq1aBvVZE3U
	AET1UJSAykZSZZy4fKJCFuP+fsDbevle4eCs1XB495PfSV3uD4K+oiv4jx2P4nLCw48=
X-Gm-Gg: AYBFou1L2ejctsaIPdwZfv9dIu7diLJOt9gQTWOxZzlrl2NoaL8MFLxV9vVfzu/J4l7
	uhgPXw//BNm7f2xUeedeE/d8LFEDuUPa7aeypglGUgD0ycDtJ2KUFWikzUrpAZVHzgZqIBofx8Q
	X4Kqlfe04baUn5RVKMNfW92KEGAtcKC0p5qHp2dBgvaGBjNMKnvnMYWxxQhknzn/Yuq05Z3+FR2
	iYx0ONMhXGEi9CpWpN6Ry2Hb7zO7ER/lS5oFcPnGdrgrxaepJ7TXzdVKlPKCd9si8ViwdFQzvQ3
	J/L0Zi0m4uTnwLvlDA2uCXEO+PIqmGW1ewL0jd7hOu26PRY0EzMYdhNQq81sAhxdJT7Wg9lcBLw
	xHfw2K/oHLKslVE2SoDLdfVEXVSGIZh9t6iGfw2NLYWn/c3+ouuSzOuYbc9ZIwjufaxqd7vr/FF
	jjC2P9QV52IfGeJ0m34aZgTwz0g2WDnx2/bSPHZZl19lj2vCV9TyqfF2BmWrhUd5Ti+5z4vCf1J
	8TJvAJYGXyzitoZwHj8AsWaDts1jdRW0XUclO9O2o+kHrh5bjNngy9rZ4j/mrrasJSu6Mjo7JqT
	Q2JrgSZuhkVSjmPE4E37ulhaFgOYemRsj0qJvexzUDhhU9IFweYlTb4J482m6PzU2XJ6W4QV4kx
	EKBYxTdk=
X-Received: by 2002:a05:620a:a00c:b0:949:6193:acc5 with SMTP id af79cd13be357-9496193b1f6mr334016685a.74.1794641743958;
        Fri, 13 Nov 2026 23:35:43 -0800 (PST)
Received: from [192.168.50.231] (pool-71-191-145-202.washdc.fios.verizon.net. [71.191.145.202])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9494c803ad1sm357502785a.12.2026.11.13.23.35.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 23:35:43 -0800 (PST)
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 10/22] mm/khugepaged: restrict collapse to common
 memory
From: "Gregory Price (Meta)" <gourry@gourry.net>
To: sashiko-reviews@lists.linux.dev
Cc: "Gregory Price (Meta)" <gourry@gourry.net>, linux-mm@kvack.org, 
 kernel-team@meta.com, linux-serial@vger.kernel.org, damon@lists.linux.dev, 
 linux-cxl@vger.kernel.org, akpm@linux-foundation.org, david@kernel.org, 
 liam@infradead.org, vbabka@kernel.org, rppt@kernel.org, surenb@google.com, 
 mhocko@suse.com, corbet@lwn.net, skhan@linuxfoundation.org, 
 rdunlap@infradead.org, gregkh@linuxfoundation.org, rafael@kernel.org, 
 dakr@kernel.org, johan@kernel.org, jirislaby@kernel.org, kasong@tencent.com, 
 qi.zheng@linux.dev, shakeel.butt@linux.dev, baohua@kernel.org, 
 axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com, 
 baoquan.he@linux.dev, baolin.wang@linux.alibaba.com, yury.norov@gmail.com, 
 linux@rasmusvillemoes.dk, pavel@kernel.org, lenb@kernel.org, 
 hannes@cmpxchg.org, brendan.jackman@linux.dev, ziy@nvidia.com, 
 sj@kernel.org, muchun.song@linux.dev, osalvador@suse.de, 
 nico.pache@linux.dev, ryan.roberts@arm.com, dev.jain@arm.com, 
 lance.yang@linux.dev, usama.arif@linux.dev, kas@kernel.org, 
 xu.xin@linux.dev, chengming.zhou@linux.dev, joshua.hahnjy@gmail.com, 
 rakie.kim@sk.com, ying.huang@linux.alibaba.com, matthew.brost@intel.com, 
 byungchul@sk.com, apopple@nvidia.com, rientjes@google.com
In-Reply-To: <sashiko-outbox-214261@kernel.org>
References: <20261114070959.3490008-1-gourry@gourry.net>
 <20261114070959.3490008-11-gourry@gourry.net>
 <sashiko-outbox-214261@kernel.org>
Date: Sat, 14 Nov 2026 02:35:42 -0500
Message-Id: <179464174225.482102.14033958474429517565.b4-reply@b4>
X-Mailer: b4 0.17-dev

On 2026-11-14 07:21 +0000, sashiko-bot@kernel.org wrote:
> > diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> > index 4bbe319ef86fa..b4bd29f25c145 100644
> > --- a/mm/khugepaged.c
> > +++ b/mm/khugepaged.c
> 
> [ ... ]
> 
> > @@ -2741,6 +2741,12 @@ static enum scan_result collapse_scan_file(struct mm_struct *mm,
> >  			break;
> >  		}
> >  
> > +		if (unlikely(!folio_is_common_memory(folio))) {
> > +			result = SCAN_PAGE_NULL;
> > +			failed_pfn = folio_pfn(folio);
> > +			folio_put(folio);
> > +			break;
> > +		}
> >  		node = folio_nid(folio);
> >  		if (collapse_scan_abort(node, cc)) {
> >  			result = SCAN_SCAN_ABORT;
> 
> [Severity: Medium]
> Should collapse_file() also check folio_is_common_memory(folio) after
> locking each folio, matching __collapse_huge_page_isolate()?
> 
> collapse_scan_file() drops its folio reference on each iteration and
> skips missing page-cache indices and swapped-out shmem entries, and
> collapse_single_pmd() drops mmap_read_lock() before calling
> collapse_pmd() -> collapse_file().  Folios that are faulted into holes,
> migrated, or instantiated by shmem_get_folio() or
> page_cache_sync_readahead() on a node outside N_MEMORY_COMMON after the
> pre-scan will still be isolated and collapsed by collapse_file().


Ah, this is technically a pre-mature report, as this is an unreachable
condition at this state in the series.

I do already have this handled in a phase 3 commit where private memory
becomes migratable, but i suppose this check could be moved ahead just
for cleanliness.

--

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index fac314b89a234..7a69d6e9b42bb 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -2390,6 +2390,12 @@ static enum scan_result collapse_file(struct mm_struct *mm, unsigned long addr,
                        goto out_unlock;
                }

+               /* Migration may have moved the folio since the scan. */
+               if (unlikely(!folio_is_common_memory(folio))) {
+                       result = SCAN_PAGE_NULL;
+                       goto out_unlock;
+               }
+
                if (!is_shmem && (folio_test_dirty(folio) ||
                                  folio_test_writeback(folio))) {
                        /*

-- 
~Gregory

