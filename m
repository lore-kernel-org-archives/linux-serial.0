Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D7F3D725E
	for <linux-serial@vger.kernel.org>; Thu,  8 Jan 2026 09:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767865679; cv=none; b=DcjZZ9xXLoZ5oC2d/DX0jD8OGyGGWuPouRbTeEWLmqM96VS+Gv3817qerK68zArpMeXsfhu0ZZhatAt3FRUM4d/3EY0XH0lM1Q6mMcQ+HuP/gfDJG7IDnGI68S8XojYAS1SQQew2XnUIVx5Aspd+qaFXgd+IpeUxjHTN2Jq0rtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767865679; c=relaxed/simple;
	bh=F+HI9weCrGvZqZdvGzT41fozcChUp0aiMuJIzq7Twlk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nF5l/vZqI46Eq+TLDY74TV6nHVVnGK2jr6m6f3WRKY0LqDUKKzagM/DBIYCeOdhA0GytlF23nMrEyD2J8bSJyCT9WDV+hMkOV7S7UpJKa02TNwRgf3kOlKaoeDO6n6Fdiuq7x5nGzXDGhmNYEGJPYPE5lr+7RS6LoyLgEXHZdzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dVNUnNZE; arc=none smtp.client-ip=209.85.217.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dVNUnNZE"
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-5ec838c33e6so909180137.0
        for <linux-serial@vger.kernel.org>; Thu, 08 Jan 2026 01:47:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767865671; x=1768470471; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mNWaW5uyJY39Ee5wA6GOpA1sGvgkAjuELUOx96wJt9s=;
        b=dVNUnNZE6UlRbvbgVadwQRwht0zLe+MUQE/LQBHDiUnQQAlCvfbaq9wiURjWUlKoLS
         4nvIotsYVuOwTf7+Mb2k91jiYHB9KEmb5oMB4Fir+OwhiBnqja6txSOpIj6wUBdSaJ7E
         tZGnxDJwijwgmoAnrWEmgs/+DdXhLJr22QhUSU+ua5tzFDLLKQ8yuRql/x7aRpUGvIBn
         y+XttrpV6iYqYennm2ORt0doPYsgKYRUBHFTAtnj+BhgsciTmwF3L7KtgaeXfzl7IHBu
         iDRs5+dzEXr4phD1ci/JAfCIM8mYaQtvH0TeSlOuRNb62ip+nPa32x7jthP5HzB1ZppH
         Y2ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767865671; x=1768470471;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mNWaW5uyJY39Ee5wA6GOpA1sGvgkAjuELUOx96wJt9s=;
        b=IV3HZ5rdcGl36mgb1uFuGCCsusLXf26NHDaaSLbSfiVY0udle2PEmSOQtYUWC7nyky
         oambK7D5kHsfMoHYHNh5rIhsuAkpQSuo4u4jWiyoOMrlSr0hlLKjk39HMB1jbeR0lWbU
         opbyIMun4cQD+U0Ay7pno66U1GrYBe9b6CjxICNtwU4iBSY15wE++ikS1gQhmWI0djv0
         HA0A4ZKHbePYx5vBNEODNKsOOcV0fcLE3bjp/Jeso0e/fMMnD7qUGqFZ9gKVj2Jg+Hx2
         Guza1xEoHT8LDo28j4o3/PE9cACu1YjeHFBQKUtUpThOc1OOCLt2X2Og6izWQ8XF7rLE
         MFNw==
X-Forwarded-Encrypted: i=1; AJvYcCWev2QmncYt40mr53LuoEJw2N4tJRT3F65q53TQH91zv1qmTCLF5SI+ibPYr1BtjmAdHdslRWtd7BoAW1s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/KM55QoeiQ2Drdw9wBn8AZBwRjS1EC5EctguPEN4myTNaP3Xc
	JmyY8ltbioQf1UOJMue08mFTDop1zKfcLIIZ8nyfQCMqt8s+qZ8YM4XWr/aOSg==
X-Gm-Gg: AY/fxX76yEGbl7gpUinwKu53rUVdn6qWlbTvrP7l69uyPLNOKspbGGJn1VXLZ7qoAtO
	SLgdfCr7EB6YjhC7jXw/V0EsyNrLhspYOLLPZx61XfLkGEi5BAp4cRSDUMft9Vo3+/H5WZ7iZG1
	QCZppZSc6TXYpt4362aNt2UbL1xOcd2hG8t/ZutPzNQCW3Lkid34aGe5m3Hql70M59qF3hgT+vF
	i03AhkaMkZESvvUuvab8TMpeXz8sWq6a+p4B9bCd7t+UTJ/i3F+4p4HL+qSZZmDsknEotvCYJ0F
	w8r7wupEYg/+oZhGD8ILBLz0dSaac+4zcYU5VZ+j5JEZXWCpLEBW1m4WUz+MqF+YogMTaPFqAev
	wIVhqN9DkFyG803nZHxj1JhNC+ERxSXI8sid8/VnMGe2WbGrUnG2PC5n96pp6uy0fySvHXC6Nuk
	T32Ov4YhaurjLcuUpsWZB+WOW3LOXowGKzsCikFS/PwkmkqpawFIXm5D2Xf/mnWQd2R2T0GZYdy
	kX35xRWkvn2uHZ/yz6hsw==
X-Google-Smtp-Source: AGHT+IHWNlnOIQoHRnNghuP/KuzB06upezljxGJd8aibyns6gUrJ5zRj9QVDAk4WOeIpJQ1oogEYew==
X-Received: by 2002:a17:90b:314a:b0:343:3898:e7c9 with SMTP id 98e67ed59e1d1-34f5f831c74mr8109800a91.2.1767859745886;
        Thu, 08 Jan 2026 00:09:05 -0800 (PST)
Received: from visitorckw-work01.c.googlers.com.com (25.118.81.34.bc.googleusercontent.com. [34.81.118.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-819bafe991dsm6900582b3a.16.2026.01.08.00.09.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 00:09:05 -0800 (PST)
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
	krzysztof.kozlowski@oss.qualcomm.com,
	Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH v2 0/6] dt-bindings: goldfish: Convert to DT schema
Date: Thu,  8 Jan 2026 08:08:30 +0000
Message-ID: <20260108080836.3777829-1-visitorckw@gmail.com>
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
Changes in v2:
- Add references to generic subsystem schemas (serial, input,
  power-supply) where applicable.
- Update property validation to use 'unevaluatedProperties: false' for
  schemas referencing generic bindings.

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

