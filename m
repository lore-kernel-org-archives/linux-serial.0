Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795601333;
	b=pfL/rv3R5KHbeLhtzKhEHV+1CPWEOOW9PXcZMLN/5OMeRO8pEFXhqTQ7kU8xUKyvvbXO
	 9lcUJzk9fvUSxiAtyCdbRoPpuFU0G98K5tAKpKEuNuz1mgiz0kQoAHKTorSgLMfddxFD8
	 +h0ljWEV+izWZSv4gTgk+gMpBmT9SMZXUhXsPLEFzbgstZLji2hmlIyH6a1z4vzOdChvU
	 QdUPvVre6gXdfgl2omcw2TwjqOnGWSqI9qnETe5KONHDUpm3B/gxsg/SF59AfBIdJUt24
	 1BhFXGoMtUBfJGPQz2ncOZjXd2bOCDePvS2YEon+tNOLTaFuOQ6ycMx6aiGNDxRKtjw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795601333;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
	 X-Developer-Signature:X-Developer-Key:Content-Transfer-Encoding;
	bh=8RFJnfFUofOUJVeOBHJ0G0LL1AXcDfGe/iXizP4/kQ4=;
	b=nPo/AC/WaZCgsJ9FZeB385A1jfSl4Iks4ab9gMD8wvX8Tg632QztVT3HSm9U6mqz5rsr
	 N5AwswaOR4AW+T4iQaPc7z2XyGpONoaR+UR3pet1oFXLXoylWYtjHkuzovJMyly2btMM0
	 9Qn+2ti8uTpOdCeafl1XhrW2XVr02XUbMb08XmYeKPcJ0qlhC93UCZKtbsAhrpzKnGTVL
	 aOgrDLpcCgCWxxDw69az4LmmwmyumJiEX+hsOohOgPLGxYrhyRkPNzzb2fuZgYFP0iCxg
	 t/xqJRqIXxipO0YHIN/5aI2uefE48yNdHVZey8dkoBTMtMbl74L7VeZllcUwY3OMviw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=baylibre.com;
	spf=pass smtp.mailfrom=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=a9GKwi79;
	arc=none smtp.remote-ip=209.85.128.47
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF86606A321
	for <linux-serial@vger.kernel.org>; Wed, 25 Nov 2026 10:08:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ADF86606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=a9GKwi79
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4bba5e17728so4450575e9.2
        for <linux-serial@vger.kernel.org>; Wed, 25 Nov 2026 02:08:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1795601331; x=1796206131; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8RFJnfFUofOUJVeOBHJ0G0LL1AXcDfGe/iXizP4/kQ4=;
        b=a9GKwi79120n4yBBhURyzuvJMs8n2HoUre26B8bje8feS3Qtx/9GZaH1rP15mA6Yxx
         VdYOWxE65FHI1XpmaSuir5ZWL7uN7PIzJ3s8OBRvWY4sCMDxYOitz9YDEwjGQm/nVl0X
         adPc1n5OvSSJhYxFlKIluSnZh54edfOCvZVNkJn8pKFMMRVmc0FI9whI/bPK4f/VSt2D
         RjIgB3oob6aTWHOyHzgU19+0OOlODIPYJUbxjDPXAHPjWREZjdMfKeXHfrh1ATdjO5bx
         dYHYy6vEJ9BYFkLW+g+UpCZnDJFLHV4jNYgJQbLWkjJfKYuKhXeHRUTqp+cSicY/WugN
         2gnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795601331; x=1796206131;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8RFJnfFUofOUJVeOBHJ0G0LL1AXcDfGe/iXizP4/kQ4=;
        b=jg0uwLkhX7rt3E7bSbklgJFwUoXTTbwycaBNrV69wKhrTjBmjn0EZArBFdt9k7uQ9O
         LLkUGLdfCdVb8eho904jMautrVYNRjkQgUys1EqJjL3D+C2I4088LJG1i5+4PG86F7iK
         94FzgwWfOEIf6XbDUFPeUS3gJzaX9hf8LMWQfMvgij5qV20DN8hXD0DLuyx/b+7qxW2A
         nNX7bjNxX5UFQCBe37/tkhybuvRszEP6NcibNbCWo8ueFzCFzYHJksNS+X/YTkUdKkgF
         H+umqox0CPbzJ1KZwkLT9lCO1pWkLyykrrj23ZgEEhlZxLGni/5WVSP04ldTHMShBCG3
         pbWw==
X-Forwarded-Encrypted: i=1; AL+hErEgjIXRcvNhEEg68Hk+IoffNIS+QZEMRho2bFafOzzh+Zu/x6xVSz6tJBZq9+1XYYwEpEPgqb/xVGrxiZU=@vger.kernel.org
X-Gm-Message-State: APuU4Z/+8fnejhZ2toTY1ZsV3nnZAj7UJcvKtXVwxg4ChfqLeSAu9kDt
	auhYuijnC+7kHgZRk1szkaz6S08ZojepeuCuLV2hyKd5wRF93re+bo7j8YaeKRYK664=
