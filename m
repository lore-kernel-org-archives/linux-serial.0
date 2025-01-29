Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A37181DF992
	for <linux-serial@vger.kernel.org>; Wed, 29 Jan 2025 16:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738168059; cv=none; b=hpCRzoLK6WchwjWDjNUqsPHPgSuQ2phUaU1tJWg5XNKOplOta28FaTYG0kf4aBA1rG3YQXAFQp/nUBqTwHnDrsNaKANgxRKNHfRQ3AWkRaAerbEwK3IdFiUZcAOG8zz+S82jIB5vRPJnUWipzSPwB84EMKrnDp9Oo8onSBx7FCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738168059; c=relaxed/simple;
	bh=95ti/EtNpoooFEon5wbA1jBQ2db4r1XuLvR1Tv/exrQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RGD4LBiR2w9IIrGv2jxH/tCj8rcLPQaLOXEL9XqzA90Sco3xkgrEvSTETzgMb8AF6mPfnff48R+75LjJy1jhDndPei8r3gYeckHePrYQ+TK/uyL3g6AFUFlfYwRRJunm9LTK5VkIoJjbtf/AlFfuQQ2abT/qxUrPGet21aXisI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=nHznBXQK; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nHznBXQK"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-21628b3fe7dso128291685ad.3
        for <linux-serial@vger.kernel.org>; Wed, 29 Jan 2025 08:27:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1738168057; x=1738772857; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GHZ2KPsF4COFgm+b5LCKQGhzh/Bu/7L9BM3q7wjetag=;
        b=nHznBXQKy71iPu3Z+/xGr7pw/XOVnc9TC0065py3OcxI/B9AwAVYkSYzKCFm8w1vzV
         bDiLVZ7kkBP+Qj8bZ+1HY/x9vHE59RFGpqR7urnZqn6kgL0lqfD9gWsIeIpvWjEbj48H
         IFbxCqKnJSgYxLSbBT+hurugvvyDOgd4p97SI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738168057; x=1738772857;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GHZ2KPsF4COFgm+b5LCKQGhzh/Bu/7L9BM3q7wjetag=;
        b=PlwT4HHqGhwo0hxUsU+CRJsa05XlC95ID/0XW8Uj41WLHpbRWwyiPhB33k/X228YM+
         pJsp0BQI8r8nmwoxS56nSJxG27+e2lRFCPa52rWoetVfvw+7pRyt+CZFMpysTanA3ts7
         gLI3+M8JP69erhtfd62+ZR+/wV6BQ0hNy9+bZqR5ibA5bSeFlMlN5Gt/jzouOxy+0nsQ
         mCfVN2hcnUE9MVVl2cKyFiCEVIkEe6wH3SUpG44p1yVJAoJzZxLJQbaoEqipZHC2ZQWv
         wL5wi4mjVPa25Rg4VnGTMDV/uji4o6aOS9mB8hvv9HcUba69mEj//Ev7pCGQR/sJMgxK
         hEyw==
X-Forwarded-Encrypted: i=1; AJvYcCWd8uWFU5SUZEKMLXSTQ4ONK/xPG8t4gCWnV4TNWWZHExztdwMmQVm0DB8Lj9pj5QwcuPetrJ8kvK/F1uE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzmw7q1+XxHfFOpPx0IAfzUbZIRqkrZ2YtYNCxRf+WTMC8FtfFl
	tc0tz3lqgJoZPID+NKnvG13R9zObxRvhdSaX4XfWNI7gtMHCTwZ2709JctKu6w==
X-Gm-Gg: ASbGncuvdwRp8BRTq/ejiE3Gv4k4cRLbpLMTAsKxUXEZns3eho+fmfxGjWOsqfVwuWn
	OhSkkuPaoApmQBwq2d7eRpFOftxNGw0/gNx8ZTYWi7cPfaqBoYaisnL4jv+QFJvwqtMFwUHzj9h
	hjFhSKyNDcCcZgUOAYyEAoSO7icmKYhjWH6HdcVrWlwZ/pgj2nEy9t2iSzs9y9AGxsUow1YslRd
	Hj9uVBjlNr/egM6YQK99pRumYLq11KDbDU7B1i4WkoQ4eudpUJd1iI4zgdXQCNKeHlBtZ+i6qB2
	xhU8/Tdvyc4C/FCRT56bIZJIZ0TacVNSHXQ=
