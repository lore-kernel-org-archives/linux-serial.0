From: Barry Song <21cnbao@gmail.com>
Subject: Re: [PATCH 1/3] serial: sirf: drop redundant pinctrl_get_select_default
 as pinctrl core does it
Date: Thu, 15 Aug 2013 06:38:59 +0800
Message-ID: <CAGsJ_4zTK2hYJxSy1jhnLNe4UOqwVb1WR5Ait+VnSuyYg2zxyw@mail.gmail.com>
References: <1376392697-20664-1-git-send-email-Baohua.Song@csr.com> <20130814191118.GA17612@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-qa0-f47.google.com ([209.85.216.47]:49188 "EHLO
	mail-qa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933300Ab3HNWjW (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 14 Aug 2013 18:39:22 -0400
Received: by mail-qa0-f47.google.com with SMTP id o19so1365066qap.6
        for <linux-serial@vger.kernel.org>; Wed, 14 Aug 2013 15:39:21 -0700 (PDT)
In-Reply-To: <20130814191118.GA17612@kroah.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org, DL-SHA-WorkGroupLinux <workgroup.linux@csr.com>, Barry Song <Baohua.Song@csr.com>, Linus Walleij <linus.walleij@linaro.org>

2013/8/15 Greg KH <gregkh@linuxfoundation.org>
>
> On Tue, Aug 13, 2013 at 07:18:15PM +0800, Barry Song wrote:
> > pinctrl core will get default pinmux, so drop it in the sirfsoc serial driver.
> >
> > Cc: Linus Walleij <linus.walleij@linaro.org>
> > Signed-off-by: Barry Song <Baohua.Song@csr.com>
> > ---
> >  drivers/tty/serial/sirfsoc_uart.c | 12 ------------
> >  drivers/tty/serial/sirfsoc_uart.h |  1 -
> >  2 files changed, 13 deletions(-)
>
> This patch fails to apply to my tree:
>
> checking file drivers/tty/serial/sirfsoc_uart.c
> Hunk #3 FAILED at 917.
> Hunk #4 FAILED at 928.
> 2 out of 4 hunks FAILED
> checking file drivers/tty/serial/sirfsoc_uart.h
>
> And as such, I can't take any of the patches in this series :(
>
> Care to redo them against my tty-next branch if you wish to have them
> applied?
>
i am sorry, and will be more careful later. i did not rebase to
tty-next this time as i thought i have sync my local tree same with
your tree but missed an external patch of dropping
platform_set_drvdata(pdev, NULL);

index 3b9382b..d28f38b 100644
--- a/drivers/tty/serial/sirfsoc_uart.c
+++ b/drivers/tty/serial/sirfsoc_uart.c
@@ -924,7 +924,6 @@ port_err:
        clk_disable_unprepare(sirfport->clk);
        clk_put(sirfport->clk);
 clk_err:
-       platform_set_drvdata(pdev, NULL);
        if (sirfport->hw_flow_ctrl)
                pinctrl_put(sirfport->p);
 err:
@@ -935,7 +934,7 @@ static int sirfsoc_uart_remove(struct platform_device *pdev)
 {
        struct sirfsoc_uart_port *sirfport = platform_get_drvdata(pdev);
        struct uart_port *port = &sirfport->port;
-       platform_set_drvdata(pdev, NULL);
+
        if (sirfport->hw_flow_ctrl)
                pinctrl_put(sirfport->p);
        clk_disable_unprepare(sirfport->clk);

i will send v2 to fix it.

> thanks,
>
> greg k-h

-barry
