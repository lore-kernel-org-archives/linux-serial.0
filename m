Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B4271BF22
	for <linux-serial@vger.kernel.org>; Tue, 16 Jan 2024 14:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="JqlPwYox"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:Mime-Version:Message-Id:Cc:To:From
	:Date:subject:date:message-id:reply-to;
	bh=bmKar/sLWNSP15I4hLWYBSWPFUWDMycTihcUdLB8Z0g=; b=JqlPwYoxyR2WVsVV0TBtAAZFjt
	91frFfQNsTBe5RNAFCGiJENK69QRjdZHAF4mYshLqMR6vzMNzWfrvv5p8Ptbr0kqOrXN/4uOma+5S
	jsCLg6NWd6dLLqNmNi91dyU8xx63gPI5MFbSiIOg3VsCFUeM4cLQlY6rbMMWx1N3neww=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:40528 helo=pettiford)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1rPkev-0007CV-Ev; Tue, 16 Jan 2024 09:43:22 -0500
Date: Tue, 16 Jan 2024 09:43:20 -0500
From: Hugo Villeneuve <hugo@hugovil.com>
To: "Srinivasan, Usha" <usha.srinivasan@cornelisnetworks.com>
Cc: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
Message-Id: <20240116094320.f09f35e36adc9d27902e9694@hugovil.com>
In-Reply-To: <BY5PR01MB5635C11E9BE2B105FB7B87A09E6C2@BY5PR01MB5635.prod.exchangelabs.com>
References: <DM4PR01MB75952BAB0B535CF832C89AD99E6B2@DM4PR01MB7595.prod.exchangelabs.com>
	<20240108172934.c457ca06b6543f868d32de46@hugovil.com>
	<DM4PR01MB75959DD41CC90B1B704A05D29E6A2@DM4PR01MB7595.prod.exchangelabs.com>
	<20240110174015.6f20195fde08e5c9e64e5675@hugovil.com>
	<BY5PR01MB5635A9264220404AA6EA5C089E682@BY5PR01MB5635.prod.exchangelabs.com>
	<20240111115239.63d408a688b1b8783de3064f@hugovil.com>
	<BY5PR01MB56351BA462070C585273B3909E682@BY5PR01MB5635.prod.exchangelabs.com>
	<20240111140833.4d312e7e4ae11f1770df8968@hugovil.com>
	<BY5PR01MB5635C11E9BE2B105FB7B87A09E6C2@BY5PR01MB5635.prod.exchangelabs.com>
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
	* -0.0 T_SCC_BODY_TEXT_LINE No description available.
	* -1.7 NICE_REPLY_A Looks like a legit reply (A)
Subject: Re: max14830 nobody cared Disbling IRQ issue
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)

On Mon, 15 Jan 2024 19:07:30 +0000
"Srinivasan, Usha" <usha.srinivasan@cornelisnetworks.com> wrote:

> Hi, Hugo.
> We fixed our clock issue in the platform; and you were right, I need to bump the delay to 100 in addition. I pulled in the latest version of max310x.c from torvals linux and I still get the "nobody cared" stack traces & the interrupts get disabled.  I'm hoping you can help me get beyond this.
> 
> 57:     100001          0 1e780000.gpio 152 Level     11-006c
>  58:     500001          0 1e780000.gpio 153 Level     11-0061
>  59:     100001          0 1e780000.gpio 154 Level     11-0062
>  60:     100001          0 1e780000.gpio 155 Level     11-0064
> [   88.832861] [<da8c4f2b>] irq_default_primary_handler threaded [<ac7ce979>] max310x_ist
> [   88.841725] Disabling IRQ #57
> [  175.370303] [<da8c4f2b>] irq_default_primary_handler threaded [<ac7ce979>] max310x_ist
> [  175.379166] Disabling IRQ #59
> [  262.242889] [<da8c4f2b>] irq_default_primary_handler threaded [<ac7ce979>] max310x_ist
> [  262.251752] Disabling IRQ #60
> [  369.903466] [<da8c4f2b>] irq_default_primary_handler threaded [<ac7ce979>] max310x_ist
> [  369.912332] Disabling IRQ #58
> 
> Thank you.
> Usha
> External recipient

Hi Usha,
please respond to the original email thread, so that people can see
what has been done so far and better help you.

With your crystal issues solved, do you see the exact same problem as
before?

Can you confirm with a voltmeter or an oscilloscope that your IRQ pin
is behaving properly before and after you insert the max310x
kernel module? Maybe it could help if you shared your DTS configuration.

Also, just to be sure, you should not just pull the max310x source code
itself, but use the whole tree to compile your kernel.

Hugo Villeneuve
