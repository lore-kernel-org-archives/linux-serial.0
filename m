Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6716C43460
	for <linux-serial@archiver.kernel.org>; Thu, 22 Apr 2021 10:09:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4043B61360
	for <linux-serial@archiver.kernel.org>; Thu, 22 Apr 2021 10:09:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235751AbhDVKKZ (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 22 Apr 2021 06:10:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:40426 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230285AbhDVKKY (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 22 Apr 2021 06:10:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 03DA961360;
        Thu, 22 Apr 2021 10:09:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619086189;
        bh=awCVv/+J9oV/6dLNqikCNFKD0Fj3UTsswF2nac3PjCk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QKoHtwKxXISmjsMNeYfv1GPhCNUAorA5WtPNyLfzvN+lsIcctMyk5llR1QtJs8AfK
         Dwd0Spbn5aUfeIV69rgHf+Jv4F121GLV/0MCnix6/BRfnoN/FZ+KGOwAZwANmXxI/C
         SI+HskUsAI384wFeCV2j/MClGodsh/pxF6qtEs54=
Date:   Thu, 22 Apr 2021 12:09:47 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/26] tty: drop low-latency workarounds
Message-ID: <YIFLa9I55aIRnJGY@kroah.com>
References: <20210421095509.3024-1-johan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210421095509.3024-1-johan@kernel.org>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Apr 21, 2021 at 11:54:43AM +0200, Johan Hovold wrote:
> The infamous low_latency behaviour of tty_flip_buffer_push(), which
> meant that data could be pushed to the line discipline immediately
> instead of being deferred to a work queue, was finally removed in 2014.
> 
> Since then there's no need for drivers to keep hacks to temporarily drop
> the port lock during receive processing but this pattern has been
> reproduced in later added drivers nonetheless.
> 
> Note that several of these workarounds were added by a series posted in
> 2013, which ended up being merged despite having completely nonsensical
> commit messages. As it turned out, it was just the RT patch set which
> effectively enabled the low_latency flag for serial drivers that did not
> handle it.
> 
> There's of course nothing wrong releasing the port lock before calling
> tty_flip_buffer_push(), and some drivers still do after this series, but
> let's get rid of the completely unnecessary unlock-and-reacquire
> pattern.

Many thanks for cleaning up this old crud, all now applied.

greg k-h
