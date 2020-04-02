Return-Path: <SRS0=sjTb=5S=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F023CC43331
	for <linux-serial@archiver.kernel.org>; Thu,  2 Apr 2020 12:18:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA0B220757
	for <linux-serial@archiver.kernel.org>; Thu,  2 Apr 2020 12:18:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585829897;
	bh=71Iog+U1Pf2i1tJM4b6pe3IqJ3VZB7yjNL9XljQ9Nps=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=p20xtI7GXiap/cXNbyQS9Df5Y/WAO+Yl+a6aMPfExyI8j8KLf6ucbXRUMtPfY7169
	 xKdLxG8NGMDZxp4J+Kk8UZGLt5+V2CZ6+wzVRWPCEghPPVbGPg6hS9toIqkIjqtpzE
	 11ittsR8RFoZrceTq+Es0QKtN7ujZC98yN8IsEYQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387963AbgDBMSR (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 2 Apr 2020 08:18:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:46028 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387730AbgDBMSR (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 2 Apr 2020 08:18:17 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 17AF2206F8;
        Thu,  2 Apr 2020 12:18:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585829896;
        bh=71Iog+U1Pf2i1tJM4b6pe3IqJ3VZB7yjNL9XljQ9Nps=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=e1F5KeO+jy4p7cBCOJqFbIgpbLxMud2IDkNuX1BGWM3NDmjRVu3ZyASftbQdYMqdw
         gYAC+C2X6iuPq8qY5+RKjOnd9MYnz1dgdrN2ZFRjCoNqOpzHbtWIASnYtN/h2yS3CY
         jVjA+k+4dOmuHMUT7Zj+kGGvaqn/gEY98CUUcw5A=
Date:   Thu, 2 Apr 2020 14:18:14 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Hyunki Koo <hyunki00.koo@samsung.com>
Cc:     krzk@kernel.org, Kukjin Kim <kgene@kernel.org>,
        Jiri Slaby <jslaby@suse.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tty: samsung_tty: 32-bit access for TX/RX hold
 registers
Message-ID: <20200402121814.GA2773800@kroah.com>
References: <20200401082721.19431-1-hyunki00.koo@samsung.com>
 <CGME20200402110609epcas2p4a5ec1fb3a5eaa3b12c20cfc2060162f3@epcas2p4.samsung.com>
 <20200402110430.31156-1-hyunki00.koo@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200402110430.31156-1-hyunki00.koo@samsung.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Apr 02, 2020 at 08:04:29PM +0900, Hyunki Koo wrote:
> Support 32-bit access for the TX/RX hold registers UTXH and URXH.
> 
> This is required for some newer SoCs.
> 
> Signed-off-by: Hyunki Koo <hyunki00.koo@samsung.com>
> ---
>  drivers/tty/serial/samsung_tty.c | 78 +++++++++++++++++++++++++++++++++-------
>  1 file changed, 66 insertions(+), 12 deletions(-)

What changed from v1?  Always put that under the --- line, as documented
to do so.

Please make a v3 with that information.

thanks,

greg k-h
