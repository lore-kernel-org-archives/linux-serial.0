Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89C3829A0;
	Fri,  9 May 2025 15:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746804560; cv=none; b=ZuP+Q9qttNIFrWfUEWzrqXIptU/SvcBfwMEfG3WsDkX6lbd2FLbelPMYRc84uGu9jaABm6S/qxD3cidb4hEvd8+dZ7GVT6XMuosKLRJUCFqUeDIOnmqZwhIW5cTC2YOFFs13TTLwSOCkCv8B+24SSPIpwNttVC1ZCXDJWa8pHzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746804560; c=relaxed/simple;
	bh=u+Whabb4TQ+V1V2yliDhCWhKigIzzI/sTbPFTZHRF9E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lPerQ2uEusf95TGtoXfmgtc/nGFABglhlDkfLN/ak2OUsdzXrb3b2PgtNAI6lIGXUhMQGrWF+gIbeS+MHGfNqOU1ffPNRS0p87RudJEGK/w/C8aMQw4+gRFuS2Z3apMzFtyHzTM4UlbFhwcBBWngyuot6LB+8cP96rkgvaKUHoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Iuu3n4Uy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Iuu3n4Uy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFB2AC4CEED;
	Fri,  9 May 2025 15:29:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746804560;
	bh=u+Whabb4TQ+V1V2yliDhCWhKigIzzI/sTbPFTZHRF9E=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Iuu3n4Uyj9Btr+jAtfZQO2qjS0zZ7RvAv1/Ep7KZB1PHN+vV4+FOjUVtgkxDFd7nW
	 PvqhnTI3zFN4yCj4jYGc05jA6TjJnhGSaN+tBmwcpN+iBnBRlYuGBJpE56EKG6KWSC
	 oo/JzeXV/yajvU9K3qL6UaXLlhw5G0C8qF6ibeEUWzdJW0Ht1YdQy0uiJ6fCx1hpgK
	 yzc6pWnMbtHTNEc1jEOjW32Vj3yHka+rYotvt+YUdJrp63YXFHzNKAguZdD4uAMqM4
	 FE2jB20XFkgQaM4GpFofMJbRwfRV366gf1cy+5s6dQgjIahNBlif357qgPt94YruaW
	 fFKee0/9OzeCA==
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-ad1d1f57a01so418796166b.2;
        Fri, 09 May 2025 08:29:19 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVR8okQFuyIwHz9gzLSlEUnZG5GwXPEBgnFTFUnZ/fZWjFhM3fV8/qmNUN/xnO6rlEKxLRoikxCkNmGrG3B@vger.kernel.org, AJvYcCWVQ+ErfmvdpWt++L3L/uETJy5K5Z570wzhV/o0/EnD0IbYYcx53INtRGOmr/+WVsBPe6fieccDRLGn@vger.kernel.org, AJvYcCXJ7t7AqwXbco8gW53AkXEXMRnXrkwsKvjAZS0+sPsN5OBm8CldFmib2Q4fTiOwXHhDymEaLQgBHq7RXkLq@vger.kernel.org
X-Gm-Message-State: AOJu0YwWO9koIYV/pszS0VuCw1HvmdAwZS3JnVfhlQwySuyBGEUXezxv
	qreWWk/jbm1RMVt2YiEGYyFtOeRop2yZzUSIew78b2TjAUM/CT6qAHuw3e+qegi8dPX5iwXw244
	Km7tWSVu6NOV9L1wTWUF42WoEjA==
X-Google-Smtp-Source: AGHT+IFpczEUqnPNYIDG6QEN4AY6S+XPrH2ZeIjVtW3vGPBCT3ZbrywOOs0Ayv9anzhiuXSkFJbKCQ8a0cunW/1ogxI=
X-Received: by 2002:a17:906:34c1:b0:ad2:2b35:8f8b with SMTP id
 a640c23a62f3a-ad22b3592c8mr93912566b.23.1746804558571; Fri, 09 May 2025
 08:29:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250507154924.1602842-1-robh@kernel.org> <2025050935-suffocate-snazzy-c5f3@gregkh>
In-Reply-To: <2025050935-suffocate-snazzy-c5f3@gregkh>
From: Rob Herring <robh@kernel.org>
Date: Fri, 9 May 2025 10:29:07 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKjssqGOO6H9RCneo86fKop4bQtiKNcCq_95fOk2CP+eA@mail.gmail.com>
X-Gm-Features: AX0GCFvTiTZ5y8MxQ5bk6A7pgLq2QXkWvtig-fgmbVa_BSqfAAnHtSv9O7h6O8E
Message-ID: <CAL_JsqKjssqGOO6H9RCneo86fKop4bQtiKNcCq_95fOk2CP+eA@mail.gmail.com>
Subject: Re: [PATCH v2] dt-bindings: serial: Convert socionext,milbeaut-usio-uart
 to DT schema
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Taichi Sugaya <sugaya.taichi@socionext.com>, 
	Takao Orito <orito.takao@socionext.com>, Thierry Reding <treding@nvidia.com>, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 9, 2025 at 9:51=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Wed, May 07, 2025 at 10:49:22AM -0500, Rob Herring (Arm) wrote:
> > Convert the Socionext Milbeaut UART binding to DT schema. It is a
> > straight-forward conversion.
> >
> > Reviewed-by: Thierry Reding <treding@nvidia.com>
> > Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> > ---
> > v2:
> >  - Fix $id path
> > ---
> >  .../bindings/serial/milbeaut-uart.txt         | 21 -------
> >  .../serial/socionext,milbeaut-usio-uart.yaml  | 56 +++++++++++++++++++
> >  2 files changed, 56 insertions(+), 21 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/serial/milbeaut-u=
art.txt
> >  create mode 100644 Documentation/devicetree/bindings/serial/socionext,=
milbeaut-usio-uart.yaml
>
> Are you wanting all of these serial "convert to dt schema" patches to go
> through the tty/serial tree, or will you be taking them?  Either is fine
> with me, your choice.

You can take them. With all of them, we're done converting serial drivers!

Rob
