Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0D44346E6D;
	Thu,  1 Oct 2026 00:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790814581; cv=none; b=EZieYo0By6pRaUpLYfrvM80vMH+tEIVkc4aYTYs3djV0DgbD4I7qCIkyut1OxSA/ry4/6+qN9yqqx0q049zQsJvvou+NcRraBMTeTYIORW3fEUU7wjaTE1Ui4IWdWp5xwMaBVjCj0uFuA5cARIQUlsJ6gdFQtikQWwBi3LJsjUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790814581; c=relaxed/simple;
	bh=vqLxQa4dg45L8d4TVe/lKsQia34uBf2jmQAkP9+qWpc=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=r/75TLYKHgCoeUfovMA2G2eLW2ToXnNr3i/xpl1O5KIjfO2Vxv7Fo9xySsOEG1s9mzgkuhUTINTnw824N0AFie9seFN9/KzyDtqrIh5mVBqmEhMXsYyDAApINcFCUTNxivLcEzkI3OEM0I7H17Wek3TGV8ZNwBK3nH/I4Qhvgwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=flapping.org; spf=pass smtp.mailfrom=flapping.org; dkim=pass (2048-bit key) header.d=flapping.org header.i=@flapping.org header.b=TpHGefEq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PUATFkLS; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=flapping.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flapping.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flapping.org header.i=@flapping.org header.b="TpHGefEq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PUATFkLS"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id D281FEC02BF;
	Wed, 30 Sep 2026 20:29:38 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Wed, 30 Sep 2026 20:29:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flapping.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1790814578;
	 x=1790900978; bh=QG5mOC8Ea7dAzNNESKpze+8IotvuIQeyFETGJ/d49vw=; b=
	TpHGefEqcnY2pEU3e4BwyO/47uSMAE8SGOtDcaVxIu6PH2GqIQv28XshW1kRCq+a
	lLMm8iFs8oOutnzCvMSfG7Zpl7KEfx+nnyf7bslb8MFgxPrk8RpVkECqytKb3JE1
	RggQFk87bYZAnVd1YSfRu+IIKJ+zmQTy/vvCYoj+TyzCW24F1W5zLTzzMM9/GMzM
	Nv+Z0mtkwZshJhwPbIIxY7G8sEBWQT6i6ibcecFHMnhqo4R7dgvQaIC31U7SoGct
	TH3J8aBZ8uRFoJzFaoa/MKos4iuBDbQtwbeLeveK3gKpmBp6IySMebv6b1DtblBU
	Eg9gHLHI6CSMaLLGGDvrbQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790814578; x=
	1790900978; bh=QG5mOC8Ea7dAzNNESKpze+8IotvuIQeyFETGJ/d49vw=; b=P
	UATFkLSEdmfCoBwyGBJaztHUGczTKcmeAc0Q6EHCwrxQkN0pZbz5vWpNc/g6zbGt
	6FlQKMszpazyOxPmce1FGFDdt7H+UNFCJTESl6q0ish/4TRsLuKFf+dysqHXFMuC
	wWpVUEhQNQzXETHz5KbjFlwR45zdjb20jWowJEHCY4D06myh+zZNyZnnWmyT9Pah
	gZFOlv5Qss5/fGTIKfhn2h8413FKOxOMnHYE17IDPXVxA8v5CfqjDyPvWvirJc6X
	YGOjKe6w3RV8hcHdO1ahydkMIwpj6z5aPpIf03bXXedXV15i4HuR0I716iVgeIOj
	JCqz8BT6gNV4puw1cKz4A==
X-ME-Sender: <xms:cqm9ail5YfO5dD_Gdk1Hl1ViP9eCiOOSo3RMPU97BRuUwj04FVzaxg>
    <xme:cqm9alwrbLxX7zTHFTrm_nOtK0OM2D1iNe2g6U05x-DzaXruNj3iYnBVOdj4hJoEA
    fUuEny0gQhhJqmnRdtA7r61wZipOMAU3p1qe1fzff48ytn3Si4BH8mh>
X-ME-Received: <xmr:cqm9amy6tOyhKXWha4NXSrjzbYS7bGqN2FpPYQtj0JUHToKWbRXYyM5LAUk9I7CL4Ps33y4lQBN55O27DhwxT2tH>
X-ME-Proxy-Cause: dmFkZTEtlGkHTQ6heY177mW/CKl+TKGnUH9b3/xKCLDLSpXaGogJCVC/ZuOJH235kIRGQk
    LmqWU8Jc8s4mxrUNeKo06jTYIysiu7814oy7/sajYtQa5J6IU2x0+0SAY7M0MGR4okQaib
    xAfSpvy/qWQr/Yzidp6donqPjSB/DO25ZqWBr0LzrMmZ+xAnAWX8aPhl4YFCA25+pJiH7m
    CqyKDZ0lDmkJBaTkhYClHOJdk/LmYl5UMWNw7LGTJ6MMZ14F9xeAI7Moi2tAxNGZvXY7jY
    wJJEYpcWPpxA+pGOZvH1sIXIJ/e0YM+4TDuPRLq2OWB5wwA90zHCZPFtfLV0g5/pnFCoQ8
    SY9jBAHMVi8SsY++v4QYZLO5yreB+XY9ILjnY1aVMlu6bfdIC1OTO6dxHu1UcZSyV6u35k
    KROFj/s4zvvfaB19ZCW3CUkqtEycljK+bCJn/tzYK8hO7oLaxqb03X/5Cw1aj4VMkY43l9
    TjO5vODcCTFXY9Pktl8ZYzaojbYaxO7HCMLXI3hL0/rDDIAlp1rVH5r4UEjsDwOWgXdEbt
    cSL3KV0aed2r7vDov86Cqjy9aTYaWsDefwurKGYx1s49mai9yzrU24M4iNptt833QAcs7u
    CDaXxNdvDox6rsgCVKYl27uSnyARlD0a8AX5eBvR/nmPWe40wMQBGGZTUkkA
