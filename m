Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 118FBC4332F
	for <linux-serial@archiver.kernel.org>; Tue, 14 Sep 2021 08:08:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0871601FC
	for <linux-serial@archiver.kernel.org>; Tue, 14 Sep 2021 08:08:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230027AbhINIIx (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 14 Sep 2021 04:08:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:60972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230260AbhINIGO (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 14 Sep 2021 04:06:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 18E6460E90;
        Tue, 14 Sep 2021 08:04:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1631606648;
        bh=is6/OZHofB1mIm80FRHvelB2x0GoF/xOkKeCXSlJcEU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OgduPq+mQO6Li4zxje1QEqgUsLiFfiTISDlsd21qYh3nCYdaEHwS2mrlOL+GjSswE
         RQxKZC6MUU746bw9w6/IYRb5d6L7drbdOAf4oeoIAhMD+SbmDLujR8Ytf7wFAJuTXK
         LoCJQiOI2zDbmLLsOElFVRGOKreTXimr82hh4TC4=
Date:   Tue, 14 Sep 2021 10:04:05 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Abel Vesa <abel.vesa@nxp.com>
Cc:     Rob Herring <robh@kernel.org>, Dong Aisheng <aisheng.dong@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-i2c@vger.kernel.org, linux-serial@vger.kernel.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 10/10] dt-bindings: serial: fsl-lpuart: Add i.MX8DXL
 compatible
Message-ID: <YUBXdR1RRWnItcAv@kroah.com>
References: <1631522874-19862-1-git-send-email-abel.vesa@nxp.com>
 <1631522874-19862-11-git-send-email-abel.vesa@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1631522874-19862-11-git-send-email-abel.vesa@nxp.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, Sep 13, 2021 at 11:47:54AM +0300, Abel Vesa wrote:
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>

I can not take patches without any changelog text at all, sorry.

greg k-h
