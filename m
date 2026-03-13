Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDBCD31F9A0;
	Fri, 13 Mar 2026 07:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773385567; cv=none; b=rBg04Z/zvKujo0XQLUbO7s5x5oThiZiCmDObMpHeguQvUcPHvtcrJHYu8AhHoLE4VBWUNobCJFXSFO/MBtMxqicF3CpFlK+Az8AAFZKWUQnlmYzj7cf4+GYuf4tcxEt8hmRbjmSUt3K/XTtqlBIdCv3iO6bU5a+tKdYeRx8SNNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773385567; c=relaxed/simple;
	bh=cFxTeORzoBh5yrTQu5gbFRopOPKKtVbksSq1U5jNLFY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zpbu3ONQUmwvRxcvP8BbKIV7NQkC64vUOpXvtVnOCpC3ONABV2s0Kbj3ySQiHi1yza0YfsxEObJUtCJ5z/mn0qBcmL3p5Jx9bTRswtK0C0Kzw+amU8P8O8D593MSaRSF7oIIbuho7+FSqFc44RfDRiBKwUEb5zCLRV1cwxKPhdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZtrhaIr1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZtrhaIr1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A197C19421;
	Fri, 13 Mar 2026 07:06:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773385566;
	bh=cFxTeORzoBh5yrTQu5gbFRopOPKKtVbksSq1U5jNLFY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZtrhaIr1MRpUh8c6OylnW1rHwx8y+dXU12D78Veri7x8Y94WUujRcJixgZGDj5Llt
	 3mKATdISePftWdwKyniGUmendfmLZv+gTgADzFKn1vYpDihXNsCrzrhWL9qnMVLoYG
	 l1i71ZKmBpIpURBqmPIEuMwxNAy5e993yYApmkyo=
Date: Fri, 13 Mar 2026 08:06:02 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Yixun Lan <dlan@kernel.org>
Cc: Yixun Lan <dlan@gentoo.org>, Jiri Slaby <jirislaby@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Lubomir Rintel <lkundrak@v3.sk>,
	devicetree@vger.kernel.org, Guodong Xu <guodong@riscstar.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev
Subject: Re: [PATCH] dt-bindings: serial: 8250: spacemit: fix clock property
 for K3 SoC
Message-ID: <2026031357-storeroom-repurpose-f680@gregkh>
References: <20260304-01-uart-clock-names-v1-1-338483f04a8b@kernel.org>
 <20260310093446-GYC318052@gentoo.org>
 <2026031226-utter-spellbind-53bf@gregkh>
 <20260313011910-GKL302167@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260313011910-GKL302167@kernel.org>

On Fri, Mar 13, 2026 at 09:19:10AM +0800, Yixun Lan wrote:
> Hi Greg,
> 
> On 15:13 Thu 12 Mar     , Greg Kroah-Hartman wrote:
> > On Tue, Mar 10, 2026 at 05:34:46PM +0800, Yixun Lan wrote:
> > > Hi Greg, Jiri,
> > > 
> > >   Do you mind if I taking this patch via SpacemiT's SoC tree? and if
> > > possible, it would be nice to have your Acks..
> > > (or either way works for me, if you grab it and merged via tty tree)
> > > 
> > > On 07:19 Wed 04 Mar     , Yixun Lan wrote:
> > > > The UART of SpacemiT K3 SoC has same clock property as K1 generation which
> > > > request two clock sources, fix the binding otherwise will get DT check
> > > > warnings.
> > > > 
> > > > Fixes: b5024e804ee0 ("dt-bindings: serial: 8250: add SpacemiT K3 UART compatible")
> > > I would just drop the Fixes tag, as I think at the time of Gudong
> > > submitting the patch, the clock driver isn't ready, so he deliberatly
> > > removed this clock contraint and provided with a fixed clock frequency
> > > (the bindings match with DTS)
> > > 
> > > https://github.com/torvalds/linux/blob/v7.0-rc3/arch/riscv/boot/dts/spacemit/k3.dtsi#L414
> > 
> > You need to get a DT maintainer to review it before you can apply it.
> Ok, so Rob gave an Ack
> 
> > If you want to take it through your tree once that happens, that's fine
> > with me.
> Thanks, so this imply an Ack, but could give an explict Acked-by?
> then I will proceed..

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