X-ME-Proxy: <xmx:cqm9as9Aps4wKpwgxEoY4DFrlmatb_gVB3gniup1WFE9sZEo673V2A>
    <xmx:cqm9au9El6gZ5rO0S1VT6Q_umYhMVyl-adb53UEUzZxTWs-TSnE1_A>
    <xmx:cqm9anev0xuUAb76aO7lR9TQub0HKxJGaLoJqYoXjM7v0luQuGxztQ>
    <xmx:cqm9aiu_GUe0_I9cQPjtMuUSZ2k4CknQqgDD1BJL9AQx24jO4z9OGQ>
    <xmx:cqm9arJUXXmNiJw7M2feUsTNdR2IoXau-M1X0zdKHl9nWX53WkhUHrhK>
Feedback-ID: i51fe4b43:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 30 Sep 2026 20:29:34 -0400 (EDT)
Date: Thu, 01 Oct 2026 09:29:31 +0900 (JST)
Message-Id: <20261001.092931.734162860031900892.tomo@flapping.org>
To: gary@garyguo.net, markus.probst@posteo.de, aliceryhl@google.com
Cc: tomo@flapping.org, dakr@kernel.org, ojeda@kernel.org,
 a.hindborg@kernel.org, acourbot@nvidia.com, bjorn3_gh@protonmail.com,
 boqun@kernel.org, daniel.almeida@collabora.com, lossin@kernel.org,
 tamird@kernel.org, tmgross@umich.edu, work@onurozkan.dev,
 linux-serial@vger.kernel.org, rust-for-linux@vger.kernel.org,
 fujita.tomonori@gmail.com
Subject: Re: [PATCH v1] rust: serdev: use Delta<Jiffy> for timeouts
From: FUJITA Tomonori <tomo@flapping.org>
In-Reply-To: <DLSP8RHJMYFZ.3II53ESHY15IL@garyguo.net>
References: <20260930041339.1551129-1-tomo@flapping.org>
	<a8693eaa1f8eeb167ee334e7c35371832e43bb4f.camel@posteo.de>
	<DLSP8RHJMYFZ.3II53ESHY15IL@garyguo.net>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Wed, 30 Sep 2026 14:52:50 +0100
"Gary Guo" <gary@garyguo.net> wrote:

>>> diff --git a/rust/kernel/serdev.rs b/rust/kernel/serdev.rs
>>> index 17ca504b7f8d..094503f059ff 100644
>>> --- a/rust/kernel/serdev.rs
>>> +++ b/rust/kernel/serdev.rs

(snip)

>>>      #[inline]
>>> -    pub fn write_all(&self, data: &[u8], timeout: Jiffies) -> Result<usize> {
>>> +    pub fn write_all(&self, data: &[u8], timeout: Delta<Jiffy>) -> Result<usize> {
>>>          if data.len() > i32::MAX as usize {
>>>              return Err(EINVAL);
>>>          }
>>>  
>>> +        let timeout = isize::max(timeout.as_jiffies(), 0);
>>> +

(snip)

>>>      /// Use a timeout of 0 to wait indefinitely.
>>>      #[inline]
>>> -    pub fn wait_until_sent(&self, timeout: Jiffies) {
>>> +    pub fn wait_until_sent(&self, timeout: Delta<Jiffy>) {
>>> +        let timeout = isize::max(timeout.as_jiffies(), 0);
>>> +
>>>          // SAFETY: `self.as_raw()` is guaranteed to be a pointer to a valid `serdev_device`.
>>> -        unsafe {
>>> -            bindings::serdev_device_wait_until_sent(
>>> -                self.as_raw(),
>>> -                isize::try_from(timeout).unwrap_or_default(),
>>> -            )
>>> -        };
>>> +        unsafe { bindings::serdev_device_wait_until_sent(self.as_raw(), timeout) };
>>>      }
>>>  }
>>>  
>>> 
>>> base-commit: f1850e443b0e4f2429ddf42a8d5033ea54ae8a90
>>
>> Both functions have "Use a timeout of 0 to wait indefinitely." inside
>> the rustdoc.
>>
>> Make sure `Delta::ZERO` is also usable for `Delta<Jiffy>` and replace
>> the 0 in the rustdoc with "[`Delta::<Jiffy>::ZERO`]". You might also
>> remove the "timeout of" part, but I don't mind if it stays.
> 
> I think the API should ideally use `Option<Delta<Jiffies>>` for this case, and
> use `None` to represent indefinite wait.

For read_poll_timeout(), where a timeout of 0 means "never time out"
in C, we did not take Option for the timeout. Alice's comment [1]:

| Another thing is the `timeout_delta` option. I would just have
| written it as two methods, one that takes a timeout and one that
| doesn't. That way, callers that don't need a timeout do not need to
| handle timeout errors. (Do we have any users without a timeout? If
| not, maybe just remove the Option.)

serdev is in the same situation. Do we want an API that uses None for
"never" here?

[1] https://lore.kernel.org/rust-for-linux/aJm9A_D-zlJtbV6X@google.com/
