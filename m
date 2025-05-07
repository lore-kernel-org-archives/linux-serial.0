Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46990289346;
	Wed,  7 May 2025 14:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746629258; cv=none; b=Nmcr6XztYyiSYGLl9R4h1n+YbEj+WILO5Gq3YYWsWrWz64YYCD8cLn+eueT/Z1amKnA8meQBP15x9peiKb3QwjrxmDDHLfUQPQL95FTdlQ/kWMc/PPEwgfjUd+mv8L8OO6e3KPUGgwyXEohhUaOCFzjaRUokLVus++VlxQaNTOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746629258; c=relaxed/simple;
	bh=7kf2ALq9/Fo9sH2dq1oJJwydVs2ruWu/GnwJukTPrac=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bbpMGFBSc+SoOPc6oHcJ2C0bsndopmvoRXpRrekklnsv8Tdhh6ji4qA/GN+O2lGN9CEvGDWqHYf4wGbn6BgcsdOTSbEQPx/qJfPEjWRLZFhTKAeo+PyTYnpSFKH3FPEaYyy7GK72jJMvf4rISe8/Ff9GXirlJseMFAOAfdh3gZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XvkEeIsP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XvkEeIsP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB735C4CEEB;
	Wed,  7 May 2025 14:47:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746629257;
	bh=7kf2ALq9/Fo9sH2dq1oJJwydVs2ruWu/GnwJukTPrac=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=XvkEeIsPB5Ry0v4pb6qPVXaZKm2OARrRn6akiFVoR2mM2spnElojN6bKMmbmuVt+s
	 roHfv02ImJBJuNFoDtnx460x5jPj6zNQLFDiWpeYGivmJMl3eQvqCp4tcvdf7s03jA
	 v6tptasGSchNEpItgc6LfuKEsLgdS9zOg5m239AHAVJit0U/Mwxd7uEDiFIRG9hULs
	 iKDX2/o6/5lDLC1ybEr9c7RYgzrIkbMINyww7ly+TzP8kL2s6ZigZFOTEYEdFLG6Yc
	 5UjpiOWy/azRbV3ytP2WoTA6DmCflg5egCtM7uMn2nC4LA2QMVj65BzI8OMmiI68Au
	 UJTrEqbH3O9cQ==
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5e5e8274a74so10764729a12.1;
        Wed, 07 May 2025 07:47:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWZFUqCWyRPJc6qqgfPpFmrFOyI3ni/4WjQ0w3rOHr2m6Kx1IuuqLzNoBeK3SGrZhhDfEhjhcaPfZIfgLa3@vger.kernel.org, AJvYcCXmgV3VgxRB3e3v6hM8swPEB4xz0PH9b7v4pTL5JLmjlRcxKQLcZnRvMO4yFYA+Sw34PQTM5/Z9EC9/@vger.kernel.org
X-Gm-Message-State: AOJu0YzsXy8MKGmR7LRVP27YObecpONLpe9ho0VFIXoDNIkhROYiax5X
	KX6JbV5VnLY6pdj3nbHBHxgy3FDzIub7ZcN3TyoDQHeveXIwMVHaCdHLAJgHFqXUoAP/6esZXHf
	OzvIIolguyFnVjA4/O7Znl1DsVg==
X-Google-Smtp-Source: AGHT+IGQ6GxHlslTwdOZh1gbDpgh+dYe27WpmXegpHd5DkVrMdkA8NZoCRZDzvSOBmaGdpd1/hZMGrQJ9el/C9neT10=
X-Received: by 2002:a17:906:6a1a:b0:ac7:16eb:8499 with SMTP id
 a640c23a62f3a-ad1e8befcc6mr361869866b.5.1746629256312; Wed, 07 May 2025
 07:47:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250506220038.2546557-1-robh@kernel.org>
In-Reply-To: <20250506220038.2546557-1-robh@kernel.org>
From: Rob Herring <robh@kernel.org>
Date: Wed, 7 May 2025 09:47:25 -0500
X-Gmail-Original-Message-ID: <CAL_JsqL9tN_9r8nNXFK0u=pn0z+vL6jbNttHiy0kUTLniAPXzQ@mail.gmail.com>
X-Gm-Features: ATxdqUEaSFPzBMpV3-DeUOiztY1d0UDv2l3fSDWeswYEdFW2Ok8r_aLfxDsvOy4
Message-ID: <CAL_JsqL9tN_9r8nNXFK0u=pn0z+vL6jbNttHiy0kUTLniAPXzQ@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: serial: Convert socionext,milbeaut-usio-uart
 to DT schema
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Taichi Sugaya <sugaya.taichi@socionext.com>, Takao Orito <orito.takao@socionext.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 6, 2025 at 5:00=E2=80=AFPM Rob Herring (Arm) <robh@kernel.org> =
wrote:
>
> Convert the Socionext Milbeaut UART binding to DT schema. It is a
> straight-forward conversion.
>
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>  .../bindings/serial/milbeaut-uart.txt         | 21 -------
>  .../serial/socionext,milbeaut-usio-uart.yaml  | 56 +++++++++++++++++++
>  2 files changed, 56 insertions(+), 21 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/serial/milbeaut-uar=
t.txt
>  create mode 100644 Documentation/devicetree/bindings/serial/socionext,mi=
lbeaut-usio-uart.yaml
>
> diff --git a/Documentation/devicetree/bindings/serial/milbeaut-uart.txt b=
/Documentation/devicetree/bindings/serial/milbeaut-uart.txt
> deleted file mode 100644
> index 3d2fb1a7ba94..000000000000
> --- a/Documentation/devicetree/bindings/serial/milbeaut-uart.txt
> +++ /dev/null
> @@ -1,21 +0,0 @@
> -Socionext Milbeaut UART controller
> -
> -Required properties:
> -- compatible: should be "socionext,milbeaut-usio-uart".
> -- reg: offset and length of the register set for the device.
> -- interrupts: two interrupts specifier.
> -- interrupt-names: should be "rx", "tx".
> -- clocks: phandle to the input clock.
> -
> -Optional properties:
> -- auto-flow-control: flow control enable.
> -
> -Example:
> -       usio1: usio_uart@1e700010 {
> -               compatible =3D "socionext,milbeaut-usio-uart";
> -               reg =3D <0x1e700010 0x10>;
> -               interrupts =3D <0 141 0x4>, <0 149 0x4>;
> -               interrupt-names =3D "rx", "tx";
> -               clocks =3D <&clk 2>;
> -               auto-flow-control;
> -       };
> diff --git a/Documentation/devicetree/bindings/serial/socionext,milbeaut-=
usio-uart.yaml b/Documentation/devicetree/bindings/serial/socionext,milbeau=
t-usio-uart.yaml
> new file mode 100644
> index 000000000000..37db6459b67a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/serial/socionext,milbeaut-usio-ua=
rt.yaml
> @@ -0,0 +1,56 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/socionext,milbeaut-usio-uart.yaml#

This is missing 'serial' in the path, so a v2 is coming.

The tooling didn't catch this as it doesn't know what the root
directory (bindings) is until a reference is used and the reference
checking happened to miss this case. I've now fixed that.

Rob
