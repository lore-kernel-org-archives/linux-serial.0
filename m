Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC5DBC433EF
	for <linux-serial@archiver.kernel.org>; Thu,  4 Nov 2021 11:48:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D426A61205
	for <linux-serial@archiver.kernel.org>; Thu,  4 Nov 2021 11:48:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231388AbhKDLum (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 4 Nov 2021 07:50:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbhKDLul (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 4 Nov 2021 07:50:41 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF74EC061714;
        Thu,  4 Nov 2021 04:48:03 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id h14so3789417qtb.3;
        Thu, 04 Nov 2021 04:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PdowUE+txHFKqxZ9G9alg9aKUaAkTecpGwT4qv6lwxw=;
        b=WIDxbb6eQAjNWl4DFkHaw/n76DzT3eBXIwGKCuu8e8aTIDfxmL5SNS52BICHET/lAA
         RnLfSKwidQPFryty2aV6MrLrO66zw0a5FB9cv3MGFfmH00Pd+UAliKs9X7Zw0coZBVTe
         QON7+VnpSQBxgoUoeppC4YWJPNAb2cQIQA7/nPsSU12PnvzsKuSm1nqzpNXlzHPv9v+l
         SdSufhSFnZ9h8g4B8lcPx+SEBvJBYfkG0G7zG/yDO0mL2ISmjL1DVT8y+M8XoefPLze/
         TXQgf9q6P0NmVBusCHx5n3zLlO814rcjbl2f8m8r3m3tImb0mb1qZOP0+xkgdihfi/Qp
         NWoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PdowUE+txHFKqxZ9G9alg9aKUaAkTecpGwT4qv6lwxw=;
        b=WLkwRq6ETE6B/tubSxlRN2DKpc5kh9o1ti+2a9pmIduZAVzw00axqsuAq5XB1mno8U
         7o9KjS6UvdUM59la8XEOOpUKSEraphWWFWpkWwzXR/ijMOX7uIpN5OkBO634bCeFyCc6
         axX5EGqc+xz+iqRXdq1Z6HBt330ZSHAn+63UzUNAWpShWydOwgohgKnBR0TpcjOZgYi9
         zcTHf3653QJJ6Xuj75wMfnP9EK157Vu0KXTnLKq5IaRHdtxSk4XLhRxMhgwV19mpJ3L7
         GaiFVyTK8vrbLr+IaFQBBv6U4vKYmd7uul3ucCdySzwBuGMx/CYWHG0piq3rdTR12QhZ
         T3qA==
X-Gm-Message-State: AOAM530nzFS0zA2IB1gsU93BN+GsJppTYFEH/LGMswQkHFjBnGkpJQzr
        eYB6/X9Kpi74oOVJJrHsQVU=
X-Google-Smtp-Source: ABdhPJwXsegp2d+MOEYt0DIqyRkxSeuCvWKpyMlOGD2ks6X5oU6l7v+9mZjqMdmypPTkzG5F2i+lEQ==
X-Received: by 2002:a05:622a:607:: with SMTP id z7mr17500336qta.237.1636026483078;
        Thu, 04 Nov 2021 04:48:03 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id y8sm3794776qtx.0.2021.11.04.04.47.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Nov 2021 04:48:02 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: yao.jing2@zte.com.cn
To:     johan@kernel.org
Cc:     andrew@aj.id.au, cgel.zte@gmail.com, fancer.lancer@gmail.com,
        gregkh@linuxfoundation.org, jirislaby@kernel.org, joe@perches.com,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        macro@orcam.me.uk, pali@kernel.org, yao.jing2@zte.com.cn,
        zealci@zte.com.cn
Subject: [PATCH v3] serial: 8250: replace snprintf in show functions with sysfs_emit
Date:   Thu,  4 Nov 2021 11:47:54 +0000
Message-Id: <20211104114754.30983-1-yao.jing2@zte.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <YYDsU778y71byGdj@hovoldconsulting.com>
References: <YYDsU778y71byGdj@hovoldconsulting.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Jing Yao <yao.jing2@zte.com.cn>

coccicheck complains about the use of snprintf() in sysfs show
functions:
WARNING use scnprintf or sprintf

Use sysfs_emit instead of scnprintf or sprintf makes more sense.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Jing Yao <yao.jing2@zte.com.cn>
---

Changes since v1 & v2:
 - Remove excess and wrong parameter 'PAGE_SIZE' in sysfs_emit function.
 - Revise the wrong patch Subject.

 drivers/tty/serial/8250/8250_port.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 5775cbff8f6e..3d58f383152e 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -3099,7 +3099,7 @@ static ssize_t rx_trig_bytes_show(struct device *dev,
 	if (rxtrig_bytes < 0)
 		return rxtrig_bytes;
 
-	return snprintf(buf, PAGE_SIZE, "%d\n", rxtrig_bytes);
+	return sysfs_emit(buf, "%d\n", rxtrig_bytes);
 }
 
 static int do_set_rxtrig(struct tty_port *port, unsigned char bytes)
-- 
2.25.1

