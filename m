From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH v6] tty: serial: add Freescale lpuart driver support
Date: Mon, 3 Jun 2013 23:54:42 -0300
Message-ID: <CAOMZO5BNbbbX0wycis_3nyg-B76kJYrQu-e+D1SpGLs10Zp3yw@mail.gmail.com>
References: <1370309270-21019-1-git-send-email-b35083@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-vb0-f42.google.com ([209.85.212.42]:44504 "EHLO
	mail-vb0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756753Ab3FDCyn (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 3 Jun 2013 22:54:43 -0400
Received: by mail-vb0-f42.google.com with SMTP id w15so3230555vbf.29
        for <linux-serial@vger.kernel.org>; Mon, 03 Jun 2013 19:54:42 -0700 (PDT)
In-Reply-To: <1370309270-21019-1-git-send-email-b35083@freescale.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Jingchang Lu <b35083@freescale.com>
Cc: linux-serial@vger.kernel.org, gregkh@linuxfoundation.org, s.hauer@pengutronix.de, shawn.guo@linaro.org, linux-arm-kernel@lists.infradead.org

On Mon, Jun 3, 2013 at 10:27 PM, Jingchang Lu <b35083@freescale.com> wrote:

> +config SERIAL_FSL_LPUART
> +       tristate "Freescale lpuart serial port support"
> +       select SERIAL_CORE
> +       help
> +         Support for the on-chip lpuart on some Freescale SOCs.
> +
> +config SERIAL_FSL_LPUART_CONSOLE
> +       bool "Console on Freescale lpuart serial port"

It is better yo use tristate here as well.

I have just sent the same fix for imx serial.

Keeping it bool may lead to build error when SERIAL_FSL_LPUART=m and
SERIAL_FSL_LPUART_CONSOLE=y

Regards,

Fabio Estevam
