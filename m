Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 255B8156C6A;
	Sat, 16 Nov 2024 17:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731776878; cv=none; b=GVg8+pUBtCB5dNlVghjADwsck0tfSo4HK66UF4yQ34oqYDbWFtmMjDR/HnEQNlQ3/qcDa2BocNXa6PYWc6yvz/4lk92UvROBu8Fpuj0f+0O/G6C+h4mzwn3BWcb/8iZuiaF4PbwBqUDKBf3aYH8XvJ2KDwt98WZXvbc9x59Fg1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731776878; c=relaxed/simple;
	bh=wU7NWhYF23Yxfl2wLbSmUXQqB9DemqBVM9wCOyyXG3g=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=O8kd6tXUKyO0Uw/CtBMzhwfaXkUB+pCJll3FyIMD0KZ6EkP32PR/4d+1BbR3eZNT6wauKWPJDmjbhfQMBmWISDMf4AyT8agVjZPK1J99xsfHZRj5/0J0nyQPyyiSB1SgLuyK76fhd+Aq88oUKAMos/ERXhc4c/TWtEmE8SvumEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=fLXHWtOz; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="fLXHWtOz"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 9219540E0263;
	Sat, 16 Nov 2024 17:07:47 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id UCXaUGfJM-lS; Sat, 16 Nov 2024 17:07:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1731776860; bh=W1g+KuVsxdOPzRKt3NGASvfnw82tcALGS6rGvbxUrBY=;
	h=Date:From:To:Cc:Subject:From;
	b=fLXHWtOz1qUrGHkJYGPWz+w8SOvmDgHeiqm5ncZJnfSNse44b+j6YIJGRaGVBY/7H
	 IDCW0OsoK4TgAbAHPprxrdqulcAmD9Tfzyz8EHFMqv9S/DtWPnGxTIlKcVlfFR/Uki
	 FgqEaesa++ei7tV4PnRPzauiQU0T295fzYPJpmjV5JIVN8MP7LKmT27aH0jW6NcEjM
	 I3lv1iEMgattu1Owea1oTV7QVguujRLNrI8OhrZRLp9ERXKtI3Vp6aWkfpIcxML2GA
	 AEjpAD8AO7WdZUQEys6OlMdultDXzajAhRd75npRvpe1PgFtPG2VZg088maJsMsFI6
	 lFqdqaZcw/zwqur8jVMMymatA6BqANMtFUtXy8EstLjjLcPn8/ffj5KDSbp8fa+5rb
	 yqvPMlclJncmYMt6sxltLGePBLBrtViO9Iz+uy+kW6Nkkql2jjsmvBZZilegpIj9Pc
	 ETQ+SvB09qfphwgTl+vukBYs3TYMZpL4en3wGr+21+sGKS7/cKpCnSeHa+IjcAzOy4
	 459QEkmlyuxL/zwiaWI4qwDvQbq/qtRxyxMDvQILhBkz2NHG2pjAJ/ux/G+bW60Fna
	 lmmWagWuQFrccHHJ1p7YTDJnfxUMVkOMj8wxfOLKpb3wjSYRkQUA5/028BkE+FB0Uo
	 objUSiuw1j6Ou0Q6T272YiAU=
Received: from zn.tnic (p200300ea9736a13e329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9736:a13e:329c:23ff:fea6:a903])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C9EC940E0169;
	Sat, 16 Nov 2024 17:07:36 +0000 (UTC)
Date: Sat, 16 Nov 2024 18:07:27 +0100
From: Borislav Petkov <bp@alien8.de>
To: linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	lkml <linux-kernel@vger.kernel.org>
Subject: serial 00:06: Runtime PM usage count underflow!
Message-ID: <20241116170727.GCZzjRT5WGcOMKFDYq@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi folks,

got a box here which says:

[    4.654361] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    4.660820] 00:06: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
[    4.668313] printk: legacy console [ttyS0] disabled
[    4.676903] serial 00:06: Runtime PM usage count underflow!
[    4.677175] serial 00:06: disabled
[    4.677264] serial 00:06: unable to assign resources
[    4.677356] serial 00:06: probe with driver serial failed with error -16
[    4.677923] printk: legacy console [ttyS0] disabled

Any suggestions?

I'd like to use the serial cable to catch dmesg but somehow the driver doesn't
like the chip...

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
