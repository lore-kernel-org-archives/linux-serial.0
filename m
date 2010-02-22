From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: Re: [PATCH  00/12] Serial : sc26xx - generalize and support SC2892
Date: Mon, 22 Feb 2010 10:06:26 +0100
Message-ID: <20100222090626.GA15242@alpha.franken.de>
References: <20100213160948.22311.27542.stgit@srv002.fuzzey.net> <20100215170958.GA13994@alpha.franken.de> <4B802207.4080309@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from elvis.franken.de ([193.175.24.41]:58991 "EHLO elvis.franken.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752020Ab0BVJGg (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 22 Feb 2010 04:06:36 -0500
Content-Disposition: inline
In-Reply-To: <4B802207.4080309@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Martin Fuzzey <mfuzzey@gmail.com>
Cc: linux-serial@vger.kernel.org

On Sat, Feb 20, 2010 at 06:55:19PM +0100, Martin Fuzzey wrote:
> Can I also have an Ack for this additional patch:

sure

> Author: Martin Fuzzey <mfuzzey@gmail.com>
> Date:   Sat Feb 20 18:47:06 2010 +0100
> 
>     Serial: sc26xx - Use ttySC0 instead of ttySC205
>    
>     Use device name ttySC0 as per Documentation/devices.txt
> 
> diff --git a/drivers/serial/sc26xx.c b/drivers/serial/sc26xx.c
> index 2e17bbc..9b0ede0 100644
> --- a/drivers/serial/sc26xx.c
> +++ b/drivers/serial/sc26xx.c
> @@ -918,8 +918,6 @@ static int __devinit sc26xx_probe(struct
> platform_device *dev)
>         if (err)
>                 goto out_free_port;
>  
> -       sc26xx_reg.tty_driver->name_base = sc26xx_reg.minor;
> -
>         err = uart_add_one_port(&sc26xx_reg, &up->port[0]);
>         if (err)
>                 goto out_unregister_driver;
> 

Acked-By: Thomas Bogendoerfer <tsbogend@alpha.franken.de>

> If this is OK with you I'll repost the whole series with your acks and a
> rename patch to sc2xxx

that's fine with me.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessary a
good idea.                                                [ RFC1925, 2.3 ]
