Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794642613;
	b=tJsW0eDXSEvqsB6mxtyPg54ZP59h7VPEK8rT59wxx7nYv6RbSEwm6OwZz0nN4oV/zdUF
	 PjAZdUMTT4SWNSPCqUFvvHwbMmYmU7+R30hwovcUegvQCVpmNDas+ArzWL/mUMuFI85J7
	 iSVAM8yP00ZJFV3Jm100QNJuHKvLUcv1CGTV8kmdXZy1wJzGLTvy3fuJnu/1s2ugKR6/i
	 I3/TClbh894anIjFJrPMsshQFsY/rM8qwcSk+Mi8RFPzG1rbKUEeNC3YS55bIG1Fmr7M1
	 kjmW8pkYg2FUtMwlShQFgiB/YNHWaoCoHOx7WZ/xrKolUa7HgKwqwg+HszjIt1iWmNw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794642613;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer;
	bh=cGbHDC4e4qa3gSIc5H3tZOXqH9VLSX3BMg1aP/6Q428=;
	b=pECaXoo4vd6kGCIfa/cqXy9jHf+k2R4cy6JwcuqS+NVpgGitp5HwLr4GKbn1EDXikKRr
	 SSL3MnpOVylSIJ6D1OFaMqxZQn9lygKqaTbEoShMJQ16xQB966PiK5fV9r13/CzapZ8sY
	 zuqMhUdRBpeLM39YoKVZ9iE9iXoFiYX8Ttl4+oBsxCWg1eB+UXhzpCLCYOersS0yBvo/Q
	 4j0cRiQrRTs1119eiy/kyC7V9Sr5Pu5uMfIcmM6WCtAvc36az60EG/XGxK29hb9/eJLAZ
	 YFumTbkI90CRL2qQ4hbfoy+Rt0snZrt6oAOAFLcySYn8USXLv51wLoacd4NSXbBJAow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=SF6em5du;
	arc=none smtp.remote-ip=209.85.160.175
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D25A6606A329
	for <linux-serial@vger.kernel.org>; Sat, 14 Nov 2026 07:50:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D25A6606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=SF6em5du
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-54f873cbe2aso27671721cf.0
        for <linux-serial@vger.kernel.org>; Fri, 13 Nov 2026 23:50:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1794642612; x=1795247412; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=cGbHDC4e4qa3gSIc5H3tZOXqH9VLSX3BMg1aP/6Q428=;
        b=SF6em5duzVjUCkIvgA+5+oFXUOsWIns/6/N7iMwfWnVzbC1tBgVSGZ0POCCGPJGAph
         lZzuvdfVtGLtNvnnMk4Q6fmeQeI1Zf4z1y1Np+gv3FVtwN/PdMlHceEufLPJUXVWuW3R
         yT8zxaqtXQ0KIt/xqddZ5oSC2mDPTlWBYMdjFbhLdc3MenvnJvjogSPz7V1igH0WKT5G
         YLOqL7cBD3Ed3rSLgTLWmXdhYqfhKZJrAesyFiW/4xR+1Li3Obfdw3cVrzn0wC3ppXcZ
         CvQxB8JFCIeWSx7dJwgOT9LlaMqQglsw+XA8pRJcYp/5jbGZ2FKUHHmKR+G/C5zqp2Lx
         YQIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794642612; x=1795247412;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cGbHDC4e4qa3gSIc5H3tZOXqH9VLSX3BMg1aP/6Q428=;
        b=vwBgFENiNkHUGMXHxwnHvUB+xy46JTdAOuJu27e/kWvdVwS/GB4OLs8Q9G9UP1zxjG
         T48FsR+3mGogFaQo5JqPHBDqj3esaDZfFn1QaALMI29eiuUvCvtfhpkUc/jl93qGTUaK
         jAHeNS/r5KQUHK2A5zWcuHhHGtR1XHpxhrHirmCRE4wuqyQsinDVb3nSAu6q9SXZBRK2
         UCtUVy5l9PK/ECkIulpfc9ccx9UaUZqRFwSgZd12zL6RgxE9dgkRnJSgMBAlcCyUeKE8
         7DI82+8zvrAredxoxC0Vaaojh/V1EW+ELZKE/sOHG2XyVjRTSdPvqKqENliicyAOYOA0
         slvw==
X-Forwarded-Encrypted: i=1; AL+hErFJKS/W1I7FNK5+94BlXnzuHXenUH9TOJ+6y8RhYAa8AC2YKQ5f8XosmFnNCkKUVK1E90pv5JHinIRL7Sk=@vger.kernel.org
X-Gm-Message-State: APuU4Z9tJIqn8vllRIALivG3scihLS6wBJJ51CzrOOcvz2kj6gSdZDmG
	oq48jojGWBXgbftfFRTqgPspoFuyZr33qkXON2H8PiCJnFVa7ZN4GeouP8Lv9i8PWJ8=
