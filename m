Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9137F19DF4B;
	Tue, 10 Dec 2024 13:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733837696; cv=none; b=Bn/C4DkJcG+nGeKPIbtcGZsgDPBeuMGObP58U3V1mRW/ji+6kvAIWM4a/IK1sVzM0987FhQjq6N7YGg04jhxWXLZUtfolw2d3on8+skrW+YrsD3S0iS2T5j4KwgmIvqB5wvLNS9rdlQ0/AOX500fBj9wHoSkF8UtigETiGze4LY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733837696; c=relaxed/simple;
	bh=xCNtIGvZnNIu5/QbFT3pZymo7sFLzI6Gj4+mZZnRzu4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R5Y4CD0/YAWch74P7T2XGvsGLrD6PuBSYFv4QCJSyUeRwIgqnyIJDThD9tJCiG+F/703GRhAgow7ZXepVcV6y5J8sEPAL9Ot3iSHuo9L78G4joKVW3ydXMqP+s9lD5/rCRZXLdemRcBNk/zS6EtzTaqxtVmFd8+WkIhPwQmldhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AYTJLaRU; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AYTJLaRU"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7b6c8b11407so148994985a.0;
        Tue, 10 Dec 2024 05:34:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733837693; x=1734442493; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bKV6ykmIkdoQNyGHHuYy+sKRiD2AqpahzC1WLoezEII=;
        b=AYTJLaRUCcq6YYLFx4X+2zu74GLUsZi3k9g3LG5OWT3iCF/58K3v6y/axjWM/60lmh
         TsUsDbSk3J5kKVIt624p+c53xcDLWFC/bYn7Vuk6hdNKLaxo7vofvVhAKRkYbbKUrYCi
         3fTBf/GNrw5YeY4XDZXtPKaqJhVTFa/g87yVGYcT1OIVHFykYkP2CpHhoAIHTy4licPw
         94wV3VmNVgm2nf4mp9wL1/xUuqnCukflav8ZQ9SN1VuirXDIYpCVW1xFSBcul9FDKOsL
         uXn235dSuG7lwerqi28A671k2EjtEHFu6LOOHd1JKeQEGqbdjq8diVSTKZYZjxOlNfQV
         pYAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733837693; x=1734442493;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bKV6ykmIkdoQNyGHHuYy+sKRiD2AqpahzC1WLoezEII=;
        b=j9CQyN7Xc4xDRP7rtI+yAazLajOwiUo4/aRLrhrLt22kJM1HPdpnMOva692jtbm+KR
         OY500o831Oi8/SdwpLPWGgRtYVt4juopj/LVI0fGgphFKMXD0UbGbFpQbTljcX+zEa1y
         kBdM22XZlty8exD2iX0EepGVMrP7Wx4T2KAwzaRrK928tb0tWoV6n2zdZ8Xlw+HrMJrA
         T3Zh/BFmgTJ1tYjSFKu6wPCWGJoAm+muatH8jWyxzT0LbD9L2KKQhWioJ2SDESmOWJaH
         2NA+5E8u8ShqEODqIuh96wTqHMolZjnBL3nwQzbYj7sbMXqYyHRkR7niLRFmRBv9IPsZ
         2K0A==
X-Forwarded-Encrypted: i=1; AJvYcCU0lxRt1ZgoMGkcwfPjwSJQBSqDELTzvi4fPNDiHtwrDLC1NSVGBjcGM19iU3nIyYSI2/XiXZAV34dqNrsf@vger.kernel.org, AJvYcCXJxr0eN/5Ob2i+gkdM4OTZ8rYongTqgyrNUNGAwxOwSUhvxY2EB+59srHfR/C60fIQkpg9suhH3kThHqRUqfA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3YfrrGof53v0yfZ13Ks9H3AkBgtBV5rXI4FGMfsdNoMnIO++z
	kfm649fPo5wRRl8Zk3wKaKMtv8nYRINv8yx3rdffgLabipE6980j
X-Gm-Gg: ASbGncuaL7KY0WUaxUtoOezRgVx2gz2+bxuBxHySfCyPpif/wqWta6Otu8J6EtmIFFn
	t8bw69UOye3+asagApFdL5nphe/tyS51jdct5shqEChczRTEE78gH1AubJ3clAE2w34Y/0alTW7
	dDKYPMv98lbFvfxONaunhXAGyw8gqylGhqwVvyoOJT3OHw9P0EdxmTxVHVlzt3FMMex7sv2VeZq
	rFYcmd6i1Q9u1omzB24GwAgcxXARlcwWMh14u6deLgJa+I=
