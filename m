Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55DEC38A701;
	Fri, 28 Aug 2026 10:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787914320; cv=none; b=lL8CQsrggWT6C+OpFKxxkUD7IeBwWIECOEm9S8/+Hvx3FL2AbnQImeVVIAqqZnXJm0/mMCX1mM1MPo3Yi2fc9ODHqJPbndHE/8wQ1+lOD5hQ9CeQMPxY2zr80C1DGG4rtrrmErYAOxxFLPymKjVzUYnbdqBOl2/T6iLLJlQXgSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787914320; c=relaxed/simple;
	bh=KnJ0xS4wtKF41uZcB5P0f1h7kIrwaBmbT9mcXlzZ+0s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H3ve36mgFqdMQL1JYdtLQJ+ytBAdo2deq62L7gwi415oaFl3VmaBEfL2pqCk7craBbKZX5YYTvZZg1LNsU4vBIw+33I8ie/A9D1n1G+alpA7tEonVOiStaAt7E5fGW5mwRzk3eqXqe17H5kPH7uWvlBHqrqNWckJUieDGU4HY4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MlgSrKfR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MlgSrKfR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 348671F000E9;
	Fri, 28 Aug 2026 10:51:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787914318;
	bh=8QR+mV84eUADKcRuIlSxXNiDLsii5HShOwXWR6BkAu0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=MlgSrKfRAXCvPPkD46t3kXwV2P8imQHSgQRHIWBUvSk3Uc9Kk0yBbHBIO6jUWKH04
	 XWYFyVeqQC2Xbk7/12BcoJEWTaWrM6Nszjm03OleYjCtw+5Amhu+3yWD4kV7u1T9rT
	 0k9hipGZIKXRV7XPkvBcb4cjpKo0smjc48lPAP98=
Date: Fri, 28 Aug 2026 12:50:17 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Farhad Alemi <farhad.alemi@berkeley.edu>
Cc: Jiri Slaby <jirislaby@kernel.org>, falemi@asu.edu,
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [BUG] WARNING: refcount bug in gsm_mux_net_start_xmit
Message-ID: <2026082821-leverage-ninth-bf28@gregkh>
References: <CA+0ovCh9MQE6BZD-8vqWMcrVS8Bj-tYY47HqeASvE7_b9QP-ZQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+0ovCh9MQE6BZD-8vqWMcrVS8Bj-tYY47HqeASvE7_b9QP-ZQ@mail.gmail.com>

On Fri, Aug 28, 2026 at 05:53:36AM +0000, Farhad Alemi wrote:
> Hello,
> 
> As part of the kernel research at ASU's SEFCOM
> lab, we hit the crash below. Crash reports can be found here:
> 
>   https://github.com/farhad-alemi/public_bug_reports/tree/main/199-warning-refcount-bug-in-gsm-mux-net-start-xmit/
> 
>   refcount_t: addition on 0; use-after-free.
>   WARNING: lib/refcount.c:25 at refcount_warn_saturate+0x9f/0x110
> lib/refcount.c:25, CPU#0: kworker/u8:1/14
>   Workqueue: ipv6_addrconf addrconf_dad_work
>   Call Trace:
>    refcount_warn_saturate+0x9f/0x110 lib/refcount.c:25
>    __refcount_inc include/linux/refcount.h:366 [inline]
>    refcount_inc include/linux/refcount.h:383 [inline]
>    kref_get include/linux/kref.h:45 [inline]
>    muxnet_get drivers/tty/n_gsm.c:3938 [inline]
>    gsm_mux_net_start_xmit+0x3af/0x440 drivers/tty/n_gsm.c:3951
>    __netdev_start_xmit include/linux/netdevice.h:5368 [inline]
>    dev_hard_start_xmit+0x23b/0x620 net/core/dev.c:3904
>    __dev_queue_xmit+0x160b/0x3250 net/core/dev.c:4831
>    ip6_finish_output2+0xfd4/0x19b0 net/ipv6/ip6_output.c:136
>    mld_sendpack+0x820/0xe00 net/ipv6/mcast.c:1855
>    ipv6_mc_dad_complete+0x85/0x470 net/ipv6/mcast.c:2279
> 
> Our reproducer.c is available upon request.

Please read the mailing list archives for why you shouldn't be worrying
about this file unless you have access to the real hardware.

Also, this required root to trigger, right?

thanks,

greg k-h
