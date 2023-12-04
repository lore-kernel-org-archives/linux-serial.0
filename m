Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="iIggT4z2"
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CB28C4;
	Mon,  4 Dec 2023 12:02:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:Mime-Version:Message-Id:Cc:To:From
	:Date:subject:date:message-id:reply-to;
	bh=Iudy9bNgGP1tF6Dq9Kz4Szt32tEwdS+2umgrF9xjPTQ=; b=iIggT4z2KmYa6t/offRhSz1vc6
	IA3B/3moj35Y3iLfFSdAkkhntwaMvto5vgSfAyr9U74su9LF9jlrKRCHPqdbrHjWEy+z+ci2eat+1
	pYRMjLfUg+Zt2OwBR+DsB6eIVBcm1cVZPU3kMdxOChF3Pe1jDf+W3FY0LiACl9zgkkLY=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:34148 helo=pettiford)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1rAF96-0001DF-RY; Mon, 04 Dec 2023 15:02:25 -0500
Date: Mon, 4 Dec 2023 15:02:24 -0500
From: Hugo Villeneuve <hugo@hugovil.com>
To: Mark Brown <broonie@kernel.org>
Cc: Jan =?ISO-8859-1?Q?Kundr=E1t?= <jan.kundrat@cesnet.cz>, Cosmin Tanislav
 <cosmin.tanislav@analog.com>, linux-serial@vger.kernel.org, Andy Shevchenko
 <andy.shevchenko@gmail.com>, linux-kernel@vger.kernel.org
Message-Id: <20231204150224.add8b07a59bf737edb0b5c1c@hugovil.com>
In-Reply-To: <f6e93e9c-1c7a-424e-afe0-425b24b99e5c@sirena.org.uk>
References: <20231201163846.a7c1d79daca7c6a2e1416a70@hugovil.com>
	<f5277458-635a-4eca-a37d-c3b2e83eb4b9@sirena.org.uk>
	<20231201171644.6f7ade89d4c2f744fa3556b7@hugovil.com>
	<20231204112905.e58cf1b7bf94440f49188390@hugovil.com>
	<06fa462c-5b48-410e-8656-4d0dbdbfa142@sirena.org.uk>
	<20231204120151.f0afbee2ebc69e93e7977547@hugovil.com>
	<50b24985-cb30-4a75-a15d-9c165a276f1d@sirena.org.uk>
	<20231204135922.0355f030945920086d21b8b6@hugovil.com>
	<66946666-eb33-431d-9870-7046c39ffb4e@sirena.org.uk>
	<20231204144136.89fec6da9be49e3db96994e0@hugovil.com>
	<f6e93e9c-1c7a-424e-afe0-425b24b99e5c@sirena.org.uk>
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

On Mon, 4 Dec 2023 19:48:05 +0000
Mark Brown <broonie@kernel.org> wrote:

> On Mon, Dec 04, 2023 at 02:41:36PM -0500, Hugo Villeneuve wrote:
> 
> > But that is not was my question was about. Here a pseudo code
> > example to select "page" 1:
> 
> > 1. save original value of LCR register.
> > 2. write 0xBF to LCR register
> > 3. access desired register in page 1
> > 4. restore original LCR value saved in step 1
> 
> > How do you do that with regmap range?
> 
> Are you saying that the selector has other, non-selector functions?

Yes! There is no bit or bit range in that register that is used to
select a praticular set of registers or "page". It is only when
writing the special magic value of $BF that the IC switches to "page"
1. And if the value is NOT $BF, then it switches back to "page" 0.

When I told you if you could point to other IC/drivers that had the
same configuration, I tough you were aware of this. That explains some
of the confusion.

> This is truly innovative hardware,...

Well, I would not say innovative, but more "crappy" hardware design :)

> ...generally the selector is just a 
> bitfield that you write paging values to.

This is also what I am accustomed to normally.

>  You'd need to extend the core
> so that it knows about this quirk, right now that's not possible and
> we'll just leave the window pointing at whatever was last accessed.

Ok. I am not sure that adding support for it would make sense, since I
do not know of other ICs that could reuse this very specific and
particular method for switching "paged" registers.

Thank you,
Hugo Villeneuve
