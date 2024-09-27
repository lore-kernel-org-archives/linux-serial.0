Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4765175A6;
	Fri, 27 Sep 2024 01:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.178.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727401109; cv=none; b=cW17DiQx559IdMxsj57nA3NvblZgU2wOjTmFjxDTFWSrdrnvztJls2FR21eXMjm1NQxdSx21jbY8RbQFsvVkAsiRNcZl3fE8rM5vuH557YhD5RIc+280shc2qWwCBcxlwZYCJCAV5jRle6OvxRCfO/a/pwjrRXfVVne3jO14tgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727401109; c=relaxed/simple;
	bh=RFMgsxGWA6jHKUjTL4AOy1zLiEFB0ZQqxoNQTkT9KsM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qjcb+jrXaNA6/x0YmAyFGxRmo4aSrx/IUZcQVS/nhKmfpv+7/hD41KxzT0sfPe9t9vcHWncgzn4FvDJMk31/BLl807XJ5QYcCWC07lbS1aakZ5BVTOYjrsq/RWBQUgQ+3yFCeSpG+KlPFvV19aNJm9p34CJUzyO8an7FIw3itnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=none smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48R1C17T014934;
	Fri, 27 Sep 2024 01:38:10 GMT
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [147.11.82.252])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 41um4xm5pt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 27 Sep 2024 01:38:10 +0000 (GMT)
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 26 Sep 2024 18:38:08 -0700
Received: from pek-lpd-ccm6.wrs.com (147.11.136.210) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server id
 15.1.2507.39 via Frontend Transport; Thu, 26 Sep 2024 18:38:07 -0700
From: Lizhi Xu <lizhi.xu@windriver.com>
To: <syzbot+8a192e8d090fa9a31135@syzkaller.appspotmail.com>
CC: <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>,
        <syzkaller-bugs@googlegroups.com>
Subject: Re: [syzbot] [serial?] INFO: task hung in vcs_open (8)
Date: Fri, 27 Sep 2024 09:38:06 +0800
Message-ID: <20240927013806.3577931-1-lizhi.xu@windriver.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <66f59678.050a0220.46d20.0001.GAE@google.com>
References: <66f59678.050a0220.46d20.0001.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: S9kiBEm_eWgOkCvufLN35p62j20z56Jv
X-Authority-Analysis: v=2.4 cv=e+1USrp/ c=1 sm=1 tr=0 ts=66f60c82 cx=c_pps a=/ZJR302f846pc/tyiSlYyQ==:117 a=/ZJR302f846pc/tyiSlYyQ==:17 a=EaEq8P2WXUwA:10 a=38vPcNaityxn9kY69L4A:9
X-Proofpoint-GUID: S9kiBEm_eWgOkCvufLN35p62j20z56Jv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-26_06,2024-09-26_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1011
 spamscore=0 lowpriorityscore=0 impostorscore=0 mlxscore=0 phishscore=0
 malwarescore=0 bulkscore=0 suspectscore=0 mlxlogscore=969
 priorityscore=1501 classifier=spam authscore=0 adjust=0 reason=mlx
 scancount=1 engine=8.21.0-2408220000 definitions=main-2409270009

limit the nilfs erros message output

#syz test

diff --git a/fs/nilfs2/dir.c b/fs/nilfs2/dir.c
index fe5b1a30c509..0a89dda75414 100644
--- a/fs/nilfs2/dir.c
+++ b/fs/nilfs2/dir.c
@@ -32,6 +32,7 @@
 #include <linux/pagemap.h>
 #include "nilfs.h"
 #include "page.h"
+#include <linux/ratelimit.h>
 
 static inline unsigned int nilfs_rec_len_from_disk(__le16 dlen)
 {
@@ -115,6 +116,7 @@ static bool nilfs_check_folio(struct folio *folio, char *kaddr)
 	size_t limit = folio_size(folio);
 	struct nilfs_dir_entry *p;
 	char *error;
+	static DEFINE_RATELIMIT_STATE(rs, DEFAULT_RATELIMIT_INTERVAL * 5, 1);
 
 	if (dir->i_size < folio_pos(folio) + limit) {
 		limit = dir->i_size - folio_pos(folio);
@@ -148,9 +150,11 @@ static bool nilfs_check_folio(struct folio *folio, char *kaddr)
 	/* Too bad, we had an error */
 
 Ebadsize:
-	nilfs_error(sb,
-		    "size of directory #%lu is not a multiple of chunk size",
-		    dir->i_ino);
+	if (__ratelimit(&rs)) {
+		nilfs_error(sb,
+			    "size of directory #%lu is not a multiple of chunk size",
+			    dir->i_ino);
+	}
 	goto fail;
 Eshort:
 	error = "rec_len is smaller than minimal";
@@ -167,18 +171,22 @@ static bool nilfs_check_folio(struct folio *folio, char *kaddr)
 Einumber:
 	error = "disallowed inode number";
 bad_entry:
-	nilfs_error(sb,
+	if (__ratelimit(&rs)) {
+		nilfs_error(sb,
 		    "bad entry in directory #%lu: %s - offset=%lu, inode=%lu, rec_len=%zd, name_len=%d",
 		    dir->i_ino, error, (folio->index << PAGE_SHIFT) + offs,
 		    (unsigned long)le64_to_cpu(p->inode),
 		    rec_len, p->name_len);
+	}
 	goto fail;
 Eend:
 	p = (struct nilfs_dir_entry *)(kaddr + offs);
-	nilfs_error(sb,
-		    "entry in directory #%lu spans the page boundary offset=%lu, inode=%lu",
-		    dir->i_ino, (folio->index << PAGE_SHIFT) + offs,
-		    (unsigned long)le64_to_cpu(p->inode));
+	if (__ratelimit(&rs)) {
+		nilfs_error(sb,
+			    "entry in directory #%lu spans the page boundary offset=%lu, inode=%lu",
+			    dir->i_ino, (folio->index << PAGE_SHIFT) + offs,
+			    (unsigned long)le64_to_cpu(p->inode));
+	}
 fail:
 	return false;
 }
