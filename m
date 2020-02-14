Return-Path: <SRS0=POds=4C=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E608EC3B1B7
	for <linux-serial@archiver.kernel.org>; Fri, 14 Feb 2020 18:12:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B179224654
	for <linux-serial@archiver.kernel.org>; Fri, 14 Feb 2020 18:12:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581703931;
	bh=35UpzJrgDYDePnmNfsBeRvzVmSHI48ScrZd/iZ6mBEQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KNL2yj1iV8A5+g/ypU8wF8LPgKQc+7T6HLCIJUKfDHTIb6/Lha1ZdXoMdE/ehjVW0
	 vkG0d2qrcxDaoyaVD3TaYL4nSj+IE81U5rKTnlmltgMVzUEVBDeslPkrqsxpfnImMv
	 EZvN8rAZS1n+2TI+IejxQE0O3nCxN+2r2IkbqvbY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393166AbgBNSMI (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 14 Feb 2020 13:12:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:60640 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731185AbgBNPxP (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 14 Feb 2020 10:53:15 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 03AED24649;
        Fri, 14 Feb 2020 15:53:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581695594;
        bh=35UpzJrgDYDePnmNfsBeRvzVmSHI48ScrZd/iZ6mBEQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HY28/nr41Rgd2i33WIaFuUdrw1T/LS27qJJELwrfe4dEcJxNFYdDVOD5dE2a9LPfv
         MlhQSCGGZpN5ED0qh3GO8IWQqgpbxd6Xtc49CXoRB4I3YA4vDQhJ/Y5xMh08ci00x1
         zvJaune7+HZKfNylfVzrhH5pV3yqfmszFoWpVduM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        Hulk Robot <hulkci@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, linux-serial@vger.kernel.org
Subject: [PATCH AUTOSEL 5.5 200/542] tty: serial: amba-pl011: remove set but unused variable
Date:   Fri, 14 Feb 2020 10:43:12 -0500
Message-Id: <20200214154854.6746-200-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214154854.6746-1-sashal@kernel.org>
References: <20200214154854.6746-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Xiongfeng Wang <wangxiongfeng2@huawei.com>

[ Upstream commit 94345aee285334e9e12fc70572e3d9380791a64e ]

Fix the following warning:
drivers/tty/serial/amba-pl011.c: In function check_apply_cts_event_workaround:
drivers/tty/serial/amba-pl011.c:1461:15: warning: variable dummy_read set but not used [-Wunused-but-set-variable]

The data read is useless and can be dropped.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
Link: https://lore.kernel.org/r/1575619526-34482-1-git-send-email-wangxiongfeng2@huawei.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/serial/amba-pl011.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 4b28134d596a9..c5e9475feb47a 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -1452,8 +1452,6 @@ static void pl011_modem_status(struct uart_amba_port *uap)
 
 static void check_apply_cts_event_workaround(struct uart_amba_port *uap)
 {
-	unsigned int dummy_read;
-
 	if (!uap->vendor->cts_event_workaround)
 		return;
 
@@ -1465,8 +1463,8 @@ static void check_apply_cts_event_workaround(struct uart_amba_port *uap)
 	 * single apb access will incur 2 pclk(133.12Mhz) delay,
 	 * so add 2 dummy reads
 	 */
-	dummy_read = pl011_read(uap, REG_ICR);
-	dummy_read = pl011_read(uap, REG_ICR);
+	pl011_read(uap, REG_ICR);
+	pl011_read(uap, REG_ICR);
 }
 
 static irqreturn_t pl011_int(int irq, void *dev_id)
-- 
2.20.1

