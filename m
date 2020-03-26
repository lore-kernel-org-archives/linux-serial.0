Return-Path: <SRS0=p7su=5L=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55040C43331
	for <linux-serial@archiver.kernel.org>; Thu, 26 Mar 2020 14:32:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F31420775
	for <linux-serial@archiver.kernel.org>; Thu, 26 Mar 2020 14:32:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585233161;
	bh=2unZXsfXGiiwQhWbjl1kP114RQvv7sM/ehc4It/7EfI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=QyM/uG5jqzyMPW5kyz6w8sKI/capzfrkpPpKmVglLt2GirT+XwTLrmuMExGU1kJDs
	 rwbdvI/s5BWz7lafxc/keVAtDgLYdc+n/y0vvbg/6MXJZ8VRhf74OCgI/9mXgxR8x3
	 TB3G30TOd5HtR1s1XMTLU2StQ4DItmJI3hEDKSHM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728331AbgCZOck (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 26 Mar 2020 10:32:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:42630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727944AbgCZOck (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 26 Mar 2020 10:32:40 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5ED042073E;
        Thu, 26 Mar 2020 14:32:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585233158;
        bh=2unZXsfXGiiwQhWbjl1kP114RQvv7sM/ehc4It/7EfI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iP1jZIWDDtdVjpcWzS6bxigS02fS6kEKL1j+a4h8tVzbngrPYZixeAIuDwj8ScSyO
         vqYVzznYonRgx5V5CeExlKr2pgebxEgQ0Cg3Fkvdq2llY7UbFAM+DeMTax9nJadNOS
         0doJMQqMbOhkJ3OeZ6TNH1yj0BxSStkdr8vFjLP0=
Date:   Thu, 26 Mar 2020 15:32:36 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Leonard Crestez <leonard.crestez@nxp.com>
Cc:     Michael Walle <michael@walle.cc>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jiri Slaby <jslaby@suse.com>, Andy Duan <fugang.duan@nxp.com>
Subject: Re: [PATCH v2 1/2] tty: serial: fsl_lpuart: move dma_request_chan()
Message-ID: <20200326143236.GA1372760@kroah.com>
References: <20200325090658.25967-1-michael@walle.cc>
 <VI1PR04MB69417B19A6FFF0AA22585884EECE0@VI1PR04MB6941.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <VI1PR04MB69417B19A6FFF0AA22585884EECE0@VI1PR04MB6941.eurprd04.prod.outlook.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Mar 25, 2020 at 06:05:16PM +0000, Leonard Crestez wrote:
> On 2020-03-25 11:07 AM, Michael Walle wrote:
> > Move dma_request_chan() out of the atomic context. First this call
> > should not be in the atomic context at all and second the
> > dev_info_once() may cause a hang because because the console takes this
> > spinlock, too.
> > 
> > Fixes: 159381df1442f ("tty: serial: fsl_lpuart: fix DMA operation when using IOMMU")
> > Reported-by: Leonard Crestez <leonard.crestez@nxp.com>
> > Signed-off-by: Michael Walle <michael@walle.cc>
> > ---
> > changes since v1:
> >   - instead of just moving the dev_info_once() out of the spinlock protected
> >     section, move the whole dma_request_chan(). Thanks Andy!
> > 
> > I've tested this on my board. Andy, Leonard, can you double check it? For
> > all which are not aware, this deadlock happens only if you have the kernel
> > console output on the lpuart, so if someone wants to test it, make sure you
> > have something like console=ttyLP0,115200.
> > 
> >   drivers/tty/serial/fsl_lpuart.c | 36 +++++++++++++++++++++------------
> >   1 file changed, 23 insertions(+), 13 deletions(-)
> 
> Tested-by: Leonard Crestez <leonard.crestez@nxp.com>
> 
> Since the original commit only made it into next it might make sense to 
> squash the commits in the tty tree.
> 
> This way future bisections won't get stuck on a boot failure.

My tree does not rebase, sorry.  And neither should any other public git
tree without really really good reasons.

thanks,

greg k-h
