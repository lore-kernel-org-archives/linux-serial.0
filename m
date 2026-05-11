Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE435309F09;
	Mon, 11 May 2026 15:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778512870; cv=none; b=C+nhICe2y/X3AhS9Vi1FPP+xgOd+dcZOb6x+JZwcFTouN2AIiVcxWh/TFXS30H490cbvjQsGes2/zz7vhArTd+RTBeyqa8cKZyHofT5zCeC6k5iIbtYMXmuBHzxIY/RuFDqVHIfFZ7inBrOo+3pqi+DuWh3CWVtMmt8ViqkNJdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778512870; c=relaxed/simple;
	bh=8oqFWVgjB8MwbkFxRTVgr25mkcf2PDeCLuulyJg4RtA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W/f54c/leroMuI+6FPMV5rQjHaOduN3hQrGmrf2EhsF88011tIliDKoioARbzZeQ9VX+Ims3OGPRJ5kL36UyrqnToV03kFT9agO3Gi8F+A5QhLdhHVq1uCKiLrzcS0mLVJxB30bLGjmIl8d3N2BJPntztVbuMyCqn+x2WkjKTvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=m3+zTQWz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PWXNKOO7; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="m3+zTQWz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PWXNKOO7"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id EC0241400023;
	Mon, 11 May 2026 11:21:07 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Mon, 11 May 2026 11:21:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1778512867;
	 x=1778599267; bh=1v1/Nkb3Sj9Lv5pi2AI2Kg5bSWc5TajvUAqgVnj6mMg=; b=
	m3+zTQWzeNqB/h3a9oa/87YyYGOgPLKejXCnuwn/x6JfGFDZNY0U9dLBjuCLPZGK
	I/6JIw3x5NynI+qKlt3IrOoJomCX/aBUxIk4GdARxxP7/gsGynTxZ+elFPRPBV8w
	B0NECcIBO8c51ygY9Wqai6vv9aTmAC4DrFedRUcA34hizj/xrG/x4RxazFmUVhWT
	aQCBi4zzh6we80QUv+Cz2dv2mTARFmjxU4FHd2zcjN+eJg/CLQGwCqKeqmrpQlof
	v7wxd7WUYOF/W5nWx6qhi+xbqooBqhT/sbdx+r02sBGmfOpn5h+QxyGNJks7Lt7O
	lbH9zMqAXxIIJNFIOHtcpA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1778512867; x=
	1778599267; bh=1v1/Nkb3Sj9Lv5pi2AI2Kg5bSWc5TajvUAqgVnj6mMg=; b=P
	WXNKOO7aeDCszQ9Gu2sBRSDxPWvYmreGBIDN3s8vE49j3v9i/m/B+Y5Ld+FGyBbX
	wR/j7mNZt9CGMDBSMzJXzMJTIsHd+ZyoetlP2hSYP6tJuKFU7vKZjUb4GckGSQdL
	Qm2qyLZjJ5Gft0Hpx9BmKde3RinBlBTh/VRycU1CPIbvhbP61MhAJeeZiHeJc+ha
	cH+EVB2qtn0L/jwfXkh3D4JX2kKyrAXTdjfadEQD21zdN7aJX8nu8nYCdBF43tt/
	Fbgvt5yEc2waPilb5/IO/rPdqp9F1t4wf7uhJp2zQiHxXR74JcjNF6TSZVVzyk11
	k1se3cC+pwnXsxdCGXFCQ==
X-ME-Sender: <xms:4_MBarPN1uTd7FjYW_gmrktgPvSKO3sZ1hRC7Y0VMq_7YXm_DK2yhg>
    <xme:4_MBaoNrFkYQUldiuWfA4eFbwBcb_i0bIo7Asdmu5fbZbzc296FqHbLbbCLi8McDq
    M3DC34MhfN07kKLrnWEsV9BI8tJ-7aInHAjGguR7X5vOCsGPck>
X-ME-Received: <xmr:4_MBashUK55w3HRFg-7EHKc0Lc2_C2F8he4Ez6cNFVjDXIH9yxkQ3801fOptWrfV49BK3EUN6DcaTz7Dlt5xR-4Wvg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduudelvdejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtugfgjgesthekre
    dttddtjeenucfhrhhomhepifhrvghgucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheq
    necuggftrfgrthhtvghrnhepgfekffeifeeiveekleetjedvtedvtdeludfgvdfhteejje
    eiudeltdefffefvdeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghi
    lhhfrhhomhepghhrvghgsehkrhhorghhrdgtohhmpdhnsggprhgtphhtthhopeeipdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehvhihnughikhhtuhhssehgmhgrihhlrdgt
    ohhmpdhrtghpthhtoheplhhinhhugidqshgvrhhirghlsehvghgvrhdrkhgvrhhnvghlrd
    horhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghl
    rdhorhhg
