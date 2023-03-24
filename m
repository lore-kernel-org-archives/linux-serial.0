Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 921CFC6FD20
	for <linux-serial@archiver.kernel.org>; Fri, 24 Mar 2023 12:57:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231228AbjCXM5x (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 24 Mar 2023 08:57:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231150AbjCXM5x (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 24 Mar 2023 08:57:53 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E9411E5C1
        for <linux-serial@vger.kernel.org>; Fri, 24 Mar 2023 05:57:52 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id r7-20020a17090b050700b002404be7920aso934135pjz.5
        for <linux-serial@vger.kernel.org>; Fri, 24 Mar 2023 05:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679662671;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LKptuzGuQaJK21efBFKz2PjWJVwyLEkP1Oow1tblUdI=;
        b=SUCuUAz1VvK/9MCXtMveCgbHkC/3BfY75pCWWyiHn2YKI1NG2ibiy1GK6IrN+nTZlW
         IOqWibsy1p0S7hOIIjhltDr8B4MyO73tOz+PUS4tlQFoE+iyvBhcuHE38EDGRlQNvC2b
         aefhxqFRhRhmM3hczANAYE3innxlfVFokff2ScweN3YlbE0lW12nWQ3WaDXqeUNovSVH
         vudbhqq7Dysr/mGM/GmV37XepUUNDTUds6eqWvtW3uah3yIijePltd59sijienOykHGZ
         3s3pMQdUf+WFlWmfrwKyvpmN+E3V3j61EU66FSTKn4qNsQNPOyLnt0zP0lqnuAodBfK/
         xGiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679662671;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LKptuzGuQaJK21efBFKz2PjWJVwyLEkP1Oow1tblUdI=;
        b=OXrn8vCyzCfDkc6jpGT8HVOqbw2BSRrMPRFktAOmpZJNnS38H4LcNo3a8Iv45DFQyS
         jtRZP+EZZ77/XaNIvfkUiJPVo7zVoV4+6fyEAwHf20rcksH2Gvdi+0Js3KSJlUAnBo/U
         hgjqKwcEE1P1uRE6ntR73luVI5P0KA3GXG7xN10i4viT0dOJhs31Dm2dQ2OqOBmzx0xt
         O1KF6YJ+6EqnkxWB4vOvaH2tjEbkoB561JiWc1jsg5c6sXhkAX8J1oeSyAvL8+YH4XZm
         E3hFYdNK4kWVoHgkcnXoQ0kzgrPmld4z29eUGoZPryQNzaGTMp1kL2ksySEP7u2hYwh+
         WLGQ==
X-Gm-Message-State: AAQBX9dk2bbQ5W5sUNZHLOBRW9WjJNHF+orqXCalxXrkYL6xhsEPl1PN
        cJqZqDMddLO+jGBC7RuFcV2SVXgZPcxBtHrRmU0=
X-Google-Smtp-Source: AKy350ZevwdwSX+C2Ix7/+qpd/UMSXvqBROeCRo84GEjTH2DAntVqzkVvjWqVoyrW4zpRrU81BbI7239e36XXPs6SdU=
X-Received: by 2002:a17:903:2290:b0:19f:30be:e9f6 with SMTP id
 b16-20020a170903229000b0019f30bee9f6mr946021plh.6.1679662671511; Fri, 24 Mar
 2023 05:57:51 -0700 (PDT)
MIME-Version: 1.0
References: <2c29454b-9369-4360-8eb4-c151f59460cb@i2se.com> <d660e3cf-5686-d989-3b59-efe83ec9d590@linux.intel.com>
In-Reply-To: <d660e3cf-5686-d989-3b59-efe83ec9d590@linux.intel.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Fri, 24 Mar 2023 09:57:39 -0300
Message-ID: <CAOMZO5A+GujiQY-UT3Q-8o0AKujJb_4kY+5L4x1e07ovGfo31w@mail.gmail.com>
Subject: Re: Regression: serial: imx: overrun errors on debug UART
To:     =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     Stefan Wahren <stefan.wahren@i2se.com>,
        =?UTF-8?Q?Tomasz_Mo=C5=84?= <tomasz.mon@camlingroup.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Sergey Organov <sorganov@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-serial@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Stefan Wahren <stefan.wahren@chargebyte.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi Stefan,

On Fri, Mar 24, 2023 at 8:48=E2=80=AFAM Ilpo J=C3=A4rvinen
<ilpo.jarvinen@linux.intel.com> wrote:

> This has come up earlier, see e.g.:
>
> https://lore.kernel.org/linux-serial/20221003110850.GA28338@francesco-nb.=
int.toradex.com/
>
> My somewhat uninformed suggestion: if the overrun problems mostly show up
> with console ports, maybe the trigger level could depend on the port
> being a console or not?

Does the change below help? Taking Ilpo's suggestion into account:

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 0fa1bd8cdec7..4d0aae38b7a5 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -233,6 +233,7 @@ struct imx_port {
        enum imx_tx_state       tx_state;
        struct hrtimer          trigger_start_tx;
        struct hrtimer          trigger_stop_tx;
+       unsigned int            rxtl;
 };

 struct imx_port_ucrs {
@@ -1309,6 +1310,7 @@ static void imx_uart_clear_rx_errors(struct
imx_port *sport)
 }

 #define TXTL_DEFAULT 2 /* reset default */
+#define RXTL_DEFAULT_CONSOLE 1 /* 1 character or aging timer */
 #define RXTL_DEFAULT 8 /* 8 characters or aging timer */
 #define TXTL_DMA 8 /* DMA burst setting */
 #define RXTL_DMA 9 /* DMA burst setting */
@@ -1422,7 +1424,7 @@ static void imx_uart_disable_dma(struct imx_port *spo=
rt)
        ucr1 &=3D ~(UCR1_RXDMAEN | UCR1_TXDMAEN | UCR1_ATDMAEN);
        imx_uart_writel(sport, ucr1, UCR1);

-       imx_uart_setup_ufcr(sport, TXTL_DEFAULT, RXTL_DEFAULT);
+       imx_uart_setup_ufcr(sport, TXTL_DEFAULT, sport->rxtl);

        sport->dma_is_enabled =3D 0;
 }
@@ -1447,7 +1449,7 @@ static int imx_uart_startup(struct uart_port *port)
                return retval;
        }

