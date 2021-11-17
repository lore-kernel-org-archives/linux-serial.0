Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5283FC433F5
	for <linux-serial@archiver.kernel.org>; Wed, 17 Nov 2021 10:05:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3263861BF4
	for <linux-serial@archiver.kernel.org>; Wed, 17 Nov 2021 10:05:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235972AbhKQKIn (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 17 Nov 2021 05:08:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:55196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233117AbhKQKIk (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 17 Nov 2021 05:08:40 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0380161544;
        Wed, 17 Nov 2021 10:05:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637143542;
        bh=WtEqVvnF6PYsfAPJLjI1r45NxQMfJMCjFvcdXXCzEgY=;
        h=From:To:Cc:Subject:Date:From;
        b=jipiOISPKxlz0WYAJnCrrQZUs/BpEjnctloVN9vemAxQB6jgCRCozGhLZ0PKB6kJT
         2G50jnzON4dtEvJWd/pJAuB+8xO2L11h/wngdC1gcWsR5Gl3hUZIYDoa+x9s5JZJal
         DdLpFWeOG56+pBULA4BTXV6JG6/VQL18ErpYTJ7Nsp7woYIneF4la1yuugfn6PQ02a
         pxFE+ztOa8nAUdxjsJHs/Ysx2o59UbWV3d77pH73rCmwJb+J7yALihUjBbPcInd/ak
         3orZVPYYyyZogwJPJuvP+5zld9Zw5eCkvLFDBwj98zW0nlYd7mh7JX8S8mK4wLX1sb
         Y0W4xHQjraELQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1mnHoi-0001KS-HR; Wed, 17 Nov 2021 11:05:24 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Ilia Sergachev <silia@ethz.ch>,
        Karol Gugala <kgugala@antmicro.com>,
        Mateusz Holenko <mholenko@antmicro.com>,
        Stafford Horne <shorne@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH v2 0/3] serial: liteuart: fix driver unbind
Date:   Wed, 17 Nov 2021 11:05:09 +0100
Message-Id: <20211117100512.5058-1-johan@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Ilia Sergachev noted that the liteuart remove() function would trigger a
NULL-pointer dereference if it was ever called since the driver data
pointer was never initialised.

Turns out there are more bugs in this part of the driver which clearly
has never been tested.

Also relax the Kconfig dependencies so that the driver can be
compile-tested without first enabling a seemingly unrelated SoC
controller driver.

Note that this series depends on the fix by Ilia:

        https://lore.kernel.org/r/20211115031808.7ab632ef@dtkw

Johan


Changes in v2
 - allow compile testing without CONFIG_OF (Andy)
 - reword commit message to clarify that LITEX is neither a build or
   runtime dependency and that the change only makes it easier to
   compile test the driver
 - move the Kconfig patch last in the series
 - add Stafford's reviewed by tags to the two unmodified patches


Johan Hovold (3):
  serial: liteuart: fix use-after-free and memleak on unbind
  serial: liteuart: fix minor-number leak on probe errors
  serial: liteuart: relax compile-test dependencies

 drivers/tty/serial/Kconfig    |  2 +-
 drivers/tty/serial/liteuart.c | 18 +++++++++++++++---
 2 files changed, 16 insertions(+), 4 deletions(-)

-- 
2.32.0

