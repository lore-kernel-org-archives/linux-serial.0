Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795017377;
	b=IDKLT2dMFoMIFGteoLxqj+qbzWY6Uy1sNRxsPfz9Ugfg91sMnDWPvnscQd/0gmWxrPhJ
	 7beJH8gEXxNsq3uLuVpv5QKX/phm5rxT2BctVeSbBc7tEpRKW6NM5r0DyZXVgctHKfN6r
	 VbrErKBo1qSdaNQPRaoQ2/bCGbE19WPEi0mxjYHJo+VdcsfUxFz2qwKJoL+B5FywO1UH3
	 fwVRtRJ+8wWvEVZfFvFgsZhCYTH9FQdtfdQXH5ZzEOzSH6SG6F06qfuKfpwFzRWFA7cKz
	 W77xlBgYgUlkXzD/CG57fEg5O4pgp03U/pETCag7J/vL4VWdWiNgQK2MCpQiugKBk+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795017377;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer;
	bh=3bQBfuPo4+GA4H58G8tofWZlnWMcm4hxNRzjXZBoZg0=;
	b=qxg3Ni2fnvGkP5Uvd10v+uMIG8muYY1wepCcz6hgY/BWT+KHfi7+eXW+Zlg/dGPP13jo
	 BjGAU3Os/yXJOrN5q0scI4/kArnqD5CHNUkTBaJOtXC9ymJCqb57K7kfe1C2i6M2yAYum
	 o9iIIzWZvLpddyzNeWI7E1AoWbA0JkFXJGpmZeMQIo6WwqNkhAXlVbb6rKsvS3PNgKS5x
	 yn6yg+gXEborvC7FXRmr/DjuHjKR4kfQ1V1PSpMmClQ1+bbTFvrOlNsVgvd8Z3s4g2U7h
	 ANZvdFPcAMYhP4mHDd//LHwE4V338OImZRpwov6H4vs5c/Rp+hWiSHOfULa7STH3XnA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=gFIxxdDt;
	arc=none smtp.remote-ip=209.85.219.52
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCBFA606A330
	for <linux-serial@vger.kernel.org>; Wed, 18 Nov 2026 15:56:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DCBFA606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=gFIxxdDt
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-91ec2d42231so6066196d6.2
        for <linux-serial@vger.kernel.org>; Wed, 18 Nov 2026 07:56:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1795017376; x=1795622176; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=3bQBfuPo4+GA4H58G8tofWZlnWMcm4hxNRzjXZBoZg0=;
        b=gFIxxdDtcqDrBFkqgwEzkN+bVHfcVbrm/mKFYHBw/aX+aK3i6yXT3iOHNNcy/dVpjR
         beX1ypC799ntnSOEXoyuWI9KAiYigmUzM2ktWAUGq14UH6bdfs19Po3EeuhNmuPBICwQ
         4fygV7vNlH+8kA4gHVrwCXXCMRXtK3og0Bhew+zJDF8jtO9O5fvmBFacfYtyQB0ZICfH
         uto7MDRpcWiyf9+vJZQn3ZyabRKAjiAEnbjmVD+LqH03jEVrnsuMJqNm4PPeRi2PD0kM
         0m9hgfLivrz1Z3dH1OiBWSOIUeexNiv0u7ws6tg5Gw4PB2Xal1+xCiI4FGHOyO/4c+dY
         QURw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795017376; x=1795622176;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3bQBfuPo4+GA4H58G8tofWZlnWMcm4hxNRzjXZBoZg0=;
        b=tdkGX6E82DvejPwt0U6d5DDsVxEsjFc/zyMpngUq08UqhMbVU9eLU/xW79tcaCJrdj
         sU34jmlyb2+/504lMOhPIqd018wHchQV50HCp08fOuPpTG/DC4v706MdYpREssM0aoTa
         eiFSA0bTAP/dfv+OTVtK8HB6XiAMcmc3S2zbPu1aKU1e+/IJ60klgS2gTw4TuQUAv6Jq
         RaRaF5zQVaB59WOoQHBn+SFbL8hkBO2EdTjifHmaqGcd5g4JH8BIYknd/EbfN3CZRiK+
         1zplpPgZeqqcQsh82Yad28wwNEznq7vt1ojYwj1hZoCoyfuMscOBi5hC3mnm3yiC35R2
         nVzg==
