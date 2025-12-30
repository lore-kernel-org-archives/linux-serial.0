Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 034D1321421
	for <linux-serial@vger.kernel.org>; Tue, 30 Dec 2025 18:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767118251; cv=none; b=ORYoGTTQeF93cNPCoabO9JvQHqEFqyzKdUeQYgwMGRLB2MCi4JVFWzhtWpPLXFOndWetVVgyz0xw9QQUGoa5sjO/hBV5etVBXMbC/naLoRbSYXjv7eHJ60AdffgSCPh7TNxXzEMVx+0TRq6Ptb+elDUSpYgARgajQ82LkAj2r90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767118251; c=relaxed/simple;
	bh=FgJuNpgaVD0m6yaXMmc2AfRGD+fA194iC5P4RORcRWk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PpybBOu+ZetXV9175TcvT91QLKh6+rHhz815LGhbzAlq5vXqhi/5HByLkX3KEJ2m7ksucaeYxLi/2O+AbVpti3k45IHGjuwBa1H3456EmAb+Ix94BW05+P8SrmN+/2yiOdmufKPNIV2rF5a9GdaGr2Kvdl07BY6WRvbUuHrNxRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jRzCiLdG; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jRzCiLdG"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7b8eff36e3bso16284437b3a.2
        for <linux-serial@vger.kernel.org>; Tue, 30 Dec 2025 10:10:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767118248; x=1767723048; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=U4o2F4BeHSek0PRiyhvtGksMp+wv7OaL4BHi8U8EOKo=;
        b=jRzCiLdGMBSfGpEhCtHyr/JU/LptiDCZJEfmCo3lyH4ZesMzZhDixX+HxuZEFyPObA
         ZDvpl/Gxs1yfacsLRce18+COii2z9dVuDBajN4FRNV78pFxUkv235fbCPaJq4XQg9O6n
         j1CPpchgDgEKuoLO6HeY1VlDvlyTMlGtBrkuuMf02sobB+f7Fex4MrA/cgfJxIAvRD0Q
         cPlPgIPQviFjZavRoU2bCBZ8o6bk67sLSC4lDj2emB4fzAV4YxoZQj8R3buNGfYso0s7
         8OYHmLp5igt5IcVWyeK1rJLulTvO9gGkS60xrtl5lNH0d556kwNYk4hz0L93gmf+YsQe
         R9xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767118248; x=1767723048;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U4o2F4BeHSek0PRiyhvtGksMp+wv7OaL4BHi8U8EOKo=;
        b=vtNMpZWLc/Mo5s0oF2r1289ZYSd7Ez02P7tSSlGHCkPYDO6YdFtE4X6H48R7dE7to+
         9ln2rdwncLfCyJ4azVklbd2pGG70BDPYOQHUDikXsw1SMZByTdynnmJl10evComa2S69
         hJIgfLF5WW68Eta3eiWF9BO9kWPYe89cfAFcb5+1ibBc0YfsSEMX2uqOc1bMt+MmEX7M
         Ov3d7dzGiPQ3RebBIxD2zj41TlTsMIJJshPJNTrtzUEAZZNj+g0X4lwu9y068YDmdnHV
         DJIIx5l52lMz7fdkI2VSgzbFypaPisilFgVNZTCxM32iyagn+7yWGncNZ4uvkmIlJyZd
         HkWg==
X-Forwarded-Encrypted: i=1; AJvYcCUQgd+J7Jg2BqPseYQlbnS9NOTUMHoWDVDx794C0dv9lL55j0sMnUDIbrc/aPdcFYA57U61p+Yq9DM5zTA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUlogrlABVackxSuAvHSlqOb7lYBa4txT5pVQReRrYHb6Dkrgy
	ta27wJHa9a2P9zIkjAxGjm84yVzSxkZR4MvpRwQylEPj4VVPbjTouzjF
