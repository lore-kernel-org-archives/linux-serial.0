Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59706C433E0
	for <linux-serial@archiver.kernel.org>; Thu, 18 Feb 2021 07:30:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3F4964DDA
	for <linux-serial@archiver.kernel.org>; Thu, 18 Feb 2021 07:30:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230492AbhBRH3W (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 18 Feb 2021 02:29:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:37122 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231173AbhBRHVB (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 18 Feb 2021 02:21:01 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4F62A64E3E;
        Thu, 18 Feb 2021 07:11:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1613632297;
        bh=jWE6ajcFqYHg9/Cyxvv8DhMQh3IGWduTTVlQPNAiu0U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AQLh40Cp9c+E9cUMGQUDfv7L8pVrXKPlA6ubFy8yHIMGXl9o8D3bBY+LPybCQy4Hu
         gcG81yaWVUTZSqk4UOAoRzvZ16rjRDVll2UZKUk85qoXPhR/xyiX7wkOgDW4BGk1km
         +MwgIXqo55e4KTSF+wmm0QkYbLxZVlulGJniBMPM=
Date:   Thu, 18 Feb 2021 08:11:33 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc:     Alexander Shiyan <shc_work@mail.ru>, linux-serial@vger.kernel.org,
        Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH] Revert "serial: max310x: rework RX interrupt handling"
Message-ID: <YC4TJQew3QK4iPvP@kroah.com>
References: <20210217080608.31192-1-shc_work@mail.ru>
 <20210217235345.7326201b@windsurf.home>
 <20210218065553.864bbf0cc2b3d398504c5b95@mail.ru>
 <20210218075127.5023d878@windsurf.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210218075127.5023d878@windsurf.home>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Feb 18, 2021 at 07:51:27AM +0100, Thomas Petazzoni wrote:
> Hello,
> 
> On Thu, 18 Feb 2021 06:55:53 +0300
> Alexander Shiyan <shc_work@mail.ru> wrote:
> 
> > I wrote a little inaccurately, I did not mean a physical interface RS-485,
> > but rather a time-critical MODBUS protocol. (In our case it used on top on RS-485).
> 
> OK, so it's not about 232 vs 485.
> 
> > I do not know how best to solve this problem, it may be an additional parameter
> > for the devicetree, but in this case it is not clear how to manage it if the
> > devicetree is not used ...
> 
> No, it cannot be a parameter in the Device Tree, as what we're talking
> about is not hardware description, but configuration of the hardware
> for particular use cases.
> 
> > This could be a Kconfig item (but something's not very good either).
> > Probably the best solution is to adapt some kind of IOCTL (or control via SYSFS).
> 
> Greg, Jiri, perhaps you could comment on what would be the appropriate
> user-space interface to use or add to be able to configure such aspects
> of a UART controller ?

What aspects need configuring and why is this uart so unique from all
others that it can't use the normal configuration methods?

thanks,

greg k-h
