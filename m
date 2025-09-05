Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6BBF270557;
	Fri,  5 Sep 2025 20:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757104711; cv=none; b=BS6EbUMVyY1FcBKM74wb43U2Lc4kqOtxmwaZqZd/6WOQKzaY/Etiw4rSGOukfUYptB2N63wV07Oz5sH8sWTPUaRsWQDfhGQq0IxomK2qPsJ8TPRK8xWqzRcix8KtOqgjPFZz5O46GqmDQU/19AvCxIti3/qWgIEuGVzFWOiPOd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757104711; c=relaxed/simple;
	bh=1jzKDgZMiPtHutvrnfgdjjHYpvwH6zlRmiSOv9As9Ok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XR3PNOkTtEd5m+lxivaJ1IrZuAcTqRVAE2pDpgrLZFRDHvbx4nOgfxzvY1E5AdExECh/Ur6dQiLEpS7/V6D7P4eAFH6QtfjnX9OZncr3e3mnKd7DveVCGYUG0cYwGslF0POt5F81tNNG36C8Dg5geMVEhwiAaTcJbkafuvYozfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TboLt5L/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TboLt5L/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44AAEC4CEF1;
	Fri,  5 Sep 2025 20:38:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757104710;
	bh=1jzKDgZMiPtHutvrnfgdjjHYpvwH6zlRmiSOv9As9Ok=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TboLt5L/1XzMHZmVcNRsMUNW+rC2Mh3IDtafTLxBVs7T5elDXTLGZTk7tYDYTztjM
	 gh7Fwrzl3HxluttGLY4iEb/Rbmq8CK4LOm1BETmJWdetT2UxGT8AScoPqIBL8nDq24
	 JR35GMOxW9InfEkQNnjfs4IaCXLg2TC7M0pPP0k//z5x0G7Hd0E5TGFK22AiHHqxRS
	 RECGQv6ZsgHeKNhZhw0uFhG4aFo/nWgYJ95Xl4mipJ5qu+5vYM2DpA+yMDUMhY9oSg
	 DV+UmAS/AHtiQ0D5nY9txqX31NoM9wO/rg3T8zmrAE+k2TDnvME1k5P+N3rGapD1me
	 h1Xw//46MNbCg==
Date: Fri, 5 Sep 2025 15:38:29 -0500
From: Rob Herring <robh@kernel.org>
To: Kendall Willis <k-willis@ti.com>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, vigneshr@ti.com, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
	d-gole@ti.com, vishalm@ti.com, sebin.francis@ti.com,
	msp@baylibre.com, khilman@baylibre.com, a-kaur@ti.com,
	john.ogness@linutronix.de, andriy.shevchenko@linux.intel.com,
	yujiaoliang@vivo.com, b-liu@ti.com, u.kleine-koenig@baylibre.com
Subject: Re: [PATCH 1/3] dt-bindings: serial: 8250_omap: Update wakeup-source
 type property
Message-ID: <20250905203829.GA1269545-robh@kernel.org>
References: <20250904212455.3729029-1-k-willis@ti.com>
 <20250904212455.3729029-2-k-willis@ti.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250904212455.3729029-2-k-willis@ti.com>

On Thu, Sep 04, 2025 at 04:24:53PM -0500, Kendall Willis wrote:
> Allow the wakeup-source property to be either of type boolean or of a
> phandle array. The phandle array points to the system idle states that the
> UART can wakeup the system from.
> 
> Signed-off-by: Kendall Willis <k-willis@ti.com>
> ---
>  Documentation/devicetree/bindings/serial/8250_omap.yaml | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/serial/8250_omap.yaml b/Documentation/devicetree/bindings/serial/8250_omap.yaml
> index 1859f71297ff2..851a5291b4be4 100644
> --- a/Documentation/devicetree/bindings/serial/8250_omap.yaml
> +++ b/Documentation/devicetree/bindings/serial/8250_omap.yaml
> @@ -69,7 +69,13 @@ properties:
>    clock-frequency: true
>    current-speed: true
>    overrun-throttle-ms: true
> -  wakeup-source: true
> +
> +  wakeup-source:
> +    oneOf:
> +      - type: boolean
> +      - $ref: /schemas/types.yaml#/definitions/phandle-array
> +        description:
> +          List of phandles to system idle states in which UARTs can wakeup the system.

You don't need to be defining the type here. Did you find either type 
didn't work?
