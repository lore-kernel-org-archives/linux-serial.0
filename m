Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4635929BD9C;
	Fri,  5 Sep 2025 20:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757104909; cv=none; b=f4+pH/fVR0fZd4q+bYqtshg5DC25Is4S83AGtFT+VQm5jyKfQjCBZm8Y4qt3Po4L+THk83sagoW9r4HgkU+531KcwSNiD+a6APyOSXva1yCMuHpUHobfUpn6YBiki18q2uiCCq/g40oXo+lO6eOjShqRvjgNwRNX0MbK3+dTh0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757104909; c=relaxed/simple;
	bh=VLzkKyFM7Xt7UD4CnLks47F9lLUSZ4SWSWQbrv3i+6M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YxpTLiIRSDNuBQ1kxjWJKNhR/oMmOe5ala9z7n4ODtQrJ1WoaXo6Cu9gU7em9L0gTSjXYS/ltdZKAMyyXBk9A5cxH6XbLGbNI4/EA0kRI2fTA8anHvhPizAOitfS5i7feoZ8BtMkNLmOjJxwz62CpVualjqQfcu3WxTIlwagv5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W6ZVxRSz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W6ZVxRSz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3067C4CEF1;
	Fri,  5 Sep 2025 20:41:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757104909;
	bh=VLzkKyFM7Xt7UD4CnLks47F9lLUSZ4SWSWQbrv3i+6M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W6ZVxRSzx/QOq57TzwXJ6Y8nr3DB+5DtiePP/+bliTZlFoFSI9KdPnK5KLnfelTm3
	 VstRYxzCeY4P5ktAD6dPqqq5taKgq6yQaQNNzKVTSqIcy3fsTxjnaCKHBJgKwy3kG7
	 XO6Mt0iBKTo4pjG4Wg9/bKcMkhlCU1YuoME/WDiUIUUX9jXVyFxZhUCkDN8G1XjtSg
	 NBnWpusaWvNfZiqb/NtfPlZXAMBXSlttun0RDV4SfSHJUIow+okrtEfxxy1CCYnp5J
	 CEhXYM4NG7/DFzX8C9ISTfB2ukRMRXPSwjmTk/rANGcsW+YJugH+p5AKfT+53M6D3h
	 6hG1qMaXCsJpQ==
Date: Fri, 5 Sep 2025 15:41:48 -0500
From: Rob Herring <robh@kernel.org>
To: Kendall Willis <k-willis@ti.com>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, vigneshr@ti.com, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
	d-gole@ti.com, vishalm@ti.com, sebin.francis@ti.com,
	msp@baylibre.com, khilman@baylibre.com, a-kaur@ti.com,
	john.ogness@linutronix.de, andriy.shevchenko@linux.intel.com,
	yujiaoliang@vivo.com, b-liu@ti.com, u.kleine-koenig@baylibre.com
Subject: Re: [PATCH 2/3] dt-bindings: serial: 8250_omap: Add wakeup pinctrl
 state
Message-ID: <20250905204148.GA1313142-robh@kernel.org>
References: <20250904212455.3729029-1-k-willis@ti.com>
 <20250904212455.3729029-3-k-willis@ti.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250904212455.3729029-3-k-willis@ti.com>

On Thu, Sep 04, 2025 at 04:24:54PM -0500, Kendall Willis wrote:
> From: Markus Schneider-Pargmann <msp@baylibre.com>
> 
> Pins associated with the 8250 omap unit can be the source of a wakeup in
> deep sleep states. To be able to wakeup, these pins have to be
> configured in a special way. To support this configuration add the
> default and wakeup pinctrl states. Add support for the sleep state as
> well which is in use by some devicetrees.
> 
> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
> Signed-off-by: Kendall Willis <k-willis@ti.com>
> ---
>  .../devicetree/bindings/serial/8250_omap.yaml   | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/serial/8250_omap.yaml b/Documentation/devicetree/bindings/serial/8250_omap.yaml
> index 851a5291b4be4..1c4040a9f9d0b 100644
> --- a/Documentation/devicetree/bindings/serial/8250_omap.yaml
> +++ b/Documentation/devicetree/bindings/serial/8250_omap.yaml
> @@ -77,6 +77,23 @@ properties:
>          description:
>            List of phandles to system idle states in which UARTs can wakeup the system.
>  
> +  pinctrl-0:
> +    description: Default pinctrl state
> +
> +  pinctrl-1:
> +    description: Can be "sleep" or "wakeup" pinctrl state
> +
> +  pinctrl-names:
> +    description:
> +      When present should contain at least "default" describing the default pin
> +      states. Other states are "sleep" which describes the pinstate when
> +      sleeping and "wakeup" describing the pins if wakeup is enabled.
> +    minItems: 1
> +    items:
> +      - const: default
> +      - const: sleep
> +      - const: wakeup

This doesn't match what 'pinctrl-1' says. Perhaps you want?:

items:
  - const: default
  - enum: [ sleep, wakeup ]

> +
>  required:
>    - compatible
>    - reg
> -- 
> 2.34.1
> 
