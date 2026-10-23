Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.125.188.122
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792733253;
	b=uAnTAenI/WyhDWWgCVOOFLT173GM2dg0BUbvIDQGevHz5SEACNZWNLtVi3wNw34rlT5j
	 DfMexvPGwUFVOAfYzYHGbQnImICzMb88zrh4TLagQu8jL2J6CNFDnuNeONyjWE2bflEst
	 PN0gHPoJysxHkoM6PqI2z/kg4BMIOkpWaICkEaaK3fdObcjSoymrvZmTWkQuDJgmqa984
	 yGUDwWrazbRibbD88m60C+CK1FK0pHC6JGWCImuMpsQmDRR9BZPbz2d2CsVXhVOVbK1ZN
	 kU18z7wV9064fMmMjiuqRfuTondCnU4I/7ovcZ54hcT4GBC9u4KHumXpGOwOkJ/P9Qg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792733253;
	h=DMARC-Filter:Received:DKIM-Signature:Received:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=HY73xKggEzfIdIfNeMh50oTUfXwZiTldS1Pkgz9mLq8=;
	b=A6UUV9bMuX7A9y1aoIPgF+lj/QLuHA9HfMyxqUTzIt7sVptb0p0kexDVuGXCO29klu6K
	 /iHUUqZnBTksBb1ChVzTSt62iPYI3aSzA8BqS6U2E3afCLqkMubKfneJUs29mxpy9BtgE
	 S367QXxEyPcO4aQR81iHVWow2TjEXTFtHC+DWBeiS186UvuetoTF/GQq35sGg4XtE2A4D
	 rpB7GLdmZXtr5fVbbhkPGLx05n0S/Rumm4ptiRidz6yF3e9b8kcgFItkiVyYUB12xK9MM
	 lLW46XwWjAoNbS7i8cE5Bh417nVC3cnDwN/rJXpt5HDfxU9bynkSowpNFd+iIOOlg0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=canonical.com;
	spf=pass smtp.mailfrom=canonical.com;
	dkim=pass header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b=VIh7nUx+;
	arc=none smtp.remote-ip=185.125.188.122
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B003D606A31D
	for <linux-serial@vger.kernel.org>; Fri, 23 Oct 2026 05:27:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B003D606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key, unprotected) header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b=VIh7nUx+
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id DE3F2402CC
	for <linux-serial@vger.kernel.org>; Fri, 23 Oct 2026 05:27:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1792733248;
	bh=HY73xKggEzfIdIfNeMh50oTUfXwZiTldS1Pkgz9mLq8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
	b=VIh7nUx+JRehjUimnHmLeWrKIsxe2VIhNKw4tQ2ktK7i7q30f9uFSvy+eZwpAAvwG
	 sMTpAvxIymhawyl9XSc3uX7odUD9pviFLswdr9EqWoUTe309F1V9v9dUZJbTgnSdQz
	 4xzS+elw+aPneNGFtqWsbAtOyDXbyz1HyhaPr8nh4RJXICOBk+ICJBXgEXzHx9IHns
	 ooNXtEsMt39m1CxIuG+lTISX3s7Vx/bsMwuMqjGMIUANJON65H5Gl246g6XsLs1ixc
	 z42h9EBrQzEvafT1ljSZt6Q32pCDxMbkbbY+FpJEk4IwrZhKM00iYJd7L6uj3XXg79
	 cAUMa9IGFr2EybBlp5MUbedr22ORWbcVnOHBjCoPI9hsVNCrU4hNvCLpeJV14lkJVY
	 YcSICQZwFiZFUHwueGr0lFNb25XZNvR6hiSoPt5n+iqHfp09pcjqcc5sM7ZZp35QsI
	 3Kcss2nNb4I74xyyYcH8PjRo2uLicEEOBrTZqSGItkv9e8+YU2US5LqxT3EXzCxdNf
	 xpU+vJ3z3cdFASx7CNQ6z7QtldwQIVa2ZgCsMlwi8hdcSC5GTQP7edgtda1sR4GJ8t
	 dVd6VPAFDiSvMs4pvVG/PX8a/BLDTeKYV+HaumDC8fG7yiDfWidNujhlY8tjt//dsD
	 QIWiUlftosM8Y8iZCjCgaVwc=
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-361c38aa269so69845eec.1
        for <linux-serial@vger.kernel.org>; Thu, 22 Oct 2026 22:27:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792733247; x=1793338047;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HY73xKggEzfIdIfNeMh50oTUfXwZiTldS1Pkgz9mLq8=;
        b=xP6Emdklly+HolNaKMMsdIs00oUfWViht+F4lUs8m2bW9DRhcVZa34DPkhFDeT1X0j
         nndCkGtftPrMEBd75gHuGFt7L0evGwf9HgjUAupymlYhpXis2BjpJcJvILFQH92PUoMZ
         1rjYaYpK+OxwdKiUtgDfmYBB/w3O7RuVq7EePI76XYHFY9Ftk94j4kgWevcZwFBHGNDj
         RrUXDq56dvvWQxaqGV9SOiK8hYvuzkC9ta3H3jMdn0GXaIOXaV+rtgHegdmymMtHb7yk
         hDnMA3DKatZNQZpZn4vy+MwWGSjCdBSTvpBGD+irUypOIq3Ve0caCidMcEHbrxYSKHjP
         hfrg==
