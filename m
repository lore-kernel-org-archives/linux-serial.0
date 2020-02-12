Return-Path: <SRS0=7071=4A=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2F02C352A4
	for <linux-serial@archiver.kernel.org>; Wed, 12 Feb 2020 16:35:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A99D021739
	for <linux-serial@archiver.kernel.org>; Wed, 12 Feb 2020 16:35:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kopismobile-com.20150623.gappssmtp.com header.i=@kopismobile-com.20150623.gappssmtp.com header.b="CosubR0P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727279AbgBLQfz (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 12 Feb 2020 11:35:55 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:41097 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728575AbgBLQfz (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 12 Feb 2020 11:35:55 -0500
Received: by mail-ot1-f68.google.com with SMTP id r27so2520757otc.8
        for <linux-serial@vger.kernel.org>; Wed, 12 Feb 2020 08:35:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kopismobile-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0eZSvCNK3gdLQqWXuN5CvAUHuBcFDPQoQpN6GR3z8cw=;
        b=CosubR0PA3uVyu+aEbqYupTko2kmhxDxUOhdeBzW1wL28I3Cy7aph/nZOhY9dtuGmz
         7icJviDkNwhfEq7NiEdMCeLCSSwU/xx/+D7R0qQSjeodyFPOFG+Ri/qWE/cPyj26MDej
         eSXXZLhnbJJ+PvnWXwjNtkXDWim0EaX+4wwphO3eMfSaxytR7A0kkaEMNT7BBMx2URl5
         eypry2HqXpgV8WzjjCK6iusRf9nUpCdZD/5+52FAIMUKlVg4AQVZw9wpK8AplIs3stLI
         WeEf5mzt+iFX/XIZj/Q+cSalCBSnUD6970rFH8eu7a2aw7fwlHTftrHeBLgmZFTR1Ekc
         94EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0eZSvCNK3gdLQqWXuN5CvAUHuBcFDPQoQpN6GR3z8cw=;
        b=DNiS7QmSQ0ThH05ns+t/aUwUivX6iB6nIu5g7hLYz3dC7jF9aQVvdvx9e7AaUA86wR
         I1kTFwZ+DfWYwjzLWRTsF7B1ko5Yvdl/THgHYOac9rI0R0Ow9asv5gqN5a7YrJBWg5Oi
         lRDE9cj40+zShF271m+s3zgi6lw+QWpAV8u2i6lk3MHv1vIAifQGgSXQbeJFS5aemCMl
         y2ZnFLeH+uJOSKruUpGu+/aKWOcFGM+ygNK8yTLrWKMBXSSV8N2Yh5vJQCCB7FcJ3kMG
         9IPd0hiv3NNCwv1LqMSgjISUM5EMDU4QyQWKlfB8JawOgU30L34SSQsXNrkq0kvtQZZw
         W1NQ==
X-Gm-Message-State: APjAAAXxPhVCuFRpQYheqWAESJMCpepihwW0zCmW7IBtc7nlp8RaICT1
        Bngi2kM5cTW++9wV6jG3VqF70nAh9i1fO6vo
X-Google-Smtp-Source: APXvYqxY4STQDOv2ETVixf+U7ZakBTOQRmdGa+EuNr5Zs/QTLD3Lw6XecFR4zwcSJbUPEGOu6rEE5Q==
X-Received: by 2002:a9d:6d10:: with SMTP id o16mr10307299otp.28.1581525353123;
        Wed, 12 Feb 2020 08:35:53 -0800 (PST)
Received: from farregard-ubuntu.kopismobile.org (c-73-177-17-21.hsd1.ms.comcast.net. [73.177.17.21])
        by smtp.gmail.com with ESMTPSA id q22sm321034otf.17.2020.02.12.08.35.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2020 08:35:52 -0800 (PST)
From:   George Hilliard <ghilliard@kopismobile.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     George Hilliard <ghilliard@kopismobile.com>,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        NXP Linux Team <linux-imx@nxp.com>, kernel@pengutronix.de
Subject: [PATCH v3 0/2] Implement support for inverted serial TX/RX on i.MX
Date:   Wed, 12 Feb 2020 10:35:36 -0600
Message-Id: <20200212163538.3006-1-ghilliard@kopismobile.com>
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

Revision 3 sets *and* clears the bit as necessary during startup.  It
also moves init before transmit is enabled.

George Hilliard (2):
  dt-bindings: serial: document fsl,inverted-tx and -rx options
  tty: imx serial: Implement support for reversing TX and RX polarity

 .../bindings/serial/fsl-imx-uart.txt          |  4 +++
 drivers/tty/serial/imx.c                      | 29 +++++++++++++++----
 2 files changed, 27 insertions(+), 6 deletions(-)

-- 
2.25.0

