Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F92634CFDA
	for <linux-serial@vger.kernel.org>; Thu,  7 May 2026 08:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778142849; cv=none; b=P60tIOpcKZa+KNCoRo0Bcl4xY3tMv+WRt+zR1cMzYF1NteMw2gxHkkQYLYjhFZzZRy27pdGux4ZKzxZ+bDtHY0ozA4ISXvMC7Pw1sPCiUb1zkzgvPOXPqUW67/5mH/E665i4J61Pp6Z9Fq535Shj74agcPcbgKTWA5etYgjNPvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778142849; c=relaxed/simple;
	bh=pvb1MHQLF11MJXf8+zcWPixcW83m0j26gAXbrydYl7U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F8FAsh7KvII+zVD1qpAQ5aj9xaD28QQ/87IsNlSK4y18Q5phYnV6EsgVZpNMC1Y3IPLvSpwHc+IkW0YkmjPzvZxCZGk2he4UKqmU7BxuaXD7De3vqv9nUMHDtRpzNvFWeEhmTGVEb5tthvaWg0jq0e+IsQ/wRzugS/Au8GFjrHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FPzeOtX/; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FPzeOtX/"
Message-ID: <a4216fa5-9576-4836-b202-d9c35f0e546a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778142832;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pvb1MHQLF11MJXf8+zcWPixcW83m0j26gAXbrydYl7U=;
	b=FPzeOtX/dwacWuJxi1CtVFm+UdCNOBga4/j0JsjDwEFJLiZquZCWytLqY8xJ+E+HaMmBwU
	oYAmTGtoLVwa3OhJBWMVG/ljX9nWUxNkAF8b+6E6Ql41kgGBQxqyaPS5BuyA8zlqjMtD45
	yT+ZJ9owbVJ8zwyG33jWdqt1Yw/nNMo=
Date: Thu, 7 May 2026 16:33:36 +0800
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
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Qingfang Deng <qingfang.deng@linux.dev>
In-Reply-To: <20260507074051.mqO5DaWL@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2026/5/7 15:40, Sebastian Andrzej Siewior wrote:
> On 2026-05-07 13:53:30 [+0800], Qingfang Deng wrote:
>>> This patch is IMHO a bit too big and should be split. Also this kind of
>>> refactor looks very invasive and potentially regression prone. I think
>>> it should include a signficant self-test coverage increase.
>> This is indeed too big. But how do I split it without breaking the build?
> The current ppp tests would yell if you accidentally broke something?
By "breaking the build" I meant compile-time errors (due to API changes).
