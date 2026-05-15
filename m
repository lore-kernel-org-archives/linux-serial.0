Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF41B377543;
	Fri, 15 May 2026 06:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778825416; cv=none; b=gTPX6liOPPFkpJkfsmXQYUxufeaOTkHf9/7jh/C8L3SW3ETr8j1dlAEWa8NPObV2HXFHmI3WfjN0545oFuqfTM9g4OXL16kDhqLA3d8OCCkMpRfdZSR9EeWI9TXTgAKA1tAaF4DWXMN8reT0LEugn0jhkhpnZm6NQzkIa5AfGxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778825416; c=relaxed/simple;
	bh=SjoK1qjs7sLak2FsW4gIQNCIy+na8honronJmYB2OcA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i9Ymx3Jcz42VETer3VMjFoBm9hJ7HWZiT22PhHbzSuG/VcG70gcojBw54p7Im7HoRPHcrXyZ9cYv3n8PdQeiNRN1HFsB1S+GotR59I1zEVWuY4ABE8BNs8v/rycdYD9qJevvVHevkiX9zfWNws3RIDkBlsnt7QHlm3bn7auZPiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=c6cXaJHO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KBqaou1O; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="c6cXaJHO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KBqaou1O"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3DB161400034;
	Fri, 15 May 2026 02:10:14 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Fri, 15 May 2026 02:10:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1778825414; x=1778911814; bh=P4BiJwiEv/
	Wuty9pN0S6WSrWRFrDwKEVgM0QWU1+1Tc=; b=c6cXaJHOswPef6HMrnIzYUMyMy
	igIf7oUh1Dio7xHGte9ZbWFOuDSrHfOaIuRzc3Fenl+aLCWHVcR+tYPOdLdN+/Hd
	I8GFdIp/IOoXZ+Aju2TVpcIOIniGIP1X1OqNH4DiJL2NU8D4ifrf1a3wqOUrp2gu
	5vs03ha1av9dzcngIMW1lFkb2o6RFdYH8Vff8kk6Wd2jlBbsi9IbqMKHSKUprfNN
	iuyHCg1Xk8aZj++WS+rNPx5OdEgsYD8T+vKAHh4SMKiu0l/+QNpz+DjQnBFu0JPE
	h7ftSd0XV/DvuPVGdaWHhBqz21jpp7iuAbdG+xVw3HPprZhKpff/gPxV/0Nw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1778825414; x=1778911814; bh=P4BiJwiEv/Wuty9pN0S6WSrWRFrDwKEVgM0
	QWU1+1Tc=; b=KBqaou1OyK+Flu/6H6IcO4+Had8+vHeSJ8ujNe14Qy5ik/TzAs4
	5gOILOutciUDrIq82fnMDiNQlvzX+3m5WKJPalT9dW/RVVdPL5+fIOcaHwMZmpFU
	RDGoIAJikKQL6tj0AsVn9ff4OKFw/dpXNnlJ3sRfI9/4fAga/KcMKVxDjXSDec5b
	5NT2W9HsuzB6e+EZG09nR1c3klkIODsQifJiB6P05oOaniuJ/TN9ZUWAzLDMtKnq
	3mxqcH9vGZ0vqD7HZQveV+FyHAravA3BoecDFDuFA1Lx+kq9WtJpjwZ15r996P+J
	cPaWe8DwexMCMf22tC/ZNvRtu2N/sMsPBmA==
X-ME-Sender: <xms:xLgGavrVIU4IvCSPwEG2JlShShGqf-R7sbJbwKzy2msBhe1zVTjTrw>
    <xme:xLgGahluFb16AvVILajHo2a7ZlYQs5B_aiG8nf2qpiLnLknoBz1TKcDdNUXD4FPkB
    C1nAchb5n4oG_xNcBqd-MCWLZ-o9VQo0os9oftPJXod-RxO>
