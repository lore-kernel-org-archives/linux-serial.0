Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A4D01E2852;
	Sat, 10 May 2025 01:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746840991; cv=none; b=jXnaFpLNvXrwTIbe04sNRwwfYO9k/6SDKK7LAkf3IJce9QBg6/du8510Y8qIkf87xOorSJbfLI6kpm6Wgimdi5e6IqghPAhXO1Zql2VBQCt8rY+wKBcymGcb0xLxZ2Zynyfktl1AuFBqttkwnP2njuzjLN4D8IYWdQ6hSsLecD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746840991; c=relaxed/simple;
	bh=JqYUP0gYITpwIO56NDGK79wZtTPw/VgY4gE78t6lC9s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eX5Ju4spoQm5+A3zNO++DIK+PnJ1JJRgfx8aXXZkXplBbouQSHafWm6lCqbN8IieeHpYX4+bTJD6eSTFf7U6cES2DkkcaGkrO1myfZOuAjrCQJ5QMCk7XSxPeXdmf5SvaiMjHp1EsEpZFLIfTlp9IBtuaWXKWn3slUequ6+umIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FELXjd7n; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FELXjd7n"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-22c336fcdaaso28122155ad.3;
        Fri, 09 May 2025 18:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746840989; x=1747445789; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wD9SkKboBNMZ2NtG53GX3UU3m+Xh67ccGkM3pd0hqvQ=;
        b=FELXjd7nuqd4aVfe0keq+aClN7yUecO2YYtWdYDAOKSpe28UnEa2stwMkbB7+TIIpL
         N7aM28w9JwErPXsf6+QN5JTl6rQdBKGQwEGg8tGZBIDVK4qu79PHvn1c+bqC6nASLTnC
         nEJ5hZYh2JVaF7/3ZBQVWxWzQ7BBExjY2l37tUYSOfAJWByFFGS9rr4ASMLPiK2mZIWZ
         cBI2TkPfHp5d/qGSNnCjHssnpcjF3OUSXzPvGeFmyS1lCphOzUNt+OWzdbleMkZSo+gY
         o3DGp7QTZNf9cHUAXiQTE+wNvWrW+iys48nK2Zdcs6uPTu1Yl7WFbxj0A14PDwl88S8r
         wPnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746840989; x=1747445789;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wD9SkKboBNMZ2NtG53GX3UU3m+Xh67ccGkM3pd0hqvQ=;
        b=C5W5oD1zBkan5FSajYHX8To05TEbM9RR2sAUwiq5XZK6Ent/wt6Z5c6FB5LiobrLlr
         LZ5nl4mlY9oDxB4FtjPYvZfuPOYRFXAYUClPhLRyCiRcJNZBzn3OWsN+Pe7RI9MphYtS
         zOEFu5UjFnqoRYeyNXHKFTWEEGLWVgzehrXbSCHMHlXHB66xutcaGylEfZRXZiYcTaB4
         nng4Ly42mLITefTkaedXqW57hYSEMII/PtXcxXxA3In6UXVthuCrjF6lJalH0/y5nCiY
         B9n9F9cYaD4LEGNQgzLxDPvOjcXSlfAr5rOL1s6XheTezNHq+0roDI2WmOetJ4LM51XP
         7Trw==
X-Forwarded-Encrypted: i=1; AJvYcCV7JDIQwYxI52ujTKlKZzVO/QCFv4mxFDmjE1RrEOmlvP6URVifKm8N5wr2Zie5YITdouwbkqLgs1F+iSlk@vger.kernel.org, AJvYcCXxJgZpjy2Lq+I/E5y4nQzVvvEwcHmcvdrpvmh97I/YhO6NaxPPH2lXMVia/X0Ab413+/IASYfoOfu/Brs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyj+pmG1QFh1SAFg7wkwX3odDtF7lkPBDM83bn3Dz6Q6Ot2PkFB
	X0iylSK90p5/vu7tTKwHHD28xGhH59hppTwxpPLh2K9rGn1kIkYA
