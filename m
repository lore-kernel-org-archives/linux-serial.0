Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795015260;
	b=xQj8jk32l1MfLVTiGP3lAecNNHekpuxp88E18IQR5EyzBkhhg73v44XfZ8PQhaIwO89V
	 i46oVfDWLMKJoj5T2Q10FRWqMh8vV45NlxhHo6EZ7elFbuDtd2tsOVzrGAAFB0L5HEKp2
	 U0kGuCVdTAUM4nf/8kBzohuDNcG/2KEUKIs00jo45cAYpvq6picJTeDubFu4bswDQMyvR
	 FnDmYJlYU+YV8h/92WPa1eBUD9ki7rInuzW0Mpdn3cdYtlGPsV0WJb2My2YlS/hmM9tAd
	 7pGi3fzmM1hH3JB9GkVUIT3Rx9ExYxwcauMnDedZP+Vtn4sMvduKdVibDgumaaufp/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795015260;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer;
	bh=2f1/3qPELFtVfaXBFluo86ffYBKVD1HppO+tx/i4yJA=;
	b=DNBYQvrTkTdSd4YxjS2Wy6B+ogwFvdNoUO2piuKh0KrMRfz1H9xdzThQtJvimp+y0cx7
	 DJXHMZBzO8U/LstvAxCMy/hUWAeKVPLxgsKkww/nOhn7NR6IW0VmIA4yky6dS54WcV9GK
	 UTWMN7o6LX9ZDMyyYQgqsuMRisWnys7tp3UhgrpA9Qw+5peCgwsb5yvV/l+niriqBxXvl
	 RvoCn60qzV0ll+o4MP5GYpNoidyhVZIP93dLcPlp9DlNpxuR+2PSRtX2rcz/xx5gESH5V
	 TaZuD6ngSXOQupdHA+t+83lVkX9YbfKiUmP/y+vpRcarYKi6qm+DA61KFlq17DuMEqQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=RcYjlh9r;
	arc=none smtp.remote-ip=209.85.160.174
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9DBA606A33F
	for <linux-serial@vger.kernel.org>; Wed, 18 Nov 2026 15:20:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C9DBA606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=RcYjlh9r
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-55d30c054dfso11803851cf.0
        for <linux-serial@vger.kernel.org>; Wed, 18 Nov 2026 07:20:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1795015259; x=1795620059; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=2f1/3qPELFtVfaXBFluo86ffYBKVD1HppO+tx/i4yJA=;
        b=RcYjlh9r4IRGrafd+j2HLcUekeO369jG4cJ8dDVzoBY8gvpxzJeyqK3ozNZlwuaNe+
         dX9eTN+iN1SLvDXv6ZqfqHOE77V1vdoVQpS9x5MRrqE0S7mvRfL6sw/ErTChduS84etH
         nS7jQ1GGdAXlIAaPdld5HxgPrnOoIx1uTeL6PFILkkDVhQvjQ1L/cdSpt//oQ3Sg56BU
         7DACo0lblGCgiebYjG3dsltULlbJRKP6YYtH3AIXL4Ytr8g/kCuFnCukKTYSpuqs6WLs
         H7LrxeAzRj7uQcJe5AdxVin1iIq0eKGTVLMXmX4R0D0sv+hVEZxbt0IeTxFEciavpACF
         rBBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795015259; x=1795620059;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2f1/3qPELFtVfaXBFluo86ffYBKVD1HppO+tx/i4yJA=;
        b=quzA53k6Q3cJ0T26mOIGtwvKZ+nYR6zPdRAE4cbNhRCf1YS/De85tKDnTvfGUGgC5R
         p24yVqfrZ1nLekSKDilxR8hnIoHrVSnPTGJaS2R6BGq9TnRm7mopt+Ic18cLoxf0DgXC
         j2ZqDzDJmDsG5D/3tyUNJFPcCbM2jONPhGeWAY1KVLoRPhLCcdL8Wn+UqHWyqwSa4xYS
         TnMAJTpVJ+/9sDu3qkQrP352KM8WNlCh1eke1kh4z+hrwTKVsXslF4+Kr3R9SQmcceBq
         bKzgjeojqtIF1CBEI8Z5tn1SpwxJ2xd6o7Et3LobjGpEEcSWvWIZE3qhhczwnPt+5F38
         4XRQ==
