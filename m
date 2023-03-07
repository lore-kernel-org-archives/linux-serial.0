Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60FCFC6FD1A
	for <linux-serial@archiver.kernel.org>; Tue,  7 Mar 2023 15:57:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230112AbjCGP5C (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 7 Mar 2023 10:57:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231321AbjCGP4b (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 7 Mar 2023 10:56:31 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A6E592727
        for <linux-serial@vger.kernel.org>; Tue,  7 Mar 2023 07:55:47 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id t25-20020a1c7719000000b003eb052cc5ccso10712747wmi.4
        for <linux-serial@vger.kernel.org>; Tue, 07 Mar 2023 07:55:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678204546;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P15p35qbKcAqVqsT9ttAQG6NVrmbwLtDEUCun7OYD7M=;
        b=xG1h0yEbTGisiKYmRDyUt8v7SeyNiOl2wgMRcDZpR5hlJwpb/2UoUsll2kLQyml10I
         mQjMYhtx6jahxTEtVgY+PGUg31xcm4N1EjRDKnoAohkSG3upA2lEprddJS1yNWjLTrwS
         dw+1AmXgku8l64hHuiJsasVntg4iljribigsUpuihJLdwe3Rck8lB7AlqC7feO0bBkpJ
         TUDkrZ8NYgWbJbhaVWU9VSLPXdoSmTn/dmts4wmRgeTmtfJgzAARoaKN4YCo0OV7zxRS
         BNRsQgjfy4uBpSsqICwRDTh24Gm4AfFAv7j1vt5I+9G8cmsfDYHprb70kX7aanGixb9v
         ikfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678204546;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P15p35qbKcAqVqsT9ttAQG6NVrmbwLtDEUCun7OYD7M=;
        b=q/FIofmfKZkgOjptCjcSDqlB9i9CTzJTfVnrw5zLKSSw8sqMhRNaFzKlNwBtA44P2E
         PjlGAP/iLAKbg4jwMUc6sRWf1REPGDF1Iv6gg9dswEWPEdaSkSFaC/AeA9lHsqIAkh2R
         SKpGwcsO7b8c7OD1EvZMEbU/HOXIQFfS1dhQ91/pMiB75IuEzNUtMx/azLdgX6V66Yrq
         SMbHYw19Kc56Bm2rCtYPyGPuT4TfVXtp9h7HDyvmVxnk0lFv+JOaX1M70UnaYmbM5u+p
         Qaw67paitHUB/c0ZVBNHgXJI0ogCx2mXARZx++GTl9YIS5kfnoiKwYdlpk8ZvY4pKlW2
         ZwrA==
X-Gm-Message-State: AO0yUKUuCUUK/n1IpoOQw1xsb/bSqTiYue5UfEf8KksyKD011BGnyMdk
        tZ69ah7Kp4xHevk3vXCWO8JZ/A==
X-Google-Smtp-Source: AK7set9f/DHvbv2XVBWNvZ1EineBTV+wgavrkys7oed6bmp6CNQz1UnFeQUBASHcvALv/DpMVcfJHw==
X-Received: by 2002:a05:600c:1c1f:b0:3eb:3b7e:7b89 with SMTP id j31-20020a05600c1c1f00b003eb3b7e7b89mr13606520wms.3.1678204546445;
        Tue, 07 Mar 2023 07:55:46 -0800 (PST)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id t14-20020a05600c450e00b003e1fee8baacsm18115389wmo.25.2023.03.07.07.55.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 07:55:45 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     agross@kernel.org, andersson@kernel.org, gregkh@linuxfoundation.org
Cc:     konrad.dybcio@linaro.org, jirislaby@kernel.org,
        bartosz.golaszewski@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 2/2] tty: serial: qcom-geni-serial: check for valid size before starting dma
Date:   Tue,  7 Mar 2023 15:55:42 +0000
Message-Id: <20230307155543.31021-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20230307155543.31021-1-srinivas.kandagatla@linaro.org>
References: <20230307155543.31021-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Check if there are valid length of bytes to transfer before starting dma.

without this check we can see below kernel warning when we try to map a zero size buffers.

------------[ cut here ]------------
WARNING: CPU: 0 PID: 0 at drivers/iommu/dma-iommu.c:1046 iommu_dma_unmap_page+0xe0/0xfc
Modules linked in:
CPU: 0 PID: 0 Comm: swapper/0 Tainted: G        W          6.3.0-rc1-dirty #347
Hardware name: Qualcomm Technologies, Inc. Robotics RB5 (DT)
pstate: 804000c5 (Nzcv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : iommu_dma_unmap_page+0xe0/0xfc
lr : iommu_dma_unmap_page+0x38/0xfc
...
Call trace:
 iommu_dma_unmap_page+0xe0/0xfc
 dma_unmap_page_attrs+0x30/0x1ec
 geni_se_tx_dma_unprep+0x58/0x80
 qcom_geni_serial_isr+0x350/0x750
 __handle_irq_event_percpu+0x58/0x148
 handle_irq_event_percpu+0x18/0x4c
 handle_irq_event+0x48/0x88
 handle_fasteoi_irq+0xb0/0x130
 generic_handle_domain_irq+0x2c/0x44
 gic_handle_irq+0xd4/0x140
 call_on_irq_stack+0x24/0x4c
 do_interrupt_handler+0x80/0x84
 el1_interrupt+0x38/0x6c
 el1h_64_irq_handler+0x18/0x24
 el1h_64_irq+0x64/0x68
 cpuidle_enter_state+0x1e4/0x310
 cpuidle_enter+0x3c/0x54
 call_cpuidle+0x1c/0x40
 do_idle+0x204/0x260
 cpu_startup_entry+0x28/0x2c
 kernel_init+0x0/0x12c
 arch_post_acpi_subsys_init+0x0/0x8
 start_kernel+0x3cc/0x74c
 __primary_switched+0xbc/0xc4

Fixes: 2aaa43c70778 ("tty: serial: qcom-geni-serial: add support for serial engine DMA")
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/tty/serial/qcom_geni_serial.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index 5972b5c317d3..bb63a00f4c07 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -637,6 +637,9 @@ static void qcom_geni_serial_start_tx_dma(struct uart_port *uport)
 
 	xmit_size = CIRC_CNT_TO_END(xmit->head, xmit->tail, UART_XMIT_SIZE);
 
+	if (!xmit_size)
+		return;
+
 	qcom_geni_serial_setup_tx(uport, xmit_size);
 
 	ret = geni_se_tx_dma_prep(&port->se, &xmit->buf[xmit->tail],
-- 
2.21.0

