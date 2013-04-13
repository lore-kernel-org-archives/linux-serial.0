From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH] tty/serial: add MVF uart driver support
Date: Sat, 13 Apr 2013 17:41:26 -0300
Message-ID: <CAOMZO5D-uQQJAc6zAMkF9ViR0KWg4q7cPr7+pLdfyAm9gtPyTA@mail.gmail.com>
References: <1365750655-3530-1-git-send-email-b35083@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-ve0-f176.google.com ([209.85.128.176]:53167 "EHLO
	mail-ve0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753362Ab3DMUl1 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sat, 13 Apr 2013 16:41:27 -0400
Received: by mail-ve0-f176.google.com with SMTP id ox1so3284024veb.35
        for <linux-serial@vger.kernel.org>; Sat, 13 Apr 2013 13:41:26 -0700 (PDT)
In-Reply-To: <1365750655-3530-1-git-send-email-b35083@freescale.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Jingchang Lu <b35083@freescale.com>
Cc: linux-serial@vger.kernel.org, shawn.guo@linaro.org, linux-arm-kernel@lists.infradead.org, Sascha Hauer <s.hauer@pengutronix.de>

On Fri, Apr 12, 2013 at 4:10 AM, Jingchang Lu <b35083@freescale.com> wrote:
> It adds Freescale Vybrid Family uart driver support
>
> Signed-off-by: Jingchang Lu <b35083@freescale.com>
> ---
>  drivers/tty/serial/Kconfig       |   17 +
>  drivers/tty/serial/Makefile      |    1 +
>  drivers/tty/serial/mvf.c         | 1246 ++++++++++++++++++++++++++++++++++++++
>  include/uapi/linux/serial_core.h |    3 +
>  4 files changed, 1267 insertions(+)
>  create mode 100644 drivers/tty/serial/mvf.c

Would it be possible to add Vybrid support into the existing imx serial port?
