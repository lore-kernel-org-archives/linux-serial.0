Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0855230CD9E
	for <linux-serial@vger.kernel.org>; Tue,  5 May 2026 11:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777979805; cv=none; b=XY8Uo/8eVtrn6IsdrZPtWkBFTFzth8RvGnra01wXGD33A9K2DBXB0sT6e/i8kS8CS/RgXnkc/cr0qc8zij0WFcmhQ6z+SLeUIvVDTF845tXNy7wDIbMbJ3G5q6gAAb8CS7GxHJzNdWt/naUgVgm9hibfoLPRtDArb7aQp4u/TBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777979805; c=relaxed/simple;
	bh=bjXwy8ZUBPC6//gkl3zE6N9hnucx6t+HiWYx6T30AZk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Nt/2PnVBOxiwFe6ThBQ5IiRmCs0/i7P/09aEZDYkJmMluqpWhGT1oVJ5jWxaQY+uIHjbbjY0w+bjsVP7SbQsMhGixZa9p7uGi8xuqQZp9G3wCGhryukcC38JLISgXorVTcnURH25KMG/4gL+4Lp1dlsOoq8YczDkMkxVi6JPW4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YzDLcxWe; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YzDLcxWe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777979801;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gKLj022WQBJqvFpf4FNV0Kj7LtHJ8BU+/iBu6AWWa9I=;
	b=YzDLcxWeVVqmf3b2lLuNqr0z0lpQM3es8kEILlXFFNwOhO6voBUusm8LXps966irF0Dtl5
	s+j6iaadwvUqHgsIa4rvWR3kETuWQ9fCLxplNnXwZ83ZJxq+tARK1BmpUibhZjIX+1PVn0
	OqcFRl0WeULpNatMRhd8/akNFElJLEI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-60-ffSpdvxQN36ecu5RbzwE_g-1; Tue, 05 May 2026 07:16:39 -0400
X-MC-Unique: ffSpdvxQN36ecu5RbzwE_g-1
X-Mimecast-MFC-AGG-ID: ffSpdvxQN36ecu5RbzwE_g_1777979799
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4836abfc742so45749925e9.0
        for <linux-serial@vger.kernel.org>; Tue, 05 May 2026 04:16:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777979798; x=1778584598;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gKLj022WQBJqvFpf4FNV0Kj7LtHJ8BU+/iBu6AWWa9I=;
        b=MAk6Q/sY0tkJKCCZM0XNR/ddmx5+vmR6oLVqSNP70A3WqKfXI37xwlUriFbCgCDVEs
         KbBrNM++AcygFTWla8M+Nj8ZcXb6MrpSxhocXu/IosFMMY09L8qtLiVPIbFMCTXOkriF
         ih3gIqKldXzxoDQpxewuGNOFcpOD3RZaJl6GcovK4Yuz8qyt6TDJO9pQtfVgzsKahYJL
         N4+mgDO3+hznM5CT2G1VZvi6v22FrjTZ6rjGahULcrH41p8DFjm9KORWsj+vtUVFMVWu
         qC1yh1CNbf07jd2jSB6z4M5Kua/NA3QeTdeW6mgEXzw1ltEN2WWcvFelBXkl6rdiJQbF
         TWyg==
X-Forwarded-Encrypted: i=1; AFNElJ/m/91VvfCqWSNAjCFw2UR6IXIPLvGGc7ejKhS/WYwBsRQ3QetGFe+X1om/0BL/oib7i5CNpSSiroTY+8s=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywrv6Vo4xEel4CN7hNomWkXN5Fn7QhFtzmRoaHCtELpoN/ff3CD
	SEoTgcn0hbjNjUWOSHxB0aT1oVXyxK6UdUniFfkeOEwrrBoV8gbc2vF3Ityu4ApwqDCFz8Lom4b
	gy5C7qyteeIqGgwleZ+AtT20sJre9FP3SOaCgCbPMflYDJ1yibY+XIixzuNvgJj3FjA==
