Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF9A284B50;
	Sat,  6 Sep 2025 11:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757158929; cv=none; b=ZxvLXukzgnVhMCJIfAsQMHtcKaEbeam591yQUOPO7T8p9G6qPqP0O8YFsfmV10mvPT3wmpFc9uaKq6qa+Z7NRj6y2JzDaQqogwBvH0zJqOH73CG0RX7kOs+FyqzI3SRjgWfKYMPzMIaE+XSHdtFnOtct5dt0vam+S3D2/m4hfWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757158929; c=relaxed/simple;
	bh=HIF9cEt3wpQPjBAaEny5cqESVVN7hzwy8m+L3yP+HwE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JsBwypveW8HvTEXa60jLh+xwWkILxIc6KG4h2x4tkxSI5E/TFoc6kw64zmNDQ/PppdMfQUyQmewxqzanNAMvSISlGJBAMlQJQpWT5mcdRlAME4JTi2FGDu/2RIL8RndCV7US9iRZM+V4VmIp7Nl+rxdKBLCG8RPN4i5ZYti688w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=t7L42CQu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="t7L42CQu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F12C5C4CEE7;
	Sat,  6 Sep 2025 11:42:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1757158928;
	bh=HIF9cEt3wpQPjBAaEny5cqESVVN7hzwy8m+L3yP+HwE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=t7L42CQuFeJMn7rk/bxVRuhz2hyhZp19OleBWLit7zEXtxsAvscrw4E0ZMNlJASL/
	 bE6Xh26r0ZgHjUl2pLaiAzNg9e7xM5Wn3Py9dJ1ZmFWMqYQxtWa3C5dvwTDcasy1JL
	 W09OpHdZVFjOrmoP2b/tUEMOBfay/LSyDq1q+LvM=
Date: Sat, 6 Sep 2025 13:42:05 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Zsolt Kajtar <soci@c64.rulez.org>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
	jirislaby@kernel.org
Subject: Re: [PATCH v2 0/4] tty/vt: fix various 512 glyph font issues
Message-ID: <2025090650-support-emergency-3599@gregkh>
References: <20250901052636.8981-1-soci@c64.rulez.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250901052636.8981-1-soci@c64.rulez.org>

On Mon, Sep 01, 2025 at 07:26:32AM +0200, Zsolt Kajtar wrote:
> Having the 8th bit of a glyph in the attribute byte is tricky business.
> These patches fix most of the cases where it went wrong in the VT code.
> What remains is related to fbcon as well and so not part of this series.
> 
> This run fixes concerns raised on review and adds one more patch for a
> problem which doesn't cause visible effects.
> 
> These patches were prepared to apply on tty-next.
> 
> Zsolt Kajtar (4):
>   tty/vt: 8th bit location in vc_uniscr routines
>   tty/vt: Prevent 8th bit corruption with soft cursor
>   tty/vt: Fix unreadable kernel messages on vgacon
>   tty/vt: use correct attribute mask in do_update_region
> 
>  drivers/tty/vt/vt.c | 40 ++++++++++++++++++++++++++--------------
>  1 file changed, 26 insertions(+), 14 deletions(-)
> 
> -- 
> 2.30.2
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

- This looks like a new version of a previously submitted patch, but you
  did not list below the --- line any changes from the previous version.
  Please read the section entitled "The canonical patch format" in the
  kernel file, Documentation/process/submitting-patches.rst for what
  needs to be done here to properly describe this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
