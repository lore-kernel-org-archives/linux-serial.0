Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CAB6824BD
	for <linux-serial@vger.kernel.org>; Fri, 21 Nov 2025 18:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763751068; cv=none; b=SAt2Qtzw5d2BbGFPN7Ovu9z2co2JlhU5CaU0qvMLWW26ouRw3OwtGWrD9XLjPzd7s5EjgQstH8u+sklXEbHijJmfddVs28dlsNHComcVTHI63TGYAcrr+8Vp182K8OXTOmSLWU+bbURWlZMPZp7Qkna/lNhW2rXzD/KSjJ5K/Go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763751068; c=relaxed/simple;
	bh=OUGnBzAKcXkW36Da9OkzDufBeFjxJOoOBfhwdvnkuOI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PoMOCcSvdBUf0a8gEJWkztPjQ46ayLmpEoabNn1E7meczU/gfgckBTOpYWJ6pMree/CTYE0Fa6F6rTUD2ST+pIzUaXOu0gFW2O56yQwzS23lQIfV4FP6JHpj7PEtpZySnML36g9R0wyk+MtoBEiwSajxxqj9BLzyvB3td6xhv7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Nbjv2Um9; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Nbjv2Um9"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-42b3108f41fso1481222f8f.3
        for <linux-serial@vger.kernel.org>; Fri, 21 Nov 2025 10:51:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1763751064; x=1764355864; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OLWRSgS8p73WSC4ZXf7/hoyNCz/96zbrBiHTXVpyk3k=;
        b=Nbjv2Um92AUUggOxj2VY37XfUnBXytLv69xITDVHw/I9SHSy7pqc+pK8YRBUGjaawN
         S+OzOu6peGGmsUYFR8s4RW/UYxaxD7aQ15RO8V/KFG4Tt38FeSSN6SYdyj6QEsSqFvL6
         yLiaQ5mkT7yK1BWOYzP9UQv/CyRYcCtFqo/dmjWBBMO9CFMPrlIwEEdMKicNE6uw0Kzg
         Gh3rTZXQDc+Ke21WKYhXhEUdmsW5Vcvn9ifgYdfMKN6UPco7hVoP+8ioU33TwgwyLdzp
         PpfcwiC34DMPvgYUoVSPSWkkqwqT+z814SB6bAbHSYnzuBVwgMzTiORKQJS8/vGgUhEY
         3T3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763751064; x=1764355864;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OLWRSgS8p73WSC4ZXf7/hoyNCz/96zbrBiHTXVpyk3k=;
        b=egQh7wKhu8iXgvZfE5n+6/+Yr/Sk83or1mnBSNqPEcFNdDMY3wMRdQT8wiPMm6tzg9
         Tr9Xi8YaixJTfw/0eKcTCSojne01ZhVCd7Pq3p2t7vzGspowtw6e+kMae5jJtrXDp89I
         0QKRr37aab4tGGyAm0lB135vPEEuJk6lISSTA1O51U2uS+f2pDrFpshwkgRbmR5gX/8I
         FjTuKAqsIAM4GbBOhbQ0oIP/WLVW78Rlg1JPP5oaGL79Tu5iey/pjHYduOU9FgDuaP40
         vB//ZPUT/rOJuxCApPDyCp8fNPe4SFgPCLWaCgMJpvDDHnrCnqeDYcgF9IZXaBPdz1np
         vuHA==
X-Forwarded-Encrypted: i=1; AJvYcCW1AtMo5b9H0yVSLg/rO9mG3apAU+3QpkMV3J5mMwtL5Ogj5bmgIorK2fPwDIMvk0pdjboCkicLaWpUFdE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxr1gO32fKE34jJOMmQjRCdstqgOp69FcvsszLPc5W5ToX3D2QY
	uM59uK0BGc6LfaFc343+ZGQPINA6tArMH+KVrbAWys7amTQCf9p/iOxnREAJQS8LdKI=
