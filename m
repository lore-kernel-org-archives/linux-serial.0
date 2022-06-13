Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55DA1CCA47F
	for <linux-serial@archiver.kernel.org>; Mon, 13 Jun 2022 19:24:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349112AbiFMTYN (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 13 Jun 2022 15:24:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350280AbiFMTXY (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 13 Jun 2022 15:23:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 688261112
        for <linux-serial@vger.kernel.org>; Mon, 13 Jun 2022 10:20:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0FFFCB81186
        for <linux-serial@vger.kernel.org>; Mon, 13 Jun 2022 17:20:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DD59C3411B;
        Mon, 13 Jun 2022 17:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1655140820;
        bh=Qttm/iSX1ZoUyPKll+5YAPGD9HeOs5nDkFWBlB44yF8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ddKLqtl3D4T0QHDNqcfkG8fzg6tZ6mnB01S6ykeMkWOYXdHHqPwx74ta1W7P44/Kg
         2Fg+2zO7qLWLBiAJu8pElwaZ51blyDG8JKidTljIo00hUvOBIqBGSYguYb8YHMocTG
         F6Yr5OhDhTjZldoSoyviGwR0Oktf5ftPLDMsXxvw=
Date:   Mon, 13 Jun 2022 19:20:17 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     juanfengpy@gmail.com
Cc:     jirislaby@kernel.org, ilpo.jarvinen@linux.intel.com,
        benbjiang@tencent.com, robinlai@tencent.com,
        linux-serial@vger.kernel.org, caelli <caelli@tencent.com>
Subject: Re: [PATCH v3] tty: fix hang on tty device with no_room set
Message-ID: <Yqdx0W8HhvT5qZlP@kroah.com>
References: <YqRFBMXz7/9SkL5F@kroah.com>
 <1655123429-15376-1-git-send-email-caelli@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1655123429-15376-1-git-send-email-caelli@tencent.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, Jun 13, 2022 at 08:30:29PM +0800, juanfengpy@gmail.com wrote:
> From: caelli <caelli@tencent.com>

This name/address does not match what you are sending it from, and I do
not think this is how you sign legal documents right?

For that reason alone, I can't take this :(

> 
> We have met a hang on pty device, the reader was blocking
> at epoll on master side, the writer was sleeping at wait_woken
> inside n_tty_write on slave side, and the write buffer on
> tty_port was full, we found that the reader and writer would
> never be woken again and blocked forever.
> 
> The problem was caused by a race between reader and kworker:
> n_tty_read(reader):  n_tty_receive_buf_common(kworker):
>                     |room = N_TTY_BUF_SIZE - (ldata->read_head - tail)
>                     |room <= 0
> copy_from_read_buf()|
> n_tty_kick_worker() |
>                     |ldata->no_room = true
> 
> After writing to slave device, writer wakes up kworker to flush
> data on tty_port to reader, and the kworker finds that reader
> has no room to store data so room <= 0 is met. At this moment,
> reader consumes all the data on reader buffer and call
> n_tty_kick_worker to check ldata->no_room which is false and
> reader quits reading. Then kworker sets ldata->no_room=true
> and quits too.
> 
> If write buffer is not full, writer will wake kworker to flush data
> again after following writes, but if write buffer is full and writer
> goes to sleep, kworker will never be woken again and tty device is
> blocked.
> 
> This problem can be solved with a check for read buffer size inside
> n_tty_receive_buf_common, if read buffer is empty and ldata->no_room
> is true, a call to n_tty_kick_worker is necessary to keep flushing
> data to reader.
> 
> Signed-off-by: caelli <caelli@tencent.com>
> ---
> Previous threads:
> https://lore.kernel.org/all/CAPmgiULo4h8bOrzL+XJ5Pndw0kz80fBPfH_KNLx3c5j-Yj04SA@mail.gmail.com/t/
> 
> I corrected some format problems as recommended and switched client to git send-email,
> which may be ok. And subject is changed from 'tty: fix a possible hang on tty device' to
> 'tty: fix hang on tty device with no_room set' to make subject more obvious.

Please properly version your patches like the documentation explains how
to, so we know what has changed from previous versions.  Otherwise they
all look identical to us.

thanks,

greg k-h
