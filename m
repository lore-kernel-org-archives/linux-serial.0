Return-Path: <SRS0=irUw=A7=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F2E9C433E6
	for <linux-serial@archiver.kernel.org>; Mon, 20 Jul 2020 12:07:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5EB222176B
	for <linux-serial@archiver.kernel.org>; Mon, 20 Jul 2020 12:07:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XzUCvGsl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728682AbgGTMHg (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 20 Jul 2020 08:07:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728532AbgGTMHf (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 20 Jul 2020 08:07:35 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EFC4C061794;
        Mon, 20 Jul 2020 05:07:35 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id f16so9992958pjt.0;
        Mon, 20 Jul 2020 05:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rWZKrOwq0rwjH5TwZ+UuKWlHddegJY7Nfmtdu4+t0zs=;
        b=XzUCvGslWr8de/Lj8121/tEpnZIfr0ColO1QujuDd9enBJsHTsaoQhN+0ZH/29Wtpf
         u4b9lZRjGc02DRjbZ6I5Zg+w/FOn+3Uk87EPegYpYGXH1Ss8wKvggR5hXVSkK9USTHxc
         RWcpG5sfF2gHaZ0tNIQjvJ9jxtnBUJjQfjM9g0UyzaZPQbtBId1QEb1/jI4CO6FI4l1F
         F3ufHVkPlhFeR1YJBosKSgagBgsy+9wxBZSwQ3+JEVwAmn1nTqlN+TR+W2khuxL+hcCu
         cdwd+U2jp+1p4lHdYacGNIYSunMdY5dalww2HdoEhX8fPlavAXTeoubhsKHOHO90DM6A
         SVWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rWZKrOwq0rwjH5TwZ+UuKWlHddegJY7Nfmtdu4+t0zs=;
        b=RnMQviLzU09ts1i7gP3nvvdbL36bGeaLSsX+ZXFuJFIM/HbDggIQZGqrIKa0Q7dEts
         R86pmFs/M2XsPyXXrTiSb9rngAeThyGbGxjaMEQE5NTr/8JHS2zqxBPrvek9Vh5W5vle
         es0mhUaFCQPYwpNOLe9jM37K2aryAhavRCiWrOmhMb2G7E3ri4yGwDt8wNb65FmLa93R
         J7bvfvBGFQCSr2Ac7TDENGvN9tq+qSRKeW2jvGI6rqgHB+Uo8h2eNqbUxnsJ4IrBMpP5
         +fMuOeM4JGUjkbD2pn9LV2oU15KsQZRrYbNVM3+fzH3momHqYT77Jw7wYAhsyu1cXii0
         B+uA==
X-Gm-Message-State: AOAM533I0Yr7b4vMITr682LwY0zcN3Xa4xs8vMrnRGySq9v4i38xXL4V
        fP1K4K2GYCD4+iLzOngPDj8=
X-Google-Smtp-Source: ABdhPJxlzUQmni1k1ndNykvfDgcQIktn9Uean9Z/i0ROVcwVzRJcUpiMgWJzkxVJaBf28RxXfI2F1g==
X-Received: by 2002:a17:90a:e017:: with SMTP id u23mr15893404pjy.137.1595246854880;
        Mon, 20 Jul 2020 05:07:34 -0700 (PDT)
Received: from varodek.iballbatonwifi.com ([103.105.153.67])
        by smtp.gmail.com with ESMTPSA id 141sm16777668pfw.72.2020.07.20.05.07.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2020 05:07:34 -0700 (PDT)
From:   Vaibhav Gupta <vaibhavgupta40@gmail.com>
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Helgaas <bjorn@helgaas.com>,
        Vaibhav Gupta <vaibhav.varodek@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     Vaibhav Gupta <vaibhavgupta40@gmail.com>,
        linux-serial@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH v1] serial: pch_uart: use generic power management
Date:   Mon, 20 Jul 2020 17:34:15 +0530
Message-Id: <20200720120414.399961-1-vaibhavgupta40@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Drivers using legacy PM have to manage PCI states and device's PM states
themselves. They also need to take care of configuration registers.

With improved and powerful support of generic PM, PCI Core takes care of
above mentioned, device-independent, jobs.

This driver makes use of PCI helper functions like
pci_save/restore_state(), pci_enable_device() and pci_set_power_state()
to do required operations. In generic mode, they are no longer needed.

Change function parameter in both .suspend() and .resume() to
"struct device*" type. Use dev_get_drvdata() to get drv data.

Compile-tested only.

Signed-off-by: Vaibhav Gupta <vaibhavgupta40@gmail.com>
---
 drivers/tty/serial/pch_uart.c | 34 ++++++++++------------------------
 1 file changed, 10 insertions(+), 24 deletions(-)

diff --git a/drivers/tty/serial/pch_uart.c b/drivers/tty/serial/pch_uart.c
index 40fa7a27722d..67aca8cb9cd4 100644
--- a/drivers/tty/serial/pch_uart.c
+++ b/drivers/tty/serial/pch_uart.c
@@ -1857,41 +1857,24 @@ static void pch_uart_pci_remove(struct pci_dev *pdev)
 	kfree(priv);
 	return;
 }
-#ifdef CONFIG_PM
-static int pch_uart_pci_suspend(struct pci_dev *pdev, pm_message_t state)
+
+static int __maybe_unused pch_uart_pci_suspend(struct device *dev)
 {
-	struct eg20t_port *priv = pci_get_drvdata(pdev);
+	struct eg20t_port *priv = dev_get_drvdata(dev);
 
 	uart_suspend_port(&pch_uart_driver, &priv->port);
 
-	pci_save_state(pdev);
-	pci_set_power_state(pdev, pci_choose_state(pdev, state));
 	return 0;
 }
 
-static int pch_uart_pci_resume(struct pci_dev *pdev)
+static int __maybe_unused pch_uart_pci_resume(struct device *dev)
 {
-	struct eg20t_port *priv = pci_get_drvdata(pdev);
-	int ret;
-
-	pci_set_power_state(pdev, PCI_D0);
-	pci_restore_state(pdev);
-
-	ret = pci_enable_device(pdev);
-	if (ret) {
-		dev_err(&pdev->dev,
-		"%s-pci_enable_device failed(ret=%d) ", __func__, ret);
-		return ret;
-	}
+	struct eg20t_port *priv = dev_get_drvdata(dev);
 
 	uart_resume_port(&pch_uart_driver, &priv->port);
 
 	return 0;
 }
-#else
-#define pch_uart_pci_suspend NULL
-#define pch_uart_pci_resume NULL
-#endif
 
 static const struct pci_device_id pch_uart_pci_id[] = {
 	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x8811),
@@ -1945,13 +1928,16 @@ static int pch_uart_pci_probe(struct pci_dev *pdev,
 	return ret;
 }
 
+static SIMPLE_DEV_PM_OPS(pch_uart_pci_pm_ops,
+			 pch_uart_pci_suspend,
+			 pch_uart_pci_resume);
+
 static struct pci_driver pch_uart_pci_driver = {
 	.name = "pch_uart",
 	.id_table = pch_uart_pci_id,
 	.probe = pch_uart_pci_probe,
 	.remove = pch_uart_pci_remove,
-	.suspend = pch_uart_pci_suspend,
-	.resume = pch_uart_pci_resume,
+	.driver.pm = &pch_uart_pci_pm_ops,
 };
 
 static int __init pch_uart_module_init(void)
-- 
2.27.0

