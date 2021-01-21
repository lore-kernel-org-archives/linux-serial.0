Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74DCDC433E9
	for <linux-serial@archiver.kernel.org>; Thu, 21 Jan 2021 18:00:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1261923A22
	for <linux-serial@archiver.kernel.org>; Thu, 21 Jan 2021 18:00:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733254AbhAUR7T (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 21 Jan 2021 12:59:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:54796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389415AbhAUR6L (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 21 Jan 2021 12:58:11 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8F4F622B2C;
        Thu, 21 Jan 2021 17:57:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1611251851;
        bh=5mkPfREPGo9kcTeQbx4tmBSVpBfLagWOH/wRlMOuDQA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KzIf/WYuGUsEDvZk93JtSt6U8HYIMcw6PVZ4WqnXmnQAqqnQH1HA+UTiVDtGvVNJe
         kfeAs9yh3ip5Cppy4BfOJwcFAgQiQ20pxBkNJ2RbQCDlN3YRWMWMwIBJ8iLqLq3yuO
         T/P+wV0NN+BH/78K/wXaGiB68s7E8C3otmLQ/OR8=
Date:   Thu, 21 Jan 2021 18:57:28 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Oliver Giles <ohw.giles@gmail.com>,
        Robert Karszniewicz <r.karszniewicz@phytec.de>
Subject: Re: [PATCH 2/6] tty: convert tty_ldisc_ops 'read()' function to take
 a kernel pointer
Message-ID: <YAnAiLYYEff0aKfX@kroah.com>
References: <20210121090020.3147058-1-gregkh@linuxfoundation.org>
 <20210121090020.3147058-2-gregkh@linuxfoundation.org>
 <ff6709dc-bb42-1e52-b348-c52036960bdd@kernel.org>
 <CAHk-=whMm=NM4=ch++YqFn3W=ceNDOhLTFqdP47nxayzVt41Qw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whMm=NM4=ch++YqFn3W=ceNDOhLTFqdP47nxayzVt41Qw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Jan 21, 2021 at 09:46:58AM -0800, Linus Torvalds wrote:
> On Thu, Jan 21, 2021 at 3:02 AM Jiri Slaby <jirislaby@kernel.org> wrote:
> >
> > n_hdlc_tty_read will return EOVERFLOW when size is 0, so this EFAULT is
> > never propagated, if I am looking correctly? n_tty seems to be fine
> > (returns zero for zeroed size).
> 
> I'll fix that up too.
> 
> Greg - same question - do you want an incremental patch, or just a new series?

Incremental is best, thanks!
