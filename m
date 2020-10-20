Return-Path: <SRS0=UUkf=D3=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2845C4363D
	for <linux-serial@archiver.kernel.org>; Tue, 20 Oct 2020 23:53:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59E1C2222D
	for <linux-serial@archiver.kernel.org>; Tue, 20 Oct 2020 23:53:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388349AbgJTXxQ (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 20 Oct 2020 19:53:16 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:38590 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387477AbgJTXxP (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 20 Oct 2020 19:53:15 -0400
X-Greylist: delayed 578 seconds by postgrey-1.27 at vger.kernel.org; Tue, 20 Oct 2020 19:53:15 EDT
Received: from localhost (localhost.localdomain [127.0.0.1])
        by kvm5.telegraphics.com.au (Postfix) with ESMTP id 3A69323B22;
        Tue, 20 Oct 2020 19:43:34 -0400 (EDT)
Date:   Wed, 21 Oct 2020 10:43:37 +1100 (AEDT)
From:   Finn Thain <fthain@telegraphics.com.au>
To:     Brad Boyer <brad@allandria.com>
cc:     Laurent Vivier <laurent@vivier.eu>,
        Greg KH <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Joshua Thompson <funaho@jurai.org>,
        linux-serial@vger.kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linux-m68k@lists.linux-m68k.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH] serial: pmac_zilog: don't init if zilog is not
 available
In-Reply-To: <20201020224446.GA15066@allandria.com>
Message-ID: <alpine.LNX.2.23.453.2010211038390.6@nippy.intranet>
References: <20201020162303.1730562-1-laurent@vivier.eu> <20201020162844.GA865546@kroah.com> <468bbbef-4745-3b16-b6f4-30b46ebcdc33@vivier.eu> <20201020173745.GA882703@kroah.com> <387fd2aa-b181-c41f-0581-0a7e79a44e41@vivier.eu> <20201020183246.GA912431@kroah.com>
 <b52e7fde-8874-3c53-ca13-7709656b69fb@vivier.eu> <20201020224446.GA15066@allandria.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, 20 Oct 2020, Brad Boyer wrote:

> 
> Wouldn't it be better to rearrange this code to only run if the devices 
> are present? This is a macio driver on pmac and a platform driver on 
> mac, so shouldn't it be possible to only run this code when the 
> appropriate entries are present in the right data structures?
> 
> I didn't look at a lot of the other serial drivers, but some other mac 
> drivers have recently been updated to no longer have MACH_IS_MAC checks 
> due to being converted to platform drivers.
> 

Actually, it's not simply a platform driver or macio driver. I think the 
console is supposed to be registered before the normal bus matching takes 
place. Hence this comment in pmac_zilog.c,

        /* 
         * First, we need to do a direct OF-based probe pass. We
         * do that because we want serial console up before the
         * macio stuffs calls us back, and since that makes it
         * easier to pass the proper number of channels to
         * uart_register_driver()
         */

Laurent, can we avoid the irq == 0 warning splat like this?

diff --git a/drivers/tty/serial/pmac_zilog.c b/drivers/tty/serial/pmac_zilog.c
index 96e7aa479961..7db600cd8cc7 100644
--- a/drivers/tty/serial/pmac_zilog.c
+++ b/drivers/tty/serial/pmac_zilog.c
@@ -1701,8 +1701,10 @@ static int __init pmz_init_port(struct uart_pmac_port *uap)
 	int irq;
 
 	r_ports = platform_get_resource(uap->pdev, IORESOURCE_MEM, 0);
+	if (!r_ports)
+		return -ENODEV;
 	irq = platform_get_irq(uap->pdev, 0);
-	if (!r_ports || irq <= 0)
+	if (irq <= 0)
 		return -ENODEV;
 
 	uap->port.mapbase  = r_ports->start;
