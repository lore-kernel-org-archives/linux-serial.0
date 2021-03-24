Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D6FBC433E2
	for <linux-serial@archiver.kernel.org>; Wed, 24 Mar 2021 06:06:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2AA5D619C7
	for <linux-serial@archiver.kernel.org>; Wed, 24 Mar 2021 06:06:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235469AbhCXGFZ (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 24 Mar 2021 02:05:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:41836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235450AbhCXGEz (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 24 Mar 2021 02:04:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BB269619C7;
        Wed, 24 Mar 2021 06:04:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1616565895;
        bh=XWHDoRNo/SbiDhxBhdCWg2aKWnxSmfL5zY03GlP5ZxQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aL26xrzyOX/byfnAUGEzC0khZ8pV2Pmhubr52R7D4iN5/riQNlIlmmO0EtB4b4D+Z
         KtGBb7v6UsNqDWxFiIQ7jwMBpGdLKbj5E10kXlqAi0uIi0cr7kZg28cf90LgjpTgUF
         CTMuWxzmO64LimiomsYTCU8sZA6CLyWMA4+FsfHA=
Date:   Wed, 24 Mar 2021 07:04:14 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Alex Nemirovsky <Alex.Nemirovsky@cortina-access.com>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        Jason Li <jason.li@cortina-access.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
Subject: Re: [PATCH 1/3] tty: serial: Add UART driver for Cortina-Access
 platform
Message-ID: <YFrWXtYKnBCYMnYd@kroah.com>
References: <1613702532-5096-1-git-send-email-alex.nemirovsky@cortina-access.com>
 <YFmzax3pWFNtFbn9@kroah.com>
 <04208957-55F9-47E8-A20A-4DEB2A35040E@cortina-access.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <04208957-55F9-47E8-A20A-4DEB2A35040E@cortina-access.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Mar 23, 2021 at 07:28:51PM +0000, Alex Nemirovsky wrote:
> 
> 
> > On Mar 23, 2021, at 2:22 AM, Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> > 
> > On Thu, Feb 18, 2021 at 06:42:09PM -0800, Alex Nemirovsky wrote:
> >> From: Jason Li <jason.li@cortina-access.com>
> >> 
> >> This driver supports Cortina Access UART IP integrated
> >> in most all CAXXXX line of SoCs. Earlycom is also supported
> >> 
> >> Signed-off-by: Jason Li <jason.li@cortina-access.com>
> >> Reviewed-by: Alex Nemirovsky <alex.nemirovsky@cortina-access.com>
> >> ---
> >> MAINTAINERS                                |   5 +
> >> drivers/tty/serial/Kconfig                 |  19 +
> >> drivers/tty/serial/Makefile                |   1 +
> >> drivers/tty/serial/serial_cortina-access.c | 798 +++++++++++++++++++++++++++++
> >> include/uapi/linux/serial_core.h           |   3 +
> >> 5 files changed, 826 insertions(+)
> >> create mode 100644 drivers/tty/serial/serial_cortina-access.c
> >> 
> >> Change log
> >>  drivers/tty/serial/serial_cortina-access.c
> >>   v3:
> >>    - Remove usage of uintptr_t. Change to pointer to driver's private
> >>      structure instead.
> > 
> > Is this really a "v3"?  The subject lines do not show that, so I'm
> > totally confused as to what to review and what has been reviewed here.
> > 
> > Please fix this up and submit a "v4" so we know what is going on :)
> 
> Could you recommend a method or a tool to update the commit subject id with a version prefix?
> Currently we are doing a git format-patch and the subject line is automatically created without a 
> version number. Do you just go in manual and edit the resulting patch contents file or do you use a 
> tool to assist in this?

This is only 3 patches, they are easy to edit by hand...  :)

Anyway 'git format-patch' can do this automatically for you if you want,
see the -v or --reroll-count option.

thanks,

greg k-h
