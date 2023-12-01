Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="ZNqSyzVg"
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F242199;
	Fri,  1 Dec 2023 14:16:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:Mime-Version:Message-Id:Cc:To:From
	:Date:subject:date:message-id:reply-to;
	bh=RleAiTqS9FxAKMgjB0DLgFy+js7sWqfnCP+O9cXHczM=; b=ZNqSyzVgu4EjEHJuKsU/HlpIOy
	4uHoNIYkAkQ+SV+kVLQkB+lH/wIY4GV/THuJgkN5U4yffWT2pGdMcYCzHlOFeyloDLIRN1m3esXN+
	qHi5szrdiGILDUvtj+5ZNfzGn3AtyEiLkc+LFAI3B+pZCWXnYUPFJTaEh99lNnQemPHQ=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:50250 helo=pettiford)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1r9BoS-0006qq-HL; Fri, 01 Dec 2023 17:16:44 -0500
Date: Fri, 1 Dec 2023 17:16:44 -0500
From: Hugo Villeneuve <hugo@hugovil.com>
To: Mark Brown <broonie@kernel.org>
Cc: Jan =?ISO-8859-1?Q?Kundr=E1t?= <jan.kundrat@cesnet.cz>, Cosmin Tanislav
 <cosmin.tanislav@analog.com>, linux-serial@vger.kernel.org, Andy Shevchenko
 <andy.shevchenko@gmail.com>, linux-kernel@vger.kernel.org
Message-Id: <20231201171644.6f7ade89d4c2f744fa3556b7@hugovil.com>
In-Reply-To: <f5277458-635a-4eca-a37d-c3b2e83eb4b9@sirena.org.uk>
References: <bd91db46c50615bc1d1d62beb659fa7f62386446.1701446070.git.jan.kundrat@cesnet.cz>
	<20231201132736.65cb0e2bff88fba85121c44a@hugovil.com>
	<ce3eaa82-66e9-404b-9062-0f628dc6164f@sirena.org.uk>
	<20231201163846.a7c1d79daca7c6a2e1416a70@hugovil.com>
	<f5277458-635a-4eca-a37d-c3b2e83eb4b9@sirena.org.uk>
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

On Fri, 1 Dec 2023 21:41:48 +0000
Mark Brown <broonie@kernel.org> wrote:

> On Fri, Dec 01, 2023 at 04:38:46PM -0500, Hugo Villeneuve wrote:
> > Mark Brown <broonie@kernel.org> wrote:
> 
> > > If you're working on that driver it'd also be good to update the current
> > > use of cache bypass for the enhanced features/interrupt identification
> > > register (and anything else in there, that did seem to be the only one)
> > > to use regmap ranges instead - that'd remove the need for the efr_lock
> > > and be a much more sensible/idiomatic use of the regmap APIs.
> 
> > I will also look to remove the efr_lock, altough it has more
> > implications since this ship has some registers that share a common
> > address, and selected by bits in other registers, and I think this
> > is why there is this efr_lock.
> 
> Right, the registers sharing a common address with the register selected
> by bits in another register is what regmap ranges support - the less
> creative use of this is banked blocks of registers with a selector
> register which picks which page bank is in use, that's moderately common
> especially for TI.

Hi Mark,
thanks for the info, I was not aware of that, and will look into it.

Hugo Villeneuve.
