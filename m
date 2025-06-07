Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 078C325A2C7
	for <linux-serial@vger.kernel.org>; Sat,  7 Jun 2025 02:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749264872; cv=none; b=UwJSgrpLN/NPDkshLU+hYK8zbtmxu2YxSDGTYEVjE4m4ECxKGst2mHg+oybOrCG+4hYH+3KxpOPLgpUPzGkHPXDLSRZN93yIcLDdZFqrLOV6jUKmA2DTSX8dy1Wgw78JG3A7ZghI5408PPRmLVoDHW1IVD4codXOoZyWjQxatV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749264872; c=relaxed/simple;
	bh=ZiQkH309SsPv8lN8ObW99ERD0AIPkQszerT12qHwgsk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=alMW8YcMsGQaQ4dI7Oyy3uruslu3C9P1MqUv+udJ6P/uiaaOj70bFlfAa2sFwqAbxOYwVY0mxARPtldXtt6Xe2KyOgG4vWkWE4UHzj9vVGmpMc4Ne3mQaTTm5cAZr3Ue/leP2KqjaVBGVwUV67IdLINEcMCA1qN9ouoN9Bd9NYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=QseZwSqS; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="QseZwSqS"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-451d54214adso23536315e9.3
        for <linux-serial@vger.kernel.org>; Fri, 06 Jun 2025 19:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1749264868; x=1749869668; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X/JKVoHG52bM7iYj5PS7gTiSERcG5UqrCOig8DJiksU=;
        b=QseZwSqSj0+A5J2VqodR6bP8uCtr+YN/25CKSwPgCAYSqOaOq9nWxcTUNf26G4W72m
         5nWvitpDE/jzkLGoDXgsOQ5EyKEC5fphVEWkOgTDaAX+KERF/Vz6hayl31vB55Pjo/Hc
         5BHp3p+BQCeC0+Quo0/K+3MIUg17U0iLN+cnH+33Es34KDbOetvEKwwAVT2E1O3H5XoB
         i/3J9jSZ1PUgw3twgxNM6ZzwzgT3Z2S3vgSdvTZmVjDc7bGch1tAaSdkm+06eAxVZey+
         f86/7ro+EGaVf0HlqSHH3oF4ywDmmoexk9KjMvYmLCY1bc5UMiMKlNPwk1gYrjhisnzP
         7YMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749264868; x=1749869668;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X/JKVoHG52bM7iYj5PS7gTiSERcG5UqrCOig8DJiksU=;
        b=GgKR/vmevvU2pm7X85Op1T4CoZAXAqC09jkBp5KEFBKwnK4vfjjF9CbcA0+aBrCWxP
         2ATj/7F0Qe0spimSRai7Hgvm/l8i49vsBpxS2RrYWCDBEvYK8mZZUH2X+u2ya5pCgb4o
         iVcaHVZtOlkC/NB0h5El2AI4ZE8TWXkXt6MTBLdfCUKy0NeajnOQkvhnrQGaYljk5gti
         35it8Bk0fcjLf5UjEH53O9Mb2tE56QGUuv5sWV/aEl/uZz036e6hWB31NSZEJzNvTP4e
         +FYR6rxq84ML8DVUWJnkVi6aoYwwpVa8DXJYyV9ifu/k09CP5FrH4YmXDVxI+uE6Q014
         fWZA==
X-Forwarded-Encrypted: i=1; AJvYcCWxUptcV/FpYlmY3ewY3BsUium2D9++JRLOc/t+JQ9HbxRRXltL3n+3dvz0zEAuD+KEymR0jmNdYGw408o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1Mv1ImNEqYeYQnXwGGERzkNJFKs4OCJh6lA28XCHVIjbgKFQC
	PRcECz6xtDjl/sReM5rnVNhNwOqGvZcWKx+Ch8PMNVtHq+Swtn39GOEdVSZlCgh5UO4=
