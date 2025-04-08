Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81EC0264F9E
	for <linux-serial@vger.kernel.org>; Tue,  8 Apr 2025 07:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744098126; cv=none; b=WPbd9z7NGeVnLzRI8FY1khlNvGF834wjtq6WAPMdKYioDrEpWMpAhJxAkSM6J/LaHc94IvJIX1Gv2HfNSshwJgnwUWa5pUVzkunYty/yJVpuOcBpWTKh9dcjGNfSYhd1N27qYmGIOwfug8XTjPBVdLBT49ok3H0bvJmH2RwcDe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744098126; c=relaxed/simple;
	bh=lDs8uuZIX3R1BllHLsG6wX7t4bhweRN0/qgCa0AtwY4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=JXzdX3R74XE6Neoq6Lkc0ElStVyY5plzKpAQrDyHRKP51sEuCiKLx0Go0xVv8rnCoh30gtGeDch9tM7cuuhlmDOFc7xpvIHVHJwuqU6QhR3Skq91zzvrntoY7Mbwjqfm9EjHWmu+nvyQw0kxx5S+WqCpdeTC1dw/61lcw7DnKys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=yvwqgYRb; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="yvwqgYRb"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43cf034d4abso56148715e9.3
        for <linux-serial@vger.kernel.org>; Tue, 08 Apr 2025 00:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1744098123; x=1744702923; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5KSliEoaziBiXlj55FlhsxOKjSAwpZNPBiyshYdPCKo=;
        b=yvwqgYRbI07YXo1L1czS2a3pK0tMQfgCaUPgKfhSiT9luR1Hanqex0cc7Bfe1DoqOR
         418dSX9vaQ4umGB8ZUlPKddTJ09VeUTbaznfxG1o8y119RuK9iZQao6Y1UzEVB3tFyWi
         MUkjHwd90+Pla7NW6tfJzgbULUDhJEfnT0M+XUE4CraDsvhMRBKrLNG5n8a1ukqNUMRC
         78Bjwvh6nn9+ob+5P7+G1jNSb4c2ltduKAK2UmDF4sQimGryJhmlKbBibakJTalN8U0b
         nr/Hxrdqp0zqh3nXWNFBATG+nsJCpoZARte0Z4agiziFBw/Ll4oH0IBuDvExL2QLZMB/
         veaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744098123; x=1744702923;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5KSliEoaziBiXlj55FlhsxOKjSAwpZNPBiyshYdPCKo=;
        b=V4yXp/6i0FxwNAbrPq6s16CKMYOfE34PBn/AhyW2oul/ZO0x9Os/X/XrbynkZUSf6t
         wUoLKQIvuddDM7DrlGYHVZq0do1gFbCCt4nHAdu3vCId880hd1LvkkhcNF30G+Fx26+v
         U4IoeCx0tv/2j4pGzlo+bUQoye+3v1XSbt2BHHX1smQWbMvdDDjGpUSLA0BV1YrIkS0M
         uxToVjC1RLXmOglHHwdeWPkiiX18vygie2siUimbMFqlRdEFvS09P5Ar3OWXfu3QwfpA
         jGS4KRZU6SIn0EUXVlHDYmWUpX23Bn+KxtX5Vv6k5DnKsB8AJlx8jc5dn/UOT2mqOmLd
         qqEg==
X-Forwarded-Encrypted: i=1; AJvYcCVFf1HbnKoFTEUb59oE/9/UMzzz/V7ZXIvlooBoaefWmJGWuquPiLy3zVqLII8crFFoyoVHZvOtp0f5VAk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJDd7FdDcl+vglibC7GM5vqWcRGoRJOPee1I3nINCeE9ypxEPG
	ZKaGzlaVy2Vy90m7uHE3jzF1eZ8FgLhrCNRrb8au7SfJOesgGv6oH/R/owfS6/M=
X-Gm-Gg: ASbGncvEEkFXnpnzyBmcE3lqN6JKrV/mkW8/RhHtIKhE+JQKHSNormy+oBtqrniOrZ4
	/eWp7+jLp2karkuaszkjG5GQTlwuI1/z8Cqu2eOpH5qUchlK1OCko6TUXKYXmH+M9tAf7bsVPFy
	NnoCFQCdlnlgtJ+0rvvI1rj8d2Te/jwB8dvyPfkhSuct6O+S/CYttLC+iQOXJ2ORRpHs/fyL6yt
	gcrldAkiCBoVpN0Uxk2tx4kW7wNSa6I2Ghso5ZRZb6zlhnYe7bPSZAkY0zRIZJNY2crhAwQssOk
	EI0HMYsM5+0GAesX8243Rs6cVvoWQ989eMCtUw==
