Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4827BC433F5
	for <linux-serial@archiver.kernel.org>; Thu, 21 Apr 2022 15:25:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390042AbiDUP2G (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 21 Apr 2022 11:28:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390035AbiDUP2F (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 21 Apr 2022 11:28:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0755C15FC2
        for <linux-serial@vger.kernel.org>; Thu, 21 Apr 2022 08:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650554713;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=6ttMoGFApcsmXuI/gPwewnQASmEx+6ID1JuIYA9uETo=;
        b=NaRhRLAhJXD99MNm9C/2l7hse2AMsCa311Fq4RcxUaItIQa68nqxUHue7eF4Wn1ErS800w
        LTTnsMBINrcejebEhGVU3X52tea4zHtMksAL58ripIsvk297DvlHuPZmcclsvvQxLL+0qy
        5dNNX3ao2R6GSTK4TAEWKbaVZWfdplA=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-127-gXI5YgybNB6oXiC_hw4GXQ-1; Thu, 21 Apr 2022 11:25:12 -0400
X-MC-Unique: gXI5YgybNB6oXiC_hw4GXQ-1
Received: by mail-qv1-f70.google.com with SMTP id 33-20020a0c8024000000b0043d17ffb0bdso4178992qva.18
        for <linux-serial@vger.kernel.org>; Thu, 21 Apr 2022 08:25:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6ttMoGFApcsmXuI/gPwewnQASmEx+6ID1JuIYA9uETo=;
        b=uqkAC9DQqGidyAbzJLuJg53g0CoQ61C9VMyz6h+bt2AmL3BY1wgd0f0P6hIZln9HmQ
         sonk4X670C8qc8W320QGKTIpuehKoKUp3vW4Cwxg7bmZktZsnFqnDVpiwUtQDXKQ897c
         +AMcLkoOc0u+hfiKng0o0StRlsgPiU/TqE+A+EvUlUs0JPvIfr2PdoXJUZQaxEmCb/iT
         Zix19fvRNYJbn/bk4JaUWmfQJbMzVEmatvMSdxUgo9uwOs/wnCuUO5umU5ruWuDa4+fE
         asm3xjOOQXwtxDHrQ/uU3eTsN+RF0X/tUDDD3nXIa0YIRmNV+rpggVlW5wcaHo6hE+ML
         V2lw==
X-Gm-Message-State: AOAM531jmhOW59yUkSDba6FvfJUJXD+duel1wZbtddtDu02Zlo1RosxU
        e1InF9L9RFT8GgM5ChYBq031/IPpcSZrrDr2EOkQ6Ms/0NgeuOyFN5bPv6bLPt0/kgIu1juSVgE
        k5/5XjbUjb3+Gz34P/FsMDKjr
X-Received: by 2002:ac8:5e54:0:b0:2f1:f60d:2b3c with SMTP id i20-20020ac85e54000000b002f1f60d2b3cmr16625085qtx.667.1650554711416;
        Thu, 21 Apr 2022 08:25:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz+P77pjFBwONc0Em0QpWeGubtnUdjANuIPyYLPcq0pQgRQocDp9HsSHlVtQWkAJm4cqwGVrA==
X-Received: by 2002:ac8:5e54:0:b0:2f1:f60d:2b3c with SMTP id i20-20020ac85e54000000b002f1f60d2b3cmr16625068qtx.667.1650554711225;
        Thu, 21 Apr 2022 08:25:11 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id 135-20020a37078d000000b0069ea3c7513bsm3109620qkh.121.2022.04.21.08.25.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 08:25:10 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     hammerh0314@gmail.com, gregkh@linuxfoundation.org,
        jirislaby@kernel.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] serial: sunplus-uart: change sunplus_console_ports from global to static
Date:   Thu, 21 Apr 2022 11:25:05 -0400
Message-Id: <20220421152505.1531507-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=trix@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Smatch reports this issue
sunplus-uart.c:501:26: warning: symbol 'sunplus_console_ports' was not declared. Should it be static?

sunplus_console_ports is only used in sunplus-uart.c so change
its storage-class specifier to static

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/tty/serial/sunplus-uart.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/sunplus-uart.c b/drivers/tty/serial/sunplus-uart.c
index 9f15922e681b..60c73662f955 100644
--- a/drivers/tty/serial/sunplus-uart.c
+++ b/drivers/tty/serial/sunplus-uart.c
@@ -498,7 +498,7 @@ static const struct uart_ops sunplus_uart_ops = {
 };
 
 #ifdef CONFIG_SERIAL_SUNPLUS_CONSOLE
-struct sunplus_uart_port *sunplus_console_ports[SUP_UART_NR];
+static struct sunplus_uart_port *sunplus_console_ports[SUP_UART_NR];
 
 static void sunplus_uart_console_putchar(struct uart_port *port,
 					 unsigned char ch)
-- 
2.27.0

