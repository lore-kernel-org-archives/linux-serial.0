Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB5331537CB;
	Mon, 17 Mar 2025 16:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742228901; cv=none; b=r/7iJqoCO9Xopsamt+MC/+FmO6/lgZtMK4KkR8nzARQu8msXcvJeROq4BoDDh0Rio+U+glHbo/88aKk45I0jh7lsDZomzcxmwg3aS6ajEatLNIF2e8/TI/4Owvo1iUrB8+/ZWWABaPbpC84wo7u7Gi1Z6/owxjdc8U3mdl5WjO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742228901; c=relaxed/simple;
	bh=uiemPpna5rz6rmRSiNXvn84q3IoFNY3GCTXNLMa76G8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j0WgfQ42Vexjp0QL5HA02AvmUlMKZmixCiZgVFA1mPis3dGpQDYNKvrFLvRg7bOtYnfpktLaD1FPEEKXbrCRUmajexyavuzO9nFGJC15bebTHTGx85C/ScXtuT0C+U8+nfd3VF08dPz3aj1g/XAJwhs/9sm+xND37thKk1YPVZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YmYOhRgT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YmYOhRgT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17D65C4CEED;
	Mon, 17 Mar 2025 16:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742228901;
	bh=uiemPpna5rz6rmRSiNXvn84q3IoFNY3GCTXNLMa76G8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YmYOhRgTUCy9c4eosSMsk+iVvO8n+jefN6oc5T73q3zQN3kYlrgBrLz6wur7on4dR
	 9jfv/G4ijgIwpSU/Rmqf2t453W1oeTu0R4WQObxWLBHPg6mBForJ0xhX3wxAaZFYeT
	 1hlk9qEKF5yzD412xdFDSCMMdBpG8XOgFx542UCgFT/QZCyV42A7NnCH43OqkT7Q4L
	 DdELdpMR1bKISkhjK77zUG5pPoiUCm8TkfyT+oFpdexKxDE/pGOw7B12dLxFCMvXBd
	 fi1AhuQLuemue+7zEKolFK/MsHTbjqbaczwc+mUyJa3VSuNaSfKUk0LvZMvHopDmba
	 Wdl7oor7mGlEA==
Date: Mon, 17 Mar 2025 11:28:19 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Xianwei Zhao <xianwei.zhao@amlogic.com>
Cc: linux-arm-kernel@lists.infradead.org, Jiri Slaby <jirislaby@kernel.org>,
	Kevin Hilman <khilman@baylibre.com>, devicetree@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	linux-amlogic@lists.infradead.org,
	Neil Armstrong <neil.armstrong@linaro.org>,
	linux-serial@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-kernel@vger.kernel.org, Jerome Brunet <jbrunet@baylibre.com>
Subject: Re: [PATCH 2/7] dt-bindings: arm: amlogic: add S7 support
Message-ID: <174222889947.175239.6799516902581952337.robh@kernel.org>
References: <20250317-s6-s7-basic-v1-0-d653384e41f3@amlogic.com>
 <20250317-s6-s7-basic-v1-2-d653384e41f3@amlogic.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250317-s6-s7-basic-v1-2-d653384e41f3@amlogic.com>


On Mon, 17 Mar 2025 15:16:53 +0800, Xianwei Zhao wrote:
> Document the new S7 SoC/board device tree bindings.
> 
> Amlogic S7 is an advanced application processor designed for
> hybrid OTT/IP Set Top Box and high-end media box applications.
> 
> Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
> ---
>  Documentation/devicetree/bindings/arm/amlogic.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>

