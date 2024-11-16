Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C424CB666;
	Sat, 16 Nov 2024 17:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731779946; cv=none; b=U3Ie1+ml8QHWT2WopXo2gHGdI4xbZEHJAnAvNkxFXoJRSauUrKpuOib8dL+USB3L1ni6JHlqX95yOi3+ztlhsq26gvGJNqFjuhvel+wvrzx0g2vyOebl/Wj/0yruCnkwOk6w7RpX4ojwOwqmgjgMrpqQcWJ+rhJbmifSLYdd3bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731779946; c=relaxed/simple;
	bh=qpWAfAW/flM6FCElfxnZMg+YR7oaJxHVMGq8ZpKccD0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Upn5CD21VIs+W3cfs66fiKytUhJb5Atqry/JWVQxK3PNwVkWLmU6RiZFl1O8lyKukrgGFERsQhrBeDV1H9JL0RO46ipYLOUIgHtllc4CfEnJ0sc9ILjm7LfUJb3zwFUlxnn10xTPMUlC+xlclQUSKbd4wpz6oKHrke2byJxzzoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=lbvwvNLQ; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="lbvwvNLQ"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 4ED4540E0263;
	Sat, 16 Nov 2024 17:59:01 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 3S_k-VtsdwLh; Sat, 16 Nov 2024 17:58:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1731779935; bh=sdUnsdGYam1RArzz2rGqxpxolNET71VTUgEXOl5+a1c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lbvwvNLQ2FPtanTdDsA9EOgDcJf/vLT1vST3kq60+xdLUTo4fc3k1Hrq3Ta9bvAef
	 ckeRYNmT61plmgNYL5vMBOsSV1ibSnzo998QP/CXt+aTy0knGeTC4sn1ekm0GlqOjR
	 5N5LZlR6HvWN1LrHD8UG1YFjjTr29MWrkHD88aKcEJakfA/5tE4/ozH2BDpP6nbTjw
	 T1lWBEr7NMsOIN0RuQLqM9R/uVfbYm9IWuzUEAJZQ0T8ag1Um3ghf3kz53LGM01Gaf
	 yawQaa+huczGBVKzPzIMq7XpqvMrdjdBWoAe89DMOB9ZctJuTxBHoDdEaK4uLIyyN1
	 TZN7ITab3GG+JwdH1MBnBUpEusJGdsr68OqP0bk9N7wgz5YsDvdOsVIoLctapCk6Xt
	 MKHx6ACqernnKiuCQesmU1d80xNqaIeyrPTmXYtRMR/L6JDRPYkiIP89IcU2qT079D
	 v0CRa4lElyXmexVeZSEFbAhmoxGtAQ0kXYEtcvcB5cAjjoQv97krqWMrH9Mvq245JG
	 EOF4DyQZcHWt1kJxSpB31/STdjEtYX5F2BkGlLzxNIre2a6D7EUwNNpFuOmFKJmfp+
	 mLhDRBf2BExbcaggjp63Q/efdSXTrFFRsR4c/A9LZqX6je3kr0TyZY/aNL6oxOVsXB
	 OP+P6xF4aVAbKwSyNiiXWuEA=
Received: from zn.tnic (p200300ea9736a13e329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9736:a13e:329c:23ff:fea6:a903])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A1B9840E0219;
	Sat, 16 Nov 2024 17:58:51 +0000 (UTC)
Date: Sat, 16 Nov 2024 18:58:46 +0100
From: Borislav Petkov <bp@alien8.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org, Jiri Slaby <jirislaby@kernel.org>,
	lkml <linux-kernel@vger.kernel.org>
Subject: Re: serial 00:06: Runtime PM usage count underflow!
Message-ID: <20241116175846.GDZzjdVlO79wtX7mlF@fat_crate.local>
References: <20241116170727.GCZzjRT5WGcOMKFDYq@fat_crate.local>
 <2024111656-try-flatten-b215@gregkh>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2024111656-try-flatten-b215@gregkh>

On Sat, Nov 16, 2024 at 06:19:36PM +0100, Greg Kroah-Hartman wrote:
> Look in the bios, that seems to be the "old" pnp serial device?  Does it
> really have a serial port on the board?

Yeah, there is a COM1 connector and I've attached a serial port brace to have
the connector on the back of the board.

> Is it enabled properly?

BIOS says:

Serial(COM) Port 0 Configuration
	Port		Enabled
	Settings	IO=3F8H, IRQ=4

It was on "Auto" before but neither setting changed anything.

I don't know how relevant this is about that same PCI device:

pnp 00:06: [dma 0 disabled]

I'll try to upgrade the BIOS, maybe it really is an ACPI f*ckup.

Thx!

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
