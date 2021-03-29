Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52D26C433DB
	for <linux-serial@archiver.kernel.org>; Mon, 29 Mar 2021 06:12:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27FAD61968
	for <linux-serial@archiver.kernel.org>; Mon, 29 Mar 2021 06:12:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229483AbhC2GLz (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 29 Mar 2021 02:11:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:51674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229971AbhC2GLX (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 29 Mar 2021 02:11:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3E0496191A;
        Mon, 29 Mar 2021 06:11:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1616998282;
        bh=Zegaaphv9aRCYkUmr3zg0QSU7np560duDWeNJWz0ws4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LEqLSog5voxrgXZPhn57yN+mzB4LCOumTFko2vzdDBjmJ5iTxEC/Izxfu/FvTrXIF
         1sgCOlGAApUnqy1bur1CtXjZlSNN0no6rSkW4xtCs4uPWlKhVxU2KyjnaD2fjTYUwf
         rc0JFBGSgcGk8iaNyf0HsHntomcyHxAbqbwjZkOE=
Date:   Mon, 29 Mar 2021 08:11:19 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     LakshmiPraveen Kopparthi <LakshmiPraveen.Kopparthi@microchip.com>
Cc:     linux-serial@vger.kernel.org,
        Ganesh Kumar Gurumurthy <GaneshKumar.Gurumurthy@microchip.com>
Subject: Re: git tree - branch to use for patch for UART(8250) drivers
Message-ID: <YGFvh9jrTawRHysT@kroah.com>
References: <e93aeae4a727b13b541973fe63240278217e2b45.camel@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e93aeae4a727b13b541973fe63240278217e2b45.camel@microchip.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, Mar 29, 2021 at 11:34:02AM +0530, LakshmiPraveen Kopparthi wrote:
> Dear Maintainers,
> I am planning to submit a patch to add support for one of our PCIe to
> UART(16550) modules.I have found the the following tree in the
> MAINTAINERS file for 8250/16?50 serial drivers.
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git
> 
> The master branch in this tree doesn't have any check in from 2020-06-
> 14.

What check specifically are you looking for?  What commit id?

> I would like to know which branch to be used as a base to generate
> and submit the patch. 

If this is a bugfix, you can make it against the tty-linus or main
branch, as the main branch tracks Linus's current tree within a -rc or
two, and the tty-linus branch has the fixes that I will be sending to
him for this release.

If it is for a new feature, the tty-next branch is what you should make
it against.

If you have any problems with this, please let me know.

thanks,

greg k-h
