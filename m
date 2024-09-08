Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEB904C66;
	Sun,  8 Sep 2024 07:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725782375; cv=none; b=V0C977YZEZ4mgpceDfMBzSKsaCpVQeCGlJ2xdaT/ItnxVe1wsY16AfwZz6gnYfcvpC0WbaFJlVZVAqa1YPC6rVkac2pP4Pcv1zX7qiQlhBr3vlGbLL4nX3iQPThqvlFIJ4/6jJnTmSd6An1TtoYlcI7dHRRj3QDWIOn6kBolSww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725782375; c=relaxed/simple;
	bh=jbSFvKRmOU53nKVT6skmCp2X/sydWQgG7fEHQCHd40w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fXaXsPwdjZmUy6vLKqzll5T/ac2emVLIbyteS5IehMZY/GtCgXq5jpdVW54q7GAUq2rQQ26wYLXsYelL2VRWKa1zvqvDy2teZJAENGBhsoOM1TvLMkL+R6CPfGmKJQo1bfcNxRBoZ1tMY0iYhPUarXAcDb0Zt9fZwf/YueU+uR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W7lCXhY6; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W7lCXhY6"
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-5df9433ac0cso2402741eaf.3;
        Sun, 08 Sep 2024 00:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725782373; x=1726387173; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1vxC7/1i8CwujpweZ1wTUP4heu2CRN+sI53b8o2l2Nw=;
        b=W7lCXhY6jPPRTnEK7cAZq7C989JEnR3arwNszdJkonm5HNdu+U+MuVhay1QfWdShm/
         orSCwHGNXnXpJqyVc4cX3+aRSziRG58IEK63CPdDc10GsKu/3JGEPvfPzNw/V5qrNIb3
         3esDdI3H8D0Sxruup/TY/0r3zaBTRHKp+YB+QBewFbMwJOiXHBnokqf3PDwpXtDhbEYG
         Clra5n8Iby1xI9xWq55zriKv0Rg4swdWclgKzzETi4DlC6ai9zSr+kEOSZ4Rp5K3Cb79
         I8P8mg25JlNibWL6w9PUFpdd+uSonAKXcLB4zvJm2xY2LtorYGbVjkXXoSMsYGqlkW7y
         POQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725782373; x=1726387173;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1vxC7/1i8CwujpweZ1wTUP4heu2CRN+sI53b8o2l2Nw=;
        b=f9mLy8DnYZ5pQIm472qB64XK0ojIuQEEgf7pAH6y1KszNXuhnCrH4IeZnh6sTYLlzI
         85doqPbC7n3Cg458L1g38rsKvE0nZBNjABfm5BLcfLjlggkWXdqiJk4RP9DsrcBIwpkx
         zc7BNxKLhTcid/FDsZ5ELbYbskJUe12JTOu/EOSsq0FnU2mrnejplxKTluv5XoA1gKnM
         teGPcGtK/Tv3eSM1IJ5lDmlQV+MAf8aBFBGDBfAQ8c9Fp7c9jl9W8kMZWrLTcPg9PaYh
         zY9O0O24Ohfr5Ky6n1L4wUgvACVj50boONdnhlDuhQinUOrq0zbQVJFfZZBKMCA+/H+S
         AYlA==
X-Forwarded-Encrypted: i=1; AJvYcCUJ/KWft0RVIrReUQCRIul5paVYtQZV7g0591VfZ6IPpFs2dqAHUlvWifTpnURpB59jqM0lp9F5uim4agM=@vger.kernel.org, AJvYcCUTHKB3CoXa815V5rWX9itob68Qa27qX2lSaHz8fzNb3RaKFNHVSYKyQolOZ8Cn57eT3/d6o6XPd3OBQVrttgM4Y7k=@vger.kernel.org, AJvYcCXYQ9eStCadE4uwVsEqI7++DB1C7DKLs2oL+guxa5w36+K6HZ8fgejAIXYhGHgPbYBbeQSIWUA5WyoPfo35@vger.kernel.org
X-Gm-Message-State: AOJu0YyeKwNElcXgOZSEpYbuw6+A/Ju6HOgI5TgxbhXdmx7QQdfK0Xt7
	H0xb+jAbtcBOh97B9/P7PkEJGBq1L1GxfT6pgCfyZDGCWXU9dZRp
X-Google-Smtp-Source: AGHT+IG2oi15GFOnc4iepyTdQsMnqiBXkibBTS5arEx2FbGWXrLqY9KDnKuLXcROgxDP2ZZUq7RAjw==
X-Received: by 2002:a05:6820:2213:b0:5da:a2fd:5af9 with SMTP id 006d021491bc7-5e1a9da272cmr7835288eaf.8.1725782372868;
        Sun, 08 Sep 2024 00:59:32 -0700 (PDT)
Received: from localhost.localdomain ([59.188.211.160])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-7d8255dc1c6sm2012690a12.68.2024.09.08.00.59.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Sep 2024 00:59:32 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: asahi@lists.linux.dev,
	Nick Chan <towinchenmi@gmail.com>
Subject: [PATCH 0/3] tty: serial: samsung: Serial fixes for Apple A7-A11 SoCs
Date: Sun,  8 Sep 2024 15:50:47 +0800
Message-ID: <20240908075904.12133-1-towinchenmi@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This series fixes issues with serial on A7-A11 SoCs. The changes do not
seem to affect existing M1 and up users so they can be applied
unconditionally.

Firstly, these SoCs require 32-bit writes on the serial port. This only
manifested in earlycon as reg-io-width in device tree is consulted for
normal serial writes.

Secondly, A7-A9 SoCs seems to use different bits for RXTO and RXTO
enable. Accessing these bits in addition to the original RXTO and RXTO
enable bits will allow serial rx to work correctly on those SoCs.

Changes in v2:
  - Mention A7-A11 in the comment about changing register accesses to
    MMIO32.

  - Use BIT() macro for new entries, and change the existing APPLE_S5L_*
    entries for consistency.

v1: https://lore.kernel.org/linux-samsung-soc/20240907111431.2970-1-towinchenmi@gmail.com

Nick Chan

---

Nick Chan (3):
  tty: serial: samsung: Use BIT() macro for APPLE_S5L_*
  tty: serial: samsung: Fix A7-A11 serial earlycon SError
  tty: serial: samsung: Fix serial rx on Apple A7-A9

 drivers/tty/serial/samsung_tty.c | 22 ++++++++++++++++------
 include/linux/serial_s3c.h       | 24 ++++++++++++++----------
 2 files changed, 30 insertions(+), 16 deletions(-)


base-commit: 9aaeb87ce1e966169a57f53a02ba05b30880ffb8
-- 
2.46.0

