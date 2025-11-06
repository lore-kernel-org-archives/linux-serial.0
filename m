Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 497BD33DEC9;
	Thu,  6 Nov 2025 16:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762444982; cv=none; b=nUgM+14Y+BjnZirXgK7a6vQKiAO8/XNNJketIZV/Yjh8Kb7+8u1bQNU18z4NTpBZLAOodm2IuZvKjkXDs+xrpg4dOZ8g/Pmlk+F1NTVwOoTLm2ZRZChQxhrzHTf8QedWlD7rI+Rux7d+22pmn8uxyu4efo0bnvgv7B5hbTwD+Q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762444982; c=relaxed/simple;
	bh=qAiKRprOv+nYZf99DweHNyqG3piOWPCI7gcz1FUSgrY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ib1KnoYyOfmOt8LpWKNtEimavhICi0GNyN1AqKPF0SzWiaYAUb+eKpKfwCLHvrXSom/BkO+ktWAkOcCeIS729uPd+7Fe6EnJ89f1k3MU2vozDWypt3lMjEKseXEkWGKSJy03XEpMty2skmPi3nYrRMMGBWnI2qZAJkbypCcm+zE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=eKKFTDQj; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="eKKFTDQj"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id E9BA740E016E;
	Thu,  6 Nov 2025 16:02:55 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id gVpGdWd_mrbE; Thu,  6 Nov 2025 16:02:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1762444970; bh=CB+rQwsuUSRqiQFnWnyRZyUO4MuMXkuilw8PJhO5FvM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eKKFTDQjUTW1AJpO67hGXKCLqbtIyDdAKJljPsZQGkB2P7qkg55dMHMuOKMPLSXkT
	 BkivfFkySioyeKsQ86n6yjnZ5NZUGNnpQPE3nS9rNdhe0XcVcjfqX7xBfiEldCWlZ2
	 nMcIBb9BGix2dX7GIW/RKDZsgZeH/HWS7xfXXr4WjR1ohsTBEkA3MHfA8YMujkrlae
	 l6fV8lfvU1Rv4hK5cmz0myWOg1oFeadEra84Tl3l9+faMCauAHUcWiXOvMHLB27xIB
	 fDrGiM0cpo0oomZA4erklQr7hvwZWGyiGvf2n8KQFeIdyp4BH12mdKdRFw6qPoXw3Q
	 YB8M5oRicGLmHPub1UdAwtChNXNufrkWgX+kOrhwmyaGph0KxebX77b1ZoV26lDP5H
	 nlMrYBt/i3z3eAfQU/N1ThvmlHnsDOweonXsRbsE0qCtlskd/IZJ/bE2AlUwYlkCW5
	 KUedTixP8UU1POeOO9yxwe3I15KzmVFD8t36o/5xpSqEiCqGxiu8eJ1jDz3UUbvBWj
	 DgUHz7dzrnsjQVLuZZDkMSeTQr9mbDA/IwDwt8+4dxraNF6G+Zn7vNt45A591JvEmV
	 V6ZMRp6jemnChhfI2ZZGuJMFCCQdDISYtuhqshav8QxzlqyGp92wUgS2iK9OsavHAw
	 /X9AaCf4kghDb00O9rIY7lU0=
Received: from zn.tnic (pd9530da1.dip0.t-ipconnect.de [217.83.13.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 08F8540E015B;
	Thu,  6 Nov 2025 16:02:41 +0000 (UTC)
Date: Thu, 6 Nov 2025 17:02:35 +0100
From: Borislav Petkov <bp@alien8.de>
To: Alex Davis <alex47794@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	John Ogness <john.ogness@linutronix.de>,
	linux-serial@vger.kernel.org
Subject: Re: [Regression] depmod fails on kernel 6.17.1 rc1
Message-ID: <20251106160235.GBaQzGm8W2Gt_VMy-s@fat_crate.local>
References: <CADiockCvM6v+d+UoFZpJSMoLAdpy99_h-hJdzUsdfaWGn3W7-g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CADiockCvM6v+d+UoFZpJSMoLAdpy99_h-hJdzUsdfaWGn3W7-g@mail.gmail.com>

Lemme add a whole bunch of relevant ppl to Cc.

So I'm seeing this with an allmodconfig build too:

depmod: ERROR: Cycle detected: 8250 -> 8250_base -> 8250
depmod: ERROR: Found 2 modules in dependency cycles!
make[6]: *** [scripts/Makefile.modinst:132: depmod] Error 1
make[5]: *** [Makefile:1917: modules_install] Error 2
make[4]: *** [Makefile:2140: run-command] Error 2
make[3]: *** [debian/rules:66: binary-image] Error 2
dpkg-buildpackage: error: make -f debian/rules binary subprocess returned exit status 2
make[2]: *** [scripts/Makefile.package:126: bindeb-pkg] Error 2
make[1]: *** [/home/amd/kernel/linux/Makefile:1643: bindeb-pkg] Error 2
make: *** [Makefile:248: __sub-make] Error 2

That's 6.17.7

On Sun, Oct 05, 2025 at 09:40:28PM -0400, Alex Davis wrote:
> When running make modules_install on linux 6.17. with the attached
> .config, I get the following error:
> 
>   DEPMOD  /lib/modules/6.17.1-rc1
> depmod: ERROR: Cycle detected: 8250 -> 8250_base -> 8250
> depmod: ERROR: Cycle detected: serial_mctrl_gpio
> depmod: ERROR: Found 2 modules in dependency cycles!
> make[2]: *** [scripts/Makefile.modinst:132: depmod] Error 1
> make[1]: *** [/spare/linux/linux-6.17/Makefile:1917: modules_install] Error 2
> make: *** [Makefile:248: __sub-make] Error 2
> 
> 
> This also happens with 6.17; it does not happen with 6.16.x.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
