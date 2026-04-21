Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 180B93BC675;
	Tue, 21 Apr 2026 10:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776767676; cv=none; b=kg8mL+A2B14Jup2PUQwZp45B8ttM84acC8+r0mI4mYCkrSatFDZC6QjnhaCeXJHHKxfxLTY3UUMAdr18S4bvkqsxuYOAEisSDotbo3vRd4cYLq4elPeTXkK+2id4O97/Xc9chJWr78yFflA0pJXffrzh0UxA3yox20OzxC+tCi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776767676; c=relaxed/simple;
	bh=SH0mo2WCb7oNgU42k3b2y9Ijw+YMkFgMBinzKGeUkX0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iKTaeYqBGp+mp9u32aiqUmcCRUCTSZ1FwYsZX3fblcxXtkm9I2qdULBCS/nFbVUkeJB3YAW34hhqjykDpsgfu3s1WnFF9ZBCMlWeYy1MUXulPcoansXs23C7ZTpMixuxsnIT74j3Nnv9lQXNvVD32NV+s9pRdEMx27xA3krYnrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u1n/0ujD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u1n/0ujD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20AB6C2BCB0;
	Tue, 21 Apr 2026 10:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776767675;
	bh=SH0mo2WCb7oNgU42k3b2y9Ijw+YMkFgMBinzKGeUkX0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=u1n/0ujDjpmCFfHUOdrtVH5Z9lNebLKv77Mmhf8H7jZUEUhdUQNlMJMoboXmuCZ4z
	 7y62RTBCPFwY1ZPX9zWDiJlSe0pCNysjlMCJBHmPsqA/QF18hONzEnl0IKfwUIV29e
	 SivR2MZNH5LHsEI/Vk80BY5q4VEMCpW/qO1c67ognakwDf9xBLFZBTZBiY06XOnUi+
	 BrqgDVaQUpmPtXnp1OoeeAyaFw/FTwjkcCqlM5PU9hBUY75+t5vtufjUrbNSQGPQ9E
	 pJa63LALtAgfmxglTykSFzUCDk8oiB9isZRfms03xPumXJqGpHfpzTW29EIUcYa64N
	 hgUUExtk0DJmw==
Date: Tue, 21 Apr 2026 12:34:33 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Shawn Guo <shengchao.guo@oss.qualcomm.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Praveen Talari <quic_ptalari@quicinc.com>, 
	Konrad Dybcio <konradybcio@kernel.org>, Dmitry Baryshkov <lumag@kernel.org>, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, Deepti Jaggi <deepti.jaggi@oss.qualcomm.com>, 
	linux-serial@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: serial: Add compatible for Qualcomm Nord SoC
Message-ID: <20260421-spotted-fiery-crab-4defd7@quoll>
References: <20260420060524.1248432-1-shengchao.guo@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260420060524.1248432-1-shengchao.guo@oss.qualcomm.com>

On Mon, Apr 20, 2026 at 02:05:24PM +0800, Shawn Guo wrote:
> From: Deepti Jaggi <deepti.jaggi@oss.qualcomm.com>
> 
> Document compatibles for QUP GENI UART controller on Nord SoC with
> fallback on SA8255P compatibles.
> 
> Signed-off-by: Deepti Jaggi <deepti.jaggi@oss.qualcomm.com>
> Signed-off-by: Shawn Guo <shengchao.guo@oss.qualcomm.com>
> ---
>  .../bindings/serial/qcom,sa8255p-geni-uart.yaml     | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

