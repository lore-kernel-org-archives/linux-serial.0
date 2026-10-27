Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793116246;
	b=ek0db6pFLpBEUSmISjYdkTJ8tx5XXW8HR+KUF4YrVStbK76skORY+lUTiYLwPXuG26RW
	 KjSct6P4Y5qEQd7FpS/ZNhI1uwZOtvW6hXWp0ur0Lc0lma3xAfXfgHYl6OyyN/Ig+kCqM
	 1kjTw8cCx+DyEI0kK7SY2BADBxhtg69ym8aVb2/sidlXVl8//8jXPRmJhBuStQ8ZSCUCJ
	 in3KJkUk1rHDdrSkUuTZI6P1JG45/fvV4B0qCm0t3h9aT/Pc1epu2HYd31aPci6eEOj8D
	 9xF0/gJ00IGpbb+jwi2uhOIb+2t+ut9zFpteE405i3P2ZdZ6cVF7wR1iwiNFkhDX0LA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793116246;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=ByIMA20bFaAay8lMe5e8/YwK0p0NS8Mq0xbXMMWelBo=;
	b=K+qjjq/H341yT1h9IC4urhkSnAdjv8fv4+EDh33KbZnnLpin5Rv1bGalSxwGFZ1kuExP
	 PY/Rpj7Wa7iSRRhRKSIaGcRQKbE3gPV9F1XYzrHvNJuMEuaGy8wMDAwhTELCjxk18rgvN
	 Aq6jivvusNVtiz4Y9/6t+aLtv5BT/iGDQocjgTwT263tk6DtC4zhEcLwKZRCoKYqu8iKc
	 O9wePwgqNnPSLkKdVziu95YdzxA3WH/lOOA1o12feOO1acCZX/0j2stZhY0hGRHQlIkkY
	 DxwQFYC4F6PPagunMRQo6VqChCyAiIbWhN5LuFlyDyksvSVZ/g/VWTiDV92A9BmrsfA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=gJ2PapAd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F19606DA15;
	Tue, 27 Oct 2026 15:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=gJ2PapAd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 227971F01825;
	Tue, 27 Oct 2026 15:50:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793116245;
	bh=ByIMA20bFaAay8lMe5e8/YwK0p0NS8Mq0xbXMMWelBo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=gJ2PapAdRtgzLR1TwB63TjqS+0vkNNmivCM/fp1NBCsyFMmrkC5A5Z1+SOIFVPFH5
	 1QP054AOPFuUnVZMOGVZSPXlxTpQpHOyvklAl2RleL2NhdWA17gntbDB/P+S5KuA3Q
	 NYOs6gAXEgUa5zYCFYG6Bj06HIsT3aLP3Jg5Efn4=
Date: Tue, 27 Oct 2026 16:50:43 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Jiri Slaby <jirislaby@kernel.org>, Joshua Rogers <linux@joshua.hu>,
	Chris Mason <mason@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
	Tony Lindgren <tony@atomide.com>, Rafael Gago Castano <rgc@hms.se>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Peter Hurley <peter@hurleysoftware.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Crescent Hsieh <crescentcy.hsieh@moxa.com>,
	Frank Li <Frank.Li@nxp.com>, Sherry Sun <sherry.sun@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Olof Johansson <olof@lixom.net>,
	Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
	Arnd Bergmann <arnd@arndb.de>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Peter Griffin <peter.griffin@linaro.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Robert Baldyga <r.baldyga@samsung.com>,
	Thomas Abraham <thomas.abraham@linaro.org>,
	Kukjin Kim <kgene.kim@samsung.com>,
	Patrice Chotard <patrice.chotard@foss.st.com>,
	Srinivas Kandagatla <srini@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>,
	Al Cooper <alcooperx@gmail.com>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, stable <stable@kernel.org>,
	Nicolas Pitre <npitre@baylibre.com>,
	Kees Cook <kees+treewide@kernel.org>, Helge Deller <deller@gmx.de>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Mingyu Wang <25181214217@stu.xidian.edu.cn>,
	Randy Dunlap <rdunlap@infradead.org>, Ronan Pigott <ronan@rjp.ie>,
	Liav Mordouch <liavmordouch@gmail.com>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Johan Hovold <johan@kernel.org>,
	Karl Mehltretter <kmehltretter@gmail.com>,
	John Ogness <john.ogness@linutronix.de>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>,
	Tony Lindgren <tony.lindgren@linux.intel.com>,
	Tate Whiteberg <whiteberg@arista.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Fushuai Wang <wangfushuai@baidu.com>,
	Petr Mladek <pmladek@suse.com>, Moteen Shah <m-shah@ti.com>,
	Kendall Willis <k-willis@ti.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Bjorn Helgaas <bhelgaas@google.com>, Lukas Wunner <lukas@wunner.de>,
	Marnix Rijnart <marnix.rijnart@iwell.eu>,
	Danilo Krummrich <dakr@kernel.org>,
	Takashi Sakamoto <o-takashi@sakamocchi.jp>,
	Linmao Li <lilinmao@kylinos.cn>, Peng Fan <peng.fan@nxp.com>,
	Shitalkumar Gandhi <shital.gandhi45@gmail.com>,
	Robin Gong <yibin.gong@nxp.com>, Pan Chuang <panchuang@vivo.com>
Subject: Re: [PATCH 00/24] tty/serial: a bunch of llm-found fixes
Message-ID: <2026102706-consensus-neon-ed05@gregkh>
References: <20261027-tty-llm-v1-0-99b0202ae546@linuxfoundation.org>
 <auC99yMtPR0BGiiH@ashevche-desk.local>
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <auC99yMtPR0BGiiH@ashevche-desk.local>

On Tue, Oct 27, 2026 at 05:06:31PM +0200, Andy Shevchenko wrote:
> On Tue, Oct 27, 2026 at 12:06:26PM +0100, Greg Kroah-Hartman wrote:
> > Here's a series of some small llm-found fixes that have been sent to me
> > recently.  Most of them are just minor bugfixes and locking cleanups,
> > but they are good to have from what I can tell.
> > 
> > Submitting them here to get a solid Sashiko run and some second eyes on
> > them before merging if all goes well.
> 
> Since it looks like v2 might be issued, can we move all Cc lists in the patches
> outside of the commit messages? (Usually it can be done by moving them below
> '---' line.) This reduces a noise in the commit messages and allows to see
> better history on a single screen page.

b4 doesn't do that "below the --- line" mess, but I will trim things
better next time around, this was a mess, sorry about that.

greg k-h
