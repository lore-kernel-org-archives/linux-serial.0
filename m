Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C034041843;
	Fri, 15 Dec 2023 19:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lRBkB8ZS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1473C433C7;
	Fri, 15 Dec 2023 19:42:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702669334;
	bh=RHN6Ed0fgIKVWx3mi/jQi+t/oJQO9mY686auJYDuwOU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lRBkB8ZScW6ebe5uPWkKzHERuHCqWCsK/wQCvSrHSRvtrExjKLuvzgJk8EflWyiff
	 5xyRJkWjLSOTpeAwj7KyKmodXnWJFXvK911U55pDY4IRqeIvcTB+3qGbNj0hBSX9ww
	 rQ9Uc+2Sl4Qe8Otw4kW8QJ4o9IK60WHB8v+83oQKgL3DHb4zzNyVlMAajUYHatyXbw
	 Ux16teJFEtotfFT6wWEdfQ+0+GoMnFiAGhAzWmhM+w40OYIY6dL7tCJQcVrfEtyGCM
	 n8FL5BJ/T6DaRR0asFgsIg70bQSfweQTLDGBtzwNo06ccu5BwEq1vt5RTY2nu/Z6P2
	 oSDLdMM3APNIA==
Received: (nullmailer pid 271794 invoked by uid 1000);
	Fri, 15 Dec 2023 19:42:10 -0000
Date: Fri, 15 Dec 2023 13:42:10 -0600
From: Rob Herring <robh@kernel.org>
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: will@kernel.org, jirislaby@kernel.org, alim.akhtar@samsung.com, arnd@arndb.de, peter.griffin@linaro.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, s.nawrocki@samsung.com, andi.shyti@kernel.org, linux-serial@vger.kernel.org, saravanak@google.com, sboyd@kernel.org, cw00.choi@samsung.com, linux-i2c@vger.kernel.org, andre.draszik@linaro.org, robh+dt@kernel.org, willmcvicker@google.com, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, tomasz.figa@gmail.com, conor+dt@kernel.org, catalin.marinas@arm.com, linux-samsung-soc@vger.kernel.org, gregkh@linuxfoundation.org, krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com, semen.protsenko@linaro.org
Subject: Re: [PATCH 03/13] dt-bindings: i2c: exynos5: add google,gs101-hsi2c
 compatible
Message-ID: <170266933016.271733.6481546184634336779.robh@kernel.org>
References: <20231214105243.3707730-1-tudor.ambarus@linaro.org>
 <20231214105243.3707730-4-tudor.ambarus@linaro.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231214105243.3707730-4-tudor.ambarus@linaro.org>


On Thu, 14 Dec 2023 10:52:33 +0000, Tudor Ambarus wrote:
> Add google,gs101-hsi2c dedicated compatible for representing
> I2C of Google GS101 SoC.
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> ---
>  Documentation/devicetree/bindings/i2c/i2c-exynos5.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>

