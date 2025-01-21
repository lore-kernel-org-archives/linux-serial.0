Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 773341F37CA;
	Tue, 21 Jan 2025 14:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737469460; cv=none; b=SRzq5PlgWxRaWjLljHeFD0FhRYlARCq2yM8EkwDvXT6aZEMrhhasapwFHlHDiK02kIr6JXp+c+7k1BtRMqE70bcp/C1cZitZG0pQcLa7Ny23BRJNfxYBqhO+sikG2F2aZ8IJVjGuSWtNHfIcVYu7HSarLYGTEbdH9gAjDXe4/rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737469460; c=relaxed/simple;
	bh=eSofiXp23hDvxs2HmbJyu4VKlhtuC3KzBBb7EsSMxgo=;
	h=Date:From:To:Cc:Message-Id:In-Reply-To:References:Mime-Version:
	 Content-Type:Subject; b=HpzTqQ0HochpzSmgGfpuJ6+5ekYxXHcn++MUmGxGQXnXDnq5eIAu7qGeGNeWFbMUDfmLBempA6hkR80Y2/39iGcoh0BezQcuYeJriWkuGOOlEh1WWt7zWLPpX/XD3I+jkwjpnwyMvexW3tWGGQP/g5+muk86oOcG5YFTtrl3yzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=tBieK/dc; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="tBieK/dc"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:Mime-Version:Message-Id:Cc:To:From
	:Date:subject:date:message-id:reply-to;
	bh=qcEGGUGvqCmp0ajekXB1ILxWVwjTPQQ4Uo2m2PGsMF4=; b=tBieK/dcnitY2WEOzkNQx2YZ7S
	HTtZRnFjUqBVLqKlq7DpkTqjaY9DdrTWvDv8XyApqHRXctL5qAAHmxODBk/9cLQGkcINlGKe3efwc
	aAe4eV22clRUMB5s13kRqNG4XB7pTCRWeu42qR0kJufWoMy2tNshDGVcdtfQi+iMmXyQ=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:43806 helo=pettiford.lan)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1taFAo-0002kw-Ko; Tue, 21 Jan 2025 09:24:11 -0500
Date: Tue, 21 Jan 2025 09:24:08 -0500
From: Hugo Villeneuve <hugo@hugovil.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Andre Werner <andre.werner@systec-electronic.com>,
 gregkh@linuxfoundation.org, jirislaby@kernel.org, hvilleneuve@dimonoff.com,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
 lech.perczak@camlingroup.com, Maarten.Brock@sttls.nl
Message-Id: <20250121092408.eb0c58293ef0d8907056c816@hugovil.com>
In-Reply-To: <Z4-iKkPHmrwD5ZBc@smile.fi.intel.com>
References: <20250121071819.1346672-1-andre.werner@systec-electronic.com>
	<Z4-iKkPHmrwD5ZBc@smile.fi.intel.com>
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
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	* -0.1 NICE_REPLY_A Looks like a legit reply (A)
Subject: Re: [PATCH v4] serial: sc16is7xx: Fix IRQ number check behavior
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)

On Tue, 21 Jan 2025 15:33:30 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Tue, Jan 21, 2025 at 08:18:19AM +0100, Andre Werner wrote:
> > The logical meaning of the previous version is wrong due to a typo.
> > 
> > If the IRQ equals 0, no interrupt pin is available and polling mode
> > shall be used.
> > 
> > Additionally, this fix adds a check for IRQ < 0 to increase robustness,
> > because documentation still says that negative IRQ values cannot be
> > absolutely ruled-out.
> > 
> > Fixes: 104c1b9dde9d859dd01bd2d ("serial: sc16is7xx: Add polling mode if no IRQ pin is available")
> 
> > 
> 
> This blank line is redundant (should not exists in the tag block).
> Otherwise LGTM, thanks for pursuing this!
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>

-- 
Hugo Villeneuve
