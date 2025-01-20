Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88E20140E3C;
	Mon, 20 Jan 2025 07:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737359834; cv=none; b=OgBvu3k7cUxKl3iYiBLGxRdBdhc3rZ+9UQpAWphaU8TikQSk+xZBTjNbi5j4kMG18psNl+iC6lg72aufeEHT3kvas7kNGvKwaXaURcZrmNOtyCw4j6VvCKntQmCzri0k149ipw0eWbu9EYtyJQaTFl9T38u5sB6VeW0S1CxlERU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737359834; c=relaxed/simple;
	bh=AbRtKskymy7iFFe/UNt6tgcNZXamzrBYtEFb+oQESJk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KlPz5+gfPo6ViEP9N7G23+mHGhvl+QUAvcxoMJehFD/x3yffkHmY4YvLwt5ymjvqYXkZKGitQOS2YUPPxXs5WmAIhD0gtVL+OBgyBizJqOt/sQ7DFqqsTDq6Yq5A2wgJLtD4vVEI2mphW71lsxukzuXnhA3AzoPbP0p4F5fcEcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WTMpAcsr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WTMpAcsr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52703C4CEDD;
	Mon, 20 Jan 2025 07:57:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737359834;
	bh=AbRtKskymy7iFFe/UNt6tgcNZXamzrBYtEFb+oQESJk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WTMpAcsrDFMYn9ppui6qqsyCbl7jkoz5lf7y9Fg6rG7PQrmiZollfRqitEvFsuFHa
	 asKmtlK7H//BLXSBA3nxc3OA3OMlBe9zB7yCWAMQem70qOCHF+cSAeeIK2NFD2oYDg
	 cyRm7Uyrp0GnDREgXPbR9NxvsmgR0JCffmfcjFA1iG3PkE0cTarMF9NtDJHVkA/IiK
	 OXL8JLxDuGOy6rcikU5+HP+Y2vbdTnnDFVr97KIZa9RT6hw6EBMIQcoq4q9EnX2V0i
	 mois0GOfYxH91zR52eNiFeL0M/vhl8xg2Eka/Uap2/Pf26QRoQAkk9ksK1igjXsCYO
	 pP+elXQ4nG4nA==
Date: Mon, 20 Jan 2025 08:57:10 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Benjamin Larsson <benjamin.larsson@genexis.eu>
Cc: linux-serial@vger.kernel.org, devicetree@vger.kernel.org, 
	ansuelsmth@gmail.com, lorenzo@kernel.org, krzk+dt@kernel.org, 
	gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: serial: 8250: Add Airoha compatibles
Message-ID: <20250120-flashy-nice-tody-afa2ae@krzk-bin>
References: <20250119130105.2833517-1-benjamin.larsson@genexis.eu>
 <20250119130105.2833517-2-benjamin.larsson@genexis.eu>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250119130105.2833517-2-benjamin.larsson@genexis.eu>

On Sun, Jan 19, 2025 at 02:01:04PM +0100, Benjamin Larsson wrote:
> The Airoha SoC family have a mostly 16550-compatible UART
> and High-Speed UART hardware with the exception of custom
> baud rate settings register.
> 
> Signed-off-by: Benjamin Larsson <benjamin.larsson@genexis.eu>
> ---
>  Documentation/devicetree/bindings/serial/8250.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/serial/8250.yaml b/Documentation/devicetree/bindings/serial/8250.yaml
> index 692aa05500fd..2fbb972e5460 100644
> --- a/Documentation/devicetree/bindings/serial/8250.yaml
> +++ b/Documentation/devicetree/bindings/serial/8250.yaml
> @@ -63,6 +63,8 @@ properties:
>        - const: mrvl,pxa-uart
>        - const: nuvoton,wpcm450-uart
>        - const: nuvoton,npcm750-uart
> +      - const: airoha,airoha-uart
> +      - const: airoha,airoha-hsuart

I assume you placed it matching existing order (kind of alphabetical for
compatibles with vendors)?

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

