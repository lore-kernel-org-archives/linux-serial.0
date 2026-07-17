Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F90C382F0A;
	Fri, 17 Jul 2026 08:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784277164; cv=none; b=DC69OzOnEAUGXtB9MvDTgPAWRe2CZYBx5SJHJlNkDkuXv8kaDgurHiTQdB+zzsPWFi2OkOr83kiY1w0FK1X8W0Hb7jzKemQEf75pu6tM3Mn7v0OwTLIuyH97DDt4ND/xkuLbyhDKbEz3esUuW/09FpR4Rj1hOU6rWqA8862Bg5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784277164; c=relaxed/simple;
	bh=uKF8zWjsO8C4eZElhhHPG63DmHvGmo69OPgs9JwPprY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N/EGgpEsvtafExjB6ZQnszssXTtow1mjvQXAPIbuVbGTxExefGSYxGq07SzE2xKMEZBwxIgI9IV0jWrmR0JxpQcPUIVCSa8V052RItZ7o7RPloyCQM52CABYDu7jOs03yx7rgH5sIAxiRcFf5EgYgy29GUTbn5ZOxYGImGd4AhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cNPpMCAf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cNPpMCAf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 408571F000E9;
	Fri, 17 Jul 2026 08:32:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784277162;
	bh=EoSnQBbtzGT4em187vuUWyzc6o09JzeyLkYsJZ+Z9kg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=cNPpMCAfq4lnDaUIbbn+a4XsST4epNsHJpyeeSwp2Un9vdTL1b5x9kNRrd5gr2g4I
	 EcT6Fg/IKuqzNnBWS9z3mgqnRgblvhRhgY8fzweQSUsocXikEdEyiV1a1IK3rsGKFe
	 T4sGiaWA7nBVEH0pQ6F8QaJ2F3QXfKrQhqTBkxGShzPck4vihPFPcTWzCL9dMFJ891
	 tnF7TcHD0kRMgm3Xwc6afFvt29WlrIEPnIEBuJdMXWdhrNRY0hEdxScKSHIve0VBC3
	 uEuMD+z8euHSb1PnpZDVHGuViIdmpLKykGcSNMnV5O2LTGJ32jdEMvLevFCQL/mmsy
	 mUJ4IV1FfE4zg==
Date: Fri, 17 Jul 2026 10:32:39 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Swark Yang <syang@axiado.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Harshit Shah <hshah@axiado.com>, Linus Walleij <linusw@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, Jan Kotas <jank@cadence.com>, 
	Michal Simek <michal.simek@amd.com>, Andi Shyti <andi.shyti@kernel.org>, 
	=?utf-8?Q?Przemys=C5=82aw?= Gaj <pgaj@cadence.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	Frank Li <Frank.Li@nxp.com>, Boris Brezillon <bbrezillon@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Mark Brown <broonie@kernel.org>, Mathias Nyman <mathias.nyman@intel.com>, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, linux-i2c@vger.kernel.org, 
	linux-i3c@lists.infradead.org, linux-serial@vger.kernel.org, linux-spi@vger.kernel.org, 
	linux-usb@vger.kernel.org
Subject: Re: [PATCH v3 5/8] dt-bindings: serial: cdns: add Axiado AX3005 UART
 variant
Message-ID: <20260717-stalwart-sandy-orca-6c5a8a@quoll>
References: <20260716-upstream-axiado-ax3005-upstream-v3-0-c429095143ec@axiado.com>
 <20260716-upstream-axiado-ax3005-upstream-v3-5-c429095143ec@axiado.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260716-upstream-axiado-ax3005-upstream-v3-5-c429095143ec@axiado.com>

On Thu, Jul 16, 2026 at 08:51:12PM -0700, Swark Yang wrote:
> Add binding for Axiado AX3005 UART controller. So far, no changes
> are known, so it can fall back to the cdns,uart-r1p12 compatible.
> 
> Signed-off-by: Swark Yang <syang@axiado.com>
> ---
>  Documentation/devicetree/bindings/serial/cdns,uart.yaml | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

