Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 875B63FBEAC
	for <linux-serial@vger.kernel.org>; Mon, 15 Jun 2026 14:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781533573; cv=none; b=cclbnQBf5iEbRQaEdLT/Z4q5EG0f5B8dvQH3dNZX2cIiEk/cnaLYJBXN6SxKXN9mMvmiX9kODzwCxjEvaWQOGnaqq5kb+kHrVw9Ad9yliuVpJuSZBvkJrEEj2cTU53t7pQkq977k9TjDiHIPUeQ+3xoirW/sQA2k3Uo0Hk9hnBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781533573; c=relaxed/simple;
	bh=464aCXfvZzsZqwNbj4vr4SPbBTTx/rFyjRChfgFLlts=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=laqPkAiVUgCVkzp/D6O4Ky1t0oVYGhvo5ORncHsU/yyTYLd2EMpFKY1QcAomEe/TA0AU5QKVS8hGVYmYsKyukGnjieoqQfFa/wfQ8a09CrZX4T95wICa4bkTMs5cKq2cOXFX8sjFsmrm4PG7WUs0asM1wgBt7PoZcR8uuV/p4Fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--himanshubatra.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KvujyCLt; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--himanshubatra.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KvujyCLt"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c860544c077so4365012a12.3
        for <linux-serial@vger.kernel.org>; Mon, 15 Jun 2026 07:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781533570; x=1782138370; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YEF2OMYK714HCc6CoMTDE62CnJ76NkStyu/hySqrREc=;
        b=KvujyCLtMhQIWYaATafUOYnjK4B9utybyu8YpaL/R6FqW0vrRk7o+mJ6Dx+Mvjcy1x
         QdARbhkWqETcp8j23cqr6+0XziHl+RodK3k6HJSmVdC5rnx2xYWGweShDczBhVaBSpJu
         QBeXwk6J6AhYU8MsxSMY3CQbYuYLt2eMN8D0v3+634FaPgaJIsSbKcQ+gPNK4bYfwo0z
         nwxht+x3arpiCkNH4yqVcomBwG+hF99cmYAsgELr+bXjSwft/u81bYdwTXkF7PyOhX/w
         6Eo9y9RYiZi04qT0ZTt7ICsFd370SRe1wz0hDeDUIX4IdV9eoZl2mjY5IXl69b+VkSrG
         j4YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781533570; x=1782138370;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YEF2OMYK714HCc6CoMTDE62CnJ76NkStyu/hySqrREc=;
        b=BhtvHdbiA75sAcVEAICl7VW4UfM25roL8fouZo/0TbVsAe0oLOgCIUZkWZLib/hThK
         mK0C9t11HddNBxHgZzB0s6mlaNArtDTZhC7/a7bL4FdFGjPzpk7mrbVz1v+zOwiCQOHw
         xaj+pX6fU4DpBo6wiyMuu8PN4A8om8lYsd6AXNiL9oN4e8NGabwLhE4cO2m2Z2Cj63dz
         NSMnIiGlF3N0P1x2cgAZ3THhWz8uABwXaFAtUulpTKiN+T0TWACiupDhxUsT+SlTKyM2
         qXkIwHjZif/GUimT7pgmXEhc9dJjbRm9SGOlDK8b7/5Fw0VV4RcQA4ehGdFB9IfmclWX
         itSw==
X-Forwarded-Encrypted: i=1; AFNElJ+WjVRdlhVfhuVjm+Ye89GqZqp/z9LUQMq4AwYhpvrAHe+Ohz+uNQ7GIiKMuZGwSh3tIFGrQM82i6gFHcE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxuj7EmJPbaB5/iz4Uyr3I2EY/8xh1HHw9rS5jOPCNUL+fei7ET
	QD3lTOYamMT8ViT0qVdTcLK4yGn6jxzj5OH4B+14Yke3lu1JoswulE/l4ipO1OvlwUk/MzyuL5W
	+2tN7dUtzUTqNbBH2gYDMO/iRnsOJYuQLCg==
X-Received: from pgbcp3.prod.google.com ([2002:a05:6a02:4003:b0:c85:1159:ffbd])
 (user=himanshubatra job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6300:220d:b0:3b4:7aae:1ef4 with SMTP id adf61e73a8af0-3b783b4269cmr16496594637.9.1781533569483;
 Mon, 15 Jun 2026 07:26:09 -0700 (PDT)
Date: Mon, 15 Jun 2026 19:56:05 +0530
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.1189.g8c84645362-goog
Message-ID: <20260615142605.2795757-1-himanshubatra@google.com>
Subject: [PATCH] ufs: Add HS_GEAR6 string in power_info/gear sysfs output
From: himanshubatra <himanshubatra@google.com>
To: Alim Akhtar <alim.akhtar@samsung.com>, Avri Altman <avri.altman@wdc.com>, 
	Bart Van Assche <bvanassche@acm.org>
Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, linux-scsi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	vamshigajjela@google.com, manugautam@google.com, 
	himanshubatra <himanshubatra@google.com>
Content-Type: text/plain; charset="UTF-8"

In power_info/gear sysfs, currently it supports output only till gear 5.
If operating mode is gear 6, it is giving output as "UNKNOWN".
Add support for HS_GEAR6 string in sysfs output when operating mode
is gear 6.

Signed-off-by: himanshubatra <himanshubatra@google.com>
---
 drivers/ufs/core/ufs-sysfs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ufs/core/ufs-sysfs.c b/drivers/ufs/core/ufs-sysfs.c
index 99af3c73f1af..d1f5041fc3c8 100644
--- a/drivers/ufs/core/ufs-sysfs.c
+++ b/drivers/ufs/core/ufs-sysfs.c
@@ -54,6 +54,7 @@ static const char *ufs_hs_gear_to_string(enum ufs_hs_gear_tag gear)
 	case UFS_HS_G3:	return "HS_GEAR3";
 	case UFS_HS_G4:	return "HS_GEAR4";
 	case UFS_HS_G5:	return "HS_GEAR5";
+	case UFS_HS_G6:	return "HS_GEAR6";
 	default:	return "UNKNOWN";
 	}
 }
-- 
2.54.0.1189.g8c84645362-goog

