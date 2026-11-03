Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.158
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793667733;
	b=3L4snwWXvTxEyir56W02ZkBPZ32DRMCPHdYmRkqdXSEbn8dNbc5d0rMFVi8PGjG18ytd
	 eX/0B7DJBvaj239wLLzdSStgeL39mAV1tkEeMuUn7LKKFWtCWCJv/Y+d0gGANVYnGIi7m
	 Qm1y9Zpaxju2fECl3SNgLJtiE3/VjGbFFShzBnd7jn2tP5y6Pv45O7vDndmAiI3yqfkVl
	 A+QxHlIdPoBt6kAswJBt0gymW1z8gj9tIyTGTJkPCh0B8OUtQtPAskt7tNhTdpKFqp8D2
	 PnwQIbCuoLa0JVtSYAdAQHsnFTLdxkR1anuRYkDMCTFPX2Ibgy8kWYo3ynmNbm+DsqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793667733;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type:Content-Transfer-Encoding;
	bh=q7TJujUGkcSK3o4vcH1xgb8tH4hXcocg42f0F5Svbyw=;
	b=EOPnLEiUxJXJw0jG/LpDTdYI14voK9jR3RLyowm7fRsixQQy0xW/5mUWtOq9VJp8E5aV
	 eZMqJxWzGcly0Py2s3XITo9D0WRm/Bp9yWC29/gdP+YFZWclqvGzf2WjXO/8/apnbRKAw
	 pJH56Yh3IIGeNe4F+FTtqCawXWBp9Vs3FYRttDSMfQ4J1MAeJ9QR30v7LPQKiaNCrTlkp
	 81lP5/SrX9YE1RKn9HVnVKhTq5e8CbQvKVm6e1rigAGcyzZL56Rf6OiGex4K8cNdg9SZo
	 o7AYyLVA7ZvCpwcnXf6i7qe+r7xvQWyQQG4bfcJyfRlyYo2KvgzKwHFy1SiiEMBoGKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=flapping.org;
	spf=pass smtp.mailfrom=flapping.org;
	dkim=pass header.d=flapping.org header.i=@flapping.org header.a=rsa-sha256 header.s=fm1 header.b=tgBjOA+1;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=OU92y5lk;
	arc=none smtp.remote-ip=103.168.172.158
Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE3A606A32F
	for <linux-serial@vger.kernel.org>; Tue,  3 Nov 2026 01:02:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EEE3A606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=flapping.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flapping.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=flapping.org header.i=@flapping.org header.a=rsa-sha256 header.s=fm1 header.b=tgBjOA+1;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=OU92y5lk
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 30B111400233
	for <linux-serial@vger.kernel.org>; Mon,  2 Nov 2026 20:02:12 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Mon, 02 Nov 2026 20:02:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flapping.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1793667731;
	 x=1793754131; bh=q7TJujUGkcSK3o4vcH1xgb8tH4hXcocg42f0F5Svbyw=; b=
	tgBjOA+1ieo88Eo3MmyB+jDXEng5SA1cC9+5YL79JsR4xyCeEz5+0PhwXw0oamV9
	Lcj796stik3rRF/Pv8YJo67sS9SOLl/ODx5fpPtY/0oLGYJnXBSyJyxTcZL0dDuh
	W+GlO+VxL0ddQ7E9m1vGQix/GRfQ8jW+PQdD1F0QB/hfyDaj1Pq0vM/vwdsbSS0m
	RMI5wxe6t0mzGQ5R5PDE9dko+NGHdAXjQ1aziBmiCad/3POF501PFbrUW/F5x3qS
	wuvL22aUyi3byg4HVqJnFhBonTE1xZBbvKwkMo/F+8xdhfs5K7D3k8zFyxuCGWSU
	LjZXoAXK6+BTCQdLx9Q54g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1793667731; x=
	1793754131; bh=q7TJujUGkcSK3o4vcH1xgb8tH4hXcocg42f0F5Svbyw=; b=O
	U92y5lk7ElqPMwv/M13AXqNvv9t4rpPN/rh2JqiQxZsSxruNM9TwesemmCUsyas8
	Cq0hxWZ9Pr+dSI/nMYeGYwsByuoZYsTsxt/Dz7lNtuHZ8IYxSixNywODIc6Hqel6
	HeyxkZ1blQkJEXCp7G6LNJcUwS1UX9wazw3RVdPhwT85gUaJlV1xUKSrDYtWqqQt
	dsjxd9A879sD40tLpHpiAxbuoUzlE+KVnozNlIXWy+VFVDWu+zNq3xL43fOvfzAT
	h7cilcKeg1N+J+xFnpMEPK+rIIDVa79S04c7svfQv5s/Y2M17rT/7j2PqcBVSNR5
	Cri2nkJg6c1opttxF5qPw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=flapping.org a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793667731; d=flapping.org;
	mf=PHRvbW9AZmxhcHBpbmcub3JnPg==;
	rt=PGxpbnV4LXNlcmlhbEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:CStN3Feu8a+f+UxLgAWSVTO6XVUAl4TytBwNK7EwEPxycQS
	2+GYjXXvlz1yVtxq1xkCz6c33e1sZCHt0J8yIi7ALZRs3SVaepYYalFtVVTlTHcM
	Vur8jIo4w+9eEXt00HM48yOvtAGAIkOWAVMktVh/bs1RmsMbtNNruDo4WppV84eK
	LqWLmkJ8Ufv7h0SLs3bPeemHwc8jDOfL0nrux7Ya2SHn31nNXBeEUyEpUq29Tnqb
	fgHgyM1GVcmuoSvVXNLJ5LH8bEKAJN5rBMQtKKfEv5lHN1z/rC/Owc5EWKEabJjf
	PI68vMhALHyBalp+/KStAGiUXJwMahZBqB6pHXA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:a3v7fm8Z5wEeYRaqa2qbpuTJWkVUAtPEHvdsSVCjWIM=:5kJn/zluX859sm57ACQ4jGGQVEHVweTmcUl56oqm9V8=;
