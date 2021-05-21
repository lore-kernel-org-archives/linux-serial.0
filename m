Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7F4CC433ED
	for <linux-serial@archiver.kernel.org>; Fri, 21 May 2021 06:51:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3EBF613BB
	for <linux-serial@archiver.kernel.org>; Fri, 21 May 2021 06:51:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232544AbhEUGwn (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 21 May 2021 02:52:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:33800 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232426AbhEUGwn (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 21 May 2021 02:52:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id ADCE3613BB;
        Fri, 21 May 2021 06:51:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1621579880;
        bh=+TlRkCWv2IP2OKDhEW+sR4mAR64PA70bKtB4aLP10Zc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=j8d1j97W11QegLjc7T5xwLpNoyeTn3bTbA4g1L7CPyFcKmgQMp9CZrgWvI6dwR1jK
         ifeU6OV9FXRCKQIJVx3JshqjtZcDhanD+B2+TKTeanp+WAhu9K7WCvfOL8fFfWsEy5
         LfBFiK6oj0iRbHARJ+n5G4R8G8hiX+pbRZv3recc=
Date:   Fri, 21 May 2021 08:51:16 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Zheyu Ma <zheyuma97@gmail.com>
Cc:     cernekee@gmail.com, jirislaby@kernel.org,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] serial: rp2: use 'request_firmware' instead of
 'request_firmware_nowait'
Message-ID: <YKdYZF8zDGl0hxeX@kroah.com>
References: <1621577323-1541-1-git-send-email-zheyuma97@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1621577323-1541-1-git-send-email-zheyuma97@gmail.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, May 21, 2021 at 06:08:43AM +0000, Zheyu Ma wrote:
> In 'rp2_probe', the driver registers 'rp2_uart_interrupt' then calls
> 'rp2_fw_cb' through 'request_firmware_nowait'. In 'rp2_fw_cb', if the
> firmware don't exists, function just return without initializing ports
> of 'rp2_card'. But now the interrupt handler function has been
> registered, and when an interrupt comes, 'rp2_uart_interrupt' may access
> those ports then causing NULL pointer dereference or other bugs.
> 
> Because the driver does some initialization work in 'rp2_fw_cb', in
> order to make the driver ready to handle interrupts, 'request_firmware'
> should be used instead of asynchronous 'request_firmware_nowait'.

You just now slowed down the probe function.  Are you _sure_ this is ok?

Do you have this hardware to test this?  If so, what is the init time
before and after this change?

thanks,

greg k-h
