Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B91D175A68;
	Thu, 12 Mar 2026 14:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773324675; cv=none; b=LenVmqt0az4Sym67nVVV7CnFjU9FedPmn9CFVkYWpSfG1eRqRE1mlMp9/r2jGGsMiqr3stDviPbihcYUkjqU74eeHrKn2MGusYskulx7uLg/Q8YqqaQrmDfVXxTvyFe48S+zknslMGfrNrJXRzzdYNU6ir9EsC06e6tZYOV7zSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773324675; c=relaxed/simple;
	bh=HAPayg6JU7/vr6Qpn1vnwJGvi+PtYgr03IdnbTQzKOY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Do7LkK9sOiSqFjuMdrrYyCXe1KWbtsJnAn7Tl3YykdPq2/onhWHRKlzzKJ5UhCESiwCVswrkAyyL7s0ktGr/UKCqL5Ikk4cRWGle44olRLELnPitcwxTZjIAYAmCW0JNNahNVtU7KUPpxnwUecBfDebmCSENLk/gK65SjJaPRE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sZCfVKyU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sZCfVKyU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FBDEC4CEF7;
	Thu, 12 Mar 2026 14:11:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773324675;
	bh=HAPayg6JU7/vr6Qpn1vnwJGvi+PtYgr03IdnbTQzKOY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sZCfVKyU8n9tc9oafJPuggiYdMgd9oHVPvEG6ZJyFc+kJ7qoH+2MJ4tt62Y62hsf/
	 AlrZZHrkg2abA+2ZAMVp/rTk/v+Qo5unMjicT3ZG1cJ2/SRaQzTEJpYLTDJQ01EfoV
	 zS8XtZlrB12yt34u4XgXcXMAQjocSJl7KsBNnRGk=
Date: Thu, 12 Mar 2026 15:11:09 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Ravindra Rama <ravindra@nexthop.ai>
Cc: jirislaby@kernel.org, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] serial: 8250_fintek: Add support for F81214E
Message-ID: <2026031246-street-vineyard-3843@gregkh>
References: <CA+mnHaW481bx8nJBNkkgS+oB+=Y=+qeX+hP0q6ObULt8=ewr-g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+mnHaW481bx8nJBNkkgS+oB+=Y=+qeX+hP0q6ObULt8=ewr-g@mail.gmail.com>

On Mon, Feb 23, 2026 at 02:40:24PM -0600, Ravindra Rama wrote:
> The F81214E is a LPC/eSPI to 2 UART Super I/O chip.
> 
> Functionally, it is the same as the F81216E. The only difference
> is that the F81216E has 4 UART ports, whereas the F81214E has 2
> UART ports.
> 
> Signed-off-by: Ravi Rama <ravi.rama@nexthop.ai>
> ---
>  drivers/tty/serial/8250/8250_fintek.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_fintek.c
> b/drivers/tty/serial/8250/8250_fintek.c
> index b4461a89b8d0..976c5748905c 100644
> --- a/drivers/tty/serial/8250/8250_fintek.c
> +++ b/drivers/tty/serial/8250/8250_fintek.c
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0
>  /*
> - *  Probe for F81216A LPC to 4 UART
> + *  Probe for F81216A LPC to 4 UART and F81214E LPC/eSPI to 2 UART
>   *
>   *  Copyright (C) 2014-2016 Ricardo Ribalda, Qtechnology A/S
>   */
> @@ -23,6 +23,7 @@
>  #define CHIP_ID_F81216AD 0x1602
>  #define CHIP_ID_F81216E 0x1617
>  #define CHIP_ID_F81216H 0x0501
> +#define CHIP_ID_F81214E 0x1417
>  #define CHIP_ID_F81216 0x0802
>  #define VENDOR_ID1 0x23
>  #define VENDOR_ID1_VAL 0x19

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

- Your patch is malformed (tabs converted to spaces, linewrapped, etc.)
  and can not be applied.  Please read the file,
  Documentation/process/email-clients.rst in order to fix this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
