Return-Path: <SRS0=dMzY=CU=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31EEDC433E2
	for <linux-serial@archiver.kernel.org>; Fri, 11 Sep 2020 17:08:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D012D221EB
	for <linux-serial@archiver.kernel.org>; Fri, 11 Sep 2020 17:08:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IpnVtLgd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725871AbgIKRIG (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 11 Sep 2020 13:08:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726277AbgIKPCE (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 11 Sep 2020 11:02:04 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E71FBC06135B
        for <linux-serial@vger.kernel.org>; Fri, 11 Sep 2020 08:01:26 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id o20so7528084pfp.11
        for <linux-serial@vger.kernel.org>; Fri, 11 Sep 2020 08:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AFJYLvWtKd0gWhl3s1dZJrARfNTei6xcNX2ZyXTTyO0=;
        b=IpnVtLgdVGxhyuhCaS3cPthT9iWbMsqXgb/fu9cWcyRQ9WBj7UKn73b4/hSmaDNGdT
         vbToscSU7CgC3GpktUaHD1tHLwWiHiumDKkD1k3t6SGJNRVP5UsQYkKbEqb1wCTOYpTj
         Sv++5PX7M5QblxUKx6v415lGt6T8zSYIy8yNA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AFJYLvWtKd0gWhl3s1dZJrARfNTei6xcNX2ZyXTTyO0=;
        b=qgRutWxeJCZowOXrJ/uVQO5kshjj+c3xjZjlV1Qtk2P2uBpOTbrgP5ATQPPlR1rB/w
         dFE3PxXuz6qKghNleRcHemQBxtMzVz3BmuQaBZNEGBQ2OJeJ/rdkeXpUWLV4r9RwYOSL
         x0NKT8rP7/koFXuDbmp1NMVeEOuOoHsC+qiOjfigQqnvwGpQ+HYTGQEmfUsao9DKL86w
         PJjDoBrvzH8mBn027ocev3sQHY0osx8DkRqOYx9I2wrUijowfBl4GMAomqTcO8Putn4t
         lJs1J/DsGVZy+ZJRTNKB+CYJUjwBIIIqqzJKyYDjPBw8+BxMs4gHE2fySZknxvgEKKzF
         xiBg==
X-Gm-Message-State: AOAM533jRBJsTKca5GfNccSrpVAB2BHiPgsWGGEr/c1XV9n88k1uOrs9
        0sslKJnhrjGNROG8rQEUFB2mNg==
X-Google-Smtp-Source: ABdhPJxR0SrJk8qEMtS/78b14//HJcWkWdb22wVtMM6VdsZAhtXPxe9ZkJhbyfNjy2GKsy5A3IFXxw==
X-Received: by 2002:a17:902:123:: with SMTP id 32mr2248956plb.143.1599836486326;
        Fri, 11 Sep 2020 08:01:26 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:42b0:34ff:fe3d:58e6])
        by smtp.gmail.com with ESMTPSA id v91sm2657228pjv.12.2020.09.11.08.01.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2020 08:01:25 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>, robdclark@chromium.org,
        Akash Asthana <akashast@codeaurora.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        jwerner@chromium.org, Douglas Anderson <dianders@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org
Subject: [PATCH] tty: serial: qcom_geni_serial: 115.2 is a better console default than 9600
Date:   Fri, 11 Sep 2020 08:00:57 -0700
Message-Id: <20200911080054.1.I4c00b921c2f17b6988688046fa7be0f729f8d591@changeid>
X-Mailer: git-send-email 2.28.0.618.gf4bc123cb7-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Commit c5cbc78acf69 ("tty: serial: qcom_geni_serial: Initialize baud
in qcom_geni_console_setup") fixed a bug by initting a variable that
was used in some cases without initialization.  However, the "default"
baud rate picked by that CL was probably not the best choice.  The
chances that anyone out there is trying to run a system with kernel
messages piped out over a 9600 baud serial port is just about nil.
Console messages are printed in a blocking manner.  At 9600 baud we
print about 1 character per millisecond which means that printing a
40-byte message to the console will take ~40 ms.  While it would
probably work, it's going to make boot _very_ slow and probably cause
the occasional timeout here and there in drivers (heck, even at 115200
console delays can wreck havoc).

This has already bit at least two people that I'm aware of that tried
to enable serial console by just adding "console=ttyMSM0" (instead of
"console=ttyMSM0,115200n8") to the command line, so it seems like it'd
be nice to fix.

Let's switch the default to 115200.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/tty/serial/qcom_geni_serial.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index f0b1b47c3abc..e390ffc8bbbd 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -1107,7 +1107,7 @@ static int qcom_geni_console_setup(struct console *co, char *options)
 {
 	struct uart_port *uport;
 	struct qcom_geni_serial_port *port;
-	int baud = 9600;
+	int baud = 115200;
 	int bits = 8;
 	int parity = 'n';
 	int flow = 'n';
-- 
2.28.0.618.gf4bc123cb7-goog

