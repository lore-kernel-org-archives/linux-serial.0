Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 302674B1E7B;
	Tue,  6 May 2025 22:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746571521; cv=none; b=iz7N8xRaL14PlHFsuy9Ak55c9WR5z6CirTPb1Mv5PT/6vSaoxNgZABIjJRMOA42SA+ZvL08sM67LBe/uvQFbEN6mmHFb7+pg0JaNGVRuNKP6adi4aHxUvYZ3rIX58XXyQT19PLDwDA/Wj0tLupdnOCKng4tqD31ZKlpTDRVeG1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746571521; c=relaxed/simple;
	bh=1dvlnqYsecpUo9pwUMnCVzZ/m+Jv+YQscZRphjofhN4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=soPdc8ahljzLSZjSYJoRVl1Kr4f59cWo7eBukVCoC1FCq+EJCjFi7MU3/fJ3Kl2Gfy22hy9UgU5MrJKYvgnRPAk17kOwHblQc3rHLoD9wd3tusrDS/21P/HDE6GzEO+ukdCGYOOyklr0dM5OPandpwTVdml/BjaukSGdTySHLJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fjVyPuq4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fjVyPuq4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5C82C4CEEF;
	Tue,  6 May 2025 22:45:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746571519;
	bh=1dvlnqYsecpUo9pwUMnCVzZ/m+Jv+YQscZRphjofhN4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=fjVyPuq4XKL3s9VatmaT0mMpeD3eZlMCpntqD0JThWu/Xw/EXm8uqFcGFPXiRJbnd
	 I1/66bfMU4+b8mySYP9GJfQBS8MU+adCgGk/GscaEEop7k0a0fiektJwQT/8SJLr1J
	 LUxjPVHSprwXA6kl9sj7k3ber9oSdNPFLeRvlHwtg+akN8A2QbiVGYISaUC3sQhvXu
	 3m2Aj/JeGkBsSFYvzaXggtyrJz8AiyObfNuzqVtj6jEVORxhFNg7amsbV5GM8MPLcV
	 ACJA1JoSijFpc7iqpfP1wpQE8LWd9KrlVgZFyrAQcQ5iW7gGwNwhycrPnc6fWkbV3Y
	 It4DUXxdRJrwA==
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5f4ca707e31so10032586a12.2;
        Tue, 06 May 2025 15:45:19 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVe3x3YxJF2ah6kOoq/S5Mzw+h1OiSzTmuUZ3cEzrUR8c3yluPKoHD6XunO966iyNQqsjSu+jaHqVh/oyZw@vger.kernel.org, AJvYcCVqFRlR6iK8pgXidUWTPvci0hniaBur6RaX8pLPRGKEc13J24JWqxstDvmu3/3SB/Cvq1SnXvEzOQa7dlfF@vger.kernel.org, AJvYcCXi0YJuhAtJFM+QkKgcmOdJm8GNJI/5I+RRF08h6tKCwFULISu6RnbDJ2O25AT8HZolBbc1U2+Ym/27@vger.kernel.org
X-Gm-Message-State: AOJu0YwJg0ihtWR4W9vDqsMce6keN4NmMdxY4NhNG/xs38QyejPWWtud
	Oa8dNTp937LjJaOfAVw1vgJALnKxzeDfOhVSbF+ytczwnSJViueWwsi3d8sS/kH9GCFhwf9WZj+
	cXT8LUjrCL5XQqri/SWp9LhVcXQ==
X-Google-Smtp-Source: AGHT+IGM3HfyPBRSSoNpCu9csErC2rnv60HCqPbdFjrsw9xOdMGNTWOymyb3x+Dvi7cgeDRWJfU56lfe8iJhazULcJM=
X-Received: by 2002:a05:6402:35c3:b0:5f4:d4e7:3c37 with SMTP id
 4fb4d7f45d1cf-5fbe9d47899mr799186a12.6.1746571518264; Tue, 06 May 2025
 15:45:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250506220044.2546706-1-robh@kernel.org> <20250506221751.t3iwqquzjgysjaai@pali>
