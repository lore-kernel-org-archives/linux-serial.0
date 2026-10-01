Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DE74366541;
	Thu,  1 Oct 2026 04:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790828805; cv=none; b=ha+Cegeeithp+pmuHiCzu4H2ahi2VhsvR7OwiQLOp+iiuqaI0siKtLpTeI6YhH1fjUDueEorauMdP0NPLnrHHqU6M0lxnIExoHkZFhxjmIePijsty/uB/JpuwNiDEBPTYgq47kTjbY3x0mjF0WJJf/xaHAzuMRFjlPlkbn5GHhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790828805; c=relaxed/simple;
	bh=GuGuLAKJN0nhnfiCJLSLeRITUvuz6hln8Qw0SHIS9bI=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=dV2sfCq4rMzxRz2NufTpfuQ9xEm6u6y/YEmNGC+CHbF6VHxXyes2zBkTjoPzMCtguXzmgvzYG6qaZBwdPoFmOFDnDoEWiYo15w8iim9JYqchtm5iWh9qeqcQhcop6mXt5/BuN7LlGkxKE6juqdzAJsuGRvMxv/Q6p+9bCO/KkNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=flapping.org; spf=pass smtp.mailfrom=flapping.org; dkim=pass (2048-bit key) header.d=flapping.org header.i=@flapping.org header.b=O17HrY8S; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AwtJatBE; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=flapping.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flapping.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flapping.org header.i=@flapping.org header.b="O17HrY8S";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AwtJatBE"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 2BBABEC0022;
	Thu,  1 Oct 2026 00:26:40 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Thu, 01 Oct 2026 00:26:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flapping.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1790828800;
	 x=1790915200; bh=6ntqSFV/+jtmXkjoJdPZodQWUppeGhACEUO1b4Gkd8U=; b=
	O17HrY8SBlU2LK3apgXYZXHJ+v9xLB3BVeAStxxVK/AVwupHApKLOxALmdmdnb9r
	10EKM3mcKUs9cc9PB0R9uDwEH9byBrta7PbueJuIUybJD0L6ESCyixCiXeJ7fad1
	bqL3jkQKratJIDWroUzmS+cwWgAeyyprU3oKJk+0KmlPVF42Z+JiI+Gsl1U0RgL4
	s3igA/gTKcEvyIW7v2JOlhjUPJfhAfw2B4ay8zXKOixjX1ftbi2xc91shwuq8J3z
	TQvXipPG8TIZGgBpYotD4haPMiKTPtCN6DjMCt7tiLt++8v/6CX0XKZPDDs+BnJD
	PIyUMiob/jyyHlrgtY+ErQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790828800; x=
	1790915200; bh=6ntqSFV/+jtmXkjoJdPZodQWUppeGhACEUO1b4Gkd8U=; b=A
	wtJatBEod4ZlAbl7SeDtiStRqJLn2e05r5KDKERfluf33/6LusZxYo1jK/MOUyaN
	tdd7bZjS2enbUz+/V8+A4rMb+CGo/wMgY5HkaYFP+xze1i2syeO3PTzIAtyV82Qi
	Ofxj13grLt/HTMDkgNhHth7VeXLzJBO+EJWhUhIUl1yLtbF7ediZy0JpxayARTXO
	PQfF2fxtppMkrEKvTHUOWrDGbJ4YzDjOVuIQQ6Z54E4DZthNDWZ91uxSxyd3Dioc
	W9Em+sZs2Gu52FnUyeqZkBb6khVbKBqK1jNZczYBWdjp1qHBf80o4NTemc4SjCHZ
	JziYf+r6kioETySC7Mgig==
X-ME-Sender: <xms:_-C9ahcipUvohr_oywDPe98xzQvKZbTxLY9JV3enJYTHKbMEXi20bQ>
    <xme:_-C9arLsaDqF1Aa_9YdzpWFSIytZfnT81ElRsQfQZySHllYXbxpl6aVbFEtPqVr09
    _mCNOF3hdfRFcz_mgTnShtLEUvo0HIhYzAH4G9wKZja0c2VBWwtujc>