X-Gm-Message-State: AFq9FYIbPeOt7R6CcDXA+RgvpSQyoZOC6paxcrFIy0BleveUezSmYfrl
	3jdFED53tzerHtQTIJ4K5b53dFzg9O9UYpClyvPgZwI5RfiRZw342ChT/vtQgAMsosda5Ovrxdq
	OPvtytptFshB8MN2mdEH5o46YSe28xA0kPtN5SivNaIQUZ3RaMtczUyPuUxwkxQsr8pO9v16OzL
	xIvPIzCIvnD/6Dug==
X-Gm-Gg: AYBFou1DgSVHE2Q7W7avED+Bw6egPxPNA4Wlzvr5Tir3WxaaiYEt5JUmK2oeZj9BC8I
	XGOzdiT3HH+WliUoghK2J2I29oRBQpDQR8kdN4qG2RpdU5W6PRDZTI0hdXq5lLxwkGghgOC5y3N
	DRYBiqEoQGywaHxUU+vAXohUa72GmBk6w/7B5/NT6LFkdlPrrymZICo3shf2+CWN/YpvsJZfU/0
	TVz9qvwF7ANKPpYTzExKuKS8zPATzKDI3lMkwPdw7efUbkYNSZIUiQgzv2QgS99OrS2VBq8R/zj
	aAm6cvtBipl5cnPWUl9PXHsgtQRd/DWPJ1A51w80ankDk5H6PFbX5bfbRDnHizLfdZPOjshRtF2
	2owLRvTdEy6EON4Nh9XUoW3x/2GByUlRVlpU85gXljW9Ur0u10O3BZ5mpwhb84IzDpPWkPxJ0K6
	kmf3WVQT+frb83kcHCS5MUjvx+4FjNSV1B3xnoruQ6UhF8sxfh6N33kt7MBH/FViIccbMJGJXjq
	pl5F8c0s237BAW3TPxTDacMshUJsf/3RTsuFr1c5+c=
X-Received: by 2002:a05:693c:83dc:20b0:35e:d21c:f33e with SMTP id 5a478bee46e88-369d9721136mr2912002eec.1.1792733247152;
        Thu, 22 Oct 2026 22:27:27 -0700 (PDT)
X-Received: by 2002:a05:693c:83dc:20b0:35e:d21c:f33e with SMTP id 5a478bee46e88-369d9721136mr2911955eec.1.1792733246659;
        Thu, 22 Oct 2026 22:27:26 -0700 (PDT)
Received: from an-XPS-15-9520.buildd (2001-b011-2008-445c-b47a-213f-cf99-45b4.dynamic-ip6.hinet.net. [2001:b011:2008:445c:b47a:213f:cf99:45b4])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369d9e1a085sm3590098eec.29.2026.10.22.22.27.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 22:27:26 -0700 (PDT)
From: ChunAn Wu <an.wu@canonical.com>
To: linux-serial@vger.kernel.org,
	platform-driver-x86@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	markus.probst@posteo.de,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	hansg@kernel.org,
	ilpo.jarvinen@linux.intel.com,
	mpearson-lenovo@squebb.ca,
	derekjohn.clark@gmail.com
Subject: [PATCH v3 0/3] serdev: handle devices without an ACPI or device tree
Date: Fri, 23 Oct 2026 13:27:14 +0800
Message-Id: <20261023052717.2577234-1-an.wu@canonical.com>
X-Mailer: git-send-email 2.34.1
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Driver-created serdev clients without an ACPI companion or device tree
node currently have no modalias and cannot be matched to a driver:
their modalias sysfs read returns -ENODEV and their creators force a
bind with device_driver_attach().

Backlight function on dell-uart-backlight is not affected: that class
device is registered independently and gets its own add uevent. The
user-visible breakage is the failing modalias read on an existing
serdev child -- Checkbox dkms_info_attachment aborts with
"OSError: [Errno 19] No such device".

Resolve the two long-standing serdev-core TODOs by adding a creator-set
modalias and an id_table, modelled on the SPI bus. ACPI and OF match
first and are unchanged. Convert dell-uart-backlight and the Lenovo
Yoga Tab 2 Pro fastcharger to this path and drop their force-attach
workarounds.

ChunAn Wu (3):
  serdev: handle devices without an ACPI or device tree node
  platform/x86: dell-uart-backlight: Bind through normal serdev matching
  platform/x86: lenovo-yoga-tab2-pro-1380-fastcharger: Bind through
    normal serdev matching

 MAINTAINERS                                   |  1 +
 .../platform/x86/dell/dell-uart-backlight.c   | 18 +++----
 .../lenovo/yoga-tab2-pro-1380-fastcharger.c   | 27 +++++-----
 drivers/tty/serdev/core.c                     | 54 ++++++++++++++++---
 include/linux/device-id/serdev.h              | 16 ++++++
 include/linux/serdev.h                        | 34 ++++++++++++
 6 files changed, 119 insertions(+), 31 deletions(-)
 create mode 100644 include/linux/device-id/serdev.h


base-commit: 9e947d96915af63e28896caae85a81b74855621b
-- 
2.34.1

