Return-Path: <SRS0=9Zku=3F=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF41AC33CB1
	for <linux-serial@archiver.kernel.org>; Thu, 16 Jan 2020 16:53:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B96C121D56
	for <linux-serial@archiver.kernel.org>; Thu, 16 Jan 2020 16:53:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579193600;
	bh=wSffEsO+b1vvjUW27LhIwKxK2Fejp0AGQVP9VscghFE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1LDYKNoYKgZIZCv17SIXlCMdjhvK0VXixzrEWMYGDwSGAFOiQuaxGES/5X1+2Tk4j
	 9Tf591JRmfKkUqQAyiBPF5JuMl/lHOWd4KvcH1m8XQsh5KPZdyS+c2lTSOG9GuZ+f9
	 jxwcvctAFrnIIT7v9p8AhQ7L15EYcI3A+7lThQ2w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726994AbgAPQxU (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 16 Jan 2020 11:53:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:37166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730749AbgAPQxU (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 16 Jan 2020 11:53:20 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DB2AD22464;
        Thu, 16 Jan 2020 16:53:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579193599;
        bh=wSffEsO+b1vvjUW27LhIwKxK2Fejp0AGQVP9VscghFE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HO2STl7H1/4MGm13LHw4gDcMoS6rKdPieQosykdS0ONXW8dpxMZdHvINxcwfGVFj9
         Fl42Fjc8AncmEevIrio5EX7oBbVygrjC1FZJpPweaQtPmxgfKDHl8wtTDiUQuUZaF8
         4+mT/itf9TDQxLQhODkIbrXKK1ytvDSVnBVGxSBM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Peng Fan <peng.fan@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 5.4 138/205] tty: serial: imx: use the sg count from dma_map_sg
Date:   Thu, 16 Jan 2020 11:41:53 -0500
Message-Id: <20200116164300.6705-138-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116164300.6705-1-sashal@kernel.org>
References: <20200116164300.6705-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

[ Upstream commit 596fd8dffb745afcebc0ec6968e17fe29f02044c ]

The dmaengine_prep_slave_sg needs to use sg count returned
by dma_map_sg, not use sport->dma_tx_nents, because the return
value of dma_map_sg is not always same with "nents".

Fixes: b4cdc8f61beb ("serial: imx: add DMA support for imx6q")
Signed-off-by: Peng Fan <peng.fan@nxp.com>
Link: https://lore.kernel.org/r/1573108875-26530-1-git-send-email-peng.fan@nxp.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/serial/imx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 5e08f2657b90..34f602c3a882 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -619,7 +619,7 @@ static void imx_uart_dma_tx(struct imx_port *sport)
 		dev_err(dev, "DMA mapping error for TX.\n");
 		return;
 	}
-	desc = dmaengine_prep_slave_sg(chan, sgl, sport->dma_tx_nents,
+	desc = dmaengine_prep_slave_sg(chan, sgl, ret,
 					DMA_MEM_TO_DEV, DMA_PREP_INTERRUPT);
 	if (!desc) {
 		dma_unmap_sg(dev, sgl, sport->dma_tx_nents,
-- 
2.20.1

