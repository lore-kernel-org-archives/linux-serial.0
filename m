Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B4C3C636D3
	for <linux-serial@archiver.kernel.org>; Thu,  2 Feb 2023 22:28:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231695AbjBBW2k (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 2 Feb 2023 17:28:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233255AbjBBW21 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 2 Feb 2023 17:28:27 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A793A34315
        for <linux-serial@vger.kernel.org>; Thu,  2 Feb 2023 14:28:24 -0800 (PST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 312MBiWR013946;
        Thu, 2 Feb 2023 22:28:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=f0YAfmQJVwXGkOVwMjqiCV7X+x2qPLNnsYTTjQJsP2A=;
 b=aZZk0zcLq3/OGPp/83V+0XxC0o7vNlojoe8fhWFD/cRHwiOCWd/xv2TvCCo3rEA3KmXg
 6rRFpn7ctqZ0uF3gkKTaIJ7b8lnSiP2OSqdaV0B2VlJ3Vrao9se8L4qIiKg0KsPdDtx7
 ajWTvbjuZtyleMDu2RsOiBvSRJw75KD5ZwZYToP/8BT9Cm0ZQFyKdJkB09heB8nZs5/4
 Iz2Lkca61mUxA843upNjKd7+P8Jqzys2UimS24N6ZGNKCSqlHb7V+zIG8pTzz1s4ajZk
 j0cnfp8yPIQ9FWJIdH2mRwWLa3+wBc+l88haNqRZVhrmhanpV+p/K7T6k3ax5l9JeTC3 7Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3ngn628ub3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Feb 2023 22:28:20 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 312MFEGw026079;
        Thu, 2 Feb 2023 22:28:19 GMT
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3ngn628uav-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Feb 2023 22:28:19 +0000
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 312IUsdu007780;
        Thu, 2 Feb 2023 22:28:19 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([9.208.130.97])
        by ppma03wdc.us.ibm.com (PPS) with ESMTPS id 3ncvtf5sx3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Feb 2023 22:28:19 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
        by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 312MSIfO25690516
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 2 Feb 2023 22:28:18 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2E9DD5804B;
        Thu,  2 Feb 2023 22:28:18 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6B5EC58059;
        Thu,  2 Feb 2023 22:28:17 +0000 (GMT)
Received: from li-6bf4d4cc-31f5-11b2-a85c-838e9310af65.ibm.com.com (unknown [9.211.158.218])
        by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Thu,  2 Feb 2023 22:28:17 +0000 (GMT)
From:   Brian King <brking@linux.vnet.ibm.com>
To:     gregkh@linuxfoundation.org
Cc:     linuxppc-dev@lists.ozlabs.org, brking@pobox.com,
        mmc@linux.vnet.ibm.com, linux-serial@vger.kernel.org,
        Brian King <brking@linux.vnet.ibm.com>
Subject: [PATCH v2 4/6] hvcs: Get reference to tty in remove
Date:   Thu,  2 Feb 2023 16:28:02 -0600
Message-Id: <20230202222804.383229-5-brking@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230202222804.383229-1-brking@linux.vnet.ibm.com>
References: <20230202222804.383229-1-brking@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: BY0t1Uh7jVTAl3HZl0xO-_17fbzg1NC8
X-Proofpoint-ORIG-GUID: KBspTYSofduU8T5FQogf2H-IsFMMY1Nw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-02_14,2023-02-02_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 clxscore=1015 lowpriorityscore=0 priorityscore=1501 mlxscore=0
 mlxlogscore=999 spamscore=0 phishscore=0 malwarescore=0 adultscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302020196
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Grab a reference to the tty when removing the hvcs to ensure
it does not get freed unexpectedly.

Signed-off-by: Brian King <brking@linux.vnet.ibm.com>
---
 drivers/tty/hvc/hvcs.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/hvc/hvcs.c b/drivers/tty/hvc/hvcs.c
index 5de7ad555540..04c58ac4fec2 100644
--- a/drivers/tty/hvc/hvcs.c
+++ b/drivers/tty/hvc/hvcs.c
@@ -813,7 +813,7 @@ static void hvcs_remove(struct vio_dev *dev)
 
 	spin_lock_irqsave(&hvcsd->lock, flags);
 
-	tty = hvcsd->port.tty;
+	tty = tty_port_tty_get(&hvcsd->port);
 
 	spin_unlock_irqrestore(&hvcsd->lock, flags);
 
@@ -828,8 +828,10 @@ static void hvcs_remove(struct vio_dev *dev)
 	 * hvcs_hangup.  The tty should always be valid at this time unless a
 	 * simultaneous tty close already cleaned up the hvcs_struct.
 	 */
-	if (tty)
+	if (tty) {
 		tty_hangup(tty);
+		tty_kref_put(tty);
+	}
 
 	printk(KERN_INFO "HVCS: vty-server@%X removed from the"
 			" vio bus.\n", dev->unit_address);
-- 
2.31.1

