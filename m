Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11AE8C05027
	for <linux-serial@archiver.kernel.org>; Fri,  3 Feb 2023 15:58:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232353AbjBCP6V (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 3 Feb 2023 10:58:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233338AbjBCP6S (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 3 Feb 2023 10:58:18 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E94E17CF6
        for <linux-serial@vger.kernel.org>; Fri,  3 Feb 2023 07:58:15 -0800 (PST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 313Flq2d016611;
        Fri, 3 Feb 2023 15:58:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=5qyFVL50t9zrStRoaiwNyES+OX72FR8ykpFm7iQP1Wk=;
 b=Op+bWQiZtKRjvKgUSGaIfJaGARPr1mlHjkWXMFJ/Ll/h2FssfIA8uUlPVyeL46YgCWZO
 oyv/JU19hRRTrRI/uzs4DYk4I9XZthrAC3ZEjkHczi8aCmjPpv019px8WajOtgK0VSvF
 qnRKFMughY5YWSsCZHJ7sJkyzy1mdRA26D7al7y/M0gnRVNibL6cB+xFgkclJzRWL2oL
 0OeV/bTUSUI+lKmZ2XBrXIUsQCRvFVBKcVscwN6ufpQ5C0RWvAtZVqePXNvJZilnjues
 rTrlO6zLnrvC9NoozHZtGYmg1kU3kSbH8wcaodi5YlxoXdfiOyKrIGRfffzufuJV/MuO cA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nh29rw44j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Feb 2023 15:58:09 +0000
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 313Dg71A014226;
        Fri, 3 Feb 2023 15:58:09 GMT
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nh29rw44f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Feb 2023 15:58:09 +0000
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 313FcveU026861;
        Fri, 3 Feb 2023 15:58:08 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([9.208.130.99])
        by ppma01wdc.us.ibm.com (PPS) with ESMTPS id 3ncvtnhh87-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Feb 2023 15:58:08 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
        by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 313Fw7FU36897096
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 3 Feb 2023 15:58:07 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8E15E58064;
        Fri,  3 Feb 2023 15:58:07 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1105C58063;
        Fri,  3 Feb 2023 15:58:07 +0000 (GMT)
Received: from li-6bf4d4cc-31f5-11b2-a85c-838e9310af65.ibm.com.com (unknown [9.211.110.209])
        by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Fri,  3 Feb 2023 15:58:06 +0000 (GMT)
From:   Brian King <brking@linux.vnet.ibm.com>
To:     gregkh@linuxfoundation.org
Cc:     linuxppc-dev@lists.ozlabs.org, brking@pobox.com,
        mmc@linux.vnet.ibm.com, linux-serial@vger.kernel.org,
        Brian King <brking@linux.vnet.ibm.com>
Subject: [PATCH v3 0/5] hvcs: Various hvcs device hotplug fixes
Date:   Fri,  3 Feb 2023 09:57:57 -0600
Message-Id: <20230203155802.404324-1-brking@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: wFsqdlClzDJ9oqFHJrQGWDXX9r29bRPj
X-Proofpoint-ORIG-GUID: DnliEwiz7cefJN_-x3dEXZgoU0NLSshB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-03_15,2023-02-03_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 mlxlogscore=999 lowpriorityscore=0 spamscore=0 mlxscore=0 phishscore=0
 clxscore=1015 malwarescore=0 impostorscore=0 suspectscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302030142
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

This patch series fixes a number of issues with hotplugging
hvcs devices including memory leaks as well as, the inability
to reconnect to a console device after it has been hot added
back, since it was not getting cleaned up properly on the
hotplug remove path.

Changes since version 2:
- Change attribute groups to use ATTRIBUTE_GROUPS macros

Changes since initial version:
- Change to use driver default groups to manage attribute lifecycle


Brian King (5):
  hvcs: Use dev_groups to manage hvcs device attributes
  hvcs: Use driver groups to manage driver attributes
  hvcs: Get reference to tty in remove
  hvcs: Use vhangup in hotplug remove
  hvcs: Synchronize hotplug remove with port free

 drivers/tty/hvc/hvcs.c | 73 ++++++++++++++++++++----------------------
 1 file changed, 34 insertions(+), 39 deletions(-)

-- 
2.31.1

