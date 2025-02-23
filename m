Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 415FA23F417;
	Sun, 23 Feb 2025 20:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740343513; cv=none; b=pThUVKfytCoVwugHFuVKgyjQw11QpQq/6hygLd8uS8FPRbzaN87xSeEUXjnmEgX9sOna2FwHcQm+IU5PYAi6j8VAGOUBNtcmV0jmEgS81E+y4wRqqGgf5XxHL9iiwXsGVybOCAccyT/UXyLsD0QL98+ygziQk8mDjS4PqjeBH8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740343513; c=relaxed/simple;
	bh=BNM5ii68EENqtMZC3EcZR7Hqtlk/UcgKmWx49cXZGYg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HXZNGW8TJ5uO2timIsVHOwwpMWRdj5KwwdN8CeTeXTOflBO2kkvAL8kHXwu2IsO6wmALHUZ1YYMvwAjaHt3TOuDCLM+O2F7UhPZkqd0APMp2KJZlCA0K+Tt+gf6qhoBSTeypI0cVvoJNehYMOLMU7RqNBPKOOiNr9s7G9Uo6iaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PCuXQ6ne; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PCuXQ6ne"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7c0b9f35dc7so542178885a.2;
        Sun, 23 Feb 2025 12:45:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740343510; x=1740948310; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yOEt6QZskOkWnzsAtQRMjy5DMtIL4TXxTfDJML0AUCI=;
        b=PCuXQ6neMDFJqP6LWzJTBNB9+XiNo4SEtfXZmkr6gcbjygOkMQIuTf2Y6VKk+IK/tA
         Lm0z+gKS/4TWFeXSIQxv/xVxvHqel88ebUxuCU3h4OHZWu879pNTLcSDwOdHZbM/WnL+
         s1N/gscPgbP/6xa1VvgUY+ggOOcNdE1MjzxfLN1XzblZXO9+ycQPHxfrUxUM/9imrjZy
         iy8aQDOMc0+Uha4Ac3BtDnUFQCq58a7s+B2bIJ9FILp4hkrwKP/LGJIafTzmsfsMVn+G
         UkMjaD5oVFUlrps9AjKE7u1W0vNuL0U9e3OSGxAAuISL7T9OXzavntbyBGsYcyGqJglk
         VBcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740343510; x=1740948310;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yOEt6QZskOkWnzsAtQRMjy5DMtIL4TXxTfDJML0AUCI=;
        b=CQczyZ/64jmEJN56alZ+1RiLxHo4VeDINTWlRZL3R0i86aLC4n70wFxgyNJURDblyz
         T2fj8LqYc/c7rr/AzTRQN4ff16qwcM9akEzeApHDLxU3BQW+7uBBXGKvUydhA4aVQFa1
         XnqHvedlKL0WdTr05yb7lQGpTxsKQH6r0c6cBWsEKK0tDLtEDrAlyRrumBgaRGPmSwjF
         /KBe0rtcChYodosVLEnvadQDXm8fGdmUydCT+ppQktIPAJQG0+3CeQIMwkj5Q+W51dT3
         aqhptkN1MbwMsLuUmp+KjpP5/LCpibFhN53lwnOkE1yzjFdFXPi9imxzt6sWei5Ra9JW
         03YQ==
X-Forwarded-Encrypted: i=1; AJvYcCWsaHmTMBHodnZimkCJymvs3Z8aeT4XvAt/CpEFjBoIVvcari56g3axUF9Li3vOkTQ2EhQTqEs3uXwUzJ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkMQCMUpG/feIw5FLgo9iLNXQUPr0ZOXMMqwy2n02ToSxnyPrN
	2Y1GgIet60t6G8MZdDYfZPUAtges/r+9nMyM6WijZ9gDmfPkt87Fz0pdS77H
X-Gm-Gg: ASbGnctfQzKA9JnWRWvimsDGmCLN1eiEx4MTQnq4nX5y0bafhT0qTwB5VoQBpV9T0qy
	U5nS3VUym9dmF/OoTD9g3XlL/qv1SsxBRdMWGCjg583zrR1mhBU3oFpDD5KTCik+0VGRcaJ/Jvm
	KwC0WCVqtzOyR6VjCeD+0n4fKfh7xceWBfc6Y1YHOLH8gA+8PMjU25OIfZaN2NurYG9XvjMYX8k
	lvDJBASoQxYsNl0HyYgm9kjOHiEDbSBlaSnX0DvtyJV4/wA54QSAg2s/PavclRe2UaZtccRO6pl
	LD36YjXc51F0pDIN1HbM6gH6d49/huYOlM6PXcLwXWySGuRE3m/a0dJBHS8ZUQc=