X-Gm-Gg: ASbGnctx6doJkK9qNk6byWUVzruGKOSq1hwpjCVYzOeZ7BwLY333l+wavz8L8PbiXZb
	lyCeB7iN+DqnUwmyM9hylvpeKA+Ms+seVn9pbXTRJjOKLnqv/UNIhI86giivrtCDw4sVXg4Qleu
	HV+ZtNb7NgRDZopm/ale3GFNc2s5x/iLhRGa6hY8O3an0FZj4ugDmoD7vQzjkPOUIpOZDFchdC/
	Tu8dtVAGMrmUVrizhnSHSIMGlnIQHldrze3Ch8dCd9j8bczXmsSbuOCKVnfW9ASWEYiqFFN2hNx
	eTv8E4g5GARnGoBFzDL2i/bV0ZphYnGDgqDp97inats04nuLe4Sc7l0MocGPJHA2H07l8lpFTmA
	NEtCzvz5Deaxwmv+MryR3HbRnBfAna3aeuRHWbE5jB7wCxljMdNk1UApHvYiGNf3evIIpPhLHvl
	R0faZ36yUqPjGUww9C3BDcP+pbP1nMt7DNSIk=
X-Google-Smtp-Source: AGHT+IGFg2pBnIYtz+jUx29u1lZD8eVRjQQpeMqBKI00tlwv+iTZw9tV5Wu13Zv6ZTnAW9KrThP7uQ==
X-Received: by 2002:a05:6000:230c:b0:429:dde3:659d with SMTP id ffacd0b85a97d-42cc1d0ce1dmr3746531f8f.47.1763751064299;
        Fri, 21 Nov 2025 10:51:04 -0800 (PST)
Received: from [127.0.0.1] (99.36.160.45.gramnet.com.br. [45.160.36.99])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7fd8baesm12473639f8f.39.2025.11.21.10.51.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 10:51:04 -0800 (PST)
From: Marcos Paulo de Souza <mpdesouza@suse.com>
Date: Fri, 21 Nov 2025 15:50:34 -0300
Subject: [PATCH v2 2/4] arch: um: kmsg_dump: Use console_is_usable
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251121-printk-cleanup-part2-v2-2-57b8b78647f4@suse.com>
References: <20251121-printk-cleanup-part2-v2-0-57b8b78647f4@suse.com>
In-Reply-To: <20251121-printk-cleanup-part2-v2-0-57b8b78647f4@suse.com>
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
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1763751050; l=947;
 i=mpdesouza@suse.com; s=20231031; h=from:subject:message-id;
 bh=OUGnBzAKcXkW36Da9OkzDufBeFjxJOoOBfhwdvnkuOI=;
 b=NhgxbcLWcMIXgHoLmIkuyir16mphjDmcWSS+twRF1KgkvMiTNw7Q71Y6gddQptkBeT/ZV7ybA
 7aK6FXimEBMB8iP+Lld4HVVYCnfUvIZlIMUIC+Vdjx4lrgmiiIWXdaA
X-Developer-Key: i=mpdesouza@suse.com; a=ed25519;
 pk=/Ni/TsKkr69EOmdZXkp1Q/BlzDonbOBRsfPa18ySIwU=

All consoles found on for_each_console are registered, meaning that all
of them have the CON_ENABLED flag set. Since NBCON was introduced it's
important to check if a given console also implements the NBCON callbacks.
The function console_is_usable does exactly that.

Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---
 arch/um/kernel/kmsg_dump.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/um/kernel/kmsg_dump.c b/arch/um/kernel/kmsg_dump.c
index 419021175272..fc0f543d1d8e 100644
--- a/arch/um/kernel/kmsg_dump.c
+++ b/arch/um/kernel/kmsg_dump.c
@@ -31,7 +31,7 @@ static void kmsg_dumper_stdout(struct kmsg_dumper *dumper,
 		 * expected to output the crash information.
 		 */
 		if (strcmp(con->name, "ttynull") != 0 &&
-		    (console_srcu_read_flags(con) & CON_ENABLED)) {
+		    console_is_usable(con, console_srcu_read_flags(con), true)) {
 			break;
 		}
 	}

-- 
2.51.1

