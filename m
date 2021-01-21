Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C747C433E6
	for <linux-serial@archiver.kernel.org>; Thu, 21 Jan 2021 19:44:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4BF7F23A3A
	for <linux-serial@archiver.kernel.org>; Thu, 21 Jan 2021 19:44:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727481AbhAUToo (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 21 Jan 2021 14:44:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:47950 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726627AbhAUToU (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 21 Jan 2021 14:44:20 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5F7E923A3A;
        Thu, 21 Jan 2021 19:43:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1611258219;
        bh=1IYwOJbWNQ/Qy6rSjMNeuj0ytyxS9oxyb6oyVJPrVHs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2GHp9uY+0jbMqu2Ql6uf0ogkUL8bjvhyjgF7dbQBE2TrOvneZw2FodxtXOyqerA1T
         YxdDo9zggjfAfwWZ37q7rL+lSfWIT5uA03YtCt2a+9z/plCiNDYt0wiE2rh1nvx/5C
         w/If0wafkNPPQicFsYaR88otFPMmvcTMH3wBIAD0=
Date:   Thu, 21 Jan 2021 20:43:37 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Oliver Giles <ohw.giles@gmail.com>,
        Robert Karszniewicz <r.karszniewicz@phytec.de>
Subject: Re: [PATCH 1/6] tty: implement write_iter
Message-ID: <YAnZaYj1ohUNinaf@kroah.com>
References: <20210121090020.3147058-1-gregkh@linuxfoundation.org>
 <f4c72a0a-25e6-5c7a-559b-6d3b7c930100@kernel.org>
 <CAHk-=whE3fmgWx+aNvC6qkNqJtWPre3dVnv-_qYj7GaWnW72Vg@mail.gmail.com>
 <YAnAfNcE8Bw95+SV@kroah.com>
 <CAHk-=wh+-rGsa=xruEWdg_fJViFG8rN9bpLrfLz=_yBYh2tBhA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wh+-rGsa=xruEWdg_fJViFG8rN9bpLrfLz=_yBYh2tBhA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Jan 21, 2021 at 10:42:04AM -0800, Linus Torvalds wrote:
> On Thu, Jan 21, 2021 at 9:57 AM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > Incremental patches please as these are already in my public branches
> > and I would have to revert them and add new ones but that's messy, so
> > fixes on top is fine.
> 
> Ok. And since I think you put that first tty_write conversion patch in
> a different branch from the tty_read one, I did the fixup patches for
> the two as separate patches, even though they really just do the exact
> same thing.
> 
> So here's three patches: the two fixups for the hung_up_tty case, and
> the EOVERFLOW error case that Jiri also noted. I've also updated the
> 'tty-splice' branch if you prefer them that way.

This works, thanks for these.  I'll wait for Jiri to review them before
applying them to my branches...

greg k-h
