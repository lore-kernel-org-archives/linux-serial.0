Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 989BA259C92
	for <linux-serial@vger.kernel.org>; Sat,  7 Jun 2025 02:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749264865; cv=none; b=Mn6lgHXqyXS1mGd7vCYPt2NcvD+viHWUwKRq+mWrnJR7ANHER5PdQppqOkE7RRZfk3ojY1NuV0zrFSt3pGTi/y4k+4TY5R2yqe5EzqPK00GxLj4of7pzOrVrUklPyt3a0CT/fMiEILD7Vny6A0Uu4FJpEI3P5x0L+DsuXS4ZNjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749264865; c=relaxed/simple;
	bh=YnwRdm6I1xYkzMWD2CGBnm+ACwq/qI6QghdxR3iROfM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DRbOjC22x9t5Ea5ZbTLO0Jpf4AYiCOhKizNVO7Rmb+4SCWXGOgZ1J5TdFKnGZ1t5anfkgwNGUMix6Zo3diEMRxLP8VcC3I1JpS/fjnPMn8mzWjiL6DYoXGRGSpqIYSnSg0Sb8UGiCaCYd3HC+g8aOKmK4rzSHpdLYK1zqk/AjQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Qf5MZWxJ; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Qf5MZWxJ"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3a5257748e1so1869969f8f.2
        for <linux-serial@vger.kernel.org>; Fri, 06 Jun 2025 19:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1749264862; x=1749869662; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yF8FpTtagcV7Kwh1mn8c83YxOz5Y2vKGfOZjELVv36A=;
        b=Qf5MZWxJexFH2124i8pTNAGf8WOmsLQuRV0YRcPwUcHKnWCVLR/Ov9pMgu/CvpeoT5
         /Av2Tn+Y5CbkHdil95WFsrvifakKs/Itn6GibO8NVHc5ib5wLOmCi4ZnYQu8Gwcl92LC
         3aDkIu5/5u9YJBMdj6pY6bp+5FV4VnqRHBBUJOQ+/bG7IPzmnXzuV+1FYOw1dVX+gxuW
         i0vxwVhdZutMruF10HHARyj3Az+HR/k9FmNzs5tcjmoulbT3ljSf0hhWKSBZPnK7Dlt2
         ZkGfIaALuoqAS5MVLtZwazrM5of55OcOB0olfKhpnjE9mpyH/4AlDC1XGC9/ILGSGqul
         n9MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749264862; x=1749869662;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yF8FpTtagcV7Kwh1mn8c83YxOz5Y2vKGfOZjELVv36A=;
        b=KDoip4FeN1SIGuAvyCZ33p+VKq61gowXngGGWl6dYK6YRtfmwVCX4n/eUp8rGlcdMS
         54urhtflmcKhkynE0zrqIyKfOsk2//21eLzfr+8fxqKq7IWY6HiLaCtsMzUtKRVsWmmh
         dAEcIa25GHUkg3Ya+BV+e6TQ7hiEcNp8VBKBp5OeOuAm2iauwJ6/IH4aoqA9wVplPfQu
         +kEIlGwAj/ZiDybD39N50529UZM+0ThfBaGi7GTsnQNmrDExpxU0Rb31otEbR4q4SnRP
         bR1m8fjnKyQVXV/Z0iYfoAL+Csrmw6IZzeVCR/Lo6tdyUDufI1sROzUAaMCWf7K+EE2z
         Vi1A==
X-Forwarded-Encrypted: i=1; AJvYcCWSKO+ErYOasSetp4GW+RLmyO78161i2IWgTMU7yjx+H4u3HUJd7oKZKcMQKLgnr2u4LwiUZJV5kH3PxSc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzmj0k2/CXjNKLQcyrVeNVcqOEAC1i0bPFq3bGw4VE9vXV3ixG5
	IvFCBHOqxlDCtSgqow0TZlzN7nzsxaFQxnxFAv/H2pQPXVCKZEHYQwsYGdzUmQWQaJc=
