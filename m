Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A623369D66;
	Thu,  1 Oct 2026 01:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790818107; cv=none; b=rjfZpaCeM2qBChzesJquchLAOsCFvFVVGf221/RuMGlWdxrnux6niLaxy7VHnY70HAL2Sok3tiyBl5K+PB+pQmdsRVX3zJLtYR4F4cETaJNUATDXFGGcgXR6Q0A6yGB78Lr1TFJhVOtlshHefZvuG+WZYjg+E/GlNA81Lu/dopE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790818107; c=relaxed/simple;
	bh=PwytU/dVzVM9s0Qg7/y9BJbYK6HdCn/8KePiB9yRVEE=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=IfyGwRcf00DCKiYY504SfzWDqNYqfKu1sru22NFXF7QMHqPEYPxwPZ+4ZTEyCXthCw/cpCK245fhJK90GzOg330P1ot0C8Mrvbg7HGC1i5RkMubNClhCvZimd9HJ+8O2hDmrEIKImEfHUjbku9w5gej2G6obh97S+nBt2YWltW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=flapping.org; spf=pass smtp.mailfrom=flapping.org; dkim=pass (2048-bit key) header.d=flapping.org header.i=@flapping.org header.b=UmEpdnl5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=w41XzJaA; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=flapping.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flapping.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flapping.org header.i=@flapping.org header.b="UmEpdnl5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="w41XzJaA"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 6E4F1EC025C;
	Wed, 30 Sep 2026 21:28:23 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Wed, 30 Sep 2026 21:28:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flapping.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1790818103;
	 x=1790904503; bh=UT56w3PIRE9yuJH2SaE7ltM9Finw8rDPpQ/vd+suDLs=; b=
	UmEpdnl5hsWZ2GtZsgMDnfe2vCu4ERvIjXmtcsS6whiNE+OPm9+hFSOUeaGkqjJf
	KgBP5KJPy6lWKrMWd9pGPHq+4hp5KyMyyGP//kGE8Fvl0hTUw/t4ksoJKXPyOtdU
	X7PBKCLMG3dBXUGj15EBGasaiWHURFVzKuYDvtEEXBmNgn7RBbmMamKE4WwyrlK6
	/G4T3nDr/pL1sD06Tf/C3L6PwpKjKGKyH7VB89e2ujjmtHQYHVHgmy6xbupIKycR
	EvCBJzA8F9m2xBVUdLJkDU/75w1O6YOxSLXE64850RCltcHumaPhDEnBHTb2Ud4A
	ecMcgNUwBE+/0Yy/ve6RYQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790818103; x=
	1790904503; bh=UT56w3PIRE9yuJH2SaE7ltM9Finw8rDPpQ/vd+suDLs=; b=w
	41XzJaAj3axWRNIdNn1cv79jZi0CpNIo0uPiKGhUGEytX5kE6JNayT0NLJ8Hk3F4
	Ck0i3yuTxg9A5g1777IDQNFHsVFFsyAEPGcmJL17SI0bb2zgJBknkmCXmSlXiW/u
	x/nRw0MwfTUcS5XzcN0H4stSv1+/lPJ2RJ6/iA0Ky8nQ89ZOg/eLoIw+DvqsR62+
	+C0r5GuBgvO9KpHFYYAb0HpzEsexgcNGZ3LokdRxT7Vl2VhdvOWZqO7DMH4T4RaP
	z+3g8H2IVpgJbny4dBj+/hxSFnPCMIUh3zabIJ10r7LNURmYauMeQcdpsjHL8Zk6
	MVKD1Ji7kYfMFItxBcRug==
X-ME-Sender: <xms:N7e9agb8QTOjqrvvCXsBEXmoLEiHm1jv6Gj-eW8yoCl9JDt8HFKbvQ>
    <xme:N7e9anVxUu6m5zHvQxc6OrtfoEgcNb0iycyWPedN9SY3v43zZwv8cKM2gdhEJXyv_
    JE7B9HrtpRCPKIz3-46JcrECOzEOUXj4N6Dv-jj10TrFenQohXAjUH3>
X-ME-Received: <xmr:N7e9ahEJx1sRCpclHA8ZoWUPzaKLRSXqhzx5ZGoVOB3ihcXusCSBVtWYDiveS2ZspSNf3Fike5uAY8iLOv0wl1mw>
X-ME-Proxy-Cause: dmFkZTECkHaILi68QL9O3FhZe9ryr3f9Pt9yjJn9u3JIIWStBnOtvUy1N6AHdszFQG5jwL
    saDGyTURO6o9wMPgHddL3j1ldc5WI7lejTX78IEZ/yQynDuMTC8RkA0X5Pk8jGFUxqcq2B
    1RcoOCbK/gPVPV8WNjYkCpxcVjP96g0jrFdzTEB/5PT++bjm2e+X2umPepd/8f+oWwNiN4
    VzNi5YgDuEYMlg90pBc0HrCSd7cLakC/9NyVb/5YwWRJBu/5j2GN0UK0pM2T7i4sGuqsy+
    bO+T+ZI7hk/VurcynbtspcInZuYtb5iGW0qtOJOP9I9Mv335hsH+/WAt9+TD5g9oTjL2HX
    sLO7lvnciETUu4gRlVLyjJcRaDdsi7stp5s/K0RoS29bAq/scNpkc+1l1/e0hdV5MXlv5w
    iNAP6J/2gCbkue23nDoWonbGyyx2qbevrWRXqQWCkZL4z85dX2J3ns5vNjceKqyiaNBA/V
    On1dEWA0EF+z29cR8U/bKTNQBAp1/MwmmwnnDTaZUlx/i+VghOhKZht4BFpaGDIcD7SWok
    RnZNFUlUiPhRYPRDrJAyTFpqJwX/JPmpdcOUg3TpbvwI9z0LJdpVE3kWnYPuV0V8AZo90Y
    aYF+YBRgt09MF0vmsZAAzQIOskxLOXJUfKW96h6RhOJoco3ttkMRZk6C+9ew
