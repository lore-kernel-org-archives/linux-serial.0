Return-Path: <SRS0=t8aj=AV=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3E48C433E6
	for <linux-serial@archiver.kernel.org>; Fri, 10 Jul 2020 14:01:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94141207D0
	for <linux-serial@archiver.kernel.org>; Fri, 10 Jul 2020 14:01:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594389661;
	bh=PPEyjlduSX73sGTB8w2t6qC65mOm8ldTBDB9q0luJ+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oOECDAACisSIpetvKqPIw374dQBt2EcMfrMORFoJYhM/QBTgar5nVAYEyzj938vuj
	 v3WMXpuy0jLW7Mpwy4ptMBSj60LSW9VyHoeuRfUcMxTTKFN/SKxnCXTPNFdHmNr7JB
	 w7HiY4b0tTJbnDnVPqyO/+XZ3iU8ShyEXS+N1SNk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728199AbgGJOA5 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 10 Jul 2020 10:00:57 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:38022 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727941AbgGJOA4 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 10 Jul 2020 10:00:56 -0400
Received: by mail-lj1-f193.google.com with SMTP id 9so6547109ljv.5;
        Fri, 10 Jul 2020 07:00:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=il3aNXnSfFljlaQIw75GtVZGikk49ri9jt/GPUfXTwY=;
        b=Yamf6suShEOv8lB6y9kHaQkm5V/14kYSE7cVsiST6vFu5s1ApZcYzpGyiuYEcRUXyC
         Dzary6W5zqw5QkpdQwyNPsBKNDKeEMTUhhiRUlFaHPgfy+ffSGBukhoVy1LcWgfKpu/x
         H9HKN4BnJxBbiXUCbo25uV0yA4YF34mjc36nqMqctXgcRmjd2W5LgAt+E2EvJtcMpQh5
         b+xAKI2GW+AQNclCJnG8Gk++6M1/zjk1mrAHmVxcACs9hL3IuJiyd08bQoO5kZigFeZA
         a3mTU7Ki4oZuGJ3IBlYF5yIlTh37110XjN0woTC4eR1k9pOB72TZyGCqBTWM6qY2M/jY
         Tr1g==
X-Gm-Message-State: AOAM530LIWf0h9xfGuC/GlHa81Mlnwr83KQ9sAHqdVODEDTw8EB0Gwf7
        H4u9I4D4eaaXDpzuQSKI6VA=
X-Google-Smtp-Source: ABdhPJwdZfLEfezmpdH50F8DcopVGauVYhFedS24MOMWcZUqB2B4VwOqe2EY7M2xeDHYUSxxQRlGwQ==
X-Received: by 2002:a2e:711a:: with SMTP id m26mr38640283ljc.448.1594389653445;
        Fri, 10 Jul 2020 07:00:53 -0700 (PDT)
Received: from xi.terra (c-beaee455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.174.190])
        by smtp.gmail.com with ESMTPSA id v19sm2191240lfi.65.2020.07.10.07.00.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 07:00:52 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.93.0.4)
        (envelope-from <johan@xi.terra>)
        id 1jttaB-0000jV-Ro; Fri, 10 Jul 2020 16:00:55 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Laxman Dewangan <ldewangan@nvidia.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jslaby@suse.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-serial@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>,
        stable <stable@vger.kernel.org>,
        Shardar Shariff Md <smohammed@nvidia.com>,
        Krishna Yarlagadda <kyarlagadda@nvidia.com>
Subject: [PATCH 1/2] serial: tegra: fix CREAD handling for PIO
Date:   Fri, 10 Jul 2020 15:59:46 +0200
Message-Id: <20200710135947.2737-2-johan@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200710135947.2737-1-johan@kernel.org>
References: <20200710135947.2737-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Commit 33ae787b74fc ("serial: tegra: add support to ignore read") added
support for dropping input in case CREAD isn't set, but for PIO the
ignore_status_mask wasn't checked until after the character had been
put in the receive buffer.

Note that the NULL tty-port test is bogus and will be removed by a
follow-on patch.

Fixes: 33ae787b74fc ("serial: tegra: add support to ignore read")
Cc: stable <stable@vger.kernel.org>     # 5.4
Cc: Shardar Shariff Md <smohammed@nvidia.com>
Cc: Krishna Yarlagadda <kyarlagadda@nvidia.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/tty/serial/serial-tegra.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/serial-tegra.c b/drivers/tty/serial/serial-tegra.c
index 8de8bac9c6c7..b3bbee6b6702 100644
--- a/drivers/tty/serial/serial-tegra.c
+++ b/drivers/tty/serial/serial-tegra.c
@@ -653,11 +653,14 @@ static void tegra_uart_handle_rx_pio(struct tegra_uart_port *tup,
 		ch = (unsigned char) tegra_uart_read(tup, UART_RX);
 		tup->uport.icount.rx++;
 
-		if (!uart_handle_sysrq_char(&tup->uport, ch) && tty)
-			tty_insert_flip_char(tty, ch, flag);
+		if (uart_handle_sysrq_char(&tup->uport, ch))
+			continue;
 
 		if (tup->uport.ignore_status_mask & UART_LSR_DR)
 			continue;
+
+		if (tty)
+			tty_insert_flip_char(tty, ch, flag);
 	} while (1);
 }
 
-- 
2.26.2

