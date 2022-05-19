Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFC83C433F5
	for <linux-serial@archiver.kernel.org>; Thu, 19 May 2022 16:23:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232805AbiESQXe (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 19 May 2022 12:23:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230526AbiESQXd (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 19 May 2022 12:23:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0237C1EE7;
        Thu, 19 May 2022 09:23:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8911661C5A;
        Thu, 19 May 2022 16:23:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 752A7C385AA;
        Thu, 19 May 2022 16:23:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1652977411;
        bh=8/iOgXriXhlIGY9edq3zMzFd7FKK3tPZq7aLsWhaTlU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BthxdFiQwLt24VzhXXNJa+X73TbsD5jk79WfNbMxBJOwKASKGLtIbuGamgMNdYt5d
         2HsHi6HzYFQVsMadXpS1hFqoxxVpnRmnS8JqoEuiEWqydg4/flIvLOc+qvqoPE2MWR
         apqPMifRscrUSKsKyGuaPj2IYazNWZzfuQM+/JNc=
Date:   Thu, 19 May 2022 18:23:28 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        linux-serial <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 1/4] serial: pmac_zilog: remove unfinished DBDMA support
Message-ID: <YoZvAJ2y+XS9WP9S@kroah.com>
References: <20220519075653.31356-1-jslaby@suse.cz>
 <2f7a739f-61b4-a1af-7c9b-70c5b93c6281@linux.intel.com>
 <b61169e6-259c-f47e-b91f-c6cf3a5e5f39@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b61169e6-259c-f47e-b91f-c6cf3a5e5f39@kernel.org>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, May 19, 2022 at 11:02:23AM +0200, Jiri Slaby wrote:
> On 19. 05. 22, 10:56, Ilpo Järvinen wrote:
> > On Thu, 19 May 2022, Jiri Slaby wrote:
> > 
> > > The support for DBDMA was never completed. Remove the the code that only
> > > maps spaces without real work.
> > > 
> > > Cc: Michael Ellerman <mpe@ellerman.id.au>
> > > Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > > Cc: Paul Mackerras <paulus@samba.org>
> > > Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> > > ---
> > >   drivers/tty/serial/pmac_zilog.c | 38 +--------------------------------
> > >   drivers/tty/serial/pmac_zilog.h |  9 --------
> > >   2 files changed, 1 insertion(+), 46 deletions(-)
> > > 
> > > diff --git a/drivers/tty/serial/pmac_zilog.c b/drivers/tty/serial/pmac_zilog.c
> > > index c903085acb8d..2953ff64a892 100644
> > > --- a/drivers/tty/serial/pmac_zilog.c
> > > +++ b/drivers/tty/serial/pmac_zilog.c
> > 
> > How about dropping this too:
> > #include <asm/dbdma.h>
> 
> Good point, fixed, will send v2 eventually.

Add-on patch is fine, thanks!

greg k-h
