From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH] serial: imx: enable the clocks for console
Date: Sat, 8 Jun 2013 10:11:07 -0300
Message-ID: <CAOMZO5A4SPFv1NopdGrN9nX-XSpZy5Cw1CLp3E95mRP8O=rhLQ@mail.gmail.com>
References: <20130608062307.GB22416@S2101-09.ap.freescale.net>
	<1370678667-3514-1-git-send-email-b32955@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-vc0-f171.google.com ([209.85.220.171]:62380 "EHLO
	mail-vc0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751379Ab3FHNLI (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sat, 8 Jun 2013 09:11:08 -0400
Received: by mail-vc0-f171.google.com with SMTP id gd11so561877vcb.2
        for <linux-serial@vger.kernel.org>; Sat, 08 Jun 2013 06:11:07 -0700 (PDT)
In-Reply-To: <1370678667-3514-1-git-send-email-b32955@freescale.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Huang Shijie <b32955@freescale.com>
Cc: gregkh@linuxfoundation.org, shawn.guo@linaro.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Huang,

On Sat, Jun 8, 2013 at 5:04 AM, Huang Shijie <b32955@freescale.com> wrote:

> +       if (!uart_console(port)) {
> +               retval = clk_prepare_enable(sport->clk_per);
> +               if (retval)
> +                       goto error_out1;
> +               retval = clk_prepare_enable(sport->clk_ipg);
> +               if (retval)
> +                       goto error_out1;

Here you should not jump to "error_out1".

You should jump to a different label and disable the sport->clk_per clock.

This was also wrong in your previous patch.
