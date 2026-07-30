Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C1A84779AA
	for <linux-serial@vger.kernel.org>; Thu, 30 Jul 2026 23:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785454419; cv=none; b=oXW2lkxjvLxJPu5JVuZ5Uv46pEoYM6kyXEOYHmPmP69+c2RDAocU2HMCBUEXUi3plu6uX94YnZNHzxXxp9+Vwymf2wxh0TVlCxNTwBlBFWSi1v9Tmhw/AgVJX/Ect/P+/p5rWOr1mWPAiR4E0+3ABn7/GqdqUa3Nnz3ucTKWvyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785454419; c=relaxed/simple;
	bh=GPZxIJ12NCdT32FLt89aeHS/XUCWgFohujxo0l4BvtQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n792xdNHr9ZKjA4fZEAp7zE6otuar6C5AmEccYDdSA2fRPtQI7G+OxfJIwIJsDRdKKt7iZ2ft0+97zLPs22LQpewbUV9qyusu93+Tf7rf23ymhbnW/LWWUSzCgMc72P4jfW0L5sWEaZI5hJ8+6eARS4ftyOTZYjvUg/BpDNZwU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=E3V5dqCt; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="E3V5dqCt"
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-5bf83925ddaso179448e0c.1
        for <linux-serial@vger.kernel.org>; Thu, 30 Jul 2026 16:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1785454417; x=1786059217; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1swx6ZS7vRHB6s/IgYx4mgkiMyCPAEEjNZGLF7mxwyE=;
        b=E3V5dqCt/Ln7Nm69H6cIZugVC02Rkjjx7HfvXAOG58sWLk9G4QiOIxkWtcyTt4M+zL
         I8xlXGl7dKBpZM/NO42yNyCvjuynsguT5q/5MGYFBBgRI+GOg4eADgUiyT90xVrVW5kL
         uk42+Vy3YsLxezLpxPT2Qm1Nxl+S4N/yuGJww=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785454417; x=1786059217;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1swx6ZS7vRHB6s/IgYx4mgkiMyCPAEEjNZGLF7mxwyE=;
        b=kjU/SydkomOI/VfVZymFwtVICtUQWyUwffuRY5okaTtVUDC5jBnw7mzkM0dt1vag25
         LQolo/M5fnWdAx2wP3Mn8MvlrhdTLkvxZE56h7cKMRSHNyoliFyFi1dTPkDjRQpOuPpM
         NgVyKg5UgtEZMb/G11dzlWyCBVw7QMCfsOvyLvsmn5RHw8BulwICc8QebULVNr+eu7Ir
         4O9PMgN2t7G39ZaM5Ptu+eAHaDVz8GiKOAf2isu9zaQVofPdbVC3nbe2pRQYiVWCSRAY
         X5sn6kV0o69fj5k7gNw909j2MMK8lLbxep2Kfj4YOayN8PEnS1CJZeEjwdUr8PIbTyQh
         hD7w==
X-Forwarded-Encrypted: i=1; AHgh+RoCLLaos2/SbUesAXU7HyyQgWQDoQ59SQKaopQ+vCWY/emq8K3ZNXxU/J6DYWyRcDyfKfSVVq4GzjjViXg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbuLkkjTJtOlxqCrr61jKgYxvsy79pdBoYkAxF5n05QcZo2SKs
	dvBCM8BpZGjx3LGci6XYf0qYgbpPRsyK6JNzVegqfQry09XdZQwrfbIpfJGpKyfxW2ddgjU8V+C
	7yQk=
X-Gm-Gg: AR+sD11jWvfFlRF4nQEYr1cXNhw2mGg3zXpzzlQ+0DrZROp8crbVqO0UmC6SCkDLlcb
	B6XJ9d5gJPFqqGsEWbEW311f+JfRfsVLfXo/GpHFEs/gmYWkJ3mM/AUYlvMBrADJ0PTEPnZriQR
	TM1KGNsCwvdveKBv83ybhhuGJ/9cMvfitT25CWQBJnczlmJHxlsRQtIlC/sZG7vLW8n7CrP8KAG
	k1NCm+WVggiyHJ9wWvqDZ0RJimVyOZPvd7ArpWp/vNg803GTewJAHQvFAvNPmLjDmMpW0HR+VxK
	2Jm9QeE+JdATEUX9QX2PO2JdM+vaHRfoHLPpZQJOukh07cSnfxHkB2EANvwMx9iHHJ2sfhPgYIc
	wkQ1fFJQdU5dLC1EX42z30drwRPr5djjJXyDjCUDitPsDRO8S1SlzpiTe056u8XbUMHEsopdKJr
	kazidi2EEpMauZOifCxfDm4fI/pX0YMvUzClgkqEVluuY/1ChUVn39aEctIt5fTNSI6Tl+JUojk
	qWsliGwV1uPZ7RBpDg0nvc9wS3h7/4/V0Qs1SY=
