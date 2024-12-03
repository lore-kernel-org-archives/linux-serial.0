Received: from sym2.noone.org (sym.noone.org [178.63.92.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A88E51E531
	for <linux-serial@vger.kernel.org>; Tue,  3 Dec 2024 14:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.63.92.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733234564; cv=none; b=I6UFpNlDGsu99+rOw2gHQ9bF1OqA7mFWKNQ4n5Xyld9z2d5ZVKN4Ym+foQHXKz/Y5VSwMWPvAdOVLblkvVPAQ90uUsvPmodDz/uszVpKDBPLEnsoM/ez6N2yRuug1KpC7olHcIXZYY5eioiYvYdNtA6iU32XW399sfCX7fplOJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733234564; c=relaxed/simple;
	bh=HSWVaH+ahscuwtDvgKuWKmqKWUkQ7LFZ1v7i/AuEnw8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q2q/QBh+IiqAHF5a55k+yWXeREk6+dWWBX8bmSAEQ0tdm/ozdgmGd/igOUJu4zdU5S1Ln/1TwnU3JE2+0i/qHTaV+OmIaaO7NA90Y1nUOpPrG2Jb3KZ0pYuqizt/lhI2DEyhzZ2OX6xPM/4u6K6Xcm3pnkNWK477CvL7+c9JqKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=distanz.ch; spf=none smtp.mailfrom=sym.noone.org; arc=none smtp.client-ip=178.63.92.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=distanz.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=sym.noone.org
Received: by sym2.noone.org (Postfix, from userid 1002)
	id 4Y2j5k6jGSz3j1cD; Tue,  3 Dec 2024 15:02:34 +0100 (CET)
Date: Tue, 3 Dec 2024 15:02:34 +0100
From: Tobias Klauser <tklauser@distanz.ch>
To: linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH] serial: altera_jtaguart: Use device name when requesting
 IRQ
Message-ID: <20241203140234.qmmsia7emgau45iz@distanz.ch>
References: <20241203132556.14182-1-tklauser@distanz.ch>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241203132556.14182-1-tklauser@distanz.ch>
User-Agent: NeoMutt/20170113 (1.7.2)

On 2024-12-03 at 14:25:56 +0100, Tobias Klauser <tklauser@distanz.ch> wrote:
> The request_irq name parameter should be the device name, not the driver
> name. This leads to more informative information in /proc/interrupts.
> 
> Before this patch:
> 
> $ cat /proc/interrupts
> ...
> 40:        123          0     GIC-0  72 Level     altera_jtaguart
> 
> After this patch:
> 
> $ cat /proc/interrupts
> ...
> 40:          6          0     GIC-0  72 Level     ff200100.fpga-juart0
> 
> Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
> ---

Apologies, I meant to send this patch before the patch titled "[PATCH v2]
serial: altera_jtaguart: Use KBUILD_MODNAME" [1]. It should be applied
before that one, otherwise the driver will fail to build with just that
patch applied.

[1] https://lore.kernel.org/linux-serial/20241203131727.9078-1-tklauser@distanz.ch/
