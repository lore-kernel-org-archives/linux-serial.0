Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794424772;
	b=AV4s9SaKdjAQXX3nmWzOxBQeil7Hr0t0yu6VzG1LUXUurqDLY0Kmdc1HE4FL35+jIygg
	 CLlCvgFYdE7RIyjapCqhSASWjfd9jakoZzdDHeGm8xBUMgEnD+K2Uj89ro3bQjCga/etI
	 X4OuAE6tcQFUMJgId7bVM26krCd3WeyZEJpBwowiVvqi8wmJGxNYrQmPEr90UPMPyvz4n
	 gHx+aDzJA6BYmARG97RVLVireFhm6y7BqXHQGwjIof1xUsibqEi5aFBGDR1GzmUNNjunf
	 VvgbTC0VXoB62VAHwTU6XSUJ3t0kyi38eEJKSX3BR29QgfsdxjkAwRyATVCS9XF1lMA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794424772;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=IJjJtd37bhn0A4un/SmSzJepmWgtq9m5kpl7Gylf3H0=;
	b=Ee3G7bBn19BZ2aqyNaYFG07+6DT85qSUoCUifNFwUBOpgExFP8yiQlFQzRr0LA7quTvD
	 AqdW9VALjSFMZw8X+O71HeHSvsfxP8n8OhRVTMEXFBX178+Lc04zudn6JW4vL4CwjWBm0
	 UW5Gki+SGTCQvi9YTmS73wQddnogoMc/4aO1McT54pGUrfT1E29evHK7l2Wfq/vDCDvyw
	 mZkcdpLrF4TLwJvMfilQS5hhiceVLDqFt1SrXYWoPqAy+eoIw5Cw8LZzZQ2gQwXUuYJ3n
	 ZVaCL2GNKnbGyfBARqRAXiyg01iXDkrkyAgZWH+UjCZveAdG/pZem13PBb7fmND/H7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=p0EcXAFX;
	arc=none smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE71606A32D
	for <linux-serial@vger.kernel.org>; Wed, 11 Nov 2026 19:19:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6DE71606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=p0EcXAFX
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4a5b2be99a8so28615415e9.2
        for <linux-serial@vger.kernel.org>; Wed, 11 Nov 2026 11:19:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794424770; x=1795029570; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=IJjJtd37bhn0A4un/SmSzJepmWgtq9m5kpl7Gylf3H0=;
        b=p0EcXAFXU9q9ifEYI7vKYVUYK8A5/mDGfn7ZtWLcfGW233Ce+MJ0ffSBYi7sebPZRw
         sdtlb3uHcMjobi2JFa7Hby9VtO0cK9Hog8MApu3xzB91aifzSjQbMzxz9Atfs8B2/QhW
         FKrioSJaAex6vlYhK0pyWr0NmfBMNVNbu12EavPWDjzeT1WB01h94zAAzUwMCbpqnDru
         LVaerzSD9MszZL0eiEixU0Nf6tFbl/tpSytPs25TS5WK/oRAdkFzWiq2hvku3o6MlvNa
         za/UzMI0M0JVfttVbtRXPy9bhkxudUf0T4gLhz5oAT9aILPk99A7yM/9HGO/D67xAKEv
         Tcdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794424770; x=1795029570;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=IJjJtd37bhn0A4un/SmSzJepmWgtq9m5kpl7Gylf3H0=;
        b=CyZ7p9pDxlXeoztBF8MaDbnAWIcVsvq1LUE+AtdYEjDvRzJXZ3k6reG+sObcAWOuSt
         8u/K7nh9uT5EAI6/Cht4raegkiqInnLguWbYA2fLELIt/i5e1Kn8AykPBbRML0mj4Kcm
         6H3jkU12UIMPuLij696nmsnu8dOJ8uAYq0WoTEvZiHOIH5RXz6xjVvqZz7LPg0prVi5c
         DF7+74uUKm+fNW2/Dm2LAdd+nRARAn6YoHD1Sx8XL8PSQEVMLQotdmG1sjMID8MK8Ycu
         U8YKCD+dUM0eDmrpJCkxkxFN6LQTlUY7DikBR0QDXmHaCnAUXQ92LdJi5afW2Qb6wsAz
         oAKg==
X-Forwarded-Encrypted: i=1; AL+hErGDbPaL5cNrR1TpCsHGyR909hPtlN96BIazetYwILu3aREmC4t5xT18SP7yF+g146zkzHX1XlJSCDqVd+o=@vger.kernel.org
X-Gm-Message-State: APuU4Z87RsNsu2rf9qvz3p+fXvTpLO96oItNoBHIqoJD+7b/V6xKiHcl
	3SAlcrT/BUcl0tXT/xFP9tLKm2VDuU1HE5xQtQ/UwMqcD9leiiCNe6de
