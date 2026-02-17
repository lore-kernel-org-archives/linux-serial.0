Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 572EC2DB7AA;
	Tue, 17 Feb 2026 08:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771315812; cv=none; b=UEO+FX0d5J7vzyEBEQRGesBagfJ00rKDp21RwUwVYRsWK5W8q4mG2vGhny7uxbdj7vxLKofJBhgRkAL2ORBUChDDk0jJETbdmtb5MmEqQZeH2r571sRe/FfvOMyAYimO8G9R0GNnPDWAZVlRwzNWgOXwC5n/uldxdzxRUygZ9T0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771315812; c=relaxed/simple;
	bh=JES+IBXkN/OopuNkWeM8rDx8cY1hL5qNmn2SSvSLDww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MmZanL0Mwmyi9jpPRQ57nr7VaTtdGUEyC7xzM4Fe0fRt78ugMQvTepTrlRzcL+hbKCFFithbLQ2/e2BGy3CoUGPTy6UAM1gkXEMLabuxM0yA/kecvr12RYpatn2qs2huWPd86zH+PnCrmwfUP21+KxMVjV9pcHIyoYOS0d9DdQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P5VdzwvW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P5VdzwvW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37FC4C19424;
	Tue, 17 Feb 2026 08:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771315811;
	bh=JES+IBXkN/OopuNkWeM8rDx8cY1hL5qNmn2SSvSLDww=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P5VdzwvWLXGyzf38GdKR0DP1zmbtvU7hfd3hlDwwRkW80X4l1SWwX85/mwayZB4/i
	 SNrxQLgJxPOUitED/rP9uOf0WeWZdIRg7+iV/SVR3Vaujf3JtmftZDR0u4ab1nywlH
	 ElR11J92kF75uTgTLkjvF1p5qCJu+TSTTDpKcp5z3WMKkTCYKnViNy96BWo6fuWxX1
	 KScScxH49TMGFhxMjUldGPC/sdm2/Mg5ywYdAAmJ7nC+vLcfzIZHfEP+MhH6bP86jL
	 VR7Xml8I39h3w+kxZt/yxdzWvOXuSPJn5BEs/4AyFYkPXjExqMUg+U7GeCux68/TX6
	 nGfyp/ia8y6gg==
Date: Tue, 17 Feb 2026 09:10:09 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Daniel Baluta <daniel.baluta@oss.nxp.com>
Cc: Larisa Grigore <larisa.grigore@oss.nxp.com>, 
	gregkh@linuxfoundation.org, jirislaby@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, sumit.semwal@linaro.org, christian.koenig@amd.com, 
	chester62515@gmail.com, cosmin.stoica@nxp.com, adrian.nitu@freescale.com, 
	stefan-gabriel.mirea@nxp.com, Mihaela.Martinas@freescale.com, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, devicetree@vger.kernel.org, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, s32@nxp.com, imx@lists.linux.dev, 
	clizzi@redhat.com, aruizrui@redhat.com, eballetb@redhat.com, echanude@redhat.com, 
	jkangas@redhat.com, Radu Pirea <radu-nicolae.pirea@nxp.com>
Subject: Re: [PATCH 09/13] dt-bindings: serial: fsl-linflexuart: add dma
 properties
Message-ID: <20260217-stirring-warping-partridge-dd9531@quoll>
References: <20260216150205.212318-1-larisa.grigore@oss.nxp.com>
 <20260216150205.212318-10-larisa.grigore@oss.nxp.com>
 <5c0251b6-5228-4077-a21f-4da179949b90@oss.nxp.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5c0251b6-5228-4077-a21f-4da179949b90@oss.nxp.com>

On Mon, Feb 16, 2026 at 05:29:57PM +0200, Daniel Baluta wrote:
> 
> On 2/16/26 17:02, Larisa Grigore wrote:
> > [You don't often get email from larisa.grigore@oss.nxp.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> >
> > From: Radu Pirea <radu-nicolae.pirea@nxp.com>
> >
> > Add 'dmas' and 'dma-names' properties to describe optional DMA support
> > for RX and TX channels in the LINFlexD UART controller.
> >
> > This allows the device tree to specify DMA channels used for UART data
> > transfers. If not specified, the driver will fall to interrupt-based
> > operations.
> >
> > Signed-off-by: Radu Pirea <radu-nicolae.pirea@nxp.com>
> > Co-developed-by: Larisa Grigore <larisa.grigore@oss.nxp.com>
> > Signed-off-by: Larisa Grigore <larisa.grigore@oss.nxp.com>
> 
> If both of you worked on this patch then the last lines must read:
> 
> Co-developed-by: Radu Pirea <radu-nicolae.pirea@nxp.com>
> 
> Signed-off-by: Radu Pirea <radu-nicolae.pirea@nxp.com>
> 
> Co-developed-by: Larisa Grigore <larisa.grigore@oss.nxp.com>
> 
> Signed-off-by: Larisa Grigore <larisa.grigore@oss.nxp.com>

No, the DCO with this authorship is correct if they both worked. Nothing
has to be changed here.

Best regards,
Krzysztof