X-ME-Proxy: <xmx:4_MBals3rm2CbGw9CKr9KCJptlBouhoXqYfqgXYXZSu006agQKxPVg>
    <xmx:4_MBaiQognL553UJmoJ4vJP1GaPbeSi4yLdqScKmTV-gLIzaoV2JlA>
    <xmx:4_MBah3P-DzRWAuM1tze-7-CdaQGPqs7UY8xds-VqcVMHCE0XUJhUw>
    <xmx:4_MBavuYmgju0AV9W019cBf6GBEJin12TGq77pyuicQMToUW20SlsQ>
    <xmx:4_MBahMDY5d74q_eeFW8GEIZPB1lkn3ySYgnGcGMC2UMFELDSszpXtNd>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 May 2026 11:21:07 -0400 (EDT)
Date: Mon, 11 May 2026 17:21:06 +0200
From: Greg KH <greg@kroah.com>
To: vyndiktus@gmail.com
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tty: serial: qcom-geni: re-arm RX DMA on spurious
 zero-length interrupt
Message-ID: <2026051150-pacifist-yogurt-aa59@gregkh>
References: <20260422-qcom-geni-uart-dma-rearm-v1-1-76d13aac7fdf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260422-qcom-geni-uart-dma-rearm-v1-1-76d13aac7fdf@gmail.com>

On Wed, Apr 22, 2026 at 04:13:03PM +0000, Vynnie Von Diktus via B4 Relay wrote:
> From: Vynnie Von Diktus <vyndiktus@gmail.com>
> 
> qcom_geni_serial_handle_rx_dma() returns early when SE_DMA_RX_LEN_IN
> reads as zero, interpreting it as a spurious interrupt. The early return
> skips geni_se_rx_dma_prep(), leaving the RX DMA descriptor permanently
> unarmed. All subsequently received bytes are silently dropped until the
> port is closed and reopened.
> 
> On cold boots, chip startup transients on the UART lines can produce a
> genuine spurious DMA interrupt with a zero-length count. The bug is
> invisible on warm reboots (the UART stays powered and stable, so no
> spurious interrupt fires), which makes it appear as an intermittent
> failure only on power-cycle reboots.
> 
> Fix by restructuring the zero-length check to fall through to
> geni_se_rx_dma_prep() in all cases. Only the data processing
> (handle_rx_uart) is skipped when no bytes arrived.
> 
> Tested on SM8150 (Snapdragon 855) with a WCN3990 BT UART — Bluetooth
> firmware download now succeeds on every cold boot without
> "Frame reassembly failed" errors.
> 
> The same GENI serial IP block is used across SDM845, SM8150, SM8250,
> SM8350 and many other Snapdragon SoCs; the bug and fix are expected to
> apply to all of them.
> 
> Signed-off-by: Vynnie Von Diktus <vyndiktus@gmail.com>
> ---
>  drivers/tty/serial/qcom_geni_serial.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
> index 69a632fef..3c950bdc0 100644
> --- a/drivers/tty/serial/qcom_geni_serial.c
> +++ b/drivers/tty/serial/qcom_geni_serial.c
> @@ -837,11 +837,9 @@ static void qcom_geni_serial_handle_rx_dma(struct uart_port *uport, bool drop)
>  	rx_in = readl(uport->membase + SE_DMA_RX_LEN_IN);
>  	if (!rx_in) {
>  		dev_warn(uport->dev, "serial engine reports 0 RX bytes in!\n");
> -		return;
> -	}
> -
> -	if (!drop)
> +	} else if (!drop) {
>  		handle_rx_uart(uport, rx_in, drop);
> +	}
>  
>  	ret = geni_se_rx_dma_prep(&port->se, port->rx_buf,
>  				  DMA_RX_BUF_SIZE,
> 
> ---
> base-commit: 4a8d8848356e9e4c41e22de9b1ef1507ea21734a
> change-id: 20260422-qcom-geni-uart-dma-rearm-a5df83e164ff
> 
> Best regards,
> --  
> Vynnie Von Diktus <vyndiktus@gmail.com>

Does not apply to the tty-next tree :(

