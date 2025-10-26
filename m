Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 667DD25B1DC
	for <linux-serial@vger.kernel.org>; Sun, 26 Oct 2025 09:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761470665; cv=none; b=Wdhx0hiVfu/ViNyTdlSu/qfBbbFRIanqvV3js0ukd0D8K7fCXUTC08MUgUOrPrsf2/Yic8I+au3c0ismmIarDiH6gRBQ1AkQuCBO+xpCim1LCiAfu1P78ME5x1lZbF3WAWmjhfkYR9zmEWzaLIhOtPhqHYtp85BFbQdHIL+Siq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761470665; c=relaxed/simple;
	bh=Wsp8cxVy22klAhiDGv9P8tZ3IPZ7LUZzLpg3S21IfDQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UZnLjrPW+rP5+WN7ZOvFG7nJ2cyTBeUpB8Uw/2MC4/zI+rkcDmn1NR2VBIMNfVIvarq51D7cRY0IkJ+4szbGiteRc9tZImHxv07Ev6DiFjDrADXzC8xhX4iYy37EyQT1vm3jDSzxJqK/aF3PXpEDfeYqILp8yv3aAKnxbfFDYWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f1COdxsR; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f1COdxsR"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-78af743c232so3342442b3a.1
        for <linux-serial@vger.kernel.org>; Sun, 26 Oct 2025 02:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761470664; x=1762075464; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BdMa6HWGVI8flyxHcsiTS5cMCkPtytHGgTVFhKdr0DY=;
        b=f1COdxsR66WLD3OuqEA0Rq55Q7m+WcTFWN3K+XEtNYrDT6OAAOlsD/RryqO55LiNrl
         h9P00xlnr0e6ApQsFX3yaF3HsJhF5bQ2oUPa+aBI9Th+4aEUVvaM952ibhXm4BXcUVzk
         U/IBNL+sWV5aWsObI6N/v+T9LMQyMpC6nZ3hCpJM0pPwBHFsVVR4f8+d31buzQ5R3U85
         URHYHd7tZTqdSeGex1E4Ivc012NwgEV7kcSFXr/R4yk/kICCWRgqAAz+dsig46dFRvc/
         kuzS/BkiVeFd6dhUmt920KNpQnJ2cupgas2ECn/k11rYoOK7F7rDyxBG4x/7GOin6u4z
         19BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761470664; x=1762075464;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BdMa6HWGVI8flyxHcsiTS5cMCkPtytHGgTVFhKdr0DY=;
        b=Q8QdFp7g8G0xvsJz72A5YDXncQjFKXlDpudKCyx+7Jy47Ll5jsGwLSly8UJ6LDz1Yi
         BB2nsNztsOSQ8tiVkPuJE4UGG0FSTGVUUqCdnYP62KF3WntxO4sxj1TFAwsFUUEj4xa8
         BLyzEPhAnL7PMaSVsg7n2W8+E9MOecZnjc4IPmyZsCsZGfldwnMaILJrw9PiWqYgvckE
         wnAWrSD4/gv8lAA9eSVCfExhmfcF12p8jRLyI5m1ZuILCmRl4mNNqxBPj5YwB97VjYI6
         TjchWSYaQKTwDgJBTNAAioCEZOYT2+bMd5libo+zhOEC//pEWOq8uGrhuzvfpBYLNYHp
         tqRQ==
X-Forwarded-Encrypted: i=1; AJvYcCVumApAe3aGVL93ce3lJpk6sKVsI3WQT2goQUtLLbyueb7FiEnGnVc/wEUYT7mYIgTYtJsBn5KNtB5hrU4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwR5tPtKbIlBMd8gMiUvB5E8Gs1E5QGkRFhp78KVYeuh4QPDl3N
	/rxKE/daBb8m9Inv7AGqH/oEPoYjzYgmMdd+X5xe+1Ve5LZWd3lTTk0U+TYnZ6s/
X-Gm-Gg: ASbGncv52wdld2cRl+B4/buuSqjLYw8BSgi+OOcmnCw1z4+U/sq579TdfRMUqY1XSQa
	FzdnnF55kJLLB7R291X0j768icbhkKQe+d9r3olZ8E9FGn05JH/O+siQPkRBRiepT5+ifCPNsSi
	IJj4kXlOuhCQffsABVJjz2fn3pqpDOeEdlpWQo3D3Pr0m7fsYMMJNDVlDcwabhNRqFNwxwYroxR
	Rxjeefq8b7T6HBjBvGEhcVukFhKLKeP/PguBgEM+NIqx/1IrHmgI70A7XUsIX3zG5FJ+wCnWsSf
	3Vgz4hFY6hg2Zdmpk8VnVH89EzyDVUuKmQB1g5hfmiHPx6VN+bvuzcsPv83p0jnvz+eEc0G1ZeI
	ERm51GpB60ysPlznV/enSecKqWletMeOdWr9K1d0OrI3nZkfdur/QeNlEVX3tyshqU1XlfHCKbk
	8zVBNWZW8DrtSgHybw69Y=
X-Google-Smtp-Source: AGHT+IGvbZctqDawrbvVj/YWwiaibKLUONAPApFbeuXnBVOb80OZCjV/x8ZAeq0wItW2If52JQqywA==
X-Received: by 2002:a05:6a20:12cf:b0:334:a681:389c with SMTP id adf61e73a8af0-33de967f61dmr10026226637.15.1761470663538;
        Sun, 26 Oct 2025 02:24:23 -0700 (PDT)
Received: from kforge.gk.pfsense.com ([103.70.166.143])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b71268bfaa1sm4063316a12.7.2025.10.26.02.24.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Oct 2025 02:24:23 -0700 (PDT)
From: Gopi Krishna Menon <krishnagopi487@gmail.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org
Cc: Gopi Krishna Menon <krishnagopi487@gmail.com>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	david.hunter.linux@gmail.com,
	xandfury@gmail.com,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev,
	khalid@kernel.org
Subject: [PATCH v2] selftests: tty: add tty_tiocsti_test to .gitignore
Date: Sun, 26 Oct 2025 14:52:32 +0530
Message-ID: <20251026092341.2896-1-krishnagopi487@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2025102633-dandruff-clang-e91d@gregkh>
References: <2025102633-dandruff-clang-e91d@gregkh>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Building the tty selftests generates the tty_tiocsti_test binary, which
appears as untracked file in git. As mentioned in the kselftest
documentation, all the generated objects must be placed inside
.gitignore. This prevents the generated objects from accidentally
getting staged and keeps the working tree clean.

Add the tty_tiocsti_test binary to .gitignore to avoid accidentally
staging the build artifact and maintain a clean working tree.

Link: https://docs.kernel.org/dev-tools/kselftest.html#contributing-new-tests-details

Suggested-by: David Hunter <david.hunter.linux@gmail.com>
Signed-off-by: Gopi Krishna Menon <krishnagopi487@gmail.com>
---
Changelog:
- Improve the commit wording and explain clearly why this change is needed.

 tools/testing/selftests/tty/.gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/tty/.gitignore b/tools/testing/selftests/tty/.gitignore
index fe70462a4aad..2453685d2493 100644
--- a/tools/testing/selftests/tty/.gitignore
+++ b/tools/testing/selftests/tty/.gitignore
@@ -1,2 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0-only
+tty_tiocsti_test
 tty_tstamp_update
-- 
2.43.0

