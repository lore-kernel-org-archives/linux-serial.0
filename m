Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FD8A233721
	for <linux-serial@vger.kernel.org>; Fri,  8 May 2026 19:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778267599; cv=none; b=lfPIr8itifNmyeU8Bw6RUVqKAilXXch9Kme916+iUOJPz7rNFHxKPpCKeosXwUIv6vm9KEP7ItFM2TbjkaDiWs6T99uITsfMlsxceNCPWz4JVzW3/mfHIQhQX+1ezu+4BKquRdF70uSgeq8IRXmkHD6fj/KgnPQZEyfJpg098G0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778267599; c=relaxed/simple;
	bh=m+PNYt/eWysm9k+FR9iBvcdxWi6AKRQIzayYMpLkT6k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=t4kahCliXM4ikJzm44TfWESeKIwYuau2A4B/Fy5rHmPRLSXJYZ8BKVitf65o8tAXrhsqb0Yysd4eVJiFWfjBq17Tsq5czIaUN+jf9Q+R6TGuhkaF98Y/Zf6q3MtV33wv5nHxGVIe2WG4ikN9Nvk4R/1w3ciRumq1QsaRk71fPb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pKDjQX5+; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pKDjQX5+"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4891c569cb1so1774945e9.2
        for <linux-serial@vger.kernel.org>; Fri, 08 May 2026 12:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778267596; x=1778872396; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ss2dNfL6Ott2JQyZMGJaHzME4Ht5awruV2D2eXagSaA=;
        b=pKDjQX5+qWTk26476bUO0x2YWtQLxK2f0Qfo9Ds42eZPIiX8I/5JzH6XYtR4pVhHda
         vxbDGQhI1Rtjju2stU4SrKxoisQDn+pES3dvYCM0+WNFjsx/MY3GnHvo+LDniVRZswq0
         MEnWCkY6EwIns5s0Fo9p5zNyJ0UGDnjndJNGolccCDn/7Kt+K3M5Hg6oC+d4B5mB1PJV
         +ibi9kfHGO61F37k2fGtMJ43m6iDdOjTdk3l6nNlQxe011S6k7VGoJHi6ivOU20iDaOx
         ZG3alHfEmVkWuh+bGA/5eCnN5nLLSlFens11Obk+BG0gCpEFAoa9e2LEe3dUTdsr02+E
         /U2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778267596; x=1778872396;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ss2dNfL6Ott2JQyZMGJaHzME4Ht5awruV2D2eXagSaA=;
        b=jWP27KBVRfpxpF+bdYwhUNqqFajs7dpkKcbecLOUFZyT3N78bnM/2UQLavT9SlvWOJ
         s5S8OrP8UkeanPBtjn1UL7cBSSb97w+EpAC7a675YeJZkNRcGKBwfU2JBNWfNocYRFp+
         1MxDnI9Ox2exHFgtj7Hnv8DPGCGVMpKUN3+0UAKZnd29fVMcFrXKzR3moazZ2vW3h4Mk
         jS2vNtj7p5K1xP5D5KAiqy5bvdMlW3BO4lLmhlcYj3mlVUPUlfoae4FErygW3sbVOW6Y
         3vlBbQGXNZIY1cfMMSDj6MgzEFLqFikRQ5k4Mvq3ri/lXcsu6OpCmPW/WDQzbpSSSvlC
         BFRQ==
X-Forwarded-Encrypted: i=1; AFNElJ/4NxovU0BuhXut0tKe8vOhpm1ZsPg3BnHc8ZBJa/X9MF7Efp5cylWE9Dcjry1Z62FcOIowHRlg/pXz5PY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9QW24uFdyTx+Ps/63SjAp1Rxfs+EokItuKaQsDD7QTnRVQXeF
	8dWXrANSAs1ZzfuT4HyVuSLLk885NT1gbbGO3jI76O7zTCMbydFJ1QZMgxhDHWzAHVJlfg==
