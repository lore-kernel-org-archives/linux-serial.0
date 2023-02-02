Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3601FC05027
	for <linux-serial@archiver.kernel.org>; Thu,  2 Feb 2023 22:29:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232466AbjBBW2n (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 2 Feb 2023 17:28:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233245AbjBBW20 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 2 Feb 2023 17:28:26 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36C072BF2B
        for <linux-serial@vger.kernel.org>; Thu,  2 Feb 2023 14:28:22 -0800 (PST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 312LfxA0015192;
        Thu, 2 Feb 2023 22:28:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=9szCe/pMSxH3ejAhsLxrEZP38yMrVIthoS8DpxwfO28=;
 b=Bg4z7aM4Oue1yDsx7/PbP5p5l9X7Z5sXrDWxrAO0hpdx8i9C2q8PzgfE79L9ssnnGP9M
 snHFQCm+hLfX+rbPDFhTZEmf/+Rs2J16qqEjUpxwlUnK5BARBMm46274qC7z82HKWA1C
 WWr8m3X7BYMT5RZsA3WEAUGd9TuxDp8Y5eCdhxnayfGo6c04UmlrHVccNS3BnJZX+RtC
 TrKbjW2DBfICHrRd2eNfmnDnmS0bpCXYzcNdIjxbS3LEnDx7fatBhspM0N8QmXcSujx4
 KvQxFAWIqiE9DoaL5qs85Qzo5WrBlb8EI7hwxJnxBiabYQfpqIigOqQYQqszEM2O5t7s dw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3ngmy41apy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Feb 2023 22:28:17 +0000
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 312MRXKI031258;
        Thu, 2 Feb 2023 22:28:17 GMT
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3ngmy41apu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Feb 2023 22:28:17 +0000
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 312IewGs028518;
        Thu, 2 Feb 2023 22:28:16 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([9.208.129.117])
        by ppma04wdc.us.ibm.com (PPS) with ESMTPS id 3ncvuywrt0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Feb 2023 22:28:16 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
        by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 312MSFnL6619830
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 2 Feb 2023 22:28:15 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7DF0458059;
        Thu,  2 Feb 2023 22:28:15 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C45355804B;
        Thu,  2 Feb 2023 22:28:14 +0000 (GMT)
Received: from li-6bf4d4cc-31f5-11b2-a85c-838e9310af65.ibm.com.com (unknown [9.211.158.218])
        by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Thu,  2 Feb 2023 22:28:14 +0000 (GMT)
From:   Brian King <brking@linux.vnet.ibm.com>
To:     gregkh@linuxfoundation.org
Cc:     linuxppc-dev@lists.ozlabs.org, brking@pobox.com,
        mmc@linux.vnet.ibm.com, linux-serial@vger.kernel.org,
        Brian King <brking@linux.vnet.ibm.com>
Subject: [PATCH v2 1/6] hvcs: Fix hvcs port reference counting
Date:   Thu,  2 Feb 2023 16:27:59 -0600
Message-Id: <20230202222804.383229-2-brking@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230202222804.383229-1-brking@linux.vnet.ibm.com>
References: <20230202222804.383229-1-brking@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: DE94K9Xyp_eFSCENItyjRZw9TDQUdf6A
X-Proofpoint-GUID: UEoP2wzfO0cBG9aB-PnGwSzaCt8DVQQC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-02_14,2023-02-02_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 adultscore=0
 mlxscore=0 malwarescore=0 clxscore=1015 phishscore=0 bulkscore=0
 mlxlogscore=999 lowpriorityscore=0 impostorscore=0 suspectscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302020196
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The hvcs driver only ever gets two references to the port. One
at initialization time, and one at install time. Remove the code
that was trying to do multiple port puts for each open, which
would result in more puts than gets.

Signed-off-by: Brian King <brking@linux.vnet.ibm.com>
---
 drivers/tty/hvc/hvcs.c | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/drivers/tty/hvc/hvcs.c b/drivers/tty/hvc/hvcs.c
index 4ba24963685e..faf5ccfc561e 100644
--- a/drivers/tty/hvc/hvcs.c
+++ b/drivers/tty/hvc/hvcs.c
@@ -1215,12 +1215,9 @@ static void hvcs_hangup(struct tty_struct * tty)
 {
 	struct hvcs_struct *hvcsd = tty->driver_data;
 	unsigned long flags;
-	int temp_open_count;
 	int irq;
 
 	spin_lock_irqsave(&hvcsd->lock, flags);
-	/* Preserve this so that we know how many kref refs to put */
-	temp_open_count = hvcsd->port.count;
 
 	/*
 	 * Don't kref put inside the spinlock because the destruction
@@ -1247,21 +1244,6 @@ static void hvcs_hangup(struct tty_struct * tty)
 	spin_unlock_irqrestore(&hvcsd->lock, flags);
 
 	free_irq(irq, hvcsd);
-
-	/*
-	 * We need to kref_put() for every open_count we have since the
-	 * tty_hangup() function doesn't invoke a close per open connection on a
-	 * non-console device.
-	 */
-	while(temp_open_count) {
-		--temp_open_count;
-		/*
-		 * The final put will trigger destruction of the hvcs_struct.
-		 * NOTE:  If this hangup was signaled from user space then the
-		 * final put will never happen.
-		 */
-		tty_port_put(&hvcsd->port);
-	}
 }
 
 /*
-- 
2.31.1

