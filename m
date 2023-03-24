Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6B27C6FD20
	for <linux-serial@archiver.kernel.org>; Fri, 24 Mar 2023 13:07:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbjCXNHF (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 24 Mar 2023 09:07:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjCXNHD (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 24 Mar 2023 09:07:03 -0400
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 150172213F
        for <linux-serial@vger.kernel.org>; Fri, 24 Mar 2023 06:07:03 -0700 (PDT)
Received: from francesco-nb.int.toradex.com (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
        by mail11.truemail.it (Postfix) with ESMTPA id 0D1832065E;
        Fri, 24 Mar 2023 14:07:01 +0100 (CET)
Date:   Fri, 24 Mar 2023 14:06:55 +0100
From:   Francesco Dolcini <francesco@dolcini.it>
To:     Stefan Wahren <stefan.wahren@i2se.com>
Cc:     Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Francesco Dolcini <francesco@dolcini.it>,
        Tomasz =?utf-8?Q?Mo=C5=84?= <tomasz.mon@camlingroup.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Sergey Organov <sorganov@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-serial <linux-serial@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Stefan Wahren <stefan.wahren@chargebyte.com>
Subject: Re: Regression: serial: imx: overrun errors on debug UART
Message-ID: <ZB2gbwwJ0/3Fvrlg@francesco-nb.int.toradex.com>
References: <2c29454b-9369-4360-8eb4-c151f59460cb@i2se.com>
 <d660e3cf-5686-d989-3b59-efe83ec9d590@linux.intel.com>
 <ZB2W4bKfuO7tvAaU@francesco-nb.int.toradex.com>
 <989d6a6f-fd4d-3e53-d417-ddf71ccf7af@linux.intel.com>
 <b6090d0f-c612-9916-06cf-8d791801e37d@i2se.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b6090d0f-c612-9916-06cf-8d791801e37d@i2se.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Mar 24, 2023 at 01:49:56PM +0100, Stefan Wahren wrote:
> Am 24.03.23 um 13:35 schrieb Ilpo Järvinen:
> > On Fri, 24 Mar 2023, Francesco Dolcini wrote:
> > > On Fri, Mar 24, 2023 at 01:47:59PM +0200, Ilpo Järvinen wrote:
> > > > On Fri, 24 Mar 2023, Stefan Wahren wrote:
> > > > > after switching to Linux 6.1.21 on our Tarragon board (i.MX6ULL SoC), we
> > > > > experience the following issues with the debug UART (115200 baud, 8N1, no
> > > > > hardware flow control):
> > > > > 
> > > > > - overrun errors if we paste in multiple text lines while system is idle
> > > > > - no reaction to single key strokes while system is on higher load
> > > > > 
> > > > > After reverting 7a637784d517 ("serial: imx: reduce RX interrupt frequency")
> > > > > the issue disappear.
> > > > > 
> > > > > Maybe it's worth to mention that the Tarragon board uses two additional
> > > > > application UARTs with similiar baud rates (9600 - 115200 baud, no hardware
> > > > > flow control) for RS485 communication, but there are no overrun errors (with
> > > > > and without the mention change).
> > > > This has come up earlier, see e.g.:
> > > > 
> > > > https://lore.kernel.org/linux-serial/20221003110850.GA28338@francesco-nb.int.toradex.com/
> > > yep, it looks exactly the same issue.
> > > 
> > > We did not verify if this was affecting other UARTs. However, isn't RS485
> > > half-duplex?
> > While half-duplex is more likely by far due simplicity, RS485 could also
> > be full-duplex. It seems imx driver supports for both modes.
> 
> The RS485 on Tarragon is half-duplex, but this is implemented in external
> hardware. So from Linux / driver point of view it's a RS232.

To me this is an interesting difference that might be worth
investigating. The console is somehow special since you are going to
echo out the received chars most of the times.

Francesco