X-Gm-Gg: AeBDieuVZ7Zm5pKpWFy6C+x/QTsnhrBdvJX6C9Yoq+ej4WXUVrnZrCJJQf8uMNVjxYB
	y9BVMf+GXR7dYwb3NOuzXzFy6sPDxhbOnqQOlCoYaRkFW3KS/Ce86IhYpDdtHi5kNBpbDn3kZ3/
	v9KYJoCjfTWNYIq6rIOwsxCAyXjriC4CcJAxbSNXrwRO5xaGSRBZBF71iBNfyd7nV1kcIQFGMAN
	LJiQc2geNcOER0rHgGS8wxsUYmxvHx01XVoukbCw+9s/DR4nOQ+QPbQ75pkJliu3aCU4JdaB+sj
	MZp7ntV9OB+yOB8O87XqBan7B+a6+GoUB+hglLnELt/gAOsvD0zsTmoj8vwJ4f/ytSauEgc+qEV
	E3F0zlNLetYGLBfcewHvpjkwqX2Jo3F09BlnofvU+rIYv6xNmzpXpJUzEzZmJh6myWqC/C9IBdn
	fF+1ZzTntY+6ftSrHlBEKgNXV1/EwhgT8J9bVgknRtum8=
X-Received: by 2002:a05:600c:46d2:b0:488:7e7b:dbc2 with SMTP id 5b1f17b1804b1-48e51f4539cmr107036435e9.3.1778267595629;
        Fri, 08 May 2026 12:13:15 -0700 (PDT)
Received: from localhost.localdomain ([94.158.58.43])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e6d8946a5sm13333695e9.0.2026.05.08.12.13.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 12:13:15 -0700 (PDT)
From: Stepan Ionichev <sozdayvek@gmail.com>
To: gregkh@linuxfoundation.org
Cc: jirislaby@kernel.org,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stepan Ionichev <sozdayvek@gmail.com>
Subject: [PATCH] tty: serial: 8250: protect against NULL uart->port.dev in register
Date: Fri,  8 May 2026 23:12:37 +0500
Message-Id: <20260508181237.11146-1-sozdayvek@gmail.com>
X-Mailer: git-send-email 2.33.0.windows.2
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

serial8250_register_8250_port() conditionally copies uart->port.dev
from up->port.dev only when up->port.dev is non-NULL:

	if (up->port.dev) {
		uart->port.dev = up->port.dev;
		...
	}

So if both the existing uart slot and up have a NULL ->dev,
uart->port.dev remains NULL. The very next ACPI companion check
then dereferences it unconditionally:

	if (!has_acpi_companion(uart->port.dev)) {

has_acpi_companion() reads dev->fwnode without a NULL guard
(include/linux/acpi.h), so this NULL-derefs the kernel for the
remaining no-dev case rather than just skipping the
mctrl_gpio_init() initialisation as intended.

smatch flags the inconsistency:

  drivers/tty/serial/8250/8250_core.c:767
  serial8250_register_8250_port() error: 'uart->port.dev' could be
  null (see line 719)

Guard the call with a NULL check so register continues to work
for callers that legitimately have no parent device (legacy
non-OF/non-ACPI registrations).

No functional change for callers that pass a non-NULL ->dev.

Signed-off-by: Stepan Ionichev <sozdayvek@gmail.com>
---
 drivers/tty/serial/8250/8250_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index a428e8893..e136cec0c 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -764,7 +764,7 @@ int serial8250_register_8250_port(const struct uart_8250_port *up)
 	 * Only call mctrl_gpio_init(), if the device has no ACPI
 	 * companion device
 	 */
-	if (!has_acpi_companion(uart->port.dev)) {
+	if (uart->port.dev && !has_acpi_companion(uart->port.dev)) {
 		struct mctrl_gpios *gpios = mctrl_gpio_init(&uart->port, 0);
 		if (IS_ERR(gpios)) {
 			ret = PTR_ERR(gpios);
-- 
2.43.0

