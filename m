Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 369BF4A68BC;
	Thu,  1 Oct 2026 08:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790844263; cv=none; b=O6jBjD4yhBLWlTqoicxr//0r+LhtvrhAkBNYlvukWGoVCE30y9mfBAZTs/e1M5jSKnZSFcQ+voDcybMV0/u7bGdqQItsPFVlWCsLv8FZ7D02SgnDJviMG6ctI6IVoX+Hv6SHiFEHttBvXB8AaaVLdc7FPpu6KmY+43OrhZnbOvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790844263; c=relaxed/simple;
	bh=xAZzeWsoU29XOEucbRrraPHu7WT8OdGc7tg9DTRUwR4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rg4OzGoOu0lidjJ7MAXXa68xDbWeJG28AuupFr1WE/5mWtFZUXpyn3Zuht3Sc5LqiWipU8wDxiOO8o6PAbByY5OgjqKCE/TbCreSEWxI02BdpszEwf3JT6wJug1aM5k9heEygMAFU6t9m0Op2Hmv8pWxC7Iyxsoj7TPnSXe/NQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Fz4woziZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Fz4woziZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 477CB1F000FF;
	Thu,  1 Oct 2026 08:44:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790844261;
	bh=53vxHPgXPAYykvhPW1cq0eTcm/diYqT4wu1qHDLYCi8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Fz4woziZXui4ARVTuxJ+CV/XtD1BRz/XmkpmVx5Ipxiv8X4uzcFbBzFIkHgXQPtVU
	 xvZKLPhfu5XT5Y7aA9z5bXBKfhjHIEus0/nUWDlWI5duDC6keWNXT62IlV2GXDnmGg
	 mS20/b6NYXv6fuE7KIg5AWZabc1iuOTT5yZJ4qew=
Date: Thu, 1 Oct 2026 10:44:15 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-serial@vger.kernel.org, Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Jiri Slaby <jirislaby@kernel.org>,
	"open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)" <linuxppc-dev@lists.ozlabs.org>,
	"open list:TTY LAYER AND SERIAL DRIVERS" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] serial: hvc: use modern IRQ acquisition API
Message-ID: <2026100104-swan-radio-6edf@gregkh>
References: <20260927204658.24338-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260927204658.24338-1-rosenp@gmail.com>

On Sun, Sep 27, 2026 at 01:46:58PM -0700, Rosen Penev wrote:
> Use platform_get_irq_optional() to be able to handle potential
> -EPROBE_DEFER and other errors. Move it earlier to avoid having to call
> kfree() on the global array.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  drivers/tty/hvc/hvc_opal.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/tty/hvc/hvc_opal.c b/drivers/tty/hvc/hvc_opal.c
> index 402da9e7c534..fb9a566ca213 100644
> --- a/drivers/tty/hvc/hvc_opal.c
> +++ b/drivers/tty/hvc/hvc_opal.c
> @@ -13,7 +13,6 @@
>  #include <linux/slab.h>
>  #include <linux/console.h>
>  #include <linux/of.h>
> -#include <linux/of_irq.h>
>  #include <linux/platform_device.h>
>  #include <linux/export.h>
>  #include <linux/interrupt.h>
> @@ -157,8 +156,9 @@ static int hvc_opal_probe(struct platform_device *dev)
>  	struct hvc_struct *hp;
>  	struct hvc_opal_priv *pv;
>  	hv_protocol_t proto;
> -	unsigned int termno, irq, boot = 0;
> +	unsigned int termno, boot = 0;
>  	const __be32 *reg;
> +	int irq;
>  
>  	if (of_device_is_compatible(dev->dev.of_node, "ibm,opal-console-raw")) {
>  		proto = HV_PROTOCOL_RAW;
> @@ -176,6 +176,10 @@ static int hvc_opal_probe(struct platform_device *dev)
>  	reg = of_get_property(dev->dev.of_node, "reg", NULL);
>  	termno = reg ? be32_to_cpup(reg) : 0;
>  
> +	irq = platform_get_irq_optional(dev, 0);
> +	if (irq == -EPROBE_DEFER)
> +		return irq;
> +
>  	/* Is it our boot one ? */
>  	if (hvc_opal_privs[termno] == &hvc_opal_boot_priv) {
>  		pv = hvc_opal_privs[termno];
> @@ -209,8 +213,7 @@ static int hvc_opal_probe(struct platform_device *dev)
>  		dev->dev.of_node,
>  		boot ? " (boot console)" : "");
>  
> -	irq = irq_of_parse_and_map(dev->dev.of_node, 0);
> -	if (!irq) {
> +	if (irq < 0) {
>  		pr_info("hvc%d: No interrupts property, using OPAL event\n",
>  				termno);
>  		irq = opal_event_request(ilog2(OPAL_EVENT_CONSOLE_INPUT));
> -- 
> 2.55.0
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
