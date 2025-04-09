Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 939F9265CC6;
	Wed,  9 Apr 2025 14:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744207853; cv=none; b=tzyCFUplbLHIB4RDmvQ+B8v0SYGhVwHpVCd8+H+u4tVjf6zLgQ2/u9Dodcp1xcasiVsj0LZqQBA06nUvZZ/ckn3scUWnxbgezGEtpJ7DwvCIam2CL1LA1+jdfF56I3dEIu3UdQqbHMOnoVAeaTlOOwScdozuwIU9uxX/1wuucSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744207853; c=relaxed/simple;
	bh=9r+hfE4G4mzURHbeG13RO9+itg1f/MqJ7SPDPOqmrW4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hU8UAOHzufECRlTSQ1IpP+WSb1oxQrhm869N6P9zq0t6XhN2eXmsTgf+oaIOrcMB0NdkcuX38yZLd2PWtMp9dV7D3Hk3xgvh4KFHhkzv1tBlWcfg1jFoLh7wT03u05ve/ZbYCfDE1nHg/hOs77w4zWU3Ni1pCfnGdZkmlHWkQSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=crGOEGef; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="crGOEGef"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D672C4CEE7;
	Wed,  9 Apr 2025 14:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744207853;
	bh=9r+hfE4G4mzURHbeG13RO9+itg1f/MqJ7SPDPOqmrW4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=crGOEGefQdmmOLRwpofhRrCIbzkcJbpjA45ig1MmpfHv2S/5eqv/WtUCxYiTMTldP
	 gOxHDi6q+flZoBHwxCZEw0PcJxaXIep4Q0IJwfLFMrUiL53ZSwJ3/auSNQl3EhHgp/
	 ofncARZ2JA7FaExCLA3OUzu6dym4MAn7G6sgySYiEOwEJ8wj2lcyVC8/Q8l6OWj8Yh
	 uRjZDbcxjUBqh4j9J80caKajhexf3DuRty7MzS04u1tEk8T57z4K0hEz4vdIUFukyZ
	 Cl/eYGPb7tuWCBZmMQwC+agbpUZK7KHuV0lWWAdMj4xxyv81czuUazzgpJxLF8ZeQX
	 Av5e/q1Hv22hw==
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ac6ed4ab410so1102647966b.1;
        Wed, 09 Apr 2025 07:10:52 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUUUO+OYP4eFpP960ubusUi/QMwLb4VDjq7ApT8Axg9qsZQ5gGIX5Hgq3zaoPHtRhsQtH0f9U/N6LOQ@vger.kernel.org, AJvYcCV2GlfcvRA5t92yQ5JUVzyrL1MZGHvkexpOrriJa928fgARFs76kSx5oMTdRw0sAO+BAiuH6MOomfFC5CgF@vger.kernel.org, AJvYcCWIDvJTz76Jl3FwjuxqcK6ypiB5nwGeptmGYqxwgddwxG9Z4jDHVzuAGKVRXPlgX/3QTQJ31HyHj8um7rDP@vger.kernel.org
X-Gm-Message-State: AOJu0YzzfAn+q+GLo9zYPIJWp1YKDknw/LAhoN4Lo0RAb1HOCuncksWU
	6OGYQ1YuOgWpxTr96FX8CyOUXZ6Jd+BhAMuRfzwzk3cgpoz3l9VL8aY4lVoY56cMkjBwlbEd56V
	bfl8kVpdACHhGpUwyTwMrkGvCnA==
X-Google-Smtp-Source: AGHT+IFEtTYjccs7j7godwPNRU8sGRR9JZWF8arZz5D8qHhS7R7QewH27wXjN4KGo06Cp8HIaFsR81SPvgM4slLDwNI=
X-Received: by 2002:a17:906:e87:b0:ac1:fb27:d3a2 with SMTP id
 a640c23a62f3a-aca9d5cedebmr238898066b.5.1744207851406; Wed, 09 Apr 2025
 07:10:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250408175146.979557-1-elder@riscstar.com> <20250408175146.979557-2-elder@riscstar.com>
In-Reply-To: <20250408175146.979557-2-elder@riscstar.com>
From: Rob Herring <robh@kernel.org>
Date: Wed, 9 Apr 2025 09:10:39 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+uhgrVJuPv_R9BVKUvwU44sGa9Y2rQRWB=Z4BhLssoGA@mail.gmail.com>
X-Gm-Features: ATxdqUHTUtH_Ek2NxCLyM1van91iQAybwsmA9SF-PSPIdBng-DZUbJNyEEEwP1s
Message-ID: <CAL_Jsq+uhgrVJuPv_R9BVKUvwU44sGa9Y2rQRWB=Z4BhLssoGA@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: serial: 8250: support an optional second clock
To: Alex Elder <elder@riscstar.com>
Cc: krzk+dt@kernel.org, conor+dt@kernel.org, gregkh@linuxfoundation.org, 
	jirislaby@kernel.org, benjamin.larsson@genexis.eu, 
	bastien.curutchet@bootlin.com, andriy.shevchenko@linux.intel.com, 
	u.kleine-koenig@baylibre.com, lkundrak@v3.sk, devicetree@vger.kernel.org, 
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 8, 2025 at 12:51=E2=80=AFPM Alex Elder <elder@riscstar.com> wro=
te:
>
> The SpacemiT UART driver requires a bus clock to be enabled in addition
> to the primary function clock.  Add the option to specify two clocks
> for an 8250-compatible UART, named "core" and "bus".

This should be conditional on the compatible associated with 2 clocks.

>
> Signed-off-by: Alex Elder <elder@riscstar.com>
> ---
>  Documentation/devicetree/bindings/serial/8250.yaml | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/serial/8250.yaml b/Documen=
tation/devicetree/bindings/serial/8250.yaml
> index dc0d52920575f..1adf935b7f36f 100644
> --- a/Documentation/devicetree/bindings/serial/8250.yaml
> +++ b/Documentation/devicetree/bindings/serial/8250.yaml
> @@ -135,7 +135,11 @@ properties:
>    clock-frequency: true
>
>    clocks:
> -    maxItems: 1
> +    oneOf:
> +      - maxItems: 1
> +      - items:
> +          - const: core
> +          - const: bus

'clocks' does not take string values. You want:

minItems: 1
items:
  - description: ...
  - description: ...

Then an if/then schema with 'minItems: 2' for spacemit and 'maxItems:
1' for everyone else.
