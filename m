Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E3C9C4167B
	for <linux-serial@archiver.kernel.org>; Sat,  4 Nov 2023 13:26:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232180AbjKDN0C (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 4 Nov 2023 09:26:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230151AbjKDN0B (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 4 Nov 2023 09:26:01 -0400
Received: from connect.vanmierlo.com (fieber.vanmierlo.com [84.243.197.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FBACE3;
        Sat,  4 Nov 2023 06:25:55 -0700 (PDT)
X-Footer: dmFubWllcmxvLmNvbQ==
Received: from roundcube.vanmierlo.com ([192.168.37.37])
        (authenticated user m.brock@vanmierlo.com)
        by connect.vanmierlo.com (Kerio Connect 10.0.2 patch 1) with ESMTPA;
        Sat, 4 Nov 2023 14:25:51 +0100
MIME-Version: 1.0
Date:   Sat, 04 Nov 2023 14:25:51 +0100
From:   m.brock@vanmierlo.com
To:     Florian Eckert <fe@dev.tdt.de>
Cc:     Eckert.Florian@googlemail.com, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, pavel@ucw.cz, lee@kernel.org,
        kabel@kernel.org, u.kleine-koenig@pengutronix.de,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-leds@vger.kernel.org
Subject: Re: [Patch v6 3/7] leds: ledtrig-tty: free allocated ttyname buffer
 on deactivate
In-Reply-To: <20231030100447.63477-4-fe@dev.tdt.de>
References: <20231030100447.63477-1-fe@dev.tdt.de>
 <20231030100447.63477-4-fe@dev.tdt.de>
Message-ID: <6be2d8101fb8da3455974ead01721e7e@vanmierlo.com>
X-Sender: m.brock@vanmierlo.com
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Florian Eckert wrote on 2023-10-30 11:04:
> The ttyname buffer for the ledtrig_tty_data struct is allocated in the
> sysfs ttyname_store() function. This buffer must be released on trigger
> deactivation. This was missing and is thus a memory leak.

Shouldn´t there be a Fixes tag here?

And as a side note: you have patches 1..7/7 and a cover letter 0/8 ?

Maarten

