Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795014796;
	b=OJCR68MDXVsANKqo39ukNqURzJFiFMaJmP5XeFFVi1rz42gJoO06JVnALuRoo1vRoAur
	 i+SnJtOxv7BX3NIYimq8Cjj+AWVK5fKLEdL7XPSD1DXXcqBa0BU6SfzC88tPlb+KFZhpc
	 TVRkN3Iro0wdygsnIzsaa1QD73TmGphU8LAzOZspEZMg5alv0h65Y8VB2F7VY4cRIPrq1
	 bumz+gOsI/WYYDjgrt+MMrJB+XsEpEgq4zb0m8cFxl2PRe0kEAagYnFrsYV1WOxWYYztf
	 4+99nHWsm2IKhrQRI+XL9gK+fT5YdV0EHx/uV0YLAgttteHjrC7ajNeq4Wj9jHZIiAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795014796;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer;
	bh=RMVcoG7RRC5e+6Od8G0B0oNhz3JqDhu+jU7/dRmM0d0=;
	b=EKoyzdJ8vEAGrSe/5U8rHsihqF1PwD+XjGdpIUrxSIgpFP6KnoBXD16ACggxP5kfZkTM
	 SPYIo64vTFcetoYn+pT7a3RufxMx5fMjDUdDrByodoUv/VUVjaw+4IFPuqUdSnKYM6YIO
	 JkhBCk7qWlQBsol/fhcbjt4d7URlUhnC6ZheMMRkLFbv8OwD2kypp6LynELMIOGgFtm1+
	 tP//cNetxb385NtWfW1cDKvhPGa/Fz43d/+J1JwwqPhuLBxHkyHhmqjDCI/1v4W1G1bMY
	 IwWn0YNsLUZkXBP5xLHounvYqjNvD2fT+aYMHudKYo+XRnfWeioiqPXagLNmNM58YAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=EaNntw86;
	arc=none smtp.remote-ip=209.85.219.50
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06ED6606A32A
	for <linux-serial@vger.kernel.org>; Wed, 18 Nov 2026 15:13:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 06ED6606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=EaNntw86
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-9211efaca89so4539686d6.3
        for <linux-serial@vger.kernel.org>; Wed, 18 Nov 2026 07:13:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1795014795; x=1795619595; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=RMVcoG7RRC5e+6Od8G0B0oNhz3JqDhu+jU7/dRmM0d0=;
        b=EaNntw86OliWenC+AEw8YZaqX/CpkEbuj/R83uxmt0euRu7q4F2m0octKXwFVihjk8
         dg9+4SMbEuteeVIYXzzmNfX/GhJAD2I5TAVlrjYtVKgH9HZf3H9sOEWDi6erVJGPVQR2
         MOUDAtFaOSguVvmB6Aeyd+dyvpdoItqLgrfZkjmHPTZWLIi47UtkzxoGuplmxuiUXO0v
         tyGF3tjz3s4yV7eQvQapqnqBjZtdFZe/FW+VRXsn3qhQN1hGCbekIeZCld143MCK2+pP
         fZ/U2FUvwPZemSkqE/IxMsmjkki3bWHrx43vsMaI4rDk0WQbZdG7s4De/itz35E+w/xw
         0AgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795014795; x=1795619595;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RMVcoG7RRC5e+6Od8G0B0oNhz3JqDhu+jU7/dRmM0d0=;
        b=1fgd9XZSkFE5a7mJuvZlfpf5+AwHZq6z7A4T4wiaw75Mtda/kTdbiN8fHCm8jrnjP6
         F94X+aBmaY7CO+dZ3vQjcsMOyjNr8p6kCxBCdJjTKag/1sJz21xKzxg1AYwpTD+2GZAc
         Fdr9O1TXMc8hOs6WAJReuElHRiNr9IHXC8cBjSYfT8gQ0hPDxiXb8YVBmThxpWpR0Ed+
         LPQezXBs80BgCpVOL2C5UNIFfdP53E5PbL3S6ARBsFRQpp37GGyV6I2qGxmgiDBTO3HZ
         ZDq/bh99WX4k0xGj39EC70RmMSZyBdqZyMKG+0AZwjkDTxNzez3f5275hGupN/01Hp8R
         g5ug==
X-Forwarded-Encrypted: i=1; AL+hErHxPW5WvYuY18RYUEzoVqHCvjOLXepkc6YpndUg/tLOarkcFMa3PUiI4VNoNYCUaWElszLHFodhhN6qr8U=@vger.kernel.org
X-Gm-Message-State: APuU4Z95z2txVglTZa+LoCGx+pgJTWMrFHYNF0+8JYcAbcLw+BKRpJLx
	2GkDWBKcncIodR32gUL9wGgAEeeEcTvuElYiqDAi/vetSRk2RcWtSdcocFmvj7+fNBk=
X-Gm-Gg: AYBFou2HpnQbPMMuJR/8Hn+h60gWGrt1XpydsZ6pQyiuFrEToQOUYkjuVok7nf3bGXa
	oPs/CHTU1zbEA/k22aRK5iu4Flaws8CeGoahyTE8TP9m9Xk0vXWVRIzbdyxvH2F80Wa0/1ZWyqE
	3C7xhhCl19QR6CcuE4/pJ/saK8X+NvhLq8tnMolnF59OO9LU8N8NE/uwzxSvc6uBAYj8tiOw/6y
	rKcm0JAPHwCG+2yZ2rfsnbTUfwgnDL+AL9AyJhs8QkETeA46areW6GyK2RqPspMjF+kvHMkU4Ti
	Q2TEPBhXsDMNLsVg2ff+spRKnftVX54haBxN3QFFrUe36/Yq3kty/YQDm7voKKCTseDqgxeJy5T
	A8DpjXYsOSl3pgs3T+zjMrhZNwUUGK1R+++PjP+GrtT9nMYbWxKke4XN67xL1Dh/CRdjGKHODMb
	EE2/41CeEeCExN44tGlS54OPSQ730H253ZKD/QkHn24xNdYsa+s/bTbagozgtJ9XH1g9SLt2Tq2
	PWMJk2wTAanrOB4znVa6xy6sm9uWJOnfITRVPESfsu7yMFFTlRYU+qAEoT+1hclUhVuQWRg5RJm
	2UZkkovseAQCgtu92VqNz2+fu0fh+8RGG125z1Bwf85WWdBE7VwGYt+dodHHwp4xXyyacl0fzx2
	CnjB1S04=
