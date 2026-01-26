Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CF7F2F745B
	for <linux-serial@vger.kernel.org>; Mon, 26 Jan 2026 09:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769419395; cv=none; b=ao0gCS1KXueHpCNZU13ixEiEthosvOJJWIosb9PNXA7Gm3TEVAtl2XcXo9rxvgX9LehvQHlMCZ6kRMKasvthPvWovBsEOVEsbzNSv8S6cXf7Bt4DU88C0NmM9sWtaHweGmorXQ3/owKYtNbt2dWhZEE+NSP51SQDc875SWzIGK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769419395; c=relaxed/simple;
	bh=ytJ/c0jABl5V5sWr8O2WU1PpHLwUQrY4hjUXNhAeC6o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NQBgdNNvc/g71ttf4KOkYcN1Yn+suqlOi37rPPgqKl/TKiT+4PJIFijBqGAgMQ3pZ623KW4bBhVeN6ieDdd+NGrjXdL9667L5q3PWG8Giobmnxf3LQkOksgDgClK2EQOAdv6XLoDPlt9TixvDrVaTwPV/hUT+yzIImUhRD/Ta7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dKumlLPu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dKumlLPu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769419393;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=fWJIkWbFtmjSC7h2sEu7+a6pXSRI/HsCAQatvbI2t7o=;
	b=dKumlLPuttDgzpcXW5AeNVKBXtm6Gy2rqwp50st/fc+9n6pGk3YFdd6zf3AyXpTEKnSrod
	MTgmr+0l4eHYXMG1dpGbddREhnwt+OFW+mJ9FRw/ZApvbzv8PyDLA7b84Y5qfbsHYQ2AfY
	lhr8iPD/2QUHWK31QdB6XD3Ooq5kPaI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-131-CCOt-x6uP7ahloewpq0Sfw-1; Mon,
 26 Jan 2026 04:23:09 -0500
X-MC-Unique: CCOt-x6uP7ahloewpq0Sfw-1
X-Mimecast-MFC-AGG-ID: CCOt-x6uP7ahloewpq0Sfw_1769419388
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 931F118002C3;
	Mon, 26 Jan 2026 09:23:07 +0000 (UTC)
Received: from hydra.redhat.com (unknown [10.44.32.253])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BC87030001A7;
	Mon, 26 Jan 2026 09:23:04 +0000 (UTC)
From: Jocelyn Falempe <jfalempe@redhat.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Nicolas Pitre <npitre@baylibre.com>,
	Calixte Pernot <calixte.pernot@grenoble-inp.org>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Jocelyn Falempe <jfalempe@redhat.com>
Subject: [PATCH] vt: Add enable module parameter
Date: Mon, 26 Jan 2026 10:21:50 +0100
Message-ID: <20260126092234.713465-1-jfalempe@redhat.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

This allows to build the kernel with CONFIG_VT enabled, and choose
on the kernel command line to enable it or not.
Add vt.enable=1 to force enable, or vt.enable=0 to force disable.

Signed-off-by: Jocelyn Falempe <jfalempe@redhat.com>
---
 drivers/tty/Kconfig | 13 +++++++++++++
 drivers/tty/vt/vt.c |  5 +++++
 2 files changed, 18 insertions(+)

diff --git a/drivers/tty/Kconfig b/drivers/tty/Kconfig
index 149f3d53b7608..2b94c2710687a 100644
--- a/drivers/tty/Kconfig
+++ b/drivers/tty/Kconfig
@@ -41,6 +41,19 @@ config VT
 	  If unsure, say Y, or else you won't be able to do much with your new
 	  shiny Linux system :-)
 
+config VT_ENABLE
+	depends on VT
+	default y
+	bool "enable VT terminal" if EXPERT
+	help
+	  This allows to build the kernel with CONFIG_VT, and choose on the
+	  kernel command line to enable it or not. If set to y, VT will be
+	  enabled by default, but can be disabled with vt.enable=0 on the kernel
+	  command line. Otherwise, use vt.enable=1 to enable VT.
+	  This should help to transition to VT-less system.
+
+	  If unsure, say Y.
+
 config CONSOLE_TRANSLATIONS
 	depends on VT
 	default y
diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 59b4b5e126ba1..d83613d98f594 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -164,6 +164,8 @@ EXPORT_SYMBOL(global_cursor_default);
 
 static int cur_default = CUR_UNDERLINE;
 module_param(cur_default, int, S_IRUGO | S_IWUSR);
+static bool vt_enable = IS_ENABLED(CONFIG_VT_ENABLE) ? true : false;
+module_param_named(enable, vt_enable, bool, S_IRUGO | S_IWUSR);
 
 /*
  * ignore_poke: don't unblank the screen when things are typed.  This is
@@ -3852,6 +3854,9 @@ ATTRIBUTE_GROUPS(vt_dev);
 
 int __init vty_init(const struct file_operations *console_fops)
 {
+	if (!vt_enable)
+		return 0;
+
 	cdev_init(&vc0_cdev, console_fops);
 	if (cdev_add(&vc0_cdev, MKDEV(TTY_MAJOR, 0), 1) ||
 	    register_chrdev_region(MKDEV(TTY_MAJOR, 0), 1, "/dev/vc/0") < 0)

base-commit: 24d479d26b25bce5faea3ddd9fa8f3a6c3129ea7
-- 
2.52.0

