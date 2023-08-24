Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27D63C3DA6F
	for <linux-serial@archiver.kernel.org>; Thu, 24 Aug 2023 07:04:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236400AbjHXHEA (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 24 Aug 2023 03:04:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240309AbjHXHDr (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 24 Aug 2023 03:03:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 888F710FD
        for <linux-serial@vger.kernel.org>; Thu, 24 Aug 2023 00:03:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 13C906519B
        for <linux-serial@vger.kernel.org>; Thu, 24 Aug 2023 07:03:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F94AC433C7;
        Thu, 24 Aug 2023 07:03:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692860624;
        bh=DO6MSqnFflUDvsdBgRIsLi8/8zxHpBEkO334lR4EtBo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wtJZtvcrIbKwVeeVqNgU2pZCZu+H/JQmZcLZyM5TYkYyFD2nPgSMz5n+1gtU9PT42
         Tf4UlmXo0iojZBKRDMtVEMU/IhsoO406b6ySBgQu2x3JcfCp33psaUgFMY3M72LMJD
         eNC9SWIyn8w+1jPRIK6a1LWun60mSU6n6AE8B9mQ=
Date:   Thu, 24 Aug 2023 09:01:39 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Dan Raymond <draymond@foxvalley.net>
Cc:     linux-serial@vger.kernel.org
Subject: Re: [PATCH v2] tty/serial: create debugfs interface for UART
 register tracing
Message-ID: <2023082435-swaddling-aloe-0077@gregkh>
References: <d00f1510-dd83-6fc1-f5e4-dc194b06aabc@foxvalley.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d00f1510-dd83-6fc1-f5e4-dc194b06aabc@foxvalley.net>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Aug 24, 2023 at 12:25:16AM -0600, Dan Raymond wrote:
> Implement a UART register tracing facility using the debugfs.  This can be
> used as a "serial port sniffer" to monitor UART traffic and line settings
> with timestamps at microsecond granularity.  This can be useful for general
> serial port debugging or to debug the UART driver itself.
> 
> Signed-off-by: Dan Raymond<draymond@foxvalley.net>
> 
> ---
> 
> diff -uprN -X a/Documentation/dontdiff a/Documentation/trace/index.rst
> b/Documentation/trace/index.rst
> --- a/Documentation/trace/index.rst    2022-11-16 02:04:15.000000000 -0700
> +++ b/Documentation/trace/index.rst    2023-08-23 21:40:33.641219700 -0600
> @@ -33,3 +33,4 @@ Linux Tracing Technologies
>     coresight/index
>     user_events
>     rv/index
> +   serial
> diff -uprN -X a/Documentation/dontdiff a/Documentation/trace/serial.rst
> b/Documentation/trace/serial.rst
> --- a/Documentation/trace/serial.rst    1969-12-31 17:00:00.000000000 -0700
> +++ b/Documentation/trace/serial.rst    2023-08-23 21:40:31.260358900 -0600
> @@ -0,0 +1,5 @@
> +UART Tracing
> 
> +------------
> 
> +
> 
> +.. kernel-doc:: drivers/tty/serial/8250/8250_debug.c
> 
> +   :doc: UART register tracing
> 
> diff -uprN -X a/Documentation/dontdiff a/drivers/tty/serial/8250/8250.h
> b/drivers/tty/serial/8250/8250.h
> --- a/drivers/tty/serial/8250/8250.h    2022-11-16 02:04:15.000000000 -0700
> +++ b/drivers/tty/serial/8250/8250.h    2023-08-23 17:04:43.171074700 -0600
> @@ -403,3 +403,11 @@ static inline int serial_index(struct ua
>  {
>      return port->minor - 64;
>  }
> +
> +#ifdef CONFIG_SERIAL_8250_DEBUG
> +extern void uart_debug_create(struct uart_port *port);
> +extern void uart_debug_destroy(struct uart_port *port);
> +#else
> +static inline void uart_debug_create(struct uart_port *port) { }
> +static inline void uart_debug_destroy(struct uart_port *port) { }
> +#endif
> diff -uprN -X a/Documentation/dontdiff a/drivers/tty/serial/8250/8250_core.c
> b/drivers/tty/serial/8250/8250_core.c
> --- a/drivers/tty/serial/8250/8250_core.c    2022-11-16 02:04:15.000000000
> -0700
> +++ b/drivers/tty/serial/8250/8250_core.c    2023-08-21 16:16:47.502740700
> -0600

Your patch is somehow whitespace damaged with tabs stripped out and
line-wrapped :(

And you forgot to document what changed, here's what my bot says:

--------

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