X-Google-Smtp-Source: AGHT+IEk/aQhe7EQCRd7H4ZWjZQuegTa1eAwg8ILNMsYIINEo4OJU9VMXs6WW1rI8GzMVr3E6kOBgg==
X-Received: by 2002:a05:6a21:b8a:b0:1ea:e7be:ff27 with SMTP id adf61e73a8af0-1ed7a5b6781mr6359250637.7.1738168056947;
        Wed, 29 Jan 2025 08:27:36 -0800 (PST)
Received: from dianders.sjc.corp.google.com ([2620:15c:9d:2:fa8a:f68a:6cb9:40b2])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ac496cb4810sm10577009a12.66.2025.01.29.08.27.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2025 08:27:36 -0800 (PST)
From: Douglas Anderson <dianders@chromium.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Daniel Thompson <danielt@kernel.org>
Cc: "Dr . David Alan Gilbert" <linux@treblig.org>,
	kgdb-bugreport@lists.sourceforge.net,
	Anton Vorontsov <anton.vorontsov@linaro.org>,
	Sumit Garg <sumit.garg@linaro.org>,
	linux-serial@vger.kernel.org,
	Douglas Anderson <dianders@chromium.org>,
	Jason Wessel <jason.wessel@windriver.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] Revert "kernel/debug: Mask KGDB NMI upon entry"
Date: Wed, 29 Jan 2025 08:25:52 -0800
Message-ID: <20250129082535.3.I2254953cd852f31f354456689d68b2d910de3fbe@changeid>
X-Mailer: git-send-email 2.48.1.262.g85cc9f2d1e-goog
In-Reply-To: <20250129162700.848018-1-dianders@chromium.org>
References: <20250129162700.848018-1-dianders@chromium.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit 5a14fead07bcf4e0acc877a8d9e1d1f40a441153.

No architectures ever implemented `enable_nmi` since the later patches
in the series adding it never landed. It's been a long time. Drop it.

NOTE: this is not a clean revert due to changes in the file in the
meantime.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 include/linux/kgdb.h      |  3 ---
 kernel/debug/debug_core.c | 14 +++-----------
 2 files changed, 3 insertions(+), 14 deletions(-)

diff --git a/include/linux/kgdb.h b/include/linux/kgdb.h
index 14739952698b..5eebbe7a3545 100644
--- a/include/linux/kgdb.h
+++ b/include/linux/kgdb.h
@@ -257,7 +257,6 @@ extern void kgdb_arch_late(void);
  * hardware breakpoints.
  * @correct_hw_break: Allow an architecture to specify how to correct the
  * hardware debug registers.
- * @enable_nmi: Manage NMI-triggered entry to KGDB
  */
 struct kgdb_arch {
 	unsigned char		gdb_bpt_instr[BREAK_INSTR_SIZE];
@@ -270,8 +269,6 @@ struct kgdb_arch {
 	void	(*disable_hw_break)(struct pt_regs *regs);
 	void	(*remove_all_hw_break)(void);
 	void	(*correct_hw_break)(void);
-
-	void	(*enable_nmi)(bool on);
 };
 
 /**
diff --git a/kernel/debug/debug_core.c b/kernel/debug/debug_core.c
index ce1bb2301c06..0b9495187fba 100644
--- a/kernel/debug/debug_core.c
+++ b/kernel/debug/debug_core.c
@@ -837,10 +837,6 @@ kgdb_handle_exception(int evector, int signo, int ecode, struct pt_regs *regs)
 {
 	struct kgdb_state kgdb_var;
 	struct kgdb_state *ks = &kgdb_var;
-	int ret = 0;
-
-	if (arch_kgdb_ops.enable_nmi)
-		arch_kgdb_ops.enable_nmi(0);
 	/*
 	 * Avoid entering the debugger if we were triggered due to an oops
 	 * but panic_timeout indicates the system should automatically
@@ -858,15 +854,11 @@ kgdb_handle_exception(int evector, int signo, int ecode, struct pt_regs *regs)
 	ks->linux_regs		= regs;
 
 	if (kgdb_reenter_check(ks))
-		goto out; /* Ouch, double exception ! */
+		return 0; /* Ouch, double exception ! */
 	if (kgdb_info[ks->cpu].enter_kgdb != 0)
-		goto out;
+		return 0;
 
-	ret = kgdb_cpu_enter(ks, regs, DCPU_WANT_MASTER);
-out:
-	if (arch_kgdb_ops.enable_nmi)
-		arch_kgdb_ops.enable_nmi(1);
-	return ret;
+	return kgdb_cpu_enter(ks, regs, DCPU_WANT_MASTER);
 }
 NOKPROBE_SYMBOL(kgdb_handle_exception);
 
-- 
2.48.1.262.g85cc9f2d1e-goog

