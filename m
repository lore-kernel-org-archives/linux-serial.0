Return-Path: <SRS0=2ftc=BC=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6303FC433EB
	for <linux-serial@archiver.kernel.org>; Thu, 23 Jul 2020 12:14:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E6F020709
	for <linux-serial@archiver.kernel.org>; Thu, 23 Jul 2020 12:14:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595506492;
	bh=+5gzCz7uYdk3gVkkcozGWQY4jmwqF+zTsPpz7ug/lyM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qryYgbLfHPQISxV3m9SBL2k5jcRUS5Ub92a0cgigLnCt00Jyjs5jQalfhTZWzly4k
	 AgrF4gSfRPNhA5UCFOF0uXEc4e0lL1AGihqr0jVATip9J+2bPyjMohML65GvUdedIg
	 YP2MOBeWADtjTH4TQeSG5327HNNpRLzS4y+v+rnA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728337AbgGWMOn (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 23 Jul 2020 08:14:43 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:34510 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726666AbgGWMOn (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 23 Jul 2020 08:14:43 -0400
Received: by mail-lj1-f196.google.com with SMTP id q7so6097951ljm.1;
        Thu, 23 Jul 2020 05:14:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o2Q2ecslmSrPMce+fKDFsnvQk/hpWSE7x9fupeYC31o=;
        b=m77uDb3eUHYag/Rskh+2rgbjI15LrQA8SqcUyzqOqvgoJ9rNjZCwdt56nDg8qzkwUj
         JY/7vG0BzSbSz4WYKmfg57fCVFEA3Flnn561oeRDLBxFBkaAqzyDVRxxe9sqeVIpIkno
         csXWItih2XQ9SIoH/KEnLmETscewrIIVmEN8AJFxUEa26WjVuL+4Q0Cewbfln2kcBhmd
         40KTvv8kTtvZDqYXUwRMJhGNboL6etZ+NQytATnuhbspYCMP5eD5bK2XApK20CetsmE0
         /bIWUEqTkjW5Gx0Lp9Qw8bVdd7w3EoeiBDVWTVCiKFFrDHDPHoOUdZEnQgu+YM0hb7Cd
         h60g==
X-Gm-Message-State: AOAM5313GkyyPv5sseBrf1Ur/7CnaUZhviKA/znA7mD+tJX6du+LZppb
        kUfK2y+hRhcJ2ij73bW36yE=
X-Google-Smtp-Source: ABdhPJxHJIr+pGd4bTOrHBPUPPImUVbPT+xKJKpoxO4CXl73afRgTx6kr3oWp4QiO8zaSWTGbY3/yw==
X-Received: by 2002:a2e:97cb:: with SMTP id m11mr1841045ljj.14.1595506481070;
        Thu, 23 Jul 2020 05:14:41 -0700 (PDT)
Received: from xi.terra (c-beaee455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.174.190])
        by smtp.gmail.com with ESMTPSA id g4sm1002603lfh.13.2020.07.23.05.14.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2020 05:14:39 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.93.0.4)
        (envelope-from <johan@xi.terra>)
        id 1jya7O-0006JV-D2; Thu, 23 Jul 2020 14:14:34 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>
Subject: [PATCH 2/2] serial: msm_serial: add sparse context annotation
Date:   Thu, 23 Jul 2020 14:14:23 +0200
Message-Id: <20200723121423.24217-3-johan@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200723121423.24217-1-johan@kernel.org>
References: <20200723121423.24217-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Add sparse context annotation to the receive handlers, which release and
reacquire the port lock, to silence sparse warnings:

	drivers/tty/serial/msm_serial.c:748:25: warning: context imbalance in 'msm_handle_rx_dm' - unexpected unlock
	drivers/tty/serial/msm_serial.c:814:28: warning: context imbalance in 'msm_handle_rx' - unexpected unlock

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/tty/serial/msm_serial.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/tty/serial/msm_serial.c b/drivers/tty/serial/msm_serial.c
index 60a9c53fa7cb..7f26cda5ba1c 100644
--- a/drivers/tty/serial/msm_serial.c
+++ b/drivers/tty/serial/msm_serial.c
@@ -696,6 +696,7 @@ static void msm_enable_ms(struct uart_port *port)
 }
 
 static void msm_handle_rx_dm(struct uart_port *port, unsigned int misr)
+	__must_hold(port->lock)
 {
 	struct tty_port *tport = &port->state->port;
 	unsigned int sr;
@@ -771,6 +772,7 @@ static void msm_handle_rx_dm(struct uart_port *port, unsigned int misr)
 }
 
 static void msm_handle_rx(struct uart_port *port)
+	__must_hold(port->lock)
 {
 	struct tty_port *tport = &port->state->port;
 	unsigned int sr;
-- 
2.26.2

