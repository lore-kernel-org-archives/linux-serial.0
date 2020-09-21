Return-Path: <SRS0=VEyX=C6=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CD02C43464
	for <linux-serial@archiver.kernel.org>; Mon, 21 Sep 2020 08:44:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8B6E20EDD
	for <linux-serial@archiver.kernel.org>; Mon, 21 Sep 2020 08:44:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SqpbR9A9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726515AbgIUIoY (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 21 Sep 2020 04:44:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726211AbgIUIoY (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 21 Sep 2020 04:44:24 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9DC3C061755
        for <linux-serial@vger.kernel.org>; Mon, 21 Sep 2020 01:44:23 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id n25so10386898ljj.4
        for <linux-serial@vger.kernel.org>; Mon, 21 Sep 2020 01:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oAL/WKPZ7s23OJg3BWCOMg9gc+lHrq1mhOgtNGOtHUQ=;
        b=SqpbR9A900d6t/dzimX3edif6/6KOdn/5KmFLzBSFLToFu1QhDYUfweFa4qcLTMO64
         /ukjiSTaV+uzEIXh4ZW9NBRSi9yyrOglaH1Ync7u2XGq6d5szFrJWzcm4cFC9uB2btwW
         3IPewsu0lnRDewQUEFijaYQrlaVDfbzg87ErtThvdWleJaoxeOPe/fyhLCEcV+E/8Xj+
         qK4ReS488/Z4nXriKig6qF+M3+FExn381qhh1n/3JcrBkvsNZ4V9225IMGETh0gRAmpx
         dabPy9NB/ROfS9seVb6tTezne3riuWizesu7smRich7moIitRRIXAGGzOFZ7dUbBjbtf
         qn8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oAL/WKPZ7s23OJg3BWCOMg9gc+lHrq1mhOgtNGOtHUQ=;
        b=RbdV4d0F7VzTp6AoeS5xZdMR7AcADSPeOLKXXFnpKVOx8x0oPLQgRm+dm6Zsry6jxP
         iK8drP+MDg4qr36CsmdAwHEzGYpkv70Q7U8Wzlf1Soxuk6VY7ds+Xfs8XcX8uqV8EuQ8
         n7j7wdWgYRyHKf9ME5oB2SjJUQNyFDBNw5jvMsBUN8U6AKSb7tDoVW4mDeV7UfTznsoy
         7Zx/k+KFPn5/IizY4ZfUCrNG4cYxPO7hUzxiUT3UZi/RgijbwjFbbRK9QJXnAsYXARHe
         cjdvZqLOOVhcVK/sRtwk0z6dyGSdL3xBtCmk6kVX/8eEh386woiZT/Ux2amwWmsWvxdY
         GJgw==
X-Gm-Message-State: AOAM531c3RTiiZt5lVSOkX2i5r1fUG6yPI04KR2qDdBr1ryxk5Nbj9/k
        po9RM9yxGjaB3o+fNL3gkHx4ZibAEQPhLvUU8OU=
X-Google-Smtp-Source: ABdhPJysfYpFz58357z1Dqeuky/srYRjo2jtrHqa+iQ+cLn8WsDp+72w90O+UjPdaN+Zrc1oLzgoxQ==
X-Received: by 2002:a2e:958d:: with SMTP id w13mr15216908ljh.160.1600677861972;
        Mon, 21 Sep 2020 01:44:21 -0700 (PDT)
Received: from localhost.localdomain (110.80-203-69.nextgentel.com. [80.203.69.110])
        by smtp.gmail.com with ESMTPSA id f6sm2388842lfq.211.2020.09.21.01.44.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2020 01:44:21 -0700 (PDT)
From:   drolevar@gmail.com
X-Google-Original-From: aabyzov@slb.com
To:     linux-serial@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, Andrij Abyzov <aabyzov@slb.com>
Subject: [PATCH 0/1] serial: 8250: Fix TX interrupt handling condition in 8250_fsl.c
Date:   Mon, 21 Sep 2020 10:43:12 +0200
Message-Id: <20200921084313.1536884-1-aabyzov@slb.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Andrij Abyzov <aabyzov@slb.com>

This is a port of the commit
db1b5bc047b3cadaedab3826bba82c3d9e023c4b ("Fix TX interrupt handling condition")
to the FSL-specifific interrupt handling routine.

Especially essential in case of RS 485 operation.

Andrij Abyzov (1):
  serial: 8250: Fix TX interrupt handling condition in 8250_fsl.c

 drivers/tty/serial/8250/8250_fsl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.25.1

