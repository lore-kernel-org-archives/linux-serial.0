Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32058C433DB
	for <linux-serial@archiver.kernel.org>; Tue, 23 Mar 2021 09:23:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6232619B8
	for <linux-serial@archiver.kernel.org>; Tue, 23 Mar 2021 09:23:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbhCWJXM (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 23 Mar 2021 05:23:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:43874 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230018AbhCWJWz (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 23 Mar 2021 05:22:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4E850619BD;
        Tue, 23 Mar 2021 09:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1616491374;
        bh=nIl5g8+JAuq2Z3PPtrMi5r/ei6Uo3jJtQSZOg96Y6kg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NWqWw+WpZUGeCu615dNX65XaOUfb07H1OLIcUVqWCSaDE3R1AC4lq9pE2m9arSlnm
         ZQ0JpHxwzlULKbNRMekmDqBfGMuLwkLkzwsL4sNg9RyZCk/+c+FFhFlInF/+NGab//
         771QRCoHNRvHaKDpBZKZswYuhu7mGICL6Fco4PMg=
Date:   Tue, 23 Mar 2021 10:22:51 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Alex Nemirovsky <alex.nemirovsky@cortina-access.com>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        Jason Li <jason.li@cortina-access.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH 1/3] tty: serial: Add UART driver for Cortina-Access
 platform
Message-ID: <YFmzax3pWFNtFbn9@kroah.com>
References: <1613702532-5096-1-git-send-email-alex.nemirovsky@cortina-access.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1613702532-5096-1-git-send-email-alex.nemirovsky@cortina-access.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Feb 18, 2021 at 06:42:09PM -0800, Alex Nemirovsky wrote:
> From: Jason Li <jason.li@cortina-access.com>
> 
> This driver supports Cortina Access UART IP integrated
> in most all CAXXXX line of SoCs. Earlycom is also supported
> 
> Signed-off-by: Jason Li <jason.li@cortina-access.com>
> Reviewed-by: Alex Nemirovsky <alex.nemirovsky@cortina-access.com>
> ---
>  MAINTAINERS                                |   5 +
>  drivers/tty/serial/Kconfig                 |  19 +
>  drivers/tty/serial/Makefile                |   1 +
>  drivers/tty/serial/serial_cortina-access.c | 798 +++++++++++++++++++++++++++++
>  include/uapi/linux/serial_core.h           |   3 +
>  5 files changed, 826 insertions(+)
>  create mode 100644 drivers/tty/serial/serial_cortina-access.c
> 
>  Change log
>   drivers/tty/serial/serial_cortina-access.c
>    v3:
>     - Remove usage of uintptr_t. Change to pointer to driver's private
>       structure instead.

Is this really a "v3"?  The subject lines do not show that, so I'm
totally confused as to what to review and what has been reviewed here.

Please fix this up and submit a "v4" so we know what is going on :)

thanks,

greg k-h