X-Forwarded-Encrypted: i=1; AL+hErGLy6O3iFfrev49W2E41RpTFWB6a4MM7TXrs4p+l2JpeIdMjlB/nqOo0rr0VuyVdT/iEvNkD42GJvm+ngg=@vger.kernel.org
X-Gm-Message-State: APuU4Z8o+9Gb6Wm0E62EnaXezgBaICT6GB3NqbVAYUvoc3WbY/0x9Wc6
	WjkqRcm47zM+HbRdngFuXJKug+cOEqS3doAaQIF0quh99JVIQsk7uJOkSKueNaIdwck=
X-Gm-Gg: AYBFou1b4kCObCiSYBt5IaYJ6xvBk8HrxrbOKXgAlTThbM2Ww+/kdPU1eAa8h3O4hcN
	X2eb2CWTJIlCb24vcG+A0mwgNgQS8oLYNLEyfZBO9zaWKGYQpRloPyeJ6PJvpx5mm9aO6+26PkU
	r3Vzz91BR3I8L3a9nXVpsP++mEgkX8pLo6SVEbxLZt9HYsv6cquVvBW+vanEzchNAcsFLaFdLgR
	X5I+9a/7TthyuPvgl9Brf/S/Jm7sZ5g2rUenh8JUYX4FM0PKp8TBTHanpKTdKHEEqTSrKkqFaPn
	kI6j6/cRVG9ynw13eRyGIZ3XC+ubXwFsTD3e7/NXrnBDOSi2wyL8j9ay4y90fuP6Er84TJ0ivp9
	OXCUMdhUWxXQFEcMktczShCkN+y8QAbCnY8vaQGlFjlPcUpYlXQqHGIrCTkvKDpktrpTalh69U1
	8GrP9nXYnTp/WKANKGvjt7Gi8shv8x+syf7/O9NycljnxdcGp2Zb1q1BWjT+xlNkpR2xOcX9kkO
	alj/hPI88oEQwjGj66pWnp0sIx+TX8ZU75u4KK+rGnYXGW5W4UicevApVf1a+/IbPcnV8J2mQuj
	i8WbeUB3jf4mItQsIBH8U1LIjBC07vTteIcdEOky1wdM260EdeLgyAYGP8tbqPl6VCucfvVWP69
	fI9AfGAk=
X-Received: by 2002:a05:622a:a0a:b0:55c:66f0:5bf0 with SMTP id d75a77b69052e-55d5a656766mr42047121cf.39.1795015258621;
        Wed, 18 Nov 2026 07:20:58 -0800 (PST)
Received: from [192.168.50.231] (pool-71-191-145-202.washdc.fios.verizon.net. [71.191.145.202])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-921167f4725sm19632976d6.44.2026.11.18.07.20.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 07:20:58 -0800 (PST)
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
Subject: Re: [PATCH 02/22] mm: publish and clear node memory states via
 helpers
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
In-Reply-To: <av1ZBTpLpJC6DJqA@MWDK4CY14F>
References: <20261114070959.3490008-1-gourry@gourry.net>
 <20261114070959.3490008-3-gourry@gourry.net> <av1ZBTpLpJC6DJqA@MWDK4CY14F>
Date: Wed, 18 Nov 2026 10:20:56 -0500
Message-Id: <179501525661.1206716.17622543796948053737.b4-reply@b4>
X-Mailer: b4 0.17-dev

On 2026-11-18 15:53 +0800, Richard Cheng wrote:
> >  	/*
> > -	 * Check whether we are adding normal memory to the node for the first
> > -	 * time.
> > +	 * Publish this node's memory states, including any newly-normal zone.
> > +	 * Hotplug never adds highmem.
> >  	 */
> > -	if (!node_state(nid, N_NORMAL_MEMORY) && zone_idx(zone) <= ZONE_NORMAL)
> > -		node_set_state(nid, N_NORMAL_MEMORY);
> > +	node_set_memory_state(nid, false, zone_idx(zone) <= ZONE_NORMAL);
> > 
> 
> Um, so I am not sure how much cache pressure this will add, I assume it's small ?
> 
> Just want to point out that the old code only wrote these bits for a node's first
> memory. THis now does up to 3 set_bit() calls on node_states[] for every onlined block.
> The result is the same, but node_states[] is __read_mostly. A test-before-set in the helper
> would keep the old behavior, or if you would like to keep it, please address in commit message.
>

Hotplug isn't on a particular hot path, but I can test N_MEMORY before
setting any new state and just early-out.  That would keep the behavior.

-- 
~Gregory

