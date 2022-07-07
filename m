Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CB7EC43334
	for <linux-serial@archiver.kernel.org>; Thu,  7 Jul 2022 14:55:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235989AbiGGOzd (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 7 Jul 2022 10:55:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235871AbiGGOzM (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 7 Jul 2022 10:55:12 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1A1F57230
        for <linux-serial@vger.kernel.org>; Thu,  7 Jul 2022 07:54:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id AC2C1CE255B
        for <linux-serial@vger.kernel.org>; Thu,  7 Jul 2022 14:54:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E7D7C341CB;
        Thu,  7 Jul 2022 14:53:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657205639;
        bh=6MGDe1yofsd6v2ZmRcpFsZQHUeGgVMjNyAU6tR4zeMU=;
        h=From:To:Cc:Subject:Date:From;
        b=pOUEWdLL4qJgjZNmj3AdiNENMhKftt79Wtr2AKfOePp3eApy+4Bti3OdNWGWamd4E
         T3TwLiZSZbUGgZd9jvd5JmPWlK/YfrawxEOhsLxqt1szOhcnKlCaTKIp87mv+Mr1fu
         gim1xaYnEa5aoanq2JxvLiHKfMUMz7NWvkjMWezJakwm8IxFKluwQh1m33tbDS2po7
         c8Gx8z0agDtkq+2OzeYsz/KZw7ryTkIMzyLrz0K3axbg49X8Tj35hzQfvCBfEB1mTX
         QrzXgAT1zgGt4kQEknPb7iZgqkki8H1TWU8DbfltwMwNLW8vw+ZIAj53iWdvme4Jy0
         2bNjwa+F0CvRA==
From:   =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To:     linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH 0/7] ftdi_sio driver improvements
Date:   Thu,  7 Jul 2022 16:53:47 +0200
Message-Id: <20220707145354.29705-1-kabel@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hello Greg,

Pali has worked out some improvements for the ftdi_sio USB serial
driver and I have tested them.

Marek

Pali Rohár (7):
  USB: serial: ftdi_sio: Fix divisor overflow
  USB: serial: ftdi_sio: Add missing baudrate validation
  USB: serial: ftdi_sio: Extract SIO divisor code to function
  USB: serial: ftdi_sio: Do not reset baudrate to 9600 on error
  USB: serial: ftdi_sio: Fix baudrate rounding for ASYNC_SPD_CUST
  USB: serial: ftdi_sio: Fix custom_divisor and c_*speed for
    ASYNC_SPD_CUST
  USB: serial: ftdi_sio: Fill c_*speed fields with real baudrate

 drivers/usb/serial/ftdi_sio.c | 181 ++++++++++++++++++++++++++++------
 1 file changed, 151 insertions(+), 30 deletions(-)

-- 
2.35.1

