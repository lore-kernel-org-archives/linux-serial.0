Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7784F143722;
	Wed, 29 Jan 2025 16:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738168866; cv=none; b=dpKGI0zTcdk/q1/R4/KOl4qdUzeaqPUUi+3fGU5gzxEVt67rgRwypRvqkBNUvKCsW9rdqMymPswUKOhm0kpZ0xUsh0lrnsOSg5lWQvl78foGNX+wPJCj8MuJ1lHh9qIThUJIzRfnyM2t1bXnt0RScar6r3n+VDbl5p5PP0KZLx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738168866; c=relaxed/simple;
	bh=JJJ6DWavmC9UXfgcPrIaJbwOzYjnHtGngZxY8l2XL0g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NYjk+ApOzpiGpxzGKMtL0wE0AjepwJx0FoHX3GcA1F8O9Aau3rU4ziVvMRPsKorrvHnhgoLY/WOp3YnCEfUBKOnDX5rbB8g7QsQChbHtaUK0TrlAkshvJEISmw1kUUXl22g4lzijG/pUqF/WC13X6qY0x4YT93R6qH4WQnRmPQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UuQE+Q66; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UuQE+Q66"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5D51C4CED1;
	Wed, 29 Jan 2025 16:41:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738168866;
	bh=JJJ6DWavmC9UXfgcPrIaJbwOzYjnHtGngZxY8l2XL0g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UuQE+Q66K8XGxO5uszd8F1QBCxb4Q4PMz7BC4XE+dbIbZreSMvScWS+/5sWavBZBU
	 sJLSLRzsK109cLEhP50u05pKWfPCva6FZMG7TwuwxEeCEk8ZQkdC0bqpNzQ24LSXtl
	 ngBP8m84gTC6fqIQEFrQg/Dg2fMRZ1DKFvRq4IU/LcqIbxfq9E0E5U1nB5mrKmJ/WP
	 rqKE7FHHY2OLMEIoAR7a+RHhQG2glPDqiIM47JFlRhWQVwRe21+cIJNpTccSJ/Colj
	 PN4YmrRRbs9Lnl/tVruXnDu2u3FKkbEWh6z89fvWaHrR2eSSSlQdaHkogw0ipW+avn
	 ag5CuDdcU9dmA==
Date: Wed, 29 Jan 2025 10:41:04 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Manikanta Guntupalli <manikanta.guntupalli@amd.com>
Cc: jirislaby@kernel.org, linux-serial@vger.kernel.org, conor+dt@kernel.org,
	krzk+dt@kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, michal.simek@amd.com,
	gregkh@linuxfoundation.org, radhey.shyam.pandey@amd.com,
	srinivas.goud@amd.com, git@amd.com, manikantaguntupalli09@gmail.com,
	shubhrajyoti.datta@amd.com
Subject: Re: [PATCH] dt-bindings: serial: pl011: Add optional power-domains
 property
Message-ID: <173816886437.2207790.14262610274759862297.robh@kernel.org>
References: <20250129095013.2145580-1-manikanta.guntupalli@amd.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250129095013.2145580-1-manikanta.guntupalli@amd.com>


On Wed, 29 Jan 2025 15:20:13 +0530, Manikanta Guntupalli wrote:
> AMD/Xilinx Versal device serial IP has its own power domain,
> so add an optional property to describe it.
> 
> Signed-off-by: Manikanta Guntupalli <manikanta.guntupalli@amd.com>
> ---
>  Documentation/devicetree/bindings/serial/pl011.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

