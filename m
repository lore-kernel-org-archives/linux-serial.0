Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.217.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793047777;
	b=qslZ3HxwoPrBmzOMOgeC/YaONAsCCXd7Yo5kxZ8M8V5HtcEAJV173r3uTWhHKLVMR/cJ
	 Pbw+eQvyXO6KxorvR33YG659iJSwyMrEHMKkgr9kGM5ojKqupd5GHRvoEP7KhkSniZ/Ml
	 9MyJ8JoGo4njyl3MsqQX2iH2icuAEMGfAohrBcPROHDYtAD7MjcSZ0P5Je9ej1q5OEp5o
	 eiHCD8QQ3kC3seEYffEmDAHAuQHzEZgxQPd65mPbVPe4FQQhASTAzinntHqm+HFVa/8PE
	 nQjeulVgef8ScPA0jy7EJSAwaiNg/fWzjWfoY7aVFmE1hCIcNM+DFBnwP8K8RnQGSuQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793047777;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=eEKPapKQIiWh5bUIcb5N/LuB8yx8USeXRcJ+z78vdxU=;
	b=v7dDLNEz7jWwxejkiTwVYjy+EadRBfg8sEHLW+Z70ur1+IzovnOMk8T4s0VsxMf/7cs7
	 FSVjCKU5xxSsgKAabRW+OhYFQxN+WFACpqSUkePLDbZSNBA951BTjx011dogufOjdqPls
	 yCJa4PXxEta3roF1b5iRtO2ir4px64l9aqJErjhumJaSGTAS/bUn8RJgJdRfqncBRQVMe
	 X0FQb/La4YY5a5CW0+Gd4BIRSmYIukwZvGcFvuEXxT33nbW5fpAJcvkWs3u9jsyOMdeLK
	 vgUWVBR8ArLLDeysUJSCMk6YlDhzNouQN/R9vmBgYhtDtZFYs2v3R8kHAH7UwFdcg2w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=rn4csZr7;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.217.41
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D7DD606A31A
	for <linux-serial@vger.kernel.org>; Mon, 26 Oct 2026 20:49:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7D7DD606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=rn4csZr7
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-7cc3eb09dd2so641782137.2
        for <linux-serial@vger.kernel.org>; Mon, 26 Oct 2026 13:49:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793047776; cv=none;
        d=google.com; s=arc-20260327;
        b=Rqjf83hhk9vmLbES1CdRHTuwhHbM77W8/A/V+M8DMK8R0JES8zZNSofJhJRcJRFqnu
         STqZMOfMbaX5W7yNKUWUVqbQTr5Cm45r4Lo9224FXv6VBpUG3RKGQjQ90jpV82Xrh4tO
         TgAXcglgrV7UHnat8XfTnWDGYJ6LYtBu3rQzcLmAlHgnrkPgHsSbnhUE9SWS6eG8ZN11
         A3Rt+yIVV+/jRz1tBWGyOiL3LLxDU7gAUlR1KJsqYIn5UmOhKpff/4EcNFLNmyH7f4kN
         8qtn/8aLwVORZu4BmFj6+q8Ad9hv9aHS7cTw5b+9r+T8WgyAcIrJym1pAtMf+eZ6qBII
         kldA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=eEKPapKQIiWh5bUIcb5N/LuB8yx8USeXRcJ+z78vdxU=;
        fh=oeWz15a7T/ur48JIofZPdzKly/hdhP7UoDt8YYt6goQ=;
        b=MXRkFEPCpA863rG1O4wvHhIDzmHtxH4q2/eC+YHmkCQQwk97DemExQWQSA7sHfqxQt
         yd8sMg4FTAqjPRpcttJDq0auyHG3B2NI5meIkFMUF5R0oKXYfmpMfsKodbTtmT3ghYAT
         /ESeEUUoyHmfUv+s3qY4hPMXvcjo13Vip2GeNWnukLhDo4nOZxtUISgiSjeyzYrDm+IM
         Pg5C8TtxSpHXCnjkDsPU0Ivum3S59JPzbhFDn0KYmIAqfmM+sAC6u58kWzxPxRs5suMt
         SkBeM55umZTtzk9WBuo+n7PLcHt5ad7ing+9Rd8o1rHnbjD+YvBhyYu6FS7Cz2o/PRUe
         tQlA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793047776; x=1793652576; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=eEKPapKQIiWh5bUIcb5N/LuB8yx8USeXRcJ+z78vdxU=;
        b=rn4csZr7XGN1hsQoBURtQe++RwWbSqtDp0Z+4fdFCzyepBWydj5w0dLalFbUFI2Yh/
         XldtUXXQhGRudMeIPI8ScDq7jN3suhDKczv3FwPi3sW6Fz+cxItRFBmeATahXzELhHcc
         cRChTP6MY2hwgzxz7jVCLJ2q9Szydc5kiJrTNOgDNILGWUIvJoVSIjdZw/oRDumRFif2
         GXYCukDAWeqPrSrrJHGkRoT5bnfthlIvTLPqI5ibxj5HbTcXma/CGUCNMziIu06onWEn
         HXQi8f+uXm0awDPjEDkCz9PMj36P29tz5WE+7pqXFhnPD4/IPn0aveIaxFyCo4D+jrJN
         B7Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793047776; x=1793652576;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eEKPapKQIiWh5bUIcb5N/LuB8yx8USeXRcJ+z78vdxU=;
        b=aHHIDIMIF9/3NTeQDpZDwlcCn2wcI4P/eCFtiWMBqwPeMGEgTfSyOCwkslRKKX7err
         071FehKJM8AqeF93bzVE4oRG8523MwtpWgD5BK8dHkxcLiJTvVIXvh3hMj2edyMYxjSa
         wB0nfViGvPsniwpjSLFoxJNMMbTcv4SbiT/izzup1alYn1voSn9hOgCiF6Wa1VH2UFhV
         5RdD0R/kHTo35CasIDRtj/cBxF2Fo7pO3Xjta7Zrdn5WS0na7082YhrGh+NwsX3WCmQR
         UKnhLKEYvJJdmECv2RZIJvgRt8T2nBtcDUXQ2csgD6jw/UPqNTD3jWBuazqOu7iXln/O
         zw0Q==
