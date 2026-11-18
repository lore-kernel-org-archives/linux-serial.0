Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795015080;
	b=z5V2C6BB9QTJLlxLEFnB978uvszNmn4KZafq4Sp9waCWQIuDYb4ad7gtsHlbG4eUXgVc
	 Qqts5V1rhER48hNSSEqHsQ/TjTkJqvtfMy6l4PvHh3+tDpembZyB8b5v6Rx3Zv9YpFBcg
	 y1ngKyBT4SCVigTXZGCJ+cHeDrOplzAr2NcqKluKfqs4VW7mlh7Y3aQNOD6mpsYDHKr0Y
	 Q3mjfFZ9oyeEGwLAPzbabdAE9g9SVOunh9MGRjdfqqmNBRUGt0LTO92fzAzjkBgnSCuPW
	 eG2eNi9sClURKpqNdrWjlWeQ+sGZCaEjsVUv69hRZD9yGxRJMA4VfeJ8ypkan0+1+uQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795015080;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer;
	bh=NayqA+2VU8BL3bQ4QlYOm2bPtjimdoFBif/UfurJ/Ic=;
	b=xsN3CHuyoZ1z6oNTXGmWcsHnSTDaQTj1zQbWKJq744Gwd7ysbbOOqBaA2qeOz5yaRK2O
	 17PMcBFimgXuB4tzySLvEz/2jMn/NrifAKIw0cAMQkJAqcp+yn/iF4sLI2OLKloMCXXQr
	 6LElAdMtekX2vsyHWUKbqJcnhj7OOCCbOG0QFK+jlPe9cJ4dZ39QBD4eoQgVb09QkIXH5
	 RON5hjf9q4D9H3Ll68v/D1KjImnyr05i5vp5PlWQOY5PNpPcc+js5cdCmc/k493vdC0fd
	 1wQGFwXXOfTYdCFtXrlAsQqzI1zPpQOkWBYjpm4tYzg5g/KefDH6wmj3A6r1HGP3mZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=e4KQUABj;
	arc=none smtp.remote-ip=209.85.219.49
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4792B606A325
	for <linux-serial@vger.kernel.org>; Wed, 18 Nov 2026 15:18:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4792B606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=e4KQUABj
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-91eb3fea2a9so9480046d6.3
        for <linux-serial@vger.kernel.org>; Wed, 18 Nov 2026 07:18:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1795015079; x=1795619879; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=NayqA+2VU8BL3bQ4QlYOm2bPtjimdoFBif/UfurJ/Ic=;
        b=e4KQUABj7gEeUxSS/9AWkxdW17UGKfzuGQLoVBznmZ3Gt2tw44MXP7MS7fuK4a6Xch
         0yyAXWnxxjkzZiP8jzIwtt8wLQB5Qssy9Gb6kZK/rHIv3jESaumWf1ihxu4gqfy3WHhI
         oFqLxTx/jKx8gn2+JTWAhEQk7YXH4RcTH2yez5MsQAFrIf799A5J/GHOpS52hUYhDizF
         brNl3q2lSv7Y6eahBplN+1C7QJXZuPwNsoam+lFO8Uv4TSMXFVNwxTf74WshGCQjFYLx
         AQVaoBNexrSRe/cQbkOsywEWMHGfpBC1GgvoSO70//W1ftEDbFrlxKA7Po9FCE5MnZw0
         zQmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795015079; x=1795619879;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NayqA+2VU8BL3bQ4QlYOm2bPtjimdoFBif/UfurJ/Ic=;
        b=wZBz5g//z4JKK0DG/ty66S3d7R3B7x6ZEgFnbOPCWxkNEYWbUC1hlNQJa8l0epivHI
         4bgDni6+XAfIzwa4bOzgtXyxcoZsAkbNXfhTkFfKhBNcD5DxsGnDZOVi2RXOeecQ2/vG
         qyjaEvD+arGnugLh9Lyuqpo94JjC/fX2oJdZk34TeUBVNON63L8YgfvXIYa9OLgWlio3
         WtTYW1BZ9GpjAyKd76/l5EQc9ZcmnB8b0FdmuDFeDZ1pHvs4IWjya3xawbezvo8+eEdK
         egfzNDdXTykbsX+VByWOTT86lhJHNNdyZVErxC3/vMvo5XDPlfbUR+TIy0+1YX1MnC88
         s9Jg==
X-Forwarded-Encrypted: i=1; AL+hErFgGuhLCJlSETD7ITDZs/06SDWpSVenp2lOkzhHBRmzJXcwerRnah2Xy4ZEE9aFW8BLx3GOyFJ96PY4eMg=@vger.kernel.org
X-Gm-Message-State: APuU4Z9H70I6C1PmoZLAqGQNjk+TdhQ+RqNz+ZD1GFO2AviSAKnX0es3
	ZWdeYZTxaqYxsMasnombCYRVolbqHoHy7rYyhplQ9UITbFvm+qOeF2Y8dMUEICRklRo=
