Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46E4DC433F5
	for <linux-serial@archiver.kernel.org>; Wed, 16 Mar 2022 14:37:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236256AbiCPOin (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 16 Mar 2022 10:38:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232943AbiCPOim (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 16 Mar 2022 10:38:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9F5A752E29
        for <linux-serial@vger.kernel.org>; Wed, 16 Mar 2022 07:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647441447;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=tHEFNI4QFddUzu0LQQmFlfD1SkQZMssJQZsRu1wTjdk=;
        b=FEYlno1SV0zVdt0kuBbxwRaV2mnouB2PZOfE4SJ9zgv4pkY8+nmf4ivq0KuW9kbklb8zPb
        Msr94pG0CmjF1NrUHieg1yfoEevKo09E+X90+o2ExuVk4nhdZq+3Dbiz/WTnah2Lq0bHml
        5sgYlfo2gfdzImG7ALnVYGENZ5KjKtQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-81-7Mew6Dc-N5mvjWn8E9OFhQ-1; Wed, 16 Mar 2022 10:37:26 -0400
X-MC-Unique: 7Mew6Dc-N5mvjWn8E9OFhQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4CA958D3765;
        Wed, 16 Mar 2022 14:37:24 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.19.38])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AAA9940F9D53;
        Wed, 16 Mar 2022 14:37:20 +0000 (UTC)
From:   Wander Lairson Costa <wander@redhat.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Johan Hovold <johan@kernel.org>,
        Wander Lairson Costa <wander@redhat.com>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        linux-serial@vger.kernel.org (open list:SERIAL DRIVERS),
        linux-kernel@vger.kernel.org (open list)
Cc:     rostedt@goodmis.org, senozhatsky@chromium.org,
        andre.goddard@gmail.com, sudipm.mukherjee@gmail.com,
        andy.shevchenko@gmail.com, David.Laight@aculab.com,
        jonathanh@nvidia.com, phil@raspberrypi.com
Subject: [PATCH v4 0/5] tty/8250: Use fifo in 8250 console driver
Date:   Wed, 16 Mar 2022 11:36:39 -0300
Message-Id: <20220316143646.13301-1-wander@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

This version fixes the bugs reported in version v3. The first patch
is the same patch of v3 as is. The following commits fix the issues in the
original patch. For details, please check the commit log of each patch.

I tested these patches in the following systems:

* IBM X3550 M3
* HP ProLiant DL380 Gen9
* HP ProLiant BL480c G1
* Dell PowerEdge R910
* Cisco UCSC-C220-M3S

I cc everybody that reported problems with the previous version of this
patch so they can retest and confirm their systems work flawlessly.

Wander Lairson Costa (5):
  serial/8250: Use fifo in 8250 console driver
  serial/8250: Use the cache value of the FCR register
  serial/8250: Use tx_loadsz as the transmitter fifo size
  serial/8250: exclude BCM283x from console_fifo_write
  serial/8250: Only use fifo after the port is initialized in
    console_write

 drivers/tty/serial/8250/8250_port.c | 67 ++++++++++++++++++++++++++---
 1 file changed, 61 insertions(+), 6 deletions(-)

-- 
2.35.1

