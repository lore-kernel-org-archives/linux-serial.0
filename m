Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A81F5C48BDF
	for <linux-serial@archiver.kernel.org>; Tue, 15 Jun 2021 11:52:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D1D86145D
	for <linux-serial@archiver.kernel.org>; Tue, 15 Jun 2021 11:52:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbhFOLyl (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 15 Jun 2021 07:54:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:32904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230052AbhFOLyl (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 15 Jun 2021 07:54:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5DBB260FF0;
        Tue, 15 Jun 2021 11:52:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1623757957;
        bh=2VVHP822lYRhsSNsXyvBdgbGe+qUNXNXZeQE62K+LQk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=a96hfrEUA8l0XzuoZfIawv5nogIipX+rQ8tIuU88D9M2P1USHb2Ad39b/nPr4xT/k
         doz0ZYHzVpiSdzUbrS29RsWvJv60yzF6gXtbNZ/LdDw+2iqGkIl597CcNklFP+/fhs
         nf9UjxIVKb1f5uG5Yo2rQH4gQ2jW1TDQYUeDLQ24=
Date:   Tue, 15 Jun 2021 13:52:34 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Alex Nemirovsky <alex.nemirovsky@cortina-access.com>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        Jason Li <jason.li@cortina-access.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH v4 1/3] tty: serial: Add UART driver for Cortina-Access
 platform
Message-ID: <YMiUgpRbfwMHCqD+@kroah.com>
References: <20210509184519.15816-1-alex.nemirovsky@cortina-access.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210509184519.15816-1-alex.nemirovsky@cortina-access.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Sun, May 09, 2021 at 11:45:16AM -0700, Alex Nemirovsky wrote:
> From: Jason Li <jason.li@cortina-access.com>
> 
> This driver supports Cortina Access UART IP integrated
> in most all CAXXXX line of SoCs. Earlycom is also supported
> 
> Signed-off-by: Jason Li <jason.li@cortina-access.com>
> ---

I can't take this without the DT maintainers acking the DT changes.

So can you resend this so that they can notice that it requires their
review?

thanks,

greg k-h