X-Gm-Gg: ASbGnctEV5hNLA1UXyhimodlbzz43YDBiAglRE7HrOAuEUuKc8ZTLcjIZSk7KTouGKJ
	j9+31wXGV+dxE4YqAAc2Ghs8RMUEsSgsSH8QJ+l/TqTE/c0A7hFdJmxlJeBMSnVCieBdchvX1+S
	mPXH98NhGjNMrslCiJ445jq3KcoMc8O1Q3T92T0C3YbeDqmPkpjMFQynm4s0P9LXf7/1Oy3HaO8
	oQhUmK89JsrStgqTprQTPHNHweB33U8tDs/ieyTftTiajIVpRsW43fwRnyQy4wZyxVfGKFEK5ya
	b3ZlJHpZ+Ol5izfOgFN8AvHA3Vwhz253d6pke0lzeLp+N+490ZKe1WLlJ2Y=
X-Google-Smtp-Source: AGHT+IEkD+heqmJq9m8IHeuM06OadoFmpx1jvpTqHM7h9oaBrwao22/Hk/I57LZwA/2jHABWh1ERAw==
X-Received: by 2002:a05:6000:1a8e:b0:3a4:d0ed:257b with SMTP id ffacd0b85a97d-3a531786a6cmr4798069f8f.22.1749264861807;
        Fri, 06 Jun 2025 19:54:21 -0700 (PDT)
Received: from [127.0.0.1] ([2804:5078:80f:b600:58f2:fc97:371f:2])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-530e6429475sm2005465e0c.45.2025.06.06.19.54.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jun 2025 19:54:20 -0700 (PDT)
From: Marcos Paulo de Souza <mpdesouza@suse.com>
Date: Fri, 06 Jun 2025 23:53:46 -0300
Subject: [PATCH 4/7] drivers: serial: kgdboc: Check CON_SUSPENDED instead
 of CON_ENABLED
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250606-printk-cleanup-part2-v1-4-f427c743dda0@suse.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1749264832; l=966;
 i=mpdesouza@suse.com; s=20231031; h=from:subject:message-id;
 bh=YnwRdm6I1xYkzMWD2CGBnm+ACwq/qI6QghdxR3iROfM=;
 b=cqiZ/O0p08p72ACNj+Qgo78sWzdqazBUHR38ZvlGqr0UR3ruYfxho4i+1leIYi6KW5or2wglX
 aqm/XqqSk0/Dl9v/iYzwAQDXRcTlLt/HqbQYzkxp32RFtqmxiFoy6EG
X-Developer-Key: i=mpdesouza@suse.com; a=ed25519;
 pk=/Ni/TsKkr69EOmdZXkp1Q/BlzDonbOBRsfPa18ySIwU=

All consoles found on for_each_console are registered, meaning that all of
them are CON_ENABLED. The code tries to find an active console, so check if the
console is not suspended instead.

Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---
 drivers/tty/serial/kgdboc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/kgdboc.c b/drivers/tty/serial/kgdboc.c
index 85f6c5a76e0fff556f86f0d45ebc5aadf5b191e8..af6d2208b8ddb82d62f33292b006b2923583a0d2 100644
--- a/drivers/tty/serial/kgdboc.c
+++ b/drivers/tty/serial/kgdboc.c
@@ -577,7 +577,8 @@ static int __init kgdboc_earlycon_init(char *opt)
 	console_list_lock();
 	for_each_console(con) {
 		if (con->write && con->read &&
-		    (con->flags & (CON_BOOT | CON_ENABLED)) &&
+		    (con->flags & CON_BOOT) &&
+		    ((con->flags & CON_SUSPENDED) == 0) &&
 		    (!opt || !opt[0] || strcmp(con->name, opt) == 0))
 			break;
 	}

-- 
2.49.0

