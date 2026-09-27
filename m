Received: from sonata.ens-lyon.org (domu-toccata.ens-lyon.fr [140.77.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A847F421221;
	Sun, 27 Sep 2026 18:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.77.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790534852; cv=none; b=Vgm9/qqFhRHmPXdAIo/d+4Fg6cf4lUawWCQV0QgCdW0S38DALF4qaKTvHa/jlTeC1CeKUeKi748DLOh8/GKhB7hIuU7aWDcJ5hvaxhZIkWtImbhSQGV+Ki9sDW7cntx/uLowkSLG39Vq/w6+DQRciNXgusXmVhpNyxQoOogBKOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790534852; c=relaxed/simple;
	bh=zdxxVPc9zPMoCgBXm1tiX9b+anurPTRVkpqwZuR+biI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=VCWULS0DX/GOeU2whR536mEixNVeeeSJX/bPF5VchHSnJ1pXZ8hBpw1SUyxheUPMjGbCuZ5CTLjPhnN/7UMLnxqqaC4xaLxrrjIen5TiSfInUGBLzQ5Rl+uXwRi3RiirAP6wKz7HXonYxOlmA4wJUGiQFfdwMIo3yGfg2DfWIAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ens-lyon.org; spf=pass smtp.mailfrom=bounce.ens-lyon.org; dkim=pass (2048-bit key) header.d=ens-lyon.org header.i=@ens-lyon.org header.b=YF+ir9Nl; dkim=pass (2048-bit key) header.d=ens-lyon.org header.i=@ens-lyon.org header.b=YF+ir9Nl; arc=none smtp.client-ip=140.77.166.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ens-lyon.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bounce.ens-lyon.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ens-lyon.org header.i=@ens-lyon.org header.b="YF+ir9Nl";
	dkim=pass (2048-bit key) header.d=ens-lyon.org header.i=@ens-lyon.org header.b="YF+ir9Nl"
Received: from localhost (localhost [127.0.0.1])
	by sonata.ens-lyon.org (Postfix) with ESMTP id ACD4DA0326;
	Sun, 27 Sep 2026 20:47:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ens-lyon.org; s=dkim;
	t=1790534841; bh=zdxxVPc9zPMoCgBXm1tiX9b+anurPTRVkpqwZuR+biI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=YF+ir9NlSZwLP5wDS6ZpHzltbW0Z7fkn74hobIc28+T5XfVv7+o9sIS8rVNVmc0oi
	 F0ST08Uyxv7oWwnxLx9X9FyYNS9igxq1T1rMsxBRDtRrSpNd9RaTnJCogGplSuPJTt
	 N334kuL0b2D9qvV7YoPoDHPAmAOSvNO5FozKK2rBnHt3CI+GiyvJLnpkVz4WLfojSB
	 hj0M3mIF8Nwy+p8jxgxEMUklzSv+sGjp5JSXqLojufW05csg3oa4OiyVhY2x5dKt4d
	 01mUHeTVuAzUth7U0KAgQ3b4KWY1WfuMeihatuvhS0CRsPK1MvSu/EDEuPrX1npRzB
	 TVdlBBTD5JXTA==
Received: from sonata.ens-lyon.org ([127.0.0.1])
	by localhost (sonata.ens-lyon.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QkHDXpVEv0P8; Sun, 27 Sep 2026 20:47:21 +0200 (CEST)
Received: from end (lfbn-bor-1-980-210.w90-120.abo.wanadoo.fr [90.120.173.210])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by sonata.ens-lyon.org (Postfix) with ESMTPSA id BF3C8A02D0;
	Sun, 27 Sep 2026 20:47:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ens-lyon.org; s=dkim;
	t=1790534841; bh=zdxxVPc9zPMoCgBXm1tiX9b+anurPTRVkpqwZuR+biI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=YF+ir9NlSZwLP5wDS6ZpHzltbW0Z7fkn74hobIc28+T5XfVv7+o9sIS8rVNVmc0oi
	 F0ST08Uyxv7oWwnxLx9X9FyYNS9igxq1T1rMsxBRDtRrSpNd9RaTnJCogGplSuPJTt
	 N334kuL0b2D9qvV7YoPoDHPAmAOSvNO5FozKK2rBnHt3CI+GiyvJLnpkVz4WLfojSB
	 hj0M3mIF8Nwy+p8jxgxEMUklzSv+sGjp5JSXqLojufW05csg3oa4OiyVhY2x5dKt4d
	 01mUHeTVuAzUth7U0KAgQ3b4KWY1WfuMeihatuvhS0CRsPK1MvSu/EDEuPrX1npRzB
	 TVdlBBTD5JXTA==
Received: from samy by end with local (Exim 4.100.1)
	(envelope-from <samuel.thibault@ens-lyon.org>)
	id 1xAtuB-00000001qD2-3qAf;
	Sun, 27 Sep 2026 20:47:19 +0200
Date: Sun, 27 Sep 2026 20:47:19 +0200
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
To: Petr Mladek <pmladek@suse.com>, John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Marcos Paulo de Souza <mpdesouza@suse.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Fushuai Wang <wangfushuai@baidu.com>, Kees Cook <kees@kernel.org>,
	Stepan Ionichev <sozdayvek@gmail.com>, linux-serial@vger.kernel.org,
	Manuel Lauss <manuel.lauss@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] printk: nbcon: Introduce Braille helpers
Message-ID: <arlktxU1LbmmM3TE@end>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
	Petr Mladek <pmladek@suse.com>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Marcos Paulo de Souza <mpdesouza@suse.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Fushuai Wang <wangfushuai@baidu.com>, Kees Cook <kees@kernel.org>,
	Stepan Ionichev <sozdayvek@gmail.com>, linux-serial@vger.kernel.org,
	Manuel Lauss <manuel.lauss@gmail.com>, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ld8pp2wq.fsf@jogness.linutronix.de>
 <araWJhKdVZnfCQcg@pathway.suse.cz>
 <877bk9id6f.fsf@jogness.linutronix.de>
 <araJ-EBntyqOGPkT@pathway.suse.cz>
 <87a4p5iejg.fsf@jogness.linutronix.de>
 <araGZN5_ixhM4AXh@pathway.suse.cz>
Organization: I am not organized

Hello,

Petr Mladek, le ven. 25 sept. 2026 16:34:12 +0200, a ecrit:
> Well, I guess that the driver was created for a particular Braille
> device.

Yes. It wouldn't be hard to add more.

> I wonder if there exists Braille devices working with other serial
> ports which are compatible...

I am not sure what the question is. There are braille devices connected
through good-old serial port, USB port, bluetooth, etc.

Petr Mladek, le ven. 25 sept. 2026 16:49:28 +0200, a ecrit:
> On Fri 2026-09-25 16:42:19, John Ogness wrote:
> > On 2026-09-25, Petr Mladek <pmladek@suse.com> wrote:
> > > This shows that braille_write() is called form printk() even when
> > > braille_co is not in console_list. It is called via vt_console_print()
> > > because the graphical console driver (ttyX) is registered.
> > 
> > But isn't that a bug? I thought Braille consoles were not supposed to be
> > handled by printk(). Even in this new series you added that exact
> > comment.
> 
> I believe that it is not a bug. I understand it the way that the
> Braille device should show everything that is shown on the virtual
> terminal. It should show the printk() messages when they are
> printed there by the related console driver.
> 
> It is just that printk() is only one source of messages shown
> on the terminal. The vt code maintains what is displayed.

That is the idea, yes.

Samuel
