Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28C4D2E229F;
	Wed, 23 Sep 2026 09:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790156775; cv=none; b=ufy6oV+AlzpdJr6oExqIYAU4evtCkUTudr4HmGA6lvpaY9OwB0eu9ob5uMWaIvWuYcxGvnkYjvLZFB+r1XPKyLI1K9nGdL6CzAK5UTycdGcxO+mwdbGrHaeHz7fWocqTaNrnLup0FC6KWW/5mDZVzYPx56x6v4HdEEF6o44c/dQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790156775; c=relaxed/simple;
	bh=PMVYgZO8cP6y5ckMpLn+PFVGTgT8mBDdbyL2LKP5ON4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tAjIfh8a1HxTLBj5q1eqsP3ejsTNnGrkBzMWrKidFEAQXJcsy52lCfd4excAMKRtDYv6PlY3knRUipLtan5hNOKpFXURG2SWgdyAvA7nkuBWwYheX0Ngp1oMsYXivL3g+3o4M8o2GyVqXarefsyK32n2E6MFkhzqb/JHwgq9pIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=M/D1iPoF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="M/D1iPoF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0D0A1F000FF;
	Wed, 23 Sep 2026 09:46:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790156773;
	bh=T6Qi8YPK1RXqDrx7q/dk8raUpjNTcrjbKdaAJ9D+O7U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=M/D1iPoFzrqn2W6mcgJ1LRF5Focn/2Y/OUIg5hYwYiMMSR8CT5ZIZD6NWIRtkXhk3
	 oujVm9FkeETC48xHPmtDrloCMSOmZ/vL27gXOV2pX36pL3yyN4jfhW6fI28IWXFgQc
	 0QzjkhcjfBTTo3h+lTK1ooSJmJ+pUx4b6t4Eufug=
Date: Wed, 23 Sep 2026 11:39:59 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>, Ian Abbott <abbotti@mev.co.uk>,
	H Hartley Sweeten <hsweeten@visionengravers.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Rudolf Marek <r.marek@assembler.cz>,
	Andi Shyti <andi.shyti@kernel.org>,
	Chris Snook <chris.snook@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Andreas Noever <andreas.noever@gmail.com>,
	Mika Westerberg <westeri@kernel.org>,
	Yehezkel Bernat <YehezkelShB@gmail.com>,
	Jiri Slaby <jirislaby@kernel.org>,
	Duncan Sands <duncan.sands@free.fr>,
	Chas Williams <3chas3@gmail.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Aaron Tomlin <atomlin@atomlin.com>, linux-watchdog@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linux-hwmon@vger.kernel.org,
	linux-i2c@vger.kernel.org, netdev@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org, linux-rtc@vger.kernel.org,
	linux-usb@vger.kernel.org, linux-serial@vger.kernel.org,
	linux-atm-general@lists.sourceforge.net,
	linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] drivers: Replace __MODULE_STRING() with __stringify()
Message-ID: <2026092352-demote-rewire-6df6@gregkh>
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

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
