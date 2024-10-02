Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5E781CF5E7;
	Wed,  2 Oct 2024 12:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727873058; cv=none; b=n5KRL0KEeOps9hLhnxFO8AFBJOVZ2x9lPnND7dJEYIDPbM62/BovFq6y4bamBshHFdbsLDpCF16C1aNyg6AL3Zb9upQC45xB3fSaSGv/12manL8lU1MU5qvuUFtpGJYa5pJMaS0j6akX4Lm2IjRR2w1OLM5rIRhE6nkV458d1g4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727873058; c=relaxed/simple;
	bh=WHEoc7mx6yNPrMHnzXlJNNyvERfoOtjfbGpFjn5Qwa8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LFefRw5yfqVEu6ahYD1/n7sJdhdCem0egOeVfaLI3aFjzheHvowZ1qW+uzD94PBEIpYdu7snYsFqugBUK1cNqcZDE8Yl/D/g5LupSX7V0WAmFdT1CiDV9GV3oTksAVlIwAJkEfGCzdA4xhctYF/8P4aP8uM5uWmkmT5tC9aNk6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=tquOYToP; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="tquOYToP"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 492CKRsK017647;
	Wed, 2 Oct 2024 12:44:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:subject:from:to:cc:date:in-reply-to:references
	:content-type:content-transfer-encoding:mime-version; s=pp1; bh=
	M4uvtCzyzzSS8wtixW+PYhT6nkzc3Py5Wtywj/4+F/4=; b=tquOYToPJxTbzEKL
	ymNTq42whR5xsKn2WCiETzdXj9FdBWDeoRLoCrRl3SRLE7as777gocF7XoyXfh/P
	+fqByQc2HuqX0OyIXOUtYkfgfWGL4zraP54/yCtpBUnNrbp9QbCnS9F7JCku0are
	dQvYKRbC7018UcU+wMsUaIHd7LZ/4/7kQGHC7fTpzwi5X4kET7dKeqXGIVAPEmkx
	1Bj3gcbn6UBoB2TVCgXe6Xp2Zjy1hC1DAlvIVM3nWGG74FoC/EXPU5wAmzVI0aV+
	ZqPGlCNWFedyvU1C9do9l78VF7iBuQwK7sCqokIhhBJbEzY+0vS6rjMUz3X8giyF
	2T7yZg==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42163bg3uh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Oct 2024 12:44:07 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 492A9tRM017902;
	Wed, 2 Oct 2024 12:44:05 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 41xw4n297b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Oct 2024 12:44:05 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 492Ci4ec39321880
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 2 Oct 2024 12:44:04 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E55BA58052;
	Wed,  2 Oct 2024 12:44:03 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 68C8C58045;
	Wed,  2 Oct 2024 12:44:02 +0000 (GMT)
Received: from oc-fedora.boeblingen.de.ibm.com (unknown [9.152.212.119])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  2 Oct 2024 12:44:02 +0000 (GMT)
Message-ID: <7bcec0eb88c3891d23f5c9f224e708e4a9bb8b89.camel@linux.ibm.com>
Subject: Re: [PATCH 1/1] tty: serial: handle HAS_IOPORT dependencies
From: Niklas Schnelle <schnelle@linux.ibm.com>
To: "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby
 <jirislaby@kernel.org>,
        Ilpo =?ISO-8859-1?Q?J=E4rvinen?=
 <ilpo.jarvinen@linux.intel.com>,
        linux-serial@vger.kernel.org, Arnd
 Bergmann <arnd@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>, linux-kernel@vger.kernel.org
Date: Wed, 02 Oct 2024 14:44:01 +0200
In-Reply-To: <alpine.DEB.2.21.2410011707550.45128@angie.orcam.me.uk>
References: <20240405152924.252598-1-schnelle@linux.ibm.com>
	  <20240405152924.252598-2-schnelle@linux.ibm.com>
	  <alpine.DEB.2.21.2405230244140.1257@angie.orcam.me.uk>
	 <ef2912910d006c573324bcf063cb76e843dc8267.camel@linux.ibm.com>
	 <alpine.DEB.2.21.2410011707550.45128@angie.orcam.me.uk>
