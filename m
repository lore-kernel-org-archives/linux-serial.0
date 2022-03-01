Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8230DC433EF
	for <linux-serial@archiver.kernel.org>; Tue,  1 Mar 2022 20:52:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237773AbiCAUxW (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 1 Mar 2022 15:53:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238424AbiCAUxN (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 1 Mar 2022 15:53:13 -0500
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3B784559D;
        Tue,  1 Mar 2022 12:52:26 -0800 (PST)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 7ADF592009C; Tue,  1 Mar 2022 21:52:25 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 7467492009B;
        Tue,  1 Mar 2022 20:52:25 +0000 (GMT)
Date:   Tue, 1 Mar 2022 20:52:25 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PING][PATCH v3 0/2] serial: 8250: Fixes for Oxford Semiconductor
 950 UARTs
In-Reply-To: <alpine.DEB.2.21.2202100424280.34636@angie.orcam.me.uk>
Message-ID: <alpine.DEB.2.21.2203011748460.11354@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2202100424280.34636@angie.orcam.me.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Sat, 12 Feb 2022, Maciej W. Rozycki wrote:

>  Here's v3 of the outstanding fixes for Oxford Semiconductor 950 UARTs.  
> As the change for the default FIFO rx trigger level has been already 
> merged with commit d7aff291d069 ("serial: 8250: Define RX trigger levels 
> for OxSemi 950 devices") only one patch of the original series remains.  

 Ping for:

<https://lore.kernel.org/lkml/alpine.DEB.2.21.2202100424280.34636@angie.orcam.me.uk/>

  Maciej
