Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=atomide.com header.i=@atomide.com header.b="AgZOpVTL"
Received: from mail5.25mail.st (mail5.25mail.st [74.50.62.9])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3B031AE
	for <linux-serial@vger.kernel.org>; Fri, 24 Nov 2023 02:55:18 -0800 (PST)
Received: from localhost (91-158-86-216.elisa-laajakaista.fi [91.158.86.216])
	by mail5.25mail.st (Postfix) with ESMTPSA id 4CDE6604D9;
	Fri, 24 Nov 2023 10:54:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=atomide.com;
	s=25mailst; t=1700823318;
	bh=kiRpKQMbZsjEgHPGBPorOr6YPA74A7kYlC4tOzf7IYs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AgZOpVTLhf/DvBDB/u5qVeUyZ0TseonjUP54c2Gd49ktBnuD/PyPChOTDSfp9FADS
	 /EWMxFVZfhjv07Y5m3jo3uKf4HftgY5sIqJEkV/58t8b3yj7dYm/E+puw1XD+rOaa1
	 Oyv218IC3qW8SMCjtJdv3YTwttI79DY4tJTfBmwCn3/V+kBmtJx7jRNtK6SCU2LIEZ
	 E/qR8KlLOQGAjr3UnlEwjSOXDS3TQxiSSbsclT7mBhCxYisGdhuPi415wc4kOP02a6
	 Gv2uRhx8U6cJ0ewo8Dn7uwggBL0bzQY3OoRiwOEHCka+12SXD1TVLitNfj8VZSnFbX
	 AcVYTJpHvWj6Q==
Date: Fri, 24 Nov 2023 12:54:55 +0200
From: Tony Lindgren <tony@atomide.com>
To: =?utf-8?B?VGjDqW8=?= Lebrun <theo.lebrun@bootlin.com>
Cc: Kevin Hilman <khilman@kernel.org>,
	Thomas Richard <thomas.richard@bootlin.com>,
	gregkh@linuxfoundation.org, jirislaby@kernel.org,
	linux-serial@vger.kernel.org, gregory.clement@bootlin.com,
	u-kumar1@ti.com, d-gole@ti.com, thomas.petazzoni@bootlin.com
Subject: Re: [PATCH] serial: 8250_omap: Set the console genpd always on if no
 console suspend
Message-ID: <20231124105455.GV5166@atomide.com>
References: <7hfs213u0r.fsf@baylibre.com>
 <20231024045109.GT27774@atomide.com>
 <7hjzrbj29t.fsf@baylibre.com>
 <20231025064131.GZ27774@atomide.com>
 <75b6cda8-c809-409b-8be9-ad8a4db63c14@bootlin.com>
 <20231031105247.GC57044@atomide.com>
 <7h34xqitl0.fsf@baylibre.com>
 <CX5F88JLWFUW.Z36KQB2PX554@tleb-bootlin-xps13-01>
 <20231124053727.GU5166@atomide.com>
 <CX6Z7BRRRECO.3I32FB3Y8Z21G@tleb-bootlin-xps13-01>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CX6Z7BRRRECO.3I32FB3Y8Z21G@tleb-bootlin-xps13-01>

* Théo Lebrun <theo.lebrun@bootlin.com> [231124 10:39]:
> On Fri Nov 24, 2023 at 6:37 AM CET, Tony Lindgren wrote:
> Checking the code confirms this behavior. Grep for the macro
> genpd_is_active_wakeup rather than GENPD_FLAG_ACTIVE_WAKEUP. It gets
> used twice (suspend & resume), both in the same manner:
> 
>    if (device_wakeup_path(dev) && genpd_is_active_wakeup(genpd))
> 
> This means this flag won't have any impact on runtime PM handling of
> power-domains. By the way, other users of the flag enable it at PD
> registration & don't touch it afterwards.

Setting GENPD_FLAG_ACTIVE_WAKEUP will block deeper idle states for
the SoC most likely.

> There is currently nothing that links the runtime PM refcount to whether
> or not the power-domains get powered-off at suspend_noirq. Should that
> change? Maybe, but it would be a big behavioral change.

For managing GENPD_FLAG_ACTIVE_WAKEUP dynamically, maybe something like:

device_request_wakeup_path(dev)
...
device_free_wakeup_path(dev)

And those would toggle GENPD_FLAG_ACTIVE_WAKEUP for the power domain
based on some usage count?

Regards,

Tony
