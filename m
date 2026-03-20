Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E4C5359A79;
	Fri, 20 Mar 2026 19:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774036759; cv=none; b=Pn2TyL6VE+8FniPYBbakuEl5/2rZnnLdDiMLUnJutNBMdAtmp80UdSgSxXz2gi3zerDKJdCrBo6vLOVhZVUYnhOlk8GWeDY9ZasYgJuWR5ihU2z7r5+eCQlwA/X65Cb8siq9U1dwJdY9mNy2AK2Z6i5sKtzd0XGIoB34UHIFhnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774036759; c=relaxed/simple;
	bh=Pfby/JKkt5s6l/ZCXO+9pVjWe6FhJok+BymLoypmp24=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nb6M17rH7vQKjDKJxTklRKXCvFu2zKV5oAjbYfKDB1RO2qSh36adm+oVVtloe5XojwNweGhNKleJPjPwhKCqW2RiynogZ1isLY9pkedSSlH6whE/BK3QpTNxgjmFbTgqCymkCinT0F3vmP1+2IyxBM1t/p0qNZDhnwq4IVLvNUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B+bjLR+h; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B+bjLR+h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE966C4CEF7;
	Fri, 20 Mar 2026 19:59:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774036759;
	bh=Pfby/JKkt5s6l/ZCXO+9pVjWe6FhJok+BymLoypmp24=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=B+bjLR+hETXZGaeGEhgqOabt/zMNivQ2jyzd+65r5dHZuP7WaMS4MBoEsZCfr0LG+
	 zGRVCGiv6Ckl7o3Kg0qvntulZ8EETYFqMcrpB3laNzC9ilr2fdRYqP6Lm2U9/BE2tP
	 Z/zbRuO3C8KVVh3rR64M4N8iA5T2qug9R63Qgpzh5FrE32N6GGRKgXiQfCKz8Y+sb9
	 TanRYUb9K0fUIYgAy4BOhTe0ys82KO2pLYbrU9x9fuTzoZNwwx/i2tW4YzgjidsxwV
	 0xUEjr3fB1JrCMcVYcQUkIAtpFe1OYdjO0YmiYgQAIukxhDz6JVVuLQlehSWYqYqxq
	 sb82vBemY+pYg==
Message-ID: <b8465b11-7a4a-4842-b292-6e3659bd95b3@kernel.org>
Date: Fri, 20 Mar 2026 20:59:13 +0100
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/4] serdev: add rust private data to serdev_device
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
 linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org, linux-pm@vger.kernel.org,
 driver-core@lists.linux.dev, dri-devel@lists.freedesktop.org
References: <20260313-rust_serdev-v3-0-c9a3af214f7f@posteo.de>
 <20260313-rust_serdev-v3-2-c9a3af214f7f@posteo.de>
 <2026031402-absence-graph-af5d@gregkh>
 <a9618d034bd48ec21bd26060573770a548619402.camel@posteo.de>
 <2026031422-shaded-matchbook-5078@gregkh>
 <fa25ed4ff4688a40bd601d695804def772e47af9.camel@posteo.de>
 <2026031447-margarita-untamed-e976@gregkh>
 <9e07a53053d1dd75a4ebe94aaa06e2279ef3701d.camel@posteo.de>
 <2026032048-curtly-refold-e4df@gregkh>
 <4f4c09d683023df9daef89ca634b17b5c16625f7.camel@posteo.de>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <4f4c09d683023df9daef89ca634b17b5c16625f7.camel@posteo.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/20/26 6:13 PM, Markus Probst wrote:
> This is unique for a bus device.
> 
> A class device has its own Data (e. g. PwmOps), i. e. it will only be
> registered after this Data has been initialized by the driver.
> 
> The receive_buf callback on the serdev device on the other hand must
> happen on the drvdata, as there is no place to store its own Data.
> 
> The drvdata is only available at the end of the probe in Rust.

In other words, devm_serdev_device_open() relies on the driver having its
private data set before this is called, since once devm_serdev_device_open() has
been called, the driver's receive_buf() callback may be called.

So, in C it is the driver's responsibility to do things in the correct order, in
Rust we want to make sure the driver can't do it out of order in the first place.

I'm still not sure whether the current approach is the best option. For
instance, we could also solve this with a separate callback. (Wasn't this even
what you had in a previous version?)
