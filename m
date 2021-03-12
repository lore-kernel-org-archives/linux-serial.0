Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9195EC433DB
	for <linux-serial@archiver.kernel.org>; Fri, 12 Mar 2021 08:16:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 685E064F6D
	for <linux-serial@archiver.kernel.org>; Fri, 12 Mar 2021 08:16:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231659AbhCLIPr (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 12 Mar 2021 03:15:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:60814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231466AbhCLIPq (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 12 Mar 2021 03:15:46 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E511964F24;
        Fri, 12 Mar 2021 08:15:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1615536946;
        bh=pGOkfq4PO14DvGqEJeNzFWg1lPYSGCHDiyFuwWF38ew=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1DHu3ktO5sP3m9DLEfAyTWhET34y3e8n1W+VXx0TEQiKvp2eb6QEeYIRseQTe/e6s
         Z9DCjiOORTqwKkDubqHsgXIuOf9SkbQRZLmKWWA5VxqQGwMq8hHaeWqb+d3OhBEb+3
         yeCG0npTLkYLSAEpDWee16MOo3X6tlishaqdE900=
Date:   Fri, 12 Mar 2021 09:15:44 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Martin Devera <devik@eaxlabs.cz>
Cc:     linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Jiri Slaby <jirislaby@kernel.org>, Le Ray <erwan.leray@st.com>,
        fabrice.gasnier@foss.st.com, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5 2/2] tty/serial: Add rx-tx-swap OF option to
 stm32-usart
Message-ID: <YEsjMJae3cGOdyjG@kroah.com>
References: <20210308192040.GA2807217@robh.at.kernel.org>
 <20210311215153.676-1-devik@eaxlabs.cz>
 <20210311215153.676-2-devik@eaxlabs.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210311215153.676-2-devik@eaxlabs.cz>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Mar 11, 2021 at 10:51:53PM +0100, Martin Devera wrote:
> STM32 F7/H7 usarts supports RX & TX pin swapping.
> Add option to turn it on.
> Tested on STM32MP157.
> 
> Signed-off-by: Martin Devera <devik@eaxlabs.cz>
> Acked-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
> ---
>  drivers/tty/serial/stm32-usart.c | 11 ++++++++++-
>  drivers/tty/serial/stm32-usart.h |  4 ++++
>  2 files changed, 14 insertions(+), 1 deletion(-)

What changed from v4-v1 on this patch series?  That needs to go below
the --- line as documented.

Please fix up and send v6.

thanks,

greg k-h
