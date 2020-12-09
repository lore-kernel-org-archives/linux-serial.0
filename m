Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA599C4361B
	for <linux-serial@archiver.kernel.org>; Wed,  9 Dec 2020 14:33:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8AFA022ADC
	for <linux-serial@archiver.kernel.org>; Wed,  9 Dec 2020 14:33:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726016AbgLIOdM (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 9 Dec 2020 09:33:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:40480 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725885AbgLIOdL (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 9 Dec 2020 09:33:11 -0500
Date:   Wed, 9 Dec 2020 15:33:47 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1607524351;
        bh=oMX36b8wxrVVSzTDLmz18H4WQ7q1me/mSWco99WXAN4=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=TOai+Th2tPxOc+/BmsorjOc4iFi5ksEeN03mucFL7Po1EtF2x4+shTahvoRpBsU7A
         aqvuWrz+KJdCLbUWW4EpPMd/+6X6Qfd7/AMcrtHNGg8SE5r/R2oKPBn2qD97UcE6fB
         bvm/64GBHAAeSoSONTnt0AA1yyoB6A7m4tKfAnkc=
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Cc:     linux-serial@vger.kernel.org, git@xilinx.com, jacmet@sunsite.dk,
        linuxfoundation.org@xilinx.com
Subject: Re: [PATCH 3/3] serial-uartlite: Remove an un-necessary read of
 control register
Message-ID: <X9DgS7j8L45EdtoR@kroah.com>
References: <1607516301-26975-1-git-send-email-shubhrajyoti.datta@xilinx.com>
 <1607516301-26975-3-git-send-email-shubhrajyoti.datta@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1607516301-26975-3-git-send-email-shubhrajyoti.datta@xilinx.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Dec 09, 2020 at 05:48:21PM +0530, Shubhrajyoti Datta wrote:
> The control register is a writeonly register that's why reading it
> doesn't make any sense.

Are you _SURE_?  Many times this is needed for hardware control...

Can you point to the documentation that says this is ok to remove?

thanks,

greg k-h
