Return-Path: <SRS0=zL5S=3D=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6916C33C9E
	for <linux-serial@archiver.kernel.org>; Tue, 14 Jan 2020 17:19:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCF2324672
	for <linux-serial@archiver.kernel.org>; Tue, 14 Jan 2020 17:19:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="ilSXUDFD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728835AbgANRTg (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 14 Jan 2020 12:19:36 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38582 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728803AbgANRTd (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 14 Jan 2020 12:19:33 -0500
Received: by mail-pg1-f196.google.com with SMTP id a33so6687011pgm.5
        for <linux-serial@vger.kernel.org>; Tue, 14 Jan 2020 09:19:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PPgVMonOcdM57HwQjNiOnHBUxZ/HQQfXgRFmsrSTIew=;
        b=ilSXUDFDHyCbuY1w0IiNI3kljKZzhJynp99eKfU0tUXQnyjpoqCNs7VJh7pEIfc2jd
         ebiQFoEb4/T1BPPzRWM3ZgjEg312rOeox4Hc0mslWvfdcfJIL1HxjQEj30rplCSjATuM
         tTT1kkRlrRUrJP5l1UMX0e8+k7GZygrx8eJtz7pQkJoalycRdr0hKR0IB95zjPUueQUi
         2MzGFp8Z8B+r6PALAIjr5v0n7yKDERoyC1TipwnloVhbjtHcDtqUJxgOzuN0TrEwz4i7
         fIyBEn+R5yEBmzSpblnVhkooVakV4AfSVAlGAWtA/3loEudq2JpIaOg42hS0mSS+ksZ+
         /oOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PPgVMonOcdM57HwQjNiOnHBUxZ/HQQfXgRFmsrSTIew=;
        b=hyTyC7x4kxTI/iEUbOYYfTpFm0XapxgBNd2a8SeE4iS8qf7L0X/m4NxoUbC0fc5vqj
         jPt3MAakoGy4zHGYmkLGly3744kTfTKRTOaLKyZmUVPLsvTl0NR00baHVUhRyMKkQw64
         OKTvODEzGRMc90him37tz2X6vYW/MPHpsbYvIC4P16Lipu0k8azmlhMd7R6gIs6VDzSM
         zAiSa8VSE82BllZ6YEOA9hin0pOlhc4XvpAoPkMeF1apIRwOcDX9nt0/ttPLvF2+VRna
         ifYAxf+uHsydDMheSOK4xCdLKr0CLuIqoOGsRF1TKVXEHM8tpQMD0d7te8aWQLrLFUEp
         2uRQ==
X-Gm-Message-State: APjAAAVSR0Vnrw/aZp1elmpjUWyaRnqxRQUpGSXeAm3j9Y3gwEv/CMZK
        /fXmcSF3yDuIg4uutKNhzOGrYw==
X-Google-Smtp-Source: APXvYqxsy6l6VeqL2CU6oyfD/xKGx5UZSw7DtMac4Ux8LUDH0cE2aK7ZIYhE7dzWV45jYCEKa5BQWA==
X-Received: by 2002:a63:f202:: with SMTP id v2mr27669125pgh.420.1579022373004;
        Tue, 14 Jan 2020 09:19:33 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id m128sm18965687pfm.183.2020.01.14.09.19.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2020 09:19:32 -0800 (PST)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Jiri Slaby <jslaby@suse.com>, Joe Perches <joe@perches.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Vasiliy Khoruzhick <vasilykh@arista.com>,
        linux-serial@vger.kernel.org
Subject: [PATCHv2-next 3/3] serial_core: Remove unused member in uart_port
Date:   Tue, 14 Jan 2020 17:19:12 +0000
Message-Id: <20200114171912.261787-4-dima@arista.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200114171912.261787-1-dima@arista.com>
References: <20200114171912.261787-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

It should remove the align-padding before @name.

Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 include/linux/serial_core.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index 9e0b66278430..1f4443db5474 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -247,7 +247,6 @@ struct uart_port {
 
 	unsigned char		hub6;			/* this should be in the 8250 driver */
 	unsigned char		suspended;
-	unsigned char		unused;
 	const char		*name;			/* port name */
 	struct attribute_group	*attr_group;		/* port specific attributes */
 	const struct attribute_group **tty_groups;	/* all attributes (serial core use only) */
-- 
2.24.1

