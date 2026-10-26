Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793037959;
	b=ZJq++Grdq2ok8FPYO84xk3tzkZ7ShzmJPn0XLUS1gcVU8S0qn8fIOrsFmMz7iig35fb4
	 paPGkZODLPqx684HiW8owPc3LJld1eH7sR//Zeu9U7cO9kBIiSi/KMeTPjO5G3rPTEAaC
	 MQEUKUXNNGXIq/TWXd46d3OyEQiMsD+nuoqyJQPBCMjljWPQnGK/zjvpxLOJsHW/PKvf6
	 LKhn0DuNMPvm5ImD1rTzHKAfyaDH4KvO2MsMtxPVXjT/M/GUQ4yU1WpRP209v/1Fu0+dj
	 pLO8uPoDUTW74DOSNgsBppwUmFhZGczN5jRvy9y+8THhzHseSLuwbMN3YBpqcf/pjMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793037959;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:Date:To:cc:
	 Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type:
	 Content-ID;
	bh=VP+SWOFadjsPgUdhl4fc+Bf9WWYdA81aKpsuWub6aN4=;
	b=HLc2+QnNEOCk6bwLqA5JL3vAG//wGzQKl790SD3oKQu/l7oY9UjXQqV+lYxsz4yqArkN
	 KJpplbn0ZJ9fqhZLNpPwpmBOKquyYLXtyLSew6e6OXBWdsOjY+wCi1XIKfNh7ib1ZgDFP
	 7+rYUUPANHC3W3Q4ZRqNaD1XHnTWwa2IOvF4LuUX6NUcswdtn7lmXQ8526jQgkjhQjaDR
	 my3S9T9NeD3egbke8fwI8lQ4JA9qPo/bdffU5PrG2MbjQMvr7aVPQqxtuW6Yszo6R2cS0
	 b0elGY+XJEImBOrVxtKTxa/45VvkUsJ019jv1OKy9ZBFi+RPJjUXkuBNjzYkzi4V5Nw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=eVOOvjOg;
	arc=none smtp.remote-ip=192.198.163.9
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A706606A322;
	Mon, 26 Oct 2026 18:05:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3A706606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=eVOOvjOg
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793037959; x=1824573959;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=/EXOvyLFl3MNKfQXtpK2SmkUPLhQq7Da43+mjsaKyVU=;
  b=eVOOvjOgbmJKC9Ogns/dBEqOS6AEcKAKQU8Zs9VhS2rX0wJpaVJaZwTP
   O9JKVVdJMzREMccvXkfckZ57M8IfsZ2V9ZAgwFGUc3HQYu/Lg9TeNy9t2
   CGt0ij067e+tyyXz0vh/0JV9QHd4EMRuu4OLgvoGAjFdhKyYxV3nayw6Z
   Nbt4tVA4CkxUoH15lVY2Xp0K8r0pK5egEf7vEJtBXXa5xZ09NzakoTS8r
   x7ILJdOEY4Vf2rOZeO9rAiRR+a+t0tjDH9k3CvmH51l5fbv7GFSD6npiT
   DtxGPJOhQHWz+03f9dSvtSPb1g11Nhm5EcH1a2fioHgy/23N7J2kl1UHb
   Q==;
X-CSE-ConnectionGUID: /wEINjr1Q5qpoO/6Kxz1xA==
X-CSE-MsgGUID: ifpLCvr9SJqo/BF+RNKp1A==
X-IronPort-AV: E=McAfee;i="6800,10657,11947"; a="1604794"
X-IronPort-AV: E=Sophos;i="6.27,179,1787036400"; 
   d="scan'208";a="1604794"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 11:05:58 -0700
X-CSE-ConnectionGUID: Um+KQiXwSyKJr5UNKyI/HQ==
X-CSE-MsgGUID: mA5N0UOWRsq4zlA91tpg/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,179,1787036400"; 
   d="scan'208";a="4439637"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.109])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 11:05:48 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 26 Oct 2026 20:05:46 +0200 (EET)
