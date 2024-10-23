Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A4C016190B;
	Wed, 23 Oct 2024 09:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729674553; cv=none; b=uCPU1G0yvT8B97VY0/RYOeRW2wcnWI+skdJrZAr9/W28Yw2cV7S+MnFOx4a6Ot7JB0rdCybhi/mkFTZITiMwBWaqA4a1trVKL8l3TFZNerOvhB9jX9Qn/SkQuR7/OG1w3ScubeCP1EysFa42WM4XTeuB3/0f0CxB/W+O0NCElAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729674553; c=relaxed/simple;
	bh=MPXSO7MlmL0YKy/BMMfxHrqho0YS3NUcNx2DCOjbvyU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Rk117VDfoY2bgtzcnClNfqbhTDtECx5B8MtNUS2DYkmfVmVq91qmVFSiCwfM5XnmfGIMx2L4yw70xwWvSo0sGNqXy2LGUG11+VDIvYQrCS+qjOXvL/ur4F0m9w92azfE2xwcaPTzkPXILghdNh/oplgNEoNDI8Az9RkvnKIBEAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g/OkG3ck; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g/OkG3ck"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5c95a962c2bso7883988a12.2;
        Wed, 23 Oct 2024 02:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729674549; x=1730279349; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tUrRWUy2mg+9eFy2uOgVTtm4AMaUGJKQ+NZVihzkt4o=;
        b=g/OkG3ckqYBrZ/Kkk6pDcmZcSHbwQ0+6vJA1gSUm59gw3BEoZPmA1oYCo0pjXwEXeT
         8VFRbes1P2NBzCwklqz+0DYDoxhWiiBbAzAxwO8htpQ8no8zdKdrgaOs3LTW1Z25ej/V
         aRNtzEV99piFPpGxwsPOCCAMrYkVNyp3qO9xh7wlslk9k71JzLUswtxb3SndEvnN7VHJ
         ae3IU62eepa2deXOme3849mjJcFyvZZ4vD9jeOvIEggn5NAm6EryJQTh0jG+TO6Wt8GN
         3/n3CW/Vn9O55xIFoGaRSufiG3bLcDpZdX7XPUb2YZx2ZQaGonXFfIdbGH0aq2LJ0t6y
         9Ylw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729674549; x=1730279349;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tUrRWUy2mg+9eFy2uOgVTtm4AMaUGJKQ+NZVihzkt4o=;
        b=bhw7G18Na8wYa+OL92PQeNGcdna5VAO6+WBQrNtpvHpjhoshmOzqLnwl8+Fq2PjCb+
         CRyYJgzuQ073eunXyGOG0pDA9oYkp5fupk3+MbU9MZsJxXTLUqR4kEfF5OtvSCBTGYwu
         zTlclSaef1HkY3NyNRBf0/WtiDo1wSuhqqQmadOhqEDWTF3yva+rAR+r28ym07zIRUOZ
         yV7guFmVbD64VRZyHqLqB2mlXAxdT+Y5sdE9nYFJ5pdHRiaWlWbdGNDYh/DeHkXV3eIn
         4zG3zEny1k9Zpl7FM/0GEgs9N8LxO72YToHejsrcfVcfed7K6Y88ex/uinufbWd72Znx
         0VKA==
X-Forwarded-Encrypted: i=1; AJvYcCUVJleDY9ARMYyT8zbVCz4cFagh4A5kFdzLPiZ7oTYo2KqDgS/sLCzwp5z8gk1mrJ6Rz+y6g/upEuPhYpAB@vger.kernel.org, AJvYcCUgIofaYQxeNYqEeCPyrjvLCsV63yex1VmJtP/oTzbf8rXHmV44S6uboOkB9BzJ1O65GrKsufO+OaDx5bt1@vger.kernel.org, AJvYcCXclHH9Zpl2OXF5SbDqvxyqftbrbukZzQGgQPXc2O3c+gQpB1lVzBsfg1eS/G5nM5CIfrZ14okoB1YF@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8XLUSRfYDx2Ru20Bw+AtddneTnCOsoMRkVbYx73yAXUVQNLUu
	sxcQrGU2ElssEozwNxjMJXjI7ThuAoSHy+eKYG41p7rf64PRbYIh
X-Google-Smtp-Source: AGHT+IH1co3YBg4rKf5PUxpbvDK7TPc4kKnhGRQ/nm7LiXeXMTGbhhWYCdZPkZcPIJcd+rccOP+qzw==
X-Received: by 2002:a05:6402:3888:b0:5c9:6f20:4cf1 with SMTP id 4fb4d7f45d1cf-5cb8af7228amr1624364a12.27.1729674549217;
        Wed, 23 Oct 2024 02:09:09 -0700 (PDT)
Received: from ivaylo-T580.. ([77.85.230.22])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cb66a6a8efsm4133058a12.52.2024.10.23.02.09.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 02:09:08 -0700 (PDT)
From: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-samsung-soc@vger.kernel.org,
	linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] tty: serial: samsung: Add Exynos8895 compatible
Date: Wed, 23 Oct 2024 12:09:00 +0300
Message-ID: <20241023090902.538040-1-ivo.ivanov.ivanov1@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hey folks,

This patchset adds serial driver support for Exynos8895 SoC. The main
difference from other exynos platforms is that fifosize is only
specified via the samsung,uart-fifosize DT property.

Newer Exynos platforms also specify fifosize via DT, so in such case
this compatible could be used with oneOf.

Changes in v2:
 - Grow the enum at gs101 instead of making a new if-else
 - Add r-b from Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Ivaylo Ivanov (2):
  dt-bindings: serial: samsung: Add samsung,exynos8895-uart compatible
  tty: serial: samsung: Add Exynos8895 compatible

 .../devicetree/bindings/serial/samsung_uart.yaml   | 14 ++++++++++++--
 drivers/tty/serial/samsung_tty.c                   | 13 +++++++++++++
 2 files changed, 25 insertions(+), 2 deletions(-)

-- 
2.43.0