X-ME-Proxy: <xmx:N7e9ahD7NSKFICwz-PYQ5_wyYXSJc3cFMNVN0GqcYCK6dbczpplAvg>
    <xmx:N7e9apz4C3DD35P9NbrJJYVHiYTUCKIIZEhJ9E9vKAB8kZB8kP0c9w>
    <xmx:N7e9aiCebYutX2f5wP7ol1CdtiRcVlXM1uaWrZJe1yXA9uMWwfSR6w>
    <xmx:N7e9aiAz3KncMwV8iwNb4eNQUHJ31fiy8-62WPkN89wRl43Bkn_tyQ>
    <xmx:N7e9aufms2eh6LPpWy5sUvEcJMQrzqQCYQ5ec1AMA6FWPqraAgHuLHz3>
Feedback-ID: i51fe4b43:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 30 Sep 2026 21:28:19 -0400 (EDT)
Date: Thu, 01 Oct 2026 10:28:16 +0900 (JST)
Message-Id: <20261001.102816.848418815165006267.tomo@flapping.org>
To: gary@garyguo.net, markus.probst@posteo.de
Cc: tomo@flapping.org, aliceryhl@google.com, dakr@kernel.org,
 ojeda@kernel.org, a.hindborg@kernel.org, acourbot@nvidia.com,
 bjorn3_gh@protonmail.com, boqun@kernel.org, daniel.almeida@collabora.com,
 lossin@kernel.org, tamird@kernel.org, tmgross@umich.edu,
 work@onurozkan.dev, linux-serial@vger.kernel.org,
 rust-for-linux@vger.kernel.org, fujita.tomonori@gmail.com
Subject: Re: [PATCH v1] rust: serdev: use Delta<Jiffy> for timeouts
From: FUJITA Tomonori <tomo@flapping.org>
In-Reply-To: <DLT305M0I5L5.19LZT0V02L1NR@garyguo.net>
References: <DLSP8RHJMYFZ.3II53ESHY15IL@garyguo.net>
	<20261001.092931.734162860031900892.tomo@flapping.org>
	<DLT305M0I5L5.19LZT0V02L1NR@garyguo.net>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Thu, 01 Oct 2026 01:39:51 +0100
"Gary Guo" <gary@garyguo.net> wrote:

> On Thu Oct 1, 2026 at 1:29 AM BST, FUJITA Tomonori wrote:
>> On Wed, 30 Sep 2026 14:52:50 +0100
>> "Gary Guo" <gary@garyguo.net> wrote:
>>
>>> I think the API should ideally use `Option<Delta<Jiffies>>` for this case, and
>>> use `None` to represent indefinite wait.
>>
>> For read_poll_timeout(), where a timeout of 0 means "never time out"
>> in C, we did not take Option for the timeout. Alice's comment [1]:
>>
>> | Another thing is the `timeout_delta` option. I would just have
>> | written it as two methods, one that takes a timeout and one that
>> | doesn't. That way, callers that don't need a timeout do not need to
>> | handle timeout errors. (Do we have any users without a timeout? If
>> | not, maybe just remove the Option.)
>>
>> serdev is in the same situation. Do we want an API that uses None for
>> "never" here?
> 
> I don't like the "using 0" to mean forever, because 0 has a more sensible
> meaning -- which is just do a poll and don't wait.

Fully agreed.

> This one doesn't even return a result at all, so `Option` sounds reasonable.

That's true for wait_until_sent(), but write_all() returns a result
and it can be ETIMEDOUT.

> Alternatively, just use `MAX_SCHEDULE_TIMEOUT` (i.e.
> `Delta::from_jiffies(isize::MAX)`). We can perhaps add a `Delta::MAX` for this.

I don't think Delta::<Jiffy>::MAX is a good idea. Whether the maximum
value means an indefinite wait depends on the function. For example,
it doesn't for Queue::enqueue_delayed().

Another option is to take Delta<Jiffy> and round 0 up to 1 jiffy. A
driver that needs an indefinite wait passes
Delta::from_jiffies(MAX_SCHEDULE_TIMEOUT) explicitly.

Markus, what do you think?