X-Gm-Gg: AYBFou3NXv3PKRvwAXmTdMuKXMvtiog4zLhZVzRH+iueFSTlYgMbYbwF30ZyyilleD2
	uk9oYqDNGQUq+HJ9DYjI1DUqNeHqomEvmAMUu8fhUTNgk0VnypGj1hqMZdZR0yzRYUSO9nBDnOp
	swRDT6alXXfYvwOKWD1EOATB20Jgh8YtdezIZoWnJN+HFnnAyTlgpRvBad70hAa8oAn5clQouDy
	h8PTGzhs74WlhyZxig9SMOADQ5uHvPFpRwPVulDVu1QJQ002w82gK/rDbUxmvE0M8qrNopKp4bo
	OD/oh1Sz1MVNHY/PhvR5tlcb4tUXWlSzabqVVt2JZDYzNdBUnqXH9jxNejQpy35UXURqC/Y1wqZ
	AV2cG/3dm6wawBA6E2CJl9frzkpF0X4yKIXFt65e27o+ATc4mWMEeXaxgCBK42O+xvBzAs2oc9r
	LALdcRdQvbb07qGvqReGgpKHXaHsEGaHj0bOrCAxgJIvBQUiwZTGCfuxXIEEFte0JVi1MmoPZue
	SX0FUosoJLso5hemfve0UfYy5YOi9ZkfQhTTTayCtrESblnEunPVXtpAPz9TVN/2f6EK8iGtUUM
	O1CxXAQI01u8YxpUKoWhWQGCKpnzyB/sOAHbjKLh2Gl3jfbMOkWvY5+w9BVFxzu7cgak9F9vmrR
	Gk1p10OY=
X-Received: by 2002:a05:600c:8b24:b0:4a2:1364:252b with SMTP id 5b1f17b1804b1-4ba09383fd2mr55404945e9.35.1794424770348;
        Wed, 11 Nov 2026 11:19:30 -0800 (PST)
Received: from alchark-surface.localdomain (bba-86-98-194-229.alshamil.net.ae. [86.98.194.229])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb4e267dcdsm9345305e9.11.2026.11.11.11.19.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 11:19:29 -0800 (PST)
From: Alexey Charkov <alchark@gmail.com>
Subject: [PATCH 0/4] serial: vt8500: Clean up the probe
Date: Wed, 11 Nov 2026 23:19:15 +0400
Message-Id: <20261111-vt8500-serial-cleanup-v1-0-b33594a25f87@gmail.com>
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMyw5AMBAAf0X2bJOWeP6KOFS7WJGSFpGIf1fMb
 Q4zF3hyTB7q6AJHB3tebBAZR6BHZQdCNsEhEUkuA3hsZSYEvpmaUc+k7L6i6XVVpJKMKQSEdnX
 U8/l9m/Z3v3cT6e2dwX0/pXvcF3kAAAA=
X-Change-ID: 20261111-vt8500-serial-cleanup-dfc9731edd70
To: Alexey Charkov <alchark@gmail.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Tony Prisk <linux@prisktech.co.nz>, 
 Alan Cox <alan@linux.intel.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@suse.de>, 
 Wentao Liang <vulab@iscas.ac.cn>, Sashiko <sashiko-bot@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1049; i=alchark@gmail.com;
 h=from:subject:message-id; bh=+hTK6IV/HGfu+wOooMtgfojIoiSt4kZ6VzyBes7lhAA=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWR92b8/8cXvSB7Tks9tGwI4jm/UavM6m5ajuODAOsXU+
 rbAzPhHHRNZGMS4GCzFFFnmfltiO9WIb9YuD4+vMHNYmUCGSIs0MAABCwNfbmJeqZGOkZ6ptqGe
 oZGOsY4RAxenAEx12DZGhnUynr/5Nv2+WBIRL36K9a/RgcIl/NtMF6/4onDAZWVEtBcjw+k7Nav
 PGc1wDVh2ULzAbpfJN9kZlaLlDdPmaTostJ6xmg8A
X-Developer-Key: i=alchark@gmail.com; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5

The driver has been carrying legacy vestiges in the form of a bitmask and
a local array to track which ports should be numbered which, both of them
not really needed anymore with DT aliases and existing in-core tracking.

Remove them altogether to simplify the driver and get rid of leaks Sashiko
found. While here, also convert the clock handling to use the resource
managed API, and propagate errors from uart_add_one_port().

Signed-off-by: Alexey Charkov <alchark@gmail.com>
---
Alexey Charkov (4):
      serial: vt8500: Find console ports in the serial core state
      serial: vt8500: Use devm_clk_get_enabled()
      serial: vt8500: Handle uart_add_one_port() failure
      serial: vt8500: Drop the port index bitmap

 drivers/tty/serial/vt8500_serial.c | 81 +++++++++++---------------------------
 1 file changed, 22 insertions(+), 59 deletions(-)
---
base-commit: 793807ca13bf3072fc6d16ce6d90e9ab9beff2a5
change-id: 20261111-vt8500-serial-cleanup-dfc9731edd70

Best regards,
--  
Alexey Charkov <alchark@gmail.com>

