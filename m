Return-Path: <SRS0=UUkf=D3=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1E75C4363A
	for <linux-serial@archiver.kernel.org>; Tue, 20 Oct 2020 23:28:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E741223C6
	for <linux-serial@archiver.kernel.org>; Tue, 20 Oct 2020 23:28:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439289AbgJTX2e (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 20 Oct 2020 19:28:34 -0400
Received: from cynthia.allandria.com ([50.242.82.17]:41706 "EHLO
        cynthia.allandria.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439288AbgJTX2e (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 20 Oct 2020 19:28:34 -0400
X-Greylist: delayed 2619 seconds by postgrey-1.27 at vger.kernel.org; Tue, 20 Oct 2020 19:28:33 EDT
Received: from flar by cynthia.allandria.com with local (Exim 4.84_2)
        (envelope-from <flar@allandria.com>)
        id 1kV0N4-00040j-JM; Tue, 20 Oct 2020 15:44:46 -0700
Date:   Tue, 20 Oct 2020 15:44:46 -0700
From:   Brad Boyer <brad@allandria.com>
To:     Laurent Vivier <laurent@vivier.eu>
Cc:     Greg KH <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
        Joshua Thompson <funaho@jurai.org>,
        linux-serial@vger.kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linux-m68k@lists.linux-m68k.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH] serial: pmac_zilog: don't init if zilog is not available
Message-ID: <20201020224446.GA15066@allandria.com>
References: <20201020162303.1730562-1-laurent@vivier.eu>
 <20201020162844.GA865546@kroah.com>
 <468bbbef-4745-3b16-b6f4-30b46ebcdc33@vivier.eu>
 <20201020173745.GA882703@kroah.com>
 <387fd2aa-b181-c41f-0581-0a7e79a44e41@vivier.eu>
 <20201020183246.GA912431@kroah.com>
 <b52e7fde-8874-3c53-ca13-7709656b69fb@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b52e7fde-8874-3c53-ca13-7709656b69fb@vivier.eu>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Oct 20, 2020 at 08:42:53PM +0200, Laurent Vivier wrote:
> Le 20/10/2020 ?? 20:32, Greg KH a ??crit??:
> > On Tue, Oct 20, 2020 at 08:19:26PM +0200, Laurent Vivier wrote:
> >> Le 20/10/2020 ?? 19:37, Greg KH a ??crit??:
> >>> Why not fix it to work properly like other arch checks are done
> >> I would be happy to do the same.
> >>
> >>> Put it in a .h file and do the #ifdef there.  Why is this "special"?
> >>
> >> I don't know.
> >>
> > 
> > Yup, that would be a good start, but why is the pmac_zilog.h file
> > responsible for this?  Shouldn't this be in some arch-specific file
> > somewhere?
> 
> For m68k, MACH_IS_MAC is defined in arch/m68k/include/asm/setup.h
> 
> If I want to define it for any other archs I don't know in which file we
> can put it.
> 
> But as m68k mac is only sharing drivers with pmac perhaps we can put
> this in arch/powerpc/include/asm/setup.h?

Wouldn't it be better to rearrange this code to only run if the devices
are present? This is a macio driver on pmac and a platform driver on mac,
so shouldn't it be possible to only run this code when the appropriate
entries are present in the right data structures?

I didn't look at a lot of the other serial drivers, but some other mac
drivers have recently been updated to no longer have MACH_IS_MAC checks
due to being converted to platform drivers.

	Brad Boyer
	brad@allandria.com

