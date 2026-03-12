Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC9E72D837C;
	Thu, 12 Mar 2026 13:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773323164; cv=none; b=uWixHm8xN0xAQR4ZNduzrWjj5swYVkmfAdilKqzqaSUA6TiMUZ19i6Hk5ZqRJAKT+ZfM3427B10L2aZuzkF8qbj4gZEyf/mV2Le66R5R4DaCq5ASmLgkNh+7RnhjllbsWXRvBGhwHx5nnrD+fA6FRXdNToVbobCMtbYqehxRFyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773323164; c=relaxed/simple;
	bh=tC35RsqzjjyjLf2nIHQplQZOFFuOpKdWewHzucMI1eE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FPlqHf/qV0V+yvFrPzbgeo7qEI8V1TbOtvQ6FvJiacUlueMemuPyoXTegvDcGdHr9w1XnR7mwULk4aNxq7vjReMj6lD+pL3ru16dD3eeENU9N1QmeUs+uOB8+uhG6rBvJ5KvDx6KLcDv/kYOkTemnIMU6n9TCDPM090vjECF4dU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zy6/l9zc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zy6/l9zc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02077C4CEF7;
	Thu, 12 Mar 2026 13:46:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773323164;
	bh=tC35RsqzjjyjLf2nIHQplQZOFFuOpKdWewHzucMI1eE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Zy6/l9zc52C9xgXBMrB6UV75iyXNovk2H5Zm0OE+TyNEhtB41TFudk358k8AO0SZD
	 vOCAVQIE+vfVZXeTMamdhZteKoxjEDN9q9xDtrEqaQfxLhnYQbHymtSd6ht5y1hYJc
	 v63rfBL4VO9SwrkF48v6qyvHeNusIhSAKbb5gZ/qhMwHydJ+QnBdYrDSI6HmdqZ1aR
	 ZtYQtCvTz8uFeaHCQvUbT9wlcKfUsuE/iDpwUOCntRqf0BjbR+sWqab3TNYEgtryz3
	 70Mav9Y0zzb84nHcsB1GrF7sp9GRNaVebIckcgcB0R8YV8LldCY3wzLXVdJcfFG4LA
	 Kqsd49j7eFqIA==
Date: Thu, 12 Mar 2026 08:46:03 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Yixun Lan <dlan@kernel.org>
Cc: devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	Conor Dooley <conor.dooley@microchip.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Lubomir Rintel <lkundrak@v3.sk>, linux-kernel@vger.kernel.org,
	Jiri Slaby <jirislaby@kernel.org>,
	Guodong Xu <guodong@riscstar.com>, linux-serial@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, spacemit@lists.linux.dev,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH] dt-bindings: serial: 8250: spacemit: fix clock property
 for K3 SoC
Message-ID: <177332316270.2898009.16159680813861530459.robh@kernel.org>
References: <20260304-01-uart-clock-names-v1-1-338483f04a8b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260304-01-uart-clock-names-v1-1-338483f04a8b@kernel.org>


On Wed, 04 Mar 2026 07:19:39 +0000, Yixun Lan wrote:
> The UART of SpacemiT K3 SoC has same clock property as K1 generation which
> request two clock sources, fix the binding otherwise will get DT check
> warnings.
> 
> Fixes: b5024e804ee0 ("dt-bindings: serial: 8250: add SpacemiT K3 UART compatible")
> Signed-off-by: Yixun Lan <dlan@kernel.org>
> ---
>  Documentation/devicetree/bindings/serial/8250.yaml | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>