X-Gm-Gg: AeBDietzF8TTuaHel1xJOhrgMOpHMq05Rt1qabRg33ZntHB/++sTlqC1iyBaa5SUvZE
	pf9dGAG3REImIR1SfH1Is3ZL8bQRWO4sGizJ96HUhDj3w4e/4yx1t9jK/7QoyuwwWsIsKePoygg
	iR7cNtLjUJkkJjphSZ8qE3GW74nHR0VsGAG0olY9sYm90BCs3Ff5LFkjyBYh9vP7nXRSewc9JAC
	8cLqNFTmJ46+kSV4eihD7bRxCaW+4NBeWQkYQOos9dKcI6ftB1/mh9D33s2YWcpcr0Ue1HJ/qZ5
	v0w40kCQ7gR+GUyYnJ/REjU4hVGrajmrtdZG5+56zAHTC3JcAv/0EKIP/86VZxNDWNS+44EpHuY
	Cq8j8C2+JyozB7H6qeznDEQTIWWj+fVCf4cw/sZJHx4lGLFHvwp3BuhI8nNj/143jv5Q=
X-Received: by 2002:a05:600c:5296:b0:488:8bdd:cfcc with SMTP id 5b1f17b1804b1-48d17fe008emr38457175e9.0.1777979798476;
        Tue, 05 May 2026 04:16:38 -0700 (PDT)
X-Received: by 2002:a05:600c:5296:b0:488:8bdd:cfcc with SMTP id 5b1f17b1804b1-48d17fe008emr38456175e9.0.1777979797935;
        Tue, 05 May 2026 04:16:37 -0700 (PDT)
Received: from [192.168.88.32] ([212.105.155.47])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48d14786d8csm17752945e9.0.2026.05.05.04.16.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 May 2026 04:16:37 -0700 (PDT)
Message-ID: <590d7931-02b0-45d6-8f43-ef909c9bde89@redhat.com>
Date: Tue, 5 May 2026 13:16:34 +0200
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
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260430090532.244758-2-qingfang.deng@linux.dev>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: RC8YRlvjjSNB2ywGMLuYGV4K25hEwwwl4_PL-ivPPbU_1777979799
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/30/26 11:05 AM, Qingfang Deng wrote:
> Historically, PPP maintained two separate structures for a channel:
> 'struct channel' was internal to ppp_generic.c, while 'struct ppp_channel'
> was the public interface that drivers were required to embed. This
> duplication was redundant and forced drivers to manage the lifecycle of
> the public structure.
> 
> Unify these two structures into a single 'struct ppp_channel', which is
> now internal to ppp_generic.c. Drivers now use a 'ppp_channel_conf'
> structure to specify registration parameters and receive an opaque
> pointer to the allocated channel.
> 
> Key changes:
> - ppp_register_channel() and ppp_register_net_channel() now return
>   a 'struct ppp_channel *' instead of taking a pointer to a driver-
>   embedded structure.
> - 'struct ppp_channel_ops' methods now take the driver's 'private'
>   pointer directly as their first argument, simplifying driver logic.
> - ppp_unregister_channel() now takes the opaque pointer.
> - Multilink-specific fields are unified and handled via the new
>   configuration structure.
> 
> This cleanup simplifies the driver interface and makes the channel
> lifecycle management more robust by centralizing allocation in the PPP
> generic layer.
> 
> Assisted-by: Gemini:gemini-3-flash
> Signed-off-by: Qingfang Deng <qingfang.deng@linux.dev>
> ---
>  drivers/net/ppp/ppp_async.c      |  51 +++++-----
>  drivers/net/ppp/ppp_generic.c    | 161 +++++++++++++++----------------
>  drivers/net/ppp/ppp_synctty.c    |  51 +++++-----
>  drivers/net/ppp/pppoe.c          |  34 ++++---
>  drivers/net/ppp/pppox.c          |   4 +-
>  drivers/net/ppp/pptp.c           |  40 ++++----
>  drivers/tty/ipwireless/network.c |  30 +++---
>  include/linux/if_pppox.h         |   2 +-
>  include/linux/ppp_channel.h      |  49 ++++++----
>  net/atm/pppoatm.c                |  61 ++++++------
>  net/l2tp/l2tp_ppp.c              |  34 ++++---
>  11 files changed, 271 insertions(+), 246 deletions(-)

