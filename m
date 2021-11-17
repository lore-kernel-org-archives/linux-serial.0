Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9067C433EF
	for <linux-serial@archiver.kernel.org>; Wed, 17 Nov 2021 10:05:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9EF5C60EBD
	for <linux-serial@archiver.kernel.org>; Wed, 17 Nov 2021 10:05:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236044AbhKQKIo (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 17 Nov 2021 05:08:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:55232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236057AbhKQKIk (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 17 Nov 2021 05:08:40 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1353C61AED;
        Wed, 17 Nov 2021 10:05:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637143542;
        bh=q+JjnaZW4YhiIxjh69UWx1tFsJdMHJxlhuR/u0OyNqE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NQ9TzlhGqpwZ/AVvZrrRbslrKmzuMBzBeUJgFzDfXtpLVr3jB2DARc5OOpmMFj7pK
         FjGG1njwiiboZXTwA3EyCAjGKM6tqWTi71z+MT7tr40Ajei7hFXgHXf4WDZ1yYTdiA
         VKCem4jxfm+CDU7iNHZYSQ74RghSgtu2hITy4MIMfnaP79bb7FHmAQCnJokR/iCOpN
         fo55L/qXttJjzWjtOdueb2QxbAPFqMDgGjLwTNOJUOgEM2fEgGrQoMd+Tub8MUeb3T
         Bj1oGlD/JDO58R2byPaOOJ2y+gGCuzhUUG8s2sYTqsbF7kBr3inmm3qpaQdm2R7kZC
         jAYwNgx8T50Ig==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1mnHoi-0001KY-QH; Wed, 17 Nov 2021 11:05:24 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Ilia Sergachev <silia@ethz.ch>,
        Karol Gugala <kgugala@antmicro.com>,
        Mateusz Holenko <mholenko@antmicro.com>,
        Stafford Horne <shorne@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH v2 3/3] serial: liteuart: relax compile-test dependencies
Date:   Wed, 17 Nov 2021 11:05:12 +0100
Message-Id: <20211117100512.5058-4-johan@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211117100512.5058-1-johan@kernel.org>
References: <20211117100512.5058-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The LITEX symbol is neither a build or runtime dependency for the
liteuart serial driver.

LITEX is selected by the "LiteX SoC Controller" driver, which does a
probe-time register-access sanity check and panics if the SoC has not
been configured correctly. That driver's Kconfig entry asserts that any
LiteX driver using the LiteX register accessors should depend on LITEX,
but currently only the serial driver complies.

Relax this LITEX "dependency" in order to make it easier to compile test
the driver.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/tty/serial/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 6ff94cfcd9db..fc543ac97c13 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -1533,7 +1533,7 @@ config SERIAL_LITEUART
 	tristate "LiteUART serial port support"
 	depends on HAS_IOMEM
 	depends on OF || COMPILE_TEST
-	depends on LITEX
+	depends on LITEX || COMPILE_TEST
 	select SERIAL_CORE
 	help
 	  This driver is for the FPGA-based LiteUART serial controller from LiteX
-- 
2.32.0

