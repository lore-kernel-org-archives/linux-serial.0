Return-Path: <SRS0=EpC2=5K=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2D83C54FD0
	for <linux-serial@archiver.kernel.org>; Wed, 25 Mar 2020 08:30:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08B4C20714
	for <linux-serial@archiver.kernel.org>; Wed, 25 Mar 2020 08:30:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=walle.cc header.i=@walle.cc header.b="HKUyML/M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727137AbgCYIaU (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 25 Mar 2020 04:30:20 -0400
Received: from ssl.serverraum.org ([176.9.125.105]:53463 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727275AbgCYIaU (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 25 Mar 2020 04:30:20 -0400
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id B52AA231D9;
        Wed, 25 Mar 2020 09:30:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1585125016;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4Sa75AZDjuoGRR7/aAnGm1x34eoqBqwHwvLgzdRS9Iw=;
        b=HKUyML/MOFe9CMcw7fK52HA8z3eFDlEL39Vi2v7avnRzuZIsLEToXramQIOSN8zLtf80CH
        qfccl5kwyKLZ1HcnM5qymFiu9ioq7ruQjr2ps2HmwawNadXI9AHLpPKSQuUbEaPIb0s14c
        nJfTU+YsLIrz3YBkwVJ07GWcpQyoF84=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 25 Mar 2020 09:30:14 +0100
From:   Michael Walle <michael@walle.cc>
To:     Andy Duan <fugang.duan@nxp.com>
Cc:     Leonard Crestez <leonard.crestez@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shawn Guo <shawnguo@kernel.org>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Vabhav Sharma <vabhav.sharma@nxp.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Peng Fan <peng.fan@nxp.com>
Subject: Re: [EXT] Re: [PATCH v4 1/4] tty: serial: fsl_lpuart: fix DMA
 operation when using IOMMU
In-Reply-To: <VI1PR0402MB360011B90343A8008BDB3A3AFFCE0@VI1PR0402MB3600.eurprd04.prod.outlook.com>
References: <20200306214433.23215-1-michael@walle.cc>
 <20200306214433.23215-2-michael@walle.cc>
 <VI1PR04MB69413E158203E33D42E3B3B3EEF10@VI1PR04MB6941.eurprd04.prod.outlook.com>
 <VI1PR0402MB36001AEE78E0F067D29F2816FFF10@VI1PR0402MB3600.eurprd04.prod.outlook.com>
 <725d2abdcdc0ab05cc1f03028f8a2919@walle.cc>
 <VI1PR0402MB360060ABA69BB138A33C9615FFF10@VI1PR0402MB3600.eurprd04.prod.outlook.com>
 <d9882e8769f234cff634cfdfa9a3dd33@walle.cc>
 <VI1PR0402MB360011B90343A8008BDB3A3AFFCE0@VI1PR0402MB3600.eurprd04.prod.outlook.com>
Message-ID: <eb5758c9ae3a78954cff0361fa2b5b76@walle.cc>
X-Sender: michael@walle.cc
User-Agent: Roundcube Webmail/1.3.10
X-Spamd-Bar: +
X-Rspamd-Server: web
X-Rspamd-Queue-Id: B52AA231D9
X-Spamd-Result: default: False [1.40 / 15.00];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         FREEMAIL_ENVRCPT(0.00)[gmail.com];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         TAGGED_RCPT(0.00)[dt];
         MIME_GOOD(-0.10)[text/plain];
         DKIM_SIGNED(0.00)[];
         RCPT_COUNT_TWELVE(0.00)[12];
         NEURAL_HAM(-0.00)[-0.625];
         RCVD_COUNT_ZERO(0.00)[0];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         FREEMAIL_CC(0.00)[nxp.com,linuxfoundation.org,kernel.org,vger.kernel.org,suse.com,gmail.com];
         MID_RHS_MATCH_FROM(0.00)[];
         SUSPICIOUS_RECIPS(1.50)[]
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi Andy,

Am 2020-03-25 05:08, schrieb Andy Duan:
> From: Michael Walle <michael@walle.cc> Sent: Wednesday, March 25, 2020 
> 12:35 AM
>> Am 2020-03-24 17:28, schrieb Andy Duan:
>> > From: Michael Walle <michael@walle.cc> Sent: Wednesday, March 25,
>> 2020
>> > 12:18 AM
>> >> Am 2020-03-24 17:12, schrieb Andy Duan:
>> >> > From: Leonard Crestez <leonard.crestez@nxp.com> Sent: Tuesday,
>> >> > March 24, 2020 11:27 PM
>> >> >> On 06.03.2020 23:44, Michael Walle wrote:
>> >> >> > The DMA channel might not be available at probe time. This is esp.
>> >> >> > the case if the DMA controller has an IOMMU mapping.
>> >> >> >
>> >> >> > There is also another caveat. If there is no DMA controller at
>> >> >> > all,
>> >> >> > dma_request_chan() will also return -EPROBE_DEFER. Thus we
>> >> >> > cannot test for -EPROBE_DEFER in probe(). Otherwise the lpuart
>> >> >> > driver will fail to probe if, for example, the DMA driver is not
>> >> >> > enabled in the kernel configuration.
>> >> > If DMA driver is not enabled, we should disable DMA controller node
>> >> > in dts file to match current sw environment, then driver doesn't do
>> >> > defer probe.
>> >> >
>> >> > So I still suggest to check -EPROBE_DEFER for
>> >> > dma_request_slave_channel() in
>> >> > .probe() function.
>> >>
>> >> I don't know if I can follow you here. This would lead to non
>> >> functional setups, eg. one build its own kernel with DMA disabled,
>> >> but still have a device tree with the DMA nodes. And besides, the
>> >> current workaround to request the DMA channel in startup() is
>> >> basically working, isn't it? And once the underlying problem is fixed
>> >> (the infinite EPROBE_DEFER), it could be moved back into _probe().
>> >>
>> >> -michael
>> >
>> > I think the user use wrong dtb file. The dtb file doesn't reflect the
>> > real enabled modules. For such case, there have many problems for
>> > syscon,... that other modules depends on them.
>> 
>> But the user doesn't use the wrong dtb. I don't consider having the 
>> DMA
>> channels in the dtb makes it wrong, just because DMA is not enabled in 
>> the
>> kernel. If you'd follow that argument, then the dtb is also wrong if 
>> there is for
>> example a crypto device, although the kernel doesn't have support for 
>> it
>> enabled.
>> 
>> -michael
> 
> dma_request_chan() is not atomic context.
> Even if move it into .startup(), please move it out of spinlock 
> context.

Agreed. I'll send a respin of my fixes patches later.

-michael

> 
>> 
>> >
>> > So we cannot support wrong usage cases, that is my thought.
>> >
>> > Thanks,
>> > Andy
>> >
>> >>
>> >> >
>> >> > Andy
>> >> >> >
>> >> >> > To workaround this, we request the DMA channel in _startup().
>> >> >> > Other serial drivers do it the same way.
>> >> >> >
>> >> >> > Signed-off-by: Michael Walle <michael@walle.cc>
>> >> >>
>> >> >> This appears to cause boot hangs on imx8qxp-mek (boards boots fine
>> >> >> on
>> >> >> next-20200324 if this patch is reverted)
>> >> >>
>> >> >> > ---
>> >> >> >   drivers/tty/serial/fsl_lpuart.c | 88
>> >> +++++++++++++++++++++------------
>> >> >> >   1 file changed, 57 insertions(+), 31 deletions(-)
>> >> >> >
>> >> >> > diff --git a/drivers/tty/serial/fsl_lpuart.c
>> >> >> > b/drivers/tty/serial/fsl_lpuart.c index
>> >> >> > c31b8f3db6bf..33798df4d727
>> >> >> > 100644
>> >> >> > --- a/drivers/tty/serial/fsl_lpuart.c
>> >> >> > +++ b/drivers/tty/serial/fsl_lpuart.c
>> >> >> > @@ -1493,36 +1493,67 @@ static void rx_dma_timer_init(struct
>> >> >> lpuart_port *sport)
>> >> >> >   static void lpuart_tx_dma_startup(struct lpuart_port *sport)
>> >> >> >   {
>> >> >> >    u32 uartbaud;
>> >> >> > +  int ret;
>> >> >> >
>> >> >> > -  if (sport->dma_tx_chan
>> && !lpuart_dma_tx_request(&sport->port)) {
>> >> >> > -          init_waitqueue_head(&sport->dma_wait);
>> >> >> > -          sport->lpuart_dma_tx_use = true;
>> >> >> > -          if (lpuart_is_32(sport)) {
>> >> >> > -                  uartbaud = lpuart32_read(&sport->port,
>> >> UARTBAUD);
>> >> >> > -                  lpuart32_write(&sport->port,
>> >> >> > -                                 uartbaud |
>> >> UARTBAUD_TDMAE, UARTBAUD);
>> >> >> > -          } else {
>> >> >> > -                  writeb(readb(sport->port.membase +
>> UARTCR5)
>> >> |
>> >> >> > -                          UARTCR5_TDMAS,
>> >> sport->port.membase + UARTCR5);
>> >> >> > -          }
>> >> >> > +  sport->dma_tx_chan = dma_request_chan(sport->port.dev, "tx");
>> >> >> > + if (IS_ERR(sport->dma_tx_chan)) {
>> >> >> > +          dev_info_once(sport->port.dev,
>> >> >> > +                        "DMA tx channel request failed,
>> >> >> > + operating without tx
>> >> >> DMA (%ld)\n",
>> >> >> > +                        PTR_ERR(sport->dma_tx_chan));
>> >> >>
>> >> >> It seems that this since this is called from lpuart32_startup with
>> >> >> &sport->port.lock held and lpuart32_console_write takes the same
>> >> >> lock it can and hang.
>> >> >>
>> >> >> As a workaround I can just remove this print but there are other
>> >> >> possible error conditions in dmaengine code which can cause a printk.
>> >> >>
>> >> >> Maybe the port lock should only be held around register manipulation?
>> >> >>
>> >> >> > +          sport->dma_tx_chan = NULL;
>> >> >> > +          goto err;
>> >> >> > +  }
>> >> >> > +
>> >> >> > +  ret = lpuart_dma_tx_request(&sport->port);
>> >> >> > +  if (!ret)
>> >> >> > +          goto err;
>> >> >>
>> >> >> This is backwards: lpuart_dma_tx_request returns negative errno on
>> >> >> failure.
>> >> >>
>> >> >> > +
>> >> >> > +  init_waitqueue_head(&sport->dma_wait);
>> >> >> > +  sport->lpuart_dma_tx_use = true;  if (lpuart_is_32(sport)) {
>> >> >> > +          uartbaud = lpuart32_read(&sport->port, UARTBAUD);
>> >> >> > +          lpuart32_write(&sport->port,
>> >> >> > +                         uartbaud | UARTBAUD_TDMAE,
>> >> UARTBAUD);
>> >> >> >    } else {
>> >> >> > -          sport->lpuart_dma_tx_use = false;
>> >> >> > +          writeb(readb(sport->port.membase + UARTCR5) |
>> >> >> > +                 UARTCR5_TDMAS, sport->port.membase +
>> >> UARTCR5);
>> >> >> >    }
>> >> >> > +
>> >> >> > +  return;
>> >> >> > +
>> >> >> > +err:
>> >> >> > +  sport->lpuart_dma_tx_use = false;
>> >> >> >   }
>> >> >> >
>> >> >> >   static void lpuart_rx_dma_startup(struct lpuart_port *sport)
>> >> >> >   {
>> >> >> > -  if (sport->dma_rx_chan && !lpuart_start_rx_dma(sport)) {
>> >> >> > -          /* set Rx DMA timeout */
>> >> >> > -          sport->dma_rx_timeout =
>> >> msecs_to_jiffies(DMA_RX_TIMEOUT);
>> >> >> > -          if (!sport->dma_rx_timeout)
>> >> >> > -                  sport->dma_rx_timeout = 1;
>> >> >> > +  int ret;
>> >> >> >
>> >> >> > -          sport->lpuart_dma_rx_use = true;
>> >> >> > -          rx_dma_timer_init(sport);
>> >> >> > -  } else {
>> >> >> > -          sport->lpuart_dma_rx_use = false;
>> >> >> > +  sport->dma_rx_chan = dma_request_chan(sport->port.dev, "rx");
>> >> >> > + if (IS_ERR(sport->dma_rx_chan)) {
>> >> >> > +          dev_info_once(sport->port.dev,
>> >> >> > +                        "DMA rx channel request failed,
>> >> >> > + operating without rx
>> >> >> DMA (%ld)\n",
>> >> >> > +                        PTR_ERR(sport->dma_rx_chan));
>> >> >> > +          sport->dma_rx_chan = NULL;
>> >> >> > +          goto err;
>> >> >> >    }
>> >> >> > +
>> >> >> > +  ret = lpuart_start_rx_dma(sport);  if (ret)
>> >> >> > +          goto err;
>> >> >>
>> >> >> This is not backwards.
>> >> >>
>> >> >> > +
>> >> >> > +  /* set Rx DMA timeout */
>> >> >> > +  sport->dma_rx_timeout = msecs_to_jiffies(DMA_RX_TIMEOUT);
>> if
>> >> >> > + (!sport->dma_rx_timeout)
>> >> >> > +          sport->dma_rx_timeout = 1;
>> >> >> > +
>> >> >> > +  sport->lpuart_dma_rx_use = true;  rx_dma_timer_init(sport);
>> >> >> > +
>> >> >> > +  return;
>> >> >> > +
>> >> >> > +err:
>> >> >> > +  sport->lpuart_dma_rx_use = false;
>> >> >> >   }
>> >> >> >
>> >> >> >   static int lpuart_startup(struct uart_port *port) @@ -1615,6
>> >> >> > +1646,11 @@ static void lpuart_dma_shutdown(struct lpuart_port
>> >> >> > +*sport)
>> >> >> >
>> >> dmaengine_terminate_all(sport->dma_tx_chan);
>> >> >> >            }
>> >> >> >    }
>> >> >> > +
>> >> >> > +  if (sport->dma_tx_chan)
>> >> >> > +          dma_release_channel(sport->dma_tx_chan);
>> >> >> > +  if (sport->dma_rx_chan)
>> >> >> > +          dma_release_channel(sport->dma_rx_chan);
>> >> >> >   }
>> >> >> >
>> >> >> >   static void lpuart_shutdown(struct uart_port *port) @@
>> >> >> > -2520,16
>> >> >> > +2556,6 @@ static int lpuart_probe(struct platform_device *pdev)
>> >> >> >
>> >> >> >    sport->port.rs485_config(&sport->port, &sport->port.rs485);
>> >> >> >
>> >> >> > -  sport->dma_tx_chan =
>> >> >> > dma_request_slave_channel(sport->port.dev,
>> >> >> "tx");
>> >> >> > -  if (!sport->dma_tx_chan)
>> >> >> > -          dev_info(sport->port.dev, "DMA tx channel request
>> failed, "
>> >> >> > -                          "operating without tx DMA\n");
>> >> >> > -
>> >> >> > -  sport->dma_rx_chan =
>> >> >> > dma_request_slave_channel(sport->port.dev,
>> >> >> "rx");
>> >> >> > -  if (!sport->dma_rx_chan)
>> >> >> > -          dev_info(sport->port.dev, "DMA rx channel request
>> failed, "
>> >> >> > -                          "operating without rx DMA\n");
>> >> >> > -
>> >> >> >    return 0;
>> >> >> >
>> >> >> >   failed_attach_port:
>> >> >> >
