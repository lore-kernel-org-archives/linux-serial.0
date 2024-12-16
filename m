Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CF5B80C0C;
	Mon, 16 Dec 2024 15:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734361703; cv=none; b=dg6t+0iOgAj1y8+Mghd+w1Rc8zjtMG17A94jqC6P6n3PlUKCzDXMVtsZaTotmN97ATf2g6sJpkgh0cGjTX/QTFNynHYF8lOpyU9M2TEQ6PjWVJ54cdhklg9apCxdMvyPrcQlSd2A6sAqvFhd575Gg9qcIfEZqJ0dT6TYw7TWE5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734361703; c=relaxed/simple;
	bh=awxiBTcZhMpWYm6oAg7E3oNZlYA7iWuuZpH4Aj7m4Ec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DuXVBl/3mgGHVrytCp/AJ5MC+Jz7cN5CHBWRutEz1UdZaqmr5nma5lG7G55puOy6lYg4tnFyReAf2i2A9ANirm4ayKFySzeXoE7gKtkZO4Haq3IxC7olH2GTOfqwyXcPAXxmOwHAxEzIu3S1CLqNGo4bs+lRDecMK3L682NmK/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jZsECHSV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jZsECHSV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AA63C4CED0;
	Mon, 16 Dec 2024 15:08:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734361703;
	bh=awxiBTcZhMpWYm6oAg7E3oNZlYA7iWuuZpH4Aj7m4Ec=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jZsECHSVwD9hZ4gBTWa5f7mSd27oFcngZLAZ6z5ioMZ5sfC0EG6R7Gk9nYK1i4Jn1
	 Vv9TxVr2/c5udikOt2dvrFYHuJmHJzzY7L+yE2H/svsVIVZkuDMNYFMgItDSnRwEcp
	 I+/8VWvqsr/mw73n/QSXsh0/lsgRvX57lnUw8N40=
Date: Mon, 16 Dec 2024 16:07:43 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Ben Wolsieffer <ben.wolsieffer@hefring.com>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jiri Slaby <jirislaby@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	John Ogness <john.ogness@linutronix.de>
Subject: Re: [PATCH] serial: stm32: use port lock wrappers for break control
Message-ID: <2024121632-railing-battle-07c7@gregkh>
References: <20241216145323.111612-1-ben.wolsieffer@hefring.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241216145323.111612-1-ben.wolsieffer@hefring.com>

On Mon, Dec 16, 2024 at 09:53:23AM -0500, Ben Wolsieffer wrote:
> Commit 30e945861f3b ("serial: stm32: add support for break control")
> added another usage of the port lock, but was merged on the same day as
> c5d06662551c ("serial: stm32: Use port lock wrappers"), therefore the
> latter did not update this usage to use the port lock wrappers.
> 
> Fixes: c5d06662551c ("serial: stm32: Use port lock wrappers")
> Signed-off-by: Ben Wolsieffer <ben.wolsieffer@hefring.com>
> ---
>  drivers/tty/serial/stm32-usart.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
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
