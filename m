Return-Path: <SRS0=K8LB=D6=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B5D3C388F7
	for <linux-serial@archiver.kernel.org>; Fri, 23 Oct 2020 03:21:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4BFF12177B
	for <linux-serial@archiver.kernel.org>; Fri, 23 Oct 2020 03:21:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2900432AbgJWDVF (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 22 Oct 2020 23:21:05 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:45734 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2508276AbgJWDVF (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 22 Oct 2020 23:21:05 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by kvm5.telegraphics.com.au (Postfix) with ESMTP id 4933A20696;
        Thu, 22 Oct 2020 23:21:01 -0400 (EDT)
Date:   Fri, 23 Oct 2020 14:21:11 +1100 (AEDT)
From:   Finn Thain <fthain@telegraphics.com.au>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
cc:     Laurent Vivier <laurent@vivier.eu>,
        Brad Boyer <brad@allandria.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Joshua Thompson <funaho@jurai.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH] serial: pmac_zilog: don't init if zilog is not
 available
In-Reply-To: <CAMuHMdVbo2C1yZ5E_A3L8J1zZigO8i8m5AFUTn9SjbY1sx16kA@mail.gmail.com>
Message-ID: <alpine.LNX.2.23.453.2010231412260.6@nippy.intranet>
References: <20201020162303.1730562-1-laurent@vivier.eu> <20201020162844.GA865546@kroah.com> <468bbbef-4745-3b16-b6f4-30b46ebcdc33@vivier.eu> <20201020173745.GA882703@kroah.com> <387fd2aa-b181-c41f-0581-0a7e79a44e41@vivier.eu> <20201020183246.GA912431@kroah.com>
 <b52e7fde-8874-3c53-ca13-7709656b69fb@vivier.eu> <20201020224446.GA15066@allandria.com> <alpine.LNX.2.23.453.2010211038390.6@nippy.intranet> <311d17ed-75fa-a7fe-6c70-177a6eec4519@vivier.eu> <alpine.LNX.2.23.453.2010221347000.6@nippy.intranet>
 <CAMuHMdVbo2C1yZ5E_A3L8J1zZigO8i8m5AFUTn9SjbY1sx16kA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, 22 Oct 2020, Geert Uytterhoeven wrote:

> 
> Thanks for your patch...
> 

You're welcome.

> I can't say I'm a fan of this...
> 

Sorry.

> 
> The real issue is this "extern struct platform_device scc_a_pdev, 
> scc_b_pdev", circumventing the driver framework.
> 
> Can we get rid of that?
> 

Is there a better alternative?

pmz_probe() is called by console_initcall(pmz_console_init) when 
CONFIG_SERIAL_PMACZILOG_CONSOLE=y because this has to happen earlier than 
the normal platform bus probing which takes place later as a typical 
module_initcall.