Autocrypt: addr=schnelle@linux.ibm.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: jGwgYpk8RwDIsQJo9hl1Xlc7qDJ_D9vP
X-Proofpoint-GUID: jGwgYpk8RwDIsQJo9hl1Xlc7qDJ_D9vP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-02_12,2024-09-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0
 clxscore=1015 bulkscore=0 mlxlogscore=999 adultscore=0 malwarescore=0
 phishscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2410020091

On Tue, 2024-10-01 at 17:41 +0100, Maciej W. Rozycki wrote:
> Hi Niklas,
>=20
> > With 2 more HAS_IOPORT patches having gone into v6.12-rc1 I'm looking
> > at what's left and we're down to 4 prerequisite patches[0] before being
> > able to compile-time disable inb()/outb()/=E2=80=A6. This one being by =
far the
> > largest of these. Looking at your suggestion it seems that to compile
> > 8250_pci.c without HAS_IOPORT I'll have to add #ifdef CONFIG_HAS_IOPORT
> > around the MOXI section as that uses I/O ports unconditionally. The
> > rest seems fine and I guess would theoretically work on a system with
> > !HAS_IOPORT. I'll send a v2 with that included.=20
>=20
>  I've skimmed over and I agree, though I'd place some of the #ifdefs=20
> differently, e.g. above #define QPCR_TEST_FOR1.  Overall I think it would=
=20
> make sense to reorder code and group stuff that depends on port I/O such=
=20
> as to minimise the number of #ifdefs.

I just noticed that while not causing compile errors pci_fintek_setup()
also sets iotype =3D UPIO_PORT so the devices using this won't work
without HAS_IOPORT either.=20

>=20
>  Ideally we could come with a slightly user-friendlier change that would=
=20
> report the inability to handle port I/O devices as they are discovered=
=20
> rather than just silently ignoring them.

I think this would generally get quite ugly as one would have to keep
around enough of the drivers which can't possibly work in that
!HAS_IOPORT kernel to identify the device and print some error. It's
also not what happens when anything else isn't supported by your kernel
build. And I don't think we can just look for any I/O ports either
because they could be an alternative access method that isn't required.

As an example for the ugliness, for 8250 one could get something to
work as it supports both I/O port and MMIO devices. First one would
need to not #ifdef the setup routines and keep the quirk entry for
devices that use UPIO_PORT and then in pciserial_init_ports()=C2=A0one coul=
d
check with !IS_ENABLED(CONFIG_HAS_IOPORT) && uart.port.iotype =3D=3D
UPIO_PORT. But then for moxa one would have to keep pci_moxa_setup() to
set iotype =3D UPIO_PORT but would have to #ifdef in pci_moxa_init()
because the initialization already uses I/O ports and init is part of
the quirk.

>=20
> > Note however that even though your POWER9 system does not have I/O port
> > support in hardware we still have HAS_IOPORT enabled for arch/powerpc
> > if PCI is enabed so even with this patch as is your POWER9 system
> > should not be affected.
>=20
>  I think we need to get this right regardless.  And also while I run a=
=20
> generic distribution kernel on my POWER9 as a production system, I'd love=
=20
> to see an option to build a tailored configuration that would indeed=20
> remove support for port I/O from the kernel side for systems like mine=
=20
> that have no provision for port I/O in hardware, knowing that such a=20
> kernel will only ever run on such hardware and discarding compiled code=
=20
> that won't ever be used.
>=20
>   Maciej

I think allowing for such custom configs is a possible second step and
I agree it would be nice and probably becomes more useful as more and
more platforms lose I/O port support. First we need to be able to build
without HAS_IOPORT on architectures that just can't do I/O port access
though, and I'd like not delay this any more.

Thanks,
Niklas