To: James Hilliard <james.hilliard1@gmail.com>
cc: Raul Rangel <rrangel@chromium.org>, 
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Jiri Slaby <jirislaby@kernel.org>, 
    Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
    Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
    Tony Lindgren <tony@atomide.com>, 
    Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
    Richard Genoud <richard.genoud@bootlin.com>, 
    Nicolas Ferre <nicolas.ferre@microchip.com>, 
    Alexandre Belloni <alexandre.belloni@bootlin.com>, 
    Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
    Jacky Huang <ychuang3@nuvoton.com>, Shan-Chun Hung <schung@nuvoton.com>, 
    =?ISO-8859-15?Q?Pali_Roh=E1r?= <pali@kernel.org>, 
    Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>, 
    Pengutronix Kernel Team <kernel@pengutronix.de>, 
    Fabio Estevam <festevam@gmail.com>, 
    "Maciej W. Rozycki" <macro@orcam.me.uk>, Timur Tabi <timur@kernel.org>, 
    LKML <linux-kernel@vger.kernel.org>, 
    linux-serial <linux-serial@vger.kernel.org>, 
    linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev, 
    linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v6 0/5] serial: 8250: serialize DMA cancellation with
 buffer reuse
In-Reply-To: <CADvTj4okFSpw7Wo0e3DR4r4-1TDvOY1esoUDWftY27B7XwWAHA@mail.gmail.com>
Message-ID: <d4ed2b29-5717-7522-24d2-a13a5aa2baf2@linux.intel.com>
References: <20261024-submit-serial-8250-dma-cancel-v1-v6-0-6f366591f566@gmail.com> <a011174b-d64c-305b-7dab-62017fc885fa@linux.intel.com> <CAHQZ30AfcwMTXPpCgiWkhz1OFoxHJOqcVmur8Buz72M45Acuag@mail.gmail.com>
 <CADvTj4okFSpw7Wo0e3DR4r4-1TDvOY1esoUDWftY27B7XwWAHA@mail.gmail.com>
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-629380202-1793035757=:1162"
Content-ID: <4cc64621-9a33-4cc3-8a63-38ad870a4ec1@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-629380202-1793035757=:1162
Content-Type: text/plain; CHARSET=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <65f07c57-a2fa-c2b7-465d-27f022b9966e@linux.intel.com>

On Mon, 26 Oct 2026, James Hilliard wrote:

> On Mon, Oct 26, 2026 at 10:24=E2=80=AFAM Raul Rangel <rrangel@chromium.or=
g> wrote:
> >
> > On Mon, Oct 26, 2026 at 5:16=E2=80=AFAM Ilpo J=C3=A4rvinen <ilpo.jarvin=
en@linux.intel.com> wrote:
> >>
> >> On Sat, 24 Oct 2026, James Hilliard wrote:
> >>
> >> > Reserve canceled transmit and receive storage until DMA and its comp=
letion
> >> > callbacks have retired. Serial-core write backpressure protects a fl=
ushed
> >> > TX FIFO while normal transfers continue to DMA directly from that FI=
FO.
> >> >
> >> > The series separates OMAP's locked completion processing and seriali=
zes
> >> > asynchronous write wakeups with the port lock before adding the seri=
al-core
> >> > reservation helpers and applying them to 8250 TX. Flushing
> >> > empties the logical queue immediately. While the old transfer owns i=
ts
> >> > storage, write_room() reports zero and write-ready notifications wai=
t for
> >> > retirement. Failed termination retains the reservation until normal
> >> > completion, without advancing the reset FIFO. DMA retirement release=
s the
> >> > reservation independently of port readiness. Serial core keeps write=
s and
> >> > wakeups gated during shutdown until successful startup or resume.
> >> >
> >> > RX delivers paused data before the PIO fallback and retires callback=
s in
> >> > process context. Track FIFO access separately from buffer retirement=
 so
> >> > PIO and the DesignWare empty-FIFO timeout handling can run once DMA =
has
> >> > released the FIFO. On failure, retain the requested interrupt enable=
s in
> >> > the existing IER shadow and mask receive interrupts in hardware unti=
l DMA
> >> > has stopped. Recovery then leaves RX on PIO until reopen. Shutdown e=
xcludes
> >> > new retirement work before releasing the channels.
> >> >
> >> > Based on tty-next with the posted shutdown guard [0], channel
> >> > configuration error handling [1], RX TTY accounting fix [2], RZ/N1
> >> > transfer-length fix [3], transmit-PM shutdown fix [4], serport
> >> > write-wakeup deferral [5], DesignWare BUSY-safe fractional-divisor
> >> > programming [6], and Intel MID RX DMA timeout locking [7]. The serpo=
rt fix
> >> > is needed before serializing the remaining write-wakeup callers with=
 the
