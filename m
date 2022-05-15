Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46F57C4332F
	for <linux-serial@archiver.kernel.org>; Sun, 15 May 2022 11:02:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231247AbiEOLCZ (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 15 May 2022 07:02:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233018AbiEOLCX (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sun, 15 May 2022 07:02:23 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0192625592;
        Sun, 15 May 2022 04:02:22 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 3BAD292009C; Sun, 15 May 2022 13:02:20 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 2D02192009B;
        Sun, 15 May 2022 12:02:20 +0100 (BST)
Date:   Sun, 15 May 2022 12:02:20 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Akira Yokosawa <akiyks@gmail.com>
cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
        linux-serial@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH 0/3] Documentation: Fix issues with Oxford Semiconductor
 PCIe (Tornado) 950
In-Reply-To: <f4d40da6-756b-9e75-b867-cc9eedc4b232@gmail.com>
Message-ID: <alpine.DEB.2.21.2205151152360.10656@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2205131712410.10656@angie.orcam.me.uk> <f4d40da6-756b-9e75-b867-cc9eedc4b232@gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Sun, 15 May 2022, Akira Yokosawa wrote:

> >  NB XeTeX, Version 3.14159265-2.6-0.99999 (TeX Live 2019/dev/Debian) and 
> > Sphinx 1.8.4 here.
> 
> As mentioned in the section titled "PDF and LaTeX builds" in
> Documentation/doc-guide/sphinx.rst, "make pdfdocs" requires Sphinx 2.4 or
> later.

 Ack, noted.  Note however that Documentation/Changes says:

Sphinx\ [#f1]_         1.7              sphinx-build --version
====================== ===============  ========================================
.. [#f1] Sphinx is needed only to build the Kernel documentation

Perhaps the additional requirement could be mentioned in the footnote?

[Also this is a production system and 1.8.4 is the only version available 
in the distribution it has installed, so I may not be able to upgrade for 
the foreseeable future anyway.]

> You can say "make SPHINXDIRS=<sub dir> htmldocs pdfdocs" to
> test-build docs under Documentation/<sub dir>/.
> You might see false warnings of "WARNING: undefined label: ..."
> which you wouldn't see in full builds, though.
> 
> Hope this helps.

 Sure, thanks a lot!

  Maciej
