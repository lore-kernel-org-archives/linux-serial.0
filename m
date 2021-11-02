Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABFC8C433EF
	for <linux-serial@archiver.kernel.org>; Tue,  2 Nov 2021 07:20:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 818F660F02
	for <linux-serial@archiver.kernel.org>; Tue,  2 Nov 2021 07:20:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231405AbhKBHXO convert rfc822-to-8bit (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 2 Nov 2021 03:23:14 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:59147 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230465AbhKBHXN (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 2 Nov 2021 03:23:13 -0400
Received: from smtpclient.apple (p4fefc15c.dip0.t-ipconnect.de [79.239.193.92])
        by mail.holtmann.org (Postfix) with ESMTPSA id 86F41CECE9;
        Tue,  2 Nov 2021 08:20:36 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.20.0.1.32\))
Subject: Re: [PATCH v1 1/3] serdev: Add interface serdev_device_ioctl
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1635836707-29341-1-git-send-email-zijuhu@codeaurora.org>
Date:   Tue, 2 Nov 2021 08:20:36 +0100
Cc:     robh@kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        jirislaby@kernel.org, linux-serial@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Zijun Hu <quic_zijuhu@quicinc.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <C6172915-FCF9-4638-BB9C-F7E9FCAEF9F0@holtmann.org>
References: <1635836707-29341-1-git-send-email-zijuhu@codeaurora.org>
To:     Zijun Hu <zijuhu@codeaurora.org>
X-Mailer: Apple Mail (2.3693.20.0.1.32)
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi Zijun,

> For serdev_device which is mounted at virtual tty port, tty ioctl()
> maybe be used to make serdev_device ready to talk with tty port, so
> add interface serdev_device_ioctl().
> 
> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
> ---
> drivers/tty/serdev/core.c           | 13 +++++++++++++
> drivers/tty/serdev/serdev-ttyport.c | 12 ++++++++++++
> include/linux/serdev.h              |  9 +++++++++
> 3 files changed, 34 insertions(+)
> 
> diff --git a/drivers/tty/serdev/core.c b/drivers/tty/serdev/core.c
> index f1324fe99378..dee934203277 100644
> --- a/drivers/tty/serdev/core.c
> +++ b/drivers/tty/serdev/core.c
> @@ -405,6 +405,19 @@ int serdev_device_set_tiocm(struct serdev_device *serdev, int set, int clear)
> }
> EXPORT_SYMBOL_GPL(serdev_device_set_tiocm);
> 
> +int serdev_device_ioctl(struct serdev_device *serdev, unsigned int cmd, unsigned long arg)
> +{
> +	struct serdev_controller *ctrl = serdev->ctrl;
> +
> +	if (!ctrl)
> +		return -ENOTTY;
> +	else if	(!ctrl->ops->ioctl)
> +		return -ENOSYS;
> +	else
> +		return ctrl->ops->ioctl(ctrl, cmd, arg);
> +}
> +EXPORT_SYMBOL_GPL(serdev_device_ioctl);
> +
> static int serdev_drv_probe(struct device *dev)
> {
> 	const struct serdev_device_driver *sdrv = to_serdev_device_driver(dev->driver);
> diff --git a/drivers/tty/serdev/serdev-ttyport.c b/drivers/tty/serdev/serdev-ttyport.c
> index d367803e2044..66afad1eb1b7 100644
> --- a/drivers/tty/serdev/serdev-ttyport.c
> +++ b/drivers/tty/serdev/serdev-ttyport.c
> @@ -247,6 +247,17 @@ static int ttyport_set_tiocm(struct serdev_controller *ctrl, unsigned int set, u
> 	return tty->ops->tiocmset(tty, set, clear);
> }
> 
> +static int ttyport_ioctl(struct serdev_controller *ctrl, unsigned int cmd, unsigned long arg)
> +{
> +	struct serport *serport = serdev_controller_get_drvdata(ctrl);
> +	struct tty_struct *tty = serport->tty;
> +
> +	if (!tty->ops->ioctl)
> +		return -ENOSYS;
> +
> +	return tty->ops->ioctl(tty, cmd, arg);
> +}
> +
> static const struct serdev_controller_ops ctrl_ops = {
> 	.write_buf = ttyport_write_buf,
> 	.write_flush = ttyport_write_flush,
> @@ -259,6 +270,7 @@ static const struct serdev_controller_ops ctrl_ops = {
> 	.wait_until_sent = ttyport_wait_until_sent,
> 	.get_tiocm = ttyport_get_tiocm,
> 	.set_tiocm = ttyport_set_tiocm,
> +	.ioctl = ttyport_ioctl,
> };
> 
> struct device *serdev_tty_port_register(struct tty_port *port,
> diff --git a/include/linux/serdev.h b/include/linux/serdev.h
> index 3368c261ab62..5804201fafb2 100644
> --- a/include/linux/serdev.h
> +++ b/include/linux/serdev.h
> @@ -91,6 +91,7 @@ struct serdev_controller_ops {
> 	void (*wait_until_sent)(struct serdev_controller *, long);
> 	int (*get_tiocm)(struct serdev_controller *);
> 	int (*set_tiocm)(struct serdev_controller *, unsigned int, unsigned int);
> +	int (*ioctl)(struct serdev_controller *ctrl, unsigned int cmd, unsigned long arg);
> };

I thought the conclusion was not do this and instead have a proper Bluetooth driver. So please drop this patch.

Regards

Marcel

