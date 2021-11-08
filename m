Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E733CC433EF
	for <linux-serial@archiver.kernel.org>; Mon,  8 Nov 2021 14:10:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CAA2E610F8
	for <linux-serial@archiver.kernel.org>; Mon,  8 Nov 2021 14:10:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236097AbhKHONl (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 8 Nov 2021 09:13:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:57716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238835AbhKHONk (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 8 Nov 2021 09:13:40 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 516C261107;
        Mon,  8 Nov 2021 14:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1636380655;
        bh=VD4LXky1edfBuqVBwDgx8FQOTCY3ZoMyDHkDS0ymc5A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=peNSD7hn/nVx97yXb0P63Z2dxKTgV9JUIOFbntfNDIYkhfUXm+0N/PJt6z7V3QASq
         TvdIPtNyRqmPun4QIOvxBFfU5GvAlrTaNzOD3BHB3MpbISuB0FaJ2i5biO0GPx2Xev
         ezkms6K8cLDMdinTlHvXoAb7f9w4D79BvqIKhYFM=
Date:   Mon, 8 Nov 2021 15:10:53 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Ajay Garg <ajaygargnsit@gmail.com>
Cc:     jirislaby@kernel.org, andriy.shevchenko@linux.intel.com,
        kernel@esmil.dk, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, paskripkin@gmail.com,
        johan@kernel.org
Subject: Re: [PATCH v5] vt: keyboard: suppress warnings in vt_do_kdgkb_ioctl
Message-ID: <YYkv7ekV9ezpPOWx@kroah.com>
References: <20211108134901.7449-1-ajaygargnsit@gmail.com>
 <YYkroa2v1ruwPRBN@kroah.com>
 <CAHP4M8WLaWa769hDJBWVwL7P7hadoTk+CE1sVba3tRVxpMRVtw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHP4M8WLaWa769hDJBWVwL7P7hadoTk+CE1sVba3tRVxpMRVtw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, Nov 08, 2021 at 07:24:59PM +0530, Ajay Garg wrote:
> Hmm, I am afraid I don't understand. The patch changes only 5 lines.
> Could someone help me navigate what to "fix"?
> 
> 
> Thanks and Regards,
> Ajay
> 
> On Mon, Nov 8, 2021 at 7:22 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Mon, Nov 08, 2021 at 07:19:01PM +0530, Ajay Garg wrote:
> > > smatch-kchecker gives the following warnings when run on keyboard.c :
> > >
> > > vt_do_kdgkb_ioctl() error: uninitialized symbol 'kbs'.
> > > vt_do_kdgkb_ioctl() error: uninitialized symbol 'ret'.
> > >
> > > i)
> > > The 'kbs" warning was introduced by "07edff926520" :
> > > ("vt: keyboard, reorder user buffer handling in vt_do_kdgkb_ioctl")
> > >
> > > *
> > > prior 07edff926520, the scope of kbs (allocation/deallocation) was
> > > external to switch-cases.
> > >
> > > *
> > > post 07edff926520, kbs is allocated internally for each case, however the
> > > deallocation remains external.
> > >
> > > Thus, as the "fix", the scope of kbs deallocation is now made internal
> > > to each switch case.
> > >
> > > ii)
> > > The 'ret' warning is the result of "4e1404a5cd04" :
> > > ("vt: keyboard, extract and simplify vt_kdskbsent")
> > >
> > > where the "ret = 0" (right at the end) was accidentally removed.
> > >
> > > Bringing back the above in a slightly different way, by initializing ret
> > > to 0 at the start.


You are listing two different things being done in this single commit.

It should be 2 different patches.

I would recommend getting more comfortable with Linux kernel development
by working in the drivers/staging/ portion of the kernel first.  And not
in the "core" kernel like tty/serial or other well-entrenched
subsystems.  That way you can learn the proper processes and workflows
better in an area of the kernel that is specifically designed just for
that, and not end up bothering the time of other kernel developers for
basic process issues like your recent patches have shown.

thanks,

greg k-h
