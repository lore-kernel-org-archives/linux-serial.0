Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 564B1330B0B
	for <linux-serial@vger.kernel.org>; Thu,  7 May 2026 05:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778133240; cv=none; b=JgEG7JMZftAtPbO3rxhhHppl8gT1zIHMh6qApW+0avcVNNPBw93PQkmZQeo8N5XSqJMYE+smvNQx+dM97E0/KEoT1GZe7rY0BIKCcdow5d7cW+FZZ4LJTNyQGrBNvVpMFySA8d3vrir34nIGbsEeHUpyVDiNv3U9oylXEinKcFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778133240; c=relaxed/simple;
	bh=1LrW5qCIbYeb/bX6ybBGiV+9rPWAOJqaKbnrQSaIt9A=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=p7c7eXIHN5/CpLgNWOB30PXoTEElywtLIyvZpIbA9+JV0/X0SpvcrALft0J0jykuHr4mkkpvBRxhJ41VH0E2NiaPkk7GrJLevECtBgWT1auScecMtMD0qU28rAPKZP/YauEmyRvigTOPojmT1ZXlji1r0VeCG5fsFPon+wDK4SA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Vgr/HUtB; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Vgr/HUtB"
Message-ID: <c9993ee6-4023-4331-a1c1-4e30952146fe@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778133225;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VbGSu/85g0XblWRuECFeslO9kenoVrjTmkH45UYo96U=;
	b=Vgr/HUtB+VnkFQX0dQtT03258riDXLlIM9m/PeTvG3tf1tRlGkqkkuu0qewifW6W/hABie
	yJESxF+JatKhHcsZbl7utDYkhuEBB4/Li+Tn8KWQc6cIAOvILsmQtsBXgEsMMx1LyBo7k6
	J95Oa8iIXKmPJJu8cCe5YBss+U9bqEc=
Date: Thu, 7 May 2026 13:53:30 +0800
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next 2/3] ppp: unify two channel structs
To: Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Jiri Kosina <jikos@kernel.org>,
 David Sterba <dsterba@suse.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Mitchell Blank Jr <mitch@sfgoth.com>,
 Chas Williams <3chas3@gmail.com>, Simon Horman <horms@kernel.org>,
 James Chapman <jchapman@katalix.com>, Kees Cook <kees@kernel.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Taegu Ha <hataegu0826@gmail.com>, Guillaume Nault <gnault@redhat.com>,
 Eric Woudstra <ericwouds@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
 Dawid Osuchowski <dawid.osuchowski@linux.intel.com>,
 Breno Leitao <leitao@debian.org>, linux-ppp@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org, linux-atm-general@lists.sourceforge.net
References: <20260430090532.244758-1-qingfang.deng@linux.dev>
 <20260430090532.244758-2-qingfang.deng@linux.dev>
 <590d7931-02b0-45d6-8f43-ef909c9bde89@redhat.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Qingfang Deng <qingfang.deng@linux.dev>
In-Reply-To: <590d7931-02b0-45d6-8f43-ef909c9bde89@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2026/5/5 19:16, Paolo Abeni wrote:
> On 4/30/26 11:05 AM, Qingfang Deng wrote:
>> Historically, PPP maintained two separate structures for a channel:
>> 'struct channel' was internal to ppp_generic.c, while 'struct ppp_channel'
>> was the public interface that drivers were required to embed. This
>> duplication was redundant and forced drivers to manage the lifecycle of
>> the public structure.
>>
>> Unify these two structures into a single 'struct ppp_channel', which is
>> now internal to ppp_generic.c. Drivers now use a 'ppp_channel_conf'
>> structure to specify registration parameters and receive an opaque
>> pointer to the allocated channel.
>>
>> Key changes:
>> - ppp_register_channel() and ppp_register_net_channel() now return
>>    a 'struct ppp_channel *' instead of taking a pointer to a driver-
>>    embedded structure.
>> - 'struct ppp_channel_ops' methods now take the driver's 'private'
>>    pointer directly as their first argument, simplifying driver logic.
>> - ppp_unregister_channel() now takes the opaque pointer.
>> - Multilink-specific fields are unified and handled via the new
>>    configuration structure.
>>
>> This cleanup simplifies the driver interface and makes the channel
>> lifecycle management more robust by centralizing allocation in the PPP
>> generic layer.
>>
>> Assisted-by: Gemini:gemini-3-flash
>> Signed-off-by: Qingfang Deng <qingfang.deng@linux.dev>
>> ---
>>   drivers/net/ppp/ppp_async.c      |  51 +++++-----
>>   drivers/net/ppp/ppp_generic.c    | 161 +++++++++++++++----------------
>>   drivers/net/ppp/ppp_synctty.c    |  51 +++++-----
>>   drivers/net/ppp/pppoe.c          |  34 ++++---
>>   drivers/net/ppp/pppox.c          |   4 +-
>>   drivers/net/ppp/pptp.c           |  40 ++++----
>>   drivers/tty/ipwireless/network.c |  30 +++---
>>   include/linux/if_pppox.h         |   2 +-
>>   include/linux/ppp_channel.h      |  49 ++++++----
>>   net/atm/pppoatm.c                |  61 ++++++------
>>   net/l2tp/l2tp_ppp.c              |  34 ++++---
>>   11 files changed, 271 insertions(+), 246 deletions(-)
> This patch is IMHO a bit too big and should be split. Also this kind of
> refactor looks very invasive and potentially regression prone. I think
> it should include a signficant self-test coverage increase.
This is indeed too big. But how do I split it without breaking the build?