X-ME-Sender: <xms:kzLpaols4RQPs1xIHYEmTekjiHQINcfTzA0Y4emoIEWnu6g6UtKniw>
    <xme:kzLpajwLD5G40_T07pfqs163W7jrJLAvt7UT1G03CFcMIuIt8g-RyfAdYpiVar3qx
    eYvgsMjHhfA_oNOHgHoTtgiF6V-GgacXIyQfXx6xm2NB6cNL7KfmP-H>
X-ME-Received: <xmr:kzLpasxMsW3Kw9bULIuYyvE7FPRLVFmji4_-m4Ss8cZrg08PAXU4rrNnQMj3oogcHOGI8ue5C7oN9rb-En3KNfx1>
X-ME-Proxy-Cause: dmFkZTGkAlZEDZtcowTKjPitBAfNXq3HiwBFGK1utx3xruE0LcH5DQxhrxcPcoxK+7B7rD
    OBsYR9pS4NmoWlGV6eqVncxFF0dMMPU7ePClRWN3wPdwgIS6W2QoflXXjRYuUp9sHPmGsy
    l0h5WRbb2QSALDhYbWHdQlPpvAg2uwCgKL87DP5ifxEHDyVz8ixeuLHzmY+zXCgbAfT9Ps
    919wGrwGGnKA5aiXy7d1cojJ0uKUjrXom1nwjaqVXoLkEsy3S3/lHDe/2bhJ+kqTiIrVyH
    Hd0WWAH0w4wM6ejPRgu0u178T1bnbEaU5vOeMFJNeDq7w+VK6iVuR03REuCQEkv5y051Np
    if8flBqKfGxRa55OVGeY6/miVcdFjyYoBrGFjZtJgEBwnvD/Qv7gmy01FFQYc6yEZkTOjB
    oc8p9sItA7Jm+kyO2lYpSBjVcuqgk21JPVeVuRsekX9fUwNng6aoiA2GzRpwgHjqhfgsLY
    ykXUtYhXaBimmBm2cRFeR8SoC0x8x6H+A9aDp1z7eHgJFw8tqC4h1y3MC0pMCtjA3U8/Cg
    5iVtwMQAhQM6H3E+xraL08KvlksTDv1VSxFlZve+0bp2k+PT/geSBj35iDDVV5YyvajA4Y
    53GDapyDLaFKgAb7vsWTQVedT5wG9EVbTNSih2zsiGiRfHvdxBjhgHGobVdA
