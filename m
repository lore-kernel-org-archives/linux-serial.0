Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EE4CC4321E
	for <linux-serial@archiver.kernel.org>; Tue, 29 Nov 2022 11:01:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232850AbiK2LBp (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 29 Nov 2022 06:01:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232670AbiK2LAt (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 29 Nov 2022 06:00:49 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F48961501
        for <linux-serial@vger.kernel.org>; Tue, 29 Nov 2022 03:00:30 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id x5so21486046wrt.7
        for <linux-serial@vger.kernel.org>; Tue, 29 Nov 2022 03:00:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1ae8HveYcHh2T2XBLR+r4ZEzx3jbK8wRJY72T1zrZRE=;
        b=zs9qEIDKNQLt9OsNEzm5stFfcAJFZLYlEZ6yB4ivjkdmPKQCfM208NpOyM5sF1X/65
         rkry25ss/0gHV7zvrsIYPEoQMfWKM9/GjyqepT0GCr9OinpKLi3RXHdCouq02kJz3nup
         Cfljw853Y67vwVD2kx6zJBEBv4MyaMiLkHLKzSzZ6z7bMhqG+udc8BPVSnNyfFF9d55f
         IRwmEyLUnuY/jrylBUVV1GVeiMek7y4DYyDYYcoblDmUc1oi6KOH2olozbXCtP/GN+Kl
         KCDU/t5slqAEmpCQXY02o+RtwebcbZzke/bhnWdHBgFTOATqxWUfJMvwAX/Xm35TqSaQ
         MZyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1ae8HveYcHh2T2XBLR+r4ZEzx3jbK8wRJY72T1zrZRE=;
        b=bOyJP3Ys9SkYoqqr0kdcpzl2X5FlLxIyncSGkdgwGU50/k45FxDSEUdS0iV9MhUKpm
         JqwHTc9Q9WCmK6WnFPELtkDBF4xrj2JvxQWzm4/mcqHfywYbcvJnIC9iFzsKIYuePuUA
         EpeWFRpFnRXKiU+KGPLCSjAFoXoyJB2TgRR6hF8Z9HFMvN2tJTiLFVtXHoB3u6MzcrKa
         0eRGs0bFWe0SlUYUXI7K+/mMY1ZmYi1Moddd5WXIbICXbacmhlBA1YE56iZMKMsYi+ND
         2zUw6ddy2qhYxQmKBvqJGKSrN7RRPHeQURneSz3oFFYbAeL3Lpux65s7WQWSkZypJO52
         HszQ==
X-Gm-Message-State: ANoB5plJ2vnObHYJkYGfp/qjBxJHTGC2uZZoLaKmiDYWnYyVFMG9YjAx
        D7C3Tyn7ep37bUpWvAVjN/Uaxw==
X-Google-Smtp-Source: AA0mqf5Gfttb2EiqHzKz0Gba0XlVKT934pq/PC605ECHdYITJ9sOp+5hEmiZ8Z0VsfiZblWKTIu4tQ==
X-Received: by 2002:a5d:42d0:0:b0:241:d8e2:868d with SMTP id t16-20020a5d42d0000000b00241d8e2868dmr26645126wrr.671.1669719628529;
        Tue, 29 Nov 2022 03:00:28 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:6b19:1d8e:fbca:fd02])
        by smtp.gmail.com with ESMTPSA id q19-20020a1cf313000000b003a3170a7af9sm1617658wmq.4.2022.11.29.03.00.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Nov 2022 03:00:28 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, Alex Elder <elder@kernel.org>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-serial@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: [PATCH v4 11/13] tty: serial: qcom-geni-serial: stop operations in progress at shutdown
Date:   Tue, 29 Nov 2022 12:00:10 +0100
Message-Id: <20221129110012.224685-12-brgl@bgdev.pl>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221129110012.224685-1-brgl@bgdev.pl>
References: <20221129110012.224685-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

We don't stop transmissions in progress at shutdown. This is fine with
FIFO SE mode but with DMA it causes trouble so fix it now.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/tty/serial/qcom_geni_serial.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index fe15fc0e1345..c0270eec2a66 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -864,6 +864,9 @@ static void get_tx_fifo_size(struct qcom_geni_serial_port *port)
 
 static void qcom_geni_serial_shutdown(struct uart_port *uport)
 {
+	qcom_geni_serial_stop_tx(uport);
+	qcom_geni_serial_stop_rx(uport);
+
 	disable_irq(uport->irq);
 }
 
-- 
2.37.2

