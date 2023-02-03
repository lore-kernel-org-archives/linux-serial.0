Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BA4AC636D7
	for <linux-serial@archiver.kernel.org>; Fri,  3 Feb 2023 15:58:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233117AbjBCP6U (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 3 Feb 2023 10:58:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233260AbjBCP6S (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 3 Feb 2023 10:58:18 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E67116AD0
        for <linux-serial@vger.kernel.org>; Fri,  3 Feb 2023 07:58:16 -0800 (PST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 313EiF1X021184;
        Fri, 3 Feb 2023 15:58:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=wo7Tb3LptoObWpz/saZLrLdh3Gx5qXEfusOJKRb2fmo=;
 b=JJbZbFv6BXMp8HgaGAmROazTICCF4vC/6g3cS7HDTLGQ62//TNxFIKZRlPM8Ubb56gV5
 6VVMV/MHa12Qtw2QDUJJohojkKXUD1wVdmZ0xLceV39qPRBfw8hC9uhrCSMgWN8uG8B7
 GLokBt/TMq/XVjHX+12Cr1dHoZ3fDLXU6A9EK93M/PEN/8V0pZhLSzjxqZh5ENifqh6I
 LY61Zvj9QQOcPUxZyttSlYnZI1s/0z3TRyQKWp2BFJYKK8JPNKy0cA7y4MxYXsM2flWM
 8pXXxuAuw5CKX5/0jGZft2JoDiGIOU34kvMOyhzM0IhCqr+wVRQbHUUyuwCJG0YJeeTK 4w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3nh49u9t61-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Feb 2023 15:58:11 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 313EjC38024197;
        Fri, 3 Feb 2023 15:58:10 GMT
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3nh49u9t5r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Feb 2023 15:58:10 +0000
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 313FpV9H004994;
        Fri, 3 Feb 2023 15:58:10 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([9.208.129.119])
        by ppma02wdc.us.ibm.com (PPS) with ESMTPS id 3ncvv29hpn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Feb 2023 15:58:10 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
        by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 313Fw8Tv39780868
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 3 Feb 2023 15:58:09 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B69E458061;
        Fri,  3 Feb 2023 15:58:08 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4316258056;
        Fri,  3 Feb 2023 15:58:08 +0000 (GMT)
Received: from li-6bf4d4cc-31f5-11b2-a85c-838e9310af65.ibm.com.com (unknown [9.211.110.209])
        by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Fri,  3 Feb 2023 15:58:08 +0000 (GMT)
From:   Brian King <brking@linux.vnet.ibm.com>
To:     gregkh@linuxfoundation.org
Cc:     linuxppc-dev@lists.ozlabs.org, brking@pobox.com,
        mmc@linux.vnet.ibm.com, linux-serial@vger.kernel.org,
        Brian King <brking@linux.vnet.ibm.com>
Subject: [PATCH v3 2/5] hvcs: Use driver groups to manage driver attributes
Date:   Fri,  3 Feb 2023 09:57:59 -0600
Message-Id: <20230203155802.404324-3-brking@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230203155802.404324-1-brking@linux.vnet.ibm.com>
References: <20230203155802.404324-1-brking@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: o3XiLjNl6fhvpoXo96qK1R3eflp4Cd-i
X-Proofpoint-ORIG-GUID: YbernrDTxERiCmy45HWPNqc-p-P9nMnf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-03_15,2023-02-03_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 malwarescore=0 mlxlogscore=999 impostorscore=0 clxscore=1015
 priorityscore=1501 spamscore=0 adultscore=0 bulkscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302030142
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Rather than manually creating attributes for the hvcs driver,
let the driver core do this for us. This also fixes some hotplug
remove issues and ensures that cleanup of these attributes
is done in the right order.

Signed-off-by: Brian King <brking@linux.vnet.ibm.com>
---
 drivers/tty/hvc/hvcs.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/tty/hvc/hvcs.c b/drivers/tty/hvc/hvcs.c
index 0416601357e1..522910716025 100644
--- a/drivers/tty/hvc/hvcs.c
+++ b/drivers/tty/hvc/hvcs.c
@@ -466,6 +466,13 @@ static ssize_t rescan_store(struct device_driver *ddp, const char * buf,
 
 static DRIVER_ATTR_RW(rescan);
 
+static struct attribute *hvcs_attrs[] = {
+	&driver_attr_rescan.attr,
+	NULL,
+};
+
+ATTRIBUTE_GROUPS(hvcs);
+
 static void hvcs_kick(void)
 {
 	hvcs_kicked = 1;
@@ -820,6 +827,7 @@ static struct vio_driver hvcs_vio_driver = {
 	.remove		= hvcs_remove,
 	.name		= hvcs_driver_name,
 	.driver = {
+		.groups = hvcs_groups,
 		.dev_groups = hvcs_dev_groups,
 	},
 };
@@ -1498,13 +1506,6 @@ static int __init hvcs_module_init(void)
 
 	pr_info("HVCS: Driver registered.\n");
 
-	/* This needs to be done AFTER the vio_register_driver() call or else
-	 * the kobjects won't be initialized properly.
-	 */
-	rc = driver_create_file(&(hvcs_vio_driver.driver), &driver_attr_rescan);
-	if (rc)
-		pr_warn("HVCS: Failed to create rescan file (err %d)\n", rc);
-
 	return 0;
 }
 
@@ -1529,8 +1530,6 @@ static void __exit hvcs_module_exit(void)
 	hvcs_pi_buff = NULL;
 	spin_unlock(&hvcs_pi_lock);
 
-	driver_remove_file(&hvcs_vio_driver.driver, &driver_attr_rescan);
-
 	tty_unregister_driver(hvcs_tty_driver);
 
 	hvcs_free_index_list();
-- 
2.31.1

