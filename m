Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 419AEC636D4
	for <linux-serial@archiver.kernel.org>; Wed,  1 Feb 2023 19:58:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232166AbjBAT6L (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 1 Feb 2023 14:58:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232147AbjBAT6I (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 1 Feb 2023 14:58:08 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DA74C64D
        for <linux-serial@vger.kernel.org>; Wed,  1 Feb 2023 11:58:02 -0800 (PST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 311JnfFp020667;
        Wed, 1 Feb 2023 19:57:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=QpwMgr23nIiMkJ3ihnsLIr7pw0uxT05vUxhNww44wHs=;
 b=rvxLDnU7X32HfrFeQAvhSniw52NKytlo7hRlotPb8SlmNxD7UfwnJuqUocSKNAUZBW6u
 Nlw1Tz/+ADzhgJorVbjycE838g8hKZIuGDbbLwBsLrbt8vSqaQlxXAamg84B5DdDXgT5
 x13SCm9QsqcPWvWq3KJVBBbimQqaPI0V+mYtov5ocLqE/WcEKE9jc0ErsvkCpfjjDjmv
 OoM5WsPYNHpczJTHHCC//oOPYaQ8jspxJPiXVT6AS4J6alCJqCWIXcgGfwtr/4/bgfAg
 iwiPO7+iEO76qmfPG6h2xGqSO4Cds0oI20f8xvWCAREnA8RxGH/fGX5Zr24+qPFpryjF zw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nfxk485vq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Feb 2023 19:57:58 +0000
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 311JoD7Z022221;
        Wed, 1 Feb 2023 19:57:57 GMT
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nfxk485va-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Feb 2023 19:57:57 +0000
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 311H8Cpb005396;
        Wed, 1 Feb 2023 19:57:56 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([9.208.129.117])
        by ppma02wdc.us.ibm.com (PPS) with ESMTPS id 3ncvv1yh6y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Feb 2023 19:57:56 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
        by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 311Jvtgx30802344
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 1 Feb 2023 19:57:55 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2D8ED58062;
        Wed,  1 Feb 2023 19:57:55 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A26AA58058;
        Wed,  1 Feb 2023 19:57:54 +0000 (GMT)
Received: from li-6bf4d4cc-31f5-11b2-a85c-838e9310af65.ibm.com.com (unknown [9.211.132.88])
        by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Wed,  1 Feb 2023 19:57:54 +0000 (GMT)
From:   Brian King <brking@linux.vnet.ibm.com>
To:     gregkh@linuxfoundation.org
Cc:     linuxppc-dev@lists.ozlabs.org, brking@pobox.com,
        mmc@linux.vnet.ibm.com, linux-serial@vger.kernel.org,
        Brian King <brking@linux.vnet.ibm.com>
Subject: [PATCH 3/6] hvcs: Remove sysfs group earlier
Date:   Wed,  1 Feb 2023 13:57:40 -0600
Message-Id: <20230201195743.303163-4-brking@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230201195743.303163-1-brking@linux.vnet.ibm.com>
References: <20230201195743.303163-1-brking@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: NecJQWBA0ZVN9TDz5nKQwXx-g5bQQrNl
X-Proofpoint-ORIG-GUID: K8YR5HZg4fKE0J7NACAwbyO0s7EWgDGu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-01_04,2023-01-31_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=999 clxscore=1015 priorityscore=1501 malwarescore=0
 spamscore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0 mlxscore=0
 adultscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302010166
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Cleanup the sysfs group earlier in remove. This eliminates
errors coming from kernfs when attempting to remove a console
device that is in use.

Signed-off-by: Brian King <brking@linux.vnet.ibm.com>
---
 drivers/tty/hvc/hvcs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/hvc/hvcs.c b/drivers/tty/hvc/hvcs.c
index 9131dcb2e8d8..9c5887d0c882 100644
--- a/drivers/tty/hvc/hvcs.c
+++ b/drivers/tty/hvc/hvcs.c
@@ -688,8 +688,6 @@ static void hvcs_destruct_port(struct tty_port *p)
 	spin_unlock_irqrestore(&hvcsd->lock, flags);
 	spin_unlock(&hvcs_structs_lock);
 
-	sysfs_remove_group(&vdev->dev.kobj, &hvcs_attr_group);
-
 	kfree(hvcsd);
 }
 
@@ -814,6 +812,8 @@ static void hvcs_remove(struct vio_dev *dev)
 	 */
 	tty_port_put(&hvcsd->port);
 
+	sysfs_remove_group(&dev->dev.kobj, &hvcs_attr_group);
+
 	/*
 	 * The hangup is a scheduled function which will auto chain call
 	 * hvcs_hangup.  The tty should always be valid at this time unless a
-- 
2.31.1