X-Gm-Gg: AZFdTZd7XAOnNniWFoQrp6VLhzlSIj8Pn5HDsVJlzjgrcEMFFdGbjU6PVySppSVA7Im
	1sp2JIHcWG3QNWO9k4PgIaON+I2Vl53Coxv/9adNcXkMxW+Y66r/lnZYMtJEn2A5Z0gojdpbbiv
	QHCfScHJrX9og+ywMis8RAB2tEjMYWiw7yk2+S/kxKzHWMdDxg1Cm+8Pk//oFA2zO/GCjQm/H+y
	sw0V681pWcL3YvFQ2r3ejOsJmjAI9kB7L89hwjwc7/Yh5kNbv1lMB+gUSkottsYudW3NnqyC/I3
	znJqwO9En2alJ21Yc4TWvyuAcux5CKKFtNrJlAkooHtWsWuXDhy6457Qsj6670RDXgj+Cqu3l5P
	yeoK/6MqRS/IfF4hMuL9dgc6EqlC1jVxA3eeSzN7eK7TOptiQ2lhzkmWaZ5+FCiLPriJuAtlTYp
	cwDz/sKDcLUnHn6+KlNugVrrswi7Q8WKhZsLBYPls7i2YcoIZ7ytcw+z8sVy4M05Pcqzp3/IhvR
	zJVQrYNBB1wfJseUfDi+DgT9jRfI2+2fxyNdqxJoesZ1ZDGOAzM6sFxzMgHyzdroLfVcKtJi+NQ
	CvfyX55wzhzK3NFwMpuoZPjNCws6JsTpPOTUoFR+lRSoEZc5QriTgLZwlGvHZw75ovLnm7D3xAG
	LAsi+m8noGrX6LZLKtNUEHNjjuYp9
X-Received: by 2002:a05:6214:5d88:b0:91f:2222:b498 with SMTP id 6a1803df08f44-92114f8f66fmr40206726d6.27.1795015079071;
        Wed, 18 Nov 2026 07:17:59 -0800 (PST)
Received: from [192.168.50.231] (pool-71-191-145-202.washdc.fios.verizon.net. [71.191.145.202])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-92114d35dabsm23793796d6.17.2026.11.18.07.17.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 07:17:58 -0800 (PST)
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
Subject: Re: [PATCH 01/22] mm: add node-state-filtered zone and node
 iterators
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
In-Reply-To: <av1hKrtcATVjCnCM@MWDK4CY14F>
References: <20261114070959.3490008-1-gourry@gourry.net>
 <20261114070959.3490008-2-gourry@gourry.net> <av1hKrtcATVjCnCM@MWDK4CY14F>
Date: Wed, 18 Nov 2026 10:17:57 -0500
Message-Id: <179501507729.1206716.6880334614636468959.b4-reply@b4>
X-Mailer: b4 0.17-dev

On 2026-11-18 16:29 +0800, Richard Cheng wrote:
> On Sat, Nov 14, 2026 at 02:09:38AM +0800, Gregory Price (Meta) wrote:
> > +/**
> > + * for_each_zone_node_state - iterate zones in intersect(nodemask, node_state(state))
> > + * @zone: The current zone in the iterator
> > + * @z: The current pointer within zonelist->_zonerefs being iterated
> > + * @zlist: The zonelist being iterated
> > + * @highidx: The zone index of the highest zone to return
> > + * @nodemask: Nodemask allowed by the allocator
> > + * @state: The node state the zone's node must be in
> > + *
> > + * The state filter is part of the iteration rather than a trailing if, so that
> > + * this expands to a single for statement: a macro ending in an unbraced if
> > + * silently steals a following else from the caller.
> > + */
> > +#define for_each_zone_node_state(zone, z, zlist, highidx, nodemask, state)	\
> > +	for (z = first_zones_zonelist_state(zlist, highidx, nodemask, state),	\
> > +		zone = zonelist_zone(z);					\
> > +		zone;								\
> > +		z = next_zones_zonelist_state(++z, highidx, nodemask, state),	\
> > +		zone = zonelist_zone(z))
> > +
> 
> A question on consistency. This one is a single for statement, with 2 new helper functions.
> for_each_populated_zone_state() in the same patch uses "if (!cond) ; else" form instead.
> 
> Both forms keep a caller's else correct. The only difference I can find is that the if/else
> form give a -Wdangling-else warning when the loop is the unbraced body of an if.
> 
> Is that the reason for the 2 helper function here? If the warning doesn't matter, this could
> use the same short form and drop the 2 functions. If it does matter, should
> for_each_populated_zone_state() be a single statement too ?
> 

Yeah I was getting that warning from various checks. I'd convinced
byself this was a false-positive, but it does look very funky indeed.

Let me look into this again, it's possible I can massage this better to
use the short form still.  It's also possible that I should just use a
different shape entirely than trying to use the existing pattern.

-- 
~Gregory