X-Google-Smtp-Source: AGHT+IHXRQ494cpE7pvjPu8VGGB1mntTUdIj+4+cFv8YRHij7fyQGz7S/oxdPJUIeeHAQeVXFVmP7w==
X-Received: by 2002:a05:620a:44c4:b0:7c0:a70e:b936 with SMTP id af79cd13be357-7c0ceeeb6e2mr1791319385a.8.1740343510445;
        Sun, 23 Feb 2025 12:45:10 -0800 (PST)
Received: from nerdopolis2.mynetworksettings.com ([2600:4040:5e66:a800:7a4:75e2:6847:49c9])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c09bc8819bsm919914085a.74.2025.02.23.12.45.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Feb 2025 12:45:09 -0800 (PST)
From: adamsimonelli@gmail.com
To: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jiri Slaby <jirislaby@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Adam Simonelli <adamsimonelli@gmail.com>
Subject: [PATCH v4 2/2] tty: Change order of ttynull to be linked sooner if enabled as a console.
Date: Sun, 23 Feb 2025 15:44:56 -0500
Message-ID: <20250223204456.1913392-3-adamsimonelli@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250223204456.1913392-1-adamsimonelli@gmail.com>
References: <20250223204456.1913392-1-adamsimonelli@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Adam Simonelli <adamsimonelli@gmail.com>

If CONFIG_NULL_TTY_CONSOLE is enabled, and CONFIG_VT is disabled, ttynull
will become the default primary console device, based on the link order.

Many distributions ship with CONFIG_VT enabled. On tested desktop hardware
if CONFIG_VT is disabled, the default console device falls back to
/dev/ttyS0 instead of /dev/tty.

This could cause issues in user space, and hardware problems:

1. The user space issues include the case where  /dev/ttyS0 is
disconnected, and the TCGETS ioctl, which some user space libraries use
as a probe to determine if a file is a tty, is called on /dev/console and
fails. Programs that call isatty() on /dev/console and get an incorrect
false value may skip expected logging to /dev/console

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
 drivers/tty/Makefile | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/tty/Makefile b/drivers/tty/Makefile
index 07aca5184a55..1a1051ecb1af 100644
--- a/drivers/tty/Makefile
+++ b/drivers/tty/Makefile
@@ -11,6 +11,10 @@ obj-$(CONFIG_N_HDLC)		+= n_hdlc.o
 obj-$(CONFIG_N_GSM)		+= n_gsm.o
 
 obj-y				+= vt/
+#If ttynull is configured to be a console by default, ensure that it is linked
+#earlier before a real one is selected.
+obj-$(CONFIG_NULL_TTY_CONSOLE)	+= ttynull.o
+
 obj-$(CONFIG_HVC_DRIVER)	+= hvc/
 obj-y				+= serial/
 obj-$(CONFIG_SERIAL_DEV_BUS)	+= serdev/
@@ -20,7 +24,13 @@ obj-$(CONFIG_AMIGA_BUILTIN_SERIAL) += amiserial.o
 obj-$(CONFIG_MOXA_INTELLIO)	+= moxa.o
 obj-$(CONFIG_MOXA_SMARTIO)	+= mxser.o
 obj-$(CONFIG_NOZOMI)		+= nozomi.o
+
+#If ttynull is enabled, but not as a boot console, it is linked and used later
+#after the real ones.
+ifneq ($(CONFIG_NULL_TTY_CONSOLE),y)
 obj-$(CONFIG_NULL_TTY)	        += ttynull.o
+endif
+
 obj-$(CONFIG_SYNCLINK_GT)	+= synclink_gt.o
 obj-$(CONFIG_PPC_EPAPR_HV_BYTECHAN) += ehv_bytechan.o
 obj-$(CONFIG_GOLDFISH_TTY)	+= goldfish.o
-- 
2.45.2