In-Reply-To: <20250506221751.t3iwqquzjgysjaai@pali>
From: Rob Herring <robh@kernel.org>
Date: Tue, 6 May 2025 17:45:06 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+T-NZE1--VN7J2c5GbpG8d4nWpfceKE=ZGg3wfXn5iFQ@mail.gmail.com>
X-Gm-Features: ATxdqUFiJ50th5PWc3bVyidIL9UXE1B-QZu3aTbehYousZMT6MMcxddc8PgW7yk
Message-ID: <CAL_Jsq+T-NZE1--VN7J2c5GbpG8d4nWpfceKE=ZGg3wfXn5iFQ@mail.gmail.com>
Subject: Re: [PATCH] irq-names dt-bindings: serial: Convert
 marvell,armada-3700-uart to DT schema
To: =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 6, 2025 at 5:17=E2=80=AFPM Pali Roh=C3=A1r <pali@kernel.org> wr=
ote:
>
> On Tuesday 06 May 2025 17:00:41 Rob Herring (Arm) wrote:
> > Convert the Marvell Armada-3700 UART binding to DT schema. It is a
> > straight-forward conversion.
> >
> > Drop the long deprecated single interrupt support.
> >
> > Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> > ---
> >  .../serial/marvell,armada-3700-uart.yaml      | 102 ++++++++++++++++++
> >  .../devicetree/bindings/serial/mvebu-uart.txt |  56 ----------
> >  MAINTAINERS                                   |   2 +-
> >  3 files changed, 103 insertions(+), 57 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/serial/marvell,ar=
mada-3700-uart.yaml
> >  delete mode 100644 Documentation/devicetree/bindings/serial/mvebu-uart=
.txt
> >
> > diff --git a/Documentation/devicetree/bindings/serial/marvell,armada-37=
00-uart.yaml b/Documentation/devicetree/bindings/serial/marvell,armada-3700=
-uart.yaml
> > new file mode 100644
> > index 000000000000..fa454337f06f
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/serial/marvell,armada-3700-uart=
.yaml
> > @@ -0,0 +1,102 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/serial/marvell,armada-3700-uart.yam=
l#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Marvell Armada-3700 UART
> > +
> > +maintainers:
> > +  - Pali Roh=C3=A1r <pali@kernel.org>
> > +
> > +description:
> > +  Marvell UART is a non standard UART used in some of Marvell EBU SoCs=
 (e.g.
> > +  Armada-3700).
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - marvell,armada-3700-uart
> > +      - marvell,armada-3700-uart-ext
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  clocks:
> > +    maxItems: 1
> > +    description:
> > +      UART reference clock used to derive the baud rate. If absent, on=
ly fixed
> > +      baud rate from the bootloader is supported.
> > +
> > +  interrupts:
> > +    minItems: 2
> > +    items:
> > +      - description: UART sum interrupt (deprecated single-element for=
m)
> > +      - description: UART TX interrupt
> > +      - description: UART RX interrupt
>
> I think that this is wrong description and does not match the old txt
> description:

It's correct that a single irq entry is deprecated, but I did say I
dropped that. So "(deprecated single-element form)" should be dropped
here.

> - Must contain three elements for the standard variant of the IP
>   (marvell,armada-3700-uart): "uart-sum", "uart-tx" and "uart-rx",
>
> - Must contain two elements for the extended variant of the IP
>   (marvell,armada-3700-uart-ext): "uart-tx" and "uart-rx",

Note that the descriptions don't really match this either. Expressing
it correctly makes the schema worse (using a oneOf) and doesn't
improve validation. We have interrupt-names correct, so I think it is
fine.

Really, no one has cared for 6 years about this binding and converting
it, so I'm not going to spend a lot of time worrying about
descriptions. There's a 1000 more to do.

Rob
