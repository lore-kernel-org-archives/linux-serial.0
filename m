Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81D353C1F2B;
	Fri, 28 Aug 2026 06:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787896817; cv=none; b=m3uM/YUtYvhNtNqpiRO8IqpJ/I3DwqiemLtNuiHQ1ufvlJ2oIXtvkTNGvb5cCLsf9E5chxYGEnBtg7FirK3VCDN3NZ7CJufpw9p4GNGhtczvn8J3JMO7ctnpGpMonF38ShNuz8hNp25C2yxqH41gIbG08biQj5ohltD1/0vUV0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787896817; c=relaxed/simple;
	bh=TYNtCJxRTEjVfzdgu91FApCO0OdaYs2rLidvNAVtCTw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iiL9LUl9Vx2XxvYy9gM18VrbgE1qEgkUA6cYAxN+UHpoHepypAuGve57oPfCvEhvVgmkpZRniJf7LX4gJQEDKdn1URbam3aJm9WM44wm1Nt9L1XrMLDczPU9ge8OOyu+Lqf1Cc4ALds6azmdyHTm+g5gsCvcjWpGUacG4ZklHzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yuExLeGK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yuExLeGK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E6D21F000E9;
	Fri, 28 Aug 2026 06:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787896816;
	bh=KWjFcRbgRcV6Ua2mslc2KqefmejrKjwQa0AVpoYm3OI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=yuExLeGK/2eH5zMAvvsFMw36Qlc0qaM3OVgJGHwD0GUtuBnei8pPBRcLN4uRUbviV
	 cIrIG8nQ4T2QatGp8T5X4N6xq1US3VaXgPAua8t6CnPpEK7LrDmn7v6lew2qLLc1HC
	 auzjxuKa/8Qmu4Z8r8zjTjrFyL9TClYyU97K24Ck=
Date: Fri, 28 Aug 2026 08:00:14 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Farhad Alemi <farhad.alemi@berkeley.edu>
Cc: Jiri Slaby <jirislaby@kernel.org>, falemi@asu.edu,
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [BUG] WARNING: refcount bug in gsm_mux_net_start_xmit
Message-ID: <2026082804-penny-pouncing-cdad@gregkh>
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
> 
> Happy to test a patch if that would help.

Again, please sned such patch.
