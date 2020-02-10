Return-Path: <SRS0=+uUE=36=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10128C35254
	for <linux-serial@archiver.kernel.org>; Mon, 10 Feb 2020 19:30:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A96A020661
	for <linux-serial@archiver.kernel.org>; Mon, 10 Feb 2020 19:30:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kopismobile-com.20150623.gappssmtp.com header.i=@kopismobile-com.20150623.gappssmtp.com header.b="1AtFHHgH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727433AbgBJTaK (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 10 Feb 2020 14:30:10 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:37573 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727029AbgBJTaK (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 10 Feb 2020 14:30:10 -0500
Received: by mail-ot1-f65.google.com with SMTP id d3so7575089otp.4
        for <linux-serial@vger.kernel.org>; Mon, 10 Feb 2020 11:30:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kopismobile-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ttAcZsliGUSH7WXcVjhAV/BjixYVK4XpgsWIL/Hit7c=;
        b=1AtFHHgHTS8qKJtFng0Lcn4Jx4ytAEVwvCUlERa4Y3S5RvhtlfDYKcw5tJIrzxyEG4
         IqCK0NQ0KONUD9HDQ/TbOjpSiCQ7mFNUUyB5+8lBhVAojD7115tcyNDvWJA/lmEcE/rl
         f9/7FDFVGPinXDYg4h+Qf3+x3mR23lFwQe9mxbJaTinUkaULX4UI5bChPyjB8gM6OfbT
         qgC+ZklVkry+/NA01RoouDRmlKAXwJqr8TtKARNMw/ognzPg3BHKWjLnX8H83Z/Cl7Ji
         3kq+Rs9oMPR6eFOsTdtROvxibm9ytUX3TNFHBns5fj5vqN/j9MmWjCBjOXQH/1rW/pGv
         PsUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ttAcZsliGUSH7WXcVjhAV/BjixYVK4XpgsWIL/Hit7c=;
        b=VtpLdJ+TQEa0YSnzdPnZKe9Zhbl/f/XhRYXzQNYGVpvIvKo/Vufo/GXDgz9ybPJmdN
         nQVSkA8AfxC0g73K+2hopkBGPzM105lMYpCMC7DoT245BNl8+CH8p7DaQm8ax+RXq8eX
         yyP+5NLyvxVphIbnviQlwTKSHHkrgWQ2rJWWPRyxftPljxzzOx7QSOWB//vqUAwkGRI8
         C4FCaOlBjfDNKpHj9dX+XMzsqJ25aY6WYDQUdXTKT5IX6i9p0JFxpN4BtAVsxlPH+7aM
         +rcw4zzKoMo9r/EDlhDyhiT//ygp9sFu65OhndFShwC/O/X8IZetoNhRzb1elFrOuVlW
         y0Og==
X-Gm-Message-State: APjAAAXas0Jmxfdjp95ycMuu+8eblLVZcv5kfEpR6TaJalZ4DrEeLjnJ
        MSTcvbu5EpZd8UbFXD+YngXBRg==
X-Google-Smtp-Source: APXvYqxwMvwLJXzmeZp/mbXuPai64iNGbAETuUWWzd3ig2H/OVUaeJjjRbpJC27IHP+Q3FkjW1CeJg==
X-Received: by 2002:a9d:1ca3:: with SMTP id l35mr798534ota.271.1581363009457;
        Mon, 10 Feb 2020 11:30:09 -0800 (PST)
Received: from farregard-ubuntu.kopismobile.org (c-73-177-17-21.hsd1.ms.comcast.net. [73.177.17.21])
        by smtp.gmail.com with ESMTPSA id n22sm412163otj.36.2020.02.10.11.30.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2020 11:30:08 -0800 (PST)
From:   George Hilliard <ghilliard@kopismobile.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     George Hilliard <ghilliard@kopismobile.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH v2 0/2] Implement support for inverted serial TX/RX on i.MX
Date:   Mon, 10 Feb 2020 13:29:47 -0600
Message-Id: <20200210192949.7338-1-ghilliard@kopismobile.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

This peripheral has dedicated control bits that flip input/output
signals before handing them off to the OS.  This is useful on my
hardware because the UART is connected to an RS-422 transceiver with the
+/- pins hooked up backward.  Instead of a hack flipping all the bits
before sending them, the hardware can do it for free.

Functionally unchanged from v1, but the confidentiality notice has been
removed.  I also CC'd other lists that Uwe suggested.

George Hilliard (2):
  dt-bindings: serial: document fsl,inverted-tx and -rx options
  tty: imx serial: Implement support for reversing TX and RX polarity

 .../bindings/serial/fsl-imx-uart.txt          |  4 ++++
 drivers/tty/serial/imx.c                      | 22 +++++++++++++------
 2 files changed, 19 insertions(+), 7 deletions(-)

-- 
2.25.0