X-Gm-Gg: ASbGncuyQ7oVO+i8J10n/2wP88T2pvse6HAKO+hqsybZrdwKLxwqi88P4zS4nyTUbis
	6b68cCoQbQ3cOkojzfOb9JeQBf6hic2iaCg6trZtGhA7H2D6DYTjTekvgOdfpAfTt6By5MYMfMH
	tc0M7y+S+sTCvCQ+b7IVsicanaUF5R14jeg9UffTZnGvu6YEj07mSyW+jgXrvIn3MHFjdprlbti
	BccqZWd6rQJEtockDrNUyHYtqlpXKgJXPZXQE0Np6fEaXWhCVsywMmqwL61svlKx/RnD8lgt8Pt
	PsYNYD3jwmf4BqJwjg+V38aMWXj+HhiB/OT4LIgDWPWZO3GOBErR6ULF2U2odzaNDG68deQJZmJ
	zR0sNRoBCZztsyGbAuDThRZK0NdyCJGHdwmChkQ==
X-Google-Smtp-Source: AGHT+IENg0QA4pDDrAf5YXcYOBv5jJnYgaomoJkaWvWaHINOGGkwFUMAt+vGF529iQB2hgnXBoY+FQ==
X-Received: by 2002:a17:903:1904:b0:22e:4d64:821f with SMTP id d9443c01a7336-22fc8b56982mr61314845ad.20.1746840988708;
        Fri, 09 May 2025 18:36:28 -0700 (PDT)
Received: from localhost.localdomain (p12284229-ipxg45101marunouchi.tokyo.ocn.ne.jp. [60.39.60.229])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22fc8271bcfsm23902965ad.125.2025.05.09.18.36.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 18:36:28 -0700 (PDT)
From: Ryo Takakura <ryotkkr98@gmail.com>
To: john.ogness@linutronix.de,
	pmladek@suse.com
Cc: Jason@zx2c4.com,
	gregkh@linuxfoundation.org,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lkp@intel.com,
	oe-lkp@lists.linux.dev,
	oliver.sang@intel.com,
	ryotkkr98@gmail.com
Subject: [PATCH] rslib: Add scheduling points during the test
Date: Sat, 10 May 2025 10:35:15 +0900
Message-Id: <20250510013515.69636-1-ryotkkr98@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The test has been prone to softlockup but stayed unnoticed because
of the printk calls during the test resets the soflockup watchdog by
calling touch_nmi_watchdog(). With the commit b63e6f60eab4 ("serial:
8250: Switch to nbcon console"), the printk calls no longer suppress
the softlockup and warnings can be observed more evidently that shows
the test needs more scheduling points.

Provide scheduling points by adding cond_resched() for each test
iteration on their up to/beyond error correction capacity.

Signed-off-by: Ryo Takakura <ryotkkr98@gmail.com>
---

Hi!

The discussion on how the printk was preventing
the softlockup can be found here [0].

Sincerely,
Ryo Takakura

[0] https://lore.kernel.org/all/202501221029.fb0d574d-lkp@intel.com/
---
 lib/reed_solomon/test_rslib.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/lib/reed_solomon/test_rslib.c b/lib/reed_solomon/test_rslib.c
index 75cb1adac..322d7b0a8 100644
--- a/lib/reed_solomon/test_rslib.c
+++ b/lib/reed_solomon/test_rslib.c
@@ -306,6 +306,8 @@ static void test_uc(struct rs_control *rs, int len, int errs,
 
 		if (memcmp(r, c, len * sizeof(*r)))
 			stat->dwrong++;
+
+		cond_resched();
 	}
 	stat->nwords += trials;
 }
@@ -400,6 +402,8 @@ static void test_bc(struct rs_control *rs, int len, int errs,
 		} else {
 			stat->rfail++;
 		}
+
+		cond_resched();
 	}
 	stat->nwords += trials;
 }
-- 
2.34.1

