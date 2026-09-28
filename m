Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C689A4915B1;
	Mon, 28 Sep 2026 10:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790589942; cv=none; b=ZRHPxTmcEM65bFdEFa0Ucuvp8j5hCttBnS03EG155dhhWr+oiRuaWhPOBsh4V4Cf8rg0QiyHxHnddV/kSisqKtspFvpqdtHStv6jbTwcVYZJSQeLb5D5wK70WuvPnLPLWB6HaNJSsv/8TLZo24qJsjeUIuxQo+JAOqsE9wQ7qq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790589942; c=relaxed/simple;
	bh=eAgVLIhlC46EQF1H+SHN3KzrK8z8WrRCtMwu1pBAq5I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WXhEw2hcmaPqikAsy56DNkumfcDhuH4mLvZUtmQKvNISrPVJjWKk1tlU2iNcWvoVIKj4lBZVL2MGptpdm7DiFSkz4ShRyKCIsuafxnC2n4GoO4I2YqkvXZFGUrrS5Alkt/bzO5hT2bMRAE/wrC4iklbMxnxV7ZOuQuqoBYwTZJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GOX3tfQm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GOX3tfQm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF2451F000FF;
	Mon, 28 Sep 2026 10:05:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790589940;
	bh=43+YVXyrdWk5fDHV8RByct1Z4fjfr1ARLHxq905/6e8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=GOX3tfQmMrYnoW34ss7TvG8kuqFbajcWZxildni27Q4qyCt3q6MdT0rIg5ciHjuIo
	 ao/yjWenwFUosPjQn71u4WfnmotIB5tVD7Vdb70ePA6pMmmPU9jAhx2MPsmqDhZ51o
	 W40AkISe8wpNRrkok7wLzgoO1nNuxOmV9YPC9VoK3HQgMDx0fT8KeoyyOm8zeLII7h
	 c1Nz/8LwgohFdaLX5VydGVDUD6OHzTWOrYeKc3Xp9QIEq/O7qPdpd+7P+8A8dTOfh1
	 IUdyrAJxVwfygYSpj3S61JrV7QpenbckymrXTLihS44x9ovfeLwJwgCejCEejqVbms
	 TftN0U44DYYDQ==
Date: Mon, 28 Sep 2026 12:05:38 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>, 
	Guenter Roeck <linux@roeck-us.net>, Ian Abbott <abbotti@mev.co.uk>, 
	H Hartley Sweeten <hsweeten@visionengravers.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Rudolf Marek <r.marek@assembler.cz>, Chris Snook <chris.snook@gmail.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Andreas Noever <andreas.noever@gmail.com>, 
	Mika Westerberg <westeri@kernel.org>, Yehezkel Bernat <YehezkelShB@gmail.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Duncan Sands <duncan.sands@free.fr>, Chas Williams <3chas3@gmail.com>, 
	Luis Chamberlain <mcgrof@kernel.org>, Daniel Gomez <da.gomez@kernel.org>, 
	Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>, 
	linux-watchdog@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-hwmon@vger.kernel.org, 
	linux-i2c@vger.kernel.org, netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org, 
	linux-rtc@vger.kernel.org, linux-usb@vger.kernel.org, linux-serial@vger.kernel.org, 
	linux-atm-general@lists.sourceforge.net, linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] drivers: Replace __MODULE_STRING() with __stringify()
Message-ID: <aro70o5N7VoXbjsy@zenone.zhora.eu>
References: <20260922-module-string-v1-0-c18766690185@suse.com>
 <20260922-module-string-v1-2-c18766690185@suse.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260922-module-string-v1-2-c18766690185@suse.com>

Hi Petr,

On Tue, Sep 22, 2026 at 03:32:22PM +0200, Petr Pavlu wrote:
> __MODULE_STRING() has been an alias for __stringify() since "[PATCH]
> MODULE_PARM support for older modules" [1] in 2002-12. That change also
> moved it to the graveyard section at the end of linux/module.h
> 
> Replace the remaining uses of __MODULE_STRING() with __stringify() in
> preparation for its removal.
> 
> Link: https://git.kernel.org/tglx/history/c/136839a1b4 [1]
> Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>

Acked-by: Andi Shyti <andi.shyti@kernel.org>

Thanks,
Andi
