Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="ypCor5Gb"
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7F1BBB;
	Mon,  4 Dec 2023 09:01:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:Mime-Version:Message-Id:Cc:To:From
	:Date:subject:date:message-id:reply-to;
	bh=jFinU3a3qG2DIAHPN+wRDTPp5jnN9KCTz2fM5tJeXus=; b=ypCor5Gb96rVureQ536eUhvxia
	23EwB+OsjdIxxKWEeTP5YRmO661ZADgbeX49QVe4SrtPsqEYA5Pr3ON2R7GwTtPFYoCpJAh4ApaRl
	/bGAv8ODv3LxbeNKVX8nAped5RGWE6oRFfh8gUkQX7/aAKJ6FhO0cjzUpb9PrSdlipOU=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:43898 helo=pettiford)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1rACKO-0008Ob-4E; Mon, 04 Dec 2023 12:01:52 -0500
Date: Mon, 4 Dec 2023 12:01:51 -0500
From: Hugo Villeneuve <hugo@hugovil.com>
To: Mark Brown <broonie@kernel.org>
Cc: Jan =?ISO-8859-1?Q?Kundr=E1t?= <jan.kundrat@cesnet.cz>, Cosmin Tanislav
 <cosmin.tanislav@analog.com>, linux-serial@vger.kernel.org, Andy Shevchenko
 <andy.shevchenko@gmail.com>, linux-kernel@vger.kernel.org
Message-Id: <20231204120151.f0afbee2ebc69e93e7977547@hugovil.com>
In-Reply-To: <06fa462c-5b48-410e-8656-4d0dbdbfa142@sirena.org.uk>
References: <bd91db46c50615bc1d1d62beb659fa7f62386446.1701446070.git.jan.kundrat@cesnet.cz>
	<20231201132736.65cb0e2bff88fba85121c44a@hugovil.com>
	<ce3eaa82-66e9-404b-9062-0f628dc6164f@sirena.org.uk>
	<20231201163846.a7c1d79daca7c6a2e1416a70@hugovil.com>
	<f5277458-635a-4eca-a37d-c3b2e83eb4b9@sirena.org.uk>
	<20231201171644.6f7ade89d4c2f744fa3556b7@hugovil.com>
	<20231204112905.e58cf1b7bf94440f49188390@hugovil.com>
	<06fa462c-5b48-410e-8656-4d0dbdbfa142@sirena.org.uk>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Level: 
Subject: Re: [PATCH] tty: max310x: work around regmap->regcache data
 corruption
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)

On Mon, 4 Dec 2023 16:35:30 +0000
Mark Brown <broonie@kernel.org> wrote:

> On Mon, Dec 04, 2023 at 11:29:05AM -0500, Hugo Villeneuve wrote:
> 
> > Do you have an example of a driver which is using regmap ranges like it
> > should be done in this driver, that is using the exact same address for
> > two or more registers? I found an example, but it doesn't seem
> > applicable to the sc16is7xx driver because the two registers do not
> > share a common address, for example they have addresses like 0x01 and
> > 0x81, even though with the proper page selection, they finally map to
> > address 0x01.
> 
> I don't understand what you mean here - you say that the addresses both
> have addresses 0x1 and 0x81 but map to address 0x1.  What does the 0x81
> refer to?  The comments in the driver seemed to indicate that there was
> a single address which mapped to multiple underlying registers...

Hi,
I was referring to an example in da9063-i2c.c where they have
these two registers:

#define	DA9063_REG_STATUS_A		0x01
#define	DA9063_REG_SEQ			0x81

To access one or the other, you must select page 0 or 1 in page config
selection register at address 0x00. It makes sense to me for this case.

But for the sc16is7xx, for example you have these two
independent registers, sharing the exact same address:

#define SC16IS7XX_IIR_REG		(0x02) /* Interrupt Identification */
#define SC16IS7XX_FCR_REG		(0x02) /* FIFO control */

I am not sure if regmap range can be used with this configuration.
Assuming regmap range would be properly setup, when we call
regmap_read(regmap, SC16IS7XX_IIR_REG, &val), how does regmap would
know that we want to access SC16IS7XX_IIR_REG and not SC16IS7XX_FCR_REG?

> Searching for struct regmap_range_cfg should show a lot of users in
> mainline.

Yes, I am trying to find a good example but I must download and read the
datasheet for each one. If you could point to an IC/driver that uses
regmap_range similar to IC sc16is7xx, it would really help.

Thank you
Hugo Villeneuve
