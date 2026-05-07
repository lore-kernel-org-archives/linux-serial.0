Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 852B3394492
	for <linux-serial@vger.kernel.org>; Thu,  7 May 2026 09:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778144427; cv=none; b=t+gQmvrUp9DPT8yUzCJ2V/WLIrsuoTHrJWO3Tg3y7u+qmrJCQMSXu4b1HWi4TRKwXfiEfJlZKdCLQjCAjZpDV5x1CQFSHdD2j8gROWFR4cAuxpL9AoAiTN8c5lYzzDe5j5Du1Ui8fMdw4m5Wcv0jhv7acXFK6EF10MQVawuwauU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778144427; c=relaxed/simple;
	bh=axho4yXyXmif/8PIcen42f/ju/wVpDekXPd1BTpmvtI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t6ANWmMmyo47M64Z18IZ9XWcHBwzhNFNFOGR87Y82NDP9cfB51SfGCBcOtTcFKC5k40xbbd0a2QCRFAu+LliLHQ6FH+ahkdnCbHegSDAjlBR8v3ibo2RHoNnrj+yaHW1qUYR3pLNmDdVKHp8Ri+IePYjcznY5BxIYBQeO8rAO70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FUno6wuJ; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FUno6wuJ"
Message-ID: <6ad7864c-b320-4b40-b627-41a986d60ecd@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778144407;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ezFd5wwZ/Wt8ZONPaERbTtUkc3/tI2+40VyZTVt60A0=;
	b=FUno6wuJ//4BbEDcjHNSOtV1n4fI/D7saoOHnl1hrn4XGYMuqDAC/cPa+/U7W7AdP7tree
	TT0o293xYymaNfwuXcTVzbnrVv+0HSkk7bSs/wzdIxOisKFxHp01UYeAUL9emlfZDdf1vw
	IxhbsB2GlW1Vgj1BMa39zitz4/NwEvo=
Date: Thu, 7 May 2026 16:59:42 +0800
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next 2/3] ppp: unify two channel structs
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Jiri Kosina <jikos@kernel.org>,
 David Sterba <dsterba@suse.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Chas Williams <3chas3@gmail.com>,
 Simon Horman <horms@kernel.org>, James Chapman <jchapman@katalix.com>,
 Kees Cook <kees@kernel.org>, Taegu Ha <hataegu0826@gmail.com>,
 Guillaume Nault <gnault@redhat.com>, Eric Woudstra <ericwouds@gmail.com>,
 Arnd Bergmann <arnd@arndb.de>,
 Dawid Osuchowski <dawid.osuchowski@linux.intel.com>,
 Breno Leitao <leitao@debian.org>, linux-ppp@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org, linux-atm-general@lists.sourceforge.net
References: <20260430090532.244758-1-qingfang.deng@linux.dev>
 <20260430090532.244758-2-qingfang.deng@linux.dev>
 <590d7931-02b0-45d6-8f43-ef909c9bde89@redhat.com>
 <c9993ee6-4023-4331-a1c1-4e30952146fe@linux.dev>
 <20260507074051.mqO5DaWL@linutronix.de>
 <a4216fa5-9576-4836-b202-d9c35f0e546a@linux.dev>
 <20260507084645.mpK7rdPn@linutronix.de>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Qingfang Deng <qingfang.deng@linux.dev>
In-Reply-To: <20260507084645.mpK7rdPn@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2026/5/7 16:46, Sebastian Andrzej Siewior wrote:
> On 2026-05-07 16:33:36 [+0800], Qingfang Deng wrote:
>> On 2026/5/7 15:40, Sebastian Andrzej Siewior wrote:
>>> On 2026-05-07 13:53:30 [+0800], Qingfang Deng wrote:
>>>>> This patch is IMHO a bit too big and should be split. Also this kind of
>>>>> refactor looks very invasive and potentially regression prone. I think
>>>>> it should include a signficant self-test coverage increase.
>>>> This is indeed too big. But how do I split it without breaking the build?
>>> The current ppp tests would yell if you accidentally broke something?
>> By "breaking the build" I meant compile-time errors (due to API changes).
> If this change would flip the logic somewhere and as such break ppp at
> runtime.
> Would the existing test suite be able to catch it?


The current self-test only covers PPP async and PPPoE, and that's why 
Paolo suggests more self-tests.

