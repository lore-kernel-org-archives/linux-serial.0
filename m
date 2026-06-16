Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55B5C3DC4A0
	for <linux-serial@vger.kernel.org>; Tue, 16 Jun 2026 08:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781598689; cv=none; b=JxTwwaeyOip26IW69/ojq+3hprXqm1GvrV9qDXdA5qtYunRbmwNnjiArqHA6iKIclxpbdWdcRxA9sWXjhvwwMifKnMHMcrNIxOkFA3qBZm5uKR34nSUQIQX6wHJNtnCLU6IOxph++ZqMx3o5G+isdJyU0kd87aN0qC3iWum1VJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781598689; c=relaxed/simple;
	bh=U1CCaUEUj+Uj+CZV2pR4dhrK2VZTd4Us+SMggdhLU1c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MQgTp9KfYwD6Z6a3H4VUN/fKrVQdYV5r0dt+BpVNZ5HZxOykJN5Kl6aUo9XwVvza95knZA/Y+cLV6bSIocbfDf1lrRcFcZMIDECP67bsX3Xg7LxhZi+mMB7gK4MIubkhX/CX2g3t9/vliK9M1GV22aDK7LfPP8hGsCVONeqEyG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--himanshubatra.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iENWB1pM; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--himanshubatra.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iENWB1pM"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c86487a8ce1so4423206a12.2
        for <linux-serial@vger.kernel.org>; Tue, 16 Jun 2026 01:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781598688; x=1782203488; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=cCVWn/Tak5xeployam8KSgFpW0BNc4qS3cakDpS+Z1Y=;
        b=iENWB1pMK9wFOwnSvWgTLY/9nmPdi5hEl7Yxs2AShcQz1xhV+Zkd6m1zWrrHVtqGJ4
         ix+oaIli8SDiKgavrBCzHpycMXTjLA5voJFbUODnfa+6tNZE6qmTMu2zU5UE/u+vgcOw
         jTUx6EfYnwTkAytYu6Q07cyOZU8mMoCB+UKzXNcVGvUKlLdc1+Yk/V6okzcC40tm35lk
         rwPni9iWtBpyAohkeqxjWPWGPhQm2U6t4q+A/CTjJ+PsG6RjXGHXepXR33lgwpd+uLPh
         Lb25Kd/OGQUdpPxpQViucTUnVFiCLNhaMeb+duX9s+4CdLORe8c0Ne0r9JRCKSZUQeDt
         b2xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781598688; x=1782203488;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cCVWn/Tak5xeployam8KSgFpW0BNc4qS3cakDpS+Z1Y=;
        b=PxIt+5RzcpRAd1sp7yNkSZCoEn6QvWqVcWWERD0mmGa4Hg3FVVwhMdyom/Vn4kAZ+W
         eO9Es/HfWSJFNpx9L55r5PjAy5tBHR3p5wD6TYdRsbqA1+/HAPhWvWFOtv8bh9aHujRQ
         pTrlpIuVCeNojqZfrxd0iU8DdaNNjXWOzCzYWa+Nu1ou0ERCL7ms1tv8g2VCqmOs4fEZ
         hBpYnKFA3KhW9N9HZg5cU2+FnKvkOz9qrtFlgotHX6FP3x6gbL6BZ/3Auvn7YK0ZTQrl
         yDGujOQTR16pLUHO6BixQArfybIWTIYJetFSuRPElfaPqkju+05FG+IeiGEfHa4C97XR
         4nRg==
X-Forwarded-Encrypted: i=1; AFNElJ/jEAIa7FqaoVawXdsONkQp5YvWI4q7JhNz54PUepHSTwp0Utx/2GIDBnuvj/8Pgmxxtpi8QXq6JK9B+Js=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKzS6N/NyDrEwRI1x6/bsTh6BLKsImmX31/9QCz52UM7ZVNBqw
	UsPNtqAUbKTv3UheJctbGyOmNeyLfDZWD84lzS7f1NKsftSLYNsjczxRdTZ6uKhC7AF609s0CWv
	z8Hr+wTgymuExIVyFzHoOS1PI64xRCy7hHg==
X-Received: from pgc13.prod.google.com ([2002:a05:6a02:2f8d:b0:c82:283f:132f])
 (user=himanshubatra job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:7d01:b0:3b2:b1ed:d1df with SMTP id adf61e73a8af0-3b796363482mr16795836637.29.1781598687366;
 Tue, 16 Jun 2026 01:31:27 -0700 (PDT)
Date: Tue, 16 Jun 2026 14:01:24 +0530
In-Reply-To: <CAEif7DR3KUdhPww-q_Fn6gR6L=V5nrD3EyLn3vi+hWLmS3eU6g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <CAEif7DR3KUdhPww-q_Fn6gR6L=V5nrD3EyLn3vi+hWLmS3eU6g@mail.gmail.com>
X-Mailer: git-send-email 2.54.0.1189.g8c84645362-goog
Message-ID: <20260616083124.267262-1-himanshubatra@google.com>
Subject: [PATCH v2] scsi: ufs: sysfs: Add HS_GEAR6 string in power_info/gear
 sysfs output
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
If operating mode is gear 6, it outputs "UNKNOWN".
Add support for HS_GEAR6 string in sysfs output when operating mode
is gear 6.

Signed-off-by: himanshubatra <himanshubatra@google.com>
---

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

