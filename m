Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97A38C433EF
	for <linux-serial@archiver.kernel.org>; Tue,  2 Nov 2021 07:44:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76DB860F56
	for <linux-serial@archiver.kernel.org>; Tue,  2 Nov 2021 07:44:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230465AbhKBHrI (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 2 Nov 2021 03:47:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:39604 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230519AbhKBHq4 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 2 Nov 2021 03:46:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3936B60F56;
        Tue,  2 Nov 2021 07:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635839060;
        bh=K+5794DO0CyR1WowT7L3guGby6Lpr9bHzC6ZoG6dV/I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Vq9/XrwBdPx+SkNvMiK+xsGpRUUBOGlQGR4cdQ3SMXR7+sqxCmdN8gPeNmm31qtpn
         hhQNVQveYd8Pz0qdYZwet6cfa2EyvDxAOTCuIwKrAhk+Tu2AvWIKQ8HyeVGBD9Vr7r
         Jihkch6CkRqk/5t8wXAHl8SJpGWZk6bTAGBuUZXqMow0HmXaQBpzrfPcrRbG1/nBmL
         q32n5vU5Gv2otj8+y6oaS2UZmR72sC49o/D66GectLPGoh/aJiBuzhTd/vUvZtB/kS
         7nE1iobpde/jg3pEl65+3BvgYFgeRrfPui2jALpvoh/lmZ6KiP06hcicKdl9Du5+Pj
         LdJpHCpNwfoIg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1mhoSx-00071v-FO; Tue, 02 Nov 2021 08:44:20 +0100
Date:   Tue, 2 Nov 2021 08:44:19 +0100
From:   Johan Hovold <johan@kernel.org>
To:     cgel.zte@gmail.com
Cc:     joe@perches.com, andrew@aj.id.au, fancer.lancer@gmail.com,
        gregkh@linuxfoundation.org, jirislaby@kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        macro@orcam.me.uk, pali@kernel.org, yao.jing2@zte.com.cn,
        zealci@zte.com.cn
Subject: Re: [PATCH v2] drivers: tty: replace snprintf in show functions with
 sysfs_emit
Message-ID: <YYDsU778y71byGdj@hovoldconsulting.com>
References: <b42482be11d04963fed0903ce1bd983742efc5c6.camel@perches.com>
 <20211102065206.3368-1-yao.jing2@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211102065206.3368-1-yao.jing2@zte.com.cn>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Nov 02, 2021 at 06:52:06AM +0000, cgel.zte@gmail.com wrote:
> From: Jing Yao <yao.jing2@zte.com.cn>
> 
> coccicheck complains about the use of snprintf() in sysfs show
> functions:
> WARNING use scnprintf or sprintf
> 
> Use sysfs_emit instead of scnprintf or sprintf makes more sense.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Jing Yao <yao.jing2@zte.com.cn>
> ---

What changed since v1? Always include a changelog here.

Also you ignored my comment on the patch Subject. Including "drivers: "
is never correct. You should also mention which driver you're changing
since it's not done subtree-wide for tty. 

Again, look at the git log for the driver you're changing. In this case
it should have been something like:

	serial: 8250: use sysfs_emit...

>  drivers/tty/serial/8250/8250_port.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
> index 5775cbff8f6e..3d58f383152e 100644
> --- a/drivers/tty/serial/8250/8250_port.c
> +++ b/drivers/tty/serial/8250/8250_port.c
> @@ -3099,7 +3099,7 @@ static ssize_t rx_trig_bytes_show(struct device *dev,
>  	if (rxtrig_bytes < 0)
>  		return rxtrig_bytes;
>  
> -	return snprintf(buf, PAGE_SIZE, "%d\n", rxtrig_bytes);
> +	return sysfs_emit(buf, "%d\n", rxtrig_bytes);
>  }
>  
>  static int do_set_rxtrig(struct tty_port *port, unsigned char bytes)

Johan
