Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2079B1DC99C;
	Sun, 23 Feb 2025 05:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740287706; cv=none; b=XoKG1IXELN3gCh/W51L03tUPNRa8QcU0rm3iBKHA9oxoDldZBpP0dK8aLAThzBCJLjsAfp+7jABUg2stpYZH0878h7bG4g+n4hU8+RmayE6g+v5nKTxpcyPkW8+VnX0ZFSKQWNge9wOgOZGHno//cGxv9xeLm2HznS3EZOZoUn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740287706; c=relaxed/simple;
	bh=BNM5ii68EENqtMZC3EcZR7Hqtlk/UcgKmWx49cXZGYg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jDQWWnITVxJ3AUCHpf88gFplFuxar7//Hi6fwDzJG6JRec71lVqawJgXF+B4qyjpXdU7IDrYcK7GTPn25V/Pb3rQNIPAoSYd0J8mMhU1/rYizrIxfREGGPk/OhofIIo7cJ3BePyx11VhIoMpc3Gd6c+UJsNcxqe6URAhC7z8UJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E5zUpp+G; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E5zUpp+G"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-471fe5e0a80so29448291cf.1;
        Sat, 22 Feb 2025 21:15:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740287704; x=1740892504; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yOEt6QZskOkWnzsAtQRMjy5DMtIL4TXxTfDJML0AUCI=;
        b=E5zUpp+GjU7chk8MKxdfmX+KvXwWk2rvW8pqJ43PyIof401p0VO/Qmi50t+pLWu/3+
         PAYYwyvqwvMb0oDBR+yxsnRqIOgGnlRQ9BSiNX1BSQ9FA/A0RoW2tT2rjiG7qa2mhVTv
         N9dyQvLJV40fXArAPt9RIYkmFXKta6PnUfqck3tUy6Dv59HzqutAmXJ735kewu+KzSL2
         ao5lvieKHxn7Bwy32rq2BY82HAEEc28/dda+s05+Tw99DbBPyRyNfIhY08/yuPRDM5iP
         xMIhEKqnC5kLXD3pBzbYKI98yc7hdvgolEK828PEj3VJI9u/4+eDqoLmarabDTGeiQI8
         Ezng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740287704; x=1740892504;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yOEt6QZskOkWnzsAtQRMjy5DMtIL4TXxTfDJML0AUCI=;
        b=eUR6kL7Wv6sMQnhZBK1vHs4iHGWV82mfkwMx7Eb0v7ck78RKNMaW/C6hnFdxiQFk/Z
         3mCeX9BBtuWLzXKxx1yd2kX3Yn4CCgLbOveEhXuWtqOcU6AxTWZAlWXNBDxGDNpIg46H
         bNvGrd1PA9FP2kx82OpeKHBMSs49sm/FbJVPa0fMTFEKKvPtXh0OuRQ59eK0gxNhLK0e
         zXhN76xNCKpDtSj4r6RgH+BCMki42ajSc9Hrsk6ISsjE4ixnxLXGzMn2xXQ+bMyRgis/
         Vy28R4LZzytyBJ3kFb8YsXCdbamgFS5rACqtg4UAV9LvvB4LMOHipoZDkJpCRYmyBfLu
         thDw==
X-Forwarded-Encrypted: i=1; AJvYcCWhY27one7Ld0ubcNFx3LqG6r3Wx1IyPav/MMqHytE+E+FKKlCo5tPoyfrzHLGqax8q9V2gx+yQXs51CpQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdOHpgcUbPcJd7US/1uoCdEqEy3Vj3R/NKb/Qn7b9aC8oDEJ24
	cYn1H4XpQaQZCYKEbTEvSXvV4k8OtWCKBr6HbpXHUqe7X6anoRdW1W7nSFJ1
X-Gm-Gg: ASbGncsj6X5Odp2MD3X5f6Khfvmq3G3t0OvMTWa+VJYAMuoyG3QxjUoDLUPI47SSl6H
	gjQGVMMJJXeRTtm8I0qjv3WUSvTbDE1EkB9+nMxxmoueRy35AusANxIulbxGIp4jdzs4Kv2/ccY
	pKwAS5gfRlzkbSach0pku24AleZIeS8DrNhvhjrQsaGo5N1zhgRWXOKXROY4fXWQdHnAkF9B2gU
	GgAHr2wooKn36vOeOyK50e2DiLr22IJPv4L0yQ73Arx3S5pq0CDNpGUavZqHISTzLrJcMZguWhE
	c//lWdzMr0qRCc28rE0A9PnhVxkzhb1fDW1/LUiJvQC9AYgJWYCGTlFOEdPssg7/
X-Google-Smtp-Source: AGHT+IFSgzxVEIKH51qETsyKXMx5jVGe8cyHVu2Zll8/c6M65UGMoj61TchBOfxsy3iarPKzMWQcBQ==
X-Received: by 2002:a05:622a:306:b0:472:996:3bf with SMTP id d75a77b69052e-4722491fb99mr91136891cf.48.1740287703657;
        Sat, 22 Feb 2025 21:15:03 -0800 (PST)
Received: from nerdopolis2.mynetworksettings.com ([2600:4040:5e66:a800:104d:377c:5733:f5b0])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e65d784e99sm118544836d6.28.2025.02.22.21.15.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Feb 2025 21:15:02 -0800 (PST)
From: adamsimonelli@gmail.com
To: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jiri Slaby <jirislaby@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Adam Simonelli <adamsimonelli@gmail.com>
Subject: [PATCH v3 2/2] tty: Change order of ttynull to be linked sooner if enabled as a console.
Date: Sun, 23 Feb 2025 00:14:41 -0500
Message-ID: <20250223051441.1861603-3-adamsimonelli@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250223051441.1861603-1-adamsimonelli@gmail.com>
References: <20250223051441.1861603-1-adamsimonelli@gmail.com>
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

