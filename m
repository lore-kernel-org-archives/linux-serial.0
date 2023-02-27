Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE883C64ED6
	for <linux-serial@archiver.kernel.org>; Mon, 27 Feb 2023 09:02:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbjB0JC6 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 27 Feb 2023 04:02:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbjB0JCq (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 27 Feb 2023 04:02:46 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5E37CC12
        for <linux-serial@vger.kernel.org>; Mon, 27 Feb 2023 00:53:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E5643B80CAF
        for <linux-serial@vger.kernel.org>; Mon, 27 Feb 2023 08:52:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAB5DC433EF;
        Mon, 27 Feb 2023 08:52:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677487921;
        bh=h4RYVawUO2zZmE0RYb8/Xj6vQkpmNefwPRcaPPcDZmM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KCfX1Y2xBZ4VIyC9Af00o1cfZQbaTZM5leUBLZ5Hky7znIMJzJWnZTmGuaGYtUebK
         3dFkdrSlTw2gz933ZAflueUgIS6vcu3KHLnOH+yeuRWwZz3yeNCJTCGks6hTyKMFHM
         haO0SmVrjNUT8vQIL+SWiYPlVlHhbqakihmvXOiLRlhysAQvBLnqMZYebcg07LngbX
         korMzd3w/yGS8Kp278R/GaHnk8jDX26Mr+MGeOLpiiIvP4zcP14LwvhLBXV01yf1Cq
         0FXt9NjWpdijL4CXdPkQ9C4GRv6r/OZ5dFqCItiYCFPblM8LQMcTSuOebjv3vnsweY
         UJKMFU92DVBaw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1pWZF7-0006Kl-Js; Mon, 27 Feb 2023 09:52:21 +0100
Date:   Mon, 27 Feb 2023 09:52:21 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Dan Carpenter <error27@gmail.com>
Cc:     linux-serial@vger.kernel.org
Subject: Re: [bug report] serial: 8250: fix handle_irq locking
Message-ID: <Y/xvRQSmS67sv2cL@hovoldconsulting.com>
References: <Y/xYzqp4ogmOF5t0@kili>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y/xYzqp4ogmOF5t0@kili>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, Feb 27, 2023 at 10:16:30AM +0300, Dan Carpenter wrote:
> Hello Johan Hovold,
> 
> The patch 853a9ae29e97: "serial: 8250: fix handle_irq locking" from
> Jul 14, 2021, leads to the following Smatch static checker warning:
> 
> drivers/tty/serial/8250/8250_fsl.c:84 fsl8250_handle_irq() warn: inconsistent returns 'flags'.
>   Locked on  : 38,46
>   Unlocked on: 84
> 
> drivers/tty/serial/8250/8250_fsl.c
>     26  int fsl8250_handle_irq(struct uart_port *port)
>     27  {
>     28          unsigned long flags;
>     29          u16 lsr, orig_lsr;
>     30          unsigned int iir;
>     31          struct uart_8250_port *up = up_to_u8250p(port);
>     32  
>     33          spin_lock_irqsave(&up->port.lock, flags);
>                                                   ^^^^^
>     34  
>     35          iir = port->serial_in(port, UART_IIR);
>     36          if (iir & UART_IIR_NO_INT) {
>     37                  spin_unlock(&up->port.lock);
>     38                  return 0;
> 
> Needs to enable IRQs again.  Same below etc.

Thanks, Dan. I just sent a fix here:

	https://lore.kernel.org/r/20230227085046.24282-1-johan@kernel.org

Johan
