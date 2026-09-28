Received: from smtp71.iad3a.emailsrvr.com (smtp71.iad3a.emailsrvr.com [173.203.187.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E44194EBAF6;
	Mon, 28 Sep 2026 16:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.203.187.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790612806; cv=none; b=jvc9JQ/FNmXBC3ZzkZIlg2FBnS4k2BmR7QKqIUYonafR3WO5yC35JgRs5jShXeBk/8eeqe+/zCEw6Cg0SgVvKoRi/Z/b4ZsXl1TGxnob001jdLO4832eYdrAtYwuecyfKRS/a+m/ER9hRc/uTPjuVrOSSA3ZKz9fYe5HY5tTDlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790612806; c=relaxed/simple;
	bh=dcfqKy8RuwJf19ZxcNaKgTpq2Zkz6O8a3A4laJuSYfM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=haU7jckcY+8/MfJ3wr81dqoIqS0ryguJAG3rRU+Ermr59D65B7d86805euUx9Rl412L73nBlA8mnM12UEVQ4pdvNDST3IXFeuiNyRw7/M7YIvchvlTgkPnOhHY5ulXz4uKYPY5z1i5QWlWulzI3X2wUMK1vbAelKbOR7heGzrh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk; spf=pass smtp.mailfrom=mev.co.uk; dkim=pass (1024-bit key) header.d=g001.emailsrvr.com header.i=@g001.emailsrvr.com header.b=knMpqU6M; dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b=dAAx1Q/7; arc=none smtp.client-ip=173.203.187.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mev.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=g001.emailsrvr.com header.i=@g001.emailsrvr.com header.b="knMpqU6M";
	dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b="dAAx1Q/7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=g001.emailsrvr.com;
	s=feedback; t=1790612291;
	bh=dcfqKy8RuwJf19ZxcNaKgTpq2Zkz6O8a3A4laJuSYfM=;
	h=Date:Subject:To:From:From;
	b=knMpqU6Mk0kmP+ISs7Cok7X4ebagiVtXT1NiP8qiqgH159TGzqgxajWFaZpSo70uz
	 X4JvLjhst970T9CuQ/B1UK7DDj94fUZ9D0EuIcMXbSMkMJeSP20XqvG8xys/G508W2
	 FOaJU8N23FUYtqhMknHHcQaVfBr5pD0xTp3BApkM=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
	s=20221208-6x11dpa4; t=1790612291;
	bh=dcfqKy8RuwJf19ZxcNaKgTpq2Zkz6O8a3A4laJuSYfM=;
	h=Date:Subject:To:From:From;
	b=dAAx1Q/7P23kXEJJmdf1NGwU5hwBxkB9RRRgCV8DxfO9tKEKn3op87rBbKCtMQxor
	 A7xRjYnmS2/wTvYLr7pPA1i+MhM1dZVN9lyPAynl4YEL0TQoXXoZQxmf7SdxwFhpQQ
	 4DXajLwgB0+U+CoG1uD67D8LZvzt6Rhe9+Cdueqc=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp17.relay.iad3a.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id 02B6C23DAD;
	Mon, 28 Sep 2026 12:18:06 -0400 (EDT)
Message-ID: <efbb4382-45eb-41a5-afe3-6c359714aa89@mev.co.uk>
Date: Mon, 28 Sep 2026 17:18:06 +0100
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] drivers: Replace __MODULE_STRING() with __stringify()
To: Petr Pavlu <petr.pavlu@suse.com>,
 Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck
 <linux@roeck-us.net>, H Hartley Sweeten <hsweeten@visionengravers.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rudolf Marek <r.marek@assembler.cz>, Andi Shyti <andi.shyti@kernel.org>,
 Chris Snook <chris.snook@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 =?UTF-8?Q?Marek_Beh=C3=BAn?= <kabel@kernel.org>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Andreas Noever <andreas.noever@gmail.com>,
 Mika Westerberg <westeri@kernel.org>, Yehezkel Bernat
 <YehezkelShB@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Duncan Sands <duncan.sands@free.fr>,
 Chas Williams <3chas3@gmail.com>, Luis Chamberlain <mcgrof@kernel.org>,
 Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>,
 Aaron Tomlin <atomlin@atomlin.com>
Cc: linux-watchdog@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-hwmon@vger.kernel.org, linux-i2c@vger.kernel.org,
 netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
 linux-rtc@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-serial@vger.kernel.org, linux-atm-general@lists.sourceforge.net,
 linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260922-module-string-v1-0-c18766690185@suse.com>
 <20260922-module-string-v1-2-c18766690185@suse.com>
Content-Language: en-US
From: Ian Abbott <abbotti@mev.co.uk>
Organization: MEV Ltd.
In-Reply-To: <20260922-module-string-v1-2-c18766690185@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Classification-ID: 15bec65d-5b3a-44b5-8eff-f2a711d4e1ec-1-1

On 2026-09-22 14:32, Petr Pavlu wrote:
> __MODULE_STRING() has been an alias for __stringify() since "[PATCH]
> MODULE_PARM support for older modules" [1] in 2002-12. That change also
> moved it to the graveyard section at the end of linux/module.h
> 
> Replace the remaining uses of __MODULE_STRING() with __stringify() in
> preparation for its removal.
> 
> Link: https://git.kernel.org/tglx/history/c/136839a1b4 [1]
> Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
Acked-by: Ian Abbott <abbotti@mev.co.uk>

-- 
-=( Ian Abbott <abbotti@mev.co.uk> || MEV Ltd. is a company  )=-
-=( registered in England & Wales.  Regd. number: 02862268.  )=-
-=( Regd. addr.: S11 & 12 Building 67, Europa Business Park, )=-
-=( Bird Hall Lane, STOCKPORT, SK3 0XA, UK. || www.mev.co.uk )=-

