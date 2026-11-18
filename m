Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795017082;
	b=rB+M7ySb7mJdcCTcyBP9MDkfPfKBNvV+Xl5AXB28u67bQfBh1S9ofLosPjtkafm/jT0M
	 gTbyJw2otEV9FmqKlS94uUHf4j5Lh8eGoDt8emU9KykVGWPq1oiT8DD9yhQY9XoJnXQku
	 I2hcoTVluC6s4UwiMUnAR0xZ5QqFPeqjkpblSmzvoatRXzVhc3q+/Lnmf44zZ/kVEruTv
	 ad3vUZxqqTxpoYCV0pXbPQhNNoTh/thmwDnT1m0o5NLtUQPWEclGT0Z+pL9fB/MgkIv79
	 jPwEzyo6NJ0U+BBlDzPOZVOWzMBUmZfNXUyAmR6QBXX1+bzWYF3NoNn7bsF4pgiD89A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795017082;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer;
	bh=rtu+dm+kZUdeiLu+ztbJ6g6Gzpa+7bPUZ/F65mvaYZ4=;
	b=Ub5wQHm1EtTioz3uHv2c4URb0FkCE/91YgC8ED3JFCATdAWN4CKVV69ZRLRcnefmck9N
	 tM2uYxhVwNuL81mfpz4xRVxPrLHnVEfuap0ZTLAibTcwHc0E3iYiL+zIr8qIStQGu72L/
	 z0TTPB2mDyUc/yr63BspwCTr5kijHbH9Fgu9RrEzPXdSnZFA4dC+8DjB6Aj4wkkOQ2Kww
	 ehIIbgHvVrJ87LjDJEo5tND2L6736B5h0on5/s5ruz6npmIubqx2dzayt0W+2qwbbrkKD
	 X3598TWPwxR3lLGgr3DU6UWrJ1Z/x9qoRKJVGUsl9GPqyb5qFxa4f0rS4WDhYJjoVCQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=CqFB5PkO;
	arc=none smtp.remote-ip=209.85.222.172
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02EA760A2602
	for <linux-serial@vger.kernel.org>; Wed, 18 Nov 2026 15:51:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 02EA760A2602
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=CqFB5PkO
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-94961ed97bcso138586085a.1
        for <linux-serial@vger.kernel.org>; Wed, 18 Nov 2026 07:51:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1795017081; x=1795621881; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=rtu+dm+kZUdeiLu+ztbJ6g6Gzpa+7bPUZ/F65mvaYZ4=;
        b=CqFB5PkOnM+jvAv7ro+HFL8RPRzHIJTyl492dti2dljQd3wyAFFyu9HAkhm+anbp8B
         uvCfhGnk7pw9Hf6Wxwj+qknoup+tslME/SAC9BSsgKXdywMvXRtsJxl5jXwIbkgrtw0H
         YsXSfwi9ZAXFWkd5QYdFiQUdjvwEGBhFNFkmhoPD0FUTS6O2P2cZNimb4nldmy0cUb1L
         YbzAnXtxIxAeadwaWNpbGyFPOrJLj5xyUbMxiZgzYgX8IDb94l+D7JpA9zYEjT7BrNqm
         pvy8ZFOnH0w+IS7vnDR9ueJvC97X/SQf0ycgblv03SriCllJZcoeAMyBnVHfCbECHmFj
         AxfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795017081; x=1795621881;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rtu+dm+kZUdeiLu+ztbJ6g6Gzpa+7bPUZ/F65mvaYZ4=;
        b=L1L/78rOX7IM7M21WnWkyEq+ho2+sUA4m1q06kAEa5NWTC5jINEG36yOyvbCLrChl1
         jL0KFeW8VEIp6dZ7Tsh7O5VhfjBOWARJ8CFu1tiF3qXm587TqtlbKAtX8gKjmOXz4a30
         gyQKkqF39OJDdoBEKV8FW+HkINfaj7YwUCEWAgnLcbFF4digiddl+/9NXH75JD/sXNJz
         o8urhqLH9zoDXP1ZC78furYOsO9TLUZUjOZjsJmuD/PYRqsBwjCFg/v7cQmpeV/VpAgg
         JSYSCbvhU3rsQziyUusLoX3YJ5N5ZyM3yP596o54a+IodJjjR1TVI8+iqjqomoKDiI98
         Q6gw==
X-Forwarded-Encrypted: i=1; AL+hErGy3fVSdW6hqFatYciGU+XxFqfX/cW8GjQFR+gfiaJ9SxvslHhe0PxTD4wwi3qS3ZnkpRUkJu2oCvyIMvY=@vger.kernel.org
X-Gm-Message-State: APuU4Z+wAza/6Esj57g7th6ZxqvnkuLbBr6nOhFltxqFHN1Jp1Nt0JAM
	18xM6+v71LlCoa76/d4JfhSHoGXpARBZOeCtp51kSE8cYoRsK7Y1yBwqVjtFRwzCCRE=
