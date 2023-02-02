Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1497C636D3
	for <linux-serial@archiver.kernel.org>; Thu,  2 Feb 2023 22:29:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232850AbjBBW2p (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 2 Feb 2023 17:28:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233259AbjBBW22 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 2 Feb 2023 17:28:28 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 035C218B1A
        for <linux-serial@vger.kernel.org>; Thu,  2 Feb 2023 14:28:25 -0800 (PST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 312MIm7m004137;
        Thu, 2 Feb 2023 22:28:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=agxVn6mCQto2PW6GZvC87iuY+VpvsK83XTypwOizQaU=;
 b=QvQPhEVqUQ5Kv9ToRLooPVg7dFBn21HEVV6XdQoMxLOH6T/GoDTInLpwh6evr4vZbHhj
 ZyHNBMG3mbOrTPIpb/k61inIXnIJUIvwDXXxjFsPk0I9SvOH4kTmV3HYq9z+UEunoHmi
 UIf2HMMvT0iBbpwi5RA9Q9UGZw8Il88DFrCNEm8Ju8gsKLU1Lk4cMnGMm0OpGfNrauAh
 BTeQ0VfRQXp+xnUB2eJE67aEdcAXURYkyU+7ivfLpZei14xUQHXFdx9JPMa+ohK7ymvP
 uS9p5YwDIff3qvTe8U9bhAzzpmUmWs27Ll2t5la3iHbEquDqm9h+M2RI7xZc1Fndk/cx dA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ngnv0850b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Feb 2023 22:28:21 +0000
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 312MQqj3029927;
        Thu, 2 Feb 2023 22:28:21 GMT
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ngnv08506-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Feb 2023 22:28:21 +0000
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 312L64tm008452;
        Thu, 2 Feb 2023 22:28:20 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([9.208.130.98])
        by ppma04dal.us.ibm.com (PPS) with ESMTPS id 3ncvw355q9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Feb 2023 22:28:20 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
        by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 312MSJch8979160
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 2 Feb 2023 22:28:19 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1B6D55804B;
        Thu,  2 Feb 2023 22:28:19 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 57F0458059;
        Thu,  2 Feb 2023 22:28:18 +0000 (GMT)
Received: from li-6bf4d4cc-31f5-11b2-a85c-838e9310af65.ibm.com.com (unknown [9.211.158.218])
        by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Thu,  2 Feb 2023 22:28:18 +0000 (GMT)
From:   Brian King <brking@linux.vnet.ibm.com>
To:     gregkh@linuxfoundation.org
Cc:     linuxppc-dev@lists.ozlabs.org, brking@pobox.com,
        mmc@linux.vnet.ibm.com, linux-serial@vger.kernel.org,
        Brian King <brking@linux.vnet.ibm.com>
Subject: [PATCH v2 5/6] hvcs: Use vhangup in hotplug remove
Date:   Thu,  2 Feb 2023 16:28:03 -0600
Message-Id: <20230202222804.383229-6-brking@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230202222804.383229-1-brking@linux.vnet.ibm.com>
References: <20230202222804.383229-1-brking@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: IXFOA_hNk_lAh2YcO45u8o-oWPYPWIHt
X-Proofpoint-ORIG-GUID: 3TC3CQu4cvH40UKtWanu8bjABSrD24tm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-02_14,2023-02-02_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 phishscore=0 suspectscore=0 spamscore=0
 priorityscore=1501 mlxscore=0 adultscore=0 bulkscore=0 malwarescore=0
 impostorscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2302020196
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

When hotplug removing an hvcs device, we need to ensure the
hangup processing is done prior to exiting the remove function,
so use tty_vhangup to do the hangup processing directly
rather than using tty_hangup which simply schedules the hangup
work for later execution.

Signed-off-by: Brian King <brking@linux.vnet.ibm.com>
---
 drivers/tty/hvc/hvcs.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/hvc/hvcs.c b/drivers/tty/hvc/hvcs.c
index 04c58ac4fec2..2e9e45f06916 100644
--- a/drivers/tty/hvc/hvcs.c
+++ b/drivers/tty/hvc/hvcs.c
@@ -824,12 +824,11 @@ static void hvcs_remove(struct vio_dev *dev)
 	tty_port_put(&hvcsd->port);
 
 	/*
-	 * The hangup is a scheduled function which will auto chain call
-	 * hvcs_hangup.  The tty should always be valid at this time unless a
+	 * The tty should always be valid at this time unless a
 	 * simultaneous tty close already cleaned up the hvcs_struct.
 	 */
 	if (tty) {
-		tty_hangup(tty);
+		tty_vhangup(tty);
 		tty_kref_put(tty);
 	}
 
-- 
2.31.1

