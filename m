Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8CCC3612C7
	for <linux-serial@vger.kernel.org>; Sun,  5 Apr 2026 22:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775429448; cv=none; b=oexZ9H9fCvcP/BNxrrYxttjwvKZHOK7Squ33mSRuIdY+oKFy8rjBAKmalkONvirQ+qU/J0D2jNofe5FaqTikllBYBvUlLEmPuoZOq6qXhAP9GDwKFPdMJmB8iyWaa9Uu0SjrsrImuhixYdeFtfWChH7CUNdN6wu0LxWGaHQNc5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775429448; c=relaxed/simple;
	bh=zzMy5NtaL7AD5tUyCQ9LrBMAHeKvVDbZmilsbp1EV5w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FvDMf9TJdPPPjdaa/U2BiFczc9glWe1U5CYVpzDLS1Oey0qsSdtRgKdd63llImTtUeoTlqypEx3yYS/oLeysdj4IB7p+pX4WBkTgKJV0ngPg92wv7it7RfF57oJ1HV7P5QJsHRlT80qYHe1N6C0mneTgzbhqEY/9gRttKJw+cIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=QyUACKc6; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QyUACKc6"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-66c17372965so6321412a12.1
        for <linux-serial@vger.kernel.org>; Sun, 05 Apr 2026 15:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1775429445; x=1776034245; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jzjlDiAhhtCwD9FkXK7yFaosCzkOtMCSogVYlSJljQY=;
        b=QyUACKc6bOC4eykf2Ho9ZUPmpmJhw40xBXpzhOalSY2NIokFHQePthjKMJhBowV+bl
         N+MLvFP+pwYYme5mu0lDZEdHZT1loitraqpRIDWvn0TAImirmcJapr4zJWx9JvykqGdP
         FwXn73sOc3aM41bzG0K0+LW8SJfIgFkzHEWQ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775429445; x=1776034245;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jzjlDiAhhtCwD9FkXK7yFaosCzkOtMCSogVYlSJljQY=;
        b=h+PgFMcTMOKUt2B0jAzAbRMkprcEkm2P5LQ6JqGKOxe1h9uEXTIoGrE29bbARrvxl9
         xyweFukLnzzWaHDoIKZXVQNuRogZdCqKeCr73Orjp2hGMcDUPUzTx1SWTsaXZ1YjQYs5
         r18ZGOY3s4QUMW5INTpynQ9ZfNvLTCWplAxDsBTqYbVOox2PYf1houyri96ZM1rbFlOv
         W9ds436j58qPOEWPNdB7jR9Cog3x9Y79nkurvsFX67hlyGcNnY7m97bJtiVW+f/k3U4+
         FgkAXBVru2oBVHtD7XXt7vnQL/OnY36qZ+S4EouxH4AjLrNBbei3Vho/QAgaKaxGt+lc
         N96g==
X-Forwarded-Encrypted: i=1; AJvYcCXzVaMtOriRkGDe26iBy5sfFWiYiYcbAytw2uxXRYRukkb0q8oCicthEnDpL1POy9Mcqvha2FRvoOt9H3k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvXHi/ejurrd7e4eB+BYCVdYtYVXXWDSt5qRy2alPjQ+lTEjl8
	pF/KazM78TW++Eh0rxWLIHzwd7ia6vlrug1UpdfAZghAUrIWDe/5l6szqi/5/BZDxkZA5e3crvv
	iFTtFYfmV
X-Gm-Gg: AeBDietfjv+2+LeS7DFSBb3bKMQYx6RdBvWhyEw7+U07+GDwL+ttCmc16EXN8Sfi3Go
	/44uvj7qU9KsROrP4xPtJumQ2Ea/UlK5R1wLB6GRXEw2N3DtMeN+1jAKjp633oEe04p37IUuC4v
	vL8pmoqHoMfrjuoWoFNEGPWqbgFsT3FRhTCculm5Oql5nqd9CaenLAq9vsJ84MuG/FX6/rdhyJp
	CVP+pl4kusGYYPKuc0iTyIoG307crv3sY6e2NwpgVqEWhWqSEPO0SOXS5u1/5YlHIEz/rNS0ZAu
	9O6YVQ/1uihj+Sih1p7zNOl6xfacFPWfdJVcgebCZya2dFHNx1wQ2ou+YuwHgnLBwAw2slKRcsR
	TW6yes6jrSLnm0ZctIVLYORCAGY6qGnTtHoacdrxwZQh2SeumbU4TmjbS58E+E6PO6hBYZ4cX6Q
	WhfkzVUSjwcLMoVfmq7P88sby8ewxBUsBtOaHSJppUC73HmfnGUoDua+jS7Jd95w==
X-Received: by 2002:a05:6402:34c3:b0:66e:3870:76a0 with SMTP id 4fb4d7f45d1cf-66e3f3dbfebmr4903303a12.10.1775429444760;
        Sun, 05 Apr 2026 15:50:44 -0700 (PDT)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com. [209.85.208.50])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-66e034d1441sm3363635a12.30.2026.04.05.15.50.44
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Apr 2026 15:50:44 -0700 (PDT)
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-66bb6eb28acso6183239a12.0
        for <linux-serial@vger.kernel.org>; Sun, 05 Apr 2026 15:50:44 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXQGYfDW9Fww2Yi4mIdeq5FOM4hyzJxt96MRUSzhnLavWIDZ29Wn+j4YO0qQAN3zNP91r5VFI6ujTK8z6Q=@vger.kernel.org
