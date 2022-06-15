Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA6EDC43334
	for <linux-serial@archiver.kernel.org>; Wed, 15 Jun 2022 09:31:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346850AbiFOJbZ (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 15 Jun 2022 05:31:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347650AbiFOJ3b (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 15 Jun 2022 05:29:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76339344F9
        for <linux-serial@vger.kernel.org>; Wed, 15 Jun 2022 02:29:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1367F61AAD
        for <linux-serial@vger.kernel.org>; Wed, 15 Jun 2022 09:29:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FFB5C34115;
        Wed, 15 Jun 2022 09:29:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1655285368;
        bh=gMX6M7K86/Sa2lZ8cyE2qPz7bphqD/q3A+lU6MRhJyI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BRULOZhvFDmFv+MCBMz2ZDZopWRs9PQRrGGGvNj/UevpmY3I/ck3HTHbKklZWxvg0
         EIwLqJhlhlC4BVkZIBzh0P4wZex+VMOHPZECjo0gBMkWd9qR7O1urIY1y9pcHblufY
         5G44z6B4SycW43tv5h2ytzBAwCDAqunLm1QTVE9c=
Date:   Wed, 15 Jun 2022 11:29:25 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     cael <juanfengpy@gmail.com>, Jiri Slaby <jirislaby@kernel.org>,
        benbjiang@tencent.com, robinlai@tencent.com,
        linux-serial <linux-serial@vger.kernel.org>
Subject: Re: [PATCH v4] tty: fix hang on tty device with no_room set
Message-ID: <YqmmdRynrDSzNL0W@kroah.com>
References: <Yqdx0W8HhvT5qZlP@kroah.com>
 <1655264710-26055-1-git-send-email-juanfengpy@gmail.com>
 <YqlnVBY6IBSQnTFC@kroah.com>
 <a5acf481-1986-7fc1-541e-6a5dea7c33c@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a5acf481-1986-7fc1-541e-6a5dea7c33c@linux.intel.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Jun 15, 2022 at 10:57:48AM +0300, Ilpo Järvinen wrote:
> Hi Greg,
> 
> On Wed, 15 Jun 2022, Greg KH wrote:
> 
> > On Wed, Jun 15, 2022 at 11:45:10AM +0800, cael wrote:
> > > We have met a hang on pty device, the reader was blocking
> > > at epoll on master side, the writer was sleeping at wait_woken
> > > inside n_tty_write on slave side, and the write buffer on
> > > tty_port was full, we found that the reader and writer would
> > > never be woken again and blocked forever.
> > > 
> > > The problem was caused by a race between reader and kworker:
> > > n_tty_read(reader):  n_tty_receive_buf_common(kworker):
> > >                     |room = N_TTY_BUF_SIZE - (ldata->read_head - tail)
> > >                     |room <= 0
> > > copy_from_read_buf()|
> > > n_tty_kick_worker() |
> > >                     |ldata->no_room = true
> > > 
> > > After writing to slave device, writer wakes up kworker to flush
> > > data on tty_port to reader, and the kworker finds that reader
> > > has no room to store data so room <= 0 is met. At this moment,
> > > reader consumes all the data on reader buffer and calls
> > > n_tty_kick_worker to check ldata->no_room which is false and
> > > reader quits reading. Then kworker sets ldata->no_room=true
> > > and quits too.
> > > 
> > > If write buffer is not full, writer will wake kworker to flush data
> > > again after following writes, but if write buffer is full and writer
> > > goes to sleep, kworker will never be woken again and tty device is
> > > blocked.
> > > 
> > > This problem can be solved with a check for read buffer size inside
> > > n_tty_receive_buf_common, if read buffer is empty and ldata->no_room
> > > is true, a call to n_tty_kick_worker is necessary to keep flushing
> > > data to reader.
> > > 
> > > Signed-off-by: cael <juanfengpy@gmail.com>
> > > ---
> > > Patch changelogs between v1 and v2:
> > > 	-add barrier inside n_tty_read and n_tty_receive_buf_common;
> > > 	-comment why barrier is needed;
> > > 	-access to ldata->no_room is changed with READ_ONCE and WRITE_ONCE;
> > > Patch changelogs between v2 and v3:
> > > 	-in function n_tty_receive_buf_common, add unlikely to check
> > > 	 ldata->no_room, eg: if (unlikely(ldata->no_room)), and READ_ONCE
> > > 	 is removed here to get locality;
> > > 	-change comment for barrier to show the race condition to make
> > > 	 comment easier to understand;
> > > Patch changelogs between v3 and v4:
> > > 	-change subject from 'tty: fix a possible hang on tty device' to
> > > 	 'tty: fix hang on tty device with no_room set' to make subject 
> > > 	 more obvious.
> 
> 
> > This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
> > a patch that has triggered this response.  He used to manually respond
> > to these common problems, but in order to save his sanity (he kept
> > writing the same thing over and over, yet to different people), I was
> > created.  Hopefully you will not take offence and will fix the problem
> > in your patch and resubmit it so that it can be accepted into the Linux
> > kernel tree.
> > 
> > You are receiving this message because of the following common error(s)
> > as indicated below:
> 
> [...snip...]
> 
> > - This looks like a new version of a previously submitted patch, but you
> >   did not list below the --- line any changes from the previous version.
> >   Please read the section entitled "The canonical patch format" in the
> >   kernel file, Documentation/SubmittingPatches for what needs to be done
> >   here to properly describe this.
> 
> I think your bot's changelog heuristic got it wrong here. He provided
> the list of changes as you can see above.

Ah, yeah, it didn't catch the changelog text at all, will go fix that
up...

> (The name thing might still be valid though, I've no idea which names are 
> real and which are not).

Yes, for the name reason alone we can't take this change :(

thanks,

greg k-h
