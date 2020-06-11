Return-Path: <SRS0=YBLV=7Y=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 598D8C433E0
	for <linux-serial@archiver.kernel.org>; Thu, 11 Jun 2020 08:25:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35638204EC
	for <linux-serial@archiver.kernel.org>; Thu, 11 Jun 2020 08:25:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbgFKIZd (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 11 Jun 2020 04:25:33 -0400
Received: from bmailout2.hostsharing.net ([83.223.78.240]:47021 "EHLO
        bmailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726594AbgFKIZd (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 11 Jun 2020 04:25:33 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id C7D9D2802B9F3;
        Thu, 11 Jun 2020 10:25:30 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 9C3834CF4AF; Thu, 11 Jun 2020 10:25:30 +0200 (CEST)
Date:   Thu, 11 Jun 2020 10:25:30 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Johan Hovold <johan@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Subject: Re: [PATCH] serial: core: drop unnecessary gpio include
Message-ID: <20200611082530.rnx7rkbi6novjdar@wunner.de>
References: <20200610155121.14014-1-johan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200610155121.14014-1-johan@kernel.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

[cc += Heiko]

On Wed, Jun 10, 2020 at 05:51:21PM +0200, Johan Hovold wrote:
> Drop the recently added gpio include from the serial-core header in
> favour of a forward declaration and instead include the gpio header only
> where needed.

Hm, but why?  Are there adverse effects if this is included by
<linux/serial_core.h>?

Thanks,

Lukas

> 
> Signed-off-by: Johan Hovold <johan@kernel.org>
> ---
>  drivers/tty/serial/8250/8250_port.c | 1 +
>  drivers/tty/serial/serial_core.c    | 1 +
>  include/linux/serial_core.h         | 2 +-
>  3 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
> index 1632f7d25acc..d64ca77d9cfa 100644
> --- a/drivers/tty/serial/8250/8250_port.c
> +++ b/drivers/tty/serial/8250/8250_port.c
> @@ -16,6 +16,7 @@
>  #include <linux/ioport.h>
>  #include <linux/init.h>
>  #include <linux/console.h>
> +#include <linux/gpio/consumer.h>
>  #include <linux/sysrq.h>
>  #include <linux/delay.h>
>  #include <linux/platform_device.h>
> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
> index 3706f31b0c37..cba19f7d9ea3 100644
> --- a/drivers/tty/serial/serial_core.c
> +++ b/drivers/tty/serial/serial_core.c
> @@ -14,6 +14,7 @@
>  #include <linux/sched/signal.h>
>  #include <linux/init.h>
>  #include <linux/console.h>
> +#include <linux/gpio/consumer.h>
>  #include <linux/of.h>
>  #include <linux/proc_fs.h>
>  #include <linux/seq_file.h>
> diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
> index 791f4844efeb..01fc4d9c9c54 100644
> --- a/include/linux/serial_core.h
> +++ b/include/linux/serial_core.h
> @@ -10,7 +10,6 @@
>  #include <linux/bitops.h>
>  #include <linux/compiler.h>
>  #include <linux/console.h>
> -#include <linux/gpio/consumer.h>
>  #include <linux/interrupt.h>
>  #include <linux/circ_buf.h>
>  #include <linux/spinlock.h>
> @@ -30,6 +29,7 @@
>  struct uart_port;
>  struct serial_struct;
>  struct device;
> +struct gpio_desc;
>  
>  /*
>   * This structure describes all the operations that can be done on the
> -- 
> 2.26.2
> 
