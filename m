Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BC65C4338F
	for <linux-serial@archiver.kernel.org>; Thu, 29 Jul 2021 14:59:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D47A760EFD
	for <linux-serial@archiver.kernel.org>; Thu, 29 Jul 2021 14:59:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbhG2O7y (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 29 Jul 2021 10:59:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:56320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229864AbhG2O7y (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 29 Jul 2021 10:59:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5584860EBC;
        Thu, 29 Jul 2021 14:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1627570790;
        bh=VBh8qGAL8EnMQACKM3w/lx9zTrNywIdlrr9xtAu2fH4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KneH5x5YOPBqJfMk/X8UNpRwwoXQ6U0aYeaQ33mnLllYW4oTH3i7K48R4PBTLyKtH
         8ZuNQH6AQ7SlkMIDjktAAWF/FLhkLZrSWTPSpbyShQmDr2MOXWvdzBM/VdQKAWSyc8
         5jNYwimH/OSOhHirY5JDm7GMKGfiIovJp0t/Tr3A=
Date:   Thu, 29 Jul 2021 16:59:43 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sean Anderson <sean.anderson@seco.com>
Cc:     linux-serial@vger.kernel.org, Peter Korsgaard <jacmet@sunsite.dk>,
        Michal Simek <michal.simek@xilinx.com>
Subject: Re: [PATCH] tty: serial: uartlite: Use read_poll_timeout for a
 polling loop
Message-ID: <YQLCX5pTkVC1Url9@kroah.com>
References: <20210723215220.624204-1-sean.anderson@seco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210723215220.624204-1-sean.anderson@seco.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Jul 23, 2021 at 05:52:20PM -0400, Sean Anderson wrote:
> This uses read_poll_timeout_atomic to spin while waiting on uart_in32.

That says what you are doing, but nothing about _why_ you are making
this change.  Please fix up.

thanks,

greg k-h
