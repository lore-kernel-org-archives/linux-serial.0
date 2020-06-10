Return-Path: <SRS0=uqjK=7X=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24FA6C433DF
	for <linux-serial@archiver.kernel.org>; Wed, 10 Jun 2020 15:53:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F298B206F4
	for <linux-serial@archiver.kernel.org>; Wed, 10 Jun 2020 15:53:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591804417;
	bh=zxOntiEnO8geBqba/Y+eG4q1ysZ2OktpSI6E2C+s2Go=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=Uykojd0qsJun0QXcKFF2XMTDq96v409WU/TDWAC3ZKD+wdaFMxz78F3+6XcTHEDoD
	 DXy4mZC1Q7t5rJEvOT/B7fWEce/mLoBiVbr58IRgnZO07q+1jOwqSBpmCotNspZXwR
	 HgAZqLQt3wk78wCYQX9SX3KzkOW5A5cLTtw75MwM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728435AbgFJPxg (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 10 Jun 2020 11:53:36 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:41320 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728217AbgFJPxg (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 10 Jun 2020 11:53:36 -0400
Received: by mail-lf1-f68.google.com with SMTP id u16so1740964lfl.8;
        Wed, 10 Jun 2020 08:53:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kHTC5ynMjdYXbR8GWvcYvNg5klsAd9eXqBm+XxUO58o=;
        b=TmPN7DC1dCNBT1Bx5vRreyA17eIi7H1dvaVlUpiC/9zVv/d6rGjr4PhfOkxQl85oYi
         CzhDBw/qNqL+PvkC7rEinHOFiCTX64tkR7ef+H/DI/JKkiPKJXRzzKGDUTKYjyedMm6+
         gemLvezQpZ7GEG0ciTV7glTZPOW6XEUm+YIgCwID0tt4vHRWebfeoDFxaODXQg2513GL
         LlqrqBrpi6ylbWijF4Qz+buTEjDXiuI+NaJNWQl0UYUm7H50lG2hnQxYuwjDXPQEKkO3
         hKN6UbUSe+VaE9VOeAi5LswHxBNAHVFPTlV8IzodZqUKk0IiEajVm1ZoTpecBEV0Yr2V
         cGdQ==
X-Gm-Message-State: AOAM532VZMA+epqeAocprmptsy9g7CFy4R+kMshDLOSu/Uj8jZNCgT/+
        SS/oYlvN+qRYaYEcjqi5zWE=
X-Google-Smtp-Source: ABdhPJyqqx/BcJVIiBXYDw9G8HwixEOGKHpBACr+n1wBRH3ucsEekHe/2Ki7AqirrHY6cGrLrC4OEg==
X-Received: by 2002:a05:6512:d1:: with SMTP id c17mr2068358lfp.80.1591804413811;
        Wed, 10 Jun 2020 08:53:33 -0700 (PDT)
Received: from xi.terra (c-beaee455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.174.190])
        by smtp.gmail.com with ESMTPSA id x69sm20823lff.19.2020.06.10.08.53.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2020 08:53:33 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.93.0.4)
        (envelope-from <johan@xi.terra>)
        id 1jj32f-0003fz-W3; Wed, 10 Jun 2020 17:53:30 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jslaby@suse.com>, Lukas Wunner <lukas@wunner.de>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH] serial: core: drop unnecessary gpio include
Date:   Wed, 10 Jun 2020 17:51:21 +0200
Message-Id: <20200610155121.14014-1-johan@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Drop the recently added gpio include from the serial-core header in
favour of a forward declaration and instead include the gpio header only
where needed.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/tty/serial/8250/8250_port.c | 1 +
 drivers/tty/serial/serial_core.c    | 1 +
 include/linux/serial_core.h         | 2 +-
 3 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 1632f7d25acc..d64ca77d9cfa 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -16,6 +16,7 @@
 #include <linux/ioport.h>
 #include <linux/init.h>
 #include <linux/console.h>
+#include <linux/gpio/consumer.h>
 #include <linux/sysrq.h>
 #include <linux/delay.h>
 #include <linux/platform_device.h>
diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 3706f31b0c37..cba19f7d9ea3 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -14,6 +14,7 @@
 #include <linux/sched/signal.h>
 #include <linux/init.h>
 #include <linux/console.h>
+#include <linux/gpio/consumer.h>
 #include <linux/of.h>
 #include <linux/proc_fs.h>
 #include <linux/seq_file.h>
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index 791f4844efeb..01fc4d9c9c54 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -10,7 +10,6 @@
 #include <linux/bitops.h>
 #include <linux/compiler.h>
 #include <linux/console.h>
-#include <linux/gpio/consumer.h>
 #include <linux/interrupt.h>
 #include <linux/circ_buf.h>
 #include <linux/spinlock.h>
@@ -30,6 +29,7 @@
 struct uart_port;
 struct serial_struct;
 struct device;
+struct gpio_desc;
 
 /*
  * This structure describes all the operations that can be done on the
-- 
2.26.2