X-ME-Received: <xmr:_-C9agpQTnZqscOnxRwcMfXcTdzEVJeytACE38K__XAM_30IqyycCBObtrsV2gPvzpNyRcqoZ0F8eOq1Ul_tgB__>
X-ME-Proxy-Cause: dmFkZTGmPX38JoMdWZOKuvYAd5LmT7MT72sMJFleChKFXp18w/nG5CRjGhvcJz+2m9YaOK
    KciWqLm2kc1UUaZ66EE/KzL+RWbhTJbRDm6FzqMQliGuIFIw7X8QTIcCa11Fy03KLXMeYC
    lDazcanKqXZsBZ/GJo6bTkZpM+1CatMP+e3wKi/nP7n4bSpguKPDICYBPH8+GTS3THi+hz
    yc34diC2GjZVHF9J4tSpHqRE+fTWgGgaTinJwa6TgnZiy4pUD6qR5EmIha0TnUM6ge6OU7
    d5WVooBmUqHcx3ZkxOiFggTZ4ee1vCY3HBaz8WnvA9ISqVJlSivKsA3wZW1HYlA6AvpEQX
    efleJMY+zqf/hgo5dFP86phpMd5PAazP5GqSKkprW+MTy04qjm59ZrQuisMHPIKQwBHiWu
    Oxji//4RHzgrnmWvQV4pJaxIA+4V44Pel7m2aiBFmmuiMmKS4lz0fVu/V2//2NzuDt2h3B
    5MTkrGPzlVwj3D/BiZ3i3Kc7VtF/9Q4Cz6BEOQuKZrtja+Grk6tWJPYJUnLFpvO7COBpng
    C8jrCXnHdAbhAzLqUcPj9thOhYzEMdVptxwqUOOiHkylHd1Iu4OMoH7zLhmdpLx29zi/Dy
    U+Rn2JgqkQhcKcZmp7X1FLO1873T9yl6QeDXtL0KFwv83/HDul+fgSadPXtw
X-ME-Proxy: <xmx:_-C9ahXpHlMyFix7ECSOrpQPStExpI9mAnrZVKBy0KUsSbqMUk1E9A>
    <xmx:_-C9ar3OrUslO9euiZAqG5lGomhRb8wj1I9xJNOm8lcoM_CqspJZdA>
    <xmx:_-C9ai1wI3rBW0EpL4RH6BESrD6LmUuqhY6t5umRMeM4VgTkrmXeDA>
    <xmx:_-C9aqlQ-pEhIfwAS4viOnPDWwU0tlXw2ZIWc36mDJHxjnvMUxxdNg>
    <xmx:AOG9at--90zRS0KSNa3_FsP49BF3azDur0j7KqJPp1K8jYBRK8t1Oncb>
Feedback-ID: i51fe4b43:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 1 Oct 2026 00:26:35 -0400 (EDT)
Date: Thu, 01 Oct 2026 13:26:33 +0900 (JST)
Message-Id: <20261001.132633.73542440712145669.tomo@flapping.org>
To: gary@garyguo.net
Cc: tomo@flapping.org, markus.probst@posteo.de, aliceryhl@google.com,
 dakr@kernel.org, ojeda@kernel.org, a.hindborg@kernel.org,
 acourbot@nvidia.com, bjorn3_gh@protonmail.com, boqun@kernel.org,
 daniel.almeida@collabora.com, lossin@kernel.org, tamird@kernel.org,
 tmgross@umich.edu, work@onurozkan.dev, linux-serial@vger.kernel.org,
 rust-for-linux@vger.kernel.org, fujita.tomonori@gmail.com
Subject: Re: [PATCH v1] rust: serdev: use Delta<Jiffy> for timeouts
From: FUJITA Tomonori <tomo@flapping.org>
In-Reply-To: <DLT5AOYLEZXE.C2HPEP6WSP33@garyguo.net>
References: <DLT305M0I5L5.19LZT0V02L1NR@garyguo.net>
	<20261001.102816.848418815165006267.tomo@flapping.org>
	<DLT5AOYLEZXE.C2HPEP6WSP33@garyguo.net>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Thu, 01 Oct 2026 03:27:39 +0100
"Gary Guo" <gary@garyguo.net> wrote:

> On Thu Oct 1, 2026 at 2:28 AM BST, FUJITA Tomonori wrote:

[...]

>>> Alternatively, just use `MAX_SCHEDULE_TIMEOUT` (i.e.
>>> `Delta::from_jiffies(isize::MAX)`). We can perhaps add a `Delta::MAX` for this.
>>
>> I don't think Delta::<Jiffy>::MAX is a good idea. Whether the maximum
>> value means an indefinite wait depends on the function. For example,
>> it doesn't for Queue::enqueue_delayed().
> 
> Whether it means infinite or not depends on the function, but that's still mean
> "MAX", no?

If I understand you correctly, a Rust function that takes Delta<Jiffy>
turns Delta::<Jiffy>::MAX into the maximum value of the C function it
calls, and documents what MAX means.

isize::MAX is MAX_SCHEDULE_TIMEOUT, so schedule_timeout() and the
functions built on it need nothing. Other functions might need a
clamp, because C avoids LONG_MAX as a jiffies span:

| /*
|  * Change timeval to jiffies, trying to avoid the
|  * most obvious overflows..
|  *
|  * And some not so obvious.
|  *
|  * Note that we don't want to return LONG_MAX, because
|  * for various timeout reasons we often end up having
|  * to wait "jiffies+1" in order to guarantee that we wait
|  * at _least_ "jiffies" - so "jiffies+1" had better still
|  * be positive.
|  */
| #define MAX_JIFFY_OFFSET ((LONG_MAX >> 1)-1)

With that, I'm fine with Delta::<Jiffy>::MAX.
