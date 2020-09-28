Return-Path: <SRS0=Gon6=DF=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 515AAC2D0A8
	for <linux-serial@archiver.kernel.org>; Mon, 28 Sep 2020 15:26:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 025BA2100A
	for <linux-serial@archiver.kernel.org>; Mon, 28 Sep 2020 15:26:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=slb.com header.i=@slb.com header.b="otiF9E5N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726504AbgI1P0d (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 28 Sep 2020 11:26:33 -0400
Received: from mta4.mail.slb.com ([136.252.134.183]:42038 "EHLO
        mta4.mail.slb.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726420AbgI1P0d (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 28 Sep 2020 11:26:33 -0400
X-Greylist: delayed 2678 seconds by postgrey-1.27 at vger.kernel.org; Mon, 28 Sep 2020 11:26:32 EDT
Received: from pps.filterd (nl0123vsmpps03.mail.slb.com [127.0.0.1])
        by nl0123vsmpps03.mail.slb.com (8.16.0.42/8.16.0.42) with SMTP id 08SEbUgi004201;
        Mon, 28 Sep 2020 14:41:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=slb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding;
 s=20180320pps; bh=2NP/juTKwiyJVKvrdhJFoVznWxCv0S4QYDJZAkH6ibE=;
 b=otiF9E5NaDbFUaw2vsP40gr9QNXYpHlWDEsac/yivj7Wx1TWssH5wffOl4WTC0h53oKm
 cXNps7HnPZZPCcXnR+rkA6ys/c6I1fDXZPi4GeettX40ogWhuSueOl2O6cQPjfbKWd6v
 tijzq6QsHnOKcQQXkzZqoVUETGWfCcjCFaF0tfCzsO3HimZulLIMfJ1chbcM2Tyuecwl
 R7UyrMlfYTa2R+bm9m+sjCdWYJ5ufp4kjh73l6bWLMzVyJ18rTCTn8gUpKQd4o7jXTf6
 4UYFqhBZddqBnaPnoYQhuaWRBi1q8UkdiRFpZMX05osaknEtWwkpmQyN2lJlN9M760PF ag== 
Received: from pps.reinject (localhost [127.0.0.1])
        by nl0123vsmpps03.mail.slb.com with ESMTP id 33uhn3r0r6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Sep 2020 14:41:52 +0000
Received: from nl0123vsmpps03.mail.slb.com (nl0123vsmpps03.mail.slb.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 08SEfqUm017946;
        Mon, 28 Sep 2020 14:41:52 GMT
Received: from mmsbuildserver2.dir.slb.com (mmsbuildserver2.bergen-no0137.slb.com [136.254.53.89])
        by nl0123vsmpps03.mail.slb.com with ESMTP id 33uhn3r0r4-1;
        Mon, 28 Sep 2020 14:41:52 +0000
From:   Andrij Abyzov <aabyzov@slb.com>
To:     linux-serial@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, Andrij Abyzov <aabyzov@slb.com>
Subject: [PATCH v3] serial: 8250_fsl: Fix TX interrupt handling condition
Date:   Mon, 28 Sep 2020 16:41:27 +0200
Message-Id: <20200928144127.87156-1-aabyzov@slb.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-28_14:2020-09-28,2020-09-28 signatures=0
X-Proofpoint-Spam-Details: rule=int_spam_policy_notspam policy=int_spam_policy score=0 impostorscore=0
 mlxlogscore=921 bulkscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 phishscore=0 clxscore=1011 suspectscore=0 spamscore=0
 mlxscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009280117
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

This is the port of the commit db1b5bc047b3 ("serial: 8250: Fix TX
interrupt handling condition") to the 8250_fsl irq handling logic.

Interrupt handler checked THRE bit (transmitter holding register
empty) in LSR to detect if TX fifo is empty.
In case when there is only receive interrupts the TX handling
got called because THRE bit in LSR is set when there is no
transmission (FIFO empty). TX handling caused TX stop, which in
RS-485 half-duplex mode actually resets receiver FIFO. This is not
desired during reception because of possible data loss.

The fix is to check if THRI is set in IER in addition of the TX
fifo status. THRI in IER is set when TX is started and cleared
when TX is stopped.
This ensures that TX handling is only called when there is really
transmission on going and an interrupt for THRE and not when there
are only RX interrupts.

Signed-off-by: Andrij Abyzov <aabyzov@slb.com>
---
Changes in v3:
    - Added change history
Changes in v2:
    - Rewritten commit description

 drivers/tty/serial/8250/8250_fsl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_fsl.c b/drivers/tty/serial/8250/8250_fsl.c
index 0d0c80905c58..ceac6cfce4c7 100644
--- a/drivers/tty/serial/8250/8250_fsl.c
+++ b/drivers/tty/serial/8250/8250_fsl.c
@@ -71,7 +71,7 @@ int fsl8250_handle_irq(struct uart_port *port)
 
 	serial8250_modem_status(up);
 
-	if (lsr & UART_LSR_THRE)
+	if ((lsr & UART_LSR_THRE) && (up->ier & UART_IER_THRI))
 		serial8250_tx_chars(up);
 
 	up->lsr_saved_flags = orig_lsr;
-- 
2.25.1

