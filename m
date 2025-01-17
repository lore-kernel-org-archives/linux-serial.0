Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 097831F7547;
	Fri, 17 Jan 2025 04:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737088484; cv=none; b=tebBYcjlq/3xWHwFeOzU/oXMTCojs3oCXZesmfX1Qzchtg+XZPBkOtRZlHonrUGwH6RmQp+Xm9hDBa6w2SMYkGObiTVApblxHRjoXYVoyCN6txoSu+xN45Mq3iFgEwVQKL8nJlWRq6W9kZXNY61pZqXNiFJEENTx2UnOdgg7wew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737088484; c=relaxed/simple;
	bh=RLUrjXEZhDGki/Pjxx6XNvFMLKuYY0/Z5oalpjyhVtg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ou+D9QZbSx9cSA/5srGIxtE8+HUefztWUNmasGR8z8JitM+A8c3UkDvF+P2/rZr5otAKdZRWADW9+0VDWppQ7V8eZf1/1dNRErOFRfx0wE8fa3ET+YtxE4Y5a+QP1UWefzpKrwBwfKM+L/eRLwYaswS8scGY2XaKHuf4g8ATfT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dGKFvCvL; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dGKFvCvL"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4678afeb133so25799391cf.0;
        Thu, 16 Jan 2025 20:34:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737088482; x=1737693282; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fo3zhZXJ/GxhiVMRgC/sUpGvGabIKgXyUMS9I6R5PMM=;
        b=dGKFvCvLiPCbQHwKH13uecTOFAquVLGnFkTe8AEKZJPJ3442e/0w4zGNr0nH8M5pm8
         8cor6ibjYwrR6eeMweU8lXgiumjhz2jV61aFFk3/LgQUGIxj4JfR3UARiEP6LpXZZKy9
         /B4DdtFbkSw+dW0tiliKGiDekyMqrMMIZ7kAJN2rzAFRb8eeYRSSsfWSLObvHjF6Dr4p
         he6I/yIqG0G6rqYwxDzz0BjePRGn9TY1+oYPqY/o6ZApre4+KM3GeUIqsGTqdpQJfUfT
         aT5KS7sv8RSF6YK8tEEg6Gt2SiUqXyUd4XUcUUmngbrqtIDsYapL7W1MUg2EydmsYexd
         1xLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737088482; x=1737693282;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fo3zhZXJ/GxhiVMRgC/sUpGvGabIKgXyUMS9I6R5PMM=;
        b=uQVwzuJjimL2ApoV91XvXuWDYgVCcBHVddKeCnADNRtafRNr8kgXqiwZ18OHioqpsE
         zS58u2q4WQLCYe5c2ojjoEGedweJN0VM998ZTmAqpwqW4aBgnWJMNlpG0FKqCGrPG3UL
         o69WDpWfxvO+anCc1lgAzIbM9+F+PN7Rd3JoFHn0MLBOFljuayvsuG7vWGcrY/AMhLVU
         oZp+/T+SSGcMFpofHvW2IdYtmlH2BuzLIB1KSQNE4R4IIN+i5OuF1PUmIBixzGRgs8HB
         b4L5inB4oe10XTRRgqq2ioCLLHruIeCdQBLIUQsU5BAm2TmqH+TxlauI3W/nRk3RsNO8
         xitg==
X-Forwarded-Encrypted: i=1; AJvYcCVifaRbssH14asN++bspFoBSItJpxQ7GtxHN5B+esNfaitBQhfdulAmBvqaxJlFZ2o3kR4zLy11dAn55zw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbhIKVvaYTyKjG7zaaU+ZXCHISVD7ax2Hcfnf8HziNYCWf6qsP
	4GUIP/mQTSaMdVQuOU9l58RVhyVKE7adkCtkj0597NXusujGw52n1lqvAg4S
