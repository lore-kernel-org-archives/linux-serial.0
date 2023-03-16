Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91231C6FD1F
	for <linux-serial@archiver.kernel.org>; Thu, 16 Mar 2023 20:21:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230284AbjCPUVZ (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 16 Mar 2023 16:21:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229897AbjCPUVX (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 16 Mar 2023 16:21:23 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64351A8C57
        for <linux-serial@vger.kernel.org>; Thu, 16 Mar 2023 13:21:21 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id fy10-20020a17090b020a00b0023b4bcf0727so2828087pjb.0
        for <linux-serial@vger.kernel.org>; Thu, 16 Mar 2023 13:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1678998081;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g57LqyNVPd4QtvwDpadq5p0zhAPNVIWZbBGClF8fQN4=;
        b=TibbCxbyBEZEYx/uzkmczi2osDWuyysnFNb7UXs3hCFZQtiCLHPDBLo+h0TaUIqtSS
         LXN+A7+bVvfxR3164Co4ZTPPvbcvJHJD6RwZamz7cg69L8SZXrOluqktWQwOCjLyhsL1
         VmUKIBoqTGOaQ3RiLfTTD6lsheEfjtiptn5bo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678998081;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g57LqyNVPd4QtvwDpadq5p0zhAPNVIWZbBGClF8fQN4=;
        b=wbNSHUAcL/SzwIyLB2f27mUphvvE+Dzyu9Hm2KejMs8pH9OIoSUGJssRtjrYBzhoGs
         ppvn5t83+r/y5eTogLcWxNiLyw9LsiSAj+99AAXScewwNdV0fKF4CLuruzsyhZdKHsN8
         kvRoeieTikGBWag/Pc+Q+rsDNxNgo7Ktf4DtkURx4NrQqDLG960QdWdMHjvE/X4ccbDk
         SezuIZp3MgyG8gXoLFJkZHifRLNRPb/6BQZor+6Gb1cqlqX3xtOLtoX+NkDq3Ulp0kTX
         lKPdWpURY+Jv59trs8IbtKViqN+tEkGR182ndB2JDKOEaCx1DlsWeTQKZNLl5cn+k8xB
         jgFQ==
X-Gm-Message-State: AO0yUKVpsCUs3z3fpGZGso6555GQu20ElNrk/cIf03lT8lytHV3vPpvm
        uXBuoyFV3lJE1W/1NFJDQUbXmg==
X-Google-Smtp-Source: AK7set9yCaDngXDzLHihTbNxF3zv4vAS5iqalhbZOQqV0PyRM1ANGSN9XbnsR7tHimYz7WJ9Kc71Dw==
X-Received: by 2002:a17:90a:1903:b0:233:76bd:9faa with SMTP id 3-20020a17090a190300b0023376bd9faamr5352705pjg.47.1678998080936;
        Thu, 16 Mar 2023 13:21:20 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:4db6:6f23:6ad2:998d])
        by smtp.gmail.com with ESMTPSA id b4-20020a17090a5a0400b0023acdac248dsm24114pjd.15.2023.03.16.13.21.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 13:21:20 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Bjorn Andersson <andersson@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-arm-msm@vger.kernel.org, Jiri Slaby <jirislaby@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        kgdb-bugreport@lists.sourceforge.net,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-serial@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: [RESEND PATCH 1/2] serial: uart_poll_init() should power on the UART
Date:   Thu, 16 Mar 2023 13:20:56 -0700
Message-Id: <20230316132027.RESEND.1.I106c39498d8094c6f5e7ada42c7db17aa5c64e48@changeid>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
In-Reply-To: <20230316202057.4070382-1-dianders@chromium.org>
References: <20230316202057.4070382-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Qualcomm devices which use the "geni" serial driver, kdb/kgdb won't
be very happy if you use it but the resources of the port haven't been
powered on. Today kdb/kgdb rely on someone else powering the port
on. This could be the normal kernel console or an agetty running.
Let's fix this to explicitly power things on when setting up a polling
driver.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/tty/serial/serial_core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 2bd32c8ece39..b14b5ed6fff4 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -2593,6 +2593,7 @@ static int uart_poll_init(struct tty_driver *driver, int line, char *options)
 {
 	struct uart_driver *drv = driver->driver_state;
 	struct uart_state *state = drv->state + line;
+	enum uart_pm_state pm_state;
 	struct tty_port *tport;
 	struct uart_port *port;
 	int baud = 9600;
@@ -2610,6 +2611,9 @@ static int uart_poll_init(struct tty_driver *driver, int line, char *options)
 		goto out;
 	}
 
+	pm_state = state->pm_state;
+	uart_change_pm(state, UART_PM_STATE_ON);
+
 	if (port->ops->poll_init) {
 		/*
 		 * We don't set initialized as we only initialized the hw,
@@ -2626,6 +2630,8 @@ static int uart_poll_init(struct tty_driver *driver, int line, char *options)
 		console_list_unlock();
 	}
 out:
+	if (ret)
+		uart_change_pm(state, pm_state);
 	mutex_unlock(&tport->mutex);
 	return ret;
 }
-- 
2.40.0.rc1.284.g88254d51c5-goog

