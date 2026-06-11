Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CE6E27FB05;
	Thu, 11 Jun 2026 18:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781203886; cv=none; b=o49fDXKrIp4t7apMIuauBaQZdX5a/OVhltwJQGCrVCTGPolArja7/X3159vaePJ1Y9k0cK23r+0xQ2wMxgQ7+9Wh54GaIWY/yrwgTVotuiJ25xPZ7Io8AFVs7kAUisZ0BEEsImsQOh+qOF+3IyncXhn4SQIkEqNbsBuQJtz9asc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781203886; c=relaxed/simple;
	bh=r2G3YG79Xb3F44hii48c5gETtj1K85tfM40g953gcsE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LofTuML4gl5WcCPTsEPF2pb9kglRiJCdA1u+CellvithHEQR/Bbe0SXyHxCvZGCY0N8mhKixFJu1UKqrpvC0N2gwX8L7SZt3uCcLSrEAZCa4vR97PgeEHmBeEHVnEOMLoZgd1glXc2xKKdxv2e9ADOA/JhnhFa4ZXXhmMEmkW1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1dp4+04h; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1dp4+04h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B0631F000E9;
	Thu, 11 Jun 2026 18:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781203883;
	bh=YH76WOlvI2uavK3vmC5UVxGlMNTBRcqqvEOMiFiEKmw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=1dp4+04h4V/1d05FqpNoH8fNNgtZsjLk4mrSqgJpAvIMBzzZV69L/lUPMge3+rTYC
	 sJlCzIYhECYW2MH2ujpIHy7bdCwiCRWUnwfOQWps0Zuk/zN2hrM+s0IFEyDoNkHnDf
	 JPrFUeG2IFOIAv3aYUmk5J17GqSkStJw4NZQ0YXk=
Date: Thu, 11 Jun 2026 20:50:24 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Weiming Shi <bestswngs@gmail.com>
Cc: Jiri Slaby <jirislaby@kernel.org>,
	Daniel Starke <daniel.starke@siemens.com>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	Xiang Mei <xmei5@asu.edu>
Subject: Re: [PATCH] tty: n_gsm: fix NULL deref of gsm->dlci[0] in control
 message handlers
Message-ID: <2026061101-hanky-uninstall-da53@gregkh>
References: <20260611183217.2488508-2-bestswngs@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260611183217.2488508-2-bestswngs@gmail.com>

On Thu, Jun 11, 2026 at 11:32:18AM -0700, Weiming Shi wrote:
> gsm_control_command() and gsm_control_reply() load gsm->dlci[0] and
> immediately dereference dlci->ftype without checking it for NULL.
> 
> On the receive path, gsm_queue() validates that gsm->dlci[0] is non-NULL
> and DLCI_OPEN before invoking the control handler, but the value is not
> held across that check: the receive worker runs from flush_to_ldisc()
> without taking gsm->mutex, while a concurrent GSMIOC_SETCONF ioctl can
> enter gsm_cleanup_mux(), which takes gsm->mutex, releases gsm->dlci[0]
> and sets it to NULL. If the mux is torn down between gsm_queue()'s check
> and the re-load inside gsm_control_command()/gsm_control_reply(), the
> handler dereferences a NULL dlci.
> 
> A peer that drives DLCI 0 control frames (e.g. CMD_TEST) while the mux
> owner reconfigures the line discipline can therefore crash the kernel
> (line numbers from decode_stacktrace.sh against the crashing build):
> 
>  Oops: general protection fault, probably for non-canonical address
>  KASAN: null-ptr-deref in range [0x0000000000000208-0x000000000000020f]
>  RIP: 0010:gsm_control_reply (drivers/tty/n_gsm.c:1497)
>  Call Trace:
>   gsm_dlci_command (drivers/tty/n_gsm.c:2482)
>   gsm_queue.part.0 (drivers/tty/n_gsm.c:2852)
>   gsm0_receive (drivers/tty/n_gsm.c:2972)
>   gsmld_receive_buf (drivers/tty/n_gsm.c:3629)
>   tty_ldisc_receive_buf (drivers/tty/tty_buffer.c:391)
>   tty_port_default_receive_buf (drivers/tty/tty_port.c:39)
>   flush_to_ldisc (drivers/tty/tty_buffer.c:495)
>   process_one_work
>   worker_thread
>   kthread
> 
> The other callers of these helpers (the keep-alive and negotiation timer
> paths) already guard the gsm->dlci[0] access; only the receive path is
> unguarded. The CMD_CLD handler in the same switch already checks the
> loaded dlci for NULL for the very same reason. Bail out early when
> gsm->dlci[0] has been cleared instead of dereferencing it.
> 
> Triggering this requires CAP_NET_ADMIN to attach the n_gsm line
> discipline (gsmld_open() uses capable(), not ns_capable()), so it is a
> local denial of service for a privileged mux owner racing its own
> control channel; harden the handlers regardless.
> 
> Fixes: 5767712668b8 ("tty: n_gsm: cleanup gsm_control_command and gsm_control_reply")
> Reported-by: Xiang Mei <xmei5@asu.edu>
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Weiming Shi <bestswngs@gmail.com>
> ---
>  drivers/tty/n_gsm.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
> index 214abeb89aaa..860cfb91d510 100644
> --- a/drivers/tty/n_gsm.c
> +++ b/drivers/tty/n_gsm.c
> @@ -1457,6 +1457,9 @@ static int gsm_control_command(struct gsm_mux *gsm, int cmd, const u8 *data,
>  	struct gsm_msg *msg;
>  	struct gsm_dlci *dlci = gsm->dlci[0];
>  
> +	if (!dlci)
> +		return -EINVAL;

What precents dlci from being NULL right after you check this?

thanks,

greg k-h
