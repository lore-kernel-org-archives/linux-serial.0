Return-Path: <SRS0=K9fp=4L=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9D19C35670
	for <linux-serial@archiver.kernel.org>; Sun, 23 Feb 2020 08:22:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8031C206ED
	for <linux-serial@archiver.kernel.org>; Sun, 23 Feb 2020 08:22:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726208AbgBWIWE (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 23 Feb 2020 03:22:04 -0500
Received: from bmailout3.hostsharing.net ([176.9.242.62]:39751 "EHLO
        bmailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725980AbgBWIWE (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sun, 23 Feb 2020 03:22:04 -0500
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id 8B29C1003D015;
        Sun, 23 Feb 2020 09:22:01 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 4117A47F54; Sun, 23 Feb 2020 09:22:01 +0100 (CET)
Date:   Sun, 23 Feb 2020 09:22:01 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Ronald =?iso-8859-1?Q?Tschal=E4r?= <ronald@innovation.ch>,
        Rob Herring <robh@kernel.org>, Jiri Slaby <jslaby@suse.com>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH] serdev: Fix detection of UART devices on Apple machines.
Message-ID: <20200223082201.urcwwykmggxsmkoo@wunner.de>
References: <20200211194723.486217-1-ronald@innovation.ch>
 <20200219111519.GB2814125@kroah.com>
 <20200220063335.GA9421@innovation.ch>
 <20200220064723.GA3192090@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200220064723.GA3192090@kroah.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Feb 20, 2020 at 07:47:23AM +0100, Greg Kroah-Hartman wrote:
> On Wed, Feb 19, 2020 at 10:33:35PM -0800, Ronald Tschalär wrote:
> > On Wed, Feb 19, 2020 at 12:15:19PM +0100, Greg Kroah-Hartman wrote:
> > > On Tue, Feb 11, 2020 at 11:47:23AM -0800, Ronald Tschalär wrote:
> > > > +#include <linux/platform_data/x86/apple.h>
> > > 
> > > Why is this needed?  Just for the x86_apple_machine variable?
> 
> That's fine, but what I am objecting to is platform-specific include
> files being added to random common kernel code.  There's no real reason
> for this other than one specific hardware platform has a quirk.  Are we
> supposed to keep this pattern up by doing tons of:
> 	#include <linux/platform_data/x86/vendor_X>
> 	#include <linux/platform_data/x86/vendor_Y>
> 	#include <linux/platform_data/x86/vendor_Z>
> all through the kernel?
> 
> That's a serious regression to the "bad old days" of platform specific
> crud being required in each and every driver subsystem.
> 
> Now I know it's not your fault this is needed for your one change, but
> can you work on a patch series to fix this all up so that it is not
> needed?  I'm sure the x86 maintainers don't want to see this spread
> around.

Andy (+cc) submitted a patch for the change you're requesting in January:

https://lore.kernel.org/lkml/20200122112306.64598-2-andriy.shevchenko@linux.intel.com/

The x86 maintainers haven't picked it up yet.

Ronald's patch fixes a regression.  Please apply it at your earliest
convenience.

Thanks,

Lukas
