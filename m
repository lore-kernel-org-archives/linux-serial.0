Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26FDAC433ED
	for <linux-serial@archiver.kernel.org>; Fri,  7 May 2021 10:52:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D54DE6101A
	for <linux-serial@archiver.kernel.org>; Fri,  7 May 2021 10:52:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235670AbhEGKxI (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 7 May 2021 06:53:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:59856 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235596AbhEGKww (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 7 May 2021 06:52:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2F5B460E0C;
        Fri,  7 May 2021 10:51:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1620384706;
        bh=IeWqElOCLmm4UqbL0AcosTEfq9DG9ik6udS4IQ6P8Ec=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZRrZMWLKjFvCWuyyzIlxW1Udpxt1i7qAzxlU7g7TS7owIHrw5TH1BOf4PL7hsmjv8
         R1bHj717O6/ICeNotQa09X76Rd0LqYjbmm2JkohkDKNEwCt4+fsgWjO3979Ipi59ND
         kkitbhE1GIaHfMWfm2HDqrDHOuX1fAQPYEHrJ+1I=
Date:   Fri, 7 May 2021 12:51:43 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Ivan Bakula <wamreu@gmail.com>
Cc:     robh@kernel.org, jirislaby@kernel.org,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] TTY: serdev: Replace depricated macros
Message-ID: <YJUbv3t05ai+g2k0@kroah.com>
References: <20210506183228.33981-1-wamreu@gmail.com>
 <YJQp4W2X/tuvLfVA@kroah.com>
 <YJUhZP1FwMlUfWrw@r00t>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YJUhZP1FwMlUfWrw@r00t>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, May 07, 2021 at 01:16:38PM +0200, Ivan Bakula wrote:
> Thank you for your reply.
> 
> > If these really are "deprecated", 
> 
> According to the comment in file "include/linux/idr.h" (line 318) these
> macros are depricated.

So that means what, that no new users should use them?  Or that they
should be replaced?

> > why not just do a search/replace across the whole tree and change them?
> 
> I've stumbled across these macros while trying to figure out how to write 
> device driver using serial device bus. So, I've decided to change them with
> appropriate function calls.
> 
> I didn't do search/replace across the whole tree because it's my first 
> patch and I wanted it to be short. But now, when you mentioned it, 
> I will do it.

No, please do not do that unless you can figure out why this is needed.

Only change code if it has to be changed.  If the idr api needs to be
redone for existing, working code, then that's fine, but do it correctly
and understand why you are doing it.

My point being that if it were as simple as a search/replace, then the
developer who wrote that comment would have done it already, not that
this should be something that you should do :)

hope this helps,

greg k-h
