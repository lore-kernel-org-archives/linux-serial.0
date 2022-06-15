Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 915B1C433EF
	for <linux-serial@archiver.kernel.org>; Wed, 15 Jun 2022 07:58:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234950AbiFOH6G (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 15 Jun 2022 03:58:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbiFOH6F (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 15 Jun 2022 03:58:05 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB66D27CE7
        for <linux-serial@vger.kernel.org>; Wed, 15 Jun 2022 00:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655279884; x=1686815884;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=ZWDpOVzOQZR0rD5CbXDvBhkXPTZ1fZKBX3NJCE2UioI=;
  b=eOMZhOX/2GCuYYVdGfof+aRfSAbfaCQF+/t5cOHxM/nTrOPvrOOt2IL5
   MIItQHL5zgC9tFZMHI646zbLk34SJJ66bM8wgkSrJRLC/9J0UriQBJkPt
   F59FnGFBk/UowPa+Jq97lLsRIcxC8+I/L5Hlf/MrCo02kWl9tMNPWF/lx
   WCejaa3olsWxrsJhx2oAXa+ZHSvxz3z9B/L515df7q5KV+nO99SNFU033
   9dosg5qtp7C7KLPcMYV/5tHZ/kOAhmBmF3YUZsWxIu2Mwd8MCFjKk1Yqd
   Myg2/PAR0QyumW1jFOF75ABlptWg5LBi/J4FX5T/nAka8L8WTG8VqDeZ0
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10378"; a="342835751"
X-IronPort-AV: E=Sophos;i="5.91,300,1647327600"; 
   d="scan'208";a="342835751"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2022 00:58:04 -0700
X-IronPort-AV: E=Sophos;i="5.91,300,1647327600"; 
   d="scan'208";a="640859170"
Received: from mgrymel-mobl1.ger.corp.intel.com ([10.249.41.34])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2022 00:58:02 -0700
Date:   Wed, 15 Jun 2022 10:57:48 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Greg KH <gregkh@linuxfoundation.org>
cc:     cael <juanfengpy@gmail.com>, Jiri Slaby <jirislaby@kernel.org>,
        benbjiang@tencent.com, robinlai@tencent.com,
        linux-serial <linux-serial@vger.kernel.org>
Subject: Re: [PATCH v4] tty: fix hang on tty device with no_room set
In-Reply-To: <YqlnVBY6IBSQnTFC@kroah.com>
Message-ID: <a5acf481-1986-7fc1-541e-6a5dea7c33c@linux.intel.com>
References: <Yqdx0W8HhvT5qZlP@kroah.com> <1655264710-26055-1-git-send-email-juanfengpy@gmail.com> <YqlnVBY6IBSQnTFC@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi Greg,

On Wed, 15 Jun 2022, Greg KH wrote:

> On Wed, Jun 15, 2022 at 11:45:10AM +0800, cael wrote:
> > We have met a hang on pty device, the reader was blocking
> > at epoll on master side, the writer was sleeping at wait_woken
> > inside n_tty_write on slave side, and the write buffer on
> > tty_port was full, we found that the reader and writer would
> > never be woken again and blocked forever.
> > 
> > The problem was caused by a race between reader and kworker:
> > n_tty_read(reader):  n_tty_receive_buf_common(kworker):
> >                     |room = N_TTY_BUF_SIZE - (ldata->read_head - tail)
> >                     |room <= 0
> > copy_from_read_buf()|
> > n_tty_kick_worker() |
> >                     |ldata->no_room = true
> > 
> > After writing to slave device, writer wakes up kworker to flush
> > data on tty_port to reader, and the kworker finds that reader
> > has no room to store data so room <= 0 is met. At this moment,
> > reader consumes all the data on reader buffer and calls
> > n_tty_kick_worker to check ldata->no_room which is false and
> > reader quits reading. Then kworker sets ldata->no_room=true
> > and quits too.
> > 
> > If write buffer is not full, writer will wake kworker to flush data
> > again after following writes, but if write buffer is full and writer
> > goes to sleep, kworker will never be woken again and tty device is
> > blocked.
> > 
> > This problem can be solved with a check for read buffer size inside
> > n_tty_receive_buf_common, if read buffer is empty and ldata->no_room
> > is true, a call to n_tty_kick_worker is necessary to keep flushing
> > data to reader.
> > 
> > Signed-off-by: cael <juanfengpy@gmail.com>
> > ---
> > Patch changelogs between v1 and v2:
> > 	-add barrier inside n_tty_read and n_tty_receive_buf_common;
> > 	-comment why barrier is needed;
> > 	-access to ldata->no_room is changed with READ_ONCE and WRITE_ONCE;
> > Patch changelogs between v2 and v3:
> > 	-in function n_tty_receive_buf_common, add unlikely to check
> > 	 ldata->no_room, eg: if (unlikely(ldata->no_room)), and READ_ONCE
> > 	 is removed here to get locality;
> > 	-change comment for barrier to show the race condition to make
> > 	 comment easier to understand;
> > Patch changelogs between v3 and v4:
> > 	-change subject from 'tty: fix a possible hang on tty device' to
> > 	 'tty: fix hang on tty device with no_room set' to make subject 
> > 	 more obvious.


> This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
> a patch that has triggered this response.  He used to manually respond
> to these common problems, but in order to save his sanity (he kept
> writing the same thing over and over, yet to different people), I was
> created.  Hopefully you will not take offence and will fix the problem
> in your patch and resubmit it so that it can be accepted into the Linux
> kernel tree.
> 
> You are receiving this message because of the following common error(s)
> as indicated below:

[...snip...]

> - This looks like a new version of a previously submitted patch, but you
>   did not list below the --- line any changes from the previous version.
>   Please read the section entitled "The canonical patch format" in the
>   kernel file, Documentation/SubmittingPatches for what needs to be done
>   here to properly describe this.

I think your bot's changelog heuristic got it wrong here. He provided
the list of changes as you can see above.

(The name thing might still be valid though, I've no idea which names are 
real and which are not).


-- 
 i.

