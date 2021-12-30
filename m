Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2EFCC433F5
	for <linux-serial@archiver.kernel.org>; Thu, 30 Dec 2021 12:21:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239201AbhL3MV5 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 30 Dec 2021 07:21:57 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:41278 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbhL3MVz (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 30 Dec 2021 07:21:55 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8FBA46168D
        for <linux-serial@vger.kernel.org>; Thu, 30 Dec 2021 12:21:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58299C36AEA;
        Thu, 30 Dec 2021 12:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1640866915;
        bh=QnboU+XWv/N4jKlN+ix1h0EdhwaY2bVTHgrD3bn62uE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IoePjmOl0MsTx5W89M3kR8qB1/d0jRstUV91Br0Fpe4MHdoSJDqqUCq2ip1P4jDtt
         bR/xshUPjlHcwNJKXBZEkxoR8OhqDSi8YAALhfcTPEFa4syywQLBVN8BcLv+ISbT95
         x5VYpP8VQRxMh+DCmtJ7HUBCke0mgHSxAK/RQT6Y=
Date:   Thu, 30 Dec 2021 13:21:52 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jochen Mades <jochen@mades.net>
Cc:     "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        Lino Sanfilippo <LinoSanfilippo@gmx.de>
Subject: Re: amba-pl011 driver: bug in RS485 mode
Message-ID: <Yc2kYOU67BqDpzLy@kroah.com>
References: <572288095.547800.1640594185677@webmail.strato.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <572288095.547800.1640594185677@webmail.strato.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, Dec 27, 2021 at 09:36:25AM +0100, Jochen Mades wrote:
> Hi,
> 
> I tested the amba-pl011 driver from the current branch rpi-5.16.y in RS485 mode and found a bug.
> 
> The current driver pulls-up RTS in function pl011_set_mctrl independent from the rs485-flags SER_RS485_RTS_AFTER_SEND.
> This leads to problems if the driver is used as RS485 slave.
> 
> In my opinion the patch should look like that (and was tested successfully by myself):
> 
> diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
> index 537f37ac4..3b45beae8 100644
> --- a/drivers/tty/serial/amba-pl011.c
> +++ b/drivers/tty/serial/amba-pl011.c
> @@ -1647,7 +1647,12 @@ static void pl011_set_mctrl(struct uart_port *port, unsigned int mctrl)
>         unsigned int cr;
> 
>         if (port->rs485.flags & SER_RS485_ENABLED)
> -               mctrl &= ~TIOCM_RTS;
> +       {
> +               if (port->rs485.flags & SER_RS485_RTS_AFTER_SEND)
> +                       mctrl &= ~TIOCM_RTS;
> +               else
> +                       mctrl |= TIOCM_RTS;
> +       }
> 
>         cr = pl011_read(uap, REG_CR);
> 
> 
> Please let me know, if I'm allowed to commit this change and let me know how to do that or if someone of you guys will do that better.

Anyone is allowed to submit a change, please do so as per the
Documentation/SubmittingPatches file describes and we will be glad to
review it and apply it if it is ok.

thanks,

greg k-h
