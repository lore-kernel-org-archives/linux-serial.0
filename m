Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3410623BCFB;
	Mon, 24 Feb 2025 12:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740400800; cv=none; b=a3BxfBgKmtkgbvBRCMQ+K/qY/iKHBOvpRfgKc8aEFFzCwVdHstO7ayIpbKV7oW3cjmfAFMEvadsfP+qFlLNbhKElOhfaojih/ZReIM/cdlGPI+LJfXoTy4gjq+vlM1lYei+cDlaLMtXZ7zQxs7CyFcoov5GTnzWplDnmMxevWgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740400800; c=relaxed/simple;
	bh=vB2i+ruSjy0DOpS/0wDhEiGkvYIz2TmWtti7O3ZnuHg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BWDk5RZ2o99tflG36ZZ+yztmFS5LYnouVJk1pO28pW8VleLwBmye+i37kgkRkHJ8qyTH05xkGt/SKbg24KQ78KLjXFMW9n9pR95fF5qESEg9ckh7cY5Tn/sv/NVDuXTlWnrgNB5mjFIElkLdKYxg4ljHK/6Lt8+gSICw+kq6n9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BDg5lCbB; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BDg5lCbB"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7c0e135e953so156499485a.2;
        Mon, 24 Feb 2025 04:39:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740400798; x=1741005598; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=veRPaw0hj+cpqnT82b8ArkdmOqx09jq+NLdo9EDH1g4=;
        b=BDg5lCbB+EU9myeEo3Ylpbl1VnAJVJYU7DxJ/JIyKA5S2LBDqr6lezSBxEjvwwPCw/
         BPzpjdjPDdxGDxrUUa4CqG9+iCLIgRznYQFM+uj37+WGQ0M41rpkvzi6j2Mhop/goOgl
         VNlvu2KgwqYTpcEiOz6TK2zjj7apRwSqwQgdarbUAJYn/ASYlhvFU/Hxl5N1KZvYVBtU
         3180ZLVccynRmRKxZhtIWN8IW9wFZcvueAm4z9tXMtg8K/bANPyDcMsejyFRVax3ZyKu
         pxwgZs82amq0ju1tvajqjm/6KXvlkoVPNJ0/kn5g/2KutQba2Ly42LY3dnSHG2SM3m00
         7c1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740400798; x=1741005598;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=veRPaw0hj+cpqnT82b8ArkdmOqx09jq+NLdo9EDH1g4=;
        b=i02E6zPEzRBm48ee2rYN9Si23UKT5Vm9XfcU9TXrTDABLkb00gw0kHylmoX8ZVe40O
         eUukor5PwUuhI3vgg/hbi7rCCAN7yTJ42rh2Zvfd4J8Lo/rFVQnXknar7QWgg5jSyS0o
         OzmosOYdg8fAw5iymysdEqXuK0/z1AhFb/pP/b0ZyR1XXACIlMy9uXN67O4kvs7nmv7Z
         zd9lJaUyqHQxvhiIOFVKCtfTZZXSjlgczptXfY7HUnOUNMBAGahfbyvP8+k9/2F4ko3n
         0/AtBxdwvWHD/rM+EYGNxU6XwLjnTOJYdudv7cvRb6LK0c2R7OaG7/aTsmRWQYJCdt9n
         09ug==
X-Forwarded-Encrypted: i=1; AJvYcCW8wUzK1NxgGvfL0+sxHZPH4TP0cgK7K9ar6GykN9PbCu0pOfjkG/JjmYxeSb6vmA7eUOY+IsWI7ByvR8A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJBd7e+cMedJ/6O79Fb3CDdaahBLjKWfcy6X5zaKnRSt5YjsUD
	8V2CHthg7r2IwoOwCp5XiljZNiKdnyAybQfKOw3MOudju6gNUpWG/cd7koWl
X-Gm-Gg: ASbGncveL24j2tvY01daQRFiEnBIX7vOHy0he5Qle7rjt492tnDCgd7paF4RTFl0//L
	ZTlRb2pq/yu6gyG1VNN8zacCezfcKxH1Pbv2mChdYkPyJkAm+nxZD6zj1uQU6CKPhneggG36bZH
	rJJvwl8k4mVBocYs0Qiie3hWmGjqZucQUwv+HYIoGTlAba1kztg9FUTDiK0RVWa6WH+XRwJPHLB
	yr+fMifks5aXXP3/5CuKe1Drj4iLSm1YfBMe6enRsuXhi+7PSMTred88byxys/9j744oGxUEJv1
	bYcRoDiA8+0MT4ZDqclVspDruZ/yw2IffDPOMVpX2/Z7NPOQg7MZPx/kPYSLdr2U
X-Google-Smtp-Source: AGHT+IFWkBDl5kbtdoaaep7NPM++wlLcw1wblzfV7SnHsAs46CYSDzcS0s8dyaAOUwsEE75oh9uZNQ==
X-Received: by 2002:a05:620a:4148:b0:7c0:c13f:4181 with SMTP id af79cd13be357-7c0cf8adfdemr1620336285a.2.1740400797690;
        Mon, 24 Feb 2025 04:39:57 -0800 (PST)
Received: from nerdopolis2.mynetworksettings.com ([2600:4040:5e66:a800:3cb7:1064:72b6:f891])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c0ad774f81sm831922785a.37.2025.02.24.04.39.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 04:39:57 -0800 (PST)
From: adamsimonelli@gmail.com
To: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jiri Slaby <jirislaby@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Adam Simonelli <adamsimonelli@gmail.com>
Subject: [PATCH v5 2/2] tty: Change order of ttynull to be linked sooner if enabled as a console.
Date: Mon, 24 Feb 2025 07:39:15 -0500
Message-ID: <20250224123915.2859682-3-adamsimonelli@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250224123915.2859682-1-adamsimonelli@gmail.com>
References: <20250224123915.2859682-1-adamsimonelli@gmail.com>
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
index 07aca5184a55..1fb905cfb420 100644
--- a/drivers/tty/Makefile
+++ b/drivers/tty/Makefile
@@ -11,6 +11,10 @@ obj-$(CONFIG_N_HDLC)		+= n_hdlc.o
 obj-$(CONFIG_N_GSM)		+= n_gsm.o
 
 obj-y				+= vt/
+# If ttynull is configured to be a console by default, ensure that it is linked
+# earlier before a real one is selected.
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
+# If ttynull is enabled, but not as a boot console, it is linked and used later
+# after the real ones.
+ifneq ($(CONFIG_NULL_TTY_CONSOLE),y)
 obj-$(CONFIG_NULL_TTY)	        += ttynull.o
+endif
+
 obj-$(CONFIG_SYNCLINK_GT)	+= synclink_gt.o
 obj-$(CONFIG_PPC_EPAPR_HV_BYTECHAN) += ehv_bytechan.o
 obj-$(CONFIG_GOLDFISH_TTY)	+= goldfish.o
-- 
2.45.2

