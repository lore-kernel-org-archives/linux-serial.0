Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43F5CC433F5
	for <linux-serial@archiver.kernel.org>; Tue, 30 Nov 2021 08:46:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234897AbhK3IuN (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 30 Nov 2021 03:50:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234760AbhK3IuN (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 30 Nov 2021 03:50:13 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F9DEC061574
        for <linux-serial@vger.kernel.org>; Tue, 30 Nov 2021 00:46:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 24106B817D6
        for <linux-serial@vger.kernel.org>; Tue, 30 Nov 2021 08:46:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23BCDC53FC1;
        Tue, 30 Nov 2021 08:46:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1638262010;
        bh=jc5QfOTukUGA/iOzJruLW2gakZ723ExBHmzJN6wafA4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=d3cqK+48d+PkR9JFU+mqwrx7YBqR6DxnjYG2dPFewJaj07MjPHBhP4PRRioadAoNp
         CpD0w6TQJDotZ+fLIrrw+TV856HANHhq9sPOu9qmH2MT1BVmddePeBNRHevWC6l2eX
         a+/XSEVIKIifOiHBYBxuPnEnvaqWg3y752leH6z4=
Date:   Tue, 30 Nov 2021 08:47:22 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     chaozeng <chaochao2021666@163.com>
Cc:     linux-serial@vger.kernel.org, jirislaby@kernel.org,
        baocheng.su@siemens.com, jan.kiszka@siemens.com,
        le.jin@siemens.com, chao.zeng@siemens.com
Subject: Re: Question: how to handle tty output buffer
Message-ID: <YaXXCtfVmsiMnvQA@kroah.com>
References: <07b4850d-eb6b-5b24-3796-a6c2dce8596a@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <07b4850d-eb6b-5b24-3796-a6c2dce8596a@163.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Nov 30, 2021 at 03:19:54PM +0800, chaozeng wrote:
> 
> 
> Dear all
> 
> I have a question about the output buffer, it just related hardware
> flow-control enabled.
> 
> 
> Question Description:
> 
> When the flow control works, rts works. At this time, the sender stops data
> transmission and exits the sender with interrupt.
> 
> We observed that the output buffer was not empty.
> 
> But
> 
> 1. When the serial port device is used again, it will hang when modifying
> the properties.(We think the buffer is not empty, change termios property is
> not OK).
> 
> 2. the receive side could receive these output buffer(before) next
> time.(seems strange)
> 
> Reproduce steps:
> 
>  1. Connect the send and receive side. enable hardware flow-control for
>     both Send side and recv side. (start recv.py then send.py)(refer
>     attachments)
>  2. Waiting for RTS desseart.
>  3. Close the send side using CTRL+C
>  4. Using stty to show or set the uart attributes(it would hang).  and
>     start the second round, the receive side would receive the data last
> sent.
> 
> I found FTDI usb-serial device would sent the data out when flow-control is
> enabled when closing the port ,but the ti omap_8250 device could not sent
> the data out and keep the buffer.
> 
> the behavior is not the same between several serial ports.

What hardware are you testing for all of this and what drivers for these
devices?  And what kernel version?

Note that usb-serial devices are very odd and cheap and do strange
things because they are so cheap.  They also have the uart hardware off
at the end of a usb connection and so are not able to be fully
controlled by the operating system for some devices (while others are,
but those are usually more expensive devices.)

Also there are many "fake" usb-serial devices out there that sometimes
work differently than the real ones, so watch out as well.

And further, when using stty for some usb-serial devices, they used to
reset their settings when stty closed, making the tool pretty useless.
Depending on your kernel version and device, you need to watch out for
this and not rely on stty, but rather the program when you start it up
needs to set the proper line settings that you need for the device and
never rely on a previous program getting the state set up properly.

Also note that when closing a port (you are aborting a program while it
is running), the state of the uart/tty device is not always in a known
state to userspace anymore.

So what exactly is the problem that you are trying to solve here and
what normal workflow has programs being aborted while running?

> Questions:
> 
> I'd like to know the common handle logic about the output buffer.
> 
> When closing the port, should the output buffer to be sent out or be cleared
> no matter flow-control is enabled?

Depends on the hardware :)

> Who should be response for these output buffer. kernel or userspace
> application?

If the data is already sent to the kernel from userspace, how can
userspace be responsible anymore?

> If we keep the output buffer after closing the port, what's thex intend of
> this?

I do not understand this question, sorry.

thanks,

greg k-h