X-Forwarded-Encrypted: i=1; AKwUvByqF2eNhir42qLECRke7cqK5hu0CKp2saWDRqAIc3OoXp4K5M3OTNL3WD8LxwXMsUIE0drFqRaQ/0azlH4=@vger.kernel.org
X-Gm-Message-State: AFq9FYKVmkVGdAg0Q5ztH5o7RCxbcETksSgxid/zbnBUvlYl8XSaBE+m
	+6HgbN0D+jPcXp7IMd8UA3ZNeBNCInOmubbKKf5GzT7O5sv0K7q+wmQw3qz8y6FGTAuaWF5qKur
	Qi/pDpyF/FgI2+XolZ2+f7GTXByYcjq0=
X-Gm-Gg: AYBFou26Ya0wDa7S84XhPkn4X0oKzj5D6SiX4BqJAKoFUs1BbQXc6kaf9c/1OHVjJft
	5msHI0+cF5xqWkvIRc8QbDCLC2bRNv7EplBJf6yiAwxQtSv0aCtk9BRZdvfiPJFZFZVkeEhqa8d
	aZ7OslgjP2FvAWDhirE2wZVUMrjWplf1dQnkS7Vk1A0wUB0hB5vhrBk42T1meTTc2dSWPoOwUrF
	IZWHjjIktSt2ss7hWVzJhnkHmIqOuA42e8LS7uqnm2OZhPDdHGhs9H31EO4wPQV6223WGCVNPYZ
	CB3fIoQ7Wnwy0lxSM3Av8joLlhpsu8voBbts636OfhKEnXFBb6v8TNJ/l4211kkmYYfEASvEWYr
	Il3fEyCq+YbCjsbfr8T2DxN83IqbpacpaNuXELFFXC0pozvypGZZ6u3BtqCovOrBsfwJ5ViTSlX
	UTr80H90Ndr62QuJE7SxAxEC/lOp1HOrGew36L7Ym2YuU0Co7b+ut6ZTQR5lkgSzhz5/K26wa7Q
	esiatqA62HLkGYvENWK/p3GDRtMIjI5zJ7IGQW2ictCjuaHVnc=
X-Received: by 2002:a67:e114:0:b0:7be:37d8:1567 with SMTP id
 ada2fe7eead31-7ce5ccdca48mr2010224137.10.1793047776347; Mon, 26 Oct 2026
 13:49:36 -0700 (PDT)
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <at4bw-G8czG-G7Wl@ashevche-desk.local> <CADvTj4psJcY2T1PG9H8_hJWjz62R7unj3PPgv3FrVquUMFVhGg@mail.gmail.com>
 <at5qKehogAjTa-fA@ashevche-desk.local> <CADvTj4qSgE6Rc--mWuqAcc8HTqN9EFOS_JM8Hp8e_=ka_ZLa6w@mail.gmail.com>
 <at8eDFj2WNaXDaot@ashevche-desk.local> <CADvTj4oNz-bnSZP+kfau-7wBSWLjLTP5jrr6nLfdCHNPo3pS6w@mail.gmail.com>
 <at-vyZ1sDhYPu0W5@ashevche-desk.local> <CADvTj4o_CENc3i92OQEZudOErSKPUptT4t2CCqDaGbseuK0QcQ@mail.gmail.com>
 <2026102631-stove-preview-b534@gregkh> <CADvTj4pCnnzx4B28H_1BuY4gm2fh_8HYL9jLpsAoJcWfiUXOHw@mail.gmail.com>
 <2026102657-tubby-tragedy-5f1b@gregkh>
