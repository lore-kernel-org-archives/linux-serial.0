Return-Path: <SRS0=6PWm=BR=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF025C433DF
	for <linux-serial@archiver.kernel.org>; Fri,  7 Aug 2020 05:19:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8BD192075A
	for <linux-serial@archiver.kernel.org>; Fri,  7 Aug 2020 05:19:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VyAVOpNi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725900AbgHGFTh (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 7 Aug 2020 01:19:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725845AbgHGFTg (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 7 Aug 2020 01:19:36 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52CB4C061575
        for <linux-serial@vger.kernel.org>; Thu,  6 Aug 2020 22:19:36 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id v15so268493pgh.6
        for <linux-serial@vger.kernel.org>; Thu, 06 Aug 2020 22:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LKoQxM83Uc+FXvx6t5Ymg1IK53B/gKt39Gp0pbNTE/w=;
        b=VyAVOpNiqddmfKMBU5li60da/RuApY8f29CHkpTimPilQ86j/gYbLdXJ1JoEKt6vpD
         d2y9EUvtPB6CzlyDFnlal3mfMmer+GsWBqAAIygnmP1BPWq0yKdn9T5KLNJws9XbR+VJ
         GgtQ18JNlytDCtEX7K8cs1KdMErJEwTQy/v1E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LKoQxM83Uc+FXvx6t5Ymg1IK53B/gKt39Gp0pbNTE/w=;
        b=dPxa6LdCgyVO9rluSsS36M46UBZ6Uc5XlSp+9zvzpLUiV6ui5+F3wOpsaoAdvw9Htu
         yPpk7J9TclxesjmMCZbeubGFu+CVfV8QxhsmDn3teinFiMxay9dzxVr+7FsHg6CeElf3
         LrYcme9tM34N7xTJDtoym2rOGHXCEiBAuAVV/qNBnBuwOrZeNwwp1HSCwUXeBsNhwfLw
         FQDdhYBTR/EuLp1f0gUNe7GDSCKYUo8BZtHT5fAEvFrmMXuKJFnKFhxOrhSuL8zQd0sc
         Gej9pwTMyVphPtLQBSNmWub5fIt04zjKsx77d3q8Zv6ZVdMvH4W4sI8NVhc6h2X1HQZb
         DINA==
X-Gm-Message-State: AOAM533WDPqCRqJLD4L5/QQS3Z3eqG6DzG9LGmgoW8JuhS9gziKwGy0R
        RqSx6dcCQU74lNF9+xb3ubXyBQ==
X-Google-Smtp-Source: ABdhPJyip5WtaSgO5LZF/l7/MXW9QhJe3s0OYmfhC0kSr5YBXvM+tKuZ31k0S09mlDItrxz9IXrAAQ==
X-Received: by 2002:a65:4b85:: with SMTP id t5mr10043682pgq.36.1596777575437;
        Thu, 06 Aug 2020 22:19:35 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:42b0:34ff:fe3d:58e6])
        by smtp.gmail.com with ESMTPSA id r15sm11381147pfq.189.2020.08.06.22.19.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2020 22:19:34 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Akash Asthana <akashast@codeaurora.org>,
        kgdb-bugreport@lists.sourceforge.net,
        Mukesh Savaliya <msavaliy@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Evan Green <evgreen@chromium.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org
Subject: [PATCH] serial: qcom_geni_serial: Fix recent kdb hang
Date:   Thu,  6 Aug 2020 22:19:08 -0700
Message-Id: <20200806221904.1.I4455ff86f0ef5281c2a0cd0a4712db614548a5ca@changeid>
X-Mailer: git-send-email 2.28.0.236.gb10cc79966-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The commit e42d6c3ec0c7 ("serial: qcom_geni_serial: Make kgdb work
even if UART isn't console") worked pretty well and I've been doing a
lot of debugging with it.  However, recently I typed "dmesg" in kdb
and then held the space key down to scroll through the pagination.  My
device hung.  This was repeatable and I found that it was introduced
with the aforementioned commit.

It turns out that there are some strange boundary cases in geni where
in some weird situations it will signal RX_LAST but then will put 0 in
RX_LAST_BYTE.  This means that the entire last FIFO entry is valid.
This weird corner case is handled in qcom_geni_serial_handle_rx()
where you can see that we only honor RX_LAST_BYTE if RX_LAST is set
_and_ RX_LAST_BYTE is non-zero.  If either of these is not true we use
BYTES_PER_FIFO_WORD (4) for the size of the last FIFO word.

Let's fix kgdb.  While at it, also use the proper #define for 4.

Fixes: e42d6c3ec0c7 ("serial: qcom_geni_serial: Make kgdb work even if UART isn't console")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/tty/serial/qcom_geni_serial.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index 07b7b6b05b8b..e27077656939 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -361,11 +361,16 @@ static int qcom_geni_serial_get_char(struct uart_port *uport)
 			return NO_POLL_CHAR;
 
 		if (word_cnt == 1 && (status & RX_LAST))
+			/*
+			 * NOTE: If RX_LAST_BYTE_VALID is 0 it needs to be
+			 * treated as if it was BYTES_PER_FIFO_WORD.
+			 */
 			private_data->poll_cached_bytes_cnt =
 				(status & RX_LAST_BYTE_VALID_MSK) >>
 				RX_LAST_BYTE_VALID_SHFT;
-		else
-			private_data->poll_cached_bytes_cnt = 4;
+
+		if (private_data->poll_cached_bytes_cnt == 0)
+			private_data->poll_cached_bytes_cnt = BYTES_PER_FIFO_WORD;
 
 		private_data->poll_cached_bytes =
 			readl(uport->membase + SE_GENI_RX_FIFOn);
-- 
2.28.0.236.gb10cc79966-goog

