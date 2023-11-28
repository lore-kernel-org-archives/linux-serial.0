Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=atomide.com header.i=@atomide.com header.b="T5ZoprE+"
Received: from mail5.25mail.st (mail5.25mail.st [74.50.62.9])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D9941A1
	for <linux-serial@vger.kernel.org>; Mon, 27 Nov 2023 21:05:36 -0800 (PST)
Received: from localhost (91-158-86-216.elisa-laajakaista.fi [91.158.86.216])
	by mail5.25mail.st (Postfix) with ESMTPSA id 9D62F60850;
	Tue, 28 Nov 2023 05:05:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=atomide.com;
	s=25mailst; t=1701147935;
	bh=XCWDrtWhKMx4WDYpLfcfCiUgU740qVl9jmolKz6JSHw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T5ZoprE+xfW8McS7YnXLmuWUZxcNXo9WrvQfs6gSRKhvF7VIvscWQdKIDXAvtePns
	 5y8/vuxjQMLRNPTRysliIvVQtox+joDhrR57W1XPjmoAiexga8rv2mVwpsYa9lVadv
	 WnvW42d2IGX1ydqjne6ypvsWTW/DZD+CR0mlrahHdnI3Qtq5BmSlcQy+cD04n4diM3
	 EJ6sZmfihd2tUWCjeRXKKY/u5E8rdOevxLq2LEzJkGw38dwunnyLByzbV8Ewq6Vx/o
	 zUAgtBlZ5HB8UtJiUprtwxUw82Tk91Nqnuc0HSD6XwlERKZg528nLYjtGIXE5wJ6ZN
	 h4+m4OuQF0vPw==
Date: Tue, 28 Nov 2023 07:05:13 +0200
From: Tony Lindgren <tony@atomide.com>
To: Kevin Hilman <khilman@kernel.org>
Cc: =?utf-8?B?VGjDqW8=?= Lebrun <theo.lebrun@bootlin.com>,
	Thomas Richard <thomas.richard@bootlin.com>,
	gregkh@linuxfoundation.org, jirislaby@kernel.org,
	linux-serial@vger.kernel.org, gregory.clement@bootlin.com,
	u-kumar1@ti.com, d-gole@ti.com, thomas.petazzoni@bootlin.com
Subject: Re: [PATCH] serial: 8250_omap: Set the console genpd always on if no
 console suspend
Message-ID: <20231128050513.GJ5166@atomide.com>
References: <75b6cda8-c809-409b-8be9-ad8a4db63c14@bootlin.com>
 <20231031105247.GC57044@atomide.com>
 <7h34xqitl0.fsf@baylibre.com>
 <CX5F88JLWFUW.Z36KQB2PX554@tleb-bootlin-xps13-01>
 <20231124053727.GU5166@atomide.com>
 <CX6Z7BRRRECO.3I32FB3Y8Z21G@tleb-bootlin-xps13-01>
 <20231124105455.GV5166@atomide.com>
 <7hfs0qed47.fsf@baylibre.com>
 <20231128041134.GI5166@atomide.com>
 <7hbkbeeayw.fsf@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7hbkbeeayw.fsf@baylibre.com>

* Kevin Hilman <khilman@kernel.org> [231128 04:52]:
> Tony Lindgren <tony@atomide.com> writes:
> 
> > * Kevin Hilman <khilman@kernel.org> [231128 04:05]:
> >> Tony Lindgren <tony@atomide.com> writes:
> >> 
> >> > * Théo Lebrun <theo.lebrun@bootlin.com> [231124 10:39]:
> >> >> On Fri Nov 24, 2023 at 6:37 AM CET, Tony Lindgren wrote:
> >> >> Checking the code confirms this behavior. Grep for the macro
> >> >> genpd_is_active_wakeup rather than GENPD_FLAG_ACTIVE_WAKEUP. It gets
> >> >> used twice (suspend & resume), both in the same manner:
> >> >> 
> >> >>    if (device_wakeup_path(dev) && genpd_is_active_wakeup(genpd))
> >> >> 
> >> >> This means this flag won't have any impact on runtime PM handling of
> >> >> power-domains. By the way, other users of the flag enable it at PD
> >> >> registration & don't touch it afterwards.
> >> >
> >> > Setting GENPD_FLAG_ACTIVE_WAKEUP will block deeper idle states for
> >> > the SoC most likely.
> >> 
> >> It doesn't affect idle states.  It only affects suspend states.
> >> 
> >> As Théo pointed out, system-wide suspend will ignores runtime PM
> >> refcounts, so IMO, using this flag is the right approach.
> >
> > But it still blocks the deeper SoC suspend states if set, right?
> >
> > If so, it should be dynamically toggled depending on the console_suspend
> > flag.
> 
> Agreed, and that's what I think Théo proposed earlier in this thread[1].
> 
> Since the deeper suspend states are prevented only when this flag is
> present *and* the wakeup path is set, Théo's example just toggles the
> wakeup path set based on console_suspend_enabled.

Ah it's the *and* part I was missing! Yes great, that sounds good to
me.

Thanks,

Tony

> [1] https://lore.kernel.org/r/CX5F88JLWFUW.Z36KQB2PX554@tleb-bootlin-xps13-01
