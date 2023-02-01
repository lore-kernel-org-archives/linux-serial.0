Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC74DC05027
	for <linux-serial@archiver.kernel.org>; Wed,  1 Feb 2023 19:58:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232138AbjBAT6I (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 1 Feb 2023 14:58:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232118AbjBAT6H (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 1 Feb 2023 14:58:07 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 004EDA24C
        for <linux-serial@vger.kernel.org>; Wed,  1 Feb 2023 11:58:00 -0800 (PST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 311JExkx013012;
        Wed, 1 Feb 2023 19:57:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=eZHFp+q1/ZdO0GMG9d6sVTotLIfZq7S/xMjdYSaqJn0=;
 b=qyubtcvMHwuZlReJ1O548a8irrm7t5P2Yq5iiJJO3B6ZIQfiZPHHwI5sxvV3sNBTEcb7
 ttQsKyO5IjM7w9ktF6SphFVS8YUP/VJdhL6dsOMuhM1zfqSRnwPbXYQmqsq3OMYAjhKr
 Du6qyyPNCjbYH4/ogt/yLlVs1GZTlmpVKbdybbh/DbMfE9DmXYRAtx6rU3xrJCBQ20pb
 ik3UxNb4yKJ1pqbEHr+yNSF0UuSR+NTsEkYdJz83a5e8csvo9WjCVntpi3Mk6F8v5+fG
 E9BS759IOZ3QtTjT7UTjoRrN5kQ/v4iwYWwBfaO9gd8sfd4/MHctoOHygjVU52OZ865j RA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nfwt41hfg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Feb 2023 19:57:56 +0000
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 311JpLIq021285;
        Wed, 1 Feb 2023 19:57:55 GMT
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nfwt41hf5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Feb 2023 19:57:55 +0000
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 311J0A10019250;
        Wed, 1 Feb 2023 19:57:55 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([9.208.129.113])
        by ppma02dal.us.ibm.com (PPS) with ESMTPS id 3ncvuqwayh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Feb 2023 19:57:55 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
        by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 311JvrAL11993724
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 1 Feb 2023 19:57:53 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4F3C458057;
        Wed,  1 Feb 2023 19:57:53 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C552658058;
        Wed,  1 Feb 2023 19:57:52 +0000 (GMT)
Received: from li-6bf4d4cc-31f5-11b2-a85c-838e9310af65.ibm.com.com (unknown [9.211.132.88])
        by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Wed,  1 Feb 2023 19:57:52 +0000 (GMT)
From:   Brian King <brking@linux.vnet.ibm.com>
To:     gregkh@linuxfoundation.org
Cc:     linuxppc-dev@lists.ozlabs.org, brking@pobox.com,
        mmc@linux.vnet.ibm.com, linux-serial@vger.kernel.org,
        Brian King <brking@linux.vnet.ibm.com>
Subject: [PATCH 0/6] hvcs: Various hvcs device hotplug fixes
Date:   Wed,  1 Feb 2023 13:57:37 -0600
Message-Id: <20230201195743.303163-1-brking@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: j5Pa4MQvY6KBS8yISPHNwc4NwIk9d-G1
X-Proofpoint-GUID: rBh2QMZgWsi-br4I9EZv9hg2J5UPELh3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-01_04,2023-01-31_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 phishscore=0
 spamscore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0 mlxscore=0
 bulkscore=0 suspectscore=0 impostorscore=0 clxscore=1011 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302010166
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

This patch series fixes a number of issues with hotplugging
hvcs devices including memory leaks as well as, the inability
to reconnect to a console device after it has been hot added
back, since it was not getting cleaned up properly on the
hotplug remove path.

Brian King (6):
  hvcs: Fix hvcs port reference counting
  hvcs: Remove sysfs file prior to vio unregister
  hvcs: Remove sysfs group earlier
  hvcs: Get reference to tty in remove
  hvcs: Use vhangup in hotplug remove
  hvcs: Synchronize hotplug remove with port free

 drivers/tty/hvc/hvcs.c | 61 +++++++++++++++++-------------------------
 1 file changed, 24 insertions(+), 37 deletions(-)

-- 
2.31.1

