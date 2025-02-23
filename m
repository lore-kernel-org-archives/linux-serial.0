Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E8BF204C36;
	Sun, 23 Feb 2025 10:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740307422; cv=none; b=g2zmSEG1qQKPjm/NyMcD72Iw7d/AmocsOzrFKvD0Kt7JCmjlay25Gbk22WRgMv0m9y91P64nXtMZJwpTc9mWQnsEfQ8i1StBg0a89zgdj+0uOPboVVfA8mlW5DX9SWKpqhJiWJOrJlD926uTLnoRzgfVGhzS6x1hFAOYYnGzR6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740307422; c=relaxed/simple;
	bh=gaTjpQE8oPZdX5oL+hZ8g0kRaq845zLpmtAxIMeu+aw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M+kXQQ3oONPpmzYZnRyBPxigYAxtc3bHf8Yab5RcVxDCpNF/T/5Cwq/xFQpczkT6VPuUwbGJPUgEcIevbFLOv4kJLLtxOk/oIUWuJOZgEu6I5Txyazpa+rnYPFwCbfKZH/5l5ItnRIoFgIaIE0i3HhF8xYzvF5Mde7ucej6tWHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O4YIjcGs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O4YIjcGs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D59EBC4CEDD;
	Sun, 23 Feb 2025 10:43:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740307421;
	bh=gaTjpQE8oPZdX5oL+hZ8g0kRaq845zLpmtAxIMeu+aw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O4YIjcGskuBH6Ek8D59HBED3gJ+89RCPoWYMUnvtpV7JI2TucINJqu7/nm3JJ1MOF
	 lcKOK7k4zpEjCa4SDS70cq8izTU0HRAUf6KS2Q8K7edIPlgpukSRzlpawOJ12zzG1U
	 SjN6mpYcqTi1629RclwMnH5Db+O7XRaun6mmgiWobD87yJ+FxkeMI83uyWYbG6DPok
	 ACyAme+Dr/akedYYBECKSer92U5FEIMXE7JuNpHJoue5Im5LY745iTyDlbWW2ibSe0
	 5o9kPk/LAgDwlrSNrnudVIm4YrbThHHAo89xqB0HEDuhHugxj9jtjiRWqOAuFSCtKT
	 lQro4vNxDdADw==
Date: Sun, 23 Feb 2025 11:43:38 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Kaustabh Chakraborty <kauschluss@disroot.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: serial: samsung: add exynos7870-uart
 compatible
Message-ID: <20250223-evasive-angelfish-of-realization-8bbbdc@krzk-bin>
References: <20250219-exynos7870-uart-v2-1-c8c67f3a936c@disroot.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250219-exynos7870-uart-v2-1-c8c67f3a936c@disroot.org>

On Wed, Feb 19, 2025 at 12:22:43AM +0530, Kaustabh Chakraborty wrote:
> Document the compatible string for Exynos7870's UART driver. The
> devicetree property samsung,uart-fifosize must be mandatory, as the
> driver enquires about the FIFO sizes. This feature makes it compatible
> with Exynos8895's UART.
> 
> Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

