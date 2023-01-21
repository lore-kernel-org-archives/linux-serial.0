Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6D9EC38159
	for <linux-serial@archiver.kernel.org>; Sat, 21 Jan 2023 15:37:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbjAUPhS (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 21 Jan 2023 10:37:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbjAUPhP (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 21 Jan 2023 10:37:15 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED4E62C64D
        for <linux-serial@vger.kernel.org>; Sat, 21 Jan 2023 07:37:00 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id vw16so20786235ejc.12
        for <linux-serial@vger.kernel.org>; Sat, 21 Jan 2023 07:37:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vxyxFeq00JGhfZF3lbLUVUOmxZ61KQdQmUjeiwFbgw8=;
        b=kldlJnYn61XKUbTLQgEkhyKuWxwTsdBRY9Ll7uOoPNsALXEqmEhVnPDlmerDjm1+SI
         l3TIDs/rQvzlfZ9dQ/8wynXwr/UVjWZHEx+xSCgZ5zSkQof+F1SPm23TTRz6NN56T2uV
         Q4ASxS1ShBnp3YJgSMmwnGvglnU4JbvzSUFPjdAEmUOrAQ3zn82WjqOk4ZlouNJcRChk
         Q0o2cy4DQp5M78/ssbHv1hxuUTPDLivZdvz8vrULXiXmyZgS8aGeMgBwfvbpVLQNngfj
         6gwUUGL50A7Y2ugBbah6TUbNKJU42SjXkr4coaWcVjICxqXqHGjJ2SSAwT9IWQDfhAT4
         zq1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vxyxFeq00JGhfZF3lbLUVUOmxZ61KQdQmUjeiwFbgw8=;
        b=I2fFhqrnFGvZDuMK6B2XgbE855E3JYBpMdtZ5p4VJ7IH+fh4/3u5h7S2CoQy7c3bGD
         h0eUi7SlpTHX8Es5WTwTqDjx5KH5HY8frSK0rMJcNzR030d/71iQN7RHEPixPvsQc7Zm
         2tYdniO3X1vj+aKS3yF8g/oc0uOFAaMSbH4Ss/lK1TCe/utS2605uNMHqLFRqYUkEy+n
         +usHwaLGX8SynUOEDugbk5JrlvGFbHAjDQCt/kb1GVqCWuLip0yUJOlSJX7KBW5aR2uC
         /XOHP1GPtDqcqNzANG7gw9OuFjVHxUHrW+GZVt6nx+wTh5sGasF8K+1zP0VyeZWhVCKV
         NzUg==
X-Gm-Message-State: AFqh2kq2gDhzBNSJl0FZgiOdfcMDj33U7cBjXT6T2iPWLtwXS+OlpYJl
        hrahk1ARQRsT9LcTubU49AfVafrH2kg=
X-Google-Smtp-Source: AMrXdXvonJoeipl/pY2J/CP9AlfUhBFM3gUEP8NtlR3AA0ZkXjY/Wfqosqwf9POkbiMwrcQJ8pE1Zg==
X-Received: by 2002:a17:906:7e0c:b0:877:60b3:3fce with SMTP id e12-20020a1709067e0c00b0087760b33fcemr13894333ejr.45.1674315419081;
        Sat, 21 Jan 2023 07:36:59 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id vc10-20020a170907d08a00b008717a377125sm8187030ejc.85.2023.01.21.07.36.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Jan 2023 07:36:58 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     linux-serial@vger.kernel.org
Cc:     Fabio Estevam <festevam@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Richard Genoud <richard.genoud@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Tim Harvey <tharvey@gateworks.com>,
        =?UTF-8?q?Tomasz=20Mo=C5=84?= <tomasz.mon@camlingroup.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Johan Hovold <johan@kernel.org>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Sherry Sun <sherry.sun@nxp.com>,
        linux-arm-kernel@lists.infradead.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sergey Organov <sorganov@gmail.com>
Subject: [PATCH v1 5/7] serial: imx: remove redundant USR2 read from FIFO reading loop
Date:   Sat, 21 Jan 2023 18:36:37 +0300
Message-Id: <20230121153639.15402-6-sorganov@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230121153639.15402-1-sorganov@gmail.com>
References: <87bko4e65y.fsf@osv.gnss.ru>
 <20230121153639.15402-1-sorganov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

There is no need to read USR2 twice at every loop iteration: get rid of the
second read.

Signed-off-by: Sergey Organov <sorganov@gmail.com>
---
 drivers/tty/serial/imx.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 797c441088a9..af4349fe6970 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -904,7 +904,6 @@ static irqreturn_t __imx_uart_rxint(int irq, void *dev_id)
 
 		rx = imx_uart_readl(sport, URXD0);
 
-		usr2 = imx_uart_readl(sport, USR2);
 		if (usr2 & USR2_BRCD) {
 			imx_uart_writel(sport, USR2_BRCD, USR2);
 			if (uart_handle_break(&sport->port))
-- 
2.30.1

