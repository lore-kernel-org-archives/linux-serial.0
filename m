Return-Path: <SRS0=Gon6=DF=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 384E1C2D0A8
	for <linux-serial@archiver.kernel.org>; Mon, 28 Sep 2020 10:29:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0CCB206C9
	for <linux-serial@archiver.kernel.org>; Mon, 28 Sep 2020 10:29:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d54UMq74"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726513AbgI1K3w (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 28 Sep 2020 06:29:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726497AbgI1K3w (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 28 Sep 2020 06:29:52 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11747C061755
        for <linux-serial@vger.kernel.org>; Mon, 28 Sep 2020 03:29:52 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id u4so566182ljd.10
        for <linux-serial@vger.kernel.org>; Mon, 28 Sep 2020 03:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MNQj7ig3So/lwcBWeYi20m6CQjjU1XhBuSA1cXyk/tA=;
        b=d54UMq747t+ntp06G9X9QkreF8pfn/18g9LWpApHx4do3DqL3RQsXrJeZJg4BTS5cZ
         WaGaIUTNGZMKoeU+fLV/rwECCAtJnlEMLbliNl5K42stbMY2Pyo8g3NgNO5t5dCup+7v
         ejooI7O0ulLulBmiE29nKtUBrfXn3qT3aK2c9omtBFbuAMUKnY+WE6fPQ56tyNJZ+J86
         y6ArbXYv2VdwpbCU6I/QnG0EnJXu7qSdfu6Z7c+yYVhaRO5eCNW5hCKX68GsOcnPSBG+
         dUHJTZyy1kr2f2AF9DAOFL6FzpDXpmyFc2sb6OKZdtlYctN5DZIHmr/2RJBqLCIPE2VD
         IQkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MNQj7ig3So/lwcBWeYi20m6CQjjU1XhBuSA1cXyk/tA=;
        b=oNZpYIQ0irVDCy2wBcEImf5D+ibMNrLFyhekxXotsZ6hGAtnCsGCiIshg9OKSkjs2T
         YAMJUJi8bKcUbdXi2mbDn8Mx9OXvBtYNMHjm5fYyf9R1qvsyfWd101xwpFtCT4yVx0A9
         vxW11+/eybHs1DkObxbNd5Tl1lyd6TfwrcmPZZ4ROi+rE8yuGiw3ORObJxKm68xAeZxY
         vzkHG8UlmOxkIrJEZQpRf4VTxLKlJJDo0XZQJJ47RA6TrYzQOAIbbkPr+5eAhCwvE09k
         6bWmzzFAovpsv6cn0cVrab1/ccHfZkop5/9BxJEFeDdjBHmsEHLe3Shu4zxxDtuY/xdP
         LOIw==
X-Gm-Message-State: AOAM530k5Cau97DPI12RiLhDCyvM/tKFJoAuaZJ0QRbb0faEJTI4pSIK
        m96YyBCRFNoPGMi/lY6l+u+IeICUvS439vuJ
X-Google-Smtp-Source: ABdhPJwQJGsu9LOynuOp+9ihlc/Lsg7T6lOfjF2BwmmVgxAEDZjn3psHDsns8TDiIBgDbeEsoBdmyw==
X-Received: by 2002:a2e:a48b:: with SMTP id h11mr207913lji.109.1601288990254;
        Mon, 28 Sep 2020 03:29:50 -0700 (PDT)
Received: from localhost.localdomain (110.80-203-69.nextgentel.com. [80.203.69.110])
        by smtp.gmail.com with ESMTPSA id p19sm2803078lfc.22.2020.09.28.03.29.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2020 03:29:49 -0700 (PDT)
From:   drolevar@gmail.com
X-Google-Original-From: aabyzov@slb.com
To:     linux-serial@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, Andrij Abyzov <aabyzov@slb.com>
Subject: [PATCH v2 0/1] serial: 8250_fsl: Fix TX interrupt handling condition
Date:   Mon, 28 Sep 2020 12:28:40 +0200
Message-Id: <20200928102841.43782-1-aabyzov@slb.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Andrij Abyzov <aabyzov@slb.com>

This is the port of the commit db1b5bc047b3 ("serial: 8250: Fix TX
interrupt handling condition") to the 8250_fsl irq handling logic.

Especially essential in case of RS 485 operation.

The bug has existed there since 8250_fsl.c was created.

Andrij Abyzov (1):
  serial: 8250_fsl: Fix TX interrupt handling condition

 drivers/tty/serial/8250/8250_fsl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.25.1

