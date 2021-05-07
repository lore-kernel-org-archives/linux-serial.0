Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_LOCAL_DIGITS,FROM_LOCAL_HEX,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 777CDC433ED
	for <linux-serial@archiver.kernel.org>; Fri,  7 May 2021 13:04:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 299A56143F
	for <linux-serial@archiver.kernel.org>; Fri,  7 May 2021 13:04:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236783AbhEGNFR (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 7 May 2021 09:05:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235836AbhEGNFO (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 7 May 2021 09:05:14 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52C4FC061574;
        Fri,  7 May 2021 06:04:13 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id h14-20020a17090aea8eb02901553e1cc649so5217036pjz.0;
        Fri, 07 May 2021 06:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Kz0YcBrq8g2OohZvohzHvN3l1WC2jeNvxaP5PqjYa+Y=;
        b=VPVtMyn5YHM6qV4qxLN6rf1oQzfo1JIe40WUL8WLjZDOpLAMlNYkgH5rbVH93iAqcQ
         iEX99Z+7nmQ3+jbGQmwTOLk4tI8yOptKVbLvRYKaq3SuKc6L7hc+ULTURy5arRPy9dB4
         BTqTJU/tWiO5WWoz4ufJdRXRx5VMdG3/88C/t977RuGCS/Ewi33OPqFSCldOxpKMwqZa
         ihJUdwYxe45g35vmvZMvj8fDcjrIcjK53D+uyS4qQuEQGUQJ0gRBjtFH8oTtE+PBozUO
         98jei2Z81U5Pqv/dj4pdonB4FfPsYNhcvbGN1xNPs+2bvfoUE6pBWIyUfW0KO/RIWySr
         0nuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Kz0YcBrq8g2OohZvohzHvN3l1WC2jeNvxaP5PqjYa+Y=;
        b=O9h6dT70Bkvua9A2KlFuLj73kOnDj5oHySbBSt+Cyd9imZgyJJYOJo9n2L5DjNVpd+
         E9XZ5nB5LYg/w4pvplOBkGbkQ/3JW6FSvSEv+hqn/cOSr9QGrhEdtDv7Ph2NHxUlp43l
         vMdvBKNf9+h/y2hAk+pULgzzAjY+hJO3pCb9qdGIUVV3r8mio8MdR/DuXrQJeWmc2iq1
         2z3RHqwAPNahGyahrm+Ve9Zm9hAfXF+qMPa1qL2zoo7ghsv+qBOR9rO2DciBwEJ3QBX5
         oYkHZKJq7MsaGTimPryphVEiTKnzbfGFA2k8xkAJH2FidYmS0QtwwAILDmlCl4BaXrcU
         JhPQ==
X-Gm-Message-State: AOAM533ctjMa4SC4IiSvm523N5s5lJXYVK/QYhHWXTP+pjE3eBSXC8Un
        mHXuanQp5IvkR9o/OWSnouYBFYZT+jQb31Buym4=
X-Google-Smtp-Source: ABdhPJzRPyQdhTffaiZilwPaQruhJVqcfkCGdJ9wk5anWmYpkEaHPoWl5raUrCfR53ukLMHgX6KGLQ==
X-Received: by 2002:a17:90a:b290:: with SMTP id c16mr10131933pjr.81.1620392652461;
        Fri, 07 May 2021 06:04:12 -0700 (PDT)
Received: from localhost.localdomain (host-219-71-67-82.dynamic.kbtelecom.net. [219.71.67.82])
        by smtp.gmail.com with ESMTPSA id d26sm4843295pfq.215.2021.05.07.06.04.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 May 2021 06:04:12 -0700 (PDT)
From:   Wei Ming Chen <jj251510319013@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
        Wei Ming Chen <jj251510319013@gmail.com>
Subject: [PATCH] serial: 8250_pci: Use fallthrough pseudo-keyword
Date:   Fri,  7 May 2021 21:04:03 +0800
Message-Id: <20210507130403.11144-1-jj251510319013@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Add pseudo-keyword macro fallthrough[1]

[1] https://www.kernel.org/doc/html/latest/process/deprecated.html?highlight=fallthrough#implicit-switch-case-fall-through

Signed-off-by: Wei Ming Chen <jj251510319013@gmail.com>
---
 drivers/tty/serial/8250/8250_pci.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
index 689d8227f95f..4158f06de4d5 100644
--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -847,8 +847,11 @@ static int pci_netmos_init(struct pci_dev *dev)
 
 	switch (dev->device) { /* FALLTHROUGH on all */
 	case PCI_DEVICE_ID_NETMOS_9904:
+		fallthrough;
 	case PCI_DEVICE_ID_NETMOS_9912:
+		fallthrough;
 	case PCI_DEVICE_ID_NETMOS_9922:
+		fallthrough;
 	case PCI_DEVICE_ID_NETMOS_9900:
 		num_serial = pci_netmos_9900_numports(dev);
 		break;
-- 
2.25.1

