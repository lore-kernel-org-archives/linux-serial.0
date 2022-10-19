Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07BB9C433FE
	for <linux-serial@archiver.kernel.org>; Wed, 19 Oct 2022 15:47:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232505AbiJSPrv (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 19 Oct 2022 11:47:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232506AbiJSPrS (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 19 Oct 2022 11:47:18 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C21B86824;
        Wed, 19 Oct 2022 08:41:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id A5B4ACE22AF;
        Wed, 19 Oct 2022 15:41:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B6F3C433C1;
        Wed, 19 Oct 2022 15:41:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1666194097;
        bh=pp0u8hipLhDrQpM4yh61waqBQ+HKhDl84yhWKQ9AfSc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=h1s+6wLnCcSZQDw219lUCDYZT/y2g3M30CfQLQHGJ4FgEHDEubtlKJ3MqSnxemyF+
         HJdvMXI8I9hLkebNLu9nujeG7K5+0YHxNAtdFSofb/EOE9MYzEjyLxKG1v7Ezsnu/H
         aPWDWGxxThDCgS0o3xDvY9J81p4lIc+++fMm40DY=
Date:   Wed, 19 Oct 2022 17:41:34 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        kgdb-bugreport@lists.sourceforge.net, linux-serial@vger.kernel.org
Subject: Re: [PATCH printk v2 01/38] serial: kgdboc: Lock console list in
 probe function
Message-ID: <Y1Aarp6pv34/cioY@kroah.com>
References: <20221019145600.1282823-1-john.ogness@linutronix.de>
 <20221019145600.1282823-2-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221019145600.1282823-2-john.ogness@linutronix.de>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Oct 19, 2022 at 05:01:23PM +0206, John Ogness wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> Unprotected list walks are not necessarily safe.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: John Ogness <john.ogness@linutronix.de>
> Reviewed-by: Petr Mladek <pmladek@suse.com>
> ---
>  drivers/tty/serial/kgdboc.c | 2 ++
>  1 file changed, 2 insertions(+)

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
