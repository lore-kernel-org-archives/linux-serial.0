Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E933546FE;
	Tue,  4 Aug 2026 08:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785831882; cv=none; b=Z/hNuu3daNMeBK4AL4s3eOjPEdu8Kkn7pFsWgFpj5rE+mcsmK4PMHn/yF4J5L/OreLJiQRVmRiV4pBFwhj1hdmGf4ptf8fuXU9WUNqt52EF3zYuOlzdz1tk5oYjj08DWFFIOjm1H41wLVcA4E/SGha0T2cyo2yfEa67xCnbiknc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785831882; c=relaxed/simple;
	bh=gNyEw19VNBIeJh862qbAwoBo7n9soM4I5I7saeGHUqE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mqudAMPWJ9jjYtWhqJt0jY36K33kYxF62vd5RxF08HB6Eefq27DjjvaUPFeJdYCc4bkLa/CtegQs+O/Aif3tFnklYTDRaKTWPC8YHj1P6QbLh949yl4azG5MAKXpC3k/nBue4PsV2HocuiNmKjGIS2QIYBUBAnbRJxfnM+Cmub4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=T5ZdBAf6; arc=none smtp.client-ip=54.204.34.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="T5ZdBAf6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1785831823;
	bh=5VQvWEioEq6qW2Ogr0TniWNY+bCjJNgkIHVdkEwg5ig=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=T5ZdBAf6BVS4N6oeJyG7pCge/kRVhzQ/l317CR0MK8wxHRL19Yb2gPbsMDk6o4dR/
	 SVwGpVpyqafbKAeYF1a89xsJZKBkOKywFNQtx6ya22B4lBlHBAtTXqceiqao/vvjQG
	 88lIeFw1fgeJjXAS2NGY+30c+wL5SDdvHczdTohA=
X-QQ-mid: zesmtpsz3t1785831804t3a4685ba
X-QQ-Originating-IP: cuwUzVNCWN9OchoEj2juAlxhDaXOJ8fJJRm1S2eysPc=
Received: from uniontech.com ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 04 Aug 2026 16:23:22 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 7681933194378969689
EX-QQ-RecipientCnt: 8
From: Yichong Chen <chenyichong@uniontech.com>
To: gregkh@linuxfoundation.org
Cc: jirislaby@kernel.org,
	viro@zeniv.linux.org.uk,
	willy@infradead.org,
	kees@kernel.org,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yichong Chen <chenyichong@uniontech.com>
Subject: [PATCH] devpts: fix pty count limit off by one
Date: Tue,  4 Aug 2026 16:23:21 +0800
Message-Id: <20260804082321.884880-1-chenyichong@uniontech.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: Nw5WZPeltq7pFFK2Ie1EhgqiEFqLGWncDkj4Vorj9SD6QgX6SbBbAGsV
	Ye/eat/NPND0rdW70WgPznIBii9q9PbH3yIU6TepAIxHyv5SL38iPZ+siy+4eLcTCRMf67e
	NBqeUzw7WkN6pHuHE4KVDhTrom/He9+zZINTFe2siTWSUpdd6C0kkpALKCCL/TFMG7n72+B
	DgeqknZnvHvHh635VbnGnlSxxIo0c9XhH8xQZzXthC+qrEr/rLA+vG/XMGy03fjYUakY5ja
	DGEJ3KqKtjd9itu2acO++Vez1pPLiGhuukYUq2+Hv98snbc7YHC5ECR7UqWouywyE+jem68
	untYLsvklbvuIc+3d3hUZTsW8qWzx/268ESQdR5njhGAfN78ozhasPpJh5AjsFInK1W1qGw
	d7VifK0E8x27zVNGJ6wj8Yx/+8T4a3VcffrNMYlcaqcdhWB6DvMiVOwP1SaHQvmtah+70aR
	i6OHDqizTmlMX7IjxlGoBagMbCozibffLccrzVjRZ3E4yuXz3pYdzzpiAV6y/ij6QvCW9eI
	J+OegT1A/Y1U4p4S3jYL8wcnPXHT032uV1hhAtApQh/PMTjhP8ADwpLXrhprGBtAG5lpR4e
	GI7hkKZrormEWAUXqn/xzvC+657+flaZx1HmQF05xD2TGc0/gJCLo0Cq7d7dBnxDSZLUM4p
	SuFwU0UKOcBZdkEiko6/LoBm0Hii/yvioAus4E+X+VnlG0XhRA0UQvXbh8/9U0PynMfZB6j
	NghdD4jUw6G7jn8D+iKlDkF8S78gHlZ//iNi4ce0PL0vF15C7zPgBUiTDN9fyxyxPGG40JU
	SfBJKHYyL4tXRWezDzvADJ1PPeX+h8DD8j+2DHN609UI8mqkErHJyWUJ3qp69V6OaM/v1ch
	ISZnDaQFodS8x6GwXcZqP4TUYTGAkiARzEH0I/rejaQ04rUUCtnTQhP/hB5j2GsDUh0N8Ll
	zOIpt8zbZogAvQlJ8eYw3I7izWGlSa+W66+ABuj1sI3f6uFq0yjxedH/uAuIOM5dSeet9tg
	Rr0uVR4Gqt/Bm0p9BLomuBOgYjkZ9Es1Bc6DsOB+fU9ORdUZLe8fNY+aCkUwLrXacq2GZg+
	4zjNPmD/ntxU9YJriUylW8=
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
X-QQ-RECHKSPAM: 0

devpts_new_index() increments the global pty count before checking it
against the effective global limit. The check currently rejects a new pty
when the incremented count is equal to the limit.

This makes kernel.pty.max allow only max - 1 ptys. For example, if
kernel.pty.nr is 3 and kernel.pty.max is set to 4, opening /dev/ptmx
fails with -ENOSPC even though one more pty should be allowed.

Allow the incremented count to be equal to the effective limit and reject
only counts above it.

Fixes: 0f0a0e54a2a1 ("devpts: Convert to new IDA API")
Signed-off-by: Yichong Chen <chenyichong@uniontech.com>
---
 fs/devpts/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/devpts/inode.c b/fs/devpts/inode.c
index 9844dcf354ee..853cc4c03e73 100644
--- a/fs/devpts/inode.c
+++ b/fs/devpts/inode.c
@@ -467,7 +467,7 @@ int devpts_new_index(struct pts_fs_info *fsi)
 {
 	int index = -ENOSPC;
 
-	if (atomic_inc_return(&pty_count) >= (pty_limit -
+	if (atomic_inc_return(&pty_count) > (pty_limit -
 			  (fsi->mount_opts.reserve ? 0 : pty_reserve)))
 		goto out;
 
-- 
2.51.0

