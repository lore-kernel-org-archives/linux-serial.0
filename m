Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC61FC433EF
	for <linux-serial@archiver.kernel.org>; Wed, 13 Apr 2022 22:53:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230023AbiDMW4D (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 13 Apr 2022 18:56:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238449AbiDMWz6 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 13 Apr 2022 18:55:58 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CB6364A3F4;
        Wed, 13 Apr 2022 15:53:35 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id B71C892009E; Thu, 14 Apr 2022 00:53:33 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id B097992009B;
        Wed, 13 Apr 2022 23:53:33 +0100 (BST)
Date:   Wed, 13 Apr 2022 23:53:33 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PING][PATCH v3] serial: 8250: Report which option to enable for
 blacklisted PCI devices
In-Reply-To: <alpine.DEB.2.21.2203310054120.44113@angie.orcam.me.uk>
Message-ID: <alpine.DEB.2.21.2204132057280.9383@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2203310054120.44113@angie.orcam.me.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, 31 Mar 2022, Maciej W. Rozycki wrote:

> Provide information in the kernel log as to what configuration option to 
> enable for PCI UART devices that have been blacklisted in the generic 
> PCI 8250 UART driver and which have a dedicated driver available to 
> handle that has been disabled.  The rationale is there is no easy way 
> for the user to map a specific PCI vendor:device pair to an individual 
> dedicated driver while the generic driver has this information readily 
> available and it will likely be confusing that the generic driver does 
> not register such a port.

 Ping for:
<https://lore.kernel.org/lkml/alpine.DEB.2.21.2203310054120.44113@angie.orcam.me.uk/>

  Maciej
