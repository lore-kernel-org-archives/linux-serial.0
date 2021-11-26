Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66650C433EF
	for <linux-serial@archiver.kernel.org>; Fri, 26 Nov 2021 16:16:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378495AbhKZQTv (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 26 Nov 2021 11:19:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378364AbhKZQRu (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 26 Nov 2021 11:17:50 -0500
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98D14C06175B;
        Fri, 26 Nov 2021 08:09:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Xu4BqA0ntRXZObjJ8mJYwmiUqSz7SQeNEXoZ0Jfceqo=; b=LEaJZhr8ackoP9gFNpWndCWCDH
        z5c7Fnb8jgV4fLcd1CVwBu2a1d1XDOpCR7d8Qs4oYMVRqUBiQvWJrziLcVChH/SDW9K0hQcYMgFeS
        GztCdgGG/Q29RwWKvI9a9X06Y65TSzqFxfgCl+/CQakgEjOu3k0kRczJjF1aDlOT9lGz89Nk1RHMQ
        ZQsvod9hEvSlb9Gd32uwyrhbzlpEzQLwEnKz1Ym4a+BUpwrweW6pcHVmQmo/vLJ2mFw89iOK3m8oh
        cNMXtZ94cw0L85AD4L9xeWSF6Hhr50aASVYufwhOdlnRZrbAqttK36nyz4Z9CJWpW90myTQUSl+DB
        ad9M3gGw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:55918)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1mqdn6-0003B6-Cz; Fri, 26 Nov 2021 16:09:36 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1mqdn4-0003Oa-2T; Fri, 26 Nov 2021 16:09:34 +0000
Date:   Fri, 26 Nov 2021 16:09:34 +0000
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Lino Sanfilippo <LinoSanfilippo@gmx.de>
Cc:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        p.rosenberger@kunbus.com, lukas@wunner.de,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] serial: amba-pl011: do not request memory region twice
Message-ID: <YaEGvkBl8YT33YAR@shell.armlinux.org.uk>
References: <20211126143925.18758-1-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211126143925.18758-1-LinoSanfilippo@gmx.de>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Nov 26, 2021 at 03:39:25PM +0100, Lino Sanfilippo wrote:
> The driver attempts to request and release the IO memory region for a uart
> port twice:
> 
> First during the probe() function devm_ioremap_resource() is used to
> allocate and map the ports memory.
> Then a combo of pl011_config_port() and pl011_release_port() is used to
> request/release the same memory area. These functions are called by the
> serial core as soon as the uart is registered/unregistered.
> 
> However since the allocation request via devm_ioremap_resource() already
> succeeds, the attempt to claim the memory again via pl011_config_port()
> fails. This failure remains unnoticed, since the concerning return value is
> not evaluated.
> Later at module unload also the attempt to release the unclaimed memory
> in pl011_release_port() fails. This time the failure results in a “Trying
> to free nonexistent resource" warning printed by the serial core.
> 
> Fix these issues by removing the callbacks that implement the redundant
> memory allocation/release.

I think you will also need the verify_port method to also deny changing
port->mapbase.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
