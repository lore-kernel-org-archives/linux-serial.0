Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF60E2AD2D;
	Tue, 28 Jan 2025 07:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738050770; cv=none; b=dtB5VGYoozCfklZZz3FLP6r5E/C9NX0dT2HwVMK0Ahu2jn6at+cTLjrGnt8/P0GNTN7fN81viYJ5+HEDPyr8Wwbbd0FJpf30ZJADmH1LgXxT9V8G96gdGyXTDD2mP6porTqia9s1JeHNOAOiQZ+v28qis1IjqJH8HYWWdMAvbaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738050770; c=relaxed/simple;
	bh=2Z86bgwk9xn8/B2uNhxhdi/lTHGGqUqlkFje4QSm0eg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CFB4Re6YGx0t6RUYgpiqieJrDVYnBz9Xb13yUHZcjpUlwwQFaqiZBzr5fUF9fPFsQEj1W456q5rYTRfjGOnU44d4OWIHgRbTyKVTfR4BJ1bMSuV5ILNdCKewZxr8EuXrCX03r6MtPp+K+HaTOtz2bNxIX0uiQ5TFS+QyMuuYk/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mSJXy4Wj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mSJXy4Wj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85105C4CEE8;
	Tue, 28 Jan 2025 07:52:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738050769;
	bh=2Z86bgwk9xn8/B2uNhxhdi/lTHGGqUqlkFje4QSm0eg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mSJXy4Wj4OQu3W7RZZ/n3ER0VxWcbr/GrspTiVgaG8yx0WXvoyMYtr4tONtSTtHG4
	 UgGv//rO16I/i8okS7w5LoSlFNAzxcSdZDq/0AgRSPBFgPMnomJwP18BEivYqORvSP
	 fYV4KvqSR1V10yuwAF6FMLynPAcZn4BE42BGjppLMQeej+7dTMAPmz1XtJEtZT/+iK
	 CCFOGUbs82IGdCwC/aiYrEHDujW8anaX7Mv+rz54FXVTthHZD1KD37f/gkOl9gSoww
	 AxgvY2zKI5uRAcVEAtDuxyokwAN6vKmrnqVcJ8akdA3MDTgZu3vlVkXt6zyEiYfUHs
	 5B5Nulo/5vylQ==
Date: Tue, 28 Jan 2025 08:52:45 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Kartik Rajput <kkartik@nvidia.com>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, thierry.reding@gmail.com, 
	jonathanh@nvidia.com, hvilleneuve@dimonoff.com, arnd@kernel.org, 
	geert+renesas@glider.be, robert.marko@sartura.hr, schnelle@linux.ibm.com, 
	andriy.shevchenko@linux.intel.com, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: serial: Add bindings for
 nvidia,tegra264-utc
Message-ID: <20250128-amusing-squirrel-of-gaiety-b3ba97@krzk-bin>
References: <20250128064633.12381-1-kkartik@nvidia.com>
 <20250128064633.12381-2-kkartik@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250128064633.12381-2-kkartik@nvidia.com>

On Tue, Jan 28, 2025 at 12:16:32PM +0530, Kartik Rajput wrote:
> The Tegra UTC (UART Trace Controller) is a HW based serial port that
> allows multiplexing multiple data streams of up to 16 UTC clients into
> a single hardware serial port.
> 
> Add bindings for the Tegra UTC client device.
> 
> Signed-off-by: Kartik Rajput <kkartik@nvidia.com>
> ---
>  .../bindings/serial/nvidia,tegra264-utc.yaml  | 83 +++++++++++++++++++
>  1 file changed, 83 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/serial/nvidia,tegra264-utc.yaml
> 
> diff --git a/Documentation/devicetree/bindings/serial/nvidia,tegra264-utc.yaml b/Documentation/devicetree/bindings/serial/nvidia,tegra264-utc.yaml
> new file mode 100644
> index 000000000000..63ba3655451f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/serial/nvidia,tegra264-utc.yaml
> @@ -0,0 +1,83 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/serial/nvidia,tegra264-utc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: NVIDIA Tegra UART Trace Controller (UTC) client

Controller and client (Client?) sound conflicting. What is this client
of?

> +
> +maintainers:
> +  - Kartik Rajput <kkartik@nvidia.com>
> +  - Thierry Reding <thierry.reding@gmail.com>
> +  - Jonathan Hunter <jonathanh@nvidia.com>
> +
> +description:
> +  The Tegra UTC (UART Trace Controller) is a hardware controller that
> +  allows multiple systems within the Tegra SoC to share a hardware UART
> +  interface. It supports up to 16 clients, with each client having its own
> +  interrupt and a FIFO buffer for both RX (receive) and TX (transmit), each
> +  capable of holding 128 characters.

So is this client or the controller?

> +
> +  The Tegra UTC uses 8-N-1 configuration and operates on a pre-configured
> +  baudrate, which is configured by the bootloader.
> +
> +properties:
> +  $nodename:
> +    pattern: "^serial(@.*)?$"

Drop, not needed. But you miss proper $ref, see other bindings.


> +
> +  compatible:
> +    const: nvidia,tegra264-utc
> +
> +  reg:
> +    items:
> +      - description: Register region for TX client.

Drop redundant parts, so just "TX region".

> +      - description: Register region for RX client.
> +    minItems: 2

Drop

> +
> +  reg-names:
> +    items:
> +      - const: tx
> +      - const: rx
> +    minItems: 2

Drop. Please take a look at other bindings how they do things. There is
no such code anywhere in the kernel.

> +
> +  interrupts:
> +    maxItems: 1
> +
> +  current-speed:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      This property specifies the baudrate at which the Tegra UTC is

Drop "This property specifies the". Do not say what Devicetree syntax
is. We all know. This is a description of hardware, not the DTS langauge.

> +      operating.
> +
> +  nvidia,utc-fifo-threshold:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      This property specifies the UTC TX and RX client FIFO threshold in
> +      terms of occupancy.
> +
> +      This property should have the same value as the burst size (number
> +      of characters read by the Tegra UTC hardware at a time from each
> +      client) which is configured by the bootloader.

Title says this is a client, so quite confusing. Anyway, why is this
board specific?

Also, missing constraints, missing units. Why common serial properties
are not applicable?

Best regards,
Krzysztof

