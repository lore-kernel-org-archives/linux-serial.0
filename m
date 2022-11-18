Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B086C4167B
	for <linux-serial@archiver.kernel.org>; Fri, 18 Nov 2022 12:27:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241807AbiKRM1R (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 18 Nov 2022 07:27:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241827AbiKRM0a (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 18 Nov 2022 07:26:30 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3215399E8F
        for <linux-serial@vger.kernel.org>; Fri, 18 Nov 2022 04:26:14 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id r126-20020a1c4484000000b003cffd336e24so2710417wma.4
        for <linux-serial@vger.kernel.org>; Fri, 18 Nov 2022 04:26:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kA0mRGqH1AuIV+a1MO05ETt4x66olQAeBj4vK+Kxqj8=;
        b=hkM7abkKGR4X3yahLkJH73KCQSaV68CGuVTJlrk2TkbNfZYOmVJ7x5d/hmfeRVUw2W
         bMJz3Cd3zkdJzfKbE0IsupzbOrHa9Hf5Vt9tnebhKw8SGEExrrH3ReA9zMoULFmgZhRU
         gID8QLVEX1dQcEB3sEHWFqUNAAEH44wROl1xrg8FyQp6c3uyCsajOuW0ENscAF0EhYbo
         9WLVuTAS0xAzUPIAtt6Ao5E5a2uolP+G9WfZsmcMqoigK+o1Z03FyYBjEpfec8HeLf/i
         pkx4tG/oe1/eipwem9b9l7nV01FDqWtyr+JaEpSAVlyC9BNcWglA7jfYEcxUJ8KAuLPk
         nZ6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kA0mRGqH1AuIV+a1MO05ETt4x66olQAeBj4vK+Kxqj8=;
        b=2+cahV+ZYNUmD3/mhX/N4sKwLtqeOXGq+vl2bGBmtenucin00cJRjPSHp2PfUCwK0N
         PABR2HEi+eP/YsBmrLY1IdDZGo8HR5L8OZ2pV5AEIdy9dLYCvoLRn9YApbMhii15SGht
         JA7fYK/JyGXUlysAjQ0X4xdbZgIUrZNqd6ATUk0S8mNJhoyjeXGhdHdTj8pe/XMGS2/k
         M76GR5ZSD9LRUG5iHxIM5VuHyVegiJlaZ2HFQqVzVHDk/82+Vrfti/dFFIdK+Vxoy9t6
         8k1jOYC66OwoWabaykpSofGbvHKX4QnoH2LbsKh4I3qRjPq8HXRFFO3797Tv1oWvGzgM
         mp/A==
X-Gm-Message-State: ANoB5pk9iVxt50a1CWDwJkAYsDpM7qS2PcrqUsmZjCjSr0TrIvnOIWft
        AzBCnDF/gich92Upgx0ZreeImA==
X-Google-Smtp-Source: AA0mqf7/NAKsEaus8X2OQBW7pJQghogKEDuQQk/ij0P0+nagbr8tCVzFcW3Le+NyQbMM5+Zb+69fwQ==
X-Received: by 2002:a05:600c:18a1:b0:3cf:a9d5:36c7 with SMTP id x33-20020a05600c18a100b003cfa9d536c7mr8256862wmp.13.1668774372729;
        Fri, 18 Nov 2022 04:26:12 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:b10c:1279:a704:75d4])
        by smtp.gmail.com with ESMTPSA id f19-20020a05600c155300b003c6f3e5ba42sm9873958wmg.46.2022.11.18.04.26.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 04:26:12 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, Alex Elder <elder@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-serial@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH 11/15] tty: serial: qcom-geni-serial: stop operations in progress at shutdown
Date:   Fri, 18 Nov 2022 13:25:35 +0100
Message-Id: <20221118122539.384993-12-brgl@bgdev.pl>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221118122539.384993-1-brgl@bgdev.pl>
References: <20221118122539.384993-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

We don't stop transmissions in progress at shutdown. This is fine with
FIFO SE mode but with DMA it causes trouble so fix it now.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/tty/serial/qcom_geni_serial.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index 6a9f3f937f29..091b8f277a04 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -868,6 +868,9 @@ static void get_tx_fifo_size(struct qcom_geni_serial_port *port)
 
 static void qcom_geni_serial_shutdown(struct uart_port *uport)
 {
+	qcom_geni_serial_stop_tx(uport);
+	qcom_geni_serial_stop_rx(uport);
+
 	disable_irq(uport->irq);
 }
 
-- 
2.37.2