In-Reply-To: <2026102657-tubby-tragedy-5f1b@gregkh>
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 26 Oct 2026 14:49:24 -0600
X-Gm-Features: AclHuK9UNYlzFhcHxdKzFFVeehL7ZLxndmHwf2zdIRC7OGdlKpLpZQpwjo4GLVA
Message-ID: <CADvTj4oFBznFO9ZxL_8wZtcPaweSSt-a_brVkmQKzqJsBX2P5w@mail.gmail.com>
Subject: Re: [PATCH v5 2/5] serial: serialize asynchronous write wakeups with
 the port lock
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	"Maciej W. Rozycki" <macro@orcam.me.uk>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Raul E Rangel <rrangel@chromium.org>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, Tony Lindgren <tony@atomide.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Richard Genoud <richard.genoud@bootlin.com>, 
	Nicolas Ferre <nicolas.ferre@microchip.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
	Jacky Huang <ychuang3@nuvoton.com>, Shan-Chun Hung <schung@nuvoton.com>, 
	=?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Timur Tabi <timur@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	imx@lists.linux.dev, linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 26, 2026 at 2:40=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Mon, Oct 26, 2026 at 02:24:58PM -0600, James Hilliard wrote:
> > On Mon, Oct 26, 2026 at 2:17=E2=80=AFPM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Mon, Oct 26, 2026 at 01:59:06PM -0600, James Hilliard wrote:
> > > > On Mon, Oct 26, 2026 at 1:53=E2=80=AFPM Andy Shevchenko
> > > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > >
> > > > > On Mon, Oct 26, 2026 at 10:45:54AM -0600, James Hilliard wrote:
> > > > > > On Mon, Oct 26, 2026 at 3:33=E2=80=AFAM Andy Shevchenko
> > > > > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > > > > On Sun, Oct 25, 2026 at 04:11:08PM -0600, James Hilliard wrot=
e:
> > > > > > > > On Sun, Oct 25, 2026 at 2:44=E2=80=AFPM Andy Shevchenko
> > > > > > > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > > > > > > On Sun, Oct 25, 2026 at 02:25:46PM -0600, James Hilliard =
wrote:
> > > > >
> > > > > ...
> > > > >
> > > > > > > > > Some people might want to test the stuff. And sending too=
 often you actually
> > > > > > > > > will get the opposite results, people will be tired to ev=
en start reviewing
> > > > > > > > > and/or testing your code as it's changed way too quickly.
> > > > > > > >
> > > > > > > > My thought process was that people wouldn't want to be test=
ing code that
> > > > > > > > had known bugs flagged in Sashiko reviews.
> > > > > > >
> > > > > > > Sashiko reviews are not visible in my or any other mailbox. T=
o see them I have
> > > > > > > to go to some URL and so on, meaning to waste time to see why=
 on the earth the
> > > > > > > new version has been sent.
> > > > > >
> > > > > > Maybe the Sashiko reviews are getting caught in spam filtering =
or something?
> > > > > > They are showing up for me and on the mailing list[0] so I'm a =
bit confused why
> > > > > > you aren't seeing them. You shouldn't have to go to the web int=
erface[1] to look
> > > > > > up the reviews.
> > > > > >
> > > > > > [0] https://lore.kernel.org/all/sashiko-outbox-183574@kernel.or=
g/
> > > > > >
> > > > > > [1] https://sashiko.dev/
> > > > > >
> > > > > > > It's better before addressing Sashiko comments,
> > > > > > > reply to all people involved and to Sashiko's original email,=
 so it will be
> > > > > > > visible in the previous version why you issued (actually abou=
t to issue) the
> > > > > > > next version.
> > > > > >
> > > > > > Hmm, maybe it makes sense to enable recipients in the reply_to =
config[2]?
> > > > >
> > > > > It's up to the list owners / subsystem maintainers.
> > > > >
> > > > > > [2] https://github.com/sashiko-dev/sashiko/blob/v.0.6.3/project=
s/linux/mailing_lists.toml#L290
> > > > > >
> > > > > > > And before even issuing it, wait for a while, people might
> > > > > > > disagree with Sashiko judgement or your replies on how to add=
ress that.
> > > > > >
> > > > > > I was assuming everyone was seeing the Sashiko reviews getting =
posted to
> > > > > > the mailing list already. The are ending up in lore so unless s=
omeone isn't
> > > > > > subscribed to the list I'm not sure why they wouldn't be seeing=
 those reviews
> > > > > > already.
> > > > >
> > > > > I assume you already answered your Q. mailing list in this sense =
doesn't mean
> > > > > recipients. I think it simply goes to the mailing list without fo=
rwarding.
> > > >
> > > > Do we want those reviews going to recipients as well as the mailing=
 list?
> > >
> > > For serial patches, we decided to only have it go to the submitter an=
d
> > > the list.
> >
> > When it goes to the list is it supposed to go to list subscribers as
> > well or only to lore?
>
> All list subscribers as well, I've watched your interactions just fine
> :)

Andy, are you subscribed to the linux-serial list?

I'm wondering if some mail is getting dropped, in this particular thread I =
never
actually received the review from Maciej W. Rozycki <macro@orcam.me.uk> at
all and had to manually import the email from lore. I think that's the
only review
email that I saw go missing myself.

That one getting dropped seems especially strange since it had a
direct reply to me.

>
> thanks,
>
> greg k-h
