Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6936720F087
	for <linux-serial@vger.kernel.org>; Mon, 16 Jun 2025 15:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750087534; cv=none; b=d4diNFE6JveXTauSH5xnJnSE8TaWvTNRN3mfjFRyRR60Lx841Y4AJXztVcF9R0phyrh5s7r5UGbLzaNnuG7HmNk7rlpBwtFg3d3oT9Kjpkanmluv+k++GQxLpHYf3j8MQljPX7ctNM2YWmVwmWBTig8ehyR6P2LrXYtAK9PyLec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750087534; c=relaxed/simple;
	bh=ZluQ5ElQw3LUVNqieIkCVlfwh1Ost0NTYdyQ1DKlhsA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WAH5dgNAzZv6gL3hUfR3kPJNy6ZdihYuJJxhvgDrwYkLV4hU03hDu/xnAYOB36mm8/y+/o1k+h7V7mJDg57DWwpM3HRCDcaLDd8OWQtW5OoyeqdVECkTe9XijJ0VqdVB48DLn612IX4pAm/RdEav9WhpQRisN4tLzECyVJdi/Ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=r44q+UjZ; arc=none smtp.client-ip=185.136.64.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="r44q+UjZ"
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 20250616151520b1dcef6e0702a36f00
        for <linux-serial@vger.kernel.org>;
        Mon, 16 Jun 2025 17:15:20 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=ZluQ5ElQw3LUVNqieIkCVlfwh1Ost0NTYdyQ1DKlhsA=;
 b=r44q+UjZVJbzFgu0DuTYp+jN4kiVZR9Oi7IWeYchA7K49R8t+cxKeMSLN7uWVzrjqlegG5
 R6PqTlqYOT84KcipWY6Y4ZNkQL/1DbaTbcAdXUQeSj7mWrHdxp4fuPzgTeLAIRy4rQx14Nrm
 88UdtjejcbmeiBLuLVei5FFVkSxgk4ejQNEdgH3G7pe8IrfD5SJ5sdCMEyZhxZcCJ4SC0c8D
 dnNZXCOz5rcfRtlB1rOnr/PIkAap/yyho9KLS2yA0jtTwH7qXkjzag3n6vLcYHgOTsaZLXig
 Vzryel3WekZwSYJBPkWOQ0U4IVzDeisVB9ztLBGuR03Kxe++II0ICUFA==;
Message-ID: <030bfa50783bc9f40ce3afd4e1f65da2a48322c1.camel@siemens.com>
Subject: Re: [linux-next:master] [serial]  b63e6f60ea:
 BUG:soft_lockup-CPU##stuck_for#s![modprobe:#]
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Ryo Takakura <ryotkkr98@gmail.com>, john.ogness@linutronix.de, 
	pmladek@suse.com
Cc: Jason@zx2c4.com, gregkh@linuxfoundation.org,
 linux-serial@vger.kernel.org, 	lkp@intel.com, oe-lkp@lists.linux.dev,
 oliver.sang@intel.com, Jan Kiszka	 <jan.kiszka@siemens.com>
Date: Mon, 16 Jun 2025 17:15:19 +0200
In-Reply-To: <20250501041055.6504-1-ryotkkr98@gmail.com>
References: <84y0vhodwy.fsf@jogness.linutronix.de>
	 <20250501041055.6504-1-ryotkkr98@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

Hi all,

On Thu, 2025-05-01 at 13:10 +0900, Ryo Takakura wrote:
> On Wed, 30 Apr 2025 17:47:01 +0206, John Ogness wrote:
> > On 2025-04-30, Ryo Takakura <ryotkkr98@gmail.com> wrote:
> > > > > The touch_nmi_watchdog() resets the softlockup watchdog. It might
> > > > > hide that the CPU did not schedule for a long time.
> > >=20
> > > To test the above, I run the rslib test using legacy console(without
> > > the John's series) with the touch_nmi_watchdog()s removed as
> > > following.
> > >=20
> > > The result is that it triggered the softlockup as expected. So I gues=
s
> > > we can say that the legacy console was indeed hiding the softlockup
> > > scenario as suggested by Petr.
> >=20
> > Excellent.
> >=20
> > > > With the John's series appied, I guess the kthread were running on =
a
> > > > cpu other than the one running the rslib test as John said[0], and
> > > > neither of touch_nmi_watchdog() nor cond_resched() were called that
> > > > could prevent the softlockup.
> > >=20
> > > To test the above, I removed the touch_nmi_watchdog() mentioned by Jo=
hn[0]
> > > on top of the John's series with the printing forced to be done on th=
e same
> > > cpu running the rslib test by marking emergency section(below change =
applied).
> > >=20
> > > The result is that it triggered the softlockup as expected. Similar t=
o
> > > the first test, the touch_nmi_watchdog() was preventing the softlocku=
p
> > > when its marked with emergency section.
> >=20
> > Excellent.
> >=20
> > > And I believe this implies that the kthread was running on some other=
 cpu
> > > as stated above as it should also be calling the touch_nmi_watchdog()
> > > when it does printing.
> >=20
> > Agreed.
> >=20
> > > If sounds good, I will prepare a fix adding cond_resched() to the
> > > rslib test later on.
> >=20
> > Yes, please add a cond_resched() to the rslib test.
>=20
> Thank you for checking the results, Got it!
>=20
> > > I tested with Linus' master on x86 qemu. I was able to see the rslib
> > > tests prone to softlockup and the John's series exaggerating it, same
> > > as raspberry pi.
> > >=20
> > > But I couldn't see the softlockup go away by marking the emergency
> > > section around the printk call within the rslib test. Looks like it
> > > never calls the touch_nmi_watchdog() in wait_for_lsr(). Maybe because
> > > trasmission gets immediatly completed on qemu board?
> >=20
> > qemu does not emulate a baudrate, so indeed transmission completes
> > immediately. It would need to be tested on real hardware. But I am
>=20
> Oh I see, that makes sense.
>=20
> > certain we found the cause and explanation. Thank you for digging into
> > this!
>=20
> Great, my pleasure!

With that it has been confirmed that the original test report [1] was
wrong. It reported the trigger, not the root cause.

b63e6f60eab4 ("serial: 8250: Switch to nbcon console")

was / is correct but got reverted by Greg in mainline with=20

f79b163c4231 ("Revert "serial: 8250: Switch to nbcon console"")

This leads to the situation that stable-rt branches still ship this
patch while mainline and stable do not. John, is that intended or was
mainline / stable never informed about that?

Best regards,
Florian


[1] https://lore.kernel.org/all/202501221029.fb0d574d-lkp@intel.com/#t
