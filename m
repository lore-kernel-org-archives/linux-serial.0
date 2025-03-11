Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8BCC1EA7DE;
	Tue, 11 Mar 2025 03:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741663908; cv=none; b=Aucl36LTSHqEY1Fl7xPh5LShtHlbXuOKtp5zqZiovuqfbLkpr2Az8qtsqqhcHd99r95XShw3QqsATTT519MTiMXxp63aOU7vE/wPLkLURVAym/3uGrE+9ckq3piV1awU4mtAbC2aRR5x+tP9D+TiEwMkShWf9lDsKxZlbSCoxpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741663908; c=relaxed/simple;
	bh=gRv7CV35Y+wxD8+twcYg9frzBTRq/XFnU65egWn7k6c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N+8ulKgIfzho4oGEqVV86HTi9PiFvza/4fHfYN7D/FjQUMMAD+Di6PeAorW3Cx8z+kgQvRjK4Qa/3KezH3rlbAZ7ejWLVtMGsUPGGOI1dTGm+LmwLOOKyP1eCdRz4/Zov6iVIovBRN9HiFuUjbzyqJdIxklo9tRX1PnJl80S9R0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mk5/APvl; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mk5/APvl"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7c089b2e239so448279285a.0;
        Mon, 10 Mar 2025 20:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741663905; x=1742268705; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lcg5+dUnqHObtyvwEawYvLNi2iYwLJnPZJ0YScHoNmg=;
        b=mk5/APvlGv9pWw0JnzoXlCTmbPJKOn2jSB71JNgpuyI1wCMpUsiLtDxKyQTHrQ0vaf
         +hAQTI/AYUznjZUAzooR58DyaLn351ly62l8qIvPgiCSS6wEMoobHxmJ5x3AWKZJY6eW
         IkUdum7pxSpctmhCbGuOX5S5oVD9eNOa39OmCkyu9hNA/ATWFy0t7uT1L1oIK/8RStTE
         Pq7QCdzFCV8x+Ako9PFCsqfaFNB0D/DFJqhBkxcg5t3gEmC3aDDniOSO3b9sf/P9duer
         wl2z+PjFRTQrmVkVcarYFHYx7X6yL28GHlrAbMc2eh4UG9FODR0PepdttLJoIArljI+2
         qUkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741663905; x=1742268705;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lcg5+dUnqHObtyvwEawYvLNi2iYwLJnPZJ0YScHoNmg=;
        b=xQvQQGQLXy32/aySED1myCkOa8D6Kv3HjdCQyMGQK0oKwrylqL7RUGvHgaCF0UYwmL
         rk7FA2JAHtlheUuzMME11q3EAFXcl587/eZesv30g+70jiGuan9BisO48p5/RqbZg/4b
         B8kQOTDgAsEmAMhu37QLf7gilQs8ClowmUYiXc2tF3CmZaOgeV9Qbx4lGCY+XpsAdyQK
         Af6hZcpr9JNfA6aVSnfcHzy26z9II3oaz1UhAnDBkdim0jkYr/tVduBnrGRKtO73yZWP
         1hPueK2rqVbcX5tmhs2VYfVLQ7S6HmTVQio7WhncWjQrtqfAadDHOUXxLAwdT20uqiv6
         nWpQ==
X-Forwarded-Encrypted: i=1; AJvYcCWLFQ7ZKGYgFTXG0wTFT3UotvyKY4GSvAWvb66uChT7K86qVFG4vONO5lLCg50H559XJDqBzIZyQjbsdo4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2y1DHHbahqpY7ixMgnqkNGOycHdkGER1Q1vnCx5iKo3u5t2DL
	1v5SrP04a+/AS3Z+iTz7HAKlvuU0SAPssglRiPSGuO4s015d86wmFpfPm/eL
X-Gm-Gg: ASbGnct+i76MFjaQ8eLjJlIAcM7sZaF9whguAfyeSqpyeoLt84avUGkvT6x0DyXpsfV
	JxiBQVOP6FG4j0SZLp4trQwst6ka6SC9H1Ju6cepyZgXUjLauYrjpcS0jAhwpy8Z+K4qaxo2bZl
	sZdL6vCSnV60DYropT8WH1E4iu8y1T+qBnwrMZ88pSAPpJAppZqTdF+htT7Kn7H7CDpWFGC0kZ+
	GVf1MG9igtU0DcEMQo0eKdpvb65FLfKvE30BlO0/LlN9xmV/XxpBSAV+wgQs6YxpxAIV17bwBNq
	UQRb3v3+sZPUaDwMDzetbTtND2QSUH7DW0ABJvIKyxHIacqxCD/VEGAidCsWWAOM69a8QEUmDc0
	vxkmmTBQ=
X-Google-Smtp-Source: AGHT+IGDuWOGj9LjvCtGYcIQ2LrciEoR/Kq2YNbvqL+OAo+OzyfUQf89uUjw/59JlAdVVmhzK7MqJw==
X-Received: by 2002:a05:620a:3d11:b0:7c0:b490:2c26 with SMTP id af79cd13be357-7c55eed3cbbmr223480685a.12.1741663904895;
        Mon, 10 Mar 2025 20:31:44 -0700 (PDT)
Received: from nerdopolis2.mynetworksettings.com ([2600:4040:5e66:a800:aa39:bd07:6207:ac0d])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c54c204e36sm342772385a.40.2025.03.10.20.31.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 20:31:43 -0700 (PDT)
From: adamsimonelli@gmail.com
To: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jiri Slaby <jirislaby@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Petr Mladek <pmladek@suse.com>
Cc: Adam Simonelli <adamsimonelli@gmail.com>
Subject: [PATCH v8 1/4] ttynull: Always initialize console index to -1
Date: Mon, 10 Mar 2025 23:31:30 -0400
Message-ID: <20250311033133.1859963-2-adamsimonelli@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250311033133.1859963-1-adamsimonelli@gmail.com>
References: <20250311033133.1859963-1-adamsimonelli@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Adam Simonelli <adamsimonelli@gmail.com>

This allows ttynull to be considered in console selection.

Suggested-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: Adam Simonelli <adamsimonelli@gmail.com>
---
 drivers/tty/ttynull.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/ttynull.c b/drivers/tty/ttynull.c
index 6b2f7208b564..d8b51edde628 100644
--- a/drivers/tty/ttynull.c
+++ b/drivers/tty/ttynull.c
@@ -57,6 +57,7 @@ static struct tty_driver *ttynull_device(struct console *c, int *index)
 static struct console ttynull_console = {
 	.name = "ttynull",
 	.device = ttynull_device,
+	.index = -1,
 };
 
 static int __init ttynull_init(void)
-- 
2.45.2

