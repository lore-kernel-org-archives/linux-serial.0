Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13C4214A095;
	Fri,  4 Oct 2024 10:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728036577; cv=none; b=BmABxrAjs7WFc2SfJ9a6sKxXy9Y/CTRPHXf6xAt5anrMIW4YAgieAC21+KdRN2WOIKSzdqBf9fC8HRxJk3XenPExwoPcmIg27a79oomr7EpxUKzhz/SuIOiS4EhsS7idl/UBcjJVa13zAjwtTcEoNYuvlT4Lx/NH0qkgU58Y4Q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728036577; c=relaxed/simple;
	bh=Ej1UJN7ACyWo9toGg+bqvSWRzCE1pidc2xXvWjQFV+U=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rkXMMiH5fSKQdRil9fBti2rcRAIBDH8iV18HXgtIHJiE+l1nOs28IJpzMP2Pq+XOhaB50aXqJXxAz8N6WoAXX8cTqczuoLbqmCttT4t5yfVNloRp4bzVkX2RY/xCW9ZrbXf+Y2IwlqZwRMIYq2iBvZRF+kfXy22DKLmhammFQRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=G7FaqiPH; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="G7FaqiPH"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4949wVGA009145;
	Fri, 4 Oct 2024 10:09:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:subject:from:to:cc:date:in-reply-to:references
	:content-type:content-transfer-encoding:mime-version; s=pp1; bh=
	aK2QfWCCfagY9X7DMfeTvcTbQZ3wcQ/G9shA1iq5KBc=; b=G7FaqiPHCfXMgNII
	jcBPNIczbhqMRPn2hZPhV1/nRq7hzCWZurxv//TsCbTp2SkuKGw/uzhivjIzasbo
	tgtVxcnRTXrsLk1v44suwoU1CCMvWDpdJHRZjBzBqz4Vjl+lnm71fIbaGL2AicID
	tedREG5XRj5eStGZWeZ3h6MYRLJrnqU4gdIs6UN906Yve2c1A8719bhgZGxeg8BA
	VMpIW8MDEkQaDbviQL4DBTjPjXIhJblZ1VQjpdz766x5UB5VtHJP1Kwl8uvHGbCV
	EbMj0rcJpVv0V2hyPKIjKDWbbVmu1eh0fEUGaCYSPOK8PZplLbmeYcDrhvzJ4txx
	KpgfBg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 422e6p02gn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 04 Oct 2024 10:09:22 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4947ISmU017899;
	Fri, 4 Oct 2024 10:09:22 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 42207jbf15-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 04 Oct 2024 10:09:22 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 494A9LYO45613366
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 4 Oct 2024 10:09:21 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3599E5805A;
	Fri,  4 Oct 2024 10:09:21 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AE9AF5805C;
	Fri,  4 Oct 2024 10:09:19 +0000 (GMT)
Received: from [9.171.87.189] (unknown [9.171.87.189])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  4 Oct 2024 10:09:19 +0000 (GMT)
Message-ID: <e916ff3347cef88981d8e519fe1bcedfabfbea24.camel@linux.ibm.com>
Subject: Re: [PATCH 1/1] tty: serial: handle HAS_IOPORT dependencies
From: Niklas Schnelle <schnelle@linux.ibm.com>
To: "Maciej W. Rozycki" <macro@orcam.me.uk>, Arnd Bergmann <arnd@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby
 <jirislaby@kernel.org>,
        Ilpo =?ISO-8859-1?Q?J=E4rvinen?=
 <ilpo.jarvinen@linux.intel.com>,
        linux-serial@vger.kernel.org, Heiko
 Carstens <hca@linux.ibm.com>,
        linux-kernel@vger.kernel.org
