Return-Path: <SRS0=Qqcb=2Z=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33AC2C32770
	for <linux-serial@archiver.kernel.org>; Sat,  4 Jan 2020 15:23:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A2A424653
	for <linux-serial@archiver.kernel.org>; Sat,  4 Jan 2020 15:23:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578151380;
	bh=dFWlPdvaj+HyEUx1AlXxNrrcbYfk6tTvTj6iCncs5hE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WMTB5OEc2Ubj0KGf3bqu+P9SJpuZNQ6cxFs8hu/niHawDCo9b6VaonBel8k6/8yD0
	 nqsyxNlSMit1ql58GMoHeJ0IyiQjivx2OHL643cgnZwdPTySve99iM2JD46yBgM4+f
	 DF+HTeVRzYhuAxuGSI6si635Jptj99fF8DgbabCc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727273AbgADPW7 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 4 Jan 2020 10:22:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:33016 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727264AbgADPW6 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Sat, 4 Jan 2020 10:22:58 -0500
Received: from localhost.localdomain (unknown [194.230.155.149])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A7CB624655;
        Sat,  4 Jan 2020 15:22:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578151377;
        bh=dFWlPdvaj+HyEUx1AlXxNrrcbYfk6tTvTj6iCncs5hE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TukjCOOKq4PkKRi8vkwrxL9bdxlHUVtF9N73U3DryerWdgdasynoTuytdBsZQDN17
         EYNr/bBwzICmaYPXdAiN3vop/NO0ofN3+iVvQI5JnJAOmPB25t36y+jyes1c6feWe7
         xJK6TeRjXA7YrZ44GqNyMFizNMibFTN3i0DksDdA=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [PATCH v2 17/20] serial: samsung: Rename Exynos to lowercase
Date:   Sat,  4 Jan 2020 16:21:04 +0100
Message-Id: <20200104152107.11407-18-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200104152107.11407-1-krzk@kernel.org>
References: <20200104152107.11407-1-krzk@kernel.org>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Fix up inconsistent usage of upper and lowercase letters in "Exynos"
name.

"EXYNOS" is not an abbreviation but a regular trademarked name.
Therefore it should be written with lowercase letters starting with
capital letter.

The lowercase "Exynos" name is promoted by its manufacturer Samsung
Electronics Co., Ltd., in advertisement materials and on website.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/tty/serial/samsung_tty.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
index 4762c74dbc35..73f951d65b93 100644
--- a/drivers/tty/serial/samsung_tty.c
+++ b/drivers/tty/serial/samsung_tty.c
@@ -2665,7 +2665,7 @@ OF_EARLYCON_DECLARE(s3c2440, "samsung,s3c2440-uart",
 OF_EARLYCON_DECLARE(s3c6400, "samsung,s3c6400-uart",
 			s3c2440_early_console_setup);
 
-/* S5PV210, EXYNOS */
+/* S5PV210, Exynos */
 static struct samsung_early_console_data s5pv210_early_console_data = {
 	.txfull_mask = S5PV210_UFSTAT_TXFULL,
 };
-- 
2.17.1

