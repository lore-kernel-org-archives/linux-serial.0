Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE0C42C3271
	for <linux-serial@vger.kernel.org>; Mon, 12 Jan 2026 22:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768258160; cv=none; b=jg+8/lhUw8rHl5L/pP1u5aJgnUkqfSQc1MpmaFutasy6r46xseFZA6samOgMhW2Bk6r0IgFxkKSDwPzuRnE/y0I7Voe/l+qjuzsvUae5mP7kaAGL1XLaL12Z3Oj7xW18Bwfxkehi2XlFc175LSmaGeq43Y8cGsG5yp8bDZmIQQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768258160; c=relaxed/simple;
	bh=ujjrCeYW4Gws3dC552q2XCMpqxd2pU0ffvvLryV2FnY=;
	h=From:Date:Subject:MIME-Version:Message-Id:References:In-Reply-To:
	 To:Cc:Content-Type; b=txWgquI+2C6+uEgBuMphMfglpX/DoRlxQevdwdpRauoVgCvclAoCv54KpD8l4IIn5tJ0+zMbrt/T8iHRlt9i+CMPMk8mz4T2JH2USbpo+G4Gwx+Oxjrw74AJBE1Otw4MkJyd58YAKona92nS5DWXxaAKMih7wQNM5tj8k2Z1LSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UPJu6o9Y; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UPJu6o9Y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768258146;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xPVVsDO6rA1DUsYXI1T3bEgIhuRr3/ZOG3IZ44Wx0sU=;
	b=UPJu6o9YDEUWMzcSDQx9qtc8/LhRBs9mvTHGWtuyNdsLrGBpuVJrC2On09SuQvbAp8Mb0g
	ujTlUUqeVWSNlRHzy0JO9zWehoSKkC2R7z2m4mARXDXCZkH9CntOeW/Aaj78XdRYVn5Cnu
	Mklsctr+f7Sa7PKicG6yxv4y7fCokyQ=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-376-cWNaW3G7Myu6bbjQyxukVQ-1; Mon, 12 Jan 2026 17:49:05 -0500
X-MC-Unique: cWNaW3G7Myu6bbjQyxukVQ-1
X-Mimecast-MFC-AGG-ID: cWNaW3G7Myu6bbjQyxukVQ_1768258145
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8b2ea3d12fcso369557385a.0
        for <linux-serial@vger.kernel.org>; Mon, 12 Jan 2026 14:49:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768258145; x=1768862945;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xPVVsDO6rA1DUsYXI1T3bEgIhuRr3/ZOG3IZ44Wx0sU=;
        b=Bm3lZGFR1TLoF8AxRa1PgO05DvCGptnOdh3ihIjkKOjA75vDC6JuK/z9pS0ve668rj
         8/ooeHK3O8r3CtUQIdoBuMRkDDPmMTIxGuoVN29HRJy/6vA7Hj+8sIu2pSAXefVQS1es
         wBJundyx6yVtmhiFxuazAOeVbhaZ37RSKchBv0QOUdwvGC5aMSHZY/YR9Hdj6qT95Ino
         BIgkJ/eLNUdsfKkRWsoYAmWpvtYX659ffpjB9n/pB8ZZxW+ELGzlBFNMxJoRlG6mGJe+
         3fQ+GBGJYwmwTKnzuVgMeKfp/SJfM7fnHP1gDXEhKJJUNzRJSTCfCdQA2d4238Z1ecvb
         lD1Q==
X-Forwarded-Encrypted: i=1; AJvYcCUvy2lP7/4ihXwR2c9jcU3cpoQ15zpKpIwcE3usqcFgJk5C80lP42C/BZG+/0nHHv96PLGjNbJNnR2n9M0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCQWgPBj5qXRP1eD3jqKkFXmfJk74jKSb7/uYvOtCQaQLY6vhf
	FRiDO9/Iq87UrdagNBEyE98vgx/aFf3M+aDYFtSdqiX4nTiIDsKFERNy1DbdrPIoybAstl8V939
	X1QUtujCW+kHIY7fbj7lkFTVJKeRHQQe67EpmzPEZGKbZhcydT4EnEFA2l5MXlJs3Bg==
