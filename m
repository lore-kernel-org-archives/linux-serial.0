Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 360AAC636D6
	for <linux-serial@archiver.kernel.org>; Fri,  3 Feb 2023 15:58:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233025AbjBCP6W (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 3 Feb 2023 10:58:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233373AbjBCP6T (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 3 Feb 2023 10:58:19 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F0591F5C1
        for <linux-serial@vger.kernel.org>; Fri,  3 Feb 2023 07:58:16 -0800 (PST)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 313FgSak011444;
        Fri, 3 Feb 2023 15:58:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=mTUej6imQQ8/A+3tpsOQrqNCFxcd5vXrdHiqFWNV1VI=;
 b=a5KfxYf+GZnCPleVbN4yaDS01nv+hZsPYgG9ZoU34u3yYUFk1LAkOBnNSieYUddQk2wv
 2AOQz4ydt46+u+r73+SZdTFu/mhBausl2ulN26miOVZ+WnEg6VMDfcRW9jFsWPuIvYPy
 8A9nOx9Aj/515E89Xzu50iG0OazNmcVMBJ7CCPun+TfaFlMPUcWbUGFwQmJDj6dRA8S/
 CNROxN0Qvhw9wz0PvEX/UXRz+2MOpAM+/z4ZQqZooW765Dd183LyWeQK9g3TxC1hWZhQ
 rpVUuXlScfyzD0Yn7S7xk9KHZmk+Wgwln+6SRf4H20qfCGAtWUKvQY2ZCLXdUQdRzsM7 Eg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nh554gby1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Feb 2023 15:58:13 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 313Fgthd012922;
        Fri, 3 Feb 2023 15:58:12 GMT
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nh554gbxq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Feb 2023 15:58:12 +0000
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 313E7A7q006461;
        Fri, 3 Feb 2023 15:58:11 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([9.208.129.113])
        by ppma01dal.us.ibm.com (PPS) with ESMTPS id 3ncvtn1t9p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Feb 2023 15:58:11 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
        by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 313FwALZ7471754
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 3 Feb 2023 15:58:10 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0117F58061;
        Fri,  3 Feb 2023 15:58:10 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 761B15803F;
        Fri,  3 Feb 2023 15:58:09 +0000 (GMT)
Received: from li-6bf4d4cc-31f5-11b2-a85c-838e9310af65.ibm.com.com (unknown [9.211.110.209])
        by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Fri,  3 Feb 2023 15:58:09 +0000 (GMT)
From:   Brian King <brking@linux.vnet.ibm.com>
To:     gregkh@linuxfoundation.org
Cc:     linuxppc-dev@lists.ozlabs.org, brking@pobox.com,
        mmc@linux.vnet.ibm.com, linux-serial@vger.kernel.org,
        Brian King <brking@linux.vnet.ibm.com>
Subject: [PATCH v3 4/5] hvcs: Use vhangup in hotplug remove
Date:   Fri,  3 Feb 2023 09:58:01 -0600
Message-Id: <20230203155802.404324-5-brking@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230203155802.404324-1-brking@linux.vnet.ibm.com>
References: <20230203155802.404324-1-brking@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: UMGudlzfDiOi2Zy8qcn06zp7RHwhhFi6
X-Proofpoint-GUID: DlkXSMpT3Tskk1pFTHYZxNroI3AiFNFe
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
index 8d40b20de277..ecf24195b1e9 100644
--- a/drivers/tty/hvc/hvcs.c
+++ b/drivers/tty/hvc/hvcs.c
@@ -810,12 +810,11 @@ static void hvcs_remove(struct vio_dev *dev)
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

