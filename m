Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 990843BB117;
	Mon,  8 Jun 2026 09:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780912553; cv=none; b=ZP8jZabItTG2H5+CzoYyQhHUcQdhkH3fe+91e8OhMz7DU2Gu7b4P+t3/w+7o90YqfVvrLwoPASq9jD5vQV3B8ufa6TD0P56zL4ErXwm5a1so1FjVK4+/kEVtmhEJfUvNfdZg0JffAzVhEX2VYIvwxyxPkU5swZYAGNVtmsEPBcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780912553; c=relaxed/simple;
	bh=2O89CWqhRpKEzZ2u+xHYVyslLDSn3l3Ta5m+7ffiUNw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=u5UjWNfdP0UvVh+oS20MelvzwoiMMTytQ18KTyRF0O4ZRGNu72oS/DM0ydQps8HVHZ6CBJQSYqDybdvXhzgN/WL6FuhDtuIbwVnJ/KUyDLwU9DQ08cW+FUL1Wn6jOf5oIM+A7ET2xF+dosAYQKfTLFCj0u+SN8u8do/8jY7zjXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=runbox.com; dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b=cF/mryfZ; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=runbox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b="cF/mryfZ"
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1wWWhs-00BS23-K4; Mon, 08 Jun 2026 11:55:44 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com;
	 s=selector1; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:
	Subject:Cc:To:From; bh=rvltOuV90ap6k1f5fUucKTBehM0UPXTMECMqjLtLd9s=; b=cF/mry
	fZJf0etzYbMIpJwCdpHSxz3+IgWctZFNO4GJJ5zpKBBcgg9Hgs9ttGT+g/cVIIhRWa/brbDEnvCk+
	Oiohv/Obwq3K3v2utyxH9T3wxpWdHn+Burw/6/ZoUPzs/aPbZCl8IeLkrcabJoujrnuPV3tGgnvBL
	GZ6FRIHGITqcPUkdDRp6v2R9UWZihWV5VKb4ugcdwjDOnLOs0SX6Erl/o7XpgCk7pv47S3MNY6E2j
	cntCORMTPqKER4q+M1Mk3Y2I9z9ux24pGz5ovCoTwncEJ5je9A4Gbd2PAYgSoIPJ0crc8OukHxuPe
	OyU/fp+0O++Urgy1h+w0m3MtxdFA==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1wWWhm-0003bZ-5Z; Mon, 08 Jun 2026 11:55:38 +0200
Received: by submission02.runbox with esmtpsa  [Authenticated ID (1493616)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1wWWhd-00Ag6G-Fz;
	Mon, 08 Jun 2026 11:55:29 +0200
From: david.laight.linux@gmail.com
To: Kees Cook <kees@kernel.org>,
	linux-hardening@vger.kernel.org,
	kgdb-bugreport@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Arnd Bergmann <arnd@kernel.org>,
	Daniel Thompson <danielt@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jason Wessel <jason.wessel@windriver.com>,
	Jiri Slaby <jirislaby@kernel.org>,
	David Laight <david.laight.linux@gmail.com>
Subject: [PATCH next] drivers/tty/serial/kgdboc: Use strscpy() to copy strings into arrays
Date: Mon,  8 Jun 2026 10:54:54 +0100
Message-Id: <20260608095523.2606-10-david.laight.linux@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Laight <david.laight.linux@gmail.com>

Replacing strcpy() with strscpy() ensures that overflow of the target
buffer cannot happen.

Signed-off-by: David Laight <david.laight.linux@gmail.com>
---
This is one of a group of patches that remove potentially unbounded
strcpy() calls.

They are mostly replaced by strscpy() or, when strlen() has just been
called, with memcpy() (usually including the '\0').

Calls with copy string literals into arrays are left unchanged.
They are safe and easily detected as such.

The changes were made by getting the compiler to detect the calls and
then fixing the code by hand.

Note that all the changes are only compile tested.

Some Makefiles were changed to allow files to contain strcpy().
As well as 'difficult to fix' files, this included 'show' functions
as they really need to use sysfs_emit() or seq_printf().

All the patches are being sent individually to avoid very long cc lists.
Apologies for the terse commit messages and likely unexpected tags.
(There are about 100 patches in total.)

 drivers/tty/serial/kgdboc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/kgdboc.c b/drivers/tty/serial/kgdboc.c
index 5a955c80a853..09648d643897 100644
--- a/drivers/tty/serial/kgdboc.c
+++ b/drivers/tty/serial/kgdboc.c
@@ -363,7 +363,7 @@ static int param_set_kgdboc_var(const char *kmessage,
 
 	mutex_lock(&config_mutex);
 
-	strcpy(config, kmessage);
+	strscpy(config, kmessage);
 	/* Chop out \n char as a result of echo */
 	if (len && config[len - 1] == '\n')
 		config[len - 1] = '\0';
-- 
2.39.5

