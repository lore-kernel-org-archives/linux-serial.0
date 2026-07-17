Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF88A3F39E0;
	Fri, 17 Jul 2026 11:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784287380; cv=none; b=Zu2f/bB4h6fxnwEmYdYG+XAFCRftF4qzMiZDAN8egTCnTRS/a48REtkk1BdaQoPykirhaTO02FKnOv+sGkQlMbUhQkG8mTRRE3Sr1VBqWJA/uh/y1J4HWpYxgdE3NE19WP0RL9zNA+r2iTlUuwcdgmyFqhdzZhrywXpHvUJ6abY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784287380; c=relaxed/simple;
	bh=n5jy1dMTAiOP7u3UwHo8kW6BBO3YFSmmT+Cr4q9O1lc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pnXkYI28WDGzM3Bp/M2Z+UOuuQpFcZshnhl2LjvMHaffI6qt4YCUBt03W+wGni32JXuhFwjIYNIr/rt3oc5aw+kQlvca/vKwNqdx7Jfd5g1JiY9lKniEoJ2xHGj+0fyw03GmAFoN2XzeTkl6ifaCBVTBnEYu932KapDq/UdJxWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BORoqmaj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BORoqmaj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA3071F000E9;
	Fri, 17 Jul 2026 11:22:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784287366;
	bh=9LCzGkAn0s99Wu4b5pEqOhCS6H/n/ifw9YI1PjIZdJY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=BORoqmajZ01WbaNHqJJnfAcCS1YoZfgYjWT/b4P8r8Z756BlgJAnP0gNzRV68hDtn
	 O1iq8KOes7AqTmiD9sn9COBZZrxOCzrCTB4EKiUiNSjfXXbrDEGurwR0OSfZxQKPQR
	 0tqG3qWcPIbxqvm8ieVpq+YSR0ELomLtmegB3j5e5LxfnZoTYEvwg91BFpN0ACHtmy
	 K602ooOp7yGKdnAl/ReGLTL88RB6fcCMZ9Ia8+uBv08Yw+MjhIlAv012jrYpJW4/pP
	 pEHs5tnUWYHaHke8kGd7PoTQnzg+ptnamb1HJm0wuT3CbsPCA5oUcUQNgxhxqlgIdl
	 RRRs4pNCx/2qw==
Message-ID: <74213297-d3da-4637-8f31-8fecebd65f60@kernel.org>
Date: Fri, 17 Jul 2026 13:22:40 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 0/3] rust: add basic serial device bus abstractions
To: Markus Probst <markus.probst@posteo.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Rob Herring <robh@kernel.org>, Jiri Slaby <jirislaby@kernel.org>,
 Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
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
 <6aafea3fdb0847766787dbe5c7c7dbaad606d649.camel@posteo.de>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <6aafea3fdb0847766787dbe5c7c7dbaad606d649.camel@posteo.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/17/26 1:14 PM, Markus Probst wrote:
> On Fri, 2026-07-17 at 12:55 +0200, Greg Kroah-Hartman wrote:
>> On Wed, Jul 15, 2026 at 09:00:14PM +0000, Markus Probst wrote:
>>> This patch series adds the serdev device bus rust abstraction into the
>>> kernel.
>>>
>>> This abstraction will be used by a driver,
>>> which targets the MCU devices in Synology devices.
>>>
>>> Kari Argillander also messaged me, stating that he wants to write a
>>> watchdog driver with this abstraction (needing initial device data).
>>>
>>> This series depends on [1].
>>>
>>> [1] https://lore.kernel.org/rust-for-linux/20260530132736.3298549-1-dakr@kernel.org/
>>>
>>> Signed-off-by: Markus Probst <markus.probst@posteo.de>
>>
>> Given there are no objections, I'll go queue this up now, thanks.
> Thanks for merging, but I haven't seen the dependency
> 
> https://lore.kernel.org/rust-for-linux/20260530132736.3298549-1-dakr@kernel.org/
> 
> getting picked yet (its at least not in linux-next), so it might not
> even compile. Not sure whats holding the patch back though.
(Ah, saw this just after I replied to the other thread.)

Nothing is holding them back other than requiring a user (which is your work),
so I did not pick them up.

Also note that tty and driver-core are different trees, so picking it up in
driver-core would not have helped tty.

Thanks,
Danilo
