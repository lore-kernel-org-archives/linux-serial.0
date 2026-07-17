Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CFD339182F;
	Fri, 17 Jul 2026 11:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784287188; cv=none; b=OYVtaxGHoxfng218d2As3vFCVqB6ncgjgDDz6caTFVIl3PyzFjrP3vs1oOj4b2lnuoMxZXd7l7FuffgduY3G4yJJQdyY/p7DXsZBS2rMNAfiNRySKIT9FudLNx8OkK0BQs526hxLDq1AZBjSrodbae+WY4OIeawrrcojfdOuqCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784287188; c=relaxed/simple;
	bh=+e22S16eqNmIhh6xcd1xo32DYOQHXclQyD4Ni8C/tbk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P9aH27Z3RE4kTnGJqbMhB8lUCC43IVWz9P5OM+IMBp48HoTS2M9wi0ZnK1+M6CPzgcih7VXbHUn4sqqqiPuqgelMZUJxtvDsJ78hR/ZergK5dBkxWwgen4yVN4+Lzd54Cnb7zhVvZGEVjynfqgxti1KaQunSOqRlNdzkBqhWG7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TV2K7aLs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TV2K7aLs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C1DB1F000E9;
	Fri, 17 Jul 2026 11:19:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784287187;
	bh=6+3kplEtdJiZ7BArih1Y0WYc76SIkb0/U86jp1lq8X4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=TV2K7aLsAXB5ThVfMdKhRsNVo/RjAZC34KM3L3aU15x9S4j56z6k8gfO+zVQCkrCc
	 Vzhyb6x/phaQkYm1TlcXknDBKf/5pPwXwUd/9MWx2Gx/ARhmDDzuFaoba23NwzQOTP
	 yjWa26t/e3s6iLr2yP96G2WSd97KG8at/4AOiepRbYtl8TvyeE44t3iRIdL4mQyqqC
	 uVG+HW+XkXZXPZXbteARiGO6KfE30fLheIMly3L1+Mp/dE2Eq+sx70aytXECgbpYf/
	 3q/8/mvr3Rx+LAcKkbL0xLuc/C6Z19YTrsT8uxDQ4ViEtaNvNQhDrzQ1UWcyCdd0C5
	 /2i4nOdTpAAog==
Message-ID: <415dd6e7-4613-47e9-b345-76a44d3ec49e@kernel.org>
Date: Fri, 17 Jul 2026 13:19:40 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 0/3] rust: add basic serial device bus abstractions
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Markus Probst <markus.probst@posteo.de>, Rob Herring <robh@kernel.org>,
 Jiri Slaby <jirislaby@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
 Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>,
 Kari Argillander <kari.argillander@gmail.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, Boqun Feng <boqun@kernel.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Tamir Duberstein <tamird@kernel.org>, Alexandre Courbot
 <acourbot@nvidia.com>, =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
 linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org, linux-pm@vger.kernel.org,
 driver-core@lists.linux.dev, dri-devel@lists.freedesktop.org
References: <20260715-rust_serdev-v14-0-b4ed5c93606f@posteo.de>
 <2026071747-android-overhead-c927@gregkh>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <2026071747-android-overhead-c927@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/17/26 12:55 PM, Greg Kroah-Hartman wrote:
> On Wed, Jul 15, 2026 at 09:00:14PM +0000, Markus Probst wrote:
>> This patch series adds the serdev device bus rust abstraction into the
>> kernel.
>>
>> This abstraction will be used by a driver,
>> which targets the MCU devices in Synology devices.
>>
>> Kari Argillander also messaged me, stating that he wants to write a
>> watchdog driver with this abstraction (needing initial device data).
>>
>> This series depends on [1].
>>
>> [1] https://lore.kernel.org/rust-for-linux/20260530132736.3298549-1-dakr@kernel.org/
>>
>> Signed-off-by: Markus Probst <markus.probst@posteo.de>
> 
> Given there are no objections, I'll go queue this up now, thanks.
You'll need the patches from [1] as well.

Thanks,
Danilo
