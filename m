Return-Path: <SRS0=Fd+J=DW=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0983C43457
	for <linux-serial@archiver.kernel.org>; Thu, 15 Oct 2020 22:33:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98E1D20776
	for <linux-serial@archiver.kernel.org>; Thu, 15 Oct 2020 22:33:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731193AbgJOWdJ (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 15 Oct 2020 18:33:09 -0400
Received: from mga17.intel.com ([192.55.52.151]:50389 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730352AbgJOWdJ (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 15 Oct 2020 18:33:09 -0400
IronPort-SDR: ukFtMdvhaGvea59Lw4LcnrcjBipHoCY8T2BMi7LakdHaqA04cjkq2OcGsx98fcO5PHdKWGudSC
 BgzXwhUCW8Uw==
X-IronPort-AV: E=McAfee;i="6000,8403,9775"; a="146327629"
X-IronPort-AV: E=Sophos;i="5.77,380,1596524400"; 
   d="scan'208";a="146327629"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2020 15:33:08 -0700
IronPort-SDR: jV+GInFu3HUKxAHj+n0syZqRxNl2VkMilsYqxBc4ldyL1YTp8hgjOoWMmk8tlgJQLWgsc7vmDz
 yx006Sl5k6bQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,380,1596524400"; 
   d="scan'208";a="531437319"
Received: from lkp-server01.sh.intel.com (HELO 5003fa193bf3) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 15 Oct 2020 15:33:05 -0700
Received: from kbuild by 5003fa193bf3 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kTBo0-00008C-Sg; Thu, 15 Oct 2020 22:33:04 +0000
Date:   Fri, 16 Oct 2020 06:32:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     kbuild-all@lists.01.org, Johan Hovold <johan@kernel.org>,
        linux-leds@vger.kernel.org, linux-serial@vger.kernel.org,
        kernel@pengutronix.de, linux-kernel@vger.kernel.org
Subject: [RFC PATCH] leds: trigger: ledtrig_tty can be static
Message-ID: <20201015223203.GA33862@68c68aa7e201>
References: <20201012123358.1475928-4-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201012123358.1475928-4-u.kleine-koenig@pengutronix.de>
X-Patchwork-Hint: ignore
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org


Signed-off-by: kernel test robot <lkp@intel.com>
---
 ledtrig-tty.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/leds/trigger/ledtrig-tty.c b/drivers/leds/trigger/ledtrig-tty.c
index 806548e33cd874..09cba818fb65c7 100644
--- a/drivers/leds/trigger/ledtrig-tty.c
+++ b/drivers/leds/trigger/ledtrig-tty.c
@@ -174,7 +174,7 @@ static void ledtrig_tty_deactivate(struct led_classdev *led_cdev)
 	kfree(trigger_data);
 }
 
-struct led_trigger ledtrig_tty = {
+static struct led_trigger ledtrig_tty = {
 	.name = "tty",
 	.activate = ledtrig_tty_activate,
 	.deactivate = ledtrig_tty_deactivate,
