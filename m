Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBA79CCA47B
	for <linux-serial@archiver.kernel.org>; Fri,  1 Jul 2022 15:29:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230129AbiGAP3J (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 1 Jul 2022 11:29:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiGAP3H (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 1 Jul 2022 11:29:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1E9F1F60D;
        Fri,  1 Jul 2022 08:29:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 39BC862414;
        Fri,  1 Jul 2022 15:29:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C587C3411E;
        Fri,  1 Jul 2022 15:29:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1656689345;
        bh=fg4rHu8CbbqFBxKzijEGmEDBRGujBS5oSTYCqS8ZW70=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HAGfJ701w0/wjeuqllH40r3iH05v/wKY7zEntWAJRSpPcG+9b8Q5miparWa6qm556
         TnxIN4cuwNhjSmg+XwnEpBYcwuiOQrZgAZjVIW+Q8dBMkrlQYB88kM6c7LhbmiQIdc
         0H0ZecFc5lF9ne4ISpiVbZPBhY7xCyZpJYnGSdh8=
Date:   Fri, 1 Jul 2022 17:29:02 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Imran Khan <imran.f.khan@oracle.com>
Cc:     Nathan Chancellor <nathan@kernel.org>, tj@kernel.org,
        viro@zeniv.linux.org.uk, m.szyprowski@samsung.com,
        michael@walle.cc, robh@kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, guillaume.tucker@collabora.com,
        pmladek@suse.com
Subject: Re: [PATCH] kernfs: Avoid re-adding kernfs_node into
 kernfs_notify_list.
Message-ID: <Yr8SvqShBXZ/U6gk@kroah.com>
References: <20220701145047.2206900-1-imran.f.khan@oracle.com>
 <Yr8OSxotW2VEUyKQ@dev-arch.thelio-3990X>
 <2c4bdc7a-b49f-c2ea-28d0-4ec838c3b26c@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2c4bdc7a-b49f-c2ea-28d0-4ec838c3b26c@oracle.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Sat, Jul 02, 2022 at 01:18:09AM +1000, Imran Khan wrote:
> Hello Nathan,
> 
> On 2/7/22 1:10 am, Nathan Chancellor wrote:
> > On Sat, Jul 02, 2022 at 12:50:47AM +1000, Imran Khan wrote:
> >> Kick fsnotify only if an event is not already scheduled for target
> >> kernfs node. commit b8f35fa1188b ("kernfs: Change kernfs_notify_list to
> >> llist.") changed kernfs_notify_list to a llist.
> >> Prior to this list was a singly linked list, protected by
> >> kernfs_notify_lock. Whenever a kernfs_node was added to the list
> >> its ->attr.notify_next was set to head of the list and upon removal
> >> ->attr.notify_next was reset to NULL. Addition to kernfs_notify_list
> >> would only happen if kernfs_node was not already in the list i.e.
> >> if ->attr.notify_next was NULL. commit b8f35fa1188b ("kernfs: Change
> >> kernfs_notify_list to llist.") removed this checking and this was wrong
> >> as it resulted in multiple additions for same kernfs_node.
> >>
> >> So far this bug only got reflected with some console related setting.
> >> Nathan found this issue when console was specified both in DT and in
> >> kernel command line and Marek found this issue when earlycon was enabled.
> >>
> >> This patch avoids adding an already added kernfs_node into notify list.
> >>
> >> Reported-by: Nathan Chancellor <nathan@kernel.org>
> >> Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
> > 
> > This should also include:
> > 
> > Reported-by: Michael Walle <michael@walle.cc>
> > 
> >> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> >> Fixes: b8f35fa1188b ("kernfs: Change kernfs_notify_list to llist.")
> >> Signed-off-by: Imran Khan <imran.f.khan@oracle.com>
> > 
> > For the ARCH=um case that I noticed:
> > 
> > Tested-by: Nathan Chancellor <nathan@kernel.org>
> > 
> 
> I am really sorry about missing these tags. I was not sure if you have tested
> the patch I sent this morning.
> 
> Could you please suggest me if I should send a v2 of this change with these tags
> included or if this mail is enough. Sorry if I am asking something obvious but I
> am encountering such situation for first time.

Please resend with them added.

thanks,

greg k-h
