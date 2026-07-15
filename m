Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EFF944A71E;
	Wed, 15 Jul 2026 11:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784116679; cv=none; b=XxUti4IryjYgL6FlsheMqiaUZK9HdPF9ykVqgybRgHTF0IhdlyRVf0uPpHJ2Zuv84jyVMiPPoAuxsei1Oa3DjG/nuikhhlMbkjKBuUIr+aRvPjxOOR1fBMZFOHjNNd2rESVHU4ZQw9uMMvrJFkBSL/l0+NVt3NzmZxKZoX/mSg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784116679; c=relaxed/simple;
	bh=GSrWjW/HZRhYRVF91jN3BzL5Ba/PhOgUvetRWBjQBDs=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=HcklLIouCOShsKwmg0d4lJdZCxcJLCychfqLt9/OD6aSpI0rVzpgL/EWfcjD5NX3HuIgJ/wHpq4Fz0ffaqxmfz3EQbGPwULlm9rQ6WheGuGroRhPtz6/+6WWOj13b7SVNUP6cm7+phPWrApcbIpXADX5PSlz6cFQWPTUdUCW36Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=GJh4+/VK; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="GJh4+/VK"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=default; h=Content-Transfer-Encoding:Mime-Version:Message-Id:Subject:Cc:
	To:From:Date:subject:date:message-id:reply-to;
	bh=2ogU2ya6fjHVs8wOOalAt7aj/PKp0wDiWqxz/76RwrE=; b=GJh4+/VKxxCNkM1w5zLpLMAIAd
	irqqeMnHf/WyT7BBR7o326b6I+9H7tHBtKLyPr1h03G7WgmmEE2dT2PVydbK4qYsObsQ1JT75Fq3Z
	Pta9MC8jfHTnjI2B+lLmoS0ycCchsn4+7mAbMJ+1MR1ht416JceveyyfdZf2PwFsOe00=;
Received: from modemcable061.19-161-184.mc.videotron.ca ([184.161.19.61] helo=pettiford.lan)
	by mail.hugovil.com with esmtpa (Exim 4.98.2)
	(envelope-from <hugo@hugovil.com>)
	id 1wjyFG-0000000065i-356Q;
	Wed, 15 Jul 2026 07:57:47 -0400
Date: Wed, 15 Jul 2026 07:57:46 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: kernel test robot <lkp@intel.com>, Jiri Slaby <jirislaby@kernel.org>,
 Hugo Villeneuve <hvilleneuve@dimonoff.com>, oe-kbuild-all@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH] serial: 8250_hub6: add missing include for
 hub6_match_port()
Message-Id: <20260715075746.b5514925de57d3d8567b6654@hugovil.com>
In-Reply-To: <2026071505-outgrow-yelp-cd59@gregkh>
References: <20260714012610.576746-1-hugo@hugovil.com>
	<202607150717.2YxVdWpX-lkp@intel.com>
	<2026071505-outgrow-yelp-cd59@gregkh>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam_score: -2.0
X-Spam_bar: --

Hi Greg,

On Wed, 15 Jul 2026 07:16:46 +0200
Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> On Wed, Jul 15, 2026 at 07:42:00AM +0800, kernel test robot wrote:
> > Hi Hugo,
> > 
> > kernel test robot noticed the following build errors:
> > 
> > [auto build test ERROR on c1d4ce2d9eaeccd7e8aef7ec1109df49eaf4f503]
> > 
> > url:    https://github.com/intel-lab-lkp/linux/commits/Hugo-Villeneuve/serial-8250_hub6-add-missing-include-for-hub6_match_port/20260714-092814
> > base:   c1d4ce2d9eaeccd7e8aef7ec1109df49eaf4f503
> > patch link:    https://lore.kernel.org/r/20260714012610.576746-1-hugo%40hugovil.com
> > patch subject: [PATCH] serial: 8250_hub6: add missing include for hub6_match_port()
> > config: parisc-allmodconfig (https://download.01.org/0day-ci/archive/20260715/202607150717.2YxVdWpX-lkp@intel.com/config)
> > compiler: hppa-linux-gcc (GCC) 16.1.0
> > reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260715/202607150717.2YxVdWpX-lkp@intel.com/reproduce)
> > 
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202607150717.2YxVdWpX-lkp@intel.com/
> > 
> > All errors (new ones prefixed by >>):
> > 
> > >> drivers/tty/serial/8250/8250_hub6.c:46:6: error: redefinition of 'hub6_match_port'
> >       46 | bool hub6_match_port(const struct uart_port *port1, const struct uart_port *port2)
> >          |      ^~~~~~~~~~~~~~~
> >    In file included from drivers/tty/serial/8250/8250_hub6.c:10:
> >    drivers/tty/serial/8250/8250.h:340:20: note: previous definition of 'hub6_match_port' with type 'bool(const struct uart_port *, const struct uart_port *)' {aka '_Bool(const struct uart_port *, const struct uart_port *)'}
> >      340 | static inline bool hub6_match_port(const struct uart_port *port1, const struct uart_port *port2)
> >          |                    ^~~~~~~~~~~~~~~
> > 
> > 
> > vim +/hub6_match_port +46 drivers/tty/serial/8250/8250_hub6.c
> > 
> > ec9f47cd6a14ca drivers/serial/8250_hub6.c          Russell King    2005-06-27  45  
> > 3d406299d88297 drivers/tty/serial/8250/8250_hub6.c Hugo Villeneuve 2026-05-21 @46  bool hub6_match_port(const struct uart_port *port1, const struct uart_port *port2)
> > 3d406299d88297 drivers/tty/serial/8250/8250_hub6.c Hugo Villeneuve 2026-05-21  47  {
> > 3d406299d88297 drivers/tty/serial/8250/8250_hub6.c Hugo Villeneuve 2026-05-21  48  	return port1->iobase == port2->iobase && port1->hub6 == port2->hub6;
> > 3d406299d88297 drivers/tty/serial/8250/8250_hub6.c Hugo Villeneuve 2026-05-21  49  }
> > 3d406299d88297 drivers/tty/serial/8250/8250_hub6.c Hugo Villeneuve 2026-05-21  50  EXPORT_SYMBOL_GPL(hub6_match_port);
> > 3d406299d88297 drivers/tty/serial/8250/8250_hub6.c Hugo Villeneuve 2026-05-21  51  
> 
> This patch didn't cause this problem, just made it show up.  Can you
> provide a follow-on patch that fixes this?

I'm on it

-- 
Hugo Villeneuve
