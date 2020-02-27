Return-Path: <SRS0=sDBB=4P=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AED73C4BA06
	for <linux-serial@archiver.kernel.org>; Thu, 27 Feb 2020 07:53:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F78E2072D
	for <linux-serial@archiver.kernel.org>; Thu, 27 Feb 2020 07:53:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728389AbgB0HxK (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 27 Feb 2020 02:53:10 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:55331 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726999AbgB0HxK (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 27 Feb 2020 02:53:10 -0500
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1j7Dym-0002LK-F1; Thu, 27 Feb 2020 08:53:08 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1j7Dyl-0004H9-0a; Thu, 27 Feb 2020 08:53:07 +0100
Date:   Thu, 27 Feb 2020 08:53:06 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     George Hilliard <ghilliard@kopismobile.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        NXP Linux Team <linux-imx@nxp.com>, kernel@pengutronix.de
Subject: Re: [PATCH v4 2/2] tty: imx serial: Implement support for reversing
 TX and RX polarity
Message-ID: <20200227075306.jkxqeuoculdlirza@pengutronix.de>
References: <20200226222319.18383-1-ghilliard@kopismobile.com>
 <20200226222319.18383-3-ghilliard@kopismobile.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200226222319.18383-3-ghilliard@kopismobile.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-serial@vger.kernel.org
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Feb 26, 2020 at 04:23:19PM -0600, George Hilliard wrote:
> The peripheral has support for inverting its input and/or output
> signals.  This is useful if the hardware flips polarity of the
> peripheral's signal, such as swapped +/- pins on an RS-422 transceiver,
> or an inverting level shifter.  Add support for these control registers
> via the device tree binding.
> 
> As part of this change, make the writes of the various registers more
> uniform by moving the UCR3 block up near the other registers' blocks,
> since the INVT bit must be set before enabling the peripheral.
> 
> Signed-off-by: George Hilliard <ghilliard@kopismobile.com>

LGTM,

Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Thanks
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