X-Gm-Gg: AY/fxX7VwOuPByyCMhHZmDOgHuIlohj51zmlOiPqfFWRMEXJu3xr52uts7q5YTYWZNi
	Il1XNkKLpiv1A/GqZLIomDn2yRIRjPSCLL75wJd3+r8M5cj5NENHTX9iJ50RloIlRJRL57z+7Vx
	jPEwNuvm4c+J05SBRm/xR/R39pzvN6kYoCrn+O2Untm6Kgp1Gsa8MlDJSu6z2Lph36fxkwxRjfK
	/LH3KsFaEBuxbWwNw3J1n0cDnlpzoKQCKpAMjFGbOU7D6hPWAWn9nrgo8cgtOS/1BzqtvNx/IAH
	hrZj06VQGM3n2IiPaac8WBIjLQtvtW0WcOHunaVC+OEIMrsalk9Cc+EAG5IHxpRko/VAiv9XmFF
	Wa3wSwqZUS5SphWLhstK9o75NxcUNLNozLEeUndRQP7ut/4h4fPC/8eCQMEjiyTHV5Y44FD4Ztj
	ia5/jKkv24/0ZPZ4Of20GNqJ+/GNj+cuSGB9pK75y0LHmzOSqpLSLVltRFZDz6zwcfl/H7bfNx/
	hiiX/M0zS/yDzxxa5WhcAMFrkvFAGR8
X-Google-Smtp-Source: AGHT+IF7WV9lO2SRprnaSS6rXcXG+rahUOdxgA9XI3QZjssiw/UqNuh+1y3CwU7o6es14BggMVW//A==
X-Received: by 2002:a05:6a00:420e:b0:7e8:450c:61ae with SMTP id d2e1a72fcca58-7ff67063910mr30261999b3a.69.1767118248003;
        Tue, 30 Dec 2025 10:10:48 -0800 (PST)
Received: from visitorckw-work01.c.googlers.com.com (25.118.81.34.bc.googleusercontent.com. [34.81.118.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c1e7bc69728sm29598278a12.19.2025.12.30.10.10.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Dec 2025 10:10:47 -0800 (PST)
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
Subject: [PATCH 0/6] dt-bindings: goldfish: Convert to DT schema
Date: Tue, 30 Dec 2025 18:10:25 +0000
Message-ID: <20251230181031.3191565-1-visitorckw@gmail.com>
X-Mailer: git-send-email 2.52.0.358.g0dd7633a29-goog
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

Kuan-Wei Chiu (6):
  dt-bindings: serial: google,goldfish-tty: Convert to DT schema
  dt-bindings: misc: google,android-pipe: Convert to DT schema
  dt-bindings: input: google,goldfish-events-keypad: Convert to DT
    schema
  dt-bindings: power: supply: google,goldfish-battery: Convert to DT
    schema
  dt-bindings: sound: google,goldfish-audio: Convert to DT schema
  dt-bindings: display: google,goldfish-fb: Convert to DT schema

 .../bindings/display/google,goldfish-fb.txt   | 17 ---------
 .../bindings/display/google,goldfish-fb.yaml  | 38 +++++++++++++++++++
 .../devicetree/bindings/goldfish/audio.txt    | 17 ---------
 .../devicetree/bindings/goldfish/battery.txt  | 17 ---------
 .../devicetree/bindings/goldfish/events.txt   | 17 ---------
 .../devicetree/bindings/goldfish/pipe.txt     | 17 ---------
 .../devicetree/bindings/goldfish/tty.txt      | 17 ---------
 .../input/google,goldfish-events-keypad.yaml  | 38 +++++++++++++++++++
 .../bindings/misc/google,android-pipe.yaml    | 38 +++++++++++++++++++
 .../power/supply/google,goldfish-battery.yaml | 38 +++++++++++++++++++
 .../bindings/serial/google,goldfish-tty.yaml  | 38 +++++++++++++++++++
 .../bindings/sound/google,goldfish-audio.yaml | 38 +++++++++++++++++++
 12 files changed, 228 insertions(+), 102 deletions(-)
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
2.52.0.358.g0dd7633a29-goog