This patch is IMHO a bit too big and should be split. Also this kind of
refactor looks very invasive and potentially regression prone. I think
it should include a signficant self-test coverage increase.

> @@ -391,9 +396,9 @@ ppp_async_init(void)
>   * The following routines provide the PPP channel interface.
>   */
>  static int
> -ppp_async_ioctl(struct ppp_channel *chan, unsigned int cmd, unsigned long arg)
> +ppp_async_ioctl(void *private, unsigned int cmd, unsigned long arg)
>  {
> -	struct asyncppp *ap = chan->private;
> +	struct asyncppp *ap = private;
>  	void __user *argp = (void __user *)arg;
>  	int __user *p = argp;
>  	int err, val;

Minor nit: reverse christmas tree above

> @@ -2985,16 +2983,13 @@ char *ppp_dev_name(struct ppp_channel *chan)
>   * This must be called in process context.
>   */
>  void
> -ppp_unregister_channel(struct ppp_channel *chan)
> +ppp_unregister_channel(struct ppp_channel *pch)
>  {
> -	struct channel *pch = chan->ppp;
>  	struct ppp_net *pn;
>  
>  	if (!pch)
>  		return;		/* should never happen */
>  
> -	chan->ppp = NULL;
> -

Sashiko says:

Could this specific ordering introduce a race condition that might lead
to a use-after-free?
If userspace has a file descriptor attached to this channel, it can
concurrently invoke the PPPIOCCONNECT ioctl. Because
ppp_disconnect_channel()
clears pch->ppp and removes the channel from its current unit before
pch->file.dead is set to 1, the concurrent ioctl could observe
pch->file.dead == 0.
This would allow ppp_connect_channel() to successfully attach the dying
channel to a new PPP unit. Once ppp_unregister_channel() completes and
frees the channel, the new PPP unit would retain a pointer to the freed
memory in its channels list, which might be accessed during a later
packet transmission via ppp_push().

> @@ -215,7 +210,8 @@ static void pppoatm_push(struct atm_vcc *atmvcc, struct sk_buff *skb)
>  		    !memcmp(skb->data, &pppllc[LLC_LEN],
>  		    sizeof(pppllc) - LLC_LEN)) {
>  			pvcc->encaps = e_vc;
> -			pvcc->chan.mtu += LLC_LEN;
> +			ppp_channel_update_mtu(pvcc->chan,
> +					       atmvcc->qos.txtp.max_sdu - PPP_HDRLEN);

Does the above introduce a functional change? At very least some comment
needed. Also possibly better move the update_mtu wrapper to a pre-req patch.

> @@ -221,7 +221,7 @@ static void pppol2tp_recv(struct l2tp_session *session, struct sk_buff *skb, int
>  		struct pppox_sock *po;
>  
>  		po = pppox_sk(sk);
> -		ppp_input(&po->chan, skb);
> +		ppp_input(po->chan, skb);

Sashiko says:

Does decoupling the channel lifetime from the driver structure introduce
a use-after-free when receiving packets?
Previously, the struct ppp_channel was embedded in struct pppox_sock,
meaning its lifecycle was safely tied to the socket's refcount. Now that
po->chan is dynamically allocated and freed during pppox_unbind_sock()
via ppp_unregister_channel(), it seems possible for pppol2tp_recv() to
access freed memory.
Since pppol2tp_recv() runs locklessly in softirq context while holding
only rcu_read_lock() and a socket reference, can it observe the
PPPOX_BOUND state and dereference po->chan just after it was freed on
another CPU?

/P

