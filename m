Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="nMuPgILV"
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E35A9A3;
	Thu,  7 Dec 2023 08:05:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:Mime-Version:Message-Id:Cc:To:From
	:Date:subject:date:message-id:reply-to;
	bh=SySsyGcu2+Rhlw3fV2fvXq/y4sERddpzVieViCi3PSE=; b=nMuPgILV62egRS6/gPgmdMBvsM
	/dW1GP+wbaffCJ0MeIOCA7YBYiS7npsODPZ6T2ODMIDdLC9Kje6VH1QVTMOpLgPS6tQzCtZp5Kl/I
	2J8RWDKFlzfR/BQ+mAylvcWRbdbLjS1m4m0grM/Cy39rHwBKHLOhRPmktNao7nxesV8E=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:49036 helo=pettiford)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1rBGsi-00073a-Fe; Thu, 07 Dec 2023 11:05:45 -0500
Date: Thu, 7 Dec 2023 11:05:44 -0500
From: Hugo Villeneuve <hugo@hugovil.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: jirislaby@kernel.org, hvilleneuve@dimonoff.com,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
 stable@vger.kernel.org, Andy Shevchenko <andy.shevchenko@gmail.com>
Message-Id: <20231207110544.43edc9e404c599bf3dd3bf5c@hugovil.com>
In-Reply-To: <2023120748-macaroni-gaining-335f@gregkh>
References: <20231130191050.3165862-1-hugo@hugovil.com>
	<20231130191050.3165862-2-hugo@hugovil.com>
	<2023120748-macaroni-gaining-335f@gregkh>
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
Subject: Re: [PATCH 1/7] serial: sc16is7xx: fix snprintf format specifier in
 sc16is7xx_regmap_name()
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)

On Thu, 7 Dec 2023 10:45:48 +0900
Greg KH <gregkh@linuxfoundation.org> wrote:

> On Thu, Nov 30, 2023 at 02:10:43PM -0500, Hugo Villeneuve wrote:
> > From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > 
> > Change snprint format specifier from %d to %u since port_id is unsigned.
> > 
> > Fixes: 3837a0379533 ("serial: sc16is7xx: improve regmap debugfs by using one regmap per port")
> > Cc: stable@vger.kernel.org # 6.1.x: 3837a03 serial: sc16is7xx: improve regmap debugfs by using one regmap per port
> > Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> > Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > ---
> > I did not originally add a "Cc: stable" tag for commit 3837a0379533 ("serial: sc16is7xx: improve regmap debugfs by using one regmap per port")
> > as it was intended only to improve debugging using debugfs. But
> > since then, I have been able to confirm that it also fixes a long standing
> > bug in our system where the Tx interrupt are no longer enabled at some
> > point when transmitting large RS-485 paquets (> 64 bytes, which is the size
> > of the FIFO). I have been investigating why, but so far I haven't found the
> > exact cause, altough I suspect it has something to do with regmap caching.
> > Therefore, I have added it as a prerequisite for this patch so that it is
> > automatically added to the stable kernels.
> 
> As you are splitting fixes from non-fixes in this series, please resend
> this as 2 different series, one that I can apply now to my tty-linus
> branch to get merged for 6.7-final, and one that can go into tty-next
> for 6.8-rc1.  Mixing them up here just ensures that they all would get
> applied to tty-next.

Ok, makes sense. Will do after I fix the 0-day issue.

Thank you,
Hugo.
