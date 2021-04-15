Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E77EC433ED
	for <linux-serial@archiver.kernel.org>; Thu, 15 Apr 2021 08:14:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B61A611AB
	for <linux-serial@archiver.kernel.org>; Thu, 15 Apr 2021 08:14:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231251AbhDOIOt (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 15 Apr 2021 04:14:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:56248 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231215AbhDOIOt (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 15 Apr 2021 04:14:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2489F6113D;
        Thu, 15 Apr 2021 08:14:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1618474466;
        bh=Sf8fOsqitkV5qdfY6PEsQKbYOdJV1drsU7tKJPv/8wk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GE4al/KhLXcCwk9V0wRJ2qzxQMq/BIH3lKNauX30BunAa2SkEKxCway7NrbZiib6i
         kBlBO7SAKrVXPRo540mjAYtUNpyOR5LzKLSoSk+KdaREH4z7N59gtcnMCleAboCK8K
         kljfzBM/9l18phTrObZoC3ETQjNsjO3I9Uq5pH6E=
Date:   Thu, 15 Apr 2021 10:14:23 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Dario Binacchi <dariobin@libero.it>
Cc:     linux-kernel@vger.kernel.org, Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org
Subject: Re: [PATCH] serial: omap: don't disable rs485 if rts gpio is missing
Message-ID: <YHf131xZBsus3g5h@kroah.com>
References: <20210411085743.510-1-dariobin@libero.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210411085743.510-1-dariobin@libero.it>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Sun, Apr 11, 2021 at 10:57:43AM +0200, Dario Binacchi wrote:
> There are rs485 transceivers (e.g. MAX13487E/MAX13488E) which
> automatically disable or enable the driver and receiver to keep the bus
> in the correct state.
> In these cases we don't need a GPIO for flow control.
> 
> Signed-off-by: Dario Binacchi <dariobin@libero.it>
> ---

Same here, what commit id does this "fix"?  Please add that and resend.

thanks,

greg k-h