X-Received: by 2002:a05:6122:20a3:b0:5bd:9dbd:60bb with SMTP id 71dfb90a1353d-5c366199ce2mr1478731e0c.9.1785454417025;
        Thu, 30 Jul 2026 16:33:37 -0700 (PDT)
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com. [209.85.222.50])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c3662af7b8sm2762319e0c.0.2026.07.30.16.33.35
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jul 2026 16:33:35 -0700 (PDT)
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-969524c1aefso89655241.3
        for <linux-serial@vger.kernel.org>; Thu, 30 Jul 2026 16:33:35 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RpglO6uSKSgwajKQyijXl6AMhCzrYOd3Psej+JVh/ZPkv4Wi1olmyyK9CwPc96opqcoAnbHEoJd/rCfvvc=@vger.kernel.org
X-Received: by 2002:a05:6102:3592:b0:608:9a34:c8ea with SMTP id
 ada2fe7eead31-7574e6d1a1amr1650546137.10.1785454414391; Thu, 30 Jul 2026
 16:33:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260722-contrib-pg-pixel10-initial-dts-v2-0-3abae9717feb@linaro.org>
 <20260722-contrib-pg-pixel10-initial-dts-v2-1-3abae9717feb@linaro.org>
In-Reply-To: <20260722-contrib-pg-pixel10-initial-dts-v2-1-3abae9717feb@linaro.org>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 30 Jul 2026 16:33:22 -0700
X-Gmail-Original-Message-ID: <CAD=FV=X32DiN2X26AutA97cpmywW9C3-76p-crT8sSQ+XqZNZw@mail.gmail.com>
X-Gm-Features: AUfX_mwLrAK1Nx-rPTyOqhPQSXAd6QqwkRvKOTa5fFmS8RMZbaeNFVMG8HEBq6M
Message-ID: <CAD=FV=X32DiN2X26AutA97cpmywW9C3-76p-crT8sSQ+XqZNZw@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] dt-bindings: arm: google: Add dt bindings for frankel/blazer/mustang
To: Peter Griffin <peter.griffin@linaro.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
	Tudor Ambarus <tudor.ambarus@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Krzysztof Kozlowski <krzk@kernel.org>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Linus Walleij <linusw@kernel.org>, 
	Drew Fustini <fustini@kernel.org>, Kees Cook <kees@kernel.org>, Tony Luck <tony.luck@intel.com>, 
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org, 
	soc@lists.linux.dev, Juan Yescas <jyescas@google.com>, RD Babiera <rdbabiera@google.com>, 
	Brian Norris <briannorris@google.com>, William McVicker <willmcvicker@google.com>, 
	kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jul 22, 2026 at 2:56=E2=80=AFAM Peter Griffin <peter.griffin@linaro=
.org> wrote:
>
> -  # Bootloader requires empty ect node to be present
> +      # Google Tensor G5 AKA lga (laguna) SoC and boards
> +      - description:
> +          Google Pixel 10, 10 Pro, 10 Pro XL (Frankel, Blazer,
> +          Mustang).
> +        items:
> +          - enum:
> +              - google,lga-blazer
> +              - google,lga-frankel
> +              - google,lga-mustang
> +          - const: google,lga

I'm not sure I really want to make a big stink here since I'm
certainly interested in getting something landed. That being said, I
at least want to ask about the "google,lga" entry in the above
snippet. "google,lga" represents the SoC and I don't think that's
technically required in the top-level compatible string.

I had a previous email about this that essentially went nowhere [1],
but I'm hoping to continue the discussion (along with other similar
topics) and Plumbers. The essence of the question is: how much data do
we really want to jam into the top-level compatible string, and is the
top-level compatible string truly the best place to indicate which SoC
is present in the system? While many boards put the SoC here, I don't
think anything in the DT spec requires it, and I'm hoping that we can
stop doing it for new boards. When/if we need the SoC info in the
device tree, it seems like we could put it somewhere better...

[1] https://lore.kernel.org/r/CAD=3DFV=3DW+jE_L_LLgAhD8K_4+CtivSD9-9t7Xe63X=
uKrKjfyfeQ@mail.gmail.com/
