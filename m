Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DB4C33B6E1
	for <linux-serial@vger.kernel.org>; Mon, 12 Jan 2026 20:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768249991; cv=none; b=NjTles/xNAq/SwK5nFYpk0eRHu8kE1qA8KJ8frTgaP0iNZODGd0Vi0ooYN/gey3BCIQgN2LLKi4FRychBkm7QXO4W6iOy/V0ZOSPLneSpwjB6CkR5aSN78oMY4fXKwP4dIrj40xMRyLSoNt6nVvaKEEkWAI5C9lgpmZV513u/lY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768249991; c=relaxed/simple;
	bh=qpCaq6TACL6eqM1utYs6sRZYduBCrJkOLynbCIHDvqY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AAJkZwc0YiVeAJjj61eOvjGw9ccsVDEg8XARFs7j6DN6ZrvWGmf3OHJ4p5UqagIDjmnZ5MhZLfe3LCB1AwAC1Cgskx77O5ChowAskQGACDHLZyOGLsA+/OcyRGTZt4cCyjRD1vrsa5n29ZScpTG593DyHL3kb1wztuimCtU0I3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AEWvnUdj; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AEWvnUdj"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-88888d80590so88386436d6.3
        for <linux-serial@vger.kernel.org>; Mon, 12 Jan 2026 12:33:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768249989; x=1768854789; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CUq04sqpfNThT7kS3bI999/FPk05t6O1xEOGrVfWKpU=;
        b=AEWvnUdjGfGTXwaHWiMG/EtkOfqKCknhrVpZmmFNKuw7OSSpD1ARL7aRMRke1PpQGO
         SZGIWBQaoaDt0lwWEz1IbQMi+F7mbHagb/HaBVne3kAyEiSW36F3TuTwo1kSKpEpTAiU
         7BZ5bBIcboZ5XQ07NwW2se8WECBmLyE4WNaek1WB4EGkU6mKvQBeggomCnCBQU4cGmRM
         BcePva5G5Nq8Zq1etBc57wG/96d7+rTHcGa7oK1RZgL/mri4HRPi3+biUZgGEQU3Q2qG
         XEWPDfgyPe5HpSRKbsr/lC1ojgfzLTPCGmLMTeBXd67zlML6vp+CnkfQFPfpt/ao+pMq
         aDFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768249989; x=1768854789;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CUq04sqpfNThT7kS3bI999/FPk05t6O1xEOGrVfWKpU=;
        b=hgRMETebYl66QHVrg8WnYMgwJA129x+vXYin2jqZEIvmG81leC/TIIPBip92UNQ24k
         zkuh1XyhSb/iNQ0pO05SQoVieihJaUamnbIQ13XmdYNhRXI05brjYXAt2icfop31+A9+
         SWqanKNdjf1cJU16C9hqo+MUZPW+PFASKqQjErMtzbtWiyNb3qVDtDfWD2/jordEwq+u
         /kqNF0TxqeJtN7rL4zT1s3wxrbzpEfxKssUTNDRZ3wO9XTE6aZ0qC7y6WMG3wzzibDfc
         gM3KidIdj+NPLVXcIAh63XIiS/bjBHklRIiGMQ8qB1xAhuazOLLPTEJrekppLgjZUHi9
         D3Nw==
X-Forwarded-Encrypted: i=1; AJvYcCUkecpfgxjV4TAJIwuu+39Z2ibywT5QDr64/3tzlUowAJUvMZ/IUEfN6Hulo0vOKCqOif3T1gvcqlHZed8=@vger.kernel.org
X-Gm-Message-State: AOJu0YynRJeq2vyvYMrlk7/ioRHNZHJ6HuKjxgQyf5eXDccqYejdPi4u
	J1kkZzuUUObgMnTjq6xtTCYOJ8JjtTt+jkao9zHvELndRMjQIM4+jEpXyeshug==
X-Gm-Gg: AY/fxX4BQ00PNs90a3Y+Eg9XFKcaEW8ZwvK7k7UsqVF14aZwb+6V1oqlt3ZjFo6PFDp
	kjIwn6glmJA90cdmWuAyTHnEvw8ArMoxcwrE2OY1ucjB37InUQgHo+5BikCi9SAOBT3yWgeottB
	WwmNVhAkqA7FeqCuGr5tKrt/KGY555Y4iMD+WV2ItqHTd6qvL4Oa/m0f1W7kNtqErrol5vAYdKB
	8eQdSwZm5dGwZZy28eTYDkjRPCiinzt2KEqIrbaqiyuk0Cx6oyDAUVQ/L80aE9Uu/cwA2I+Zbvi
	bSbainCQLJBGA9BWEBl9OG9QCvlYhy+tCIA0fOIa1VwnLJAmS0fQMWxQQfHo/qwEABuCd2ePVuj
	UjEVCKV2rx89lcm9JSxTPMRUBRxGqdI16JZ9DOf37o95MjJcYWL0ilKVCkTFsjVkYO4TmhetdBh
	sbv5WfGfFVjK/++uaTcVpym/hwGPcjUd7jfdp6CoMNx5uW6uFmb/mBx2zT5hivvhMEupT2JOmO8
	15fWUy0CvWuQacaTrHtlg==