X-Gm-Gg: ASbGnctXqsAaM4P6JqwjlFP0INyvccGe6ax+WZS89RjzXUa8gaz24nA89e4ij2aqZUG
	LdEt4Vbyeqgr/b6oqb2EDJzfCpq+d6oHx07MsrMdj0pN6HJZ5yR/rWTsbjdfpBKXtpsuPRGDvgw
	3Kn0Jd+aqT9wzbWC8lXsnoldZRN+UmgB1U4guZAR1z7KhQAAcZ6z4OahvEXsunnT60K2UJgg9tU
	lykjbUskPZrcN/hQRdnBKYpu4+vd15YRwcYAfWKhVdk1ICD2FmEjRYCCX0b4yMeJBSdHPTb4pPE
	4i6C04oRSPLNAXquXQWxYX19kG+UPZE76JDt8BMF5snX4yjv
X-Google-Smtp-Source: AGHT+IH5d/vDAJyZSz6fuV0j5C8IVfGiu/PKk0FvmAPHACrM59+l4DsDYjrQIDTW1PtMdxhQU8+9aQ==
X-Received: by 2002:adf:e705:0:b0:3a5:39bb:3d61 with SMTP id ffacd0b85a97d-3a539bb41abmr1337284f8f.27.1749264868362;
        Fri, 06 Jun 2025 19:54:28 -0700 (PDT)
Received: from [127.0.0.1] ([2804:5078:80f:b600:58f2:fc97:371f:2])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-530e6429475sm2005465e0c.45.2025.06.06.19.54.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jun 2025 19:54:27 -0700 (PDT)
From: Marcos Paulo de Souza <mpdesouza@suse.com>
Date: Fri, 06 Jun 2025 23:53:47 -0300
Subject: [PATCH 5/7] arch: um: kmsg_dump: Don't check for CON_ENABLED
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250606-printk-cleanup-part2-v1-5-f427c743dda0@suse.com>
References: <20250606-printk-cleanup-part2-v1-0-f427c743dda0@suse.com>
In-Reply-To: <20250606-printk-cleanup-part2-v1-0-f427c743dda0@suse.com>
To: Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, 
 John Ogness <john.ogness@linutronix.de>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, 
 Jason Wessel <jason.wessel@windriver.com>, 
 Daniel Thompson <danielt@kernel.org>, 
 Douglas Anderson <dianders@chromium.org>, 
 Richard Weinberger <richard@nod.at>, 
 Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
 Johannes Berg <johannes@sipsolutions.net>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 kgdb-bugreport@lists.sourceforge.net, linux-um@lists.infradead.org, 
 Marcos Paulo de Souza <mpdesouza@suse.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1749264832; l=916;
 i=mpdesouza@suse.com; s=20231031; h=from:subject:message-id;
 bh=ZiQkH309SsPv8lN8ObW99ERD0AIPkQszerT12qHwgsk=;
 b=jWqGiPKl/XV1kWO8hkwg925xr1q6tsYBxos9FuxBE92z/Pq14tW6oRTqYnah8nuO92j1JK2AA
 efZNwgbsN74BdsXUFSv+HbPRvTzvr8dhPJfS5pW4gOs10Hl/GEHry89
X-Developer-Key: i=mpdesouza@suse.com; a=ed25519;
 pk=/Ni/TsKkr69EOmdZXkp1Q/BlzDonbOBRsfPa18ySIwU=

All consoles found on for_each_console are registered, meaning that all of
them are CON_ENABLED. The code tries to find an active console, so check if the
console is not suspended instead.

Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---
 arch/um/kernel/kmsg_dump.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/um/kernel/kmsg_dump.c b/arch/um/kernel/kmsg_dump.c
index 4190211752726593dd2847f66efd9d3a61cea982..f3025b2a813453f479d720618c630bee135d4e08 100644
--- a/arch/um/kernel/kmsg_dump.c
+++ b/arch/um/kernel/kmsg_dump.c
@@ -31,7 +31,7 @@ static void kmsg_dumper_stdout(struct kmsg_dumper *dumper,
 		 * expected to output the crash information.
 		 */
 		if (strcmp(con->name, "ttynull") != 0 &&
-		    (console_srcu_read_flags(con) & CON_ENABLED)) {
+		    (console_srcu_read_flags(con) & CON_SUSPENDED) == 0) {
 			break;
 		}
 	}

-- 
2.49.0