X-Google-Smtp-Source: AGHT+IEOwLVOTlI4m4uj7zOwwVtrtm680vmN2VG7dTu/ruWCUt9xbSA2/3fAuyKxU4vnMQjWrfnPCA==
X-Received: by 2002:a05:600c:a016:b0:439:9b2a:1b2f with SMTP id 5b1f17b1804b1-43ee0613661mr146416045e9.3.1744098122886;
        Tue, 08 Apr 2025 00:42:02 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:2adf:eaae:f6ea:1a73])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c3009644dsm13876928f8f.6.2025.04.08.00.42.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 00:42:02 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH 0/2] serial: convert GPIO chips to using new value setters
Date: Tue, 08 Apr 2025 09:41:59 +0200
Message-Id: <20250408-gpiochip-set-rv-tty-v1-0-fb49444827d4@linaro.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEfT9GcC/x3MQQqAIBBG4avIrBswK4KuEi3Kfms2JSpRhHdPW
 n6L916KCIJIg3op4JIo51FQV4rsPh8bWNZiMtp0ujE9b15Ou4vniMTh4pQe1jC1w6LbFqBS+gA
 n938dp5w/x05rD2UAAAA=
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 linux-gpio@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=829;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=lDs8uuZIX3R1BllHLsG6wX7t4bhweRN0/qgCa0AtwY4=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBn9NNJEvZIMxQPI/OdfZHz33PDWuvxwthdor+4N
 7Kkv0hZmRiJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCZ/TTSQAKCRARpy6gFHHX
 coNXEACCDtdktaflEawsexSUIwVZ8sTv2djibKqe3xiQN1nbQHEvKQlMWec9YDEwFepuP+4Qs+q
 4ldDiM/F4A5wV5vrsMsb5AmAasdACVaSRCZagqJWAm4d1/T7KH1bDLGY3ZMQvaGFDPtHPv4lpaO
 ulKEFb4CLRUlx7w/sZewdfAQ7y+lIzlqZb3yUhr6uS2ZRhprQCxFDxRuNKssFTF2NYpVsL3a3SV
 ioh3iQGxvqV4/hzl/qOscMMpePkt7kG0GhMc4059nDnz7DkhZXobKQwqCB8zOnyFk6joTb53SC5
 +yb+XR9wXvfJoUSYEGFcdQKbOdztxtpDuwV3xyPifky+53N37tm1k+AHl7jvhIk3mob9agd/W+f
 iSYVve6gvmI+GuFIIaeuJ7l8/YC+Kug207n7o/DJXeYu0odl/nKCfwadWquj6Aufsc4RaMmj+Fe
 tpE4Yc89XmoTU7FEsgyne9fXmRQr1clfrHRFccnDdeSXS9EUGkZBNJ8/ZDjtN3dNXvbW11eUDzy
 RcNTnIL0WQ8nquxadvHhg9XvGzVqnAho0yzfBPz3Cdikb9uYvCBiulgcrpv4EvLwtwueHZXGtsS
 QGfTAQVFIJ4sM78ZjmFqjOCnShk3nHga8KDuXJDMXmNtsmwRkCcY9ZC6FaK+h4ckbTCBay/wM1G
 IitRcqGfkKdP6IA==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

struct gpio_chip now has callbacks for setting line values that return
an integer, allowing to indicate failures. We're in the process of
converting all GPIO drivers to using the new API. This series converts
all GPIO controllers under drivers/tty/serial/.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
Bartosz Golaszewski (2):
      serial: max310x: use new GPIO line value setter callbacks
      serial: sc16is7xx: use new GPIO line value setter callbacks

 drivers/tty/serial/max310x.c   | 7 +++++--
 drivers/tty/serial/sc16is7xx.c | 7 +++++--
 2 files changed, 10 insertions(+), 4 deletions(-)
---
base-commit: 0af2f6be1b4281385b618cb86ad946eded089ac8
change-id: 20250327-gpiochip-set-rv-tty-0e21feb044ee

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

