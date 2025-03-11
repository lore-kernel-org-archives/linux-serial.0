Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 680491EB5FA;
	Tue, 11 Mar 2025 03:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741663914; cv=none; b=cRvBO5MRewofE3ursSZghtUBGRiA1SrCXzlOUm5qUSB0fEvusWoPekuVYYoEHqbq6y0YsHEz5UYo7DgR4P4j3JXYpg+NGpa1DN+IFsml8ueOcofzxZWnWQKSjriCTNmDFv/rYHIPGj51iUgPW5n/P1j4BFaRIe8CF2HNy6Y116Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741663914; c=relaxed/simple;
	bh=/Ur3QigqVe6BvuF6KFEyubm6FemNS7SrI3khZNNAKGw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RW2gp6GdkIduCClZ1bRhFRIsQk6Z9y3nj4gMPfYuZ1C5hX0mWKbUlp2RjhxKUq81hiF3dIAkunVuiJSpyH+XboGX6EKQyJXPo5NatnW7f7gBCx8ZR8uKgOV7EKUz4Nc5wD3z3h2UPwAbGJ4E7Em/rFP7YSGM1PBU/ACuU2QvhBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B8KVN98o; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B8KVN98o"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7c559b3eb0bso74089085a.1;
        Mon, 10 Mar 2025 20:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741663911; x=1742268711; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kA1OV3LCyCYIYiWIgM4V5RUECOenxGpsaM/3MlbJANQ=;
        b=B8KVN98olYm12ONIEbcAS8Ylw0IW/xtf136y7Ne99tX27sEMstvVqjmIS7MK5RX//O
         G72fyFQi0tMfZJhaXA8eeWhfi2NONPOp5guBZOAiyjazL1gG5ZtPz8AbrQyQMzODM1MQ
         WXyoeBgbUBbibl1FzwGpKtmMFlkDjZmHj2kafoR0+YxDe0N2avaN9ZmrUm+p1qo0ygWO
         rnalC51CJKmvxmMES61tQ7+yP5f4/oSrW6k8fidn9tuuqmSb2STEQb7KguxNSyXF1ii+
         9omyV9+rqxCoHoS+pXxOsoFhFT5GiMYMBfWMUd0uTNiNvpz42+4+5ObwMEvT9uep56Xx
         iVhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741663911; x=1742268711;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kA1OV3LCyCYIYiWIgM4V5RUECOenxGpsaM/3MlbJANQ=;
        b=pTS63o7GA98gelKbU8JG9oFfxjGcE5JugCoqomu1MHDNCjm5uuaZv7avzoVT8nv8Rz
         sxzOz5GKcqvb2dxOU4VscrTnldeIPHFvKOwS+Byw9deNOAisku0TGPz/qDrk5Hq0kr3i
         gZE2HKLZflSlPA9f5yc24sl6Iiz3g0n+UBLrZl36nOwDmgjH9y1Waa73ntZeE8XW/tAU
         bKx5k9Q5y+m/raru61YCuZwFDDIaKGBuiiJR5MA02383ZURGRLmROjuHi0Sl8TV3om0w
         VHwNI69bGrbt/CSfG4tcQrStXU7vTOxEgl3X67NQXqGp7uh/QaN2TfUKxWYqZu8QgJcl
         LAAg==
X-Forwarded-Encrypted: i=1; AJvYcCWD7DSPRve+Ny59fgnhcj5L044hXkXzm3rg9mxIPL2NTwt5AJAOSa+d7EQ+5mDdwjYEtlgqyDYgZq1c81Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDp0yjZEmwod1nlG3XZ8YSYQHDl7EVWoEXR6Tqur5n1b7UBK0l
	PQMfyUrWsDCa49R/DuBNhIy+JA+mdwwO3MPsSAN8qvl9XLo7bzIFTzf+opBF
X-Gm-Gg: ASbGnctp2ZB4ZUT7vvBfgNgJRhvftm5uETkGt60ntLDtCQTIIRpIzOcmeoTUFeonnv6
	Y+kOjPZlOVtep+pw5aEgRZgAFDtoN/XVWn2eRp5AlHgy1SP/bcsFb8ckEzi0U7zh5bMeLDgMmcC
	tqwXbq86hLYvl6tN/dKwV6lQ7Q3FDY4dc4KOQ58XWrxKZ6XU01PDEQ32oGBo8XQaNGaZciTblKJ
	yrO9L9hZE/rF0uGBs92RMgTMxYesXVX7mNqj5N1zdEEQLiH2mUeeSeXKGgim9yfC33+0UqnebkJ
	/4PfB8YZ113d6zAPS5COE7Yv7FsQqjO2SyyUFo6+z/pEuE5IcNdcQNmmJv0gQDT/K7uQ6s1BgyL
	EkMF7bGg=
