Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8881D175D50;
	Sun, 30 Mar 2025 11:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743333028; cv=none; b=NR0PafyTTbdbCF6311MerSGqIZHaorXlJBW7zsWD/iixpkusVqnFtJ+xABDyjIl6CMPhc+G459EmgwTfOc6dp4CYxLSYvceBQmoVkRf8kcm30HFs7+cFLdF9cBpqE9ays/SaP5KySQWF93JECJmu+yzp/3oQsXHtnBjB0plQfiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743333028; c=relaxed/simple;
	bh=uMH9D5qQAVaC3sufhouTJxvBFoW4Cg3Kxe6V50NQyrI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CqIcSPjdVVnDnncgT16/LyphOPacrZJvABpQxBom9WwO8tLkBjaxPgqMGhR83gA/a1GHnDQy3cDXfQnrVAiy/rxRHnNMjbnzIxlDlFNM2bqGvB5BQf7hvrE5UtSMfg/DW6fPI8eC5wW2bhmWqHkni0Cp9UeKwBK0UcmEdjvN/y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B6eosBVz; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B6eosBVz"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3035858c687so4911796a91.2;
        Sun, 30 Mar 2025 04:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743333027; x=1743937827; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KF09n6ohxZVdfCGussuOtctoxzw/9z0eF08JQ8zCyw8=;
        b=B6eosBVzzsifAB7mUwm2gB2aCdHRlnTn+gU14Evqg9BKI2fInZFRhZmBSLEtp7EiFs
         ITTLvly140T1X+MnnrFBOtU2QYOYh/8etOzEl6Vrt+KQk5JQbDjlYFfzYP71LfOhNGh1
         Z1fB60uum4J5BUeKqqMJC1Zi7s3U96LfFAG4v3b9ZGtTVnZ15etp8d3pbPNejHXFvnDg
         270KemPLE3oqF3v0sxFGiYErroaqgXlV4GD61MbI2ubovqURCQhkMezbfOf9+auzWIFq
         2t7R1/lqDUUu0VtqSHo2IlJ7tGnK2+Kkqd2jcHnWh2pb0ygpk2XCN9haffOORwENSXv6
         fGEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743333027; x=1743937827;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KF09n6ohxZVdfCGussuOtctoxzw/9z0eF08JQ8zCyw8=;
        b=MScB1VpDQqlTj2oDA+tc1Z/qmqBOMwq/GAFTeCFOj2Oaq4DpImdZTqYInUaS9+zxuz
         PlO2IRlMeZpCAGSmeXRf92nX6P/2mzNk6iPXHBRD4E05mL4kB8tV19v3ipgQCV8Kk8ZO
         WHH6frp5rc8/jY0x+3fcxPfSr4BVcqwujIm2SHk2qauRZKWZTgtRdUVpxDZA21R1zxr+
         xtKStLuloHCErEFHbPu4PRYM1xqGG2+YCLBX37wSpNxDy1Kcm8JTrbijQxSoYZJ87Ydw
         MaXhuL39YB51Cpv9H3h8b3cbuyVltyeWTA1C5QnFY7d1b/WZyVIP1FztoLMebwWBXMYC
         q2bA==
X-Forwarded-Encrypted: i=1; AJvYcCUJaBtIzUjHiQGk803Jny1ULTCg8yxXyDDZ2pZxx9w8S9NPj+Googy5sGKlMooF4tJphGYwYHlYpaAtQEQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw22rHTxt07T4xHlErEMdK3oBsXM0h+OBvUKg3H2qt50Zb7myBD
	O5Ty+axQ6UEMFb8dFsdHzlQBNGZp/WQ80awfIHUZCiKyAdE5xgQv
X-Gm-Gg: ASbGnctO1M2waq1ZwzCr65kv+LqrQtTi7NbDl/lY5Lxi/mCfX0qNP2dXjoSEAYZ3cae
	v75pccEKn3aCU08FAmQ1YqzUI/ywMLZSrfzlyItQxSq5Kc8rahdXA7xk4M7Aaive4WgE7A2dp1I
	USsyfrpGTBedwefXSZlTGqg/vc462FlinMJE8WdHY/fG5AkJB6g7cizLYxJPSdxlYIcaxzZtZZz
	mQvjoy2DMA7e5yxossZgTlv5vzMfjUtjNR42We3nBU44XN6Eq7/gC77fu7jt0YjcyqSpG9cBuxV
	dwzd82qQElzVERTH5LGkqY88mXeDGtgY25AZnJota2/Rx6Q3jay4dvT6GWVDmRi4gx+V18NxGVe
	WEV96QZs5+xxOE3mLHKIppbAClxozxdEV4G8n9+ZrKg==
X-Google-Smtp-Source: AGHT+IFnbzl2epOSt90H01aDeUm2b0dBQj1iJ1sf8IFO6dYHI0OIszwKM41B4LCe7IBBHP62GqRyjg==
X-Received: by 2002:a17:90b:3b85:b0:2ff:6e72:b8e9 with SMTP id 98e67ed59e1d1-30532154023mr7903936a91.25.1743333026761;
        Sun, 30 Mar 2025 04:10:26 -0700 (PDT)
Received: from DESKTOP-NBGHJ1C.flets-east.jp (p12284229-ipxg45101marunouchi.tokyo.ocn.ne.jp. [60.39.60.229])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3039dff0529sm8367069a91.16.2025.03.30.04.10.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Mar 2025 04:10:26 -0700 (PDT)
From: Ryo Takakura <ryotkkr98@gmail.com>
To: alex@ghiti.fr,
	aou@eecs.berkeley.edu,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	john.ogness@linutronix.de,
	palmer@dabbelt.com,
	paul.walmsley@sifive.com,
	pmladek@suse.com,
	samuel.holland@sifive.com,
	bigeasy@linutronix.de,
	conor.dooley@microchip.com,
	u.kleine-koenig@baylibre.com
Cc: linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-serial@vger.kernel.org,
	Ryo Takakura <ryotkkr98@gmail.com>
Subject: [PATCH v3 0/2] serial: sifive: Convert sifive console to nbcon
Date: Sun, 30 Mar 2025 20:09:57 +0900
Message-Id: <20250330110957.392460-1-ryotkkr98@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi!

This series convert sifive console to nbcon.

The first patch fixes the issue which was pointed out by John [0] 
that the driver has been accessing SIFIVE_SERIAL_IE_OFFS register 
on its ->startup() and ->shutdown() without port lock synchronization 
against ->write().

The fix on the first patch still applies to the second patch which 
converts the console to nbcon as ->write_thread() holds port lock
and ->write_atomic() checks for the console ownership.

Sincerely,
Ryo Takakura

[0] https://lore.kernel.org/lkml/84sen2fo4b.fsf@jogness.linutronix.de/

---

Changes since v1:
[1] https://lore.kernel.org/lkml/20250323060603.388621-1-ryotkkr98@gmail.com/

- Thank you John for the feedback!
- Add a patch for synchronizing startup()/shutdown() vs write(). 
- Add <Reviewed-by> by John.

Changes since v2:
[2] https://lore.kernel.org/all/20250330003058.386447-1-ryotkkr98@gmail.com/ 

- Add Cc stable for the first patch.

---

Ryo Takakura (2):
  serial: sifive: lock port in startup()/shutdown() callbacks
  serial: sifive: Switch to nbcon console

 drivers/tty/serial/sifive.c | 93 +++++++++++++++++++++++++++++++------
 1 file changed, 80 insertions(+), 13 deletions(-)

-- 
2.34.1

