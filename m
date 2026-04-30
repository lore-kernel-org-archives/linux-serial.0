Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E2C8317144;
	Thu, 30 Apr 2026 15:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777563024; cv=none; b=BlG3KFlfjGzubn3IK7Ale+Bu5kYytGXHxXpm9u04uNxF9ILUNiHIK34byqxjMs08X8qusmk6PSBCqHNTyperSMMwYwE+k0dRoTtXBqWfvstnQcG/Qs5T21Zso/PKTR1bCa3PcczFhYIHj4WGLPnI5UggQ13pBrIf4jcu98CqgAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777563024; c=relaxed/simple;
	bh=gpKAXXPe6oullD3WlpTgp+i5zf+0IrABP8G15qJ6g5k=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=LWmo/u8mJMlWgtnMWEa2PqIMKbXj8qTJr6WTN+2NNH3LKcve/di3xFFwKlLfnxR3Vp0Y3JE5vMYGe/jr/I310+7jzGBe8e13oJnZNYOBDZi43Wfsj6eF9qtqHzOzlvI1qnsvbpSpAVD/xyvPYsh8ZiKvkj0WvpsdXuzSiRyJoAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=QVFYW9xB; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="QVFYW9xB"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=default; h=Content-Transfer-Encoding:Mime-Version:Message-Id:Subject:Cc:
	To:From:Date:subject:date:message-id:reply-to;
	bh=LhIOnfV1KALYVahRWhhfn7jdwiwNyXlcXR/SMGys04Q=; b=QVFYW9xB2Iweurje7xHVbhFLpi
	KA/II06sXwvx6WdNLenU7ZLN0Nd7hZkZaZ64uWZqo2BPr8ZXdp4xzBFlc8fKJaykRl0B6J/GY3UZG
	JE7x7mCTluVaS1ze78deA2lF9pKfYvmXhvZAOMDx/gMxpnykteP10RvF08j88Dm+QmHQ=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168] helo=pettiford.lan)
	by mail.hugovil.com with esmtpa (Exim 4.98.2)
	(envelope-from <hugo@hugovil.com>)
	id 1wITL9-000000006SZ-2ZEq;
	Thu, 30 Apr 2026 11:30:12 -0400
Date: Thu, 30 Apr 2026 11:30:11 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby
 <jirislaby@kernel.org>, ilpo.jarvinen@linux.intel.com,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Hugo Villeneuve
 <hvilleneuve@dimonoff.com>
Subject: Re: [PATCH v2 02/15] serial: core: add uart_iotype_mmio/legacy_io
 helper functions
Message-Id: <20260430113011.fea8a6edca8d864429a63fd5@hugovil.com>
In-Reply-To: <afNwaUf8esqaqxUe@black.igk.intel.com>
References: <20260428-tty-upio-v2-0-01c1857cf761@dimonoff.com>
	<20260428-tty-upio-v2-2-01c1857cf761@dimonoff.com>
	<afNwaUf8esqaqxUe@black.igk.intel.com>
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

On Thu, 30 Apr 2026 17:08:25 +0200
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Tue, Apr 28, 2026 at 01:53:48PM -0400, Hugo Villeneuve wrote:
> 
> > To help simplify code that check on the io type mode of the port.
> 
> ...
> 
> > +bool uart_iotype_legacy_io(enum uart_iotype iotype)
> 
> Why do we use 'legacy'? Still in use in modern CPUs...

TBH I do not remember exactly where i got this, but what would you
suggest?

Maybe:
  uart_iotype_io()


Hugo.
