Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WEnlCspJ"
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E955810C2;
	Sun,  3 Dec 2023 11:34:01 -0800 (PST)
Received: by mail-ot1-x333.google.com with SMTP id 46e09a7af769-6d875809921so1148172a34.3;
        Sun, 03 Dec 2023 11:34:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701632041; x=1702236841; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4YGRNDAChzcpaz6DA4kFDpotF2uCzYOTR4dLduIm5dA=;
        b=WEnlCspJHIVcyo3FjFMMypzkEyoyDL1AhF/sQxLQoU16ClTrXre8cBNsOHrfBGrMUt
         DdaxGb23z/NqpklT+Y5dHWAtlUvaM38sHa6rlnFIxHY1l5Hdo9wZ298W2dkBfFy5M4vc
         J2CPOUxc7iP27k/joKKsOb6j720nz6sh2364t/MNk9nwifWPWrlUPDFb/XFHD2GwtKHg
         MEL3dbt4Q8stwYvYpShw09GX1/nFlnFUoj1Ce0ywFqNILdwOWGjvEB8U/f98gHV///sh
         j0TyN/uEQbiRdq8li6MlYC+IwG04ZkmOPVRmMDbP7/bBTZ4Zm3UnLvZE2mrRoMiBYFmZ
         iVdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701632041; x=1702236841;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4YGRNDAChzcpaz6DA4kFDpotF2uCzYOTR4dLduIm5dA=;
        b=JqxTGcDWiQ//WHKSvwWPGgZrr2XlkkBlKhDsrN4vlpGCzC/emQgoWyem2U6Xi7lp/o
         g4JqzverNpF+x6x2XgBE5S0FR9DGr+R4Kvnpm5VfPHU7sFaOJly9NF3DVSK7j5V4v+Zn
         HfruHjYIrbuN8mdyYOdnc8F4rhCYMvJ4gx4vGQA31AQyu1UgLuJBfbMOufUdUovTwlXt
         kTytbBV21EKrcUyhXuBQlz59/v5aCKfY8UGAIjsThvoewsZCsDa6mkB2glyPxOqe00ws
         xcdMpikp1ohC687Lr8GWA577V7Ucmonhy8atN18GouXqkMJuiRFKc+740X38vZFOMGTd
         srjw==
X-Gm-Message-State: AOJu0YyLcCAd28ZUBQ7RhnD/MeT16CcICRcW9v//yu/i+A7pvbNm/jg7
	Ulx2QCcQ7hxzoTTrYFXcEfaJH1FdFPwpJw==
X-Google-Smtp-Source: AGHT+IExsLn0go1OA//DeYwHNGrL21qoUugcZ1F84U/o5gtE7SJTR+zyNaqzlUxRm+fFiRK/9hPb/A==
X-Received: by 2002:a9d:6186:0:b0:6d8:11ba:ed47 with SMTP id g6-20020a9d6186000000b006d811baed47mr2857309otk.14.1701632040714;
        Sun, 03 Dec 2023 11:34:00 -0800 (PST)
Received: from localhost ([2601:344:8301:57f0:cb98:c3e:57c:8191])
        by smtp.gmail.com with ESMTPSA id z2-20020a816502000000b00597e912e67esm2759736ywb.131.2023.12.03.11.33.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Dec 2023 11:34:00 -0800 (PST)
From: Yury Norov <yury.norov@gmail.com>
To: linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Lech Perczak <lech.perczak@camlingroup.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Hui Wang <hui.wang@canonical.com>,
	Isaac True <isaac.true@canonical.com>,
	Yury Norov <yury.norov@gmail.com>,
	linux-serial@vger.kernel.org
Cc: Jan Kara <jack@suse.cz>,
	Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>,
	Matthew Wilcox <willy@infradead.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org>,
	Alexey Klimov <klimov.linux@gmail.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: [PATCH v2 29/35] serial: sc12is7xx: optimize sc16is7xx_alloc_line()
Date: Sun,  3 Dec 2023 11:33:01 -0800
Message-Id: <20231203193307.542794-28-yury.norov@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231203193307.542794-1-yury.norov@gmail.com>
References: <20231203192422.539300-1-yury.norov@gmail.com>
 <20231203193307.542794-1-yury.norov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Instead of polling every bit in sc16is7xx_lines, switch it to using a
dedicated find_and_set_bit(), and make the function a simple one-liner.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 drivers/tty/serial/sc16is7xx.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index db2bb1c0d36c..6a463988d5e0 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -427,15 +427,9 @@ static void sc16is7xx_port_update(struct uart_port *port, u8 reg,
 
 static int sc16is7xx_alloc_line(void)
 {
-	int i;
-
 	BUILD_BUG_ON(SC16IS7XX_MAX_DEVS > BITS_PER_LONG);
 
-	for (i = 0; i < SC16IS7XX_MAX_DEVS; i++)
-		if (!test_and_set_bit(i, &sc16is7xx_lines))
-			break;
-
-	return i;
+	return find_and_set_bit(&sc16is7xx_lines, SC16IS7XX_MAX_DEVS);
 }
 
 static void sc16is7xx_power(struct uart_port *port, int on)
-- 
2.40.1

