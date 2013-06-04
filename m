From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH v6] tty: serial: add Freescale lpuart driver support
Date: Tue, 4 Jun 2013 00:08:27 -0300
Message-ID: <CAOMZO5DzVhh4REj5S=cVVVrGzxmTxY9s_h_6ZQ-G8wOxi+KG=A@mail.gmail.com>
References: <1370309270-21019-1-git-send-email-b35083@freescale.com>
	<CAOMZO5BNbbbX0wycis_3nyg-B76kJYrQu-e+D1SpGLs10Zp3yw@mail.gmail.com>
	<B56CDBE15CE27145A4B77D2D24263E851CEFD9@039-SN1MPN1-003.039d.mgd.msft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-ve0-f172.google.com ([209.85.128.172]:53581 "EHLO
	mail-ve0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753514Ab3FDDI2 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 3 Jun 2013 23:08:28 -0400
Received: by mail-ve0-f172.google.com with SMTP id jz10so3410920veb.17
        for <linux-serial@vger.kernel.org>; Mon, 03 Jun 2013 20:08:27 -0700 (PDT)
In-Reply-To: <B56CDBE15CE27145A4B77D2D24263E851CEFD9@039-SN1MPN1-003.039d.mgd.msft.net>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Lu Jingchang-B35083 <B35083@freescale.com>
Cc: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "shawn.guo@linaro.org" <shawn.guo@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Tue, Jun 4, 2013 at 12:02 AM, Lu Jingchang-B35083
<B35083@freescale.com> wrote:

> [Lu Jingchang-B35083]
>   SERIAL_FSL_LPUART_CONSOLE depends on SERIAL_FSL_LPUART=y in the patch as below, when SERIAL_FSL_LPUART is configured as module, it can't be configured as console. Thanks!

Why to prevent using the console of the driver is built as module?
