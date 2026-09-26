Received: from mail-dy2-f43.google.com (mail-dy2-f43.google.com [74.125.229.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CCDD3815F8
	for <linux-serial@vger.kernel.org>; Sat, 26 Sep 2026 18:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790448133; cv=none; b=Q6N2PCjNRIK0HPY+Z+UzRA3gvBRLTjkbOQbaIDFb1aRkW0oipIpHIcpxaGaH/GYmA6MIbibZ6qI+epvjQdFWdr5QR6u9f23QU7cy1lPjYc4MPkDD2KnOMTqOvW4GmaGxiMVjsMBc148Z9gSAK6NVzLilSJ6GBt8V5PI/1RB14Eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790448133; c=relaxed/simple;
	bh=boXPXLGkg2VaTiorsvVz25Gpm8TO4haBSjqWWgMIdOc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=btc1XuKGVdRQ2AXNbxAcz4KfN27TzO3yak4p5LvOCVofE/iwrs6ZcDUPZvu6sp0E+zoAtux7b3xvylf7NgDFCa1LAs6DQEyUw0AwIA2goBh7jZlvNdr2uqlZW2D5ylxLgaVwyb681dysACHklnK1ova9dbgmYaETVDu7NbB3LEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bhrzkcxZ; arc=none smtp.client-ip=74.125.229.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bhrzkcxZ"
Received: by mail-dy2-f43.google.com with SMTP id 5a478bee46e88-340f45daf45so188647eec.3
        for <linux-serial@vger.kernel.org>; Sat, 26 Sep 2026 11:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790448131; x=1791052931; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=IwlsSfA7SK5PS+loMIuNUAYcVxuEJS/8KwFetEK6oME=;
        b=bhrzkcxZbeRYWKDFy8UxCjHRUDn8lZmt/xgb+i5jC3StVlLFxei4XlXB9QXGgVokLL
         xMi27F7p4U+0MuP07FQQBhR1gIZIHeCs6TUrDv/GVI7fTJqVdWPwtvgpVQhaPpjVDBrq
         SrVyheqyKGqqIqSsuaIAiBLyUZGjLUBgOZmwxQY/yiWokxddicxvbCJrcSE2nnTDml2s
         6MJmxPM4jKBIAmy/yOUsOW0bqCrStNNyJwydrecv8XcKM9L+m+0DDfiZjOL/GZoN4xxd
         FgYFvaZQIR+zZKBvtOhl5vHHx+vi7VTQdlvbWE7LyEgiiU0ruB1XU98Eniw2KTeSW2Eg
         Hc9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790448131; x=1791052931;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IwlsSfA7SK5PS+loMIuNUAYcVxuEJS/8KwFetEK6oME=;
        b=ytOgY6uqvIeegWgewIoxRL78JRO7vOJJKJfWxmv8LkdmVNmOzJ0PHQ7Aobdr93f4oL
         ujXfy0fbEY5laxzqbgRi9cX293ueIIxV/aE3/j6NDCfcpkoEwaOb4vSOtNfhtjKkHtYJ
         +UBnoUXMF2nNpR8JEU6kh3/n+P/Jmqn+zTvD/6vOzI3IQbMY6dwzOIUHbORM1p4lRP8e
         V5710J6knYbxS9hBxWpiDDy/frV3oubKJwFntDMpPgi/G7F4Ay4kIftklJJm0r5vIs0K
         mcVJEhcEOAUssIGvanb1vt4Nty5k+pzKaoJ8hTzeB+LtkTTWzL0XnNOngnsru4NE0u/I
         0zTQ==
X-Forwarded-Encrypted: i=1; AKwUvBwfC353NoFGOvaAPi5mnvOwsemd4vpkYgWUL/U2Kqdm3clss1SBhqHZDwBJfs48Lix/t0Zb0M6rQMnuJjs=@vger.kernel.org
X-Gm-Message-State: AFq9FYJXWsHq243UMn8PcIa7H+QS8rvl51lY8SINo/Y+I4lxuK7tve8n
	M3mf2OvqzmHcipUpqX4aGkGiVRMqA2bABjL92z+zEtAYtuqZp5Ismqtd
X-Gm-Gg: AYBFou2c/YTPnRUnKpm39AcbmAUt2M7D2dh03spI0LsBMp4e86LiI2/hWGeujAuGmUL
	X5snGPruGNU4HKYadKPvSHNjoMcCvtGs6i6WtUdS3OJ9FwReUcjyCZnypXaBjA4ihgQFxb+t8dS
	tts/87ommEUXHM7G0uVFOqX9l8XvRJrVNXorvfRdXIBo82sj2+ll0MtN5dj1TydVjn8mPj7k6T6
	o7BfmhXE3fgSLCt1OtPvQBhim4mpoBTe1SNRHCCKymJE2YlQ/rP8Mgg4BEdYbnXU9A0VDRi8K7H
	8j0uzjUfbTbz+qu1SoVN9YJHy4ZGQp0iG0HfhAvQ/jlH/3e916DuR9HHBrWOVCyKJZzTDb8BIc/
	Zakc2JWqypDJIMGiac8Nkio6JGWgBSlgOCadznXRgV6udZUWoDPIOUWQG5uvKXZQBuq/fIcGXB9
	KMbsjdUj0M+v+Y9LMuuC3zxlaZKR1diVwiw7UnSWtGMSddKR2Flu0ePuP0GAee1R+UdnWDH6Yct
	cMA02YrzW6YXKsUhaZ7XepkDCBWPE7WoRAUIPYf4r0bDLB59aOvkKU7GVsFHAJtK60QQA==
X-Received: by 2002:a05:7301:b0e:b0:33f:3750:4e22 with SMTP id 5a478bee46e88-3426cce6521mr5663350eec.0.1790448129931;
        Sat, 26 Sep 2026 11:42:09 -0700 (PDT)
Received: from localhost.localdomain (95.169.12.199.16clouds.com. [95.169.12.199])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34144f4eb9esm16221158eec.19.2026.09.26.11.42.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 11:42:09 -0700 (PDT)
From: Chengfeng Ye <nicoyip.dev@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Johan Hovold <johan@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Chengfeng Ye <nicoyip.dev@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] tty: Serialize saved termios access with device registration
Date: Sun, 27 Sep 2026 02:41:54 +0800
Message-ID: <20260926184154.3017929-1-nicoyip.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

tty_register_device_attr() frees saved termios data when reusing a minor
number without serializing with tty_init_termios() or tty_save_termios().
The tty_mutex held by the open and close paths does not protect against
this registration-side free.

For example, an n_gsm mux reconfiguration can register a device while its
previous tty is being released. tty_save_termios() loads the saved pointer,
registration clears the array entry and frees the object, and
tty_save_termios() then writes through its stale pointer. The saved-termios
copy in tty_init_termios() is vulnerable to the same lifetime race.

KASAN reported:

  BUG: KASAN: slab-use-after-free in tty_save_termios+0x39a/0x3d0
  Write of size 44 at addr ffff8881012e8180 by task poc/114

  Call Trace:
   tty_save_termios+0x39a/0x3d0
   release_tty+0xb3/0x7a0
   tty_release_struct+0xa0/0xd0
   tty_release+0xc1b/0x11b0
   __fput+0x2f8/0x9e0
   fput_close_sync+0xe2/0x190
   __x64_sys_close+0x78/0xd0

  Allocated by task 110:
   tty_save_termios+0x2c1/0x3d0
   release_tty+0xb3/0x7a0
   tty_release_struct+0xa0/0xd0
   tty_release+0xc1b/0x11b0

  Freed by task 113:
   kfree+0x131/0x3c0
   tty_register_device_attr+0x498/0x8b0
   gsm_activate_mux+0xfb/0x210
   gsmld_ioctl+0x92f/0x14d0
   tty_ioctl+0x915/0x1240
   __x64_sys_ioctl+0x134/0x1c0

Serialize the saved-termios copies and reset with a private mutex. Taking
tty_mutex during registration would invert existing driver lock ordering:
UART registration holds port->mutex, while tty_find_polling_driver() holds
tty_mutex when calling uart_poll_init(), which takes port->mutex. Keep the
new lock confined to the saved-termios operations, with no driver callbacks
inside the critical sections.

Fixes: 93857edd9829 ("tty: reset termios state on device registration")
Cc: stable@vger.kernel.org
Assisted-by: GPT-6-Astra
Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>
---
 drivers/tty/tty_io.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index 48569035da56..26bdc4560a4c 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -143,6 +143,7 @@ LIST_HEAD(tty_drivers);			/* linked list of tty drivers */
 
 /* Mutex to protect creating and releasing a tty */
 DEFINE_MUTEX(tty_mutex);
+static DEFINE_MUTEX(tty_termios_mutex);
 
 static ssize_t tty_read(struct kiocb *, struct iov_iter *);
 static ssize_t tty_write(struct kiocb *, struct iov_iter *);
@@ -1219,6 +1220,8 @@ void tty_init_termios(struct tty_struct *tty)
 	if (tty->driver->flags & TTY_DRIVER_RESET_TERMIOS)
 		tty->termios = tty->driver->init_termios;
 	else {
+		guard(mutex)(&tty_termios_mutex);
+
 		/* Check for lazy saved data */
 		tp = tty->driver->termios[idx];
 		if (tp != NULL) {
@@ -1441,6 +1444,8 @@ void tty_save_termios(struct tty_struct *tty)
 	if (tty->driver->flags & TTY_DRIVER_RESET_TERMIOS)
 		return;
 
+	guard(mutex)(&tty_termios_mutex);
+
 	/* Stash the termios data */
 	tp = tty->driver->termios[idx];
 	if (tp == NULL) {
@@ -3242,10 +3247,12 @@ struct device *tty_register_device_attr(struct tty_driver *driver,
 		 * Free any saved termios data so that the termios state is
 		 * reset when reusing a minor number.
 		 */
-		tp = driver->termios[index];
-		if (tp) {
-			driver->termios[index] = NULL;
-			kfree(tp);
+		scoped_guard(mutex, &tty_termios_mutex) {
+			tp = driver->termios[index];
+			if (tp) {
+				driver->termios[index] = NULL;
+				kfree(tp);
+			}
 		}
 
 		retval = tty_cdev_add(driver, devt, index, 1);
-- 
2.43.0

