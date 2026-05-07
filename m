Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C91AA2F8BC0
	for <linux-serial@vger.kernel.org>; Thu,  7 May 2026 07:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778139131; cv=none; b=JHLnyjDOErIFoYgaOHG2vqPnTqEaE03pRsxMoayFa+Drgb5d5aQqkO0597DBuUaMu26k7ciqXDQ2HiNjwsE0cFHPNhphV1TDP/6KrwvGaMYZV3LdomrrIsIcQZRXaJfagXPE39VN1udl7YjdFEh0+jX69WMAtcRWvUm4fdJOijM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778139131; c=relaxed/simple;
	bh=HsGMEhUZAT9fbCcg+Bq391eAyCLcB/mx8L0Lh4WnyEQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=B1GE+g8a3xYQQjTvANoH/WDOJunBq09n6u/tTQGK37r8LXxrYaIJaA/0UJuX1flU77FPgrkvrRlweRymdgsS6gkCAFS/ZHoR5otaUXK/vA+IqF0uyWNglB6c50LFQIPIzZW6vJ/KHnSweSQKZG0YnljcfAdrXVJtqzaw8Fkz4FY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JRY2/x3d; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JRY2/x3d"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778139128;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jxWlRoeKkA2ok8M69esj27UbK+Xcl6hGq3Av3kN5L/s=;
	b=JRY2/x3dxejZysdDYo6VVHuGTB9Uqm0COEQkpxqhwTob8VP+FB4YO/1YdUY+MfZQMGQoNn
	K0eMG0QJZJPMS+Xj9xVr5RDtLCzisy6Ub+JMob+DwT0OFGoL3gTg03rkhQd2RIPb3WbymZ
	iGs10T9gVKKWUqVZMTvDMpheLlnM5n0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-564-LAk7bx_PNv27gkf4SxwYWg-1; Thu, 07 May 2026 03:32:05 -0400
X-MC-Unique: LAk7bx_PNv27gkf4SxwYWg-1
X-Mimecast-MFC-AGG-ID: LAk7bx_PNv27gkf4SxwYWg_1778139125
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-48e51dc35a3so3815045e9.1
        for <linux-serial@vger.kernel.org>; Thu, 07 May 2026 00:32:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778139125; x=1778743925;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jxWlRoeKkA2ok8M69esj27UbK+Xcl6hGq3Av3kN5L/s=;
        b=MOl58vBCu8W4bOQ/ez+F1Z1TfvGE73exUzI0pOQjx8Gl9aqhhJdOMdQgukljcZRooA
         yPpbSCaO+saTgR3tJZh+aWl0ikGuJ+MPelHjt1HYKPhIaDbAuELjqZVy1lIeyvvNq6kf
         NNj7j/iYO6GXHBwsqyRMEZ94pwyL2MDHDlZP3bDoCqt14+xMMn990WQpaICmX8mltjKu
         v18C6ykheeh/sjtSckO5ZjMhXFaFez8dbVUB5YPmk+sA+0zAfPwUvQJppyZfzdVJGOiu
         G9ywoyAdMNS4bVxC7BopXLCsRTnfFrozy9CRxPkXLQK38j7FQ08YFAcilHhxeOtFg2v1
         +9Aw==
X-Forwarded-Encrypted: i=1; AFNElJ+uu0W2uMPXsLKUDXNnexcAalwveSpi9FLaSQdCXLvJrzX/0ZvD3wiNHhccW9xJxK+dx4TeMI6+X+023Us=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2hxdvAGl2q+Lk0KU/4PrWTqI7vxyr5FhQX+Ol+mlu1gc+JdqF
	xLxnUOlrTQi/VnZgvpDJv11WC1j9Z859FWhXYqPHbnlVIu0E4XVIn4E7BCSko/MAe00B1PEKvvk
	48srk0EDeKfXwZewDEvaB1x85WCqYsJAXXquIFpNP/Y2WKyUwYcseSpBpDl2TWZvVvg==
X-Gm-Gg: AeBDieuTvERVedmyXDnofphkvCRHZ7mq4qVfErcf9vzfHq64/sy9icDaPZbc2Xo0oCX
	2bM24M/ufqp5FWjt8lN57PItHC9K+i/chQ2UteFwUFLN9oBQf7S+OC3GrYwkTGJBli7TnX5Gvvt
	rugAqYgL7r24pc+EBds1DZXXNqIeGN87zKO0fvnVT9iy7LfR287VmVsO5HR5USDuKJc1JtrFxBb
	yUGltbBibh53RvyKlKc31VSMlSZ0c1Kquz3wDLkh3CYw8+vKvkDFk7pzQXFiUevLPBcdzu5TbWS
	2PeoTwp9pwlmIkSRp0+g4pVnZ3twAe47fR8+12ckYOMtLIlwPwj6MW1uWJc/7m06ISNLUHb/Gtu
	gvNXXvVKc1g605Gg2SRcdWpzZ5QNwmNO25DdDOv4leQIJ32v25N0l86Hb44SBKT1QBl3qheIyL6
	KK
