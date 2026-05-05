Received: from mail-dy1-f193.google.com (mail-dy1-f193.google.com [74.125.82.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE4435AC07
	for <linux-serial@vger.kernel.org>; Tue,  5 May 2026 01:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777944087; cv=none; b=BBf1+mjgYAiuo0lJaMtPB2gQYoxVy9L1M6hnIG9ioYbNVmN+7ED/tK+uTiaRPSelm6+uskMtgNK2ES3HU1PJjekpz31v3PCYr/3y8FO6UzocCvWhB1bf1g8AFqtwfy8SGNwv6JZVG3uinEo+zK6XrcZj5uE8zH4lwDiX+JgtPGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777944087; c=relaxed/simple;
	bh=XP5HZDn42Ha4kD9bDHw0YACkP+oRj9KR8xJbO2j1ark=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Duxn8IMW/5KLzLuCPV8iDiYrgyJxv5H0l5pqe5OgihDbzSk7qWaF3x6bZQCC8s6Ku1+zyO5v58LjtYAh7nEWTo1Xla+nhD2oeZWkbzNFy4AvrmozCkLJLuS7Q0gxYVXuOIb11mvOv0ZuUxs8UOk41mxD+eehvRkQLITDDJj2ETg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nnJHd35L; arc=none smtp.client-ip=74.125.82.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nnJHd35L"
Received: by mail-dy1-f193.google.com with SMTP id 5a478bee46e88-2f36da5c8fbso1057257eec.0
        for <linux-serial@vger.kernel.org>; Mon, 04 May 2026 18:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777944085; x=1778548885; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FQwsxbcGcs3is/KSucD9xztTzPVRhYIYFQ8Q48Zx6Gw=;
        b=nnJHd35LjmwZ5znyvpVjf1ORM/xtAf4d0vpZUqSsOwM77D6S3G+fly0gpTGNPaaa+5
         bHpbNQMufsc3dCv8VEoG1gVWEH9DphtoAVl6ez5VtcFeNltYP2YMno6WR5Pyyqn4LDHJ
         ZShpxW9CWccBYj+a51ZAdti8nvSa7459fRgHb1UNlK2O2FcskOSm2cUENlr+Nf0WCBzh
         8s5z1+yzDDYD4vxM/SJJSjjQCa7ggvr38ovbfoArr9twnYjyaXkY1B219Nc5LrulvXZA
         DG2dbeGvKYFuRax6aJJUgITbMw3Omm3iULqcjpH+ABfYa/PeJ4C0VbANPdBHjJfSkeCD
         JgBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777944085; x=1778548885;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FQwsxbcGcs3is/KSucD9xztTzPVRhYIYFQ8Q48Zx6Gw=;
        b=jQ02XnQIslHmbSHJEved7zce6h3F/nwNOTzq+XvIB+88wxP58znBbLFafsVXXFkeC5
         TT9OTMR0U6b7Zg/JpRAtUtqp4arI+AQsx4E1Wos4m/BGdP1YC0bYtJOcdDXzU+j1fTr7
         jacYOoXvHE+bKcPCeJ6btUUdiDOl+IikVan8dUxuprrEAewqcKpfl5GbK9WlGmbP/tvP
         CEXEiEacJEkvZfgsaOVr2k0rEyD0Evzran9ePWxvd5aeUcccjX/PlO9wnDcihOz3wgOX
         Hm7K1J2gBRA903d2wqB56rcvDgnPJh+Px5fsjIYV3kAEOCeiBM3oSeAGgRjyUq8f5jNC
         KkuA==
X-Gm-Message-State: AOJu0YzcV0zo9dEl/xu+NWkuumXVkfmLF2sth+R+hiyBSExoNhhC8WUE
	7bWozMn6SnxydarAQqyRKL2V8f8cmVM/XdsZfW3sCbvgewoCLXU7PmEj9fR0OcL7
X-Gm-Gg: AeBDieuhlWbexpisP0gxzBrcs7CoC6vi31cFm6hrDSGjLQ2cryx2jb/uSDTqBFDKnHv
	y5iedab0FHWOjECW0dSHojU1xN3bpahY7gw7rwxAimDS/i4EheURSd5NyB/oLPN4KPq0I2uzSzt
	vVl3SdooN2fmvKRykPkwqu5icwBXpfF7iuKHA360YEJmEE6MP1T45iV5Cx7bEpzF90lYhOXvCWl
	0vHb40HVLcupT0u24mwgCZcLwThicAqsbHSDzMpxbZ12u0J5i0DXQW7X2wtijqAYtl2eM4ovHyx
	cvf76aFbWKaxVGZ7y4CJS1pv4AU2CrRNRJRI9TWm5f1bjs2kkwtKrH+YrW9PBOIMiabtiC9loKc
	mZT09o3OPj9LTTAPhYtkcK9K4BkbnonMA/WURL1eESR7gTFGGF5U/ba+b2xnPd01t7HdEL1ZmOG
	B8y/Axy1wAA6/QlSH/+k/00YqAQPYqLgjZDbABqB6VcsxEwfe27xAIefdve0Zw84QgQNeEMxhmt
	3lSvnmV8oJ+B8ypRhhHJhhWig2Uaelx2GRn/cjQjPXO7eXXPDZui9+O7r91fcPc7IYwA6kNgItM
	04EqIzppOoI9GTlF3rAMEAq3HGnP
X-Received: by 2002:a05:7300:fe07:b0:2e2:4979:ec7 with SMTP id 5a478bee46e88-2efb80ba167mr5128692eec.10.1777944084655;
        Mon, 04 May 2026 18:21:24 -0700 (PDT)
Received: from ethan-latitude5420.. (host-127-24.cafrjco.fresno.ca.us.clients.pavlovmedia.net. [68.180.127.24])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ee3889d611sm24060034eec.1.2026.05.04.18.21.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 18:21:24 -0700 (PDT)
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
To: linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Ethan Nelson-Moore <enelsonmoore@gmail.com>
Subject: [PATCH 3/3] docs: driver-api/tty/index.rst: copy-editing; improve organization
Date: Mon,  4 May 2026 18:20:36 -0700
Message-ID: <31fe93b480b4ca157086af3bebb21326d0fbe983.1777943090.git.enelsonmoore@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1777943090.git.enelsonmoore@gmail.com>
References: <cover.1777943090.git.enelsonmoore@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The TTY driver API intro document contains a number of grammar and
capitalization issues. Fix them.

Now that the MOXA Smartio driver documentation is in the serial/
directory, the "Other Documentation" section only contains TTY line
disciplines. Rename it to reflect that.

Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
---
 Documentation/driver-api/tty/index.rst | 46 +++++++++++++-------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/Documentation/driver-api/tty/index.rst b/Documentation/driver-api/tty/index.rst
index 6a08aebbc47c..eb5d602450f8 100644
--- a/Documentation/driver-api/tty/index.rst
+++ b/Documentation/driver-api/tty/index.rst
@@ -4,29 +4,30 @@
 TTY
 ===
 
-Teletypewriter (TTY) layer takes care of all those serial devices. Including
-the virtual ones like pseudoterminal (PTY).
+The teletypewriter (TTY) layer handles all serial devices, including
+virtual ones like pseudoterminals (PTYs).
 
-TTY structures
+TTY Structures
 ==============
 
 There are several major TTY structures. Every TTY device in a system has a
 corresponding struct tty_port. These devices are maintained by a TTY driver
-which is struct tty_driver. This structure describes the driver but also
-contains a reference to operations which could be performed on the TTYs. It is
-struct tty_operations. Then, upon open, a struct tty_struct is allocated and
+defined by struct tty_driver. This structure describes the driver but also
+contains a reference to struct tty_operations, which defines operations which
+can be performed on the TTY. Upon open, a struct tty_struct is allocated and
 lives until the final close. During this time, several callbacks from struct
 tty_operations are invoked by the TTY layer.
 
-Every character received by the kernel (both from devices and users) is passed
+Every character received by the kernel (from both devices and users) is passed
 through a preselected :doc:`tty_ldisc` (in
 short ldisc; in C, struct tty_ldisc_ops). Its task is to transform characters
-as defined by a particular ldisc or by user too. The default one is n_tty,
-implementing echoes, signal handling, jobs control, special characters
-processing, and more. The transformed characters are passed further to
-user/device, depending on the source.
+as defined by a particular ldisc or by the user. The default one is n_tty,
+which implements echoes, signal handling, jobs control, special characters
+processing, and more. The transformed characters are passed on further to the
+user or device, depending on the source.
 
-In-detail description of the named TTY structures is in separate documents:
+A detailed description of the named TTY structures is contained in separate
+documents:
 
 .. toctree::
    :maxdepth: 2
@@ -40,14 +41,14 @@ In-detail description of the named TTY structures is in separate documents:
    tty_internals
    console
 
-Writing TTY Driver
-==================
+Writing TTY Drivers
+===================
 
-Before one starts writing a TTY driver, they must consider
-:doc:`Serial <../serial/driver>` and :doc:`USB Serial <../../usb/usb-serial>`
+Before you start writing a TTY driver, you should consider using the
+:doc:`serial <../serial/driver>` and :doc:`USB serial <../../usb/usb-serial>`
 layers first. Drivers for serial devices can often use one of these specific
 layers to implement a serial driver. Only special devices should be handled
-directly by the TTY Layer. If you are about to write such a driver, read on.
+directly by the TTY layer. If you are about to write such a driver, read on.
 
 A *typical* sequence a TTY driver performs is as follows:
 
@@ -58,14 +59,13 @@ A *typical* sequence a TTY driver performs is as follows:
 #. Remove devices as they are going away (remove function)
 #. Unregister and free the TTY driver (module exit)
 
-Steps regarding driver, i.e. 1., 3., and 5. are described in detail in
-:doc:`tty_driver`. For the other two (devices handling), look into
-:doc:`tty_port`.
+Steps regarding the driver, i.e., steps 1, 3, and 5, are described in detail in
+:doc:`tty_driver`. For the other two (device handling), see :doc:`tty_port`.
 
-Other Documentation
-===================
+Line Disciplines
+================
 
-Miscellaneous documentation can be further found in these documents:
+Documentation for TTY line disciplines can be found in the following documents:
 
 .. toctree::
    :maxdepth: 2
-- 
2.43.0