X-Gm-Gg: AYBFou2uPWosGVocx8/s6qT2kYBY8FdoF+faftg922t+4YWgPv8IPS/FjrcLjFtXu4U
	sA+qihbUUoBbJw5cHkI/Ct8tNShyGBlcO3squm9pRFWpBsoPzZce4vDKowU2/3GvIBEAbJYaEOM
	jKpg197s7dtfJ17bvK8pCJ58lgXx/lrOvzh38crkBcEuc1rFIuU0uOlX+SPriou6CY0eH2f9K81
	oZpDGS6gjpD/hdg3GeBl59w0ekV9JsJuv7sPOQvNPCqiyeLPRjVwBmqZlxoQ3BQnlcoG9rXEd6i
	5q4BA+LwOuiCXeEWI4IzR4hyUOHKaYc/wSf6sa1DhYqcYenpp1lHLKywHFJEU1HCAAeL5BqBxEh
	Z1PdV9m5DClhJXXdp9qpfdAOKO8X0DwRx1jwP0DeGKVkdolzrgrQAjhfJmudHf+SHLZsMkoG8iu
	Kst1GCH1SgPaE0n4fzX5jfXpyXDZgskfdoFLYD/h8mYUjlI9URtcrR5/iigm0bdvVoWntPvLjPr
	C7ljAKBI0Jncr33SxaCVJmS52ZxaoEDx03rPEYbri3OwbTuIWm/uAwuRwQgyM8XYRXteH+G/h70
	uDIyWwWVekFRBpzdKgPCBVJ2Q1TLk32l7kcDwEUvnrAAC/aYp/aUBVwzZb9jDQAKEOZU4Sa/oyP
	uPgHxBhM=
X-Received: by 2002:a05:620a:8086:b0:93f:2938:48ba with SMTP id af79cd13be357-949997ac21amr514417285a.55.1795017080864;
        Wed, 18 Nov 2026 07:51:20 -0800 (PST)
Received: from [192.168.50.231] (pool-71-191-145-202.washdc.fios.verizon.net. [71.191.145.202])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9499b454facsm210842185a.5.2026.11.18.07.51.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 07:51:20 -0800 (PST)
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
Subject: Re: [PATCH 03/22] mm: introduce the common-memory node state
From: "Gregory Price (Meta)" <gourry@gourry.net>
To: Richard Cheng <icheng@nvidia.com>
Cc: "Gregory Price (Meta)" <gourry@gourry.net>, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, kernel-team@meta.com, 
 linux-doc@vger.kernel.org, driver-core@lists.linux.dev, 
 linux-serial@vger.kernel.org, linux-pm@vger.kernel.org, 
 damon@lists.linux.dev, linux-cxl@vger.kernel.org, akpm@linux-foundation.org, 
 david@kernel.org, liam@infradead.org, vbabka@kernel.org, rppt@kernel.org, 
 surenb@google.com, mhocko@suse.com, corbet@lwn.net, 
 skhan@linuxfoundation.org, rdunlap@infradead.org, 
 gregkh@linuxfoundation.org, rafael@kernel.org, dakr@kernel.org, 
 johan@kernel.org, jirislaby@kernel.org, kasong@tencent.com, 
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
In-Reply-To: <av2_8Z2sdM_9zUEL@MWDK4CY14F>
References: <20261114070959.3490008-1-gourry@gourry.net>
 <20261114070959.3490008-4-gourry@gourry.net> <av2_8Z2sdM_9zUEL@MWDK4CY14F>
Date: Wed, 18 Nov 2026 10:51:19 -0500
Message-Id: <179501707902.1206716.2408532904937875068.b4-reply@b4>
X-Mailer: b4 0.17-dev

On 2026-11-18 23:24 +0800, Richard Cheng wrote:
> On Sat, Nov 14, 2026 at 02:09:40AM +0800, Gregory Price (Meta) wrote:
> > N_MEMORY is overloaded with two meanings:
> >   1) a node has memory.
> >   2) a node's memory is reachable via ordinary allocation or
> >      an arbitrary MM service may use that memory.
> > 
> > Allow N_MEMORY to mean #1, and introduce N_MEMORY_COMMON to mean #2.
> > 
> > N_MEMORY_COMMON nodes contain "common memory" capable of being managed
> > arbitrarily by the kernel MM based solely on zone membership. Following
> > commits convert relevant N_MEMORY users to N_MEMORY_COMMON.
> > 
> > Add folio_is_common_memory() and page_is_common_memory() for MM services
> > that walk folios. Following commits convert folio_is_zone_device() and
> > page_is_zone_device() callers accordingly.
> > 
> > Expose the state via `has_common_memory` so userspace can identify
> > the memory available to ordinary allocations and common MM services.
> > 
> > Add has_memory to the docs while we're here.
> > 
> > Every node with memory is common, so N_MEMORY_COMMON equals N_MEMORY
> > and there is no behavioral change.
> >
> 
> This sentense kind of blurred me, you state that N_MEMORY_COMMON is meant
> to isolate the concept of #2 from N_MEMORY, I expect something
> making clear distinction between common memory and private memory ?
> 

Sorry, basically as of this set:
  node_state[N_MEMORY] == node_state[N_MEMORY_COMMON]

Later, we'll introduce N_MEMORY_PRIVATE and the sets become disjoint.

I realize posting this series in isolation was a mistake now, and I am
going to post the entire v6 of private nodes with the reworks you
suggested instead.

-- 
~Gregory

