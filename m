Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A177042E019;
	Tue, 30 Jun 2026 14:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782829317; cv=none; b=X9MpJSR2nAFEnNSQsLItgK/yfL1t6/6jNz2Ss2mGEUmz1fo7WrV4Qw9Yg3OcPvC4RFOCtE3c8bcRATh9nt7FFMhZApbCdagS/y6KxJogHPx69vdIIB/n9Q4c31J7vUpDieRdGcvFxkHTQdl8EeV/XmoqbF6+hJicp9ispQXstw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782829317; c=relaxed/simple;
	bh=48oppZkuFVbRBYdzWtNYjZxjdlSAMOmcINsfMBrqk1w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eSXH4y0MfenPM5JSlGMVkydWXedUUL1TcLAWdBihwJA0FZPFO4H3j7D2djpmD5R52yS3RnLryI4Imu9tIyAtHE/rSOYa0vtk42xxzEnL54gx/M0JB4Ip9behcWCJhW4z755aAluN7SbD6qCmyRN/fZfujlwUblkQJZKpCzhUJIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eSKMFciA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eSKMFciA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E4861F00A3D;
	Tue, 30 Jun 2026 14:21:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1782829313;
	bh=h+pjphyu3G6bWxWuW5uuvJoxE5ahv9qJU1UuTOXIyGc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=eSKMFciAuxIe91Y7JXIh0EYYAbqywPzMiW/364tXDl+gZ3tNRNFDvIyIylocwk9tB
	 +KELA1Mi0k0lDU3kyodYYCqn7vgcO6XHeFQyuJNeP7R/qjXkBL6m+oGsBdhVh0Havs
	 oSzf+IEOPKd9LAuEfpeJR4Udvvx7lGM//w6fwKrI=
Date: Tue, 30 Jun 2026 16:20:37 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Longxing Li <coregee2000@gmail.com>
Cc: syzkaller@googlegroups.com, jirislaby@kernel.org,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [Kernel Bug] INFO: task hung in show_cons_active
Message-ID: <2026063012-equal-scroll-080b@gregkh>
References: <CAHPqNmzFQPFCom1Ng-FhbeRm=maLsKW1T4ZasGm40OkrxJfuwg@mail.gmail.com>
 <2026060919-unchanged-raking-9225@gregkh>
 <CAHPqNmztcnHLLEV0v8JK1zspgWqaveaTpDtEMh8ehuv-3hZPqA@mail.gmail.com>
 <2026062257-grading-remember-bfde@gregkh>
 <CAHPqNmxJfSC73Liogt=vr=YR_wX0VFTAMphejesodE=85Aeuvg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHPqNmxJfSC73Liogt=vr=YR_wX0VFTAMphejesodE=85Aeuvg@mail.gmail.com>

On Tue, Jun 30, 2026 at 08:30:39PM +0800, Longxing Li wrote:
>  Dear maintainers,
> 
> Here's my fix and patch of the bug.
> 
> Fix Summary:
> 
>   The deadlock occurs because unregister_console() holds console_list_lock
>   while __pr_flush() blocks on console_sem. show_cons_active() has the same
>   lock -> sem ordering (holds mutex, waits for sem), creating a potential
>   ABBA when any printer path needs the mutex.
> 
>   Fix: restructure unregister_console() into three phases:
> 
>     Phase 1 (list lock):   Disable console (clear CON_ENABLED).
>     Phase 2 (NO lock):     __pr_flush() waits for pending output.
>                            Safe because console is already disabled.
>     Phase 3 (list lock):   Remove from list + cleanup.
> 
>   This ensures __pr_flush() is never called while holding console_list_lock,
>   eliminating the lock inversion.
> 
>   Full patch is as follows and also attached in the link.
> 
> =====================================================
> From: Longxing Li <coregee2000@gmail.com>
> Date: Tue, 30 Jun 2026
> Subject: [PATCH] printk: fix potential deadlock in unregister_console()
> 
> unregister_console() holds console_list_lock while calling __pr_flush(),
> which blocks on console_sem. show_cons_active() holds console_mutex (the
> same lock) while also waiting for console_sem. This creates a potential
> ABBA deadlock when any console output path needs console_mutex.
> 
> Fix by restructuring unregister_console() so __pr_flush() is called WITHOUT
> holding console_list_lock:
> 
>   Phase 1 (list lock):    Disable console (clear CON_ENABLED).
>   Phase 2 (no lock):      __pr_flush() drains pending output.
>   Phase 3 (list lock):    Remove from list + cleanup.
> 
> Reported-by: Longxing Li

You are the author, noneed for a reported-by

> Suggested-by: Greg KH <gregkh@linuxfoundation.org>

I did?

> Signed-off-by: Longxing Li <coregee2000@gmail.com>
> ---
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -4235,28 +4235,15 @@
>   struct console *c;
>   int res;
> 
>   lockdep_assert_console_list_lock_held();
> 
> - con_printk(KERN_INFO, console, "disabled\n");
> -

Patch is corruupted and can not be applied :(