> >> > port lock.
> >> >
> >> > [0] https://lore.kernel.org/r/20261021-submit-serial-8250-dma-shutdo=
wn-v1-v1-1-3d3ce383c614@gmail.com
> >> > [1] https://lore.kernel.org/r/20261021-submit-serial-8250-dma-config=
-errors-v1-v1-1-c067587d1ef2@gmail.com
> >> > [2] https://lore.kernel.org/r/20261021-submit-serial-8250-dma-rx-acc=
ounting-v1-v1-1-c11795914ab4@gmail.com
> >> > [3] https://lore.kernel.org/r/20261023-submit-serial-8250-dma-tx-len=
gth-v1-v2-1-c3106ef4d2df@gmail.com
> >> > [4] https://lore.kernel.org/r/20261022-submit-serial-8250-tx-pm-shut=
down-v1-v1-1-0e894afa3bb8@gmail.com
> >> > [5] https://lore.kernel.org/r/20261023-submit-serport-write-wakeup-v=
1-v1-1-74e7311638a2@gmail.com
> >> > [6] https://lore.kernel.org/r/20261024-submit-serial-8250-dw-divisor=
-v1-v2-1-032ca5338359@gmail.com
> >> > [7] https://lore.kernel.org/r/20261024-submit-serial-8250-mid-rx-loc=
k-v1-v1-1-2b9afdf869d7@gmail.com
> >> >
> >> > Assisted-by: Codex:gpt-6-astra
> >> > Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> >> > ---
> >> > Changes in v6:
> >>
> >> Hi,
> >
> >
> >>
> >>
> >>
> >> This series is moving way too fast with new versions. Please slow down=
=2E
> >
> >
> > +1. I think you should have spent more time refining your patch set bef=
ore submission, or sending individual patches that weren't interelated.
>=20
> I was doing as much validation as I could locally already but often I
> was missing
> issues the Sashiko review bot was flagging. Since the Sashkio reviews app=
eared
> to be release issues I was doing respins to try and fix all those issues.

Fixing an issue sashiko finds does not mandate you to send the fixed=20
version out right away. And yes, definitely, fix those issues as soon as=20
you want, no matter what's the source (sashiko, human reviewer, your own=20
mind finding flaws when given time to process the code you've=20
read/written), they'll then be in store for the time when it's time to=20
send the next version.

We do know this is a major problem with AI review that it pushes=20
submitters to do rapid refresh cycle on the false pretence that reviewers=
=20
must always see the latest and shiniest code (despite often the corner=20
cases sashiko find relate to a single obscure driver most reviewers would=
=20
have no opinion anyway) or that humans should only be bothered when AI bot=
=20
found nothing (yet they always have a huge cc lists and mailing lists with=
=20
hundreths if not thousands receipients so it doesn't add up with that=20
excuse either!). Effectively such a patch sending loop ends up only=20
feeding the AI review bot.

> Apparently not everyone is seeing those reviews posted despite them showi=
ng
> up fine in lore for me.[0]
>=20
> Is everyone here seeing those reviews or are they not showing up?
>=20
> [0] https://lore.kernel.org/all/CADvTj4oNz-bnSZP+kfau-7wBSWLjLTP5jrr6nLfd=
CHNPo3pS6w@mail.gmail.com/

It's quite irrelevant to me whether I can see the reviews Sashiko gives=20
(and I could look them up from https://sashiko.dev if I'd be interested=20
and they do appear there).

When I do review the patch series I'm not basing my review on top of=20
sashiko's nor on top of other reviewer's. Sometimes I end up reviewing=20
something that gets updated by a later version because of that but it also=
=20
makes me immune to false claims or fixations of others. But the number one=
=20
cause for me reviewing an older version is sender sending versions very=20
close to each other, often during weekend (in how many cases the part of=20
the code I commented on had changed, I don't have an estimate for you,=20
sorry).

At reaching v6 this fast, you've clearly done something wrong given=20
multiple people are pointing out this to you, and yet all we get in=20
response is that "I only did it because sashiko gave me things to fix".=20
What is missing is a clear indication that you've understood the way=20
you've behaved so far will not maintain good appearance in the eyes of=20
many of the community. So please consider if it is really worth the few=20
extra days waiting would require.

I suggest you never do more than two versions per week on any non-trivial=
=20
series. I can understand sometimes a quick refresh (especially when=20
at v1-v2) is warranted but to do it for many versions close to each other=
=20
is something that people don't want to see.


And I do know how annoying it is to wait with patches and submit=20
prerequisite fixes first, with all the annoying delay it comes with
for the main patches one wants to get upstreamed, so I'm in no different
boat than you when it comes to that part.

--=20
 i.
--8323328-629380202-1793035757=:1162--
