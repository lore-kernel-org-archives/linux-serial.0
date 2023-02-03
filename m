Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9058DC636D6
	for <linux-serial@archiver.kernel.org>; Fri,  3 Feb 2023 15:58:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233389AbjBCP6T (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 3 Feb 2023 10:58:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233117AbjBCP6S (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 3 Feb 2023 10:58:18 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EAC01F49A
        for <linux-serial@vger.kernel.org>; Fri,  3 Feb 2023 07:58:15 -0800 (PST)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 313FgRWI011410;
        Fri, 3 Feb 2023 15:58:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=pSJ5H9ErhvfQwRYs8Vwr/9mWh2W7+Gu4a1tfEP2WfYY=;
 b=PKpwmpDr+65Q1uvr+wWusU6tEP8vgErEV3Kj9Q8EIYwfEMapa4z6NdMFML3vx/jyh5Gz
 RDufPOn2nJF/LscekhzT3B0h/VjMbM10bIY4S5RRJl4vItxeIZ1bc0ro0i53nm7tyI0m
 uhzol10uC+TNIr6menzka9W3qIFBOlJY6v4T4mmJblh1/eLeoqd7RWpxyd0Wb/vlOv3T
 XNU0Wl2EqVg1k7PciYsdDIlTjZmmkezeYGP+JOwYlSq/hs6SGv2FHf391FJBxsA7IbWB
 wDYbMUlKJ0llFj/lM9fCJVZlNxsjCowwdQCWFbziZECRMmKRjs/Fam0RATbmT6LBvzSV pw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nh554gbxf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Feb 2023 15:58:11 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 313Fh2Ou013201;
        Fri, 3 Feb 2023 15:58:11 GMT
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nh554gbx2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Feb 2023 15:58:11 +0000
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 313E9WPJ006481;
        Fri, 3 Feb 2023 15:58:10 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([9.208.129.119])
        by ppma01dal.us.ibm.com (PPS) with ESMTPS id 3ncvtn1t9h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Feb 2023 15:58:09 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
        by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 313Fw84j41419186
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 3 Feb 2023 15:58:08 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 28C285803F;
        Fri,  3 Feb 2023 15:58:08 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A84A95805A;
        Fri,  3 Feb 2023 15:58:07 +0000 (GMT)
Received: from li-6bf4d4cc-31f5-11b2-a85c-838e9310af65.ibm.com.com (unknown [9.211.110.209])
        by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Fri,  3 Feb 2023 15:58:07 +0000 (GMT)
From:   Brian King <brking@linux.vnet.ibm.com>
To:     gregkh@linuxfoundation.org
Cc:     linuxppc-dev@lists.ozlabs.org, brking@pobox.com,
        mmc@linux.vnet.ibm.com, linux-serial@vger.kernel.org,
        Brian King <brking@linux.vnet.ibm.com>
Subject: [PATCH v3 1/5] hvcs: Use dev_groups to manage hvcs device attributes
Date:   Fri,  3 Feb 2023 09:57:58 -0600
Message-Id: <20230203155802.404324-2-brking@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230203155802.404324-1-brking@linux.vnet.ibm.com>
References: <20230203155802.404324-1-brking@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: QI6JDg-zt6jgdPuIlM_lHjuCypMEvo2j
X-Proofpoint-GUID: 9kl8Gk2tdnBEfFGPpgGh5L7Y3Mezs8nI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-03_15,2023-02-03_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 malwarescore=0 suspectscore=0 spamscore=0 clxscore=1015
 mlxlogscore=999 impostorscore=0 bulkscore=0 priorityscore=1501 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302030142
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Use the dev_groups functionality to manage the attribute groups
for hvcs devices. This simplifies the code and also eliminates
errors coming from kernfs when attempting to remove a console
device that is in use.

Signed-off-by: Brian King <brking@linux.vnet.ibm.com>
---
 drivers/tty/hvc/hvcs.c | 19 +++++--------------
 1 file changed, 5 insertions(+), 14 deletions(-)

diff --git a/drivers/tty/hvc/hvcs.c b/drivers/tty/hvc/hvcs.c
index faf5ccfc561e..0416601357e1 100644
--- a/drivers/tty/hvc/hvcs.c
+++ b/drivers/tty/hvc/hvcs.c
@@ -432,7 +432,7 @@ static ssize_t hvcs_index_show(struct device *dev, struct device_attribute *attr
 
 static DEVICE_ATTR(index, S_IRUGO, hvcs_index_show, NULL);
 
-static struct attribute *hvcs_attrs[] = {
+static struct attribute *hvcs_dev_attrs[] = {
 	&dev_attr_partner_vtys.attr,
 	&dev_attr_partner_clcs.attr,
 	&dev_attr_current_vty.attr,
@@ -441,9 +441,7 @@ static struct attribute *hvcs_attrs[] = {
 	NULL,
 };
 
-static struct attribute_group hvcs_attr_group = {
-	.attrs = hvcs_attrs,
-};
+ATTRIBUTE_GROUPS(hvcs_dev);
 
 static ssize_t rescan_show(struct device_driver *ddp, char *buf)
 {
@@ -688,8 +686,6 @@ static void hvcs_destruct_port(struct tty_port *p)
 	spin_unlock_irqrestore(&hvcsd->lock, flags);
 	spin_unlock(&hvcs_structs_lock);
 
-	sysfs_remove_group(&vdev->dev.kobj, &hvcs_attr_group);
-
 	kfree(hvcsd);
 }
 
@@ -721,7 +717,6 @@ static int hvcs_probe(
 {
 	struct hvcs_struct *hvcsd;
 	int index, rc;
-	int retval;
 
 	if (!dev || !id) {
 		printk(KERN_ERR "HVCS: probed with invalid parameter.\n");
@@ -778,13 +773,6 @@ static int hvcs_probe(
 	list_add_tail(&(hvcsd->next), &hvcs_structs);
 	spin_unlock(&hvcs_structs_lock);
 
-	retval = sysfs_create_group(&dev->dev.kobj, &hvcs_attr_group);
-	if (retval) {
-		printk(KERN_ERR "HVCS: Can't create sysfs attrs for vty-server@%X\n",
-		       hvcsd->vdev->unit_address);
-		return retval;
-	}
-
 	printk(KERN_INFO "HVCS: vty-server@%X added to the vio bus.\n", dev->unit_address);
 
 	/*
@@ -831,6 +819,9 @@ static struct vio_driver hvcs_vio_driver = {
 	.probe		= hvcs_probe,
 	.remove		= hvcs_remove,
 	.name		= hvcs_driver_name,
+	.driver = {
+		.dev_groups = hvcs_dev_groups,
+	},
 };
 
 /* Only called from hvcs_get_pi please */
-- 
2.31.1