X-Gm-Gg: ASbGnculPKP7FvCZR49Nj33ADEYE3cxCJwXnohTxy/YmBTLAiX34kou91KyycfhiajB
	7WdLGqpF40UDG8fU9xWPBKIWrAOPsW+19Fi7QROpzMmnj2alDnLmhiQ2ER/vE1cghnOmFES9G5f
	GY5Qy5OTyCqmethSy6B8CoyyN5pqEirPlya1JNb4YYyi+QaAjFLMdScySBH5krxuFXA2Qrp47iG
	XLjJhDR05ercjto+kV7YdoGYnHUq0iSzUSM4ZREH9ki4nOrmjU3uOi5I0oHZCnZShKTdXQ699zv
	+OExWrnxgKNsUSyA8q05+WJdBcVrgICupX/06+jVffeNlYdZ8r958HtgqYI=
X-Google-Smtp-Source: AGHT+IEGDLU4aro9nxePiLc9jsAoQF+3FAn9WTMh06y7ObDygNhCEISqBknrcEXo4hUCFJNWyZ2OzQ==
X-Received: by 2002:a05:622a:1922:b0:467:6a8d:e01d with SMTP id d75a77b69052e-46e12e8ea52mr18948211cf.18.1737088481780;
        Thu, 16 Jan 2025 20:34:41 -0800 (PST)
Received: from nerdopolis2.mynetworksettings.com (pool-96-238-19-91.prvdri.fios.verizon.net. [96.238.19.91])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46e10404a2dsm7514911cf.52.2025.01.16.20.34.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2025 20:34:40 -0800 (PST)
From: adamsimonelli@gmail.com
To: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jiri Slaby <jirislaby@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Adam Simonelli <adamsimonelli@gmail.com>
Subject: [PATCH 2/2] tty: Change order of ttynull to be loaded sooner.
Date: Thu, 16 Jan 2025 23:34:27 -0500
Message-ID: <20250117043427.1512743-3-adamsimonelli@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250117043427.1512743-1-adamsimonelli@gmail.com>
References: <20250117043427.1512743-1-adamsimonelli@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Adam Simonelli <adamsimonelli@gmail.com>

If CONFIG_NULL_TTY_CONSOLE is enabled, and CONFIG_VT is disabled, ttynull
will become the default primary console device, based on the load order.
Users and distributions that are migrating away from CONFIG_VT will
benefit from this as /dev/console would not suddenly become /dev/ttyS0
which could otherwise cause some user space behavior changes, namely the
TCGETS ioctl failing, which causes libc's isatty() to incorrectly return
false when /dev/ttyS0 is disabled, and will prevent a device that is
connected to a user's /dev/ttyS0 to suddenly start getting kernel log
messages.

Signed-off-by: Adam Simonelli <adamsimonelli@gmail.com>
---
 drivers/tty/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/Makefile b/drivers/tty/Makefile
index 07aca5184a55..03bb47e11e1c 100644
--- a/drivers/tty/Makefile
+++ b/drivers/tty/Makefile
@@ -11,6 +11,8 @@ obj-$(CONFIG_N_HDLC)		+= n_hdlc.o
 obj-$(CONFIG_N_GSM)		+= n_gsm.o
 
 obj-y				+= vt/
+obj-$(CONFIG_NULL_TTY)		+= ttynull.o
+
 obj-$(CONFIG_HVC_DRIVER)	+= hvc/
 obj-y				+= serial/
 obj-$(CONFIG_SERIAL_DEV_BUS)	+= serdev/
@@ -20,7 +22,6 @@ obj-$(CONFIG_AMIGA_BUILTIN_SERIAL) += amiserial.o
 obj-$(CONFIG_MOXA_INTELLIO)	+= moxa.o
 obj-$(CONFIG_MOXA_SMARTIO)	+= mxser.o
 obj-$(CONFIG_NOZOMI)		+= nozomi.o
-obj-$(CONFIG_NULL_TTY)	        += ttynull.o
 obj-$(CONFIG_SYNCLINK_GT)	+= synclink_gt.o
 obj-$(CONFIG_PPC_EPAPR_HV_BYTECHAN) += ehv_bytechan.o
 obj-$(CONFIG_GOLDFISH_TTY)	+= goldfish.o
-- 
2.45.2

