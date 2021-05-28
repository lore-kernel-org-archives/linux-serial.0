Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A930C4708C
	for <linux-serial@archiver.kernel.org>; Fri, 28 May 2021 09:03:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 536FF613DA
	for <linux-serial@archiver.kernel.org>; Fri, 28 May 2021 09:03:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234770AbhE1JFb (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 28 May 2021 05:05:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:58098 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234769AbhE1JFb (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 28 May 2021 05:05:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2CE4D61222;
        Fri, 28 May 2021 09:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1622192636;
        bh=WDJo2X/13nKa4nbTGm3lVorzD0sNu2kPcS/rS1lAivU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gWSRtwbteWsYBbIL6OeZ4ipidV4E3qtOaduG6WAEgS7CDrd0/nuUl8Oa74F3+Zqu5
         z9CrL2nlrZTodGH35HXyKY2ZnwbhfHc/0yl5jHGkY/6rMqASVxhTO0u/FeWPGdMxlZ
         ngwze2ExPDAPxGen4+m5zCnhwquhzVxiVW8UGFJs=
Date:   Fri, 28 May 2021 11:03:54 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        kernel@collabora.com
Subject: Re: [PATCHv5 0/2] Fix imx53-ppd UART configuration
Message-ID: <YLCx+jhg/j+JmBox@kroah.com>
References: <20210430175038.103226-1-sebastian.reichel@collabora.com>
 <YIzxKNV4x6/8GVrB@kroah.com>
 <20210528004952.r2dnoxetqdi655d6@earth.universe>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210528004952.r2dnoxetqdi655d6@earth.universe>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, May 28, 2021 at 02:49:52AM +0200, Sebastian Reichel wrote:
> Hi Greg,
> 
> On Sat, May 01, 2021 at 08:11:52AM +0200, Greg Kroah-Hartman wrote:
> > On Fri, Apr 30, 2021 at 07:50:36PM +0200, Sebastian Reichel wrote:
> > > IMHO PATCHv4 was better, but in the end I don't have strong feelings
> > > about this. Btw. I think this patchset is a good demonstration of
> > > frustrating upstream kernel development can be considering PATCHv5
> > > is basically the same as PATCHv1. Thanks for making us go in
> > > circles :(
> > > 
> > > Changes since PATCHv4:
> > >  * https://lore.kernel.org/lkml/20210305115058.92284-1-sebastian.reichel@collabora.com/
> > >  * use DT property instead of sysfs config option, like the initial patch
> > >    version did as requested by Greg.
> > > 
> > > Changes since PATCHv3:
> > >  * https://lore.kernel.org/lkml/1539249903-6316-1-git-send-email-fabien.lahoudere@collabora.com/
> > >  * rewrote commit message to provide a lot more details why this is needed
> > >  * rebased to torvalds/master (5.12-rc1-dontuse), also applies on top of linux-next
> > >  * use sysfs_emit() instead of sprintf
> > > 
> > > -- Sebastian
> > > 
> > > Fabien Lahoudere (2):
> > >   serial: imx: Add DMA buffer configuration via DT
> > >   ARM: dts: imx53-ppd: add dma-info nodes
> > > 
> > >  .../bindings/serial/fsl-imx-uart.yaml         | 12 +++++++++
> > >  arch/arm/boot/dts/imx53-ppd.dts               |  2 ++
> > >  drivers/tty/serial/imx.c                      | 25 +++++++++++++------
> > >  3 files changed, 32 insertions(+), 7 deletions(-)
> >
> > This is the friendly semi-automated patch-bot of Greg Kroah-Hartman.
> > You have sent him a patch that has triggered this response.
> > 
> > Right now, the development tree you have sent a patch for is "closed"
> > due to the timing of the merge window.  Don't worry, the patch(es) you
> > have sent are not lost, and will be looked at after the merge window is
> > over (after the -rc1 kernel is released by Linus).
> > 
> > So thank you for your patience and your patches will be reviewed at this
> > later time, you do not have to do anything further, this is just a short
> > note to let you know the patch status and so you don't worry they didn't
> > make it through.
> > 
> > thanks,
> > 
> > greg k-h's patch email bot
> 
> Any update on this? :)

I'm waiting for the DT maintainers to review the new changes before I
can take the driver changes.

thanks,

greg k-h
