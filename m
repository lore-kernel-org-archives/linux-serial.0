Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10F112C181;
	Sun, 25 May 2025 02:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748141169; cv=none; b=DKJIJIrCUeTheq2q6uD4zZJKU/gKQK1WV1cmmBZGM0VF7f3KX1FjsQdBmrI+MfCd0+0CJkNpxdyqRdlnoGa8tmK+1UeLb/064oBkx/SswuzGGBF5A4qi8mALBC8/bqrtij09CSpEhDgSadOWammS8O9Ku32RTHW4fP/eoyDgHf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748141169; c=relaxed/simple;
	bh=OxlWYued1qwgYdzX737Wr2KjNkSsaqCH+6uEdTlEtzA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GYgoVIssFUIHDrVccNElQzpwwSHpk0NUUMxGYVq2kjBUEXxGG4poyMuB70sriq3H5C3ECieSyRgKErUQeeBtq4QzcZYYZ+b/p6ZEObse5K95jPwaMONxnCIuay9+wfV48aTuR6VXyEBBaacdrpbwi4AwQPSshl0uv2bDMc5Mcus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D/u7UQ0L; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D/u7UQ0L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6046C4CEE4;
	Sun, 25 May 2025 02:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748141168;
	bh=OxlWYued1qwgYdzX737Wr2KjNkSsaqCH+6uEdTlEtzA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=D/u7UQ0Lntycg+UCM4HEKiuCxHqOvjlFkLgOowzVYZvTUCTx+vs5zNU/euoLbJJV3
	 LkhFgCnLWOpoY0bNHl0h4hanFAH8vCiYaA0pN4XZcQsNaaJSlMo5yJQNjrr7D2LIJP
	 4RvFVFeKIpirfaxK2gOUeNwfphLj+p2ywlqppyFZNyznWQsUyKcD+uyekPmkx3CUp/
	 mbk/fIqWLUl4cnH6aI4ih48HJ5mc6ItKClVK+HAQ2N77PMo8xjvD6LIFHMusz30YHX
	 l96g4PnQmDaxhVv5deREyUMPJpTs35WJq+pLqVK9npgOeR26l1+04AtzY/NvkXjmzx
	 0Q9eK4SxT8gmQ==
Message-ID: <68eeeb84-5df1-4647-b247-6fdf87658c5a@kernel.org>
Date: Sat, 24 May 2025 19:46:06 -0700
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] dt-bindings: serial: Convert snps,arc-uart to DT
 schema
To: "Rob Herring (Arm)" <robh@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Vineet Gupta <vgupta@kernel.org>
Cc: Thierry Reding <treding@nvidia.com>, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org, devicetree@vger.kernel.org
References: <20250507154909.1602497-1-robh@kernel.org>
From: Vineet Gupta <vgupta@kernel.org>
Content-Language: en-US
In-Reply-To: <20250507154909.1602497-1-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/7/25 08:49, Rob Herring (Arm) wrote:
> Convert the Synopsys ARC UART binding to DT schema. Drop the "aliases"
> portion which is not relevant to this schema.
>
> Reviewed-by: Thierry Reding <treding@nvidia.com>
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>

Acked-by: Vineet Gupta <vgupta@kernel.org>

Thx,
-Vineet

> ---
> v2:
>  - Fix $id path
> ---
>  .../devicetree/bindings/serial/arc-uart.txt   | 25 ---------
>  .../bindings/serial/snps,arc-uart.yaml        | 51 +++++++++++++++++++
>  2 files changed, 51 insertions(+), 25 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/serial/arc-uart.txt
>  create mode 100644 Documentation/devicetree/bindings/serial/snps,arc-uart.yaml
>
> diff --git a/Documentation/devicetree/bindings/serial/arc-uart.txt b/Documentation/devicetree/bindings/serial/arc-uart.txt
> deleted file mode 100644
> index 256cc150ca7e..000000000000
> --- a/Documentation/devicetree/bindings/serial/arc-uart.txt
> +++ /dev/null
> @@ -1,25 +0,0 @@
> -* Synopsys ARC UART : Non standard UART used in some of the ARC FPGA boards
> -
> -Required properties:
> -- compatible		: "snps,arc-uart"
> -- reg			: offset and length of the register set for the device.
> -- interrupts		: device interrupt
> -- clock-frequency	: the input clock frequency for the UART
> -- current-speed		: baud rate for UART
> -
> -e.g.
> -
> -arcuart0: serial@c0fc1000 {
> -	compatible = "snps,arc-uart";
> -	reg = <0xc0fc1000 0x100>;
> -	interrupts = <5>;
> -	clock-frequency = <80000000>;
> -	current-speed = <115200>;
> -};
> -
> -Note: Each port should have an alias correctly numbered in "aliases" node.
> -
> -e.g.
> -aliases {
> -	serial0 = &arcuart0;
> -};
> diff --git a/Documentation/devicetree/bindings/serial/snps,arc-uart.yaml b/Documentation/devicetree/bindings/serial/snps,arc-uart.yaml
> new file mode 100644
> index 000000000000..dd3096fbfb6a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/serial/snps,arc-uart.yaml
> @@ -0,0 +1,51 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/serial/snps,arc-uart.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Synopsys ARC UART
> +
> +maintainers:
> +  - Vineet Gupta <vgupta@kernel.org>
> +
> +description:
> +  Synopsys ARC UART is a non-standard UART used in some of the ARC FPGA boards.
> +
> +allOf:
> +  - $ref: /schemas/serial/serial.yaml#
> +
> +properties:
> +  compatible:
> +    const: snps,arc-uart
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clock-frequency:
> +    description: the input clock frequency for the UART
> +
> +  current-speed:
> +    description: baud rate for UART
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clock-frequency
> +  - current-speed
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    serial@c0fc1000 {
> +        compatible = "snps,arc-uart";
> +        reg = <0xc0fc1000 0x100>;
> +        interrupts = <5>;
> +        clock-frequency = <80000000>;
> +        current-speed = <115200>;
> +    };

