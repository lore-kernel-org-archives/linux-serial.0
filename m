Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43E37C433F5
	for <linux-serial@archiver.kernel.org>; Mon,  1 Nov 2021 07:59:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B0EC60F56
	for <linux-serial@archiver.kernel.org>; Mon,  1 Nov 2021 07:59:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbhKAIBi (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 1 Nov 2021 04:01:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:41868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229933AbhKAIBh (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 1 Nov 2021 04:01:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4069C60F56;
        Mon,  1 Nov 2021 07:59:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1635753544;
        bh=hp2luMpeIUeaO2bLE5QCgM1ttGKCyStAm0Cx5a4oosY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Q87/8yosEOBECSjbEUMCLoQVtRgJp+UZytezIO+6WHcaSDVZlxyR+QXtEpFCNDHvf
         BXu2TxfFrd56yu2/PKs1qsV1DwD2Tg8CgjvHp/0oojGJekp+Idta76HsERkzdGNOv2
         eJeGpZh68wQEArTRBNP5Ip0J3YbVygOHKL+AtfCY=
Date:   Mon, 1 Nov 2021 08:59:02 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Zijun Hu <zijuhu@codeaurora.org>
Cc:     robh@kernel.org, jirislaby@kernel.org,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>
Subject: Re: [PATCH v1] serdev: Add interface serdev_device_ioctl
Message-ID: <YX+eRgCrUs2Y5iaX@kroah.com>
References: <1635753048-5289-1-git-send-email-zijuhu@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1635753048-5289-1-git-send-email-zijuhu@codeaurora.org>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, Nov 01, 2021 at 03:50:48PM +0800, Zijun Hu wrote:
> From: Zijun Hu <quic_zijuhu@quicinc.com>
> 
> For serdev_device which is mounted at virtual tty port, tty ioctl()
> maybe be used to make serdev_device ready to talk with tty port, so
> add interface serdev_device_ioctl().
> 
> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
> ---
>  drivers/tty/serdev/core.c           | 11 +++++++++++
>  drivers/tty/serdev/serdev-ttyport.c | 12 ++++++++++++
>  include/linux/serdev.h              |  9 +++++++++
>  3 files changed, 32 insertions(+)
> 
> diff --git a/drivers/tty/serdev/core.c b/drivers/tty/serdev/core.c
> index f1324fe99378..c0f6cd64716b 100644
> --- a/drivers/tty/serdev/core.c
> +++ b/drivers/tty/serdev/core.c
> @@ -405,6 +405,17 @@ int serdev_device_set_tiocm(struct serdev_device *serdev, int set, int clear)
>  }
>  EXPORT_SYMBOL_GPL(serdev_device_set_tiocm);
>  
> +int serdev_device_ioctl(struct serdev_device *serdev, unsigned int cmd, unsigned long arg)
> +{
> +	struct serdev_controller *ctrl = serdev->ctrl;
> +
> +	if (!ctrl || !ctrl->ops->ioctl)
> +		return -EOPNOTSUPP;

Wrong error for returning that an ioctl is not handled :(

Anyway, what in-tree driver needs this functionality?  Why does serdev
need any ioctl commands?

thanks,

greg k-h
