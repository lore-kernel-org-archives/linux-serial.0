Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA9F548E0;
	Sat,  6 Jul 2024 09:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720256565; cv=none; b=VZ3GpDvm5W3UI49yEF54f4jaIeVC7X1TjpgWJ1xS3iql61cbKtC+pXd0V8de2B2FQ5Ac6gXBZo2CEt6FAsBb8txdIuMNugqYtexBIhHf4QpVr7iHbtNy3ags33Y03dLFZMxh7f0G5l8Se9iCxI25m+UPCEPbbXUNf2WX1czCJy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720256565; c=relaxed/simple;
	bh=LzforoF+0+/UCbH+FWr8s4xGhJ+NQq3I23rEgnI8QdA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oZY47B3FcCikcBKVvVXI5mvm8Z3dJlIhHxmRAE9O58Wuk8LYeSGBgym1wZXiM2ugW6QMoeY0hnjUC3KNj2gpwGxM4sq1VXxCBYvqQLV4Kcrfoz0TuudSydWQ9oOfgDxxiZOlh5XhYwLKy48adPKidBTVWzkX4pjdZW93ICGF7Oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dQd5NoS5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dQd5NoS5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A16FBC2BD10;
	Sat,  6 Jul 2024 09:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720256565;
	bh=LzforoF+0+/UCbH+FWr8s4xGhJ+NQq3I23rEgnI8QdA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dQd5NoS5X/i50MviFgFPHobQte/egNY5LF4NB2pwGn1s5nFdHDqVwSsvuERpqB45k
	 4oWYAzCEJIk7WTWvEhgt1L4vCbgeYANMvF1CJKVkZg0a9Zmdz8sMLfcmma6wftNlBW
	 hovwa6za6SBoeN8D++D0FnXqDF97Inv2YR0aWK1k=
Date: Sat, 6 Jul 2024 11:02:42 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jisheng Zhang <jszhang@kernel.org>
Cc: Jiri Slaby <jirislaby@kernel.org>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH] serial: 8250: don't lost port's default capabilities
Message-ID: <2024070631-chrome-impromptu-e140@gregkh>
References: <20240706082928.2238-1-jszhang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240706082928.2238-1-jszhang@kernel.org>

On Sat, Jul 06, 2024 at 04:29:28PM +0800, Jisheng Zhang wrote:
> Commit b0b8c84cf58d ("serial: of_serial: Handle auto-flow-control
> property") added support for fifo-size and hw-flow-control properties
> to avoid adding new types to 8250.c for UARTs that are compatible with
> the standard types but that have different size fifo or support 16750
> compatible auto flow control. We avoided many new 8250 port types with
> this nice feature, but there's a problem, if the code detects fifo-size
> or auto-flow-control property, up->capabilities will be set
> accordingly, then serial8250_set_defaults() will ignore the default
> port's capabilities:
> 
> |if (!up->capabilities)
> |	up->capabilities = uart_config[type].flags;
> 
> If the port's default capabilities contains other bits such as
> UART_CAP_SLEEP, UART_CAP_EFR and so on, they are lost.
> 
> Fixes: b0b8c84cf58d ("serial: of_serial: Handle auto-flow-control property")
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>  drivers/tty/serial/8250/8250_port.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
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
