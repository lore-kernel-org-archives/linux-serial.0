Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 441DCC63705
	for <linux-serial@archiver.kernel.org>; Wed,  7 Dec 2022 22:05:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230044AbiLGWFe (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 7 Dec 2022 17:05:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiLGWFP (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 7 Dec 2022 17:05:15 -0500
Received: from mail.someserver.de (mail2.someserver.de [31.15.66.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E697685668
        for <linux-serial@vger.kernel.org>; Wed,  7 Dec 2022 14:04:15 -0800 (PST)
Received: from localhost (unknown [213.55.243.226])
        by mail.someserver.de (Postfix) with ESMTPSA id 13CC98016E;
        Wed,  7 Dec 2022 22:56:10 +0100 (CET)
From:   Christina Quast <contact@christina-quast.de>
To:     linux-serial@vger.kernel.org
Cc:     Christina Quast <contact@christina-quast.de>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        "Daniel Beer" <daniel.beer@igorinstitute.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Subject: [PATCH tty-next 0/3] hid-ft260 cleanups
Date:   Wed,  7 Dec 2022 22:55:37 +0100
Message-Id: <20221207215540.114920-1-contact@christina-quast.de>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Cleanups in preparation for the serial driver functionality addition
to hid-ft260.

Thanks for the review to Ilpo Järvinen and Greg Kroah-Hartman.

Christina Quast (3):
  hid-ft260: Cleanup macro formatting
  hid-ft260: Rename struct ft260_i2c_input_report
  hid-ft260: Change u8 to __u8 for hw facing structs

 drivers/hid/hid-ft260.c | 101 ++++++++++++++++++++--------------------
 1 file changed, 51 insertions(+), 50 deletions(-)

-- 
2.35.1