X-Gm-Gg: AZFdTZc0/i9NZs+BWFSGQoht7vGB1lMLkGaRnT6dBL2N4D6MEsxlUhNCgRs1gxuKXxU
	oT/lR7zdhdNMWHR6yIijAgFYN/VqNX5hKV1H2Ahkvk+ZNfR9rgcmR1sfBoS0g2KCQN3Bvp8GvUb
	K/S+okMidiLHrZkOIaBO3wvS37sZaNY3aoOSnkq9B3FWCCBpCVGskCDrVJbubYdNEl3dxtggu2j
	08wESyaI7y5m0TjMOrkcRj/aLjxjBmLot3UY2dnBYUOxfocck8nsK3EKN/2rAjKrP7nePGDKjgT
	QusrA5iwZMXiTUB53xfA12uX3StHvUjqNBJ2oNfDn4pq0LhH1oND8SfDRyHyq8t0MA3tBIigOam
	8c/BTr1FJ56HlZm6MjeTUFle07fS54mDoFD0j183ArNvPXk5jkAgJw/gB0QONs1hNJv/EcPbteq
	aj0Ua+ap/5f711HabARuez6K4M46vJE3YjLYAscqG1/qWOPjMF+ZnwVEaTXpiZlG4ilh/H1HL8h
	TgDypLHWHwX/rkvxSBYCLelUyFvTOS8oWlbJn53eR3J20qVJ/tL6DmTPKdfac3DWoC4fYuVF2Vg
	70hwnHYecJRoCQp/lMc6oCY6FELHsxrJtUk0Dg788d4CfqI1vWSd7AMnuIwJNXIDpcmDYg6wyjT
	pInYxRAMYNLssCVGr
X-Received: by 2002:a05:600c:848d:b0:4bb:52d8:73ef with SMTP id 5b1f17b1804b1-4bb88940f1bmr346869865e9.34.1795601331043;
        Wed, 25 Nov 2026 02:08:51 -0800 (PST)
Received: from localhost (p200300f65f19a9043ef7230869dfba63.dip0.t-ipconnect.de. [2003:f6:5f19:a904:3ef7:2308:69df:ba63])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4bb853ca452sm494486865e9.15.2026.11.25.02.08.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 02:08:50 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Paul Mbewe <paultyson.mbewe@ziehl-abegg.de>,
	Joachim Knorr <joachim.knorr@ziehl-abegg.de>,
	Martin Fuzzey <martin.fuzzey@flowbird.group>,
	Luca Fresi <luca.fresi@bithiatec.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: [PATCH v1 0/2] serial: sc16is7xx: Two simplifications
Date: Wed, 25 Nov 2026 11:08:37 +0100
Message-ID: <cover.1795601260.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=612; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=x3FshVaiZ2bQ7REteKeXQd9o/itPhX2UHimwWozOqB8=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBrBrOligdbxiii+PmMAhR41FggMFupvbQayJJ2R x/U6JBCXlCJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCawazpQAKCRCPgPtYfRL+ TthnB/9+0VgDmPwTgmZVpux2mE3nVwoeNUfUOMKTvDQQ0td1GgcDVU7NJl+n1P2aCdUZ7+RiLoc jGbNcL4GSfHr2h7lR46vhzZcY1EPE+JlKlw1WYES0mmBd/+mrNS2CBlpHvtRxRvaPwyDuuMMWpu yyadOR4LpWbcxDTFrVhcdFVQarNkpGqTcKCAzusTUr11mLzTusCS8NcIx9/jRDwG+qGI2H6xFxK l/N9P9I3M0EiNJ8ZL5pKWNGhdWBCChIIlPMhA4/2n3xwViycS3pm8Y6ZfB15OSQaDxj++LU+6AM kYMvRyvB1VGEHacCfQnIc54M+rX23zZhlGkqu/brkvWNu0iP
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

Hello,

the objective of the first patch is to prepare for the removal of
<linux/mod_devicetable.h>. The 2nd patch is just a patch opportunity I
noticed while working on the first patch.

The patches can be applied independantly if needed.

Best regards
Uwe

Uwe Kleine-König (2):
  serial: sc16is7xx: Drop usage of <linux/mod_devicetable.h>
  serial: sc16is7xx: Drop unneeded __maybe_unused

 drivers/tty/serial/sc16is7xx.c | 2 +-
 drivers/tty/serial/sc16is7xx.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)


base-commit: 3dd8c790a7b7027abdd568e36db5e82ffaea7c77
-- 
2.47.3

