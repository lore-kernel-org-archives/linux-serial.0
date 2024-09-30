Received: from out203-205-221-245.mail.qq.com (out203-205-221-245.mail.qq.com [203.205.221.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA551A288;
	Mon, 30 Sep 2024 03:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727666448; cv=none; b=Nnc9fxZqQZZkJeWkbnEkJgASMpjky4IN+7ch//1jpj+VDxzaPHiag9aqfhaXzrH7XhgVR4kkmZugibkxtJ0jbV8cjtLsIVPxgk1/y5LBW8AHq06e6FsTD9Ts3RFPKUkUQPR//jS/h6Z92JMQWYqs4MYJHIlbofx4qwAVaenkqPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727666448; c=relaxed/simple;
	bh=ay3MUvCZq9yN8i2gbuXEpbVKhpEcZbnPWAHyGy5OcUs=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=S9uXG+yM6Yyf6hxn/sTWeeoFUFo5XxDybXWJKSzXrp6cQ7UOfPI1jVIqGYfJiDaYNqPK68UIBTO9bci61oC/9gkOGlp1fzf6Gtnin/Nwm+S8jBaxcPCs3Lr/Pnrq/IzbD12NXO6ptfJcPKtcnU473pvEzJgFgTfMZQ5eipyeMaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=lYgI99Bn; arc=none smtp.client-ip=203.205.221.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="lYgI99Bn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1727666437; bh=VGNgmHrqrFOv2Niu9U2cuhY4Og3BHlCKU4x9HInKv7A=;
	h=From:To:Cc:Subject:Date;
	b=lYgI99BnDhzSCsoC9fc/wQB0NTm03jOcFzXLM+WA/HGRJuSxLYvQ7ctffIfQbv575
	 jBlKGRHNxYnkbAZ2wzw/SRH5leD/g868DGjQ6+cKM5hAazezpQJYmKd4FgNhO197Ez
	 +nX78oDBSQc55QS+qpcykE/WF7vZv3VacfKsqsm8=
Received: from LAPTOP-58DOKDH3.localdomain ([115.153.148.27])
	by newxmesmtplogicsvrszgpua4-0.qq.com (NewEsmtp) with SMTP
	id 4D12F4CF; Mon, 30 Sep 2024 11:19:17 +0800
X-QQ-mid: xmsmtpt1727666357tj6rw4mjo
Message-ID: <tencent_A926284D28E1F878F1888699245B2E06CF0A@qq.com>
X-QQ-XMAILINFO: NC/J3CrDtaBb9UqwR/kqPl5opia5IMQu/cD8tH4WlJXZvXLvJewaMsAeezPMPg
	 E+FRq2APEWBpfRa2jjhCQXTDkFuO3SbBHp/W1aqOlqBoLXux4RafkmaDzRKS7Becr4Ns6n2XmgGs
	 1LnV1jnnm3h9xgC/QTeLN0vgbOuvkeKWPs/pc0XccvoKtcBYuKcsLR+N5vjJJhpiiTIYrZ4/T6uE
	 +pI6gxQ6ug3phVqY31iimNPUBiVBjTCW1Irz859frTyabG5s3ulzOmAUSE9EiQlH2t2F/kXb8hzw
	 2l6oQvGbOmP9eOGv6lPP7eP8msf3iCvOtWlORUKJkLWRA30n/enSEuNmGY6PKzIFGMJb/PEgmidI
	 ztO+HMYt5I6q3b4ViPnRE5wVDZOKMkCVXRUGeEXy6pQ3T58iRyUOa3wi1r9y0oMvsfSZFwAtJFrP
	 Ba///1+M4p+BzQzODZnmSFOvzFfoz2QKiH3sfJQnnjsYAH5+VSB8mReXGHTqbkVvQSebSxdzA0uA
	 f6ZSYzXMBe5A29Q3nOOLTAZl1sXuRgLQIAcNmU4MxknEI3llHPkom/5JKOWclxmDVaJBS7mMkP7i
	 mvli7rKYKMlHrEib7NjZ/btesBcMP8ch3CbXqe0uDuH4rL20kQfJMu97k9WcNGsH2WmJeguYAU5i
	 SfeRfhX8SzJx4StmU+273tNa0J8+uv91BplpiOT+wgREU4epcrSw7j8BvBqUJb6xRYWUW1Hf7LAx
	 mSGCtWdpo1YTOjZFXYZ7UhuqOcHmIdOP2WcXnqYvI+ZcU8gQNQIMZA0SLdBkEwSyCvZ/h5SHVaMO
	 OvvjNbHkCfz2sTy9nz6nnxy00DUuL5sZiAfVdl/JvMJhaJZTNmHfu9Gq+wTVaH82y66yoq0wRUCt
	 0E0hixFdwzMaGRIAA6yp1VPpDBVXyZLk7+ljsv8G3MLygJ4dbrZkSzuakJCymOWvmyqmzldTeViL
	 f5nx/+K38IXWvay8UetxMcnyxh1MEJmaAWpZFh9vM=
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
From: winterver <295107659@qq.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	winterver <295107659@qq.com>
Subject: [PATCH] dio: Improve readability: rename dio_scodetophysaddr
Date: Mon, 30 Sep 2024 11:18:37 +0800
X-OQ-MSGID: <20240930031837.2341-1-295107659@qq.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename dio_scodetophysaddr to dio_scode_to_physaddr.
Also dio_scodetoipl -> dio_scode_to_ipl and dio_scode_to_name
-> dio_scode_to_name, though they're not implemented yet.
I've searched these names in the repo. There are only a few of references.
I think it's OK and worth renaming them for readability.

Signed-off-by: winterver <295107659@qq.com>
---
 drivers/dio/dio.c                    | 12 ++++++------
 drivers/tty/serial/8250/8250_hp300.c |  2 +-
 include/linux/dio.h                  |  2 +-
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/dio/dio.c b/drivers/dio/dio.c
index 0a051d656..143e58c9f 100644
--- a/drivers/dio/dio.c
+++ b/drivers/dio/dio.c
@@ -11,12 +11,12 @@
  *    This means that framebuffers should pass it as
  *    DIO_ENCODE_ID(DIO_ID_FBUFFER,DIO_ID2_TOPCAT)
  *    (or whatever); everybody else just uses DIO_ID_FOOBAR.
- * unsigned long dio_scodetophysaddr(int scode)
+ * unsigned long dio_scode_to_physaddr(int scode)
  *    Return the physical address corresponding to the given select code.
- * int dio_scodetoipl(int scode)
+ * int dio_scode_to_ipl(int scode)
  *    Every DIO card has a fixed interrupt priority level. This function
  *    returns it, whatever it is.
- * const char *dio_scodetoname(int scode)
+ * const char *dio_scode_to_name(int scode)
  *    Return a character string describing this board [might be "" if
  *    not CONFIG_DIO_CONSTANTS]
  * void dio_config_board(int scode)     mark board as configured in the list
@@ -130,7 +130,7 @@ int __init dio_find(int deviceid)
 		if (DIO_SCINHOLE(scode))
 			continue;
 
-		pa = dio_scodetophysaddr(scode);
+		pa = dio_scode_to_physaddr(scode);
 
 		if (!pa)
 			continue;
@@ -203,7 +203,7 @@ static int __init dio_init(void)
 		if (DIO_SCINHOLE(scode))
 			continue;
 
-		pa = dio_scodetophysaddr(scode);
+		pa = dio_scode_to_physaddr(scode);
 
 		if (!pa)
 			continue;
@@ -274,7 +274,7 @@ subsys_initcall(dio_init);
 /* Bear in mind that this is called in the very early stages of initialisation
  * in order to get the address of the serial port for the console...
  */
-unsigned long dio_scodetophysaddr(int scode)
+unsigned long dio_scode_to_physaddr(int scode)
 {
 	if (scode >= DIOII_SCBASE)
 		return (DIOII_BASE + (scode - 132) * DIOII_DEVSIZE);
diff --git a/drivers/tty/serial/8250/8250_hp300.c b/drivers/tty/serial/8250/8250_hp300.c
index 3012ea03d..1bef48842 100644
--- a/drivers/tty/serial/8250/8250_hp300.c
+++ b/drivers/tty/serial/8250/8250_hp300.c
@@ -124,7 +124,7 @@ int __init hp300_setup_serial_console(void)
 #endif
 	} else {
 #ifdef CONFIG_HPDCA
-		unsigned long pa = dio_scodetophysaddr(scode);
+		unsigned long pa = dio_scode_to_physaddr(scode);
 		if (!pa)
 			return 0;
 
diff --git a/include/linux/dio.h b/include/linux/dio.h
index 464331c4c..1677cdf6d 100644
--- a/include/linux/dio.h
+++ b/include/linux/dio.h
@@ -241,7 +241,7 @@ struct dio_driver {
  */
 
 extern int dio_find(int deviceid);
-extern unsigned long dio_scodetophysaddr(int scode);
+extern unsigned long dio_scode_to_physaddr(int scode);
 extern int dio_create_sysfs_dev_files(struct dio_dev *);
 
 /* New-style probing */
-- 
2.25.1

