Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=atomide.com header.i=@atomide.com header.b="lZ/V74uF"
Received: from mail5.25mail.st (mail5.25mail.st [74.50.62.9])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19EB51AA
	for <linux-serial@vger.kernel.org>; Mon, 27 Nov 2023 20:12:04 -0800 (PST)
Received: from localhost (91-158-86-216.elisa-laajakaista.fi [91.158.86.216])
	by mail5.25mail.st (Postfix) with ESMTPSA id 0E0CA604DD;
	Tue, 28 Nov 2023 04:11:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=atomide.com;
	s=25mailst; t=1701144717;
	bh=5j5oM/pbOLWyt0lUfunh8Zch6ngI8XSQ2tedB5KN5fg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lZ/V74uFnNbEzMWXnbBgU+zFdWFHAY1cg64GJ5V1zOv2JW9JI/zpVIfEuFdclNEao
	 vCqgck397ZqF/MW86HN3bjirA9XmUeIbNrMu97GJLEuS8ajg4Jf5P3xp6uIUOjt9eQ
	 BsLyR4rNzhLM5qoKvoKT+0SS3HSogRtHyf+CH91c2ZDvQL86SDGycX/4cH2jtC2CxT
	 sUWHXdiNpwofgo9NWpEF4yIsYJZbPjBDb+b/0nGa7WxLZMCr/hWY6q1B9a07HKobLm
	 spdFBI+On3UfuDY2U3Cdt3LR+lQa5sM9bABU8ohmkvwQiQA9hUL2XAMeFmHd+UXDXB
	 18RyinDzfZuCA==
Date: Tue, 28 Nov 2023 06:11:34 +0200
From: Tony Lindgren <tony@atomide.com>
To: Kevin Hilman <khilman@kernel.org>
Cc: =?utf-8?B?VGjDqW8=?= Lebrun <theo.lebrun@bootlin.com>,
	Thomas Richard <thomas.richard@bootlin.com>,
	gregkh@linuxfoundation.org, jirislaby@kernel.org,
	linux-serial@vger.kernel.org, gregory.clement@bootlin.com,
	u-kumar1@ti.com, d-gole@ti.com, thomas.petazzoni@bootlin.com
Subject: Re: [PATCH] serial: 8250_omap: Set the console genpd always on if no
 console suspend
Message-ID: <20231128041134.GI5166@atomide.com>
References: <7hjzrbj29t.fsf@baylibre.com>
 <20231025064131.GZ27774@atomide.com>
 <75b6cda8-c809-409b-8be9-ad8a4db63c14@bootlin.com>
 <20231031105247.GC57044@atomide.com>
 <7h34xqitl0.fsf@baylibre.com>
 <CX5F88JLWFUW.Z36KQB2PX554@tleb-bootlin-xps13-01>
 <20231124053727.GU5166@atomide.com>
 <CX6Z7BRRRECO.3I32FB3Y8Z21G@tleb-bootlin-xps13-01>
 <20231124105455.GV5166@atomide.com>
 <7hfs0qed47.fsf@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7hfs0qed47.fsf@baylibre.com>

* Kevin Hilman <khilman@kernel.org> [231128 04:05]:
> Tony Lindgren <tony@atomide.com> writes:
> 
> > * Théo Lebrun <theo.lebrun@bootlin.com> [231124 10:39]:
> >> On Fri Nov 24, 2023 at 6:37 AM CET, Tony Lindgren wrote:
> >> Checking the code confirms this behavior. Grep for the macro
> >> genpd_is_active_wakeup rather than GENPD_FLAG_ACTIVE_WAKEUP. It gets
> >> used twice (suspend & resume), both in the same manner:
> >> 
> >>    if (device_wakeup_path(dev) && genpd_is_active_wakeup(genpd))
> >> 
> >> This means this flag won't have any impact on runtime PM handling of
> >> power-domains. By the way, other users of the flag enable it at PD
> >> registration & don't touch it afterwards.
> >
> > Setting GENPD_FLAG_ACTIVE_WAKEUP will block deeper idle states for
> > the SoC most likely.
> 
> It doesn't affect idle states.  It only affects suspend states.
> 
> As Théo pointed out, system-wide suspend will ignores runtime PM
> refcounts, so IMO, using this flag is the right approach.

But it still blocks the deeper SoC suspend states if set, right?

If so, it should be dynamically toggled depending on the console_suspend
flag.

Regards,

Tony