X-ME-Received: <xmr:xLgGajZgvAVnlDxDjr2KHnVszE794Xwb_wF9zI7DxDbflan_5zavvP3avDtwm2iN3VerqiKjvfM88ieXk8tm-Dx_WA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduvdelieegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpefirhgvghcumffjuceoghhrvghgsehkrhhorghhrdgtohhmqeen
    ucggtffrrghtthgvrhhnpeehgedvvedvleejuefgtdduudfhkeeltdeihfevjeekjeeuhf
    dtueefhffgheekteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhl
    fhhrohhmpehgrhgvgheskhhrohgrhhdrtghomhdpnhgspghrtghpthhtohepudeipdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopeifudehfedtfeejgeeitdeivdesudeifedr
    tghomhdprhgtphhtthhopehpmhgvnhiivghlsehmohhlghgvnhdrmhhpghdruggvpdhrtg
    hpthhtohepmhgrrhgtvghlsehhohhlthhmrghnnhdrohhrghdprhgtphhtthhopehluhhi
    iidruggvnhhtiiesghhmrghilhdrtghomhdprhgtphhtthhopehlihhnuhigqdgslhhuvg
    htohhothhhsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidq
    shgvrhhirghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugi
    dqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvdehudek
    uddvudegvddujeesshhtuhdrgihiughirghnrdgvughurdgtnh
X-ME-Proxy: <xmx:xLgGapXYUEqhkzkHtIhwm6RnXbXCjbFuUDicbn7qRFMk6wSVxBoycQ>
    <xmx:xLgGarBnTdh-1_pRpRpVkWkhW_eGfQEj1J1_2nKF7Of9aW4ZERQ6cg>
    <xmx:xLgGagx-E_-t1YmaAOdFusSYeTWju_J3NRKEY9uc_ndgoCNR04r5Fg>
    <xmx:xLgGapZn-tP3bFmfiS4P_hO17dvM3nRzizonfH6KlbLTNHs7n45eyg>
    <xmx:xrgGahw5C-d7fjeI21VCpoZlQnivPllZ9_AkQN6wK_y1ySbKwOBaugUP>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 15 May 2026 02:10:12 -0400 (EDT)
Date: Fri, 15 May 2026 08:10:17 +0200
From: Greg KH <greg@kroah.com>
To: w15303746062@163.com
Cc: pmenzel@molgen.mpg.de, marcel@holtmann.org, luiz.dentz@gmail.com,
	linux-bluetooth@vger.kernel.org, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mingyu Wang <25181214217@stu.xidian.edu.cn>
Subject: Re: [PATCH v2] Bluetooth: hci_uart: fix UAF in hci_uart_tty_close()
Message-ID: <2026051510-elliptic-avatar-d819@gregkh>
References: <505b56bd-e5fd-4feb-a6e3-1d8269609277@molgen.mpg.de>
 <20260514151722.382161-1-w15303746062@163.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260514151722.382161-1-w15303746062@163.com>

