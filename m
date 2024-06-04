Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE714144D21;
	Tue,  4 Jun 2024 12:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717502431; cv=none; b=siJl7B+GWUixPsvZ6gamoDAXR6i8J8Pp4X3lMyCcEp2pAC9a3Pw25ZdCoz3Q5Cte9tSUBIveyyDsjLPLhYcomHovHS7XcgUTr8vwGcgaf5TK/ejvV4npxh5msmjLYcNsr0czd3sSPCl54gCgzE3Xw9LEg9F6eEAWxhmpXDWlf5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717502431; c=relaxed/simple;
	bh=uqC1CdqJrQZsKoI9p56FyhoJ8ZKHafWpVDbwRS7y2lo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T+0sio6rQB8JciSWImzyxC936byA/XNgCRss90jLJleJzWlZS3ofW3u+PPo0b4hVdhfAY7czwgzAXrkEUNEksuf875+2GIvOlIslWix18dl8Wjsw9SLaBm4LLsmL6zrfiR89ApzOGyHP3QBaVN6qUO1JRiMGJ/Sko39IJooKCR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bXUi4eQa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bXUi4eQa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83A6EC2BBFC;
	Tue,  4 Jun 2024 12:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1717502430;
	bh=uqC1CdqJrQZsKoI9p56FyhoJ8ZKHafWpVDbwRS7y2lo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bXUi4eQa0Ms/AUNphYr4mmeszGwtmlI2nrH4Fgpb2tDaW7KxBo64jhMx9bjrbG+fB
	 OSnDStbCivdLQ6SqQd4lOEQ828Tsr7/vxPG8zuxoXzXikpls8hoc+Edz0ySuDei7Ec
	 WbYysoeGZ9P7TdMnc0+mSBK8Kr4Yjm2US1qXqNjI=
Date: Tue, 4 Jun 2024 13:56:00 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Jiri Slaby <jirislaby@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Mark Brown <broonie@kernel.org>,
	Lubomir Rintel <lkundrak@v3.sk>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH] spi: dt-bindings: marvell,mmp2-ssp: Merge PXA SSP into
 schema
Message-ID: <2024060451-stuffed-letdown-23ba@gregkh>
References: <20240522132859.3146335-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240522132859.3146335-1-robh@kernel.org>

On Wed, May 22, 2024 at 08:28:58AM -0500, Rob Herring (Arm) wrote:
> The Marvell PXA SSP block is the same or similiar to the MMP2 variant.
> The only difference in the binding is the PXA version supports DMA (and
> that's probably a binding difference rather than an actual h/w
> difference).
> 
> The old binding didn't belong under 'serial' as it is not a UART. The
> SSP block also supports audio devices, so 'spi' is not a perfect fit
> either. As the existing schema for MMP2 is there, just leave things
> as-is.
> 
> The examples in the old text binding were pretty out of sync with
> reality. 'clock-names' and 'ssp-id' aren't documented nor used.
> 
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>  .../bindings/serial/mrvl,pxa-ssp.txt          | 64 -------------------
>  .../bindings/spi/marvell,mmp2-ssp.yaml        | 35 ++++++++--
>  2 files changed, 31 insertions(+), 68 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/serial/mrvl,pxa-ssp.txt
> 

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
