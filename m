Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4FB1C46467
	for <linux-serial@archiver.kernel.org>; Thu, 15 Dec 2022 21:39:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbiLOVjW (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 15 Dec 2022 16:39:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbiLOVjS (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 15 Dec 2022 16:39:18 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A45355C757
        for <linux-serial@vger.kernel.org>; Thu, 15 Dec 2022 13:39:16 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id 4so373397plj.3
        for <linux-serial@vger.kernel.org>; Thu, 15 Dec 2022 13:39:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=h7/2YnkVuiIGLOWco/NzVPRk7bUN+sBgdzIXm01FjBA=;
        b=UYR5JxmxZFiLWhHFyYbPZIQ7rzJdMeALPUXI+Z3ZPEpgiRJ6k+YQaDGwfGUlca6467
         uKfoYAakaOaWnDwxi9dY3PqvtSHTbgPN2dxHNaiGFpmJQx6L7yO1E1y9xx6Y51wLwmGu
         VDLub8C7w185vF8EokMgNtpEwBZt4LKBiQP2+n2TTk5BcTyFyNwmoxmnAweAR3wVX3s9
         v558APPYfYJbmUHnLIa7wuxEWj5K3T1CtjfmFDZQ7hLSd8bvDiUOqmdJvtYvv//ShMdx
         3yY1qXxXpXfIwCwVSeLRi2icOspnIpi6/WYDqbV9V10z3Gb/tDinO/cL0rWq7AvwTXjS
         u8ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h7/2YnkVuiIGLOWco/NzVPRk7bUN+sBgdzIXm01FjBA=;
        b=kqgclO/pZqEyQYUBdvRJq2h2HOSnfaZYZOwbohcRbj1LL7b52r/WdQvDnVHMWtZ/Ha
         MM/EfOeuMoAeC78RGLT4Yjt6CofrPvUwWRg/p/h9DJyN4Dt32VZemF/fot0ILAUT9sNx
         mpAuGDZ2SfnitJIXexf0cMjDw2f0xQKS8J2SXWGpxuaxEB7XLhC1xn75ntC94hFcHhlH
         5+39cfBwOu8QPNT5sLh8hWTwZk5jcz9JNMU2CX8BGCh+OX+1jMlgJqt9kPrfLO17Lipl
         x8RJM3KEsYVvcSHFNI4wP2nkg1CmqEB3Opa3FhTADkBlPpBjz8+6Y3WaGtHdQK5hXE62
         Qg9w==
X-Gm-Message-State: AFqh2krgpkI48eH0mr52FVVGB2xK7xuU1l1LCYfsO39VPUMaPCfLu/J1
        +STF6/8gxP784hd571YHt2qSvEz8Mc1ll17u59RBKS0w52o=
X-Google-Smtp-Source: AMrXdXt6KsVLrjCv0wNZmngaa+ekj7gcoQe87eQKLvF1Z9WglvlZq+sfiDV7rbmYGKPpu/uC4HDkNGBTHYIxUBZRGPw=
X-Received: by 2002:a17:90a:8506:b0:219:720c:29cb with SMTP id
 l6-20020a17090a850600b00219720c29cbmr456910pjn.76.1671140356057; Thu, 15 Dec
 2022 13:39:16 -0800 (PST)
MIME-Version: 1.0
References: <87bko4e65y.fsf@osv.gnss.ru>
In-Reply-To: <87bko4e65y.fsf@osv.gnss.ru>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Thu, 15 Dec 2022 18:38:58 -0300
Message-ID: <CAOMZO5DFth_0wzBb8HHeHoNGkT1rexb7xvakvfiNgdY=cHJSfg@mail.gmail.com>
Subject: Re: serial: imx: sudden rx flood: hardware bug?
To:     Sergey Organov <sorganov@gmail.com>
Cc:     linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        =?UTF-8?Q?Tomasz_Mo=C5=84_=3Ctomasz=2Emon=40camlingroup=2Ecom=3E?= 
        <k.drobinski@camlintechnologies.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi Sergey,

On Thu, Dec 15, 2022 at 5:57 PM Sergey Organov <sorganov@gmail.com> wrote:

> An effective method to reproduce the issue is to send isolated start bit
> at baud rate that is about 2.4 times higher than the one configured on
> the iMX UART while corresponding TTY is open on iMX. At these
> conditions the problem appears with about 90% probability, i.e., about 9
> out of 10 "sent" 0xff chars provoke continuous "receiving" of 0xff
> chars by the UART, at intervals corresponding to the UART baud rate,

I recall seeing this storm of receiving 0xff  before.

I fixed it a long time ago with the following commit:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?h=v6.1&id=b38cb7d2571197b56cefae8967f9db15c9361113

Looking at the current code, I see that the UCR3_ADNIMP bit is only
set conditionally.

Could you try the change below?

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 757825edb0cd..997681ec354f 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -2399,6 +2399,12 @@ static int imx_uart_probe(struct platform_device *pdev)
                imx_uart_writel(sport, ucr2, UCR2);
        }

+       if (!imx_uart_is_imx1(sport)) {
+               u32 ucr3 = imx_uart_readl(sport, UCR3);
+               ucr3 |= UCR3_ADNIMP;
+               imx_uart_writel(sport, ucr2, UCR3);
+       }
+
        if (!imx_uart_is_imx1(sport) && sport->dte_mode) {
                /*
                 * The DCEDTE bit changes the direction of DSR, DCD, DTR and RI
@@ -2416,8 +2422,7 @@ static int imx_uart_probe(struct platform_device *pdev)
                 * (confirmed on i.MX25) which makes them unusable.
                 */
                imx_uart_writel(sport,
-                               IMX21_UCR3_RXDMUXSEL | UCR3_ADNIMP | UCR3_DSR,
-                               UCR3);
+                               IMX21_UCR3_RXDMUXSEL | UCR3_DSR, UCR3);

        } else {
                u32 ucr3 = UCR3_DSR;
@@ -2426,7 +2431,7 @@ static int imx_uart_probe(struct platform_device *pdev)
                        imx_uart_writel(sport, ufcr & ~UFCR_DCEDTE, UFCR);

                if (!imx_uart_is_imx1(sport))
-                       ucr3 |= IMX21_UCR3_RXDMUXSEL | UCR3_ADNIMP;
+                       ucr3 |= IMX21_UCR3_RXDMUXSEL;
                imx_uart_writel(sport, ucr3, UCR3);
        }