X-Received: by 2002:a5d:5889:0:b0:43b:47ee:4586 with SMTP id
 ffacd0b85a97d-43d292d34e1mr14051064f8f.29.1775429026066; Sun, 05 Apr 2026
 15:43:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260404000644.522677-1-dianders@chromium.org> <2026040539-sponge-publisher-2b42@gregkh>
In-Reply-To: <2026040539-sponge-publisher-2b42@gregkh>
From: Doug Anderson <dianders@chromium.org>
Date: Sun, 5 Apr 2026 15:43:34 -0700
X-Gmail-Original-Message-ID: <CAD=FV=X6DRHV6k7G=p5Mno22na75G-69F-EzMkisSxMoxuvJcQ@mail.gmail.com>
X-Gm-Features: AQROBzBHjVedWun0AWH98b5RajBbraAAaRvLQSenEhaNEY8p1Czch8mAczvPiQQ
Message-ID: <CAD=FV=X6DRHV6k7G=p5Mno22na75G-69F-EzMkisSxMoxuvJcQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/9] driver core: Fix some race conditions
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
	Alan Stern <stern@rowland.harvard.edu>, Saravana Kannan <saravanak@kernel.org>, 
	Christoph Hellwig <hch@lst.de>, Eric Dumazet <edumazet@google.com>, Johan Hovold <johan@kernel.org>, 
	Leon Romanovsky <leon@kernel.org>, Alexander Lobakin <aleksander.lobakin@intel.com>, 
	Alexey Kardashevskiy <aik@ozlabs.ru>, Robin Murphy <robin.murphy@arm.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Frank.Li@kernel.org, 
	Jason Gunthorpe <jgg@ziepe.ca>, alex@ghiti.fr, alexander.stein@ew.tq-group.com, 
	andre.przywara@arm.com, andrew@codeconstruct.com.au, andrew@lunn.ch, 
	andriy.shevchenko@linux.intel.com, aou@eecs.berkeley.edu, ardb@kernel.org, 
	bhelgaas@google.com, brgl@kernel.org, broonie@kernel.org, 
	catalin.marinas@arm.com, chleroy@kernel.org, davem@davemloft.net, 
	david@kernel.org, devicetree@vger.kernel.org, dmaengine@vger.kernel.org, 
	driver-core@lists.linux.dev, gbatra@linux.ibm.com, 
	gregory.clement@bootlin.com, hkallweit1@gmail.com, iommu@lists.linux.dev, 
	jirislaby@kernel.org, joel@jms.id.au, joro@8bytes.org, kees@kernel.org, 
	kevin.brodsky@arm.com, kuba@kernel.org, lenb@kernel.org, lgirdwood@gmail.com, 
	linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-cxl@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org, linux-mm@kvack.org, 
	linux-pci@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-serial@vger.kernel.org, linux-snps-arc@lists.infradead.org, 
	linux-usb@vger.kernel.org, linux@armlinux.org.uk, 
	linuxppc-dev@lists.ozlabs.org, m.szyprowski@samsung.com, maddy@linux.ibm.com, 
	mani@kernel.org, maz@kernel.org, miko.lenczewski@arm.com, mpe@ellerman.id.au, 
	netdev@vger.kernel.org, npiggin@gmail.com, osalvador@suse.de, 
	oupton@kernel.org, pabeni@redhat.com, palmer@dabbelt.com, 
	peter.ujfalusi@gmail.com, peterz@infradead.org, pjw@kernel.org, 
	robh@kernel.org, sebastian.hesselbarth@gmail.com, tglx@kernel.org, 
	tsbogend@alpha.franken.de, vgupta@kernel.org, vkoul@kernel.org, 
	will@kernel.org, willy@infradead.org, yangyicong@hisilicon.com, 
	yeoreum.yun@arm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Apr 4, 2026 at 10:28=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Fri, Apr 03, 2026 at 05:04:54PM -0700, Douglas Anderson wrote:
> > NOTE: one potentially "controversial" choice I made in some patches
> > was to always reserve a flag ID even if a flag is only used under
> > certain CONFIG_ settings. This is a change from how things were
> > before. Keeping the numbering consistent and allowing easy
> > compile-testing of both CONFIG settings seemed worth it, especially
> > since it won't take up any extra space until we've added a lot more
> > flags.
>
> Nah, this is fine, I don't see any problems with this as the original
> code kind of was doing the same thing with the "hole" in the structure
> if those options were not enabled.
>
> > I only marked the first patch as a "Fix" since it is the only one
> > fixing observed problems. Other patches could be considered fixes too
> > if folks want.
> >
> > I tested the first patch in the series backported to kernel 6.6 on the
> > Pixel phone that was experiencing the race. I added extra printouts to
> > make sure that the problem was hitting / addressed. The rest of the
> > patches are tested with allmodconfig with arm32, arm64, ppc, and
> > x86. I boot tested on an arm64 Chromebook running mainline.
>
> I'm guessing your tests passed?  :)

Yup, all the tests that I've run have passed. I also threw in an
"allnoconfig" compile test just for good measure.


> Anyway, this looks great, unless there are any objections, other than
> the "needs to be undefined", which a follow-on patch can handle, I'll
> queue them up next week for 7.1-rc1.

Thanks. As per the other thread, I'm happy if you or Danilo want to
apply it, and I'm happy if you want to make minor fixups when
applying.

When I see the patches applied, I'll send a followup patch to address
the "needs to be undefined" comment, unless Danilo makes that change
himself when applying.

-Doug
