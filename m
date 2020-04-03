Return-Path: <SRS0=+zim=5T=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04911C43331
	for <linux-serial@archiver.kernel.org>; Fri,  3 Apr 2020 09:44:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9F75208E4
	for <linux-serial@archiver.kernel.org>; Fri,  3 Apr 2020 09:44:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585907071;
	bh=JZdgbxojaFXqEniYk+LRNZx0nJZ1n6has4h4/C53gRw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=lAZ7NbIgiH0zfmsUoHqVhI6O5yHoFmzwe5mX8n2bHtsCf5tsRqFJ8ymGN18DhQ6Sp
	 IJjhYEQM87INfKl6ckgDFt6P+Ro26vVifIw1n2O5U7ISF2OvuP/aprMlj0KZlXyBFw
	 RcmmlPqWQfXAXk+26aDM61J+pm7TcPIEE0Y/NFjQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389998AbgDCJob (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 3 Apr 2020 05:44:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:48810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727924AbgDCJob (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 3 Apr 2020 05:44:31 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2AC482080C;
        Fri,  3 Apr 2020 09:44:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585907070;
        bh=JZdgbxojaFXqEniYk+LRNZx0nJZ1n6has4h4/C53gRw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yWhCY8DotHZ0SZufEDg33AVRBGq+vMKbJMMyIwZjAX9yhOrpiiSuy8ajbiI4cvVdT
         OzCq1Q6ZfzJa5Q18h5BFELlviTQaSjMpQ33R4zYVsF0DYJfhh2ntPW1f3kXAYTwwvx
         lFaeXPYyYhQlCZ0zo7ur6s4CcM9SGUEruAmqdqto=
Date:   Fri, 3 Apr 2020 11:44:27 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Michal Simek <michal.simek@xilinx.com>
Cc:     johan@kernel.org, linux-kernel@vger.kernel.org, monstr@monstr.eu,
        git@xilinx.com, Jiri Slaby <jslaby@suse.com>,
        linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH 0/7] serial: uartps: Revert dynamic port allocation
Message-ID: <20200403094427.GA3754220@kroah.com>
References: <cover.1585905873.git.michal.simek@xilinx.com>
 <20200403093216.GA3746303@kroah.com>
 <d9598635-a8ef-eff2-22e8-4fa37f8390b3@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d9598635-a8ef-eff2-22e8-4fa37f8390b3@xilinx.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Apr 03, 2020 at 11:37:46AM +0200, Michal Simek wrote:
> On 03. 04. 20 11:32, Greg KH wrote:
> > On Fri, Apr 03, 2020 at 11:24:29AM +0200, Michal Simek wrote:
> >> Hi,
> >>
> >> there were several changes done in past in uartps drivers which have been
> >> also done in uartlite driver.
> >> Here is the thread about it
> >> https://lore.kernel.org/linux-serial/20191203152738.GF10631@localhost/
> >>
> >> This series reverts all patches which enabled dynamic port allocation and
> >> returning driver to the previous state. There were added some features in
> >> meantime which are not affected by this series.
> > 
> > Should this go into 5.7-final as it's causing problems now, and
> > backported as well?  Or can it wait until 5.8-rc1?
> 
> These patches have been added to v4.20. It means all version from that
> are affected.
> 
> The issue I am aware of is when you setup stdout-path =
> "serialX:115200n8" where X is not 0.
> 
> But as was discussed the concept is based on Johan wrong that's why it
> can be consider as bug fix.

Ok, I'll queue these up after 5.7-rc1 is out, for inclusion in
5.7-final, and cc: for stable, as I agree, they should all be reverted.
Thanks for doing the work.

greg k-h
