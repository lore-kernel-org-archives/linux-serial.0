Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CABA18E02A;
	Wed,  7 May 2025 15:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746633295; cv=none; b=iHB9cXnECTwxOdG8zwil+d+LmsfmVaJXF3Dpf9IgQiNBCZJltfS7NlRD9JiDwsqIG1DtAdh+xQNjjTgeHPa2wa8sv8rCJOicVrGUKj964gdK61/9W9WOGDxs2gtGPluvQ6GRi44e4lvDcoCp23vFbleMJ6mgkHTpFHgULYt7dEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746633295; c=relaxed/simple;
	bh=zW0RWInMNx5/I7PV4AOVLi7xHPAV51zOFBu+ZZh6dHM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jpkq3ieJglJpqo8Dpp6L1DeqN975X1ZmUM8H5zepFybWk9kokDjdbVqIEM4+TfVD8Mg+uCb6Jj15ZLRSc1OL9MaENGWH28zbz343iANLrBMKh3qNayTVifTtcqEB+Sog7Ad0ktIogD7kDBkkvlCFUAMqyvFUJR6BIzPe+bXn3Co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 472E916F2;
	Wed,  7 May 2025 08:54:43 -0700 (PDT)
Received: from donnerap.manchester.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4A29E3F58B;
	Wed,  7 May 2025 08:54:52 -0700 (PDT)
Date: Wed, 7 May 2025 16:54:47 +0100
From: Andre Przywara <andre.przywara@arm.com>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby
 <jirislaby@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: serial: Convert arm,sbsa-uart to DT schema
Message-ID: <20250507165447.7e340d47@donnerap.manchester.arm.com>
In-Reply-To: <20250506220016.2545637-1-robh@kernel.org>
References: <20250506220016.2545637-1-robh@kernel.org>
Organization: ARM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  6 May 2025 17:00:15 -0500
"Rob Herring (Arm)" <robh@kernel.org> wrote:

> Convert the Arm SBSA UART binding to DT schema. It is a straight-forward
> conversion.
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> 
> ---
>  .../bindings/serial/arm,sbsa-uart.yaml        | 38 +++++++++++++++++++
>  .../bindings/serial/arm_sbsa_uart.txt         | 10 -----
>  2 files changed, 38 insertions(+), 10 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/serial/arm,sbsa-uart.yaml
>  delete mode 100644 Documentation/devicetree/bindings/serial/arm_sbsa_uart.txt
> 
> diff --git a/Documentation/devicetree/bindings/serial/arm,sbsa-uart.yaml b/Documentation/devicetree/bindings/serial/arm,sbsa-uart.yaml
> new file mode 100644
> index 000000000000..68e3fd64b1d8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/serial/arm,sbsa-uart.yaml
> @@ -0,0 +1,38 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +---
> +$id: http://devicetree.org/schemas/serial/arm,sbsa-uart.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: ARM SBSA UART
> +
> +maintainers:
> +  - Andre Przywara <andre.przywara@arm.com>
> +
> +description:
> +  This UART uses a subset of the PL011 registers and consequently lives in the
> +  PL011 driver. It's baudrate and other communication parameters cannot be

He said "driver" in a binding document!! ;-) I think you can remove that
part, or maybe rephrase it to say it could be supported by the same driver
that supports a PL011.

Other than that it looks alright, thanks for the conversion!

With that fixed:

Reviewed-by: Andre Przywara <andre.przywara@arm.com>

Cheers,
Andre

> +  adjusted at runtime, so it lacks a clock specifier here.
> +
> +allOf:
> +  - $ref: /schemas/serial/serial.yaml#
> +
> +properties:
> +  compatible:
> +    const: arm,sbsa-uart
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  current-speed:
> +    description: fixed baud rate set by the firmware
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - current-speed
> +
> +unevaluatedProperties: false
> diff --git a/Documentation/devicetree/bindings/serial/arm_sbsa_uart.txt b/Documentation/devicetree/bindings/serial/arm_sbsa_uart.txt
> deleted file mode 100644
> index 4163e7eb7763..000000000000
> --- a/Documentation/devicetree/bindings/serial/arm_sbsa_uart.txt
> +++ /dev/null
> @@ -1,10 +0,0 @@
> -* ARM SBSA defined generic UART
> -This UART uses a subset of the PL011 registers and consequently lives
> -in the PL011 driver. It's baudrate and other communication parameters
> -cannot be adjusted at runtime, so it lacks a clock specifier here.
> -
> -Required properties:
> -- compatible: must be "arm,sbsa-uart"
> -- reg: exactly one register range
> -- interrupts: exactly one interrupt specifier
> -- current-speed: the (fixed) baud rate set by the firmware

