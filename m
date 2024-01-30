Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2132B7EF05;
	Tue, 30 Jan 2024 23:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706655743; cv=none; b=oCBHIXrA6SCJeI1gpauv9zY4kHkEtUpkP5CFwaUvJ7XsepTqyxOTkltiuILsDmrEOLdP9VSHtLoBsudNxpIn6MhbbUFcAv7AGgNRWbvprJaxbA0lVIiH7vWwedFzIk9QgPoPwYarddnanr/xjZKWIjjuV6Nl7EbA4QEGqUidQ6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706655743; c=relaxed/simple;
	bh=Q/5sVxq0UBbAMtH5axjn8/3c/o19Bpt/DiCP+LgTKhU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UCIiijdBtXEfcoI4xV3ubwnd6KL2Jtvv+stRxmN/LOMNHgOXqRFZFgnSc+nSJOrCkwE/hpPdbZM/f9cKRSS8Pq0zm4RdwaF93LtejQ7e/J6KjnfS3tAzKqPUC8AR3lxNZightvzUGG39zWYVy1MTk/Qv0nTxucSb7oK1zw34MNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bFFzWkI2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bFFzWkI2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D7FAC433F1;
	Tue, 30 Jan 2024 23:02:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706655742;
	bh=Q/5sVxq0UBbAMtH5axjn8/3c/o19Bpt/DiCP+LgTKhU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bFFzWkI23nEDrljXibfFpeh//ZhwiOaUzuVPkBQ2abO2/Y9SHQejdGt/YabotelJQ
	 zi9/4pjDB+6508q+ONxNgxvAlj3y9j54UOIxYBvV6+sdgZIvDTqEqBQbgGBf0ly5zC
	 ZLHiVvyOR2kz+RkZ2Y0XvD37h3WAEkdrxwH0Tgy4pGMD2XmUs4ev4Oje1ZkeMG58yz
	 XL9n6vtKfCoTsoFTpvUdpkS2sA/oASkFLEpiBZvbgFwrLFGraThwDpZ8t/ihP0ZXrZ
	 Guwib0fCCB/9i5WEUXw+doqTL8urbagZHfBMV+dgNE7fRoL5Csn3hprI0zPV39sdDr
	 FRKUgu27RaEoA==
Date: Tue, 30 Jan 2024 17:02:20 -0600
From: Rob Herring <robh@kernel.org>
To: Farouk Bouabid <farouk.bouabid@theobroma-systems.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	quentin.schulz@theobroma-systems.com
Subject: Re: [PATCH v5 3/6] dt-bindings: serial: add binding for rs485
 rx-enable state when rs485 is disabled
Message-ID: <20240130230220.GA2569797-robh@kernel.org>
References: <20240126-dev-rx-enable-v5-0-5d934eda05ca@theobroma-systems.com>
 <20240126-dev-rx-enable-v5-3-5d934eda05ca@theobroma-systems.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240126-dev-rx-enable-v5-3-5d934eda05ca@theobroma-systems.com>

On Fri, Jan 26, 2024 at 06:27:44PM +0100, Farouk Bouabid wrote:
> RS485 can have a receiver-enable gpio (rx-enable-gpios). When rs485 is

s/gpio/GPIO/

> enabled, this gpio, if provided, must be driven active while receiving.
> However when RS485 is disabled this gpio should not have an undefined
> state. In that case, as DE and RE pins can be connected both to this gpio,
> if its state is not properly defined, can cause unexpected transceiver
> behavior.
> This binding depend on rx-enable-gpios to be implemented.

Sounds like a constraint:

dependencies:
  rs485-rx-enable-inactive-when-rs485-disabled: [ rx-enable-gpios ]

> 
> Signed-off-by: Farouk Bouabid <farouk.bouabid@theobroma-systems.com>
> ---
>  Documentation/devicetree/bindings/serial/rs485.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/serial/rs485.yaml b/Documentation/devicetree/bindings/serial/rs485.yaml
> index b64577036b5c..4c79dfaaf460 100644
> --- a/Documentation/devicetree/bindings/serial/rs485.yaml
> +++ b/Documentation/devicetree/bindings/serial/rs485.yaml
> @@ -55,6 +55,11 @@ properties:
>      description: GPIO to handle a separate RS485 receive enable signal
>      maxItems: 1
>  
> +  rs485-rx-enable-inactive-when-rs485-disabled:

For something a bit shorter, perhaps: rs485-rx-enable-inactive-on-disable

> +    description: rx-enable GPIO is not active when RS485 is disabled. If missing, active-state
> +      is assumed.
> +    $ref: /schemas/types.yaml#/definitions/flag
> +
>    rs485-term-gpios:
>      description: GPIO pin to enable RS485 bus termination.
>      maxItems: 1
> 
> -- 
> 2.34.1
> 
