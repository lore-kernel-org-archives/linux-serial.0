Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B96C2C38159
	for <linux-serial@archiver.kernel.org>; Fri, 20 Jan 2023 06:46:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229449AbjATGqd (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 20 Jan 2023 01:46:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjATGqc (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 20 Jan 2023 01:46:32 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD74E40F9
        for <linux-serial@vger.kernel.org>; Thu, 19 Jan 2023 22:46:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 61A5861E2C
        for <linux-serial@vger.kernel.org>; Fri, 20 Jan 2023 06:46:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B5E8C433D2;
        Fri, 20 Jan 2023 06:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1674197190;
        bh=tF42KmX2vST2IaU7J3dJPNiyMHXscoOSRk7IHHuFQ6g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=exHnsZYe+hp+HEf6U+eVCjqWj0RRJafH0x3H9RCzeSbpp4c03HlSALfJyWLJN62Hk
         8v/g+UK5gCnYtGWQYwDerHwrBELnzxbJjKGR29acdVnBsKFFkS8BNVG2MpeFe3FzMZ
         2yNJW5FJ3DmXYcL2PY2p36OBwbx8/clRoj+9jZzA=
Date:   Fri, 20 Jan 2023 07:46:27 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Marek Vasut <marex@denx.de>
Cc:     kernel test robot <lkp@intel.com>, oe-kbuild-all@lists.linux.dev,
        linux-serial@vger.kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Johan Hovold <johan@kernel.org>
Subject: Re: [tty:tty-linus 4/7] drivers/tty/serial/stm32-usart.c:804:62:
 error: 'flags' undeclared
Message-ID: <Y8o4w8jRJAUSPIDx@kroah.com>
References: <202301200130.ttBiTzfO-lkp@intel.com>
 <f5f4b504-8e58-2844-fa26-c8896a625794@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f5f4b504-8e58-2844-fa26-c8896a625794@denx.de>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Jan 19, 2023 at 07:08:00PM +0100, Marek Vasut wrote:
> On 1/19/23 18:33, kernel test robot wrote:
> 
> [...]
> 
> > cc58d0a3f0a475 Erwan Le Ray     2021-10-20  800  	/* Receiver timeout irq for DMA RX */
> > f24771b62a8323 Marek Vasut      2023-01-12  801  	if (stm32_usart_rx_dma_enabled(port) && !stm32_port->throttled) {
> > f24771b62a8323 Marek Vasut      2023-01-12  802  		spin_lock(&port->lock);
> > 6333a485062172 Erwan Le Ray     2021-10-25  803  		size = stm32_usart_receive_chars(port, false);
> > 6333a485062172 Erwan Le Ray     2021-10-25 @804  		uart_unlock_and_check_sysrq_irqrestore(port, flags);
> 
> +CC Johan
> 
> This one should be uart_unlock_and_check_sysrq(port); I think . If that's
> correct, then I'll send a patch.
> 
> > 6333a485062172 Erwan Le Ray     2021-10-25  805  		if (size)
> > 6333a485062172 Erwan Le Ray     2021-10-25  806  			tty_flip_buffer_push(tport);
> > 6333a485062172 Erwan Le Ray     2021-10-25  807  	}
> 
> [...]

Let me go revert this now until you all get it fixed up in a new change,
I can't have a broken branch right now, sorry.

greg k-h
