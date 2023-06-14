Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26FBAEB64DA
	for <linux-serial@archiver.kernel.org>; Wed, 14 Jun 2023 06:37:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243090AbjFNGhQ (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 14 Jun 2023 02:37:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243160AbjFNGgw (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 14 Jun 2023 02:36:52 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEF741BF7
        for <linux-serial@vger.kernel.org>; Tue, 13 Jun 2023 23:36:41 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3f8d2bfec3bso3373045e9.2
        for <linux-serial@vger.kernel.org>; Tue, 13 Jun 2023 23:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686724600; x=1689316600;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8xH+3TukFsIv3cdPHfSub9T49BJL/AeGC9ZLa4qaj34=;
        b=PMBq1D3LMmdg6odh7ZoEkJF+YdTnIB8hyFqtgJg/FGlUQpZpPJe6slbk2Vilp402QB
         Rzww5X33CUxTIYWiDI/g3t0pfa8b7lfdykg4d52xqWD125rnLNMG8QK38/KD8f1fwHKC
         PmDV2fGk7MhANYkHsrzalzKK4PgZlOeiIqh8BdOF1dIY/e+p75C7lvQfN3N7xpZgqdkf
         LzzzKUUW5t0ky4TehnX2Jq3J9PXA39NfCF9wKT01mNYCLkeJawTC+CjbbbLbe2uA2W0N
         dPO+pHcJGany/oCGQXSW29fdp1EhpU+TZe1AID1SVIe0LyLff9U2QHbGKjDRARHeiicv
         hpbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686724600; x=1689316600;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8xH+3TukFsIv3cdPHfSub9T49BJL/AeGC9ZLa4qaj34=;
        b=bc+j/Yqhg76Thfd1R7ylTxWMYUocyq/fIW4cQTollmRh8RZ3PGgYTrYJkoj9xo1fPt
         Ww5kPaCyxeyP4rZAfUSSrUBrlGy+akxTlTJsrpFiO+o3OMrgDvrwBnvJizmjyAAW4qBn
         wGKZMPxDFsT7+wmEkIgbARlss2Xks8/0WS2nD6LYlUYFXhX4HJxXKQq7jjz1E3aWjZ7j
         RCnEE5VCi6UsAdM+ijnuTatEkG21s8uMBGqCVCGREToloB+yljhGn7yAbHjvpqwxGwhh
         bPSWrHVeeM6ZSYeyZVy9ub571YGuIUyJwjLMLpKIZtk5uY0XruK2JmgzP8aATceCjEhu
         5qGA==
X-Gm-Message-State: AC+VfDytXnh0F8+redi6TZqrKLFFTJLI+sn20Ho+Hu9IFjkfi7F7iWKZ
        e10GALRKxrO3zq56/PN2gGyovA==
X-Google-Smtp-Source: ACHHUZ70+/9T5WjSsqxROpoPJdQZzZvygIJZzvEM/9TvClD2GFsby0lpQO4nP9sS8fLnIuZbn4avcg==
X-Received: by 2002:a5d:5109:0:b0:30e:57f2:9f0 with SMTP id s9-20020a5d5109000000b0030e57f209f0mr9768759wrt.39.1686724600314;
        Tue, 13 Jun 2023 23:36:40 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id b10-20020adfe30a000000b00300aee6c9cesm17317190wrj.20.2023.06.13.23.36.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 23:36:38 -0700 (PDT)
Date:   Wed, 14 Jun 2023 09:36:33 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] serial: core: fix -EPROBE_DEFER handling in init
Message-ID: <18318adb-ab2c-4dcc-9f96-498a13d16b80@moroto.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The -EPROBE_DEFER error path in serial_base_device_init() is a bit
awkward.  Before the call to device_initialize(dev) then we need to
manually release all the device resources.  And after the call then we
need to call put_device() to release the resources.  Doing either one
wrong will result in a leak or a use after free.

So let's wait to return -EPROBE_DEFER until after the call to
device_initialize(dev) so that way callers do not have to handle
-EPROBE_DEFER as a special case.  Now callers can just use put_device()
for clean up.

The second issue with the -EPROBE_DEFER path is that deferring is not
supposed to be a fatal error, but instead it's normal part of the
init process and the kernel recovers from it automatically.  That means
we should not print an error message but just a debug message on this
path.

Fixes: 539914240a01 ("serial: core: Fix probing serial_base_bus devices")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/tty/serial/serial_base_bus.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/serial_base_bus.c b/drivers/tty/serial/serial_base_bus.c
index 9de9f6fa6481..6ff59c89d867 100644
--- a/drivers/tty/serial/serial_base_bus.c
+++ b/drivers/tty/serial/serial_base_bus.c
@@ -50,17 +50,17 @@ static int serial_base_device_init(struct uart_port *port,
 				   void (*release)(struct device *dev),
 				   int id)
 {
-	if (!serial_base_initialized) {
-		dev_err(port->dev, "uart_add_one_port() called before arch_initcall()?\n");
-		return -EPROBE_DEFER;
-	}
-
 	device_initialize(dev);
 	dev->type = type;
 	dev->parent = parent_dev;
 	dev->bus = &serial_base_bus_type;
 	dev->release = release;
 
+	if (!serial_base_initialized) {
+		dev_dbg(port->dev, "uart_add_one_port() called before arch_initcall()?\n");
+		return -EPROBE_DEFER;
+	}
+
 	return dev_set_name(dev, "%s.%s.%d", type->name, dev_name(port->dev), id);
 }
 
-- 
2.39.2

