Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B325C433F5
	for <linux-serial@archiver.kernel.org>; Thu, 18 Nov 2021 08:11:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0451061BD2
	for <linux-serial@archiver.kernel.org>; Thu, 18 Nov 2021 08:11:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244329AbhKRIO2 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 18 Nov 2021 03:14:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:38714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244290AbhKRIOL (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 18 Nov 2021 03:14:11 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 298CF61BA2;
        Thu, 18 Nov 2021 08:11:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637223071;
        bh=JV2wuEBBp/+TV+h0oOZXKp/9rbQzk41OB9luAA5b+JQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z/EbAlz4zohx8Bny3LbcWNbQWgqvdKrcHJYDq3Wr4yNaahX8BqILflEENT2z8YUC0
         VTH7ASwniczUXAhUQJoBFjU2PmdCumbkkdGDVYjlHtyDXlJE9HBF4neJJOCVZBm8o5
         20HnqdZ9pSoYCe/qliFViFHooLXFp+k6Skmu/twi1xCTgFI3SzaWgxkHExPvKAMbwB
         KBbhavU35+qZn3VGnAKfxWh51Z6e+74AxDOqYQv9yR6eIhZv9Chw7bCeMXD+NtKkDm
         0rtxXmXKJwJbeXEV3OclqWMn6ly7UP8DJT6D3hEXKuTPfTg3Pwcehgb5tVB9jksYuK
         pYjQP4N/PHX4w==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1mncVS-0006CE-Fp; Thu, 18 Nov 2021 09:10:54 +0100
Date:   Thu, 18 Nov 2021 09:10:54 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 16/16] tty: drop tty_flip_buffer_push
Message-ID: <YZYKjmejIqub5tTf@hovoldconsulting.com>
References: <20210914091134.17426-1-jslaby@suse.cz>
 <20210914091415.17918-1-jslaby@suse.cz>
 <20210914091415.17918-9-jslaby@suse.cz>
 <YUMWaCpT4s8dQKiy@hovoldconsulting.com>
 <1fd9ed1a-edd2-a154-da1c-022a89b2c722@kernel.org>
 <01079c75-2d2f-fe57-db0e-6aadf9963846@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01079c75-2d2f-fe57-db0e-6aadf9963846@kernel.org>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Nov 18, 2021 at 08:54:05AM +0100, Jiri Slaby wrote:
> Friendly ping Johan, Greg: any opinions on the tty_schedule_flip vs 
> tty_flip_buffer_push case -- which one should I keep?

I still prefer keeping tty_flip_buffer_push() since it's name is much
more descriptive and since it's used by almost all drivers.

There's also no good reason to force developers to relearn the insert +
push pattern either (and rewriting the documentation and books that
describe it).

Johan
 
> On 22. 09. 21, 8:57, Jiri Slaby wrote:
> > On 16. 09. 21, 12:03, Johan Hovold wrote:
> >> On Tue, Sep 14, 2021 at 11:14:15AM +0200, Jiri Slaby wrote:
> >>> Since commit a9c3f68f3cd8d (tty: Fix low_latency BUG) in 2014,
> >>> tty_flip_buffer_push() is only a wrapper to tty_schedule_flip(). All
> >>> users were converted, so remove tty_flip_buffer_push() completely.
> >>
> >> Did you consider inlining tty_flip_buffer_push() or unexporting
> >> tty_schedule_flip() instead?
> > 
> > Yes -- I see no reason for two functions doing the very same thing. It's 
> > only confusing.
> > 
> >> The name tty_flip_buffer_push() is arguable more descriptive since the
> >> work may already be running and is also less tied to the implementation.
> >>
> >> The ratio of drivers using tty_flip_buffer_push() over
> >> tty_schedule_flip() is also something like 186 to 15 so that would
> >> amount to a lot less churn too.
> > 
> > OK, I can do either way. I chose this path as tty_schedule_flip was a 
> > wrapper to tty_flip_buffer_push. In any case, I wouldn't take the number 
> > of changed drivers as a measure. But if it makes more sense for people 
> > regarding the naming, I will "flip" the two flips.
