Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE1664266A8;
	Fri, 10 Jul 2026 12:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783686821; cv=none; b=RzCLzR0o4rRcoVhlJzCTuMgiHT2NFt2b5vjxzOYSo3Fr9GyFE6/Ur0GPy51+x3yK8tBGzf9oDT3N9+0fQ5zEJnTz0syK/yqX8jRXpTNBnug/SgaIEbt95HM1mFgT46mw7khOrCNEdubw+KrJkwOITpV3wV5C3yJIHlDhJ1aPI/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783686821; c=relaxed/simple;
	bh=44sDJm9Q4dJ5FvMNDcKQuBJZxQA44oMgkthYo0Mgl3Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NgGlDFwZN+20+b3XbiKWSrmn5BTa9jNQNByRNiEtJt+kio/lryW5aBzRUfHvAWPPKfAe9RXhpsE0DzMeCa2Yo/RCfT/lIgKm9fLwryLdcDUIRqeSAc+Aoxt7vCWzU2Wbj2RoP96NsLuI1tLAVnzyjI+Slwq25vZqHMMA+pqKHQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nSi6wN5m; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nSi6wN5m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD8271F000E9;
	Fri, 10 Jul 2026 12:33:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783686819;
	bh=b130bPAJHPNf/pKE6j8b+YefwbbZ9vGIzK3XSyiPhaw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nSi6wN5mBUuDgAFXA5HTlCsy00feN6LpmFRylXWtoPjHKTzqWNVFnhVM2UZ8eiwVM
	 G6Ir838afNlquhcnb13tMc8l7k/5u/YthY+CiPZnWYCmsF7MSDkuwfohMUNsE4BysB
	 WtSUyQWFHeCuhfhFERZD/g4VJyDJ+FZRy1UZmv8A=
Date: Fri, 10 Jul 2026 14:33:35 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-serial@vger.kernel.org, Jiri Slaby <jirislaby@kernel.org>,
	Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	"open list:TTY LAYER AND SERIAL DRIVERS" <linux-kernel@vger.kernel.org>,
	"open list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <imx@lists.linux.dev>,
	"moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCHv3 0/6] serial: mxs-auart: devm conversion, clock rework,
 and IRQ ordering fixes
Message-ID: <2026071011-geiger-smugly-4069@gregkh>
References: <20260611033856.6476-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260611033856.6476-1-rosenp@gmail.com>

On Wed, Jun 10, 2026 at 08:38:50PM -0700, Rosen Penev wrote:
> This series cleans up the mxs-auart driver by converting to devm-managed
> resources, fixing clock prepare/enable ordering, and addressing IRQ
> registration races.
> 
> Patch 1 fixes compilation on 64-bit build with W=1
> 
> Patch 2 reworks the clock handling to use devm_clk_get_enabled and
> reorders clk_prepare_enable after clk_set_rate to avoid
> CLK_SET_RATE_GATE failures.
> 
> Patch 3 converts iomem mapping and GPIO IRQ requests to devm,
> removing the manual cleanup paths.
> 
> Patch 4 moves the main UART IRQ registration after uart_add_one_port
> so the port state is initialized before the handler can run, and
> manages the module clock for console vs non-console ports correctly.

Do you have this hardware to test this with?  If not, I would just leave
this alone as devm_* conversions are tricky and prone to bugs.

thanks,

greg k-h
