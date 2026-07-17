Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45DCD3E3C62;
	Fri, 17 Jul 2026 08:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784277142; cv=none; b=TSEh/QJgRNNsbBcB6VG/uq5A0UAPZ9Czxsbe1pDo7F3sUxQ3n9SiqeSRAwH0DzI5omHYK87F/ExR+TQS6vZRV1y/Zc4/dWV9cclDjh0JHFOlaudQRJrcmboheTp9ZaC9xDmYe/b8UDjjM6ZgMKpayslCCQsPfrGK27C2fAVZY/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784277142; c=relaxed/simple;
	bh=mnk9dENboNpFgZKjd96cOxg2sEen6QQfx5mpA7HW+Rg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q2RcuR9EgE19hg1aRdxm6PrhVDN52hMqJFo8FA9uw+V3XV4PiQ6pFNLBBiRYRy6opL28HOzVSq1DnHqBQHalo6QMOFah+zRSIsP1pc2TkOkrYTKbbFnUvlziUq85kvBWF7VDrSJbuAWIZ6IFzviq9E9ynUwOqShZIs+GMyhayxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EWG0PmBs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EWG0PmBs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 600FE1F000E9;
	Fri, 17 Jul 2026 08:32:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784277140;
	bh=XSZWX5xFW0sVcWlHSb+4MgJ4CgTapTVN8LsIk7/nm/8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=EWG0PmBskngtBjqNBmrVsVSBFqYpucErvCXUeoY1LPeUz4W37bkXZIsScvNuFQOL9
	 IConoJndUypWgtq5JTV2kKRJS9cNFHy0OsA7rp8LOWdRhUTTKNWojQacmIQH4/Kc9B
	 BARghgtdWg05RSb2lk2Lr4h410Pw6CoixuD3CM9yJDJc4xfBIlNZ8e5hz5tdZry66A
	 TkmiIgguw0SWhZqBNzpHzSr6hJJYVhPOYUIT7qmBmf+2F7UDxTKaJMNr017IBaGTfQ
	 flFTCdN9yk8d9fB08dOKJ+NnVfW5KLi0OYGGqKu/jCUdl4BvKPAqHdqDsQoB4ArGS1
	 guf6VOiY/S4bg==
Date: Fri, 17 Jul 2026 10:32:16 +0200
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
Subject: Re: [PATCH v3 4/8] dt-bindings: i3c: cdns: add Axiado AX3005 I3C
 variant
Message-ID: <20260717-rainbow-innocent-mantis-eb246a@quoll>
References: <20260716-upstream-axiado-ax3005-upstream-v3-0-c429095143ec@axiado.com>
 <20260716-upstream-axiado-ax3005-upstream-v3-4-c429095143ec@axiado.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260716-upstream-axiado-ax3005-upstream-v3-4-c429095143ec@axiado.com>

On Thu, Jul 16, 2026 at 08:51:11PM -0700, Swark Yang wrote:
> Add binding for Axiado AX3005 I3C master. So far, no changes
> are known, so it can fall back to the cdns,i3c-master compatible.
> 
> Signed-off-by: Swark Yang <syang@axiado.com>
> ---
>  Documentation/devicetree/bindings/i3c/cdns,i3c-master.yaml | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

