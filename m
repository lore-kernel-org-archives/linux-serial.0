Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D421C433F5
	for <linux-serial@archiver.kernel.org>; Thu, 23 Sep 2021 08:32:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BFCC6105A
	for <linux-serial@archiver.kernel.org>; Thu, 23 Sep 2021 08:32:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239877AbhIWIeZ (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 23 Sep 2021 04:34:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:58606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239676AbhIWIeX (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 23 Sep 2021 04:34:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CFBC86103C;
        Thu, 23 Sep 2021 08:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632385970;
        bh=vnXfYXOxyn9Ib5ZzXCraaYxvauIbNLuuADn51WHKooI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FQFwno3eTTineSXa32z/9oMB+zl71XT0u2+voZDGF9tIp9dvNzCY6teposdT7D7KP
         0FEZqDSIQnyTo7XOjl92VA9MB2DmEIpHqjUZE9xRwCPJ5SChXOH3+W53FC/NBHfGGb
         zBU6vDVAc7rXN+t+GM5Ol4+S44se5HTby7V5MU4YuYG2j5qCRmjjAUdc8BbYg78bpY
         MUs0RL9CH9OgI1mWUxUworIF36TdcpBggNK7u7G52W0/oghyoSSvgMcxJy6hetmNnI
         xiUE6oPwTJTT1zynkYDxZk2JM+UgxIivvAxpeBFUAxSCzAGK+LGJ2+q5U3IX10Tvzh
         6ayuQl3V9u0Yg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1mTK9z-0008Fd-RZ; Thu, 23 Sep 2021 10:32:51 +0200
Date:   Thu, 23 Sep 2021 10:32:51 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 16/16] tty: drop tty_flip_buffer_push
Message-ID: <YUw7s76Pi5B4RJoL@hovoldconsulting.com>
References: <20210914091134.17426-1-jslaby@suse.cz>
 <20210914091415.17918-1-jslaby@suse.cz>
 <20210914091415.17918-9-jslaby@suse.cz>
 <YUMWaCpT4s8dQKiy@hovoldconsulting.com>
 <1fd9ed1a-edd2-a154-da1c-022a89b2c722@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1fd9ed1a-edd2-a154-da1c-022a89b2c722@kernel.org>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Sep 22, 2021 at 08:57:17AM +0200, Jiri Slaby wrote:
> On 16. 09. 21, 12:03, Johan Hovold wrote:
> > On Tue, Sep 14, 2021 at 11:14:15AM +0200, Jiri Slaby wrote:
> >> Since commit a9c3f68f3cd8d (tty: Fix low_latency BUG) in 2014,
> >> tty_flip_buffer_push() is only a wrapper to tty_schedule_flip(). All
> >> users were converted, so remove tty_flip_buffer_push() completely.

> > The name tty_flip_buffer_push() is arguable more descriptive since the
> > work may already be running and is also less tied to the implementation.
> > 
> > The ratio of drivers using tty_flip_buffer_push() over
> > tty_schedule_flip() is also something like 186 to 15 so that would
> > amount to a lot less churn too.
> 
> OK, I can do either way. I chose this path as tty_schedule_flip was a 
> wrapper to tty_flip_buffer_push. In any case, I wouldn't take the number 
> of changed drivers as a measure. But if it makes more sense for people 
> regarding the naming, I will "flip" the two flips.

I'd prefer that. The name tty_flip_buffer_push() is more descriptive and
we've been using it in virtually all tty drivers since 1997. No need to
force people to relearn the pattern of tty insert + push.

(Also note that the kernel doc for tty_schedule_flip() says "push
characters to ldisc", while the name more reflects how the tty buffering
was originally implemented.)
 
> > Also, can you please start adding cover letters to your series to
> > provide an overview of what it is you're trying to accomplish?
> 
> I am not a fan of cover letters as they are not Cced to people who are 
> Cced in separate patches. So what would you like to see in the letter? 
> This series are just a random cleanup and IMO there is not much more to 
> be said except what is in their commit logs.

Even if all it said was "random cleanups" it would still be worth having
as I'd know that this is just Jiri moving code about and not necessarily
something that needs deeper review.

In this case the driver commit messages only said that "[w]e are going
to remove [tty_flip_buffer_push()]" without any real explanation why
that was chosen over the alternatives. I had to look up the series on
lore to look for more details. But since there's no cover letter I end
up having to skim the entire series only to come up mostly empty handed
as the final patch just added "One less exported function" as some sort
of motivation.

Let's not make it harder for reviewers. If you're sending random cleanup
patches then say so. And if they can be grouped into a few classes as
seemed to be the case here then having those outlined is also helpful.

Johan
