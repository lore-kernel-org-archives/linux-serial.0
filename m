Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 778C75F547
	for <linux-serial@vger.kernel.org>; Fri, 12 Apr 2024 13:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712927651; cv=none; b=S9of+MrEb066FC0IT3yiKDtnCpF8CoBsWT5DD+bmaC1GrxeFjTL+KN8lFmm0FAWCzQgmAyvsE7BvQniUBpDieSg5s5mRJy6OWKo7jQkVzdHU1vftZsybe/uKBxFlII5W7sTOOwUSyRSvT7pekLTocIgplcCI/sejFpvgdK/N9NA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712927651; c=relaxed/simple;
	bh=PUTvlT9riZ19owzSi9HVU/vZE2mXRfMn0J3ryH6SxWA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=SpMxcoZ2sLlf0FWbX0QGytAqLw/axeux958Y5L8/WqRvYvoL/jQ4Y4furasEOxdQ9hc6gfVok8mmCA7eXPOAQIXUM/zXcuzkM4Eh4B/ZvE4GWRAkD68URSS1QHWebgwEZW3BAyZ3GKmqsu7lHrl3X3U58oBE9YsaoliFYNXAXTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LnXkro7h; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LnXkro7h"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4180c6a60baso1943265e9.0
        for <linux-serial@vger.kernel.org>; Fri, 12 Apr 2024 06:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712927649; x=1713532449; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aKIKmBiM6jcwJEcZrg6LHG0d6Eum207+g4jW0WFBkI4=;
        b=LnXkro7hgw6SfUCEgnNonw5ZMrQDi4FGzC9ksXOwG6PTr5DUNyrLgZUjwfZhIPOix0
         bJAsOOKZRx7r72hgbel1vK7AVg6OuBu9tOD9RM3piCB7eBft/rlqaDKezZEaAyv0Z+Ix
         HWlh48KE8I1KNIxgcEZcsQLbiuuaoQu9Sp7Wk/7tXPpgn5LLGLAprTAXxbA990yJFk6P
         GYvlYg9B/zT0apqJUwb3JrIkiXF+s3Ebt+VmccbgDlnO9MuhWjKPE32CDn6fn7qkFYAo
         NeL0IJGlgtTea0g0ChgO4hYkOMeUxFabRYre0oUpxeuJ1crTURNbYG3XOWQZJcV4avHi
         kPow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712927649; x=1713532449;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aKIKmBiM6jcwJEcZrg6LHG0d6Eum207+g4jW0WFBkI4=;
        b=vtb8bim7ZgLwPUkMUhheDIMnQ1/Y7rwq7Tvc7oyHR/qY8AhLNrz0eP0oiiD4OthOTY
         q8/BkWZTQGjCkPvtAKTvAKwKYXOjUxiJuyyrHF1EBBxLiaOj7MO3mPrDB7qCSVBBPYGC
         CImEqfwkKyONqfstb93xb7TnG+46l+LfMGN5xTKfXwuFiKAilNiRwT6msgW48VvgbvVM
         MRJrtbiJdVcFltAteAcnir3lMUgyKXDkznkjOOUUjqwPz3nZ9o7ESSFTLYbEuhr3lZYh
         KZnMUFbb01InidENBxHD2+/P5P9uSb8ScRdLejUqI7nlMdZFAt8yAizoWLzMvaPop8Jo
         wlJA==
X-Forwarded-Encrypted: i=1; AJvYcCUsaTWKvMY204QSyK0IPrvITH7FfDxy/kbV+D2fWUP6LZSOeXqiROTZ+O2kfet0VU6U+MMT2V9qQPJ8D2KzTWgVyuRxP2F46RlJnt5F
X-Gm-Message-State: AOJu0YyUcc0ZIAM7mZKieaI5NhgRmWaBBo4BMkBV52y4IipBDrTcQWqw
	Wu4HzEWptDfdfQsJQfPKd9XVbGwEWFbcr2rEvtfFu2vZBx89c8E9IWqPzGJaNyE=
X-Google-Smtp-Source: AGHT+IEqWFd+QuLDbJcv6OTiLAWvUCIGZ2gJlq/aV9qLhe8ioHcLstnAVYQDw4b9SFeb9RuTfwe69Q==
X-Received: by 2002:a05:600c:4510:b0:417:f58a:57e with SMTP id t16-20020a05600c451000b00417f58a057emr1582523wmo.0.1712927648621;
        Fri, 12 Apr 2024 06:14:08 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id n3-20020a05600c4f8300b0041627ab1554sm8826376wmq.22.2024.04.12.06.14.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 06:14:08 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Jerome Brunet <jbrunet@baylibre.com>, Kevin Hilman <khilman@baylibre.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Xianwei Zhao <xianwei.zhao@amlogic.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, 
 linux-serial@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20240401-basic_dt-v3-0-cb29ae1c16da@amlogic.com>
References: <20240401-basic_dt-v3-0-cb29ae1c16da@amlogic.com>
Subject: Re: [PATCH v3 0/5] Baisc devicetree support for Amlogic A4 and A5
Message-Id: <171292764771.2837390.2489661650748373215.b4-ty@linaro.org>
Date: Fri, 12 Apr 2024 15:14:07 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.4

Hi,

On Mon, 01 Apr 2024 18:10:48 +0800, Xianwei Zhao wrote:
> Amlogic A4 and A5 are application processors designed for smart audio
> and IoT applications.
> 
> Add the new A4 SoC/board device tree bindings.
> 
> Add the new A5 SoC/board device tree bindings.
> 
> [...]

Thanks, Applied to https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git (v6.10/arm64-dt)

[1/5] dt-bindings: arm: amlogic: add A4 support
      https://git.kernel.org/amlogic/c/8b8e6e24eca07efb4860c97aa773dd36fa3a1164
[2/5] dt-bindings: arm: amlogic: add A5 support
      https://git.kernel.org/amlogic/c/7e05175cb7be232450e70fe75ba2a852947eecc8
[3/5] dt-bindings: serial: amlogic,meson-uart: Add compatible string for A4
      https://git.kernel.org/amlogic/c/a652d67a84575e09b52614a2f81399772d52876b
[4/5] arm64: dts: add support for A4 based Amlogic BA400
      https://git.kernel.org/amlogic/c/6ef63301fa37087414342269bc02a2a930e81779
[5/5] arm64: dts: add support for A5 based Amlogic AV400
      https://git.kernel.org/amlogic/c/a654af36fe8b54e360fcf155b785df3aa0eab73e

These changes has been applied on the intermediate git tree [1].

The v6.10/arm64-dt branch will then be sent via a formal Pull Request to the Linux SoC maintainers
for inclusion in their intermediate git branches in order to be sent to Linus during
the next merge window, or sooner if it's a set of fixes.

In the cases of fixes, those will be merged in the current release candidate
kernel and as soon they appear on the Linux master branch they will be
backported to the previous Stable and Long-Stable kernels [2].

The intermediate git branches are merged daily in the linux-next tree [3],
people are encouraged testing these pre-release kernels and report issues on the
relevant mailing-lists.

If problems are discovered on those changes, please submit a signed-off-by revert
patch followed by a corrective changeset.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git
[2] https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
[3] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git

-- 
Neil

