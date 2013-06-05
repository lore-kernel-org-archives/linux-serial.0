From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH v2 2/2] serial: imx: Allow module build
Date: Tue, 4 Jun 2013 23:44:11 -0300
Message-ID: <CAOMZO5BW_GgAAsJKyKfRW_vfO7ajLkfZdUiD=PHdLpzNUDYOFg@mail.gmail.com>
References: <1370365718-23474-1-git-send-email-fabio.estevam@freescale.com>
	<1370365718-23474-2-git-send-email-fabio.estevam@freescale.com>
	<B56CDBE15CE27145A4B77D2D24263E851CF28F@039-SN1MPN1-003.039d.mgd.msft.net>
	<86D15885F63D1143A519F161FB828EAF267106@039-SN2MPN1-013.039d.mgd.msft.net>
	<B56CDBE15CE27145A4B77D2D24263E851CF2E7@039-SN1MPN1-003.039d.mgd.msft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-ve0-f179.google.com ([209.85.128.179]:33997 "EHLO
	mail-ve0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751116Ab3FECoM (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 4 Jun 2013 22:44:12 -0400
Received: by mail-ve0-f179.google.com with SMTP id d10so854741vea.10
        for <linux-serial@vger.kernel.org>; Tue, 04 Jun 2013 19:44:11 -0700 (PDT)
In-Reply-To: <B56CDBE15CE27145A4B77D2D24263E851CF2E7@039-SN1MPN1-003.039d.mgd.msft.net>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Lu Jingchang-B35083 <B35083@freescale.com>
Cc: Estevam Fabio-R49496 <r49496@freescale.com>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "shawn.guo@linaro.org" <shawn.guo@linaro.org>, "kernel@pengutronix.de" <kernel@pengutronix.de>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>

On Tue, Jun 4, 2013 at 11:33 PM, Lu Jingchang-B35083
<B35083@freescale.com> wrote:

> [Lu Jingchang-B35083]
> With make arch=ARM clean, I still meet the same fail problem. Does the driver support console when built as module?
> If it does, I see that "uart_console_device" referenced by imx.c is not exported with EXPORT_SYMBOL in serial core.
> From the patch, I think the drive support console when built as module, doesn't it?
> But explanation from Arnd Bergmann [arnd@arndb.de] yesterday is: "All serial port drivers do this. IIRC the reason is that the console has to be started from console_initcall(), which is not available in modules."
> It seems serial driver module mode doesn't support console support, do I misunderstand?

Yes, correct. Looks like your last patch is the correct approach. I
will send a v3.

Regards,

Fabio Estevam