X-Google-Smtp-Source: AGHT+IGO6oLV5do8yYss44bnT2N4WL9FloUnYXlt04KMsjlUR+qtL3oT0lT3VEA5R53JbKPYtkk2Mw==
X-Received: by 2002:a05:620a:8004:b0:7c5:467f:d131 with SMTP id af79cd13be357-7c5467fd2d5mr1746411185a.36.1741663911012;
        Mon, 10 Mar 2025 20:31:51 -0700 (PDT)
Received: from nerdopolis2.mynetworksettings.com ([2600:4040:5e66:a800:aa39:bd07:6207:ac0d])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c54c204e36sm342772385a.40.2025.03.10.20.31.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 20:31:49 -0700 (PDT)
From: adamsimonelli@gmail.com
To: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jiri Slaby <jirislaby@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Petr Mladek <pmladek@suse.com>
Cc: Adam Simonelli <adamsimonelli@gmail.com>
Subject: [PATCH v8 3/4] tty: Change order of ttynull to be linked sooner if enabled as a console.
Date: Mon, 10 Mar 2025 23:31:32 -0400
Message-ID: <20250311033133.1859963-4-adamsimonelli@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250311033133.1859963-1-adamsimonelli@gmail.com>
References: <20250311033133.1859963-1-adamsimonelli@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Adam Simonelli <adamsimonelli@gmail.com>

If CONFIG_NULL_TTY_DEFAULT_CONSOLE is enabled, and CONFIG_VT is disabled,
ttynull will become the default primary console device, based on the link
order.

ttynull will be the only console device usually with this option enabled.
Some architectures do call add_preferred_console() which may add another
console though.

Many distributions ship with CONFIG_VT enabled. On tested desktop hardware
if CONFIG_VT is disabled, the default console device falls back to
/dev/ttyS0 instead of /dev/tty.

This could cause issues in user space, and hardware problems:

1. The user space issues include the case where  /dev/ttyS0 is
disconnected, and the TCGETS ioctl, which some user space libraries use
as a probe to determine if a file is a tty, is called on /dev/console and
fails. Programs that call isatty() on /dev/console and get an incorrect
false value may skip expected logging to /dev/console.

2. The hardware issues include the case if a user has a science instrument
or other device connected to the /dev/ttyS0 port, and they were to upgrade
to a kernel that is disabling the CONFIG_VT option, kernel logs will then be
sent to the device connected to /dev/ttyS0 unless they edit their kernel
command line manually.

The new CONFIG_NULL_TTY_CONSOLE option will give users and distribution
maintainers an option to avoid this. Disabling CONFIG_VT and enabling
CONFIG_NULL_TTY_CONSOLE will ensure the default kernel console behavior
is not dependant on hardware configuration by default, and avoid
unexpected new behavior on devices connected to the /dev/ttyS0 serial
port.

Signed-off-by: Adam Simonelli <adamsimonelli@gmail.com>
---
 drivers/tty/Makefile | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/tty/Makefile b/drivers/tty/Makefile
index 07aca5184a55..7d0414dc31ed 100644
--- a/drivers/tty/Makefile
+++ b/drivers/tty/Makefile
@@ -11,6 +11,12 @@ obj-$(CONFIG_N_HDLC)		+= n_hdlc.o
 obj-$(CONFIG_N_GSM)		+= n_gsm.o
 
 obj-y				+= vt/
+
+# If ttynull is configured to be a console by default, ensure that it is linked
+# earlier before a real one is selected.
+obj-$(CONFIG_NULL_TTY_DEFAULT_CONSOLE) \
+				+= ttynull.o
+
 obj-$(CONFIG_HVC_DRIVER)	+= hvc/
 obj-y				+= serial/
 obj-$(CONFIG_SERIAL_DEV_BUS)	+= serdev/
@@ -20,7 +26,13 @@ obj-$(CONFIG_AMIGA_BUILTIN_SERIAL) += amiserial.o
 obj-$(CONFIG_MOXA_INTELLIO)	+= moxa.o
 obj-$(CONFIG_MOXA_SMARTIO)	+= mxser.o
 obj-$(CONFIG_NOZOMI)		+= nozomi.o
+
+# If ttynull is enabled, but not as a boot console, it is linked and used later
+# after the real ones.
+ifneq ($(CONFIG_NULL_TTY_DEFAULT_CONSOLE),y)
 obj-$(CONFIG_NULL_TTY)	        += ttynull.o
+endif
+
 obj-$(CONFIG_SYNCLINK_GT)	+= synclink_gt.o
 obj-$(CONFIG_PPC_EPAPR_HV_BYTECHAN) += ehv_bytechan.o
 obj-$(CONFIG_GOLDFISH_TTY)	+= goldfish.o
-- 
2.45.2

