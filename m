Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44AEC65F;
	Thu, 13 Jun 2024 05:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718255634; cv=none; b=BNGEhOOBRPH00d/YN3ABA9Ajw3EA6FmR4KNMkfvplSSRvwQ+SJEGuIcDSW9R9FRhts5UWIB8OrXq1s9fSYa+9XgB9YfV/W3aC2NP3FSKqhYwZw0M6nuai6TTXGv+SGZ7yzB7qCE2NzoXYBawA/uSbVm8HFJyamniUq/hVQX+124=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718255634; c=relaxed/simple;
	bh=Yz59tQWkv01hPFKbE+8vks+JGjl0tcpj9w+w7TTxogs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z0TcoLay26tiXVqAyiwTld09JeLR8Qzd65WFMXH3ymTCk3/vuR6yfjSVJhDJFKaouVMrPc/OJOMJclHyGW5QwDrcPdKH70dw5R3yJ5CiVctX48JflHPu1pVq6yqHzr4dnGZYPg2kj5Oc473miB/OQj6AWpKXCcRTwFTb2CLSrZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YU9mD4LL; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YU9mD4LL"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6b060f0f48aso3197876d6.1;
        Wed, 12 Jun 2024 22:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718255632; x=1718860432; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yz59tQWkv01hPFKbE+8vks+JGjl0tcpj9w+w7TTxogs=;
        b=YU9mD4LLt6UIUM1lxf5T6eYhLWuIZBFi0MG5HODfbmCFB2Ts5UbJdT6OxhN1uoLaZA
         DXhvMhH01ST5YS0UWlCRyuBymgvNfInBBdyGkSKaqgGeNaNFA0locz0blJ7v8ChUmwjd
         5d+3pn4n1iIAYIeRwqGASXUzj0r6iTRXbHgf7+urTc+q6197wun0ak2rzO5i8UV1LZFu
         vjYAIGqs5oFqldbKUXsSTFwgxzCuQdp8a8jb3ldVGOxH+4Qq3sDUOQVjrKYCPSYrPaUs
         QbJrhJbyQSg4JmsVQfOnhNwX4Yq+4LAe480gMQF9GgdcXVPg3fYDygvFBpWpw1zgCRPn
         RVbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718255632; x=1718860432;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yz59tQWkv01hPFKbE+8vks+JGjl0tcpj9w+w7TTxogs=;
        b=NZlZsvF8vtVGcAXrgzh5B1Mao6DyDTLsgWmYGt2Wprgx9HdwFjKBTqp9hs1/I52+sD
         OKmFnAIyd70vXS9rKTaWyUsjBDl9CC+mpd9/YzklPRI7eJcniEOL4tgubJaXuSleGrHb
         sjzjDCotTfOpOT36GM9GDMQ5krFaFyw3j9P79MObZKPWXD+Q/dfnTbuJg+YMzTML4ZH3
         gCOySu/AShraJJyPiUYoMrOxxF/Epw0mG1A7i5VyTke30QSizs4nRE+3DOruSmdBmo22
         vnKaQad1PSNsFgwQBrSg1xUzfaGRB1d04suhhFLXidz5/PLoSwmbyYF/RH2TltmpwXJD
         GrDg==
X-Forwarded-Encrypted: i=1; AJvYcCX2s0jOtA6WSLpfdKedPEtPSCPFVP/l4pK0u+AlwamaxujizCFWl1kKFr/uljGx8WSnSMtsuTjoww73el6QK9SsJ+vHjWeIgH3wYEi8UYGdYiHae69rarZ/U63WGlIHirL+1tZU2E2VjsHpTJqYdSFNUftzWnBKvTKlcGqRGgxuqZocGSGQiw==
X-Gm-Message-State: AOJu0YwfwviU4GBlyrs4nQ1huUjNgtQ4zsgxIFldbOhvJWbQv/MXbxq1
	SMqhqDSDHt81bxXCEJGnhNG411pqLmmEzrpLdV56KQcH3YngF3Ecsx6fD+zEq9Iu4DsCLjcX4vP
	SakbedZ/a1OATORBBPbpkoYLa/uGz+KNA87Yimg==
X-Google-Smtp-Source: AGHT+IGA/60BeVBcSGOZs2ZPs2s0isSjEHC6dloesC4nDItXtIqTS5fn0q30oP5yguqs2uRGIDtioTO6gpNUkOcindI=
X-Received: by 2002:a05:6214:4688:b0:6b0:6d9c:8eb6 with SMTP id
 6a1803df08f44-6b1b5c0afedmr48758286d6.58.1718255632046; Wed, 12 Jun 2024
 22:13:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240612153847.52647-2-kanakshilledar@gmail.com>
In-Reply-To: <20240612153847.52647-2-kanakshilledar@gmail.com>
From: Alexey Charkov <alchark@gmail.com>
Date: Thu, 13 Jun 2024 09:13:40 +0400
Message-ID: <CABjd4YxqDkrcZw2_mp6sXkhXndRcODHoA2tCLLqP0ernojV6GQ@mail.gmail.com>
Subject: Re: [PATCH v3] dt-bindings: serial: vt8500-uart: convert to json-schema
To: Kanak Shilledar <kanakshilledar@gmail.com>
Cc: kanakshilledar111@protonmail.com, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kanak,

Thank you for reworking this one.

On Wed, Jun 12, 2024 at 7:39=E2=80=AFPM Kanak Shilledar
<kanakshilledar@gmail.com> wrote:
>
> Convert the VIA VT8500 and WonderMedia WM8xxx UART Controller to
> newer DT schema. Created DT schema based on the .txt file which had
> `compatible`, `reg`, `interrupts` and `clocks` as required properties.
>
> Additions to the original binding
> - changed the file name from vt8500-uart to via,vt8500-uart.yaml
> - removed unnecessary alias from the example.
>
> Signed-off-by: Kanak Shilledar <kanakshilledar@gmail.com>

Acked-by: Alexey Charkov <alchark@gmail.com>

Best regards,
Alexey