On Thu, May 14, 2026 at 11:17:22PM +0800, w15303746062@163.com wrote:
> From: Mingyu Wang <25181214217@stu.xidian.edu.cn>
> 
> A Use-After-Free (UAF) vulnerability and a subsequent kernel panic were
> observed in hci_uart_write_work() due to a race condition between the
> initialization of the HCI UART line discipline and concurrent TTY hangup.
> 
> This issue was triggered by our custom device emulation and fuzzing
> framework (DevGen) on the v6.18 kernel. Due to the highly timing-dependent
> nature of this race condition (requiring a precise interleaving of
> TIOCVHANGUP and protocol setup), Syzkaller failed to extract a reliable
> standalone C reproducer (reproducer is too unreliable: 0.00).
> 
> The crash trace is as follows:
>   ODEBUG: free active (active state 0) object: ffff88804024e870 object type: work_struct hint: hci_uart_write_work+0x0/0x940
>   WARNING: CPU: 0 PID: 338273 at lib/debugobjects.c:612 debug_print_object+0x1a2/0x2b0
>   ...
>   Call Trace:
>    <TASK>
>    debug_check_no_obj_freed+0x3ec/0x520
>    kfree+0x3f0/0x6c0
>    hci_uart_tty_close+0x127/0x2a0
>    tty_ldisc_close+0x113/0x1a0
>    tty_ldisc_kill+0x8e/0x150
>    tty_ldisc_hangup+0x3c1/0x730
>    __tty_hangup.part.0+0x3fd/0x8a0
>    tty_ioctl+0x120f/0x1690
>    __x64_sys_ioctl+0x18f/0x210
>    do_syscall_64+0xcb/0xfa0
>    entry_SYSCALL_64_after_hwframe+0x77/0x7f
>    </TASK>
> 
> The issue arises because the workqueues (init_ready and write_work) are
> only cancelled if the HCI_UART_PROTO_READY flag is set. However, during
> the protocol initialization phase (HCI_UART_PROTO_INIT), the underlying
> protocol may schedule work. If a hangup occurs before the setup completes
> and the READY flag is set, hci_uart_tty_close() skips the cancel_work_sync()
> calls and proceeds to free the `hu` struct. When the delayed workqueue
> executes, it blindly dereferences the freed `hu` struct.
> 
> Fix this by moving the cancel_work_sync() calls outside the
> HCI_UART_PROTO_READY check, ensuring that any pending works are
> unconditionally cancelled before the hci_uart structure is freed.
> Note that hu->init_ready and hu->write_work are initialized in
> hci_uart_tty_open(), so it is always safe to call cancel_work_sync()
> on them in hci_uart_tty_close(), even if the protocol was never
> fully attached.
> 
> Fixes: 3b799254cf6f ("Bluetooth: hci_uart: Cancel init work before unregistering")
> 
> Signed-off-by: Mingyu Wang <25181214217@stu.xidian.edu.cn>
> ---
> Changes in v2:
> - Added KASAN/ODEBUG crash trace.
> - Added explanation for the absence of a standalone reproducer (highly timing-dependent race condition).
> - Added Fixes tag pointing to commit 3b799254cf6f.
> 
>  drivers/bluetooth/hci_ldisc.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
> index 275ea865bc29..566e1c525ee2 100644
> --- a/drivers/bluetooth/hci_ldisc.c
> +++ b/drivers/bluetooth/hci_ldisc.c
> @@ -544,14 +544,18 @@ static void hci_uart_tty_close(struct tty_struct *tty)
>  	if (hdev)
>  		hci_uart_close(hdev);
>  
> +	/*
> +	 * Always cancel workqueues unconditionally before freeing the hu
> +	 * struct, as they might be active during the PROTO_INIT phase.
> +	 */
> +	cancel_work_sync(&hu->init_ready);
> +	cancel_work_sync(&hu->write_work);
> +
>  	if (test_bit(HCI_UART_PROTO_READY, &hu->flags)) {
>  		percpu_down_write(&hu->proto_lock);
>  		clear_bit(HCI_UART_PROTO_READY, &hu->flags);
>  		percpu_up_write(&hu->proto_lock);
>  
> -		cancel_work_sync(&hu->init_ready);
> -		cancel_work_sync(&hu->write_work);
> -
>  		if (hdev) {
>  			if (test_bit(HCI_UART_REGISTERED, &hu->flags))
>  				hci_unregister_dev(hdev);
> -- 
> 2.34.1
> 
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- You have marked a patch with a "Fixes:" tag for a commit that is in an
  older released kernel, yet you do not have a cc: stable line in the
  signed-off-by area at all, which means that the patch will not be
  applied to any older kernel releases.  To properly fix this, please
  follow the documented rules in the
  Documentation/process/stable-kernel-rules.rst file for how to resolve
  this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
