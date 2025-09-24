Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92366312817;
	Wed, 24 Sep 2025 15:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758728282; cv=none; b=IT3Ux45uyb28Fen8DvK7LwKWHmxss0Ipa0H1sHQRDlZe6zwVSaxFTR1U+Io+UuROXInwIG7V7jRG2Hy5Ls/CT5CjlAfoMJwIR3uTNv7P8uNBW3//nOP5akQyjhZqvkIOixFkJ8Qt/rj6GfGDzRgrrEjUL1gHuZyxRd3dxh8kMh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758728282; c=relaxed/simple;
	bh=+3u4GT7ho/fVnLlm9Fb0g30Tpf6refpWMMmq6XbmcbE=;
	h=From:To:Cc:Date:Message-Id:In-Reply-To:References:MIME-Version:
	 Subject; b=D2nUAgsaDVkUtnWkzJtynOJS0S0OrInfBd4l+iv+Jq/AvqoLs1jaIgVg3dWX0OgWgxzsU2VNjjbQ3ferI92bA3MyBzYi6sn347NvIRY2E1a0sAwggkKWmVYdeKMfRInj4Qhbtrw8H5UsYRML7Hp2YNKWkfPZce/brRRHgtBOdgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=xqZ0Vi9z; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="xqZ0Vi9z"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Cc:To
	:From:subject:date:message-id:reply-to;
	bh=qoaY+ZoNwdZMOnb1nwaF8EXSI8+/WdKyXHOeBl5C7Fo=; b=xqZ0Vi9zNDKH+uNGDTbD0EM9Mz
	/Vnqly+ju8dhQuEmnLQEKsP8ICCODT34g4MRAx3NcFgtNU7OzCaduUKCN9BaIRXIxOmyPMaR/usRV
	5kY4bOUWgTJoeJoYqVwnCMRXi8o1ighu2DyOTdBUyYXoMZWuplI1Z6EHofQr/ZhNKTKs=;
Received: from modemcable061.19-161-184.mc.videotron.ca ([184.161.19.61]:51978 helo=localhost.localdomain)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1v1RZ3-0000RT-EY; Wed, 24 Sep 2025 11:37:53 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	fvallee@eukrea.fr
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	hugo@hugovil.com,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>
Date: Wed, 24 Sep 2025 11:37:32 -0400
Message-Id: <20250924153740.806444-8-hugo@hugovil.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250924153740.806444-1-hugo@hugovil.com>
References: <20250924153740.806444-1-hugo@hugovil.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 184.161.19.61
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Level: 
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
Subject: [PATCH 07/15] serial: sc16is7xx: declare SPR/TLR/XOFF2 register as volatile
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

SPR shares the same address space as TLR and XOFF2. If SPR or TLR were to
be used eventually, this could lead to incorrect read value from the cache.

Prevent this potential bug by declaring SPR/TLR/XOFF2 as volatile.

Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
 drivers/tty/serial/sc16is7xx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index 4384804a4e228..96ea308013912 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -545,6 +545,7 @@ static bool sc16is7xx_regmap_volatile(struct device *dev, unsigned int reg)
 	case SC16IS7XX_IIR_REG:
 	case SC16IS7XX_LSR_REG:
 	case SC16IS7XX_MSR_REG:
+	case SC16IS7XX_SPR_REG: /* Shared address space with TLR & XOFF2 */
 	case SC16IS7XX_TXLVL_REG:
 	case SC16IS7XX_RXLVL_REG:
 	case SC16IS7XX_IOSTATE_REG:
-- 
2.39.5