X-Forwarded-Encrypted: i=1; AL+hErFukVvcsVPKB9IYYh2Be3UCmcCZ2HtCagVfuZhrd5xYqZZZSYX5USfgmI/kyrnyCMWVIfcmPzdjxDJ95M0=@vger.kernel.org
X-Gm-Message-State: APuU4Z92s0sRmqDtv9a7Lxx0FHbmfJBOrWho1Db1sRyE9d6cu5PxUvXh
	h9MhQ8DszJHTZmY9fixAQIUAnGuekzFoEa1YO2HjhUtTrp5NrhuCqsV1dpYyt4KWq/8=
X-Gm-Gg: AZFdTZepkSbfdtBfaljAL5QvhI3Rl+jvEHuRNA1/qe0AabUaMfopILm/TVfLpHGZWLW
	6xNGHYYANKt0CvW4fQewpz7pZjS7lgojg8OfBFEXenYlrHzdCJ7xLH9vn6khsV1HZHESKyhK61b
	5jVMrbI1tHrtIZjaw8vwM6/HXewkLRcdRazXJU30SiPGe49JwG3ORKw2KLpIDuN/Koppnd+HLUL
	xURCqJbuREU234LEDOMgXBUATzQiK5NqE054roHVIfXb6XkslOeMG1gbS0fQE+CO/Ex8jYJHvfm
	tZV1mZscpULkakUiP8kTqf0IgMlZuIrr7ZdH7rhWWqpfhJdXBsuzavgAsDobnjfa7EEzLC6DlgU
	Ty100p5KdszLnlJCZi/ZbNN4YXGVfPH0cYcqBS1sh1cykTEAxCooXjcmVabMv7gETyySENQKoYC
	ulMgjCYabMXm3+Z+WV7wHsXlcvAdwb2bfW7/AjxZqgs4bP+myTbNiD6ImbfwyDODhp6i/tSpUSU
	vOLzdBHOt1snykjE1VLJshTxnqAhtp8h6dlnSeTibgan1Ys+cGZ3Kf2UGvYzhnQdjGqqfmGeaE7
	nFZZcAWE6/gvwP1ry3l1N51BDGwA62JEYnERHepf7HZ7my32sGiuteqbGwdeEe1M370B/dZZv26
	lRqEl0+tLKsOGMGB+NNUL9oQx/7FT
X-Received: by 2002:a05:6214:8013:b0:921:1890:b77f with SMTP id 6a1803df08f44-9211890b87emr29798426d6.47.1795017375668;
        Wed, 18 Nov 2026 07:56:15 -0800 (PST)
Received: from [192.168.50.231] (pool-71-191-145-202.washdc.fios.verizon.net. [71.191.145.202])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-92114d28215sm24719106d6.16.2026.11.18.07.56.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 07:56:15 -0800 (PST)
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
Subject: Re: [PATCH 05/22] mm/mempolicy: keep interleave and tmpfs mount
 policies on common memory
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
In-Reply-To: <av3EGWuHX2JDdlrx@MWDK4CY14F>
References: <20261114070959.3490008-1-gourry@gourry.net>
 <20261114070959.3490008-6-gourry@gourry.net> <av3EGWuHX2JDdlrx@MWDK4CY14F>
Date: Wed, 18 Nov 2026 10:56:13 -0500
Message-Id: <179501737390.1206716.11014097946405277594.b4-reply@b4>
X-Mailer: b4 0.17-dev

On 2026-11-18 23:30 +0800, Richard Cheng wrote:
> On Sat, Nov 14, 2026 at 02:09:42AM +0800, Gregory Price (Meta) wrote:
> > -	for_each_online_node(nid) {
> > -		if (!node_state(nid, N_MEMORY))
> > -			continue;
> > -
> > +	for_each_node_state(nid, N_MEMORY_COMMON) {
> 
> Maybe I overlooked or somehow, but when do we have the assumption
> that common memory is definitely onlined ?
> 

For this particular case it's not particularly relevant.

This code only runs at init time, so it's either got memory or it
doesn't.  If the memory is present but offline, it still wants weights.

There isn't really a bug here, but the existing code could also just
check N_MEMORY and end up with the same result.  If the memory is
hotplugged later, it still gets weights accordingly.

-- 
~Gregory

