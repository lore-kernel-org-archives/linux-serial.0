Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52BDF2FB97B;
	Fri, 17 Jul 2026 08:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784277126; cv=none; b=NOIu3JpboxzOAophEk1bMe1rF3vNBPzrBrS9o2S1zYroksdt0zv0aVbrJih7/EvqTnxbiqwT6DO3y3w/C7VyAKI6W8XrihV2ZTJJgQTzbwjvRdUkAmf1fqBFRICmRvkGipK89Oim34Y/z9+h4vTdj9CF3GigLpZ06OU1RpgV8Ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784277126; c=relaxed/simple;
	bh=B1150FEolT4Sj5jskF2xoZNy5VPqKCLr3UsGC+Io9tQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jZhIyK8SmGL8CHQg/W2SuCopTs/hLdjpCuwS4VlDim0gOF+A/YM8nGeG9fLDZXEC9/POmq+jntKZhYuA+zsNyse5o5TIznl566B3VO0P8BfBuqnN1ezdWBVmXYZ+UrT+z3t4zbznyQeHLZWk46DIHPzWAzQ5Et6ak4ZcZtaneZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K5QN8LUt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K5QN8LUt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A01F1F000E9;
	Fri, 17 Jul 2026 08:32:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784277125;
	bh=B1150FEolT4Sj5jskF2xoZNy5VPqKCLr3UsGC+Io9tQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=K5QN8LUtjGqpCo64YJ1WWJRUe8xPvGTAhqiDiTvkjbud+ZFKKwzL4WUGpgiczOQY3
	 3CKueGy35nboOLYF0ZP/GGT2ZiR2ja6UurRv1N1ggTYhUoQRJiAwgIq87MiXX8C6x8
	 XhI1Jtmx/ICtI/OIE9s687KDlWvo0DRIKYEFvCz9Xfto6O2NnwTDhREzihnPze8n3f
	 V5H5OQT2hsJBszLIMSXg+VrZyGHuNAKe6gXRXe4X4af0JPYXvA7MEVqQoS45FBq+zU
	 pVCeiMnj2RL45e1lSU2+zRldbqSj6KG3n/Z5vBLoU1RP8r6HxkMJW3p1EZLb5WsmHa
	 ELxeMvzW4WR/w==
Date: Fri, 17 Jul 2026 10:32:01 +0200
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
Subject: Re: [PATCH v3 3/8] dt-bindings: i2c: cdns: add Axiado AX3005 I2C
 variant
Message-ID: <20260717-skilled-private-leech-e8c3be@quoll>
References: <20260716-upstream-axiado-ax3005-upstream-v3-0-c429095143ec@axiado.com>
 <20260716-upstream-axiado-ax3005-upstream-v3-3-c429095143ec@axiado.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260716-upstream-axiado-ax3005-upstream-v3-3-c429095143ec@axiado.com>

On Thu, Jul 16, 2026 at 08:51:10PM -0700, Swark Yang wrote:
> Add binding for Axiado AX3005 I2C controller. So far, no changes
> are known, so it can fall back to the cdns,i2c-r1p14 compatible.


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

