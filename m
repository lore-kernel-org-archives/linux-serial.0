Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACD47C433B4
	for <linux-serial@archiver.kernel.org>; Thu, 15 Apr 2021 08:11:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 893C16113D
	for <linux-serial@archiver.kernel.org>; Thu, 15 Apr 2021 08:11:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231423AbhDOIMR (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 15 Apr 2021 04:12:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:55762 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231300AbhDOIMR (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 15 Apr 2021 04:12:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0596861107;
        Thu, 15 Apr 2021 08:11:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1618474314;
        bh=onC1ug6HwwxiADSJ2qQ9lSuZTAx6WhR3mtRZd+ORhl0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Lf3Li3E0mVpGcAvsHNFSL7h8amPJokLoykSjT/pl1f/H4GxxWPkzEz1PNmXybN4HT
         syF5lQnmprtx2DyA0sk74VipJqjuDFLBCsucZYp/7wD/tWAKQG7CbYS6QTtfbCN9fK
         REFxz53QRoql2WoHVCGzXs59VGDggZ4ZtDQSGR4c=
Date:   Thu, 15 Apr 2021 10:11:51 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Al Cooper <alcooperx@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org
Subject: Re: [-next] serial: 8250: Match legacy NS16550A UARTs
Message-ID: <YHf1RxZjOxwN2u31@kroah.com>
References: <20210414134539.42332-1-alcooperx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210414134539.42332-1-alcooperx@gmail.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Apr 14, 2021 at 09:45:39AM -0400, Al Cooper wrote:
> From: Florian Fainelli <f.fainelli@gmail.com>
> 
> Older 32-bit only Broadcom STB chips used a NS16550A compatible UART,
> the 8250_bcm7271.c driver can drive those UARTs just fine provided that
> we let it match the appropriate compatible string.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> Reviewed-by: Al Cooper <alcooperx@gmail.com>

When forwarding on patches from others, you need to sign-off on them,
not just say "reviewed-by" as I am obtaining the patch from you, not
Florian.

Please fix up.

thanks,

greg k-h