X-Received: by 2002:a05:620a:444b:b0:949:6d95:f63a with SMTP id af79cd13be357-94999810096mr508584985a.78.1795014794676;
        Wed, 18 Nov 2026 07:13:14 -0800 (PST)
Received: from [192.168.50.231] (pool-71-191-145-202.washdc.fios.verizon.net. [71.191.145.202])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-92114d70a8fsm23976506d6.30.2026.11.18.07.13.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 07:13:14 -0800 (PST)
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
Subject: Re: [PATCH 00/22] mm: introduce N_MEMORY_COMMON
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
In-Reply-To: <av1DvCQd_OvkGgLU@MWDK4CY14F>
References: <20261114070959.3490008-1-gourry@gourry.net>
 <av1DvCQd_OvkGgLU@MWDK4CY14F>
Date: Wed, 18 Nov 2026 10:13:12 -0500
Message-Id: <179501479267.1206716.268867271510310543.b4-reply@b4>
X-Mailer: b4 0.17-dev

On 2026-11-18 15:01 +0800, Richard Cheng wrote:
> Hi Gregory,
> 
> I've browsed through the serie, I'll go into detail in each patch
> in the following days, for now I have one general question.
>

Thank you for the read and the feedback!

> I wonder how the "common memory only" rule is enforced ?
> 
> As far as I read it, there're 2 ways:
> 1. The zonelist, you build them from N_MEMORY_COMMON, so non-common
>    node isn't in any zonelist.
> 2. A check at the call site, e.g. node_state(nid, N_MEMORY_COMMON) or
>    folio_is_common_memory()
> 

Those are essentially the two cases, which are already present in the
code in one shape or another in the existing shape:

   node_state(nid, N_MEMORY);
        or
   folio_is_zone_device(folio)

With the exception of one or two places, the series largely modifies
these locations to use N_MEMORY_COMMON instead (or in addition, in the
case of zone device).  There are a few places we add common checks where
zone device checks were not already present (because they were missing
or did not apply, usually PMD scenarios).

> 
> Code reaches a node's memory in 3 ways: zonelist, node id, or by folio.
> I couldn't find a statement of which mechanism is responsible for which
> kind of path.
>

Being a bit more precise: How do we reach a node's folios/pages?

 1) through some kernel structure, obvious examples:
    - page tables
    - VMAs / pagemaps / xarrays
    - LRUs

 2) pfn walks
    - memory hot-unplug
    - contiguous allocation
    - DAMON

 3) page allocator
    - freelists (page allocator)
    Sort of its own category since you ask it for folios from a node

> I see some consistent issues,
> 1. zonelist paths are covered by way number 1. Some of them also carry
>    way number 2, some don't
> 2. node id and folio paths can only be covered by way number 2. Some entry
>    points have the check, and some do not.
> 
> I can't tell when a call site has no check is deliberate or missed.
> This matters once non-common node gets its own zonelist, as patch 4 metioned I think?
>
> Could you clarify the rule ? e.g. which zonelist users must filter on N_MEMORY_COMMON
> themselves? and why the zonelist alone is not enough for them ?

Some of this is obfuscated by the fact that the existing code already
does this filtering for you.

I suppose I have some premature changes to add additional filtering
where it isn't needed yet to reduce the complexity of later patches,
but I can see why this is confusing when introduced by itself.

Consider this:

-       for_each_zone_zonelist_nodemask(zone, z, zonelist,
-                                       gfp_zone(gfp_mask), nodemask) {
+       for_each_zone_node_state(zone, z, zonelist, gfp_zone(gfp_mask),
+                                nodemask, N_MEMORY_COMMON) {

This is a bit of a preparatory change to later convert this to:

+       for_each_zone_node_state(zone, z, zonelist, gfp_zone(gfp_mask),
+                                nodemask, N_MEMORY_RECLAIM) {

It looks like we're filtering by N_MEMORY_COMMON, but we're actually
iterating the fallback zonelist (constructed from N_MEMORY_COMMON)

  struct zonelist *zonelist = node_zonelist(numa_node_id(), sc.gfp_mask);

Later we update this node_zonelist() call to determine whether the
private nodelist should be walked, at which point you do have to filter
for service support.

> Whether every path that takes a node id or a folio must check N_MEMORY_COMMON, and
> which ones are left for the feature bits in phase 3 ?
> 
> Let's get the rule settled down and make it as the foundation as well as phase 2 and
> phase 3 ?

So:
  1) If you're walking the normal zonelists, you're already filtered

  2) If you're walking nodelists, you need to filter on N_MEMORY_COMMON

  3) If you're operating on folios, you need to check common_memory()

  4) If you're walking the private zonelist, filter on N_MEMORY_COMMON


So let me do this:
  1) i'll restructure this phase to omit premature changes like above
     (they'll move into N_MEMORY_PRIVATE and N_MEMORY_<FEATURE> commits).

  2) I'll restructure N_MEMORY_COMMON commits here to handle cases 1-3
     above in that order, and that'll hopefully clear up the confusion.

-- 
~Gregory

