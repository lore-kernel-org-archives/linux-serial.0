Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A458713C9B3;
	Sat, 28 Dec 2024 15:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735398073; cv=none; b=oLLPzxZwSmX/Wj4Sh5QiUXISWxVxilsiw6351no0J6SRUSxR75S0e4IRJH5dWx8Vc+zvHGqshpYRjlBshgmwvtnLbtiZHBgL2GPj4rU1WKKW1LdDNnTkhdkmwT5hdHikhnYEXp67aOsl0QqAzAGOA8nKDQRBmyqy5Munis495kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735398073; c=relaxed/simple;
	bh=F3UpHpGAsrtG3MNgCHlge+zKLqv/Vv0MI0Z9q19ZvWI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DSgj/2FC/B4HJEqymTxVHI+67MI39vVHqHUfoXtttRymvc3ohKE4cG0vIkzmG5/GnHUUCKRPVml3hUYtaOTnx5eCFDQuM5+4fYcf1EWhJJorobYt68URvfL8cRrtWRUcHsAEkN9dzIM8exZMRXLYCU+7mwuYkS+sXlwxjPnFngA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B5cPePAm; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B5cPePAm"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-38632b8ae71so5724879f8f.0;
        Sat, 28 Dec 2024 07:01:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735398070; x=1736002870; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TGEh+xQok28WCp2LIgq90iGSAbbQLa61OseSLFGbtpI=;
        b=B5cPePAmrcXoy8RcH/zXZReKAHdJDUvLQBsOIlOhcFXTSeDDLHoICBWfRqVJ+QdqnS
         qx7CyAmTPmUmqaASYoUY0qnWJQyHwzELQvfKDy9G1Q+HP0K4/oSnTITzVU4A6cGkZsti
         TE7mIh0Gvr7Tkrs7RJD/zdLGt1mIA0msu9pnltJ921xf8ndL7INeZ2+HPrMDuQSJUFTj
         DxZ0p7ZKoUmVaVc/Fmr2u0Zf3DhazqR/BYZ0SE9h+DCM69mp7XXOXIgRyXrm1wNSf8K1
         +KENeeCUJpeAPCTdml7vMnK69k1HAMSv+Umzf3k6lcpDOOKEdICejqioVq7Wj2C3sR8B
         u6Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735398070; x=1736002870;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TGEh+xQok28WCp2LIgq90iGSAbbQLa61OseSLFGbtpI=;
        b=gOuUh9rm48PGB/Nb2zZR1OuSruJyg3MU4gwQs1pdWEAEaMImniBwKCrYmMP6C34JQS
         kNufoXaVJhxnfpn7H2OZe6a+J51KV7XocP9sYDOa/se6tDjW4SAnKsDr58Z2kHzv6Kwe
         Xr1s9+/Vn7FXqaytvfsdSptYKQuZP7bX+jyRXpkmRJ6PVX2+7zXhVa9aqMtmX9YF1y7i
         9+T4w1jJ8f3Foyid3l5+bSyCfBda7iyzNaGMd/mJ+sL1TOAkB7sPC38j2Eku07SP9/rs
         /IGSktu2WHOp7xtOONRAzwJ8ycbdtivSTJ/4cifJxzUFSCdqbnWJY3AldEA3UD35TeH3
         V6Kg==
X-Forwarded-Encrypted: i=1; AJvYcCX+aJM2PcDximoS+93VT+g3g0BJ3iS/Ps1/Dnc9LsvBmGy2JHamarKtoBp0xyjm1b29Qxiz1h8UNII28rA=@vger.kernel.org, AJvYcCXsO2fLvqf0dpd9X40XJdOF1PixKDQCh6YyZOW8NgEmNgtP3qGifRQRSi/WuAyoVUNMrsVURR55At/imkwY@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/uZbaSfPMTK1foX2gW7MlmZdkhBl0s2QG6JS3obdcfALwPe1G
	uOdxeJHOh+qNK+EiD3TW+KcErtgJFlJJY16l2zvaNaK3LRmc1imQLW8SZQ==
X-Gm-Gg: ASbGncsUb3H074/6IUsKZ/MN1ZQm0twIbHmq0x4J1KeyEpPoFq1DB2KD6osVPHX0BuH
	fvyj17LkavEmv1thKhvauHzNq8e3Ke+0ZdCcWr9BK5a87kqjO/Seg3vUoU045cwOJ94f21dOKsW
	5+vwcRJ6h3T+3S/ZXXkbWFfzVwz1nlCeztm3iPQRurVrK0TQ2wSRbbJocMnC6We/DTxPUSRTb7q
	UM9ZD42CXxk13veAXI7x/pngoStHCEJi7dDsXAmdoMDhZUKX6eJKyRaG/9uJvhKP7jZ04+Jbetf
	isI=
X-Google-Smtp-Source: AGHT+IGZpRwFhC2sEUIgUg88lg4hi+eIpU3IXrAr8AWhPZWluVQVsXhDQJfg9fhFiT39qAJjp/CUtw==
X-Received: by 2002:a05:6000:704:b0:385:e9ba:acda with SMTP id ffacd0b85a97d-38a221e2738mr24418351f8f.2.1735398069742;
        Sat, 28 Dec 2024 07:01:09 -0800 (PST)
Received: from localhost.localdomain ([95.43.220.235])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c832ec4sm24779584f8f.26.2024.12.28.07.01.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Dec 2024 07:01:09 -0800 (PST)
From: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Subject: [PATCH 0/2] tty: n_gsm fixes
Date: Sat, 28 Dec 2024 17:00:58 +0200
Message-Id: <20241228150100.100354-1-ivo.g.dimitrov.75@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series fixes few n_gsm issues

Ivaylo Dimitrov (2):
  tty: n_gsm: wait until channel 0 is ready
  tty: n_gsm: Fix control dlci ADM mode processing

 drivers/tty/n_gsm.c | 39 +++++++++++++++++++++++++++------------
 1 file changed, 27 insertions(+), 12 deletions(-)

-- 
2.30.2

