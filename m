Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E255C433EF
	for <linux-serial@archiver.kernel.org>; Fri, 28 Jan 2022 15:38:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233610AbiA1Pij (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 28 Jan 2022 10:38:39 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:60594 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231320AbiA1Pij (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 28 Jan 2022 10:38:39 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A763D60DD5
        for <linux-serial@vger.kernel.org>; Fri, 28 Jan 2022 15:38:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78998C340E0;
        Fri, 28 Jan 2022 15:38:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1643384318;
        bh=QkU38DNKzKoA7jb2CGD5+BQ2Mtxg89hSC2gD2OMi9so=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lyQDM+h/eKBj8bNnIow+8ZOhbOc4BaITMs11sLb4TqJ+nkdVGqd76+KiWZieFMb++
         5syq1DtcZWkavgCe3hmublfBnsYnk+CKcZUmzQJ5ywzgdthBT0Gf/fgvgtijJEDtPe
         6/DaMRqc1SpC7yawGaBvyzBhXIqk9cl8cjN/VNEs=
Date:   Fri, 28 Jan 2022 16:38:34 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Benjamin Ulrich <Benjamin.Ulrich@codewrights.de>
Cc:     "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
Subject: Re: response time of serdev_device
Message-ID: <YfQN+iV9jA5aIOYr@kroah.com>
References: <AM9PR03MB6771AA9FC0E036F21320400893229@AM9PR03MB6771.eurprd03.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM9PR03MB6771AA9FC0E036F21320400893229@AM9PR03MB6771.eurprd03.prod.outlook.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Jan 28, 2022 at 01:03:53PM +0000, Benjamin Ulrich wrote:
> Hi all,
> 
> I'm using your serdev_device kernel module because it fit my needs pretty well.
> In my application the response delay to an received frame is time critical, because of that I made following observations:
> 
> When I'm writing an UART "echo-device" with:
> static int device_receive_buf(struct serdev_device *serdev, const unsigned char *pbuf, size_t length)
> {
>     return serdev_device_write_buf(serdev, pbuf, length);
> }
> 
> I can measure the response delay between the TX/RX UART line.
> On my device (IMX8,with preempt-rt) the delay is dependent from the baudrate:
> 19200b -> 4.6ms
> 115200 -> 1ms
> 256000 -> 0.7ms
> 
> The result is very surprising to me, at least the baudrate-response dependency.

This all depends on your uart hardware as well.

> I know that there are HW-Flow control stuff for Half-Duplex communication like in many RS485 applications. 
> Is it possible that there are some old configs left? In the function: static int ttyport_open(struct serdev_controller *ctrl) the ktermios flags are set properly.
> 
> For my driver a response time of 1ms@19200 would be really good.

Why do you think that?

> Can someone help me to archive that?

Are you sure this is possible with your hardware?  This depends on your
workload and lots of other things happening at the same time.  If you
need determinisitic behavior, have you tried the -RT kernel?

Have you used perf to measure where the delay is happening?

thanks,

greg k-h
