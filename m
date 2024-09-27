Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1EA08467;
	Fri, 27 Sep 2024 02:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.166.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727403226; cv=none; b=EQ5DdaFiKu/yd8XY5fJrRwWNW9Smam7WxJXAcc8VgZAqwxSC9Oa26P+JL12EXEnxAMnxOph4OhjpOOF0sjf28juxWXUXiJ2gloRR2EptceHO+P98Txa6CaS0Hx+tJWndZ2FNn76YxpDDsK1jK1NWP2O7hlQ86maildpyPmQeRAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727403226; c=relaxed/simple;
	bh=YLFzYQuBP3w8Ms/jaGDp8hR9hPfwcZeRccyqsB5OIJE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SpGOLtwpPP0iMcTiPkTeMU7FPiZYYWeJ5J2OW3s+BjvREftTML2hffaDfprNHTyAMY+xWqCiUi2g8Fph29f4E7myw4F2sbfzEBjeHIaQOWe3M0gcZ2r+vsoWuSj3xxYYJ+TVJaO9x0MRKhpPBcBF0grQGmjG7sqjJfz/W7Qb+4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=none smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48R1E91x024498;
	Thu, 26 Sep 2024 19:13:25 -0700
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [147.11.82.252])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 41um554766-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 26 Sep 2024 19:13:25 -0700 (PDT)
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 26 Sep 2024 19:13:24 -0700
Received: from pek-lpd-ccm6.wrs.com (147.11.136.210) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server id
 15.1.2507.39 via Frontend Transport; Thu, 26 Sep 2024 19:13:23 -0700
From: Lizhi Xu <lizhi.xu@windriver.com>
To: <syzbot+8a192e8d090fa9a31135@syzkaller.appspotmail.com>
CC: <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>,
        <syzkaller-bugs@googlegroups.com>
Subject: [PATCH] nilfs2: add ratelimiting to nilfs2 message
Date: Fri, 27 Sep 2024 10:13:22 +0800
Message-ID: <20240927021322.4088706-1-lizhi.xu@windriver.com>
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
X-Authority-Analysis: v=2.4 cv=Z/q+H2RA c=1 sm=1 tr=0 ts=66f614c5 cx=c_pps a=/ZJR302f846pc/tyiSlYyQ==:117 a=/ZJR302f846pc/tyiSlYyQ==:17 a=EaEq8P2WXUwA:10 a=hSkVLCK3AAAA:8 a=edf1wS77AAAA:8 a=t7CeM3EgAAAA:8 a=LDpvdhc8yH1BBIb8LwkA:9 a=cQPPKAXgyycSBL8etih5:22
 a=DcSpbTIhAlouE1Uv7lRv:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: 4GI1dUwKHwzKocWMQag0VJbcgDo1UDeL
X-Proofpoint-GUID: 4GI1dUwKHwzKocWMQag0VJbcgDo1UDeL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-27_01,2024-09-26_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 phishscore=0
 priorityscore=1501 suspectscore=0 clxscore=1015 mlxscore=0 malwarescore=0
 impostorscore=0 lowpriorityscore=0 adultscore=0 spamscore=0 bulkscore=0
 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.21.0-2408220000 definitions=main-2409270013

Syzbot report a task hung in vcs_open.
When rec_len too small in nilfs_check_folio, it can result in a huge flood
of messages being sent to the console. It eventually caused tty to hung when
retrieving the console_lock().

Reported-by: syzbot+8a192e8d090fa9a31135@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=8a192e8d090fa9a31135
Signed-off-by: Lizhi Xu <lizhi.xu@windriver.com>
---
 fs/nilfs2/dir.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

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
-- 
2.43.0

