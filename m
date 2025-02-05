Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9838C22A1C5;
	Wed,  5 Feb 2025 08:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738745045; cv=none; b=KzQIDLXCK8LF17zlVWETXia15YckvG7DNDTp+dLqum3rdJUehtt0Dy/L3xG2PQke8oMhcH/4iFRnoOk3m4owBoJVHGSy31B92l4mswNOQQNARnU691aHjUfx1UBnCpMvD9/w8MK4T+cjTJLrvcIN3h6omgY79f0gXGXc+yW23uY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738745045; c=relaxed/simple;
	bh=DVZfcrbv7vSC0Qw/vD+hsLybGCwDpGP5oB9YoF6ZEYU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KmVsQtVt02zBuCOv7rZArCFAnKNnEls4fuwsuK7WkJFb83/eWJn6AbFFjf7XZHiVMiWMGW+VfSYu1fKSsHpe9vX+e0rgLMIlyouf+iqH4J3IgZyJMJ24gH7av5ypvin+FN3WG5DTMkDuxM8i98gbwI+3YGXpPhrZc7i8nWvb+AU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mA2aBluE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mA2aBluE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15857C4CED1;
	Wed,  5 Feb 2025 08:44:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738745045;
	bh=DVZfcrbv7vSC0Qw/vD+hsLybGCwDpGP5oB9YoF6ZEYU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mA2aBluE+Ucem9uUonit6rVkY9Wjgqbez75BUeNNZp3nNPUA4hTj9vi6Y82qMlXju
	 JiQKGjN5bubglCBaMd/jkn0BlNwVk/2QjtZs3UERW1hXfi8zAaWUxfmjIZ5yoz8kr6
	 3NBNW1/Pj1l1qRrMhp7jO4DwszNo0/EOJCIhu6S7edJlml1XiKOunInPK/DgKlGtsO
	 BZ2FuSE81E21lHMSetvGXbhqBFY7rB4kGfdfusnG3cTLMAm1GzQrSN/35RiSMDP1gA
	 3Taew7BzQvpCE43q8GRIISTFS+SAmcghSY1oqnt4ZBMTrwZfKoeV8FNg5LJ8vNF1qF
	 1Vc5lfO8xR3pg==
Date: Wed, 5 Feb 2025 09:44:01 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Kaustabh Chakraborty <kauschluss@disroot.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>, Conor Dooley <conor@kernel.org>, 
	Alim Akhtar <alim.akhtar@samsung.com>, Sergey Lisov <sleirsgoevy@gmail.com>, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org
Subject: Re: [PATCH 2/2] tty: serial: samsung: add support for exynos7870
Message-ID: <20250205-artichoke-gibbon-of-management-e9c5fc@krzk-bin>
References: <20250204-exynos7870-uart-v1-0-06be6aa96284@disroot.org>
 <20250204-exynos7870-uart-v1-2-06be6aa96284@disroot.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250204-exynos7870-uart-v1-2-06be6aa96284@disroot.org>

On Tue, Feb 04, 2025 at 02:08:46AM +0530, Kaustabh Chakraborty wrote:
> Add serial UART support for Exynos7870. The FIFO sizes are not defined
> in the driver, and they must be provided in the devicetree with the
> samsung,uart-fifosize property.
> 
> Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
> ---
>  drivers/tty/serial/samsung_tty.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
> index 210fff7164c138e315d20ccaa4a29ce6a7bb2dfe..c8607633fea40df2ec221cfd3653c726094127cb 100644
> --- a/drivers/tty/serial/samsung_tty.c
> +++ b/drivers/tty/serial/samsung_tty.c
> @@ -2493,6 +2493,12 @@ static const struct s3c24xx_serial_drv_data exynos5433_serial_drv_data = {
>  	.fifosize = { 64, 256, 16, 256 },
>  };
>  
> +static const struct s3c24xx_serial_drv_data exynos7870_serial_drv_data = {
> +	EXYNOS_COMMON_SERIAL_DRV_DATA,
> +	/* samsung,uart-fifosize must be specified in the device tree. */
> +	.fifosize = { 0 },
> +};

I don't see any difference against Exynos8895, so they look compatible.
Use Exynos8895 as fallback compatible, even though it is a bit reversed.

Best regards,
Krzysztof

