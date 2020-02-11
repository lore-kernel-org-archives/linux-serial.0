Return-Path: <SRS0=2Nu8=37=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 945D1C352A3
	for <linux-serial@archiver.kernel.org>; Tue, 11 Feb 2020 07:38:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7868E206D7
	for <linux-serial@archiver.kernel.org>; Tue, 11 Feb 2020 07:38:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727561AbgBKHik (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 11 Feb 2020 02:38:40 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:37213 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727056AbgBKHij (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 11 Feb 2020 02:38:39 -0500
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1j1Q7v-00074b-2a; Tue, 11 Feb 2020 08:38:35 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1j1Q7u-0004Zn-42; Tue, 11 Feb 2020 08:38:34 +0100
Date:   Tue, 11 Feb 2020 08:38:34 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     George Hilliard <ghilliard@kopismobile.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kernel@pengutronix.de, devicetree@vger.kernel.org,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-serial@vger.kernel.org
Subject: Re: [PATCH v2 2/2] tty: imx serial: Implement support for reversing
 TX and RX polarity
Message-ID: <20200211073834.ndtusa7vvmvsydz4@pengutronix.de>
References: <20200210192949.7338-1-ghilliard@kopismobile.com>
 <20200210192949.7338-3-ghilliard@kopismobile.com>
 <20200210205003.x7xduj3avwjhimjm@pengutronix.de>
 <CALM8J=dZjK9C+-yMOC_DKp+6m2MaKJsNXaz_+enDVtkgj32U+A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALM8J=dZjK9C+-yMOC_DKp+6m2MaKJsNXaz_+enDVtkgj32U+A@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-serial@vger.kernel.org
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hello George,

On Mon, Feb 10, 2020 at 05:03:14PM -0600, George Hilliard wrote:
> On Mon, Feb 10, 2020 at 2:50 PM Uwe Kleine-König
> <u.kleine-koenig@pengutronix.de> wrote:
> > On Mon, Feb 10, 2020 at 01:29:49PM -0600, George Hilliard wrote:
> > > @@ -1390,6 +1392,8 @@ static int imx_uart_startup(struct uart_port *port)
> > >       ucr4 = imx_uart_readl(sport, UCR4) & ~UCR4_OREN;
> > >       if (!sport->dma_is_enabled)
> > >               ucr4 |= UCR4_OREN;
> > > +     if (sport->inverted_rx)
> > > +             ucr4 |= UCR4_INVR;
> >
> > You fail to clear this bit if .inverted_rx is false.
> 
> I believe this is taken care of by the SRST asserted slightly above
> this - UCR* is reset by this.

The i.MX6 manual states: Reset the transmit and receive state machines,
all FIFOs and register USR1, USR2, UBIR, UBMR, UBRC, URXD, UTXD and
UTS[6-3]. UCR* isn't mentioned here. So please at least confirm your
belief experimentally.

> I see that this reset is also done in the imx_uart_flush_buffer()
> implementation, but as I understand it, this is a cleanup method that
> doesn't reconfigure much of the peripheral.

The comment there even has the above list of registers. If the
experiment I suggested above should confirm your believe IMHO this
function needs fixing anyhow.
 
Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