X-Gm-Gg: AYBFou0KVDNo2zTihdA2LmCC7O1/V+opl/rBe9N0iwxLR6vlXoS6NxZIJCsz1FMIthE
	ofpHNuqmhGnSPIzTyrC+4I8kjz1XVWljeD+JbP9VyY8N4VjZuJ6KXx3v2my2Cbm/uxr+bMVnjXD
	hKlJ5jvZTMkGYQitIrkEvtl0qFVTpMGUGNefehH+ka+pZRKr+ElkJ9UW8G6tutPTfHB9Za3YUxR
	vzaQPvqHplv2dZ/NBt1ELj9T7JPbBSBBsIV2/5k8Y+CBkmKdF/iotLQv1bFnaUXDiHk6ShyNhpr
	gP17AKkVBpxVxokcV8/Z0o9HvUkhOfp9VrVGo7MQ70KTI4l1ta6UOotGMLKbyyQECVY6yDSaVUL
	Wj8Cxc/TIV/8jWABCjbDuN2MFpmQUMBEmtPsuIrD/oz/U0nIySDvtVBJMxXshrIHieGUjmDYKY/
	IHaRUCBKmBKyXRSKX40cwage/kOShqGwcevs3d/HyDSu8f4+ViqzQZPOej7hSftblGGAO8lB6jU
	dvogMdjzQEtppuhOMpiainOXWZ/7yQsGuVq4kZDkli9qEQcCMWJSohXeez1MAbfTM9qX62VXdTK
	4IhJ7TbdrtG4ehqPKpRFfGB6T62gxtV7IfhU2AlWnOuv8FQibeO+QwT42EJgDiZEZg9zJzoLeIh
	nf3OrtiA=
X-Received: by 2002:a05:622a:4890:b0:536:6378:c80d with SMTP id d75a77b69052e-55ac7d4f0e5mr76447071cf.32.1794642611571;
        Fri, 13 Nov 2026 23:50:11 -0800 (PST)
Received: from [192.168.50.231] (pool-71-191-145-202.washdc.fios.verizon.net. [71.191.145.202])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f23d445d1sm38109806d6.8.2026.11.13.23.50.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 23:50:11 -0800 (PST)
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
Subject: Re: [PATCH 20/22] PM: hibernate: size the image from common memory
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
In-Reply-To: <sashiko-outbox-214264@kernel.org>
References: <20261114070959.3490008-1-gourry@gourry.net>
 <20261114070959.3490008-21-gourry@gourry.net>
 <sashiko-outbox-214264@kernel.org>
Date: Sat, 14 Nov 2026 02:50:09 -0500
Message-Id: <179464260972.482102.15351839494267219366.b4-reply@b4>
X-Mailer: b4 0.17-dev

On 2026-11-14 07:34 +0000, sashiko-bot@kernel.org wrote:
> > @@ -2011,9 +2013,10 @@ static int enough_free_mem(unsigned int nr_pages, unsigned int nr_highmem)
> >  	struct zone *zone;
> >  	unsigned int free = alloc_normal;
> >  
> > -	for_each_populated_zone(zone)
> > +	for_each_populated_zone_state(zone, N_MEMORY_COMMON) {
> >  		if (!is_highmem(zone))
> >  			free += zone_page_state(zone, NR_FREE_PAGES);
> > +	}
> >  
> >  	nr_pages += count_pages_for_highmem(nr_highmem);
> >  	pr_debug("Normal pages needed: %u + %u, available pages: %u\n",
> 
> [Severity: Medium]
> Should count_free_highmem_pages() also iterate over N_MEMORY_COMMON zones?
> 
> On CONFIG_HIGHMEM systems, enough_free_mem() calls count_pages_for_highmem(),
> which calls count_free_highmem_pages():
> 
> kernel/power/snapshot.c:count_free_highmem_pages() {
> 	struct zone *zone;
> 	unsigned int cnt = 0;
> 
> 	for_each_populated_zone(zone)
> 		if (is_highmem(zone))
> 			cnt += zone_page_state(zone, NR_FREE_PAGES);
> 
> 	return cnt;
> }
> 
> Because count_free_highmem_pages() still sums all populated zones,
> enough_free_mem() continues to count free highmem pages on non-common nodes as
> available room for the image, undercounting the normal pages needed to back
> highmem copies.
> 
> In addition, alloc_highmem_pages() and prepare_highmem_image() use
> count_free_highmem_pages() to bound loops that call alloc_image_page() or
> alloc_page() with __GFP_HIGHMEM and pass the returned page directly to
> page_to_pfn() or swsusp_page_is_free() without a NULL check, which can
> dereference NULL when highmem on N_MEMORY_COMMON nodes is exhausted while
> non-common nodes still have free highmem pages.
> 

HIGHMEM can't exist on a private node.  Private nodes require NUMA which
require 64-bit.  As far as I know HIGHMEM is 32-bit only.

Trivial to update though, so for consistency i can add it. 

-- 

--- a/kernel/power/snapshot.c
+++ b/kernel/power/snapshot.c
@@ -1291,16 +1291,17 @@ static void mark_free_pages(struct zone *zone)
 /**
  * count_free_highmem_pages - Compute the total number of free highmem pages.
  *
- * The returned number is system-wide.
+ * Only common memory counts, since image pages come from common memory.
  */
 static unsigned int count_free_highmem_pages(void)
 {
        struct zone *zone;
        unsigned int cnt = 0;

-       for_each_populated_zone(zone)
+       for_each_populated_zone_state(zone, N_MEMORY_COMMON) {
                if (is_highmem(zone))
                        cnt += zone_page_state(zone, NR_FREE_PAGES);
+       }

        return cnt;
 }
