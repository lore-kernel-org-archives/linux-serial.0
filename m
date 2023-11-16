Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A5E9C197A0
	for <linux-serial@archiver.kernel.org>; Thu, 16 Nov 2023 10:31:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234029AbjKPKbb (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 16 Nov 2023 05:31:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbjKPKb3 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 16 Nov 2023 05:31:29 -0500
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 026B8B7;
        Thu, 16 Nov 2023 02:31:23 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id BAB8660005;
        Thu, 16 Nov 2023 10:31:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1700130682;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=ixpklLWwSkk4I/yPqqbqBcWEcsYH1dKNM9IZkWS8e0M=;
        b=RcvKFHwK/5hxl0ISDxClwPnpyCAZE4zebORmbm+2jMfjVR3am4J9EkJeDaShPuIkHjvlwZ
        nilZweL4mJSiCtu1rxkqfCBkK6RMFovVGBVw2wo/5OuBvZI6uaNvTHLSZqfgk1mtH6EdgL
        Px+Fs0uCgJTeTKIoUXTjF8UUC4j2V4DMKO+4I5PIEqRo+qYCjv+sV/WNTMXBFKm0a9RqZx
        x7KA7sMJJipPIf8N0CJVVenw5YcqXtlTtNnTJWoXoYfYgl0rkHlxDGufWPEDpCJ73sfupu
        YAzflqr8WqL5QwrgoWi/F0EKhVP6QUDdvPSyUPX41A8/dkbD4h9r98eq1aKSZA==
From:   =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: [PATCH v2 0/5] Cleanup AMBA PL011 driver
Date:   Thu, 16 Nov 2023 11:31:03 +0100
Message-Id: <20231116-mbly-uart-v2-0-863f665ce520@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAGfvVWUC/03MQQrDIBCF4auEWdeSGNpqV71HyULN2AwkWtRKQ
 /DutYFCF7P4h8e3QcRAGOHabBAwUyTvavBDA2ZS7oGMxtrAW9539dii55W9VEhMWaOM1lJYoaH
 unwEtvXfrPtSeKCYf1p3O3ff7U85/Su5YyyQ/CUTF5WXsb9r7NJM7Gr/AUEr5ACNBik2kAAAA
To:     Russell King <linux@armlinux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        =?utf-8?q?Gr=C3=A9gory_Clement?= <gregory.clement@bootlin.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>,
        Tawfik Bayouk <tawfik.bayouk@mobileye.com>,
        =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: b4 0.12.3
X-GND-Sasl: theo.lebrun@bootlin.com
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi,

While adding upstream support to a new platform (Mobileye EyeQ5[1]) that
uses the AMBA PL011 driver, I took some time to look at the PL011
driver and ended up with a few patches that cleanup parts of it. The
line-diff is big mostly because of the checkpatch-fixing commits.

The driver hadn't received any love for quite some time. A single commit
changes the code's behavior: see "tty: serial: amba-pl011: Parse bits
option as 5, 6, 7 or 8 in _get_options". See commit messages for more
information.

Compared to v1, we drop one [PATCH 6/6] & we fix some nits.

[1]: https://lore.kernel.org/all/202310050726.GDpZbMDO-lkp@intel.com/T/

Have a nice day,
Théo Lebrun

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
Changes in v2:
- [PATCH 2]: add #include <linux/bits.h> in include/linux/amba/serial.h
  as we use the BIT() macro.
- Move one whitespace cleanup from [PATCH 4/6] to [PATCH v2 3/5] where
  it belongs.
- Drop [PATCH 6/6]: console will never have a word length of 5 or 6.
- Link to v1: https://lore.kernel.org/r/20231026-mbly-uart-v1-0-9258eea297d3@bootlin.com

---
Théo Lebrun (5):
      tty: serial: amba: cleanup whitespace
      tty: serial: amba: Use BIT() macro for constant declarations
      tty: serial: amba-pl011: cleanup driver
      tty: serial: amba-pl011: replace TIOCMBIT macros by static functions
      tty: serial: amba-pl011: unindent pl011_console_get_options function body

 drivers/tty/serial/amba-pl011.c | 241 ++++++++++++++++++++--------------------
 include/linux/amba/serial.h     | 193 ++++++++++++++++----------------
 2 files changed, 218 insertions(+), 216 deletions(-)
---
base-commit: 82251bf0515a7c32121b0e833922708d4dd70da9
change-id: 20231023-mbly-uart-afcacbb98f8b

Best regards,
-- 
Théo Lebrun <theo.lebrun@bootlin.com>

