Return-Path: <SRS0=2Nu8=37=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1683FC352A3
	for <linux-serial@archiver.kernel.org>; Tue, 11 Feb 2020 07:31:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAAD5206DB
	for <linux-serial@archiver.kernel.org>; Tue, 11 Feb 2020 07:31:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726170AbgBKHbZ (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 11 Feb 2020 02:31:25 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:59113 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbgBKHbZ (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 11 Feb 2020 02:31:25 -0500
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1j1Q0x-0006VJ-E6; Tue, 11 Feb 2020 08:31:23 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1j1Q0u-0004Nt-AL; Tue, 11 Feb 2020 08:31:20 +0100
Date:   Tue, 11 Feb 2020 08:31:20 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     fugang.duan@nxp.com
Cc:     gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
        jslaby@suse.com, kernel@pengutronix.de, festevam@gmail.com,
        Dirk Behme <dirk.behme@de.bosch.com>,
        Aaron Brice <aaron.brice@datasoft.com>,
        Stefan Agner <stefan@agner.ch>,
        Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>
Subject: Re: [PATCH tty/serial 1/1] tty: serial: imx: setup the correct sg
 entry for tx dma
Message-ID: <20200211073120.uywotjqfeljbc3rx@pengutronix.de>
References: <1581401761-6378-1-git-send-email-fugang.duan@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1581401761-6378-1-git-send-email-fugang.duan@nxp.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-serial@vger.kernel.org
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hello,

On Tue, Feb 11, 2020 at 02:16:01PM +0800, fugang.duan@nxp.com wrote:
> From: Fugang Duan <fugang.duan@nxp.com>
> 
> There has oops as below happen on i.MX8MP EVK platform that has
> 6G bytes DDR memory.
> 
> when (xmit->tail < xmit->head) && (xmit->head == 0),
> it setups one sg entry with sg->length is zero:
> 	sg_set_buf(sgl + 1, xmit->buf, xmit->head);
> 
> if xmit->buf is allocated from >4G address space, and SDMA only
> support <4G address space, then dma_map_sg() will call swiotlb_map()
> to do bounce buffer copying and mapping.
> 
> But swiotlb_map() don't allow sg entry's length is zero, otherwise
> report BUG_ON().
> 
> So the patch is to correct the tx DMA scatter list.
> 
> Oops:
> [...]

It's a bit sad this wasn't catched earlier. The fsl_lpuart driver got
this exact fix in 2016 (d704b2d32c39c256dea659e142a31b875a13c63b) and
obviously nobody looked left or right to check for other drivers being
affected. :-|

> Reported-by: Eagle Zhou <eagle.zhou@nxp.com>
> Tested-by: Eagle Zhou <eagle.zhou@nxp.com>
> Signed-off-by: Fugang Duan <fugang.duan@nxp.com>

Fixes: 7942f8577f2a ("serial: imx: TX DMA: clean up sg initialization")

(Also here nobody looked in detail: The commit log is obviously wrong as
the if condition isn't just inverted.)

Reviewed-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