X-Google-Smtp-Source: AGHT+IEO5V91IXkAUxJIMMTguBq9T2vS6FkhMCRazvler4aaNFZ5+3hngvqMaFkv2Gl//Wyc6mFSXQ==
X-Received: by 2002:a05:620a:1a94:b0:7b6:7aab:418f with SMTP id af79cd13be357-7b6bcb64d24mr2550058685a.55.1733837693414;
        Tue, 10 Dec 2024 05:34:53 -0800 (PST)
Received: from localhost ([2a03:2880:20ff:13::])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b6d8aea6dcsm162677285a.107.2024.12.10.05.34.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 05:34:52 -0800 (PST)
From: Amal Raj T <tjarlama@gmail.com>
To: danielt@kernel.org,
	dianders@chromium.org,
	jason.wessel@windriver.com,
	stephen.s.brennan@oracle.com
Cc: tjarlama@gmail.com,
	amalrajt@meta.com,
	osandov@osandov.com,
	linux-debuggers@vger.kernel.org,
	linux-serial@vger.kernel.org,
	kgdb-bugreport@lists.sourceforge.net
Subject: [PATCH 3/3] kgdb: Add command linux.vmcoreinfo to kgdb
Date: Tue, 10 Dec 2024 05:34:48 -0800
Message-ID: <20241210133448.3684593-4-tjarlama@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241210133448.3684593-1-tjarlama@gmail.com>
References: <gmail>
 <20241210133448.3684593-1-tjarlama@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Amal Raj T <amalrajt@meta.com>

Add a new query `linux.vmcoreinfo` to kgdb that returns
vmcoreinfo to the client using the mem2ebin encoding.
Maximum size of output buffer is set to 3X the maximum
size of VMCOREINFO_BYTES (kgdb_mem2ebin() requires 1x
for the temporary copy plus up to 2x for the escaped
data).

Signed-off-by: Amal Raj T <amalrajt@meta.com>
---
 kernel/debug/gdbstub.c | 10 +++++++++-
 lib/Kconfig.kgdb       |  1 +
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/kernel/debug/gdbstub.c b/kernel/debug/gdbstub.c
index 6198d2eb49c4..5bec444fc6d3 100644
--- a/kernel/debug/gdbstub.c
+++ b/kernel/debug/gdbstub.c
@@ -34,13 +34,14 @@
 #include <linux/uaccess.h>
 #include <asm/cacheflush.h>
 #include <linux/unaligned.h>
+#include <linux/vmcore_info.h>
 #include "debug_core.h"
 
 #define KGDB_MAX_THREAD_QUERY 17
 
 /* Our I/O buffers. */
 static char			remcom_in_buffer[BUFMAX];
-static char			remcom_out_buffer[BUFMAX];
+static char			remcom_out_buffer[MAX(VMCOREINFO_BYTES*3, BUFMAX)];
 static int			gdbstub_use_prev_in_buf;
 static int			gdbstub_prev_in_buf_pos;
 
@@ -768,6 +769,13 @@ static void gdb_cmd_query(struct kgdb_state *ks)
 		*(--ptr) = '\0';
 		break;
 
+	case 'l':
+		if (memcmp(remcom_in_buffer + 1, "linux.vmcoreinfo", 16) == 0) {
+			remcom_out_buffer[0] = 'Q';
+			kgdb_mem2ebin(vmcoreinfo_data, remcom_out_buffer + 1, vmcoreinfo_size);
+		}
+		break;
+
 	case 'C':
 		/* Current thread id */
 		strcpy(remcom_out_buffer, "QC");
diff --git a/lib/Kconfig.kgdb b/lib/Kconfig.kgdb
index 537e1b3f5734..012529eee79e 100644
--- a/lib/Kconfig.kgdb
+++ b/lib/Kconfig.kgdb
@@ -12,6 +12,7 @@ menuconfig KGDB
 	bool "KGDB: kernel debugger"
 	depends on HAVE_ARCH_KGDB
 	depends on DEBUG_KERNEL
+	select VMCORE_INFO
 	help
 	  If you say Y here, it will be possible to remotely debug the
 	  kernel using gdb.  It is recommended but not required, that
-- 
2.43.5

