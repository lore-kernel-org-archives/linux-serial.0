Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F9B1F4169;
	Tue,  4 Mar 2025 03:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741060509; cv=none; b=pZhMkOJt895AyC9cOd4B2hfHDlMtUsMViTIxNIF5Q13zg4ndXi8MsNAqgkNYaoDs4JrcHfDE8Bf54zhStYBz6pMpu2YZQmHcP5OQ+6AxawW35cTemg3QLwOTOtN89oGKSzJ7ZRb1u8GVg212pUmzDebwVm0QKzyot3eW90x7tzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741060509; c=relaxed/simple;
	bh=K2JMcePkguomNk533rxGnSo7HEuNE+HYU/PkTSIxr0s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HwqCGEsN6fNyYBjzJXUNLO/NAUIu10Sp8QHJAOa/WjMtT8tN7jqfneMvs4djJ69525oDFuXscK20qKxqG4VcuJwMvM9eo2hdNQ5xukJn1qnQCaGz7DXesew1QnrBRgu65Reu60YQ+oLQe4B/C1gZdqaRqgyY+8HViY5dUGGX75s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AuSLG6pn; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AuSLG6pn"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-47220d28138so72768331cf.3;
        Mon, 03 Mar 2025 19:55:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741060506; x=1741665306; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GdcrE3LdnQVgeO5HL+/GJUF9iIqr/dYjf5g3HkcSy6c=;
        b=AuSLG6pn/6juVZZWf0ja6SbSZE/5t56qYuGrjV1UUsN9l3havmN35uCKug+yo8npqE
         wqq+PSgL0cl3kFjAxnf3SvVvwktF42IF4Xnmon52WhgAvH1cbAw1SXI+cQeccnmIbj8F
         MhfHBs1rrEb+/8C09ETQBcAd/70UxC3LYQ1nv643w7ZUp0PMn4Prfx7VS4PyXxl/92go
         Pi8HKWzEVPTyahwrniPMscyT3+W9BvbzknQMnL06wcRjZ6yUBsn4UZDtoo76UCXv86pn
         lR4DkgJ41lnsePLNUattMgqwolInJ/O0wRjZyRVZPHvnrokTrF+/dOmM9N3nceg4ps4G
         YOxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741060506; x=1741665306;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GdcrE3LdnQVgeO5HL+/GJUF9iIqr/dYjf5g3HkcSy6c=;
        b=JZv93JpSm1eqBVSLBYVl9+2wf6tMsnZwdQwLrXl1+tZVabNNf8rVs/8Vw06cZajt0v
         /LdLUKD53jutG5dOdLx8mkQip9TpR5YVnN4KnChrJ0hUtSk5ZrA3qKX1W0h8/q40m6N0
         LAnwz1Lsk0qRghVXJu8c+zrEa0O34UsKlpPKIHoLizAApeDjVyT6N9qWGwjkd2MwQ2l5
         Y1dxxcX22YqJ+VL8ObfQXXVGQXl08FlAwNjprQLR8qk+SBsd35Lv2oz79s8SD9mnKOe1
         kk1gr1WH0VT/v2flmUP02dEQ4rP3R+A8Dzh4DjA/c7GXf5cYKou4JDhoh51mIKFmy6o+
         5VKg==
X-Forwarded-Encrypted: i=1; AJvYcCVc0Lali7f4Wfxuvz48fpUOBCWwM6HnqdHGwxQzI5an9JSIeOurJmeSEDxApNcPljDlC70zLaBo7E5vye0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx63UgbOyaBYNR6eE07jUBQgkNd3Jtd35rjgM7CdQLWQW1Y2jxw
	SZIsYkN4LyEU8oyhR7XggwkZWWmSBlNHn7QVyKbkxpumdj37O3krUt17f3Ee
X-Gm-Gg: ASbGnctnzJcow6j6BQbPpWyMEkuKd+VpwFt3vu1SO4MpvWO2vMGmgL6GpVNjM/KEAUU
	u4ZWTAo38KYu4JxEOm+7+QZJMEXnTx342qDEgDrbWVnWO02wmHq+jJ256oF5l69rD7O9Gm4gRLV
	/eSivfjrl6INWMBqrBDJamubuEKt//q90QD2ub+NEHtvUrg094a+bSwUNR/N2AQ7Blarv8pBfeH
	5kOXUkDAPVfJom1/DahMlwB1p/zCVtT6r/FJd6RIuzRYubw9cF5ULKEcKf8YuygbrYm5ZNQsShC
	kksR/JgmPxzKY2h/Qlu7xBfCeXTgnj6HhF9u4hEnynPmEznScXHA280SW0xrG4igPkkgWVDnYCG
	XlUXYm7A=
X-Google-Smtp-Source: AGHT+IE1pAuGx7BQ7H2vAjWVPS1Ixjg3wxAx2UDJGXmnGcGGEMGV5PCvJgx27ocQocD20/K72ooAGw==
X-Received: by 2002:ac8:7dcf:0:b0:472:6aa:d6be with SMTP id d75a77b69052e-474bc069f2fmr185735581cf.17.1741060506261;
        Mon, 03 Mar 2025 19:55:06 -0800 (PST)
Received: from nerdopolis2.mynetworksettings.com ([2600:4040:5e66:a800:745f:1ed4:1113:4077])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-474691a1f2csm67567041cf.13.2025.03.03.19.55.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 19:55:05 -0800 (PST)
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
Subject: [PATCH v6 3/3] tty: Change order of ttynull to be linked sooner if enabled as a console.
Date: Mon,  3 Mar 2025 22:54:47 -0500
Message-ID: <20250304035447.3138221-4-adamsimonelli@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250304035447.3138221-1-adamsimonelli@gmail.com>
References: <20250304035447.3138221-1-adamsimonelli@gmail.com>
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
 drivers/tty/Makefile | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/tty/Makefile b/drivers/tty/Makefile
index 07aca5184a55..a4caf32a2014 100644
--- a/drivers/tty/Makefile
+++ b/drivers/tty/Makefile
@@ -11,6 +11,11 @@ obj-$(CONFIG_N_HDLC)		+= n_hdlc.o
 obj-$(CONFIG_N_GSM)		+= n_gsm.o
 
 obj-y				+= vt/
+# If ttynull is configured to be a console by default, ensure that it is linked
+# earlier before a real one is selected.
+obj-$(CONFIG_NULL_TTY_DEFAULT_CONSOLE) \
+				+= ttynull.o
+
 obj-$(CONFIG_HVC_DRIVER)	+= hvc/
 obj-y				+= serial/
 obj-$(CONFIG_SERIAL_DEV_BUS)	+= serdev/
@@ -20,7 +25,13 @@ obj-$(CONFIG_AMIGA_BUILTIN_SERIAL) += amiserial.o
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