X-Gm-Gg: AY/fxX5i6b1uuTxT4R7YFWQp7xULvl4wr8U9sL1TeZkLgNoP/D2Vvo56xCi/WRIERQY
	+cIBWV9MFNucsE8xZ8ZVVMp7bv1HYUrHOFWoT8/1izeHFmAHBNGNTF4CCamme7Hc7PFTlXHTKie
	VrIlO6Cl6MgI9aDMQB0ErwtUD4UJsTTqxRtgUiwEtu2n68M4W4rEDMoF8UBJ/I+QGGRfTj1eLC5
	SfjosQx91g/cNeeblWx9nHRtIV7VDJYMHyQyeJuR7tDCh5n2DylicIhUu2eIH9sIOoKIinlL/xO
	hFZ0NewSyZFCLZr+KQKnrkX9xRPPB3g/zJdiIEjBwlf3qvgQ092qzle6CC45RWb8bAW5YR+bkxy
	UQc7jAcOev+tzG+zg5kkDVSgX+v6VdNpRiH0nGWWorVtFZmf+6g==
X-Received: by 2002:a05:620a:191d:b0:8bb:ac44:bd34 with SMTP id af79cd13be357-8c389368d86mr2436420685a.4.1768258145084;
        Mon, 12 Jan 2026 14:49:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFNXCc8z9qIgmtoPJLDZiBaHPvREI5QKz6xqckNeA02fMmWIrp28+uV08fFzeeVnlq/j5MHQw==
X-Received: by 2002:a05:620a:191d:b0:8bb:ac44:bd34 with SMTP id af79cd13be357-8c389368d86mr2436418085a.4.1768258144624;
        Mon, 12 Jan 2026 14:49:04 -0800 (PST)
Received: from [192.168.1.15] (c-73-183-52-120.hsd1.pa.comcast.net. [73.183.52.120])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c37f4a6145sm1580930385a.5.2026.01.12.14.49.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 14:49:04 -0800 (PST)
From: Brian Masney <bmasney@redhat.com>
Date: Mon, 12 Jan 2026 17:48:06 -0500
Subject: [PATCH v2 12/16] serial: pic32_uart: update include to use pic32.h
 from platform_data
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <20260112-mips-pic32-header-move-v2-12-927d516b1ff9@redhat.com>
References: <20260112-mips-pic32-header-move-v2-0-927d516b1ff9@redhat.com>
In-Reply-To: <20260112-mips-pic32-header-move-v2-0-927d516b1ff9@redhat.com>
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Brian Masney <bmasney@redhat.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1095; i=bmasney@redhat.com;
 s=20250903; h=from:subject:message-id;
 bh=ujjrCeYW4Gws3dC552q2XCMpqxd2pU0ffvvLryV2FnY=;
 b=owGbwMvMwCW2/dJd9di6A+2Mp9WSGDJTq3xSvDvZXIseCG8/w7I1cUdP3sV3++582GLI+WOu0
 v6IW88rOkpZGMS4GGTFFFmW5BoVRKSusr13R5MFZg4rE8gQBi5OAZjIQVNGhpcPaxNz/7ac/Xzk
 OdPLhcZ2u9Y3OPZ+N4pffEFq3iX9f1IM/9Put6XPv/nbMz9jqeFny70FDT8Wi/a66mgGdjdYtl2
 VZQYA
X-Developer-Key: i=bmasney@redhat.com; a=openpgp;
 fpr=A46D32705865AA3DDEDC2904B7D2DD275D7EC087
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: rx9w-FHUNlcWcjfGgo3e9VBbQTgfGZOJLuDYzeCccvs_1768258145
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Use the linux/platform_data/pic32.h include instead of
asm/mach-pic32/pic32.h so that the asm variant can be dropped. This
is in preparation for allowing some drivers to be compiled on other
architectures with COMPILE_TEST enabled.

Signed-off-by: Brian Masney <bmasney@redhat.com>

---
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jiri Slaby <jirislaby@kernel.org>
Cc: linux-kernel@vger.kernel.org
Cc: linux-serial@vger.kernel.org
---
 drivers/tty/serial/pic32_uart.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/tty/serial/pic32_uart.c b/drivers/tty/serial/pic32_uart.c
index 14d50bd7f1bd3575e60e51783bf5b2d821f9168d..8407f85776c07a7495688fc4f95b8672b1543bd0 100644
--- a/drivers/tty/serial/pic32_uart.c
+++ b/drivers/tty/serial/pic32_uart.c
@@ -22,8 +22,7 @@
 #include <linux/tty_flip.h>
 #include <linux/serial_core.h>
 #include <linux/delay.h>
-
-#include <asm/mach-pic32/pic32.h>
+#include <linux/platform_data/pic32.h>
 
 /* UART name and device definitions */
 #define PIC32_DEV_NAME		"pic32-uart"

-- 
2.52.0

