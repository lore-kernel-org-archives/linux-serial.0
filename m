Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD5EBC433EF
	for <linux-serial@archiver.kernel.org>; Sun, 17 Apr 2022 23:03:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235336AbiDQXFo (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 17 Apr 2022 19:05:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235335AbiDQXFi (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sun, 17 Apr 2022 19:05:38 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3D27618B08;
        Sun, 17 Apr 2022 16:02:55 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 734BE9200BB; Mon, 18 Apr 2022 01:02:54 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 711349200B4;
        Mon, 18 Apr 2022 00:02:54 +0100 (BST)
Date:   Mon, 18 Apr 2022 00:02:54 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
cc:     Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND][PATCH v3 1/2] serial: 8250: Fold EndRun device support
 into OxSemi Tornado code
In-Reply-To: <Ylk3HNZqnBLMMQCm@kroah.com>
Message-ID: <alpine.DEB.2.21.2204172339300.9383@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2203310114210.44113@angie.orcam.me.uk> <alpine.DEB.2.21.2203310121211.44113@angie.orcam.me.uk> <Ylk3HNZqnBLMMQCm@kroah.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, 15 Apr 2022, Greg Kroah-Hartman wrote:

> > Index: linux-macro/include/linux/pci_ids.h
> > ===================================================================
> > --- linux-macro.orig/include/linux/pci_ids.h
> > +++ linux-macro/include/linux/pci_ids.h
> > @@ -2622,6 +2622,9 @@
> >  #define PCI_DEVICE_ID_DCI_PCCOM8	0x0002
> >  #define PCI_DEVICE_ID_DCI_PCCOM2	0x0004
> >  
> > +#define PCI_VENDOR_ID_ENDRUN		0x7401
> > +#define PCI_DEVICE_ID_ENDRUN_1588	0xe100
> 
> As per the top of this file, this should not be needed here as you are
> only using it in one file.  Please leave it as-is.

 I find this requirement silly, but here it's not the place to discuss it, 
so I have removed this part as requested.  At least it's not inline magic 
numbers here.

  Maciej
