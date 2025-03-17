Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F391199FA4;
	Mon, 17 Mar 2025 16:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742228918; cv=none; b=aULO0bcRzef0eDap1qB3cRpAURz0ws50p1K/iJxKfp/qyZxcJHFdPv87G5QIaCu+XP5es9VCvEU/eXk+xaKVoMEWrLtTAYnDraj8GnGQXmRqrlUf9oMQp0iUBrLXXtK+CXQ4QvKRm350GDqCTuHbCrBuCDDeoB2YXCjZ9Pykd+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742228918; c=relaxed/simple;
	bh=zsvLH0eJBggR1J2XUJcBl3DUBqw/nGArkQrX+Pud1z8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y1IT3BDujBeMYP54vi/gqfjl+f7m+EQsLNQHEMvzs37cqDpKtJJ9IMJMbQGvWg0C/syGf0W+0wTpVNej+NYkplOA3Zkv63bwcXGTZ/mZxmgp29U+BuAnZHxvug++FPSjEsuR6/8eL31TZGB6la7hQziABXeKNtfSozhv027O4Po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ouNz4fss; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ouNz4fss"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A8A5C4CEE3;
	Mon, 17 Mar 2025 16:28:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742228918;
	bh=zsvLH0eJBggR1J2XUJcBl3DUBqw/nGArkQrX+Pud1z8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ouNz4fssuiTv4iAiNiC4IiiXc4eYdaM5Ds5MtbMhp2BjG3IWc6/pOP+cmzRRVKBCF
	 kIaM0bNkYXkFg9ShihT5vfCRsAMop5iMe8BE1VmzjfhM66vH9HGZNwLGqSv4zWbKbb
	 a2GBsSvUAU8q1zKFGZ6UvQMDwRcPE9eOyHQp/SWQmr7tMkUundsIrpD+6LlJWPLbXA
	 QFMsMRlUtBJtJUNFddYIaO2p8aZoCgmYorxnZrjSVYXoq5LgvbjQDehdnGbho2XJl5
	 dwFZlSgGr6+WT0TNVMFm6euKytuoR5SpbBebBruu++YcP5AFJXXUaKuYszHvEBkC6O
	 nMQU7JeBxgwXQ==
Date: Mon, 17 Mar 2025 11:28:37 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Xianwei Zhao <xianwei.zhao@amlogic.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
	linux-amlogic@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	Jerome Brunet <jbrunet@baylibre.com>, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	linux-serial@vger.kernel.org, Kevin Hilman <khilman@baylibre.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH 3/7] dt-bindings: arm: amlogic: add S7D support
Message-ID: <174222891679.175685.18314787347681123484.robh@kernel.org>
References: <20250317-s6-s7-basic-v1-0-d653384e41f3@amlogic.com>
 <20250317-s6-s7-basic-v1-3-d653384e41f3@amlogic.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250317-s6-s7-basic-v1-3-d653384e41f3@amlogic.com>


On Mon, 17 Mar 2025 15:16:54 +0800, Xianwei Zhao wrote:
> Document the new S7D SoC/board device tree bindings.
> 
> Amlogic S7D is an advanced application processor designed for
> hybrid OTT/IP Set Top Box and high-end media box applications.
> 
> Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
> ---
>  Documentation/devicetree/bindings/arm/amlogic.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>

