Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE810C433F5
	for <linux-serial@archiver.kernel.org>; Tue, 26 Apr 2022 11:29:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235522AbiDZLcz (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 26 Apr 2022 07:32:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232244AbiDZLcz (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 26 Apr 2022 07:32:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58E8F17B396
        for <linux-serial@vger.kernel.org>; Tue, 26 Apr 2022 04:29:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E8C2E61827
        for <linux-serial@vger.kernel.org>; Tue, 26 Apr 2022 11:29:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6406C385A0;
        Tue, 26 Apr 2022 11:29:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1650972587;
        bh=eKr3TQUtQzx3bjhQgJZN7lbkNuKpD7lF4lsJMQV9xrE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gNoBQut6VL3ixj5reXozj54j1VxWEUNM+B0CLjPRzvr66launhRTCqRerAoYqj6H6
         jKt+aWGaisW1RUNOs1Bx0vOLI/KQistepnztpNVKxxlYSgnbSH6s1/yvwvDeyBBkdm
         2z3HVC4kQ5epvEgMSOVMg8s94VL/vT13zYFa30t8=
Date:   Tue, 26 Apr 2022 13:29:44 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     linux-serial@vger.kernel.org, Jiri Slaby <jirislaby@kernel.org>,
        Lukas Wunner <lukas@wunner.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Vicente Bergas <vicencb@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, Johan Hovold <johan@kernel.org>,
        heiko@sntech.de, giulio.benetti@micronovasrl.com,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Raymond Tan <raymond.tan@intel.com>
Subject: Re: [PATCH v4 04/13] serial: 8250_dwlib: RS485 HW half & full duplex
 support
Message-ID: <YmfXqK1KaX7XoJd8@kroah.com>
References: <20220425143410.12703-1-ilpo.jarvinen@linux.intel.com>
 <20220425143410.12703-5-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220425143410.12703-5-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, Apr 25, 2022 at 05:34:01PM +0300, Ilpo Järvinen wrote:
> The Synopsys DesignWare UART can be configured to have HW support for
> the RS485 protocol from IP version 4.0 onward. Add support for
> hardware-controlled half duplex and full duplex modes.
> 
> HW will take care of managing DE and RE, the driver just gives it
> permission to use either by setting both to 1.
> 
> To ask for full duplex mode, userspace sets SER_RS485_RX_DURING_TX flag
> and HW will take care of the rest.
> 
> Set delay_rts_before_send and delay_rts_after_send to zero for now. The
> granularity of that ABI is too coarse to be useful.
> 
> Co-developed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Co-developed-by: Raymond Tan <raymond.tan@intel.com>
> Signed-off-by: Raymond Tan <raymond.tan@intel.com>
> Co-developed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---
>  drivers/tty/serial/8250/8250_dwlib.c | 85 +++++++++++++++++++++++++++-
>  drivers/tty/serial/8250/8250_dwlib.h |  3 +
>  2 files changed, 86 insertions(+), 2 deletions(-)

This commit fails to apply to my tree.  Can you rebase this and the rest
and resend?

thanks,

greg k-h