-       imx_uart_setup_ufcr(sport, TXTL_DEFAULT, RXTL_DEFAULT);
+       imx_uart_setup_ufcr(sport, TXTL_DEFAULT, sport->rxtl);

        /* disable the DREN bit (Data Ready interrupt enable) before
         * requesting IRQs
@@ -1464,6 +1466,11 @@ static int imx_uart_startup(struct uart_port *port)
        if (!uart_console(port) && imx_uart_dma_init(sport) =3D=3D 0)
                dma_is_inited =3D 1;

+       if (uart_console(port))
+               sport->rxtl =3D RXTL_DEFAULT_CONSOLE;
+       else
+               sport->rxtl =3D RXTL_DEFAULT;
+
        spin_lock_irqsave(&sport->port.lock, flags);

        /* Reset fifo's and state machines */
@@ -1863,7 +1870,7 @@ static int imx_uart_poll_init(struct uart_port *port)
        if (retval)
                clk_disable_unprepare(sport->clk_ipg);

-       imx_uart_setup_ufcr(sport, TXTL_DEFAULT, RXTL_DEFAULT);
+       imx_uart_setup_ufcr(sport, TXTL_DEFAULT, sport->rxtl);

        spin_lock_irqsave(&sport->port.lock, flags);

@@ -2139,7 +2146,7 @@ imx_uart_console_setup(struct console *co, char *opti=
ons)
        else
                imx_uart_console_get_options(sport, &baud, &parity, &bits);

-       imx_uart_setup_ufcr(sport, TXTL_DEFAULT, RXTL_DEFAULT);
+       imx_uart_setup_ufcr(sport, TXTL_DEFAULT, sport->rxtl);

        retval =3D uart_set_options(&sport->port, co, baud, parity, bits, f=
low);
