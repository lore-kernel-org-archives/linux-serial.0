Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F4B1EDA03;
	Tue, 11 Mar 2025 03:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741663918; cv=none; b=Uosz5CH0tgHogUEQ7MvskRMf+CH6NNffMneo+dateZScTYRFm/O/nicGyZ3u1jTIJ6sD/+Uoli4O8ShxvVMBrzSpK/SAGYd8fp9lEO/6/NDm1AuNqcY2VvylKQvDyWa1mDBZhTIVA5e7jEyVuGdGw0qHNwQ5LWd02X3fZ09bniE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741663918; c=relaxed/simple;
	bh=/TKgmRcpR6FwG+QP75QeweLLHLthLmIsWG6RxmlgQmg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hyml4lORjsW45ZiFaZJyzusoH7NtPzTpJ0HHmWxDICMnvrICDVNP693l5uz824y7X1uGGBdMcoWAZtyGL3keHaBexLeT0eSR/3FJeivbly6XPnyJiYyPMulkIJBsmwGA7Rci0sUhnFdAxF9ssZS9DDqA0okmnTN8PIbracB7LoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RkeYEAl+; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RkeYEAl+"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7c04df48a5bso438173285a.2;
        Mon, 10 Mar 2025 20:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741663914; x=1742268714; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tEOdYvwBabq4hLr7eGLZh7Wd260T/gAnmabJNmIq24s=;
        b=RkeYEAl+wC0znmtUydZvF81b6zA6maDdvgFxVzfKhsn9iaMF58l7nCicf6jKzGOLka
         Jnu6/DaSbKdSivnU3uwSCatjdXnemjZ/T41cECe997e/f+gPF9UgyE4qdgZgGH5UJpjF
         fNVR0M4KurScNPX5cpYe2XsQv8ymXF0nYcacNhLo8q1RsVSzqBu1JehBXlqzUB4XkLJN
         +8Lky4/O2aO3vEbXRceSQNQaqQdiHvaOznSXBqvFl9Yle2IEXq9/VY3Ws5Z0HQ6zvZxC
         bTlHZX3kjW4GYZhVA1XjQlkwTBcESSLyar6NdRjj+Sg9E3TQlmAPdahwD14K3eQvlVko
         XAxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741663914; x=1742268714;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tEOdYvwBabq4hLr7eGLZh7Wd260T/gAnmabJNmIq24s=;
        b=mz2SXg3UdcpWWomO/Isg7fx8EUDSD528c29fvd/eAW69YCMMYCrzX28nI2GyIgqfeK
         3CNKu4Gcm9yyoN+iejPGQU2UqadvrMkj30SkYUDEISCV9YHSUZ57p5xkVQEsFagNuGy5
         RfjN43sHR1iQhH8eHte97KDhxxcbdCbX8gmDgIc+uuTAhBql7Ei27hUxudCnbq/Vp2in
         4drVqOc/sigmyYkOs6mqQ8ZmYteB4Hreinc3pRx/0RHD9Zh187vI8JTr21FwR5gfc1/K
         2DdfkNpaa7/G3LykjoQbu8Ca/Sf9xvb7fe7oJlLvZS0s+G9+bt1j0RQ6iT0m3s3mtc9p
         PMbQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+ybUS/JLyu0Ed5QSX/fNzwEkWs3hRAGDT9WpQOlRBHffjEaEJoVP1NrForzOLY5z0GcNFu8cVi9WAKwk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOp3T92kgchvxuDvgmXY/0gO45r7NbKHXH4CTvz9ybiwJW5Uwl
	3y0NnY7ctQMXXY+XM59CQkOy/CCIi0RyuvvwzSv/Cdjafk3kTXqzqsiBlcdR
X-Gm-Gg: ASbGncscR44+c0S3TCpDJNIluRPzd/6YuEHGqTeY50QhMagwOcWd4p16qPhD4WQF6Hw
	lF/Ozj9lrllFIyc9JP6In2nX+5HHJAuinvcKp7Bn4+b6JIbXseMW4EPqdQgQfj6CATLO+oksHwK
	GrUBBrDBhfJpcKJSjJQXClNu52+sRWpYsVAMwe7uEyLa0RCvrdUiBWF0ziF2umr6tPdzlbuwahF
	+LEWZeAFFpE5XzMokKlbrB1dAAt8sh0oIDeTQq7dYH1J9rJ4KGvIgMTJDC1NBdAH433afwukq8A
	9giMwY45WgKxIKkP+B7BzxL2ll0GDIYPOMPrsBxrOto8uCGPkHf44hg2ADTVyWBNAYnIQ/m8uqG
	irhiJJPpA5k3AFWxBOA==
X-Google-Smtp-Source: AGHT+IHIAyzXVA/iU++8gfxQ63RCGP5YFcZSH8DC2qBAqSfVfKP1LwdcEzYiabOBoLCtcoyEq3huvg==
X-Received: by 2002:a05:620a:6407:b0:7c5:565a:2177 with SMTP id af79cd13be357-7c5565a2b71mr687815285a.33.1741663913931;
        Mon, 10 Mar 2025 20:31:53 -0700 (PDT)
Received: from nerdopolis2.mynetworksettings.com ([2600:4040:5e66:a800:aa39:bd07:6207:ac0d])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c54c204e36sm342772385a.40.2025.03.10.20.31.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 20:31:52 -0700 (PDT)
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
Subject: [PATCH v8 4/4] Documentation/serial-console: Document CONFIG_NULL_TTY_DEFAULT_CONSOLE.
Date: Mon, 10 Mar 2025 23:31:33 -0400
Message-ID: <20250311033133.1859963-5-adamsimonelli@gmail.com>
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

When the kernel is compiled with CONFIG_NULL_TTY_DEFAULT_CONSOLE and
no console= options are selected, it defaults to using the ttynull
device.
---
 Documentation/admin-guide/serial-console.rst | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/serial-console.rst b/Documentation/admin-guide/serial-console.rst
index a3dfc2c66e01..1609e7479249 100644
--- a/Documentation/admin-guide/serial-console.rst
+++ b/Documentation/admin-guide/serial-console.rst
@@ -78,7 +78,9 @@ If no console device is specified, the first device found capable of
 acting as a system console will be used. At this time, the system
 first looks for a VGA card and then for a serial port. So if you don't
 have a VGA card in your system the first serial port will automatically
-become the console.
+become the console, unless the kernel is configured with the
+CONFIG_NULL_TTY_DEFAULT_CONSOLE option, then it will default to using the
+ttynull device.
 
 You will need to create a new device to use ``/dev/console``. The official
 ``/dev/console`` is now character device 5,1.
-- 
2.45.2

