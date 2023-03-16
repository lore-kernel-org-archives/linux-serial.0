Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0825FC7618E
	for <linux-serial@archiver.kernel.org>; Thu, 16 Mar 2023 20:21:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbjCPUV2 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 16 Mar 2023 16:21:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230266AbjCPUVY (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 16 Mar 2023 16:21:24 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A516733A7
        for <linux-serial@vger.kernel.org>; Thu, 16 Mar 2023 13:21:23 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id j3-20020a17090adc8300b0023d09aea4a6so6659376pjv.5
        for <linux-serial@vger.kernel.org>; Thu, 16 Mar 2023 13:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1678998083;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R7uYBq/r2MM26gN/T+YojigH2qsAcwEwpy934F/qkEQ=;
        b=BJIzhXdI1s5gzEG0m+7jSYgDrDB2Cv3jwayVk4kqbzV9tbFk9R3GGCEwVuyfc6mlrD
         KpM3I806ejLxxNf4tfemT2g38pET3WVqkOcawWyOrA/AXqin5PDGFZ6+htFTWvwHtO6Y
         KS6NTWUEKJ8Gpx1hurGHVnAHy/QsDGjxzy9CM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678998083;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R7uYBq/r2MM26gN/T+YojigH2qsAcwEwpy934F/qkEQ=;
        b=tvchb7uu18kAJ0pgzT6YvHVMhm4RVGBahMHHqcOKg7LJP4wqDh3GE/aM3lWuPaC7MW
         MrlKfnUq7JWHnmvjdikbS+T5Su6vK5d7MTj6ML13ZxZdxzxNfeqBGLLTYZwnR2Vbu5Vr
         agbiUNqti7VRZ5v1/TE7uPQZ41mqdnOF/Gx3JiB3d3EnPw9AyziOyuZ8hZDxGK57/BTH
         lg5zKioulEvAzhefR1y4QHbPTgkmfgmHRJW9V/xtsfyATCsjqT6wFXkaINsGimTdli/R
         lmrtAwueWdyKvkhYK0yW5qlEj1/7mc8wl1A3OXpXfc2kgYCA56O4J/tYmIN5ypNV35JX
         9/ew==
X-Gm-Message-State: AO0yUKWRIGjXd6ewPhN6Gm7aohE1Ms+RlsvgEKvUt4ngY+8XKpM1ITdx
        Ydq5vsWnYhd0/ofBWl2WBdgL0Q==
X-Google-Smtp-Source: AK7set8U+8u0pAReOkw3SQcSNQaY6unkcGqSXoWSlafTmIws3G0+lrdPTp5NRIJ1P1F3tRAnfoo8wQ==
X-Received: by 2002:a17:90b:3850:b0:234:118d:b1b1 with SMTP id nl16-20020a17090b385000b00234118db1b1mr4760801pjb.48.1678998082769;
        Thu, 16 Mar 2023 13:21:22 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:4db6:6f23:6ad2:998d])
        by smtp.gmail.com with ESMTPSA id b4-20020a17090a5a0400b0023acdac248dsm24114pjd.15.2023.03.16.13.21.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 13:21:22 -0700 (PDT)
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
        Andy Gross <agross@kernel.org>, linux-kernel@vger.kernel.org
Subject: [RESEND PATCH 2/2] tty: serial: qcom-geni-serial: Add a poll_init() function
Date:   Thu, 16 Mar 2023 13:20:57 -0700
Message-Id: <20230316132027.RESEND.2.Ie678853bb101091afe78cc8c22344bf3ff3aed74@changeid>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
In-Reply-To: <20230316202057.4070382-1-dianders@chromium.org>
References: <20230316202057.4070382-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On sc7180 Chromebooks, I did the following:
* Didn't enable earlycon in the kernel command line.
* Didn't enable serial console in the kernel command line.
* Didn't enable an agetty or any other client of "/dev/ttyMSM0".
* Added "kgdboc=ttyMSM0" to the kernel command line.

After I did that, I tried to enter kdb with this command over an ssh
session:
  echo g > /proc/sysrq-trigger

When I did that the system just hung.

Although I thought I'd tested this scenario before, I couldn't go back
and find a time when it was working. Previous testing must have relied
on either the UART acting as the kernel console or an agetty running.

It turns out to be pretty easy to fix: we can just use
qcom_geni_serial_port_setup() as the .poll_init() function. This,
together with the patch ("serial: uart_poll_init() should power on the
UART"), allows the debugger to work even if there are no other users
of the serial port.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/tty/serial/qcom_geni_serial.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index d69592e5e2ec..7fdb3e12846d 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -1532,6 +1532,7 @@ static const struct uart_ops qcom_geni_console_pops = {
 #ifdef CONFIG_CONSOLE_POLL
 	.poll_get_char	= qcom_geni_serial_get_char,
 	.poll_put_char	= qcom_geni_serial_poll_put_char,
+	.poll_init = qcom_geni_serial_port_setup,
 #endif
 	.pm = qcom_geni_serial_pm,
 };
-- 
2.40.0.rc1.284.g88254d51c5-goog

