Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5909425CD9
	for <linux-serial@vger.kernel.org>; Tue, 16 Jun 2026 10:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781604087; cv=none; b=DyqQyMvKCSpjzPNuA3B9pR+eCqbh0TwxLM/DpahkvMRoNUEornXSIV3ZyjfaFKk4X3WYxvgvg3RLuob5aK0ElfeRgWP1Y5S5GTtW6wKUekz9HXWyiBuOOL6lJQ+Oir2xHEAP54h3KT/mNKmH8rz7tl/HF3KkslNcB4F4Npjg7nM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781604087; c=relaxed/simple;
	bh=5YPRfJtwZLRFV0Jul74SWkiWszu9PKIMTqshqX3gRC4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MPaI8HJ0fJdG602gQj1fiFdKWbP4xdSscH9auKl4CBqobpB7aFVVB/KATPT8PUUdJWypP5v6BUZaNeUlGyL4mstBXBH49/04e/Cw2ySyDLZdN5zzWu/IQBua107/jYtNDfGsrBD0gsKpZAvsiAN21RhO+1jZUyvZUFp4P3mtaok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--himanshubatra.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qBIbsy/U; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--himanshubatra.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qBIbsy/U"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2c0a99db8dfso42222985ad.3
        for <linux-serial@vger.kernel.org>; Tue, 16 Jun 2026 03:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781604086; x=1782208886; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=21NwLBUNehqApSlGBHg1TEkC78aGT7ZEdik5YJarQwI=;
        b=qBIbsy/UqjPJLydHZeh7Zalb+Yjd8JUvOPoMqwpWBptnstR6DahX9ekvbqWTkgnw+m
         RF1v72XCMGvC6LkXtf4rE3q9QjfW+J6kcq7ETjrTNXJQLwmDPE5mZTodmlMhF+jbntF5
         QhxDge5eI1NDRl7+6rXjJ3g0506Hk96ncRVPnrezVObUGfkYsLTcvLESL5hEKi+0PcQw
         BrXEulus9YW4KYkIoS/9L49mYkMff1tU8+rwJx6ep7Y/+a1I5MMVW+4oY5v4M7qpTFy2
         gSKwM1jvuKO8DlhVi9X3UqtYSoJw7yaoTbYFojQ2YFwUtgmc2ySjtvSH4HNq+rWeEpWL
         vLbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781604086; x=1782208886;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=21NwLBUNehqApSlGBHg1TEkC78aGT7ZEdik5YJarQwI=;
        b=Gd155LYlNkwPuVPiAVEj0h5uY19oK5Xa+udbOpksmJQwIeyWb5NZGJBYD/B9bjqZgI
         it3Xj1i2JvDQjvAP2QmHVZj4sMxXVjKTM48rykZEf1DaLTxq+B+3P79gt8txj8UfJ0MO
         daWQF58jprkUSNTsjMxJE2BhwzueAdj04rx1j6UI6xt1mSTUXl1B2JmdK8xoyLoTwsVc
         tzu0+U18+ciVlVLgr4Yxa8nbhpFoEo8pIr1HYlE6mlpUnv/0friV/C2O8hwAJSIUc67g
         v1mcVf+jPJxw1fsRgmYuokmvGlOeX5XyrgbIFFd0eqFrvJKiFRtKjkLJeMjvyPLB+mDW
         6MYg==
X-Forwarded-Encrypted: i=1; AFNElJ95Jdpb8q6vWpXwQ2scx0zgqy1HLOCxSbYWMPWzmj1FLI+MvxqFhzXv1ddtUUXh8jqrG2rVoiDZE0PaJm0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yws5L+mTzncl9l2RCwU8fGK7YmQ0NcZSv3Bp2RLA1ew6HSJR2Qv
	3q/eM9EbRgPRg6zeT9pMxgYNFhZsFgrWlFEoJ+XzIgHlSLaB1t1Edojb/uTNRmXd6/Oc8zV8Om9
	XMTpYmQmNkVog5u5RICJ9KnWJQ7ps3iNiyQ==
X-Received: from pgao66.prod.google.com ([2002:a63:4145:0:b0:c86:1337:acfe])
 (user=himanshubatra job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:c6ca:b0:3a2:f75f:73ef with SMTP id adf61e73a8af0-3b7e4d4fdf1mr3252491637.37.1781604085919;
 Tue, 16 Jun 2026 03:01:25 -0700 (PDT)
Date: Tue, 16 Jun 2026 15:31:21 +0530
In-Reply-To: <2026061659-enjoyer-boogeyman-25c0@gregkh>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <2026061659-enjoyer-boogeyman-25c0@gregkh>
X-Mailer: git-send-email 2.54.0.1189.g8c84645362-goog
Message-ID: <20260616100121.548759-1-himanshubatra@google.com>
Subject: [PATCH v3] scsi: ufs: sysfs: Add HS_GEAR6 string in power_info/gear
 sysfs output
From: Himanshu Batra <himanshubatra@google.com>
To: Alim Akhtar <alim.akhtar@samsung.com>, Avri Altman <avri.altman@wdc.com>, 
	Bart Van Assche <bvanassche@acm.org>
Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, linux-scsi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	vamshigajjela@google.com, manugautam@google.com, 
	Himanshu Batra <himanshubatra@google.com>
Content-Type: text/plain; charset="UTF-8"

In power_info/gear sysfs, currently it supports output only till gear 5.
If operating mode is gear 6, it outputs "UNKNOWN".
Add support for HS_GEAR6 string in sysfs output when operating mode
is gear 6.

Signed-off-by: Himanshu Batra <himanshubatra@google.com>
---

Changes in v3:
- Fixed the identity alignment issue: updated both the 'From:' line 
  and 'Signed-off-by:' tag to use my full real name ("Himanshu Batra")

Changes in v2:
- A slightly better comment.

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

