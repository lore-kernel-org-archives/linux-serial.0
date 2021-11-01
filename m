Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4794DC433EF
	for <linux-serial@archiver.kernel.org>; Mon,  1 Nov 2021 08:32:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2AB2D6056B
	for <linux-serial@archiver.kernel.org>; Mon,  1 Nov 2021 08:32:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231420AbhKAIes (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 1 Nov 2021 04:34:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:49038 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231371AbhKAIer (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 1 Nov 2021 04:34:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 61A17604DC;
        Mon,  1 Nov 2021 08:32:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1635755534;
        bh=WWtJFKR4jTlASd9KJ+hLEAZFd4MaJ5istoeU4ycOG5A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dEZv0J8MokrWkjX8PYt6hu+hQ2AxLuqSMhDSiXl6/Oc97xUwbDD2ChOJkl+PTajFO
         3h3V2esP3ydcX5seZfBFivkKgxoxrSndXyy5A9dIRfRpShfA6dCT7oo3TH7EFJSlfn
         koxFx2OyT5f1tdRl1FtSDd6jhxUteExXtsRG9i74=
Date:   Mon, 1 Nov 2021 09:32:12 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Zijun Hu <zijuhu@codeaurora.org>
Cc:     robh@kernel.org, jirislaby@kernel.org,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>
Subject: Re: [PATCH v1] serdev: Add interface serdev_device_ioctl
Message-ID: <YX+mDGr8tDzVT4Hr@kroah.com>
References: <1635753048-5289-1-git-send-email-zijuhu@codeaurora.org>
 <YX+eRgCrUs2Y5iaX@kroah.com>
 <fe5a8bec-b186-c719-5f02-a0a67eb8862f@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fe5a8bec-b186-c719-5f02-a0a67eb8862f@codeaurora.org>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, Nov 01, 2021 at 04:29:10PM +0800, Zijun Hu wrote:
> 
> 
> On 11/1/2021 3:59 PM, Greg KH wrote:
> > On Mon, Nov 01, 2021 at 03:50:48PM +0800, Zijun Hu wrote:
> >> From: Zijun Hu <quic_zijuhu@quicinc.com>
> >>
> >> For serdev_device which is mounted at virtual tty port, tty ioctl()
> >> maybe be used to make serdev_device ready to talk with tty port, so
> >> add interface serdev_device_ioctl().
> >>
> >> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
> >> ---
> >>  drivers/tty/serdev/core.c           | 11 +++++++++++
> >>  drivers/tty/serdev/serdev-ttyport.c | 12 ++++++++++++
> >>  include/linux/serdev.h              |  9 +++++++++
> >>  3 files changed, 32 insertions(+)
> >>
> >> diff --git a/drivers/tty/serdev/core.c b/drivers/tty/serdev/core.c
> >> index f1324fe99378..c0f6cd64716b 100644
> >> --- a/drivers/tty/serdev/core.c
> >> +++ b/drivers/tty/serdev/core.c
> >> @@ -405,6 +405,17 @@ int serdev_device_set_tiocm(struct serdev_device *serdev, int set, int clear)
> >>  }
> >>  EXPORT_SYMBOL_GPL(serdev_device_set_tiocm);
> >>  
> >> +int serdev_device_ioctl(struct serdev_device *serdev, unsigned int cmd, unsigned long arg)
> >> +{
> >> +	struct serdev_controller *ctrl = serdev->ctrl;
> >> +
> >> +	if (!ctrl || !ctrl->ops->ioctl)
> >> +		return -EOPNOTSUPP;
> > 
> > Wrong error for returning that an ioctl is not handled :(
> checkpatch.pl always reports below WARNING when i use ENOTSUPP as present interfaces
> do. so i change error code to EOPNOTSUPP.
> 
> #28: FILE: drivers/tty/serdev/core.c:412:
> +               return -ENOTSUPP;
> 
> WARNING: ENOTSUPP is not a SUSV4 error code, prefer EOPNOTSUPP

Both of them are not the correct error to return when an ioctl is not
supported.

> > Anyway, what in-tree driver needs this functionality?  Why does serdev
> > need any ioctl commands?
> >
> i am developing driver for a special bluetooth controller which is integrated within SOC,
> and it does not connect with the BT HOST with UART as normal controller do, but it has very
> similar features as the BT controller with UART I/F. it is mounted on a virtual serial port
> driven by a tty driver developed. but it need to call tty ioctl to make the 
> special BT controller ready to talk with tty port. so i add this interface.

Please submit this change when you submit your driver that uses it at
the same time so we can review them all at once.  We do not add apis
that are not used in the kernel tree.

> as you known, the main purpose of ioctl is to achieve MISC and irregular control. so it is useful
> for these irregular devices.

For tty devices, "custom" ioctls are not ok, use the standard tty
commands and you should be fine for everything you need to do.

If not, then perhaps your design is incorrect?

thanks,

greg k-h
