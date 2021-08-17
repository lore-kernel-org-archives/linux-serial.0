Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A0AFC4338F
	for <linux-serial@archiver.kernel.org>; Tue, 17 Aug 2021 17:04:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1598D606A5
	for <linux-serial@archiver.kernel.org>; Tue, 17 Aug 2021 17:04:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230192AbhHQREx (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 17 Aug 2021 13:04:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbhHQREx (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 17 Aug 2021 13:04:53 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2D42C061764;
        Tue, 17 Aug 2021 10:04:19 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id n13-20020a17090a4e0d00b0017946980d8dso6279037pjh.5;
        Tue, 17 Aug 2021 10:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=74Z3GwaGrI/6L9131Hr1UbUOb6HfxaEgTCmH3K6poSk=;
        b=mJsV1EjCjypQ/+hVsiuaTX4jdTaHW0J2geVgrgdXMLGaI4kkfM69xiSPEkYG+0XppQ
         sTHJ+RmAbjFR9HSCTzsNB6avSLRCnQbWKv/V5iuzsqibAv8iKmZcrFTbinA6u9n+eKJ+
         hqbLRHC1YJbvo9nQEp0Dzszz2igME0vh5S6ZmXTAGNvUEDsxpG4g18xIzViIDXkc3joM
         QuUXeK0wLUbII158wLtnW4aF0imAXBPYOGA6hGSwMq6D5lTnsBbBG3vaylwWzZ6EFwFt
         dg4xR5b/CeLhhdlYpNcmdb8Pwyt0qmQyFF4yq4lhefjrNj4g4W6w25o/uGYZ5AXBI0c9
         X38A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=74Z3GwaGrI/6L9131Hr1UbUOb6HfxaEgTCmH3K6poSk=;
        b=q3VvQw48CDUYLdLgdrvb9T2efFO24Qt8viybzSJ19/No8ai5d3dfiygeNPXSYPQg8m
         zIv870QD5M+zxb8Y42Dtky6BHmWi6htQG8fmDwUVHPSuWe/9JfHacxC2bORBnTg96Fk7
         2t6N/+8JxjSKVW3YedquKn87nFGnhKmIC+Dkp+degYBFoO00L3yN3yKrMlwjj3T7CKo3
         dWz9Gu7yRG8DJIFDYGMRW/c0qHiPpBhrfMh5FDtHFMJUZ66oVhjB9raRBB5KLe/MIjhe
         6tvMV60A5t/lTe85eU6uD4f3Gr91Zo6sI2pwsVigkmEcRRUPUmL15c1eZTWefUcM1Dj6
         Ja7w==
X-Gm-Message-State: AOAM533uTEhHyYI/D8bvLlMPu9E8NtYKz5xcgsO1O4FOMOG6KB+7Iz29
        28t4/JOqWH27lwY2XL62geE=
X-Google-Smtp-Source: ABdhPJyaiZuQKZeZ5Z5LXSWOAXvDKrX2z5w8aE/fXPs2fir6u76qA821P2ehYwrWLsKR4qx6k6WotA==
X-Received: by 2002:a17:90a:aa8f:: with SMTP id l15mr4570586pjq.183.1629219858940;
        Tue, 17 Aug 2021 10:04:18 -0700 (PDT)
Received: from localhost.localdomain ([49.36.211.221])
        by smtp.googlemail.com with ESMTPSA id 65sm3958402pgi.12.2021.08.17.10.04.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 10:04:18 -0700 (PDT)
From:   Utkarsh Verma <utkarshverma294@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Valmer Huhn <valmer.huhn@concurrent-rt.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Utkarsh Verma <utkarshverma294@gmail.com>
Subject: [PATCH] serial: 8250_exar: Add missing call to pci_free_irq_vectors()
Date:   Tue, 17 Aug 2021 22:30:57 +0530
Message-Id: <20210817170057.16783-1-utkarshverma294@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Free the pci irq vectors if the call to pci_alloc_irq_vectors() fails
or if the device is removed.

Signed-off-by: Utkarsh Verma <utkarshverma294@gmail.com>
---
 drivers/tty/serial/8250/8250_exar.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/8250/8250_exar.c
index 3ffeedc29c83..38b65d6980f5 100644
--- a/drivers/tty/serial/8250/8250_exar.c
+++ b/drivers/tty/serial/8250/8250_exar.c
@@ -627,8 +627,10 @@ exar_pci_probe(struct pci_dev *pcidev, const struct pci_device_id *ent)
 	pci_set_master(pcidev);
 
 	rc = pci_alloc_irq_vectors(pcidev, 1, 1, PCI_IRQ_ALL_TYPES);
-	if (rc < 0)
+	if (rc < 0) {
+		pci_free_irq_vectors(pcidev);
 		return rc;
+	}
 
 	memset(&uart, 0, sizeof(uart));
 	uart.port.flags = UPF_SHARE_IRQ | UPF_EXAR_EFR | UPF_FIXED_TYPE | UPF_FIXED_PORT;
@@ -677,6 +679,7 @@ static void exar_pci_remove(struct pci_dev *pcidev)
 
 	if (priv->board->exit)
 		priv->board->exit(pcidev);
+	pci_free_irq_vectors(pcidev);
 }
 
 static int __maybe_unused exar_suspend(struct device *dev)
-- 
2.17.1

