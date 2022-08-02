Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB2DCC19F29
	for <linux-serial@archiver.kernel.org>; Tue,  2 Aug 2022 20:26:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234700AbiHBU0B (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 2 Aug 2022 16:26:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234696AbiHBU0A (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 2 Aug 2022 16:26:00 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CCC61B7A5
        for <linux-serial@vger.kernel.org>; Tue,  2 Aug 2022 13:25:58 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id w17-20020a17090a8a1100b001f326c73df6so14798711pjn.3
        for <linux-serial@vger.kernel.org>; Tue, 02 Aug 2022 13:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=CoI+b4eQNFsd6VQQuo13RXDecKo8nUBlpQJijANZQ6s=;
        b=Y+RkZo92dY20DXfviJHzTDwAdke5hi5C44z6J+p3LKVXAJ6vrpPqaZ9G6Q+uY/D4lC
         eL91bYO3yjzEE3lsZOD+4sMK3fQjxPI58Z91YQ3pnJLpji1GeGFxO2LraWCphbXH01aq
         1rEjFHxwXQtpjvAfEMiD7dBlfMFGCCrP26Z9c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=CoI+b4eQNFsd6VQQuo13RXDecKo8nUBlpQJijANZQ6s=;
        b=1HOK92X44HZbT1tfh9ekT77Igl6adPygoReml8NhjV6Nr9YRLzG4Gn5n3L72174o5U
         bFjD7p4u9HgPqZtSjla64oYF9Aa7uwxpq+NGCrM0EXeD0RDfu/c88rLK6TQvDpihuUDX
         yH7JpYEjDmRYidjHB8VAlrNdpxmHnVolNry72ApILTtLL14H1Pbjbpq+8+PYkX4BIQNP
         rcb7k5mrIUK6u1USYdtU/NJN3hdbyJxSfGj8yAzu2jMk4HFyx9gTgy3toweJMiSpcFGG
         MqDkkM3rdr+wIGegUYAxQsLNvqo8acUgMEgj8zz/kjYTgZxq3EezqsN1x7utmOgioLh3
         Y0Xw==
X-Gm-Message-State: ACgBeo0GP1IasB4XS+U+isT2dJLlwLuKvaISKbEP5BHFk8QFv6ft3nOq
        DP2IKCrsOHAUyAFVzafzHGZ6HA==
X-Google-Smtp-Source: AA6agR7yo2KwaNw92YLINt7gWmsCTI+mo2MZ2MCjpy8dYhL8FxAdIHrB/P6FFqBUXj26A0eGAdRGIg==
X-Received: by 2002:a17:90b:4b0a:b0:1f2:a904:8af7 with SMTP id lx10-20020a17090b4b0a00b001f2a9048af7mr1288188pjb.76.1659471958100;
        Tue, 02 Aug 2022 13:25:58 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:201:31c9:9937:c6bb:62f5])
        by smtp.gmail.com with ESMTPSA id b66-20020a621b45000000b0052d50e14f1dsm5794435pfb.78.2022.08.02.13.25.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 13:25:57 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org
Subject: [PATCH] tty: serial: qcom-geni-serial: Fix %lu -> %u in print statements
Date:   Tue,  2 Aug 2022 13:23:09 -0700
Message-Id: <20220802132250.1.Iea061e14157a17e114dbe2eca764568a02d6b889@changeid>
X-Mailer: git-send-email 2.37.1.455.g008518b4e5-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

When we multiply an unsigned int by a u32 we still end up with an
unsigned int. That means we should specify "%u" not "%lu" in the
format code.

NOTE: this fix was chosen instead of somehow promoting the value to
"unsigned long" since the max baud rate from the earlier call to
uart_get_baud_rate() is 4000000 and the max sampling rate is 32.
4000000 * 32 = 0x07a12000, not even close to overflowing 32-bits.

Fixes: c474c775716e ("tty: serial: qcom-geni-serial: Fix get_clk_div_rate() which otherwise could return a sub-optimal clock rate.")
Reported-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/tty/serial/qcom_geni_serial.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index f754619451dc..f7c1f1807040 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -1033,12 +1033,12 @@ static void qcom_geni_serial_set_termios(struct uart_port *uport,
 		sampling_rate, &clk_div);
 	if (!clk_rate) {
 		dev_err(port->se.dev,
-			"Couldn't find suitable clock rate for %lu\n",
+			"Couldn't find suitable clock rate for %u\n",
 			baud * sampling_rate);
 		goto out_restart_rx;
 	}
 
-	dev_dbg(port->se.dev, "desired_rate-%lu, clk_rate-%lu, clk_div-%u\n",
+	dev_dbg(port->se.dev, "desired_rate-%u, clk_rate-%lu, clk_div-%u\n",
 			baud * sampling_rate, clk_rate, clk_div);
 
 	uport->uartclk = clk_rate;
-- 
2.37.1.455.g008518b4e5-goog

