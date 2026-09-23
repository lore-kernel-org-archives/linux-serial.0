Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8877E414414;
	Wed, 23 Sep 2026 10:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790159535; cv=none; b=Jl/AWAQ1D+RCAUR00UifH7U0ofIwH/muawC/7U3+S8YBs35ErZzuIzH+GwWn+lkzxgviwmXnvHmqHv/DDXGmqZhGm+FVADmZp1/pb45cuiUIgW0bbY3cZP08aD21V/ajuYw1Upto9BWeFObXUxgP6qo7WCqT6abZ5dPBbw9WrG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790159535; c=relaxed/simple;
	bh=cF/njPo9j8sWXcdGcEVgzeYY4ZHTPdGLMqVhs94iLH4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B6teFvaLwlXfymouttei1lPiukBPjsB6eMNoKy2NgbiDgBv8NzszscVUlIZP333XC1GEC59A6Z/QyXEwcfeC9tVO7dz9smKwL/tmh5fNE7ADfyGnpT9LUxAYMNIdiCk+uvcigHrz3zTS/BsGR7441+Rfk7esYvh5pnstw8X0xE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0FmDAODm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0FmDAODm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42EC11F000FF;
	Wed, 23 Sep 2026 10:32:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790159522;
	bh=cpuCu5v1M9XfKbLexcgtG6aXcXIggBSNrBJURPKiOI8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=0FmDAODmcxVfwZLNR9rZEXlbpRpomC44Gv6lT+IXPYnPTrPF1FGN1X6M9Qa0bERtQ
	 dhm1mluz8WLI+JNEYy23F3cAxWpybSWy8lKwFDOOdaCkHD/Yw9ZNTGReUWQIJBN2ki
	 uUUTW9ybj4ow/kSuc6soxXEfNKp2t5XM0CXrNPtQ=
Date: Wed, 23 Sep 2026 12:31:58 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Ginger Li <ginger.jzllee@gmail.com>
Cc: jirislaby@kernel.org, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org, Maarten.Brock@sttls.nl
Subject: Re: [PATCH v2] serial: max3100: Fix a data race on s->rts in
 max3100_work()
Message-ID: <2026092348-police-filth-8d32@gregkh>
References: <20260922053151.11260-1-ginger.jzllee@gmail.com>
 <20260922170239.33485-1-ginger.jzllee@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260922170239.33485-1-ginger.jzllee@gmail.com>

On Wed, Sep 23, 2026 at 01:02:39AM +0800, Ginger Li wrote:
> max3100_set_mctrl() stores the new RTS state and raises s->rts_commit to tell
> max3100_work() that it has to program it:
> 
> 	spin_lock(&s->conf_lock);
> 	if (s->rts != rts) {
> 		s->rts = rts;
> 		s->rts_commit = 1;
> 	}
> 	if (s->loopback_commit || s->rts_commit)
> 		max3100_dowork(s);
> 	spin_unlock(&s->conf_lock);
> 
> max3100_work() consumes s->rts_commit under s->conf_lock, but reads s->rts
> itself outside of the lock, both when it services that pending update and when
> it later transmits a character, so the state it programs into the hardware can
> be stale.
> 
> Read s->rts into a local variable in the s->conf_lock protected snapshot at
> the top of the loop, before s->rts_commit is consumed, in the same way as
> s->conf is read before s->conf_commit.
> 
> Fixes: 7831d56b0a35 ("tty: MAX3100")
> Signed-off-by: Ginger Li <ginger.jzllee@gmail.com>
> ---
> v2:
>  - read s->rts into "rts" before s->rts_commit is consumed, as suggested by
>    Maarten
>  - mention s->rts_commit in the commit message
>  - left the s->rts / s->rts_commit split alone; folding both into one byte
>    would be a separate cleanup
> ---
>  drivers/tty/serial/max3100.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/max3100.c b/drivers/tty/serial/max3100.c
> --- a/drivers/tty/serial/max3100.c
> +++ b/drivers/tty/serial/max3100.c
> @@ -236,6 +236,7 @@ static void max3100_work(struct work_struct *w)
>  	struct tty_port *tport = &s->port.state->port;
>  	unsigned char ch;
>  	int conf, cconf, cloopback, crts;
> +	bool rts;
>  	int rxchars;
>  	u16 tx, rx;
>  
> @@ -249,6 +250,7 @@ static void max3100_work(struct work_struct *w)
>  		s->conf_commit = 0;
>  		cloopback = s->loopback_commit;
>  		s->loopback_commit = 0;
> +		rts = s->rts;
>  		crts = s->rts_commit;
>  		s->rts_commit = 0;
>  		spin_unlock(&s->conf_lock);
> @@ -258,7 +260,7 @@ static void max3100_work(struct work_struct *w)
>  			max3100_sr(s, 0x4001, &rx);
>  		if (crts) {
>  			max3100_sr(s, MAX3100_WD | MAX3100_TE |
> -				   (s->rts ? MAX3100_RTS : 0), &rx);
> +				   (rts ? MAX3100_RTS : 0), &rx);
>  			rxchars += max3100_handlerx(s, rx);
>  		}
>  
> @@ -277,7 +279,7 @@ static void max3100_work(struct work_struct *w)
>  			}
>  			if (tx != 0xffff) {
>  				max3100_calc_parity(s, &tx);
> -				tx |= MAX3100_WD | (s->rts ? MAX3100_RTS : 0);
> +				tx |= MAX3100_WD | (rts ? MAX3100_RTS : 0);
>  				max3100_sr(s, tx, &rx);
>  				rxchars += max3100_handlerx(s, rx);
>  			}
> -- 
> 2.43.0
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