X-Received: by 2002:a05:600c:a411:b0:488:af48:af11 with SMTP id 5b1f17b1804b1-48e51e08ce3mr81023565e9.1.1778139124650;
        Thu, 07 May 2026 00:32:04 -0700 (PDT)
X-Received: by 2002:a05:600c:a411:b0:488:af48:af11 with SMTP id 5b1f17b1804b1-48e51e08ce3mr81023035e9.1.1778139124218;
        Thu, 07 May 2026 00:32:04 -0700 (PDT)
Received: from [192.168.88.32] ([150.228.93.82])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e530a67dcsm50966955e9.2.2026.05.07.00.32.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 May 2026 00:32:03 -0700 (PDT)
Message-ID: <11416095-4393-4a28-a7ac-db090960c9a7@redhat.com>
Date: Thu, 7 May 2026 09:32:01 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/3] ppp: unify two channel structs
To: Qingfang Deng <qingfang.deng@linux.dev>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
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
 <c9993ee6-4023-4331-a1c1-4e30952146fe@linux.dev>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <c9993ee6-4023-4331-a1c1-4e30952146fe@linux.dev>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: a_uD9QAto9TL1kcRGkTS8Qju1cCKX7PgzTgDp64Zuw8_1778139125
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/7/26 7:53 AM, Qingfang Deng wrote:
> On 2026/5/5 19:16, Paolo Abeni wrote:
>> On 4/30/26 11:05 AM, Qingfang Deng wrote:
>>> Historically, PPP maintained two separate structures for a channel:
>>> 'struct channel' was internal to ppp_generic.c, while 'struct ppp_channel'
>>> was the public interface that drivers were required to embed. This
>>> duplication was redundant and forced drivers to manage the lifecycle of
>>> the public structure.
>>>
>>> Unify these two structures into a single 'struct ppp_channel', which is
>>> now internal to ppp_generic.c. Drivers now use a 'ppp_channel_conf'
>>> structure to specify registration parameters and receive an opaque
>>> pointer to the allocated channel.
>>>
>>> Key changes:
>>> - ppp_register_channel() and ppp_register_net_channel() now return
>>>    a 'struct ppp_channel *' instead of taking a pointer to a driver-
>>>    embedded structure.
>>> - 'struct ppp_channel_ops' methods now take the driver's 'private'
>>>    pointer directly as their first argument, simplifying driver logic.
>>> - ppp_unregister_channel() now takes the opaque pointer.
>>> - Multilink-specific fields are unified and handled via the new
>>>    configuration structure.
>>>
>>> This cleanup simplifies the driver interface and makes the channel
>>> lifecycle management more robust by centralizing allocation in the PPP
>>> generic layer.
>>>
>>> Assisted-by: Gemini:gemini-3-flash
>>> Signed-off-by: Qingfang Deng <qingfang.deng@linux.dev>
>>> ---
>>>   drivers/net/ppp/ppp_async.c      |  51 +++++-----
>>>   drivers/net/ppp/ppp_generic.c    | 161 +++++++++++++++----------------
>>>   drivers/net/ppp/ppp_synctty.c    |  51 +++++-----
>>>   drivers/net/ppp/pppoe.c          |  34 ++++---
>>>   drivers/net/ppp/pppox.c          |   4 +-
>>>   drivers/net/ppp/pptp.c           |  40 ++++----
>>>   drivers/tty/ipwireless/network.c |  30 +++---
>>>   include/linux/if_pppox.h         |   2 +-
>>>   include/linux/ppp_channel.h      |  49 ++++++----
>>>   net/atm/pppoatm.c                |  61 ++++++------
>>>   net/l2tp/l2tp_ppp.c              |  34 ++++---
>>>   11 files changed, 271 insertions(+), 246 deletions(-)
>> This patch is IMHO a bit too big and should be split. Also this kind of
>> refactor looks very invasive and potentially regression prone. I think
>> it should include a signficant self-test coverage increase.
> This is indeed too big. But how do I split it without breaking the build?

This is indeed a good question, but I'm really unable to give you a good
answer without allocating to this topic much more time than I have
available.

I think that the (indeed smallish) mtu changes could easily go in a
separate patch.

You could try introducing the struct and/or variables renaming
separately, with no actual functional change, i.e.

- one patch to rename ppp_channel -> ppp_channel_conf
- one patch to rename channel -> ppp_channel
(possibly adjust accordingly the variables name if can done mechanically)

no idea if the end result would be more palatable, but possibly worth a try.

/P

