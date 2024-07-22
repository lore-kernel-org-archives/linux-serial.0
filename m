Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E5EA3770D;
	Mon, 22 Jul 2024 23:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721690675; cv=none; b=m8wnkDNlewVndmly78EwvXGeeuSY1XI+d7+Yd1BaRSHPVuWJQhhK5NJZmJRD17pcAo+j+gCT2Ad4I4OUptMvWv5wlHB38EbQGoaDnORlNlHrjyOynLW0Sla4yHXJRWdrzoTYjwPm3AeSfz8aUzNe133qyRiwaRoDMD2ZexHifZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721690675; c=relaxed/simple;
	bh=EaNRTQTVUZ3xOSXnhwsO79gawVw0DO92+zGDtm8hCEM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sxjFoI0G8QXe2HlDp0caQRBsiD1g62HpUTIHX/s99atBcZe3uAI3gcYEF42Bvar4oy5WP07LImq1qsDtAAFP/ylUr6BR0iukIyJHvk6dSVi2V8KQCk0e7hq9hWO7nnQEnuZ/KAWvIo2isK45Qz/4/2ISTO8ijAL+zQiafu1dU8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l5jaTq/S; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l5jaTq/S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDD6EC116B1;
	Mon, 22 Jul 2024 23:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721690674;
	bh=EaNRTQTVUZ3xOSXnhwsO79gawVw0DO92+zGDtm8hCEM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=l5jaTq/SahUf7TxNjROOgwf8QlzK2x/pjGx0xly2E7MYfQV/VEehXeMp1RP6rdpOo
	 4PKKXvqFvDbwsAuZRBpnSaU37n252dlAZUqVnfffnCvuqdrVwayrcZNvmR/co9pO3z
	 L4uxxaefINGU0LkJ7CHTgOdI4syDkL1GNnHXhYKrIujheFa3YnV68OfmFbcOeViap9
	 KIhDQtIFfPMxYaBPYclwAyDGyvFBsyAKKupdGNCmbvpuOCPorCeDS1UVT2bIUA52za
	 p/YKgQGjKxGsVqWyV1sKNwUyouQBhoPwKVnMjdKL9d9yUU+0iFZNjqg6HHeQ3oF+DL
	 6GW5EyoI0eaaA==
Date: Mon, 22 Jul 2024 17:24:27 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: =?iso-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
Cc: devicetree@vger.kernel.org, Peter Griffin <peter.griffin@linaro.org>,
	linux-kernel@vger.kernel.org,
	Will McVicker <willmcvicker@google.com>,
	linux-serial@vger.kernel.org, kernel-team@android.com,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH v4 2/2] dt-bindings: serial: samsung: fix maxItems for
 gs101
Message-ID: <172169065730.292676.195019467020873816.robh@kernel.org>
References: <20240712-gs101-uart-binding-v4-0-24e9f8d4bdcb@linaro.org>
 <20240712-gs101-uart-binding-v4-2-24e9f8d4bdcb@linaro.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240712-gs101-uart-binding-v4-2-24e9f8d4bdcb@linaro.org>


On Fri, 12 Jul 2024 15:51:18 +0100, André Draszik wrote:
> While gs101 needs exactly two clocks for the UART, the schema doesn't
> currently limit the maximum number to this and instead the default of
> five from this schema is applied.
> 
> Update the schema accordingly.
> 
> Signed-off-by: André Draszik <andre.draszik@linaro.org>
> 
> ---
> v4:
> * drop description from clocks:, it was Linux-specific and a we'll
>   implement something that makes it obsolete anyway
> * no need to duplicate clock-names anymore
> ---
>  Documentation/devicetree/bindings/serial/samsung_uart.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

