Return-Path: <SRS0=EYjC=7H=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25F89C433DF
	for <linux-serial@archiver.kernel.org>; Mon, 25 May 2020 13:02:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00A292073B
	for <linux-serial@archiver.kernel.org>; Mon, 25 May 2020 13:02:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mMy73XZt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390609AbgEYNCw (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 25 May 2020 09:02:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388757AbgEYNCw (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 25 May 2020 09:02:52 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12B70C061A0E;
        Mon, 25 May 2020 06:02:52 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id l21so20405577eji.4;
        Mon, 25 May 2020 06:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DZr4IPFA4Vnbkt6An22aT54SGu2lLj63yMeWXMh2dCU=;
        b=mMy73XZtjjq+v4fDME0JBmckAwsdZlGQrcp1G0zD8WngkTBWfH8HjpTofWsjJgwraQ
         ncz6Rex61aGiRYH768s46xsWQhHLzdLe+qi7H71M8wHZZh318/BIb+Kzd5ljR9FhsExI
         Y2VNq5YIzefbTqjzrHmYmgdsZU/SnNdopkjk3ByxS+Jz0popDoFuQJjrziYpS8S0GhCx
         Y4tLWe5ROO8kQzaBLll0odz/tcULVeR1RkqKR11ed9IyOCy9v6pjqS2HRqr5HNTMtNkx
         b1rdKVPBUHwclqn85zggGlfCuHdP1ndh4g0dleq/9Tj7GiwnkBUROk3iM8J0VcDSsOpq
         zAaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DZr4IPFA4Vnbkt6An22aT54SGu2lLj63yMeWXMh2dCU=;
        b=RFxwan3zqfPWkMg7acC6TEMvNel1IHWQ4PjxqG6gNqx7DAIdR8r/he8fjgimtDgeVI
         JudUy5kTZY7sNxTwXHSkshcWn+vhx7HHe8xv464jRJFrExZ++RX+UyEEzn1BouniLbeB
         mXVi+kDcqV0v+t+kntmLXAlj4EW4LxZQwVnA22VysH8pCP2F7SYqLIVcq6MV38aZCCbD
         t52Xbd656qGWbGpvXZ8vyWNFiT7942aosEQqsN3ix26qoXKCri6f8m2Ui2igZ/32NZaW
         VHjvf9CBQDqeSh34AyuYNdeT9NCq6nn3E6/7E3UE54cnd+EHz3ZsTykPnVSsPAdEOvTf
         i3wg==
X-Gm-Message-State: AOAM530OoH6MTkNiBFFTSWo6ejuFu8oHv1eAIQ0CW6uIsr7iOxcwqUM8
        khbNPxfrX4QirucgruQO7Xw=
X-Google-Smtp-Source: ABdhPJz5mt0X/pfBA+FGY+x8reJY5MplGG1iEykEAMeauC//yEKoqPcGvWWK6WjbkImYZeR/hpWdKA==
X-Received: by 2002:a17:906:aeca:: with SMTP id me10mr19856510ejb.367.1590411770746;
        Mon, 25 May 2020 06:02:50 -0700 (PDT)
Received: from localhost.localdomain ([188.25.147.193])
        by smtp.gmail.com with ESMTPSA id d15sm15656750edr.3.2020.05.25.06.02.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2020 06:02:50 -0700 (PDT)
From:   Vladimir Oltean <olteanv@gmail.com>
To:     gregkh@linuxfoundation.org, linux-serial@vger.kernel.org
Cc:     jslaby@suse.com, andriy.shevchenko@linux.intel.com,
        lukas@wunner.de, heikki.krogerus@linux.intel.com, vigneshr@ti.com,
        linux-kernel@vger.kernel.org, fido_max@inbox.ru,
        radu-andrei.bulie@nxp.com
Subject: [PATCH] serial: 8250: probe all 16550A variants by default
Date:   Mon, 25 May 2020 16:02:38 +0300
Message-Id: <20200525130238.3614179-1-olteanv@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Vladimir Oltean <vladimir.oltean@nxp.com>

On NXP T1040, the UART is typically detected as 16550A_FSL64. After said
patch, it gets detected as plain 16550A and the Linux console is
completely garbled and missing characters.

So clearly, introducing the SERIAL_8250_16550A_VARIANTS config option
has broken many existing users because it has changed the default
behavior. Restore that by adding a 'default y' to this option. Users who
care about 20 ms shorter boot time can always disable it, but stop
wasting many debugging hours for people who don't care all that much.

Fixes: dc56ecb81a0a ("serial: 8250: Support disabling mdelay-filled probes of 16550A variants")
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/tty/serial/8250/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/8250/Kconfig b/drivers/tty/serial/8250/Kconfig
index af0688156dd0..89c7ecb55619 100644
--- a/drivers/tty/serial/8250/Kconfig
+++ b/drivers/tty/serial/8250/Kconfig
@@ -63,6 +63,7 @@ config SERIAL_8250_PNP
 config SERIAL_8250_16550A_VARIANTS
 	bool "Support for variants of the 16550A serial port"
 	depends on SERIAL_8250
+	default y
 	help
 	  The 8250 driver can probe for many variants of the venerable 16550A
 	  serial port. Doing so takes additional time at boot.
-- 
2.25.1

