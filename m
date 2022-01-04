Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4F6EC433F5
	for <linux-serial@archiver.kernel.org>; Tue,  4 Jan 2022 10:54:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbiADKyx (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 4 Jan 2022 05:54:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbiADKyx (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 4 Jan 2022 05:54:53 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06485C061761
        for <linux-serial@vger.kernel.org>; Tue,  4 Jan 2022 02:54:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BFF01B811A1
        for <linux-serial@vger.kernel.org>; Tue,  4 Jan 2022 10:54:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA954C36AE9;
        Tue,  4 Jan 2022 10:54:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1641293690;
        bh=BjVnEWxy74+YYL80SSdTgbxIeEC8l0tv+XWpbEnDhFo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=y1UIiZFxBigfrqlIhRYyDXAerUH49AWCSazO3s9F98xos1qjzJWqparil5I2FAl0V
         OIPk6asucdN5ZtcXyiyjUUdHV4eavR8ITiY5xwBPKYn35zxJL2jdRRELszg6eWDf8d
         zKWl//NmqO1DNkycx8Kix2TAF2b++jDXDOc7XaIg=
Date:   Tue, 4 Jan 2022 11:54:47 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Tomasz =?utf-8?Q?Mo=C5=84?= <tomasz.mon@camlingroup.com>
Cc:     linux-serial@vger.kernel.org, Jiri Slaby <jirislaby@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        k.drobinski@camlintechnologies.com
Subject: Re: [PATCH] serial: imx: reduce RX interrupt frequency
Message-ID: <YdQndwYc9xaauvpS@kroah.com>
References: <20220104103203.2033673-1-tomasz.mon@camlingroup.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220104103203.2033673-1-tomasz.mon@camlingroup.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Jan 04, 2022 at 11:32:03AM +0100, Tomasz Moń wrote:
> Triggering RX interrupt for every byte defeats the purpose of aging
> timer and leads to interrupt starvation at high baud rates.
> 
> Increase receiver trigger level to 8 to increase the minimum period
> between RX interrupts to 8 characters time. The tradeoff is increased
> latency. In the worst case scenario, where RX data has intercharacter
> delay slightly less than aging timer (8 characters time), it can take
> up to 63 characters time for the interrupt to be raised since the
> reception of the first character.

Why can't you do this dynamically based on the baud rate so as to always
work properly for all speeds without increased delays for slower ones?

thanks,

greg k-h