Date: Fri, 04 Oct 2024 12:09:18 +0200
In-Reply-To: <alpine.DEB.2.21.2410022305040.45128@angie.orcam.me.uk>
References: <20240405152924.252598-1-schnelle@linux.ibm.com>
	 <20240405152924.252598-2-schnelle@linux.ibm.com>
	 <alpine.DEB.2.21.2405230244140.1257@angie.orcam.me.uk>
	 <ef2912910d006c573324bcf063cb76e843dc8267.camel@linux.ibm.com>
	 <alpine.DEB.2.21.2410011707550.45128@angie.orcam.me.uk>
	 <7bcec0eb88c3891d23f5c9f224e708e4a9bb8b89.camel@linux.ibm.com>
	 <alpine.DEB.2.21.2410021632150.45128@angie.orcam.me.uk>
	 <84bbda13-ded1-4ada-a765-9d012d3f4abd@app.fastmail.com>
	 <alpine.DEB.2.21.2410022305040.45128@angie.orcam.me.uk>
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
X-Proofpoint-GUID: ohn8cF6K3cMDVJnjdkIVXgolqRScypvi
X-Proofpoint-ORIG-GUID: ohn8cF6K3cMDVJnjdkIVXgolqRScypvi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-04_07,2024-10-03_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=897
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 phishscore=0
 mlxscore=0 bulkscore=0 adultscore=0 clxscore=1015 suspectscore=0
 malwarescore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410040072

On Wed, 2024-10-02 at 23:59 +0100, Maciej W. Rozycki wrote:
> On Wed, 2 Oct 2024, Arnd Bergmann wrote:
>=20
> > I agree that this shouldn't be hard to finish. The IS_ENABLED()
> > check is not that easy to do as I think we need to keep calling
> > inb()/outb() outside of an #ifdef a compile-time error.
>=20
>  Can we just provide dummy prototypes with `__attribute__((error("...")))=
'=20
> instead?  This will surely prevent us from having to bend backwards so as=
=20
> to make sure the compiler won't see any spurious references to these=20
> inexistent functions or macros.  We already have a `__compiletime_error()=
'=20
> macro for this purpose even.

This is already done in the final patch of my series when disabling
inb()/outb() and friends.


>=20
> > Part of the problem that Niklas is trying to solve with the
> > CONFIG_HAS_IOPORT annotations is to prevent an invalid inb()/outb()
> > from turning into a NULL pointer dereference as it currently does
> > on architectures that have no way to support PIO but get the
> > default implementation from asm-generic/io.h.
>=20
>  It can be worse than that.  Part of my confusion with the defxx driver=
=20
> trying to do port I/O with my POWER9 system came from the mapping actuall=
y=20
> resulting in non-NULL invalid pointers, dereferencing which caused a floo=
d=20
> of obscure messages produced to the system console by the system firmware=
:
>=20
> LPC[000]: Got SYNC no-response error. Error address reg: 0xd0010014
> IPMI: dropping non severe PEL event
> LPC[000]: Got SYNC no-response error. Error address reg: 0xd0010014
> IPMI: dropping non severe PEL event
> LPC[000]: Got SYNC no-response error. Error address reg: 0xd0010014
> IPMI: dropping non severe PEL event
> LPC[000]: Got SYNC no-response error. Error address reg: 0xd0010014
> IPMI: dropping non severe PEL event
> [...]
>=20
> from which it was all but obvious that they were caused by an attempt to=
=20
> use PCI port I/O with a system lacking support for it.
>=20
> > It's not clear if having a silently non-working driver or one
> > that crashes makes it easier to debug for users. Having a clear
> > warning message in the PCI probe code is probably the best
> > we can hope for.
>=20
>  I agree.  Enthusiastically.

I think there was also a bit of a misunderstanding. My argument that
this would be very ugly in the general case was really meant as general
case outside of drivers like 8250 that deals with both I/O port and
MMIO i.e. we can't warn/error when !HAS_IOPORT deactivates a whole
driver because seeing an I/O port BAR in common PCI code doesn't mean
that it is required for use of the device.

I'm working on a new proposal for 8250 now. Basically I think we can
put the warning/error in serial8250_pci_setup_port(). And then for
those 8250_pci.c "sub drivers" that require I/O ports instead of just
ifdeffing out their setup/init/exit we can define anything but setup to
NULL and setup to pci_default_setup() such that the latter will find
the I/O port BAR via FL_GET_BASE() and subsequently cause the error
print in serial8250_pci_setup_port(). It's admittedly a bit odd but it
also keeps the #ifdefs to just around the code that wouldn't compile.

One thing I'm not happy with yet is the handling around
is_upf_fourport(port) in 8250_pci.c. With !HAS_IOPORT this is defined
as false. With that it makes sure that inb_p()/outb_p() aren't called
but I think this only works because the compiler usually drops the dead
if clause. I think there were previous discussions around this but I
think just like IS_ENABLED() checks this isn't quite correct.

Thanks,
Niklas
