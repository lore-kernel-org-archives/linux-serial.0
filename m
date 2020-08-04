Return-Path: <SRS0=ea2O=BO=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACA67C433DF
	for <linux-serial@archiver.kernel.org>; Tue,  4 Aug 2020 16:12:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9CBAB2086A
	for <linux-serial@archiver.kernel.org>; Tue,  4 Aug 2020 16:12:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729767AbgHDQME (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 4 Aug 2020 12:12:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726027AbgHDQLk (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 4 Aug 2020 12:11:40 -0400
X-Greylist: delayed 17925 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 04 Aug 2020 09:11:40 PDT
Received: from hera.aquilenet.fr (hera.aquilenet.fr [IPv6:2a0c:e300::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22F9DC06174A;
        Tue,  4 Aug 2020 09:11:40 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by hera.aquilenet.fr (Postfix) with ESMTP id 8E93DE765;
        Tue,  4 Aug 2020 18:11:37 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at aquilenet.fr
Received: from hera.aquilenet.fr ([127.0.0.1])
        by localhost (hera.aquilenet.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id sDQfZDMn0Rnd; Tue,  4 Aug 2020 18:11:36 +0200 (CEST)
Received: from function (lfbn-bor-1-797-11.w86-234.abo.wanadoo.fr [86.234.239.11])
        by hera.aquilenet.fr (Postfix) with ESMTPSA id D4671E2D2;
        Tue,  4 Aug 2020 18:11:36 +0200 (CEST)
Received: from samy by function with local (Exim 4.94)
        (envelope-from <samuel.thibault@ens-lyon.org>)
        id 1k2zXL-0027ud-Um; Tue, 04 Aug 2020 18:11:35 +0200
Date:   Tue, 4 Aug 2020 18:11:35 +0200
From:   Samuel Thibault <samuel.thibault@ens-lyon.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, speakup@linux-speakup.org
Subject: Re: [PATCH 2/2] speakup: only build serialio when ISA is enabled
Message-ID: <20200804161135.pgwqbaahdtxhe7cq@function>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, speakup@linux-speakup.org
References: <20200804111332.dex7jobmabifdzw5@function>
 <20200804113413.GA181242@kroah.com>
 <20200804114951.ijs3hnezi4f64nll@function>
 <20200804115817.GC203147@kroah.com>
 <20200804153542.zowupa4ygdgxnciu@function>
 <20200804154952.GB495852@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200804154952.GB495852@kroah.com>
Organization: I am not organized
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Greg KH, le mar. 04 août 2020 17:49:52 +0200, a ecrit:
> > #define inb(c)		({ u8  __v; __io_pbr(); __v = readb_cpu((void*)(PCI_IOBASE + (c))); __io_par(__v); __v; })
> > 
> > and thus yes it's arithmetic over a (void*) pointer, the caller cannot
> > do anything about it.
> 
> And that's fine, math with pointers, even void ones, is ok.

C++ doesn't like it, but in general compilers provide some semantic for
it, yes.

> I wonder why riscv was complaining about that.  It's not nice, but it is
> valid C.

Strictly C speaking, no, but GNU C yes.

> Let's see if any of their developers care about it :)

Ok :) In the meanwhile I sent a v2 series that should fix the different
link cases, just not the particular riscv warning.

Samuel
