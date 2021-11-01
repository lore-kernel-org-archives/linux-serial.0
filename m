Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4E0AC433F5
	for <linux-serial@archiver.kernel.org>; Mon,  1 Nov 2021 11:54:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5843610A8
	for <linux-serial@archiver.kernel.org>; Mon,  1 Nov 2021 11:54:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231749AbhKAL4t (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 1 Nov 2021 07:56:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:49894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232198AbhKAL4r (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 1 Nov 2021 07:56:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 584CD610A8;
        Mon,  1 Nov 2021 11:54:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1635767654;
        bh=5GVpmTGqcSsozn4hY6lZg7D/j5U9J7/08+1Wzgsqao8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MLQ3SrtEIi2la5eXWvUi0kkcZ9qUd0Topxa1AwkjaKMzCQJ4JB2Asyh+C1FJ/I1oN
         YEkUfMUlx5m4LR82D4ptWO0xRXO/8NeCqkRs07DTXtAADshNBgfB+8kZuiYQZyVg7y
         stsk9Us51S2fYznoRJWyS25EHxkyQDFLc5tC2aNg=
Date:   Mon, 1 Nov 2021 12:54:09 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Zijun Hu <zijuhu@codeaurora.org>, robh@kernel.org,
        jirislaby@kernel.org, linux-serial@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Zijun Hu <quic_zijuhu@quicinc.com>
Subject: Re: [PATCH v1] serdev: Add interface serdev_device_ioctl
Message-ID: <YX/VYUC3ngOf5bX5@kroah.com>
References: <1635753048-5289-1-git-send-email-zijuhu@codeaurora.org>
 <YX+eRgCrUs2Y5iaX@kroah.com>
 <fe5a8bec-b186-c719-5f02-a0a67eb8862f@codeaurora.org>
 <YX+mDGr8tDzVT4Hr@kroah.com>
 <573d3640-2e8b-9266-4205-755ac0951abd@codeaurora.org>
 <YX/M/MZL8jbu7p7I@kroah.com>
 <DC399B43-DB1E-42AC-8A31-3A2C9407EE6D@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DC399B43-DB1E-42AC-8A31-3A2C9407EE6D@holtmann.org>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, Nov 01, 2021 at 12:45:36PM +0100, Marcel Holtmann wrote:
> Hi Greg,
> 
> >>>>>> For serdev_device which is mounted at virtual tty port, tty ioctl()
> >>>>>> maybe be used to make serdev_device ready to talk with tty port, so
> >>>>>> add interface serdev_device_ioctl().
> >>>>>> 
> >>>>>> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
> >>>>>> ---
> >>>>>> drivers/tty/serdev/core.c           | 11 +++++++++++
> >>>>>> drivers/tty/serdev/serdev-ttyport.c | 12 ++++++++++++
> >>>>>> include/linux/serdev.h              |  9 +++++++++
> >>>>>> 3 files changed, 32 insertions(+)
> >>>>>> 
> >>>>>> diff --git a/drivers/tty/serdev/core.c b/drivers/tty/serdev/core.c
> >>>>>> index f1324fe99378..c0f6cd64716b 100644
> >>>>>> --- a/drivers/tty/serdev/core.c
> >>>>>> +++ b/drivers/tty/serdev/core.c
> >>>>>> @@ -405,6 +405,17 @@ int serdev_device_set_tiocm(struct serdev_device *serdev, int set, int clear)
> >>>>>> }
> >>>>>> EXPORT_SYMBOL_GPL(serdev_device_set_tiocm);
> >>>>>> 
> >>>>>> +int serdev_device_ioctl(struct serdev_device *serdev, unsigned int cmd, unsigned long arg)
> >>>>>> +{
> >>>>>> +	struct serdev_controller *ctrl = serdev->ctrl;
> >>>>>> +
> >>>>>> +	if (!ctrl || !ctrl->ops->ioctl)
> >>>>>> +		return -EOPNOTSUPP;
> >>>>> 
> >>>>> Wrong error for returning that an ioctl is not handled :(
> >>>> checkpatch.pl always reports below WARNING when i use ENOTSUPP as present interfaces
> >>>> do. so i change error code to EOPNOTSUPP.
> >>>> 
> >>>> #28: FILE: drivers/tty/serdev/core.c:412:
> >>>> +               return -ENOTSUPP;
> >>>> 
> >>>> WARNING: ENOTSUPP is not a SUSV4 error code, prefer EOPNOTSUPP
> >>> 
> >>> Both of them are not the correct error to return when an ioctl is not
> >>> supported.
> >>> 
> >> is ENODEV okay?
> > 
> > No, -ENOTTY is the correct one as per the documentation, right?
> > 
> >>>>> Anyway, what in-tree driver needs this functionality?  Why does serdev
> >>>>> need any ioctl commands?
> >>>>> 
> >>>> i am developing driver for a special bluetooth controller which is integrated within SOC,
> >>>> and it does not connect with the BT HOST with UART as normal controller do, but it has very
> >>>> similar features as the BT controller with UART I/F. it is mounted on a virtual serial port
> >>>> driven by a tty driver developed. but it need to call tty ioctl to make the 
> >>>> special BT controller ready to talk with tty port. so i add this interface.
> >>> 
> >>> Please submit this change when you submit your driver that uses it at
> >>> the same time so we can review them all at once.  We do not add apis
> >>> that are not used in the kernel tree.
> >>> 
> >> okay
> >>>> as you known, the main purpose of ioctl is to achieve MISC and irregular control. so it is useful
> >>>> for these irregular devices.
> >>> 
> >>> For tty devices, "custom" ioctls are not ok, use the standard tty
> >>> commands and you should be fine for everything you need to do.
> >>> 
> >>> If not, then perhaps your design is incorrect?
> >>> 
> >> i just want to refer bt_ioctl within https://source.codeaurora.org/quic/qsdk/oss/kernel/linux-ipq-5.4/tree/drivers/soc/qcom/bt_tty.c?h=NHSS.QSDK.11.5.0.5.r2
> >> by serdev. so add this interface.
> > 
> > The 5.4 kernel is not relevant here, so I do not understand.
> > 
> >> are there any other good solution to advise?
> > 
> > Why not work with the bluetooth developers on this?
> 
> if this is just to have some hackish Bluetooth driver, then NAK from my side. Since we have serdev, we have no need for, or requirements for any ioctl anymore. If such thing is needed, it is a bad design.

Thanks for the confirmation, seems sane to me!

Zijun, please fix up your driver and submit it to be merged and all
should be fine, no need for any custom ioctls.

thanks,

greg k-h
