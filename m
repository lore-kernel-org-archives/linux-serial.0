Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3601219EEBD;
	Mon, 17 Mar 2025 16:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742228887; cv=none; b=cVpe3grGOSVAe6Vke4aFc0VZO7J6aB8mX0p1FzeRehmjvRJ1aB7P+GFYJqnwHjgbLu7rXY6NEC/0QWQiGWO1+h+FeAJmp8HcKSmKnVV6U4qhsHn1IAmQoQk+qWcTGRNrnGvfTI8wPMoBXvqBXZRpmTNgeVoq/iuBHe77LBNgL9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742228887; c=relaxed/simple;
	bh=ZVZb4jCcDrvXrs/O5aeyNMWmVf2cKnbebKhQIZUZXQc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GCc02bxtiA2EWDKe3bVpsO8d5odztNdB2RajcMweki1aIIDPvCMMvAUMaobXdFtorFCkW5TW+PSrrGL8e1N7+GQq512K/n27MjkWh7OyRKVdb+wMh7NMZd2m9K7pZELYwlR5GcAeFyG98IYbXyk70Z5kZCvqHRjL0XZGTb6Xf3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=epaRQui2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="epaRQui2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F584C4CEEC;
	Mon, 17 Mar 2025 16:28:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742228886;
	bh=ZVZb4jCcDrvXrs/O5aeyNMWmVf2cKnbebKhQIZUZXQc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=epaRQui2CqqpUPQ4zQJyNTEAPsH0wAdW1pYN0GnfYnKZGms/3cwuiLtsc1E7H1fgo
	 XUBGTi6HbHJsokqR0MzUjhN3ScQ2xtgIkR1Q8Haq7nt1HRr0CLUf2ogpLjR90Xiwqw
	 hXQ/sgf1kg5WvgXAEXdBEjEqWoduwZNT/0j6G9/RYUT5k4ib/bWaYex6lCsEoNijq6
	 HzpEp5xwShv99Df2AQKQi/PZ07a/bjkOYtfI8PcAFQv3SJVijxqyToxiByIVv800WT
	 uPHaAKKdND/E0AZaczrE5QV5QKuWShx7ac3P2NqdJmje18UfwF7FCE4iOJLN6MlKUV
	 1OqeDE6qyCEAg==
Date: Mon, 17 Mar 2025 11:28:05 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Xianwei Zhao <xianwei.zhao@amlogic.com>
Cc: Jiri Slaby <jirislaby@kernel.org>, Jerome Brunet <jbrunet@baylibre.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-serial@vger.kernel.org, linux-amlogic@lists.infradead.org,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Kevin Hilman <khilman@baylibre.com>, linux-kernel@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH 1/7] dt-bindings: arm: amlogic: add S6 support
Message-ID: <174222888470.174842.6381740588460152313.robh@kernel.org>
References: <20250317-s6-s7-basic-v1-0-d653384e41f3@amlogic.com>
 <20250317-s6-s7-basic-v1-1-d653384e41f3@amlogic.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250317-s6-s7-basic-v1-1-d653384e41f3@amlogic.com>


On Mon, 17 Mar 2025 15:16:52 +0800, Xianwei Zhao wrote:
> Document the new S6 SoC/board device tree bindings.
> 
> Amlogic S6 is an advanced application processor designed for
> hybrid OTT/IP Set Top Box and high-end media box applications.
> 
> Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
> ---
>  Documentation/devicetree/bindings/arm/amlogic.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>

