Return-Path: <SRS0=QtZL=CZ=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15CD6C433E2
	for <linux-serial@archiver.kernel.org>; Wed, 16 Sep 2020 06:21:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E38BC2067C
	for <linux-serial@archiver.kernel.org>; Wed, 16 Sep 2020 06:21:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726451AbgIPGVH (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 16 Sep 2020 02:21:07 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:12303 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726445AbgIPGVH (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 16 Sep 2020 02:21:07 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 63F7230A5DCB465E5511;
        Wed, 16 Sep 2020 14:21:05 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.487.0; Wed, 16 Sep 2020 14:20:56 +0800
From:   Qinglang Miao <miaoqinglang@huawei.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Benjamin Herrenschmidt" <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
CC:     <linux-serial@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
        <linux-kernel@vger.kernel.org>,
        Qinglang Miao <miaoqinglang@huawei.com>
Subject: [PATCH -next] serial: pmac_zilog: use for_each_child_of_node() macro
Date:   Wed, 16 Sep 2020 14:21:38 +0800
Message-ID: <20200916062138.191188-1-miaoqinglang@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Use for_each_child_of_node() macro instead of open coding it.

Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>
---
 drivers/tty/serial/pmac_zilog.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/pmac_zilog.c b/drivers/tty/serial/pmac_zilog.c
index 96e7aa479..063484b22 100644
--- a/drivers/tty/serial/pmac_zilog.c
+++ b/drivers/tty/serial/pmac_zilog.c
@@ -1644,7 +1644,7 @@ static int __init pmz_probe(void)
 		 * TODO: Add routines with proper locking to do that...
 		 */
 		node_a = node_b = NULL;
-		for (np = NULL; (np = of_get_next_child(node_p, np)) != NULL;) {
+		for_each_child_of_node(node_p, np) {
 			if (of_node_name_prefix(np, "ch-a"))
 				node_a = of_node_get(np);
 			else if (of_node_name_prefix(np, "ch-b"))
-- 
2.23.0

