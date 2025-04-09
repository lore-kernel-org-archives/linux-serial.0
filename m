Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 082232144C4;
	Wed,  9 Apr 2025 23:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744243157; cv=none; b=oIEz8yCm41AGfodNpnDF63F34Iaghd5oGlfEktDrt5hW6mejfkjhDeU2sr0N5DifzWqNnxvpNMg6siJwtjLdMVSf8LffYvATCO2BgwYgQ773MbxU8HI0mOVQeAFQYIxEnSTwxY2rXjnOrOjxlZmYG4Zh8YEC6UwkENOxrXo88Kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744243157; c=relaxed/simple;
	bh=fbizQkJURv/VI4ti6Z1JNgUGnYq1ZQ73QlfCFSh6YFs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RawUuz+QRiy0SxngPhLbjfZFq7574DotMyTm2efu0PI37gIYOKot/YAnpSSjYxSY5GWXrzW/5RmgEfZJtLeiJr+dh5KXnx5zl8gSR8DjAOBTBn8cFnU5iU2ALLQHaWfBolNEy9kIwg/UcmZezg/Lku/qhVbn4Tt/xu/PBgKdyXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from localhost (unknown [116.232.27.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dlan)
	by smtp.gentoo.org (Postfix) with ESMTPSA id C5016343371;
	Wed, 09 Apr 2025 23:59:13 +0000 (UTC)
Date: Wed, 9 Apr 2025 23:59:09 +0000
From: Yixun Lan <dlan@gentoo.org>
To: Alex Elder <elder@riscstar.com>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org,
	benjamin.larsson@genexis.eu, bastien.curutchet@bootlin.com,
	andriy.shevchenko@linux.intel.com, u.kleine-koenig@baylibre.com,
	lkundrak@v3.sk, devicetree@vger.kernel.org,
	linux-serial@vger.kernel.org, spacemit@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] serial: 8250_of: add support for an optional bus
 clock
Message-ID: <20250409235909-GYB19066@gentoo>
References: <20250409192213.1130181-1-elder@riscstar.com>
 <20250409192213.1130181-3-elder@riscstar.com>
 <20250409214345-GYA19066@gentoo>
 <04facbe3-cd40-4d79-a204-2b91880da331@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <04facbe3-cd40-4d79-a204-2b91880da331@riscstar.com>

Hi Alex,

On 17:47 Wed 09 Apr     , Alex Elder wrote:
> On 4/9/25 4:43 PM, Yixun Lan wrote:
> > Hi Alex,
> > 
> > On 14:22 Wed 09 Apr     , Alex Elder wrote:
> >> The SpacemiT UART requires a bus clock to be enabled, in addition to
> >> it's "normal" core clock.  Look up the optional bus clock by name,
> >> and if that's found, look up the core clock using the name "core".
> >>
> >> Supplying a bus clock is optional.  If no bus clock is needed, the
> >> the first/only clock is used for the core clock.
> >>
> >> Signed-off-by: Alex Elder <elder@riscstar.com>
> >> ---
> >> v2: Update logic to more check for the optional bus clock first
> >>
> >>   drivers/tty/serial/8250/8250_of.c | 11 ++++++++++-
> >>   1 file changed, 10 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/tty/serial/8250/8250_of.c b/drivers/tty/serial/8250/8250_of.c
> >> index 11c860ea80f60..a90a5462aa72a 100644
> >> --- a/drivers/tty/serial/8250/8250_of.c
> >> +++ b/drivers/tty/serial/8250/8250_of.c
> >> @@ -123,7 +123,16 @@ static int of_platform_serial_setup(struct platform_device *ofdev,
> >>   
> >>   	/* Get clk rate through clk driver if present */
> >>   	if (!port->uartclk) {
> >> -		info->clk = devm_clk_get_enabled(dev, NULL);
> >> +		struct clk *bus_clk;
> > we also need to handle clk in suspend/resume procedure, so
> > I think you need to put bus_clk inside struct of_serial_info..
> 
> OK, I didn't do anything for that in previous versions of the
> series.
> 
> I think that means we'd call clk_disable_unprepare() on
> the bus clock after doing so for the function clock.  And
> clk_prepare_enable() on the bus clock before doing that for
> the function clock in of_serial_resume().  That's easy.
> 
right, pretty much similar to info->clk

> Is there anything further you think is required?  There is
> no clock rate associated with the bus clock that I know of,
> so even if the function clock rate changes, the bus clock
> can remain as-is.
> 
no further info I know of, my best guess, the rate doesn't
really matter, a wide clk range should just work fine.

> > 
> >> +
> >> +		bus_clk = devm_clk_get_optional_enabled(dev, "bus");
> > for the 'optional', we can interpret it's optional for other vendor
> > UART, but a must required clk for SpacemiT's k1 UART controller
> > 
> > would it better to guard this inside a compatible test or even introduce
> > a flag in compatible data?
> 
> I don't personally think so. We could, but the DT binding is going
> out of its way to define when the bus clock is required.  This is
> simpler, and generic.
> 
I would personally choose the way of introducing a flag of compatible data,
but it's a lot change of the code (may not worth the effort)..

anyway, I'm fine with your current version, and yes, it's generic
thanks for doing this..

-- 
Yixun Lan (dlan)
Gentoo Linux Developer
GPG Key ID AABEFD55
