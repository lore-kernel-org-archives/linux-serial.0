Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E65E224E4B4;
	Wed,  8 Oct 2025 15:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759939002; cv=none; b=bGWKOxmdgM/uCuF01hqwwh04Sg6yoRTSVWG2Z4MFPAn45RzjM54rWrSigCX741y++E7uwIorolgi6ziL3kTkw2RQpUEe68613uzX6K6x0zyHAq0f8VNIyHZor3VLQdr204/+wU7Y3IXcMeyPWzGN/pWtyX1k6vWoOg1ZryGrjC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759939002; c=relaxed/simple;
	bh=9qyewUb4ExmRr6UmFNl1hRCIb1ViwnpfSBxGFnmLjKc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=khnTVud4THvDekpu0fu15U9I6CHHIGZdHKiiG6dinefTu2PydIaMJziZK/OpE0uCvPNmynzj0EMewiVfwuV8JMNRxCEeCNppDHp9sNQekKCjQTdr2W92l8XrxIXdulO/ljlefJk/w7tTRHD2PyASjBF8qY5vW0w/mI+Ov6VXElE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NhyThWDT; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sEKWZv0q; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NhyThWDT";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sEKWZv0q"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1759938992;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gd/fCX6HQtRmZtHwzEbmOAhoWSy8hda/BT8nVHCbzfc=;
	b=NhyThWDTiBbqKcf9BO/bcykZmH48DpxzNMut6hkXLqRumIPMEbRhCNTrnKxzInxd2lzn+h
	h9Jtswf4RJiBD2pHqwG2oQ/YvvqUGmeFMht8XqwnxZi+s2P1oe4dvCXTbuqLUpRWrbPk4E
	+wZiPJjTyL6RqPOVCW55juxEJULf6uTNbBR63wanlZM3LAhxmwdJpKLUFpv/y1PiNnPsE8
	rDcJQjugk/Mzl1NMNk3NqhcCoSPrMOus8QcHWx6ydUWCdLi4sekUOLO8hsJGaauH7leio+
	RF/nBqGzt7Zon0cNZzhFgFlATVt1LNgiykk9ZtrdCqmVEL7vMvqZm8cn4YzcBQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1759938992;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gd/fCX6HQtRmZtHwzEbmOAhoWSy8hda/BT8nVHCbzfc=;
	b=sEKWZv0qtlqHM99CvvqzDNTvmUAZr4IMamcbbdWVWLdTrR3iX8tD71VXN6cwPRczcOQcHB
	zgOfvUgmwc1JDdAQ==
To: Jon Hunter <jonathanh@nvidia.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>, Petr Mladek <pmladek@suse.com>,
 Sergey Senozhatsky <senozhatsky@chromium.org>, Steven Rostedt
 <rostedt@goodmis.org>, Thomas Gleixner <tglx@linutronix.de>, Esben
 Haabendal <esben@geanix.com>, linux-serial@vger.kernel.org,
 linux-kernel@vger.kernel.org, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>, Tony
 Lindgren <tony@atomide.com>, Niklas Schnelle <schnelle@linux.ibm.com>,
 Serge Semin <fancer.lancer@gmail.com>, "linux-tegra@vger.kernel.org"
 <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH tty-next v5 5/6] serial: 8250: Switch to nbcon console
In-Reply-To: <80b020fc-c18a-4da4-b222-16da1cab2f4c@nvidia.com>
References: <20250107212702.169493-1-john.ogness@linutronix.de>
 <20250107212702.169493-6-john.ogness@linutronix.de>
 <80b020fc-c18a-4da4-b222-16da1cab2f4c@nvidia.com>
Date: Wed, 08 Oct 2025 18:02:31 +0206
Message-ID: <84a521pets.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Jon,

On 2025-01-15, Jon Hunter <jonathanh@nvidia.com> wrote:
> I have noticed a suspend regression on -next for some of our 32-bit 
> Tegra (ARM) devices (Tegra20, Tegra30 and Tegra124). Bisect is pointing 
> to this commit and reverting this on top of -next (along with reverting 
> "serial: 8250: Revert "drop lockdep annotation from 
> serial8250_clear_IER()") fixes the issue. So far I have not dug in any 
> further. Unfortunately, I don't have any logs to see if there is some 
> crash or something happening but I will see if there is any more info I 
> can get.

I have been looking into reproducing this using other 8250/ARM boards
(BeagleBone Black and Phytec WEGA). Unfortunately it is just showing me
all kinds of other brokenness (in mainline) and essentially making it
impossible to confirm that I am seeing what you are seeing, since
suspend/resume is randomly dying without my 8250-nbcon patch.

Before I start spending weeks investigating/fixing most likely totally
unrelated PM or BSP issues, is it possible that I could receive one of
the boards you mentioned so that I can reproduce and debug the actual
problem you are reporting? If this is possible, feel free to take this
conversation offline so that we can discuss delivery details. Thanks!

John Ogness
