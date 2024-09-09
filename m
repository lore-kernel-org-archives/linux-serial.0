Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8DDE17557C;
	Mon,  9 Sep 2024 08:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725871374; cv=none; b=lew2v8MgHrsaee6hr0SyC/KrUf7yqZDeZDqHw654qMbj2k8GM8u19TjYLWngLPI84oRRA+qmTgJabGk521NkQDPkbzrLwbWh9dgCA1zRmFVWTQZvGwqzsn+ybICGi2+JzKuRuPcf5lzXgsJUN6tM5lm6RDgiNR9pNTwiiJYv8sQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725871374; c=relaxed/simple;
	bh=xKd1F8AMa6iLEMCT5CxTZYVGKrUpbi5VyPWC8eqSoic=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eYCNCIryL0pagnP0/RyiyQXOwGidjcB7o7MNGkz5NJQZswYjdPlOrsQ/XCGoxSCWSWt14ijt1kAxtT9jS4HttHtXW70wvB9mCU/XOg4qb5C3qiHVu+jwB1TQrLo498OxxrlGPHGxWAKKYGdh7UwmewxFaeGu5jpw3S9iIklYLb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RTyp0qfk; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RTyp0qfk"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-206b9455460so32806635ad.0;
        Mon, 09 Sep 2024 01:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725871372; x=1726476172; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=D0V7TB65jfCSDJctjTYijcIn0PZ8E4sHEf+LCXzJaNM=;
        b=RTyp0qfkKdPK/BnSvWvWIxKP2W1s08PqxevkhQyragPhS7CAiG58ut/exsq/q2E1aL
         41t3hF2FNIILbXd4q/tRSy1kXe5oo0eps2WzPP/mLLPtnGw9/n7nia/OQwhwKLfvkmPr
         sJCd7/fU9lcCUmR1Z5MP2jFELxOCA1pJxywfGfF+7FjnG3G8CnN3nLbeLGBCuiPauqtN
         smtcokn8RJs9LCBwMt7f5q8IIYFKNa6AhHiw9BkyxKh++Hf/buRvCV5kLjZSFedcBw6q
         uDoBhM4ptKRk2s0lVbcVUHKHSOl/O/aKALE/t0yILqmbhOpliuNoQ7oUvkKmT3qNMOCj
         tppA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725871372; x=1726476172;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D0V7TB65jfCSDJctjTYijcIn0PZ8E4sHEf+LCXzJaNM=;
        b=PmTkBcTIVqW7VUKFbcA2uPP9J1ay2u8yzF7Rb/Ewp/I+8l8jUzAgLocv/7IgkIObZd
         Az8dsFdNcqxX2JXx+YFHl11eqkDvV/4lYV2cgoUC41sDFgIUX91zUfmX+I+1MCiMWi5M
         dwo7x1DiriVclhu0ckXMbtpP0QbZdtadeazBaFsARHhpnFCvABkA8edhrpHUVXPRp2en
         edrm/2Y2M3cmUoEFFwrwFOQWaeA7Q5uNp5lRzudn/CfCtWAQOtjpehqOanNdSG5GEn4M
         ICdcbcfgdlqa1oIr2HcjKOj997x27Nx/gmzvJPutqJktic2OjdjcrKZiOJRx3OfNm/T3
         e8uQ==
X-Forwarded-Encrypted: i=1; AJvYcCVfdDAzFRvVORXfWlmS0RH1KSlvyy37Hn1c0fJl/WR19JojdfPkxCgNrac/Yk2vUYeAvgWDmiMq4Cj95M4=@vger.kernel.org, AJvYcCWvhKbArDRDHvVIbO1oXlI+rovoUyZdiSp/oFMbHcy4aHJfm+IGsNWxWbsPF7FsJbb1yhmie9O5KmEUOShG@vger.kernel.org, AJvYcCXEM6eKIdWsrpWv6ZCa9QFtJcZtkWICDrnZxFrAsFNOi+T6yegStVVUK0/I8sNTxZ06LL5+Q5fZGWlJD904gu3mG9Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSGPthkk5vPxPoWVMs8wjnukIgiOtX7S4cVwrRoVSHWQ/osKs0
	YARw3jhCS0fSoxEE8wCMZvJHl7pUmNkwdJW1RS7eVtM6YPmeSZ9h
X-Google-Smtp-Source: AGHT+IEmpzqq7HlCYQ/AwpVz0yP4We+SivUqNdMDBseS85lpNBrSETaIY8zGm3Y4FctQy56+TfqyvA==
X-Received: by 2002:a17:902:f54d:b0:206:b618:1d96 with SMTP id d9443c01a7336-206ee75720fmr151653315ad.0.1725871371805;
        Mon, 09 Sep 2024 01:42:51 -0700 (PDT)
Received: from localhost.localdomain ([59.188.211.160])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-20710f1d663sm29678675ad.188.2024.09.09.01.42.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 01:42:51 -0700 (PDT)
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
Subject: [PATCH v4 0/3] tty: serial: samsung: Serial fixes for Apple A7-A11 SoCs
Date: Mon,  9 Sep 2024 16:37:24 +0800
Message-ID: <20240909084222.3209-1-towinchenmi@gmail.com>
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

Changes in v4:
  - Removed fake Reviewed-by tag added by accident... need to stop
    making stupid mistakes that wastes everyone's time. The remaining
    Reviewed-by is real as far as I am aware.

Changes in v3:
  - v2 did not declare itself as v2 in subject line... resend as v3.

Changes in v2:
  - Mention A7-A11 in the comment about changing register accesses to
    MMIO32.

  - Use BIT() macro for new entries, and change the existing APPLE_S5L_*
    entries for consistency.

v1: https://lore.kernel.org/linux-samsung-soc/20240907111431.2970-1-towinchenmi@gmail.com
v2: https://lore.kernel.org/linux-samsung-soc/20240908075904.12133-1-towinchenmi@gmail.com
v3: https://lore.kernel.org/linux-samsung-soc/20240908090939.2745-1-towinchenmi@gmail.com

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

