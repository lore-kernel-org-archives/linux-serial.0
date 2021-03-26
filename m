Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 909E2C433DB
	for <linux-serial@archiver.kernel.org>; Fri, 26 Mar 2021 14:19:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C90261A24
	for <linux-serial@archiver.kernel.org>; Fri, 26 Mar 2021 14:19:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbhCZOSl (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 26 Mar 2021 10:18:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:45818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229848AbhCZOSU (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 26 Mar 2021 10:18:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C6A5361A02;
        Fri, 26 Mar 2021 14:18:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1616768300;
        bh=B2wQnGoW3sjS3jK2xpNARrCIjunm/tk41Pa8NA5DY5E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1yBm8JhuS01juL29Nf8Cm+AQNa8BlSM9LErBVnG18b9NDhG4PqA+jEt/BKX/2wYP+
         4GVy3U0Qv2VJ+gjn26jWNzva5ZiReSohVrh2kuibvEocqni/vdrXpYHs1B6C5Bdj7g
         S8UIfkLJMbEMgo6UnMd+ScTgUiSZwm4ZgyBfzs7A=
Date:   Fri, 26 Mar 2021 15:18:18 +0100
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
Subject: Re: [PATCH v7 2/2] tty/serial: Add rx-tx-swap OF option to
 stm32-usart
Message-ID: <YF3tKmzX1PtlX59x@kroah.com>
References: <1615559009.788146.2976052.nullmailer@robh.at.kernel.org>
 <20210312153702.12349-1-devik@eaxlabs.cz>
 <20210312153702.12349-2-devik@eaxlabs.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210312153702.12349-2-devik@eaxlabs.cz>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Mar 12, 2021 at 04:37:02PM +0100, Martin Devera wrote:
> STM32 F7/H7 usarts supports RX & TX pin swapping.
> Add option to turn it on.
> Tested on STM32MP157.
> 
> Signed-off-by: Martin Devera <devik@eaxlabs.cz>
> Acked-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>

This does not apply to my tty-next branch at all.  Can you please rebase
this series (and keep Rob's ack of patch 1) and resend?

thanks,

greg k-h
