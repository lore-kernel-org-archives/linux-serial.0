Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76DC51D63C3;
	Wed,  5 Mar 2025 04:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741149027; cv=none; b=PaRXkJfRzbUWluR32k5YC5BcpVVBzl/WE9uVJEXKQ8W7J//Y2kLVJ35khIIBwynMKRhvbuJ0AUohl1/yAxi10HdZKBAyfINVaWvCDh6FwFx9MrUvXAY6aX0gnUfhtMBD0gygE5D4k7tZJ3xTmVm1xRBm27MlUlrV2UYGd1qfCPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741149027; c=relaxed/simple;
	bh=/rtDbi7uSjBFCc9+l01/GCl/ObmCJylChTnhbJQIO7M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Uslsw6rCOjPyYuhbTx0cyADelWQnAmT5w+Yhj7v0VuxTnLIvmSCH514roVwJn+0fdMLYslmFtE0RFXuFYpuZVkIefY1rp8jrUdMTV9Vrz5Hr2crll29Yb1igvAsWxrrBys4h/hadVmrOT7QyNqeNP7l5Vx2niYgcePiiypm/Hxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tmyiaj2/; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tmyiaj2/"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7be49f6b331so620466785a.1;
        Tue, 04 Mar 2025 20:30:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741149024; x=1741753824; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rjB9uUIaqtE9vOEIpWwNSuqq5SDBhNaUIjyLRrZ2+yo=;
        b=Tmyiaj2/mhLpZxRsAMjLBcoO5YuNxUrxg9lyn/K1yVLxk/DGqfqU2UvVXfeYtTKWDh
         BQoJxaTw+J84JrwxfKyXWP8KPOVaPmXjVDPngbNuGUwHtQ9nC1Dgz5bEsZ5shhChxQT8
         BoIYXO9/2Srzjbcljfj/NM2uNqPMoLnBZzrXwVBtiHW3AvlMNmqwCT1SGW0Tal1rPX1x
         UbXGdlhMmTVWO1JeXrRG0FW2FHaXoM/PK9kydouxqKEalNgGeY+XdOk0XOzXLfG7onvF
         Feh73XekPVR5NpvQwwtONVH4q+XUX+nmiIkZrazwHD+3EWFr9wxRKVwvspec0HhaiV7k
         1jQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741149024; x=1741753824;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rjB9uUIaqtE9vOEIpWwNSuqq5SDBhNaUIjyLRrZ2+yo=;
        b=QoUjGHElj7pNpxU9KoHf/B0pcff+rdc5MRchmSB63/gaRlNWiOx5UmPNPtnhz9hbUK
         4KA1HSBwu9bBlaqDFmxFtl1Q/tooN+o3DJDYWuhgRl8p/89cbQqvieAfxL12lkRhoNuI
         Com3fyC9y5C1daiaYCzqaz1HVX6KNz85xes1mvCUJtlPpLbMq6OoHEKo5QO9Kik/WfaC
         pWdr29eT9Bm9yzg7sNjMXXd2o2ILfy+3Be4CiHqmDWOAvcWLRKKua1CZqbw2Eqe1h4T9
         MOQt8PZULvWq6m3BZJ9MMhMZKy2JHbT6Zc1BJzMmuIlGJTcUnoeaPDqqHVFHPdCg8nlQ
         fdTg==
X-Forwarded-Encrypted: i=1; AJvYcCX6GMx6ICk3h4emNmbnZynGCz5pSret22whjMf9e5gYgtSuzOd3ClomLIHmPKVxci4YbBQqmyUcQQPpgDY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYcLlBSZEXi61UFxDbeHfok57wseyhWSzYms5XrGGlipn+n3JW
	D9fMCeNYQ6SZlJEXutSAJRN6v+IM6XawqYwAfDred9bXulPKCgNGeHDky19u
X-Gm-Gg: ASbGncsBlbXWpJJp2fDVeDgCJLVcu4edLaMEiHGHjIMUTi+uR8c6zEQfAovcqk6rP/s
	fhsOyivYjvbMvqRYWL0QfvTmwsj0LP1e8UjYrleQsw8EzOFwOYT5miSDPNNKVXGPPpaiKVlwH2L
	l1wrsXLhnedIdhQFRqD70GYpCcJSsntmsW5yQbr0JdBZNxs1u23LTn3E9+n3EqFtoelQHgrqppq
	Bmi1Ru25RMY7LKFhsAaa3CaJ9LMWRSYRrQESdA4WPSTVWGRS7AX7i2RZATpSUGzuoSf5A+W2+cc
	hCAwCKBacIqV7G1VE5+upuwqz5V05s+V5GYKPoucsRvU4HEAak4s8PBnuDhBjLZXMBa3k8e5D8v
	+I6lmPbI=
X-Google-Smtp-Source: AGHT+IGWDx0RkZd6Nu9XMl3P81+xGGY29EFnXdhoJHvCCiaa+rmUCdY6b51hp0aq9gPRkLbOBpWKyw==
X-Received: by 2002:a05:620a:8908:b0:7c3:d45b:c0bc with SMTP id af79cd13be357-7c3d8ee1838mr399822985a.36.1741149023860;
        Tue, 04 Mar 2025 20:30:23 -0800 (PST)
Received: from nerdopolis2.mynetworksettings.com ([2600:4040:5e66:a800:a5b9:4b66:4113:9357])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c36fee8b4dsm834060785a.15.2025.03.04.20.30.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 20:30:22 -0800 (PST)
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
Subject: [PATCH v7 3/3] tty: Change order of ttynull to be linked sooner if enabled as a console.
Date: Tue,  4 Mar 2025 23:29:30 -0500
Message-ID: <20250305042930.3453265-4-adamsimonelli@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250305042930.3453265-1-adamsimonelli@gmail.com>
References: <20250305042930.3453265-1-adamsimonelli@gmail.com>
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

