Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E23A137750;
	Sun, 19 Oct 2025 02:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760839369; cv=none; b=fnEhiMcFjo7F03d7dXYzlWx36k6r39e1PwVGu7q4Pc7M62FwnHB36ewiVVu4rLWykY1/o4AXTUVZFTf0yzmjFKGxKGKo8YnObzf661LusamCYf4UF8f+1SoX3Ht9hpE9x7JlOfsckupTxxrr8z8gf1MTLBNbBUHo8sTQnjeNcDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760839369; c=relaxed/simple;
	bh=x2EO3W9+QwWgfWMo+S/1DHswU5yldySvuI6dvcu1C4U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MSKEkBJy4ht8SR3DYJD6bcux/9OlfePYrZGF4p32nJvG+EAJlSI8BuhPGQrxn8itZkFRQIfrUQ1ifGdHgXm3Neq/otH+QHgC9/HqpWdkaNlxsW8RSutOkDXYkf1mxhzIqi1zasgxz4Z2adcqyPOxfKq8EPMITewAFnlpMPpHARI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1vAIke-000000005VK-0PXI;
	Sun, 19 Oct 2025 02:02:28 +0000
Date: Sun, 19 Oct 2025 03:02:24 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Matthias Brugger <matthias.bgg@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Yu Jiaoliang <yujiaoliang@vivo.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Changqi Hu <changqi.hu@mediatek.com>,
	Sam Shih <sam.shih@mediatek.com>,
	Steven Liu <steven.liu@mediatek.com>,
	John Crispin <john@phrozen.org>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v3] serial: 8250_mtk: Enable baud clock and manage in
 runtime PM
Message-ID: <aPRGsKGDrYlyoTje@makrotopia.org>
References: <de5197ccc31e1dab0965cabcc11ca92e67246cf6.1758058441.git.daniel@makrotopia.org>
 <939cea9e-d7bd-4a13-b462-17e483f61e4c@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <939cea9e-d7bd-4a13-b462-17e483f61e4c@gmail.com>


On Wed, Sep 17, 2025 at 12:00:57PM +0200, Matthias Brugger wrote:
> On 16/09/2025 23:37, Daniel Golle wrote:
> > Some MediaTek SoCs got a gated UART baud clock, which currently gets
> > disabled as the clk subsystem believes it would be unused. This results in
> > the uart freezing right after "clk: Disabling unused clocks" on those
> > platforms.
> > 
> > Request the baud clock to be prepared and enabled during probe, and to
> > restore run-time power management capabilities to what it was before commit
> > e32a83c70cf9 ("serial: 8250-mtk: modify mtk uart power and clock
> > management") disable and unprepare the baud clock when suspending the UART,
> > prepare and enable it again when resuming it.
> > 
> > Fixes: e32a83c70cf9 ("serial: 8250-mtk: modify mtk uart power and clock management")
> 
> Most of the issues from this commit are already fixed in
> b6c7ff2693ddc ("serial: 8250_mtk: Simplify clock sequencing and runtime PM")
> which is more or less a revert of e32a83c70cf9.
> 
> I think we should add
> Fixes: b6c7ff2693ddc ("serial: 8250_mtk: Simplify clock sequencing and runtime PM")
> here as well. It's a fix of a fix :)

Just a friendly ping about this patch :)
Should I resend the patch with the added Fixes:-tag? Or can it be merged
including the tag added my Matthias without a resend?


> 
> Regards,
> Matthias
> 
> 
> > Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> > Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> > ---
> > v3: squash into single patch
> > v2: add managing run-time PM in dedicated patch
> > 
> >   drivers/tty/serial/8250/8250_mtk.c | 6 ++++--
> >   1 file changed, 4 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/tty/serial/8250/8250_mtk.c b/drivers/tty/serial/8250/8250_mtk.c
> > index b44de2ed7413..5875a7b9b4b1 100644
> > --- a/drivers/tty/serial/8250/8250_mtk.c
> > +++ b/drivers/tty/serial/8250/8250_mtk.c
> > @@ -435,6 +435,7 @@ static int __maybe_unused mtk8250_runtime_suspend(struct device *dev)
> >   	while
> >   		(serial_in(up, MTK_UART_DEBUG0));
> > +	clk_disable_unprepare(data->uart_clk);
> >   	clk_disable_unprepare(data->bus_clk);
> >   	return 0;
> > @@ -445,6 +446,7 @@ static int __maybe_unused mtk8250_runtime_resume(struct device *dev)
> >   	struct mtk8250_data *data = dev_get_drvdata(dev);
> >   	clk_prepare_enable(data->bus_clk);
> > +	clk_prepare_enable(data->uart_clk);
> >   	return 0;
> >   }
> > @@ -475,13 +477,13 @@ static int mtk8250_probe_of(struct platform_device *pdev, struct uart_port *p,
> >   	int dmacnt;
> >   #endif
> > -	data->uart_clk = devm_clk_get(&pdev->dev, "baud");
> > +	data->uart_clk = devm_clk_get_enabled(&pdev->dev, "baud");
> >   	if (IS_ERR(data->uart_clk)) {
> >   		/*
> >   		 * For compatibility with older device trees try unnamed
> >   		 * clk when no baud clk can be found.
> >   		 */
> > -		data->uart_clk = devm_clk_get(&pdev->dev, NULL);
> > +		data->uart_clk = devm_clk_get_enabled(&pdev->dev, NULL);
> >   		if (IS_ERR(data->uart_clk)) {
> >   			dev_warn(&pdev->dev, "Can't get uart clock\n");
> >   			return PTR_ERR(data->uart_clk);
> 
