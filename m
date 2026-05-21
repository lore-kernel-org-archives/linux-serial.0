Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B35032BF52
	for <linux-serial@vger.kernel.org>; Thu, 21 May 2026 15:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779376072; cv=none; b=RzFDGcKy7th24gs42n31cblvufSdcIQ2XHuV3x03n6TXcT67uPI9Hv4QxrSqmQNJQowZSHD3sngGZinLpAIGNiRrkv0gFz3IG071CsiuvB+8J+EB7z3rZ7u+5Lb623ONwhNK3dJpTGxQvaIdeQEJkLukRdrcaD2AaocHo35nI4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779376072; c=relaxed/simple;
	bh=cd3dKYTuIZtproMToprtB8KNI0LgkvRevMgBh5hgm6M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=boq3OLHhokvJXMAYYoc1fu8Hg27eFpfBH3ActeRe2e7naorvH94CVT5DWSZaFYV15LEUwDdAVgjtBvOQDBpn5cvbow2MQLA03ld4sMWKBAbPieSfFb7+mjCEKHL09i0mHFKGQnlpDO9xMnMtfJ6vJETmuT+UWINOcmVXccAyxE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JHpnXSAh; arc=none smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JHpnXSAh"
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-65c3ea2ebf7so7219784d50.0
        for <linux-serial@vger.kernel.org>; Thu, 21 May 2026 08:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779376070; x=1779980870; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WjKxID8eOM6JKjQ4xHwsGmipvQwbvP3kOWH+IvP0XSY=;
        b=JHpnXSAh/+6w6M6AVP782QAHcW/uoyrcqXk7QyULxV3SAHJbsQ5vHvV4v9fTJKzyKj
         7jLl4RQQiH5k6EETcar8UFyMAslcLbwO7gpQkZ3vkIZUDDCQhXilDSH0pXsWOVxR0GA4
         xvYGK8inLNPmoxFiSAHlJrT5C8/dUpf866WplMIcDoY4avttoDLqVM+u46AQM75aHOE7
         /uJ8yZzkZugndhm0QP/LEJl82r2C8xH1FtzZ+ySseTRyTaRmjBE+oCU2zL7I5gh+Zuuo
         ZNRNRR+9eGdEKp0FU2z5x+xrOEGV7z3duna8f9Uco1zgaXPAMnZchBkypQ44CVHSHBci
         2K9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779376070; x=1779980870;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WjKxID8eOM6JKjQ4xHwsGmipvQwbvP3kOWH+IvP0XSY=;
        b=myjfpvRy6um0nMfYUDXGREhDbCbg7X7UddeKlZfeW66qZw+rhf0g0pWm2TgyH47Jb8
         su92OGQytlimnl4VIvbuJmkqZ5CSz3PlFtUvdYpekjqW7aAq32bUK27xe0Z78aaJATZn
         dL54q1sQ4RXJ+JQCeQoVboBZvwCqi3TDXtNvStjf/BR6dT/3QgXH61KbEq+NOLQGZiuO
         VzbWi2cRWAZInWrb597riQEPFxE2Cf8TxpKiiIZlGYeLLgQMgfjcSYAQKfbP/c1BzfaZ
         4xLDgsolV21PYzM5qU9mXJn35/4Y8iMP1yM44VDIuDuDDxFxOyLc8ayoMI2F0ID5L/Se
         FV0g==
X-Forwarded-Encrypted: i=1; AFNElJ/gVD2f2E0nKe8UCo8OL4jMUThWww2ORbnlGcB2aLbUz13D0RSbFxTHdyTzFC1LVfyxl8f4AfxMQXxHi4s=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywti9lc/Y4iKssqxiiWuLq9iPNEiI4ZP9OKNX0APhDbZ6gshYrs
	WK7w1dYM4jyeq56lVhkA6JsrDuaBCymnUFUpLXzZLRPFRdQaQ+VFz8RY
X-Gm-Gg: Acq92OFuyifg93Mwcv/lYdfzSNt1h72YpSWLCjRKsi6qgpNatJZRgzfjk50P63Kfa5H
	nkaTLLY2o6burOQ9M0mgekQ6wuoGnvKzjR7/Kcv7Cy5ApADwhJvuHAPs3EFDEEcRrN0B1hIq6Nl
	nlSXywRrg2J7tAz1STX50lEXxYjgMGKG1AYuc3sxxqcu9hajBBSQHCeQ5uCCx77HpuIew/Vi8Nj
	iwVZjEHDKtAYzgMaNs1Dls7LweKGvHzTZLj8bOz3OVLTgtRARKooXDhqHt6c4CTBeSK5qGhpg7E
	urq9ZtxTeJOjqUw/6qC7eJ2rXew+PMlhRy/QszJSQEzQqv21z7ddVrF4WJI5dKkouIf24U19c6g
	1RwzgiG/YYVXdPutaep9EZ+vZVnQoR86ZnIhG1I4VCiYKOyughgJicHTg6zdh6112h5lLquzY71
	1QY/M9fTBqhePn+ioNKEeemr6yDq07dhyqheH4NTjDsZToMLPGNA1X
X-Received: by 2002:a05:690e:4812:b0:64c:f7d0:5c07 with SMTP id 956f58d0204a3-65eae047184mr1880107d50.10.1779376069874;
        Thu, 21 May 2026 08:07:49 -0700 (PDT)
Received: from fsh.attlocal.net ([2600:1702:56e9:4b40:ed8c:6b8b:1fa3:d14b])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-65ec1eeadd3sm288264d50.10.2026.05.21.08.07.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 08:07:49 -0700 (PDT)
From: Akash Sukhavasi <akash.sukhavasi@gmail.com>
To: krzk+dt@kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH] dt-bindings: serial: rs485: remove deprecated .txt binding stub
Date: Thu, 21 May 2026 10:07:47 -0500
Message-ID: <20260521150748.4816-1-akash.sukhavasi@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The plain-text binding file was superseded by the YAML schema in
commit d50f974c4f7f ("dt-bindings: serial: Convert rs485 bindings
to json-schema"). The file now contains only a redirect notice.
Remove it.

Signed-off-by: Akash Sukhavasi <akash.sukhavasi@gmail.com>
---
 Documentation/devicetree/bindings/serial/rs485.txt | 1 -
 1 file changed, 1 deletion(-)
 delete mode 100644 Documentation/devicetree/bindings/serial/rs485.txt

diff --git a/Documentation/devicetree/bindings/serial/rs485.txt b/Documentation/devicetree/bindings/serial/rs485.txt
deleted file mode 100644
index a7fe93efc..000000000
--- a/Documentation/devicetree/bindings/serial/rs485.txt
+++ /dev/null
@@ -1 +0,0 @@
-See rs485.yaml
-- 
2.54.0

