Return-Path: <SRS0=9Cit=CG=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBCDCC433E6
	for <linux-serial@archiver.kernel.org>; Fri, 28 Aug 2020 08:18:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98F5A20776
	for <linux-serial@archiver.kernel.org>; Fri, 28 Aug 2020 08:18:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598602721;
	bh=73FhKi65XqUq6hi2IN55t0uqmSmIWYCAODCd/AinFj8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=j+1yzTC89aTEVBvv7MtXyMfivZ6HjaynE/cfjem8PtmUaB7R094L+ZBiy3xHSC9+q
	 byAio7tmk40STaKfkkdc5l7Mz1XTAVbbaBZIu0q8SQ2aEwLh1uHnFZ2C5XcCVzgsYy
	 +2mhJTl9QQ3oQJygXqR20KZdNxdcm5MsWIyMLuJ4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728501AbgH1ISj (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 28 Aug 2020 04:18:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:55962 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726834AbgH1ISi (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 28 Aug 2020 04:18:38 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6796E20776;
        Fri, 28 Aug 2020 08:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598602718;
        bh=73FhKi65XqUq6hi2IN55t0uqmSmIWYCAODCd/AinFj8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nJsPSQJEodX0ILukgCu32ZmCyFPd04361JBvas+tLcZqSeuXnBYQE6EWhzOZiCBot
         V+CSUzgLhcKl2HAP+JS+kdHG0DHJXBDgm52im535Wzdhvp5YDXJuMS0qpX6oJEJEvp
         QOsXVXqsaMOdyZmCeyfd2EFKXoSsP19IZMPaIATg=
Date:   Fri, 28 Aug 2020 10:18:49 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Paras Sharma <parashar@codeaurora.org>
Cc:     Jiri Slaby <jslaby@suse.com>, linux-arm-msm@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] serial: qcom_geni_serial: To correct QUP Version
 detection logic
Message-ID: <20200828081849.GC1007729@kroah.com>
References: <1597131794-1076-1-git-send-email-parashar@codeaurora.org>
 <20200811082330.GC113774@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200811082330.GC113774@kroah.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Aug 11, 2020 at 10:23:30AM +0200, Greg Kroah-Hartman wrote:
> On Tue, Aug 11, 2020 at 01:13:14PM +0530, Paras Sharma wrote:
> > The current implementation reduces the sampling rate by half
> > if qup HW version greater is than 2.5 by checking if the geni
> > SE major version is greater than 2 and geni SE minor version
> > is greater than 5.
> > 
> > This implementation fails when the version is 3 or greater.
> > 
> > Hence by adding the another check for geni SE major version,
> > this problem can be solved.
> > 
> > Signed-off-by: Paras Sharma <parashar@codeaurora.org>
> > ---
> >  drivers/tty/serial/qcom_geni_serial.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> Should this go to stable kernels?  If so, how far back?  What git commit
> id is this patch fixing?  And if so, why not put a Fixes: tag on this as
> well?

Dropped from my review queue due to lack of response, please fix up and
resend when you wish to have it reviewed again...

greg k-h