X-Google-Smtp-Source: AGHT+IEj1k7cb2fd0Uhwg3rDL/Jbgy35/7F5lChJPW1hzU6BQQa/0pFpWI+28ikvSEYQSgMkRmokRA==
X-Received: by 2002:a05:6a20:7287:b0:35d:d477:a7f1 with SMTP id adf61e73a8af0-3898f99146bmr17183198637.43.1768243906956;
        Mon, 12 Jan 2026 10:51:46 -0800 (PST)
Received: from visitorckw-work01.c.googlers.com.com (25.118.81.34.bc.googleusercontent.com. [34.81.118.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c4cca06b16fsm18874197a12.31.2026.01.12.10.51.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 10:51:46 -0800 (PST)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: airlied@gmail.com,
	simona@ffwll.ch,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	dmitry.torokhov@gmail.com,
	sre@kernel.org,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	lgirdwood@gmail.com,
	broonie@kernel.org
Cc: jserv@ccns.ncku.edu.tw,
	eleanor15x@gmail.com,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-sound@vger.kernel.org,
	Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH v3 0/6] dt-bindings: goldfish: Convert to DT schema
Date: Mon, 12 Jan 2026 18:50:38 +0000
Message-ID: <20260112185044.1865605-1-visitorckw@gmail.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the Android Goldfish emulator platform bindings from text
format to DT schema.

Most of these bindings are currently located in
Documentation/devicetree/bindings/goldfish/. Move them to the
appropriate subsystem directories (serial, input, power, sound, misc)
to align with the kernel directory structure.

Update the examples to use generic node names (e.g., 'serial' instead
of 'goldfish_tty') and fix minor inconsistencies in the original
documentation to comply with current DT specifications.
---
Changes in v3:
- Update 'interrupts' property in examples to use decimal values where
  appropriate, replacing hex values.

Changes in v2:
- Add references to generic subsystem schemas (serial, input,
  power-supply) where applicable.
- Update property validation to use 'unevaluatedProperties: false' for
  schemas referencing generic bindings.

v2: https://lore.kernel.org/lkml/20260108080836.3777829-1-visitorckw@gmail.com/
v1: https://lore.kernel.org/lkml/20251230181031.3191565-1-visitorckw@gmail.com/

Kuan-Wei Chiu (6):
  dt-bindings: serial: google,goldfish-tty: Convert to DT schema
  dt-bindings: misc: google,android-pipe: Convert to DT schema
  dt-bindings: input: google,goldfish-events-keypad: Convert to DT
    schema
  dt-bindings: power: supply: google,goldfish-battery: Convert to DT
    schema
  dt-bindings: sound: google,goldfish-audio: Convert to DT schema
  dt-bindings: display: google,goldfish-fb: Convert to DT schema

 .../bindings/display/google,goldfish-fb.txt   | 17 --------
 .../bindings/display/google,goldfish-fb.yaml  | 38 +++++++++++++++++
 .../devicetree/bindings/goldfish/audio.txt    | 17 --------
 .../devicetree/bindings/goldfish/battery.txt  | 17 --------
 .../devicetree/bindings/goldfish/events.txt   | 17 --------
 .../devicetree/bindings/goldfish/pipe.txt     | 17 --------
 .../devicetree/bindings/goldfish/tty.txt      | 17 --------
 .../input/google,goldfish-events-keypad.yaml  | 41 +++++++++++++++++++
 .../bindings/misc/google,android-pipe.yaml    | 38 +++++++++++++++++
 .../power/supply/google,goldfish-battery.yaml | 41 +++++++++++++++++++
 .../bindings/serial/google,goldfish-tty.yaml  | 41 +++++++++++++++++++
 .../bindings/sound/google,goldfish-audio.yaml | 38 +++++++++++++++++
 12 files changed, 237 insertions(+), 102 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/display/google,goldfish-fb.txt
 create mode 100644 Documentation/devicetree/bindings/display/google,goldfish-fb.yaml
 delete mode 100644 Documentation/devicetree/bindings/goldfish/audio.txt
 delete mode 100644 Documentation/devicetree/bindings/goldfish/battery.txt
 delete mode 100644 Documentation/devicetree/bindings/goldfish/events.txt
 delete mode 100644 Documentation/devicetree/bindings/goldfish/pipe.txt
 delete mode 100644 Documentation/devicetree/bindings/goldfish/tty.txt
 create mode 100644 Documentation/devicetree/bindings/input/google,goldfish-events-keypad.yaml
 create mode 100644 Documentation/devicetree/bindings/misc/google,android-pipe.yaml
 create mode 100644 Documentation/devicetree/bindings/power/supply/google,goldfish-battery.yaml
 create mode 100644 Documentation/devicetree/bindings/serial/google,goldfish-tty.yaml
 create mode 100644 Documentation/devicetree/bindings/sound/google,goldfish-audio.yaml

-- 
2.52.0.457.g6b5491de43-goog