X-ME-Proxy: <xmx:kzLpaq_TMtadqPh0jroZDuz9glBj2AyvAP8_iY-nUL93ya9pq28dJg>
    <xmx:kzLpak8O59E3oMKDc-jl2o1w7NHveHLirCf4aepCe1qG9uGAkXW4XQ>
    <xmx:kzLpaletOEbiXdz9-kY5N1_t_gH-saNLglDoUcBKyVYxaQbsTTDV_w>
    <xmx:kzLpaosXsVoC8By9aFtjnTQ8cCd_8nQotVP5XAhdoLAsW0UtkEixJw>
    <xmx:kzLpahKlYSNOsTWQQKFcX0exEByCMFvpABBVleKvWq8O54dlcOJ2LvpG>
Feedback-ID: i51fe4b43:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Nov 2026 20:02:07 -0500 (EST)
Date: Tue, 03 Nov 2026 10:02:04 +0900 (JST)
Message-Id: <20261103.100204.453363930065225212.tomo@flapping.org>
To: markus.probst@posteo.de
Cc: tomo@flapping.org, dakr@kernel.org, ojeda@kernel.org,
 a.hindborg@kernel.org, acourbot@nvidia.com, aliceryhl@google.com,
 bjorn3_gh@protonmail.com, boqun@kernel.org, daniel.almeida@collabora.com,
 gary@garyguo.net, lossin@kernel.org, tamird@kernel.org, tmgross@umich.edu,
 work@onurozkan.dev, linux-serial@vger.kernel.org,
 rust-for-linux@vger.kernel.org, fujita.tomonori@gmail.com
Subject: Re: [PATCH v2] rust: serdev: use Delta<Jiffy> for timeouts
From: FUJITA Tomonori <tomo@flapping.org>
In-Reply-To: <30511bdb7f197c632ee9baa7e8c5d730faad3b1f.camel@posteo.de>
References: <20261102005125.626125-1-tomo@flapping.org>
	<30511bdb7f197c632ee9baa7e8c5d730faad3b1f.camel@posteo.de>
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Mon, 02 Nov 2026 14:41:27 +0000
Markus Probst <markus.probst@posteo.de> wrote:

> On Mon, 2026-11-02 at 09:51 +0900, FUJITA Tomonori wrote:
>> From: FUJITA Tomonori <fujita.tomonori@gmail.com>
>> 
>> write_all() and wait_until_sent() take the timeout as a raw Jiffies,
>> which is a c_ulong alias. The type does not show the unit.
>> 
>> Take the timeout as Delta<Jiffy> instead.
>> 
>> The C side treats a timeout of 0 as "wait indefinitely". The Rust API
>> does not keep that meaning. A timeout of 0 or negative is rounded up
>> to one jiffy. A caller that wants to wait indefinitely passes
>> Delta::from_jiffies(isize::MAX). That value is MAX_SCHEDULE_TIMEOUT.
>> The C side replaces 0 with MAX_SCHEDULE_TIMEOUT before it waits, so
>> this gives the same wait as a timeout of 0 did before.
>> 
>> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>

[...]

> I would have preferred something like `Delta::MAX_TIMEOUT`, but thats
> outside the scope of serdev.

Agreed. I'll work on a constant for this in the time module
independently of this patch.

> The rustdoc example above `serdev::Driver` needs to be fixed.
> 
> With that resolved,
> 
> Reviewed-by: Markus Probst <markus.probst@posteo.de>

Thanks, will fix the example in v3.
