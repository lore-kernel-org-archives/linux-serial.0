Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65DACC43219
	for <linux-serial@archiver.kernel.org>; Fri, 15 Oct 2021 11:14:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 504346115C
	for <linux-serial@archiver.kernel.org>; Fri, 15 Oct 2021 11:14:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238376AbhJOLQv (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 15 Oct 2021 07:16:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:39946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238324AbhJOLQu (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 15 Oct 2021 07:16:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5B40261151;
        Fri, 15 Oct 2021 11:14:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634296484;
        bh=4RvH6OfV0u1jrHwKt/IorhlNNVZBTsy0WDqkrvEA2m8=;
        h=From:To:Cc:Subject:Date:From;
        b=HOXV8lRmTmRtYc7bGfLIC61OzrXx3OXIDQpC3nRL/AVN7sVqAeBHgW/0uW2PB4D3+
         nxbZiCxU8yn6+b1wttgnNpdd6LhWckLEE7TscfpTBx5efdrJCneYSnNi9/B+Qcasl5
         Qg5gIeZaJ+/v54ealJ/gWoJJf9fypsodZnwIaG846palekH3vaNLkrf/ciwtq3Kriz
         RfaFgQ5A/cGVjHbFXhJQfVR56DvnujvF/Z3wTlTr/2zVy58neHvXqx3dxNhPOvFcAw
         lBG1Jw8iYCWwx7VwYIDcXKDM1mOaevqVcCHU0NguIEdy68qOkyFyai4lJVTaUNQwTR
         5f1ie8cR3Yrgw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1mbLAb-0000HS-8E; Fri, 15 Oct 2021 13:14:38 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH 0/3] serial: 8250: fix racy uartclk update
Date:   Fri, 15 Oct 2021 13:14:19 +0200
Message-Id: <20211015111422.1027-1-johan@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Here's a fix for the asynchronous uartclk-update hack which was added
last year and a couple of related clean ups.

Johan


Johan Hovold (3):
  serial: 8250: fix racy uartclk update
  serial: 8250: rename unlock labels
  serial: 8250_dw: drop bogus uartclk optimisation

 drivers/tty/serial/8250/8250_dw.c   | 11 ++++------
 drivers/tty/serial/8250/8250_port.c | 31 ++++++++++++++++++++---------
 2 files changed, 26 insertions(+), 16 deletions(-)

-- 
2.32.0

