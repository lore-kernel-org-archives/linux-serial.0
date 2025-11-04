Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B22F52E6CD7
	for <linux-serial@vger.kernel.org>; Tue,  4 Nov 2025 14:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762268081; cv=none; b=UqnmP09VtFwhGZiJTXchMx8NtfaZpDNEs9beQ99Mec1XfQ4d7Jn5dQeY0aMPq9Fh9loIfLRbdjM5F8QfUvyJyTazVC8W3URbHoQPi6XX0I9FAc8WUhQSsQQ9VPRgaLYGYWeuIacWDTG2YZMVwZrTxrXLXJZbDVtzAfT/Pxqp6gY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762268081; c=relaxed/simple;
	bh=tMM0FrpzOwdKfNoqgk0wHyasTgBqPHWdw6Pw56pYrVU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CDUB80dcR0sS4t1wbMC3abrZBYYBrajBoD+TkXIgYdq1VSarX1xR62DCGlhxWNC60N/Y4qixUc1xx5J1ujzclSI7bWaR/QOGl2Nb/asAQjKtxRyxeBeFcCUtPR5Qnd7wU2SMiKKpaXpBXceB23IqplxqcHBCCFZIscnKHN+CXiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dRjlkx0y; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dRjlkx0y"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6408f9cb1dcso5571781a12.3
        for <linux-serial@vger.kernel.org>; Tue, 04 Nov 2025 06:54:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762268078; x=1762872878; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jOvGyS+AFA2b2XdOCri8ZZ+CLzTz/OL3oewIg+xXlA0=;
        b=dRjlkx0yU6pzOoC519joE9J+h+xZoJkVobX0AtrbtvaTaNnl+MSYiQ16nbbNnF7mTn
         Jvw8kuxXZt9yaoToRv2LciPhe6unBbfMvRZuDHQBgSQiQ3OnxnWJKMwv1B/tBl8WoU3L
         pCev17Ix05M53H3KeR7NzMn257XymA4wB/XtE6srRUL5+UJDlWueNVjhOF6EcNcKey/G
         AVN/uztT0ywaJ0Aw5+KOR8hWLNA5EehQi6JmszyfMCVqAXhQpxOPFsLBOcc9SmKnj+jx
         3kkBMuldzz6IWkih+TB8Z3lSHnMEt4J13iTIyT3B1mhSHTLvtrDzTZrHsgTD2+fEnosH
         cYIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762268078; x=1762872878;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jOvGyS+AFA2b2XdOCri8ZZ+CLzTz/OL3oewIg+xXlA0=;
        b=RrMrrJs6YLJotOr+7VEW4bDjeu+dg1XoUMBCmmRO8d2putm3f4m567N0/z8b7bcwXh
         2VitrK9HHiS2OaAuvKpooi9D1119cC+jDc4LqmrmPh2pDXd5LZOPs1FCoVLrk1azz53S
         j1bbFZvFtYKAGznfm6+DxaL2dh7gYG6n80KkJiOEUGgOGTctI6NMawvtyqUGps0lQVjv
         fh5bUSf+OhYsDBagnfwczocJTdw18krhzg9/xXvFKMJb4SSm282Z5JvoNa+HAX5eMPaP
         +99Vi5HS69bB02HBs1CZMCbzgoiPOK8BAY70+59Zqh1R73EpRq7Yn6M0Rka8i6Nf5VH3
         3fHA==
X-Forwarded-Encrypted: i=1; AJvYcCUTRWHn6wEyRs0RIdt73kRp9rjc8pZlMdmlWJYuwBsrJy5le75BLTUMM21j9HQU7TdHeT3BbobNFEMAElc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxqYgIUfz9LPMFhTJVAU3G1+4w+bvsRpvF5sW2H19gXXbQVqhl
	3yxCr1pc/7LxVqjo5Tbb8Wp/pGh9Q+dfCGHriviov6LHWN7UGQY1B7sb
X-Gm-Gg: ASbGnctEPRfdH7RzFpr1TCkwinXR1OhiYlZAeZC6mjxjAqdnx7JE5WPIHUzWqZXDwma
	+0pUObXBKLUHl2gRb/eesrYinxY32ASXJomP3I8+QUo5w1lOx+lO5znRpTS3lnLPS66b3XZmHUT
	7d5HSgb2AlKK5IjD3xU+tygqRl8hue6mIED8VZiTfcuaSt17VgAi4ijXr19HRrRfcNbZwMMDNo5
	havWBq1hCS1dNZRzoW+YkPf9LFu2X3WdFS8qR1uCB5LB9YFmUe9H4nV4U3NEeNbI3y9+uoNr4+F
	ZyHz4W794mDk//78tsQSoXohKlnvc1ujzWWeonDBE1eyoBc6jrS98ge8OY9I7GmdxFzrky9TGmG
	d1c+/Bj0bjmPLN4cRphNvNCYnEFgv/h+3fB2PmTpZaCP7mm4ksprNWkswqMWZ1djhC0yxxwKsmz
	T1
X-Google-Smtp-Source: AGHT+IHwgA9FO5GGp+/OCTCuFBuQnKQEnDtnj8IkU1asVMEJd7eMujGCpXNexpCTZo8mqU/8fJq3lw==
X-Received: by 2002:a05:6402:42c9:b0:640:da69:334c with SMTP id 4fb4d7f45d1cf-640da693f92mr4046621a12.35.1762268077784;
        Tue, 04 Nov 2025 06:54:37 -0800 (PST)
Received: from NB-6746.. ([188.243.183.84])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-640e6a70b50sm2235016a12.25.2025.11.04.06.54.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 06:54:37 -0800 (PST)
From: Artem Shimko <a.shimko.dev@gmail.com>
To: ilpo.jarvinen@linux.intel.com,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Artem Shimko <a.shimko.dev@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: [PATCH v2 0/2] serial: 8250_dw: Fix runtime PM and use _DEFINE_DEV_PM_OPS
Date: Tue,  4 Nov 2025 17:54:24 +0300
Message-ID: <20251104145433.2316165-1-a.shimko.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Dear maintainers and reviewers,

This patch series enhances runtime power management error handling
in the 8250_dw driver and updates the PM ops initialization to
modern kernel standards.

The first patch adds proper error checking for clock enable operations
in runtime_resume, ensuring that failures are properly propagated
rather than silently ignored.

The second patch reorganizes the runtime PM initialization sequence
to simplify error handling and prevent potential suspend during
device probe.

Thank you for your consideration.

--
Best regards,
Artem Shimko

---

ChangeLog:
v1: https://lore.kernel.org/all/20251030174142.2039122-1-a.shimko.dev@gmail.com/T/#u
v2:
  * Split combined changes into separate logical commits
  * Added detailed commit messages explaining the changes

Artem Shimko (2):
  serial: 8250_dw: handle clock enable errors in runtime_resume
  serial: 8250_dw: fix runtime PM initialization sequence

 drivers/tty/serial/8250/8250_dw.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

-- 
2.43.0

