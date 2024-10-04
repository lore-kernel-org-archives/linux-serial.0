Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C8D42178F1;
	Fri,  4 Oct 2024 14:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728053063; cv=none; b=iVikp/RRp7gCeXi+P/LTZOwEAIWGZAiPQY2pDv/ljWSOy5SbbbQ7Y9QdwyxAp60Trd3SyK9Swa1GeUrOVzOALQ/W7qltzmzhzLOH7xi/+5fXDdfWNo2+VdhBkhk5IIEEJN+7GudtBUIn9wmMjLq7qsX1zegj7H5JwvDsgWJvwqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728053063; c=relaxed/simple;
	bh=c2f4wjWndb0oUKVDRlhoacnlrzzFZKKdtwtL6jC5O1U=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pERgvcg3Wdm0sx+3Yf697izuzjvNNO8a3Id91Sb75IBgM8VmPXZErJCaR4ahfHMpGQWhx0DDonUkXIj/T+GXgTh4iVqBitQ2S39012SSSlY3mEUQMgML/uToV67/zcT86LqnB6MCQiMfGDWsJs/vxGhDMBgR2Iijvk/1eh6vONw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rxeTqOkD; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rxeTqOkD"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 494DnaOt006946;
	Fri, 4 Oct 2024 14:44:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:subject:from:to:cc:date:in-reply-to:references
	:content-type:content-transfer-encoding:mime-version; s=pp1; bh=
	zpDY2+Mo91IH7ru01R+RLsb8SsQF3OYQ3s8Q+4K8eCQ=; b=rxeTqOkDcffu4yGw
	jzS2TLwT5KmWRVG3XnbWZfpv6f3XmT9FiofgyzA9vEXtTQfh9SF0Eu2QK9jnqMoH
	TaRO5E22rIXQR49p+y/PSAh5Uxtfcpj6S07oXo6yh3y36fA3SnDf7V2hE/er6QpZ
	ih4Omgd2y1V7cm5Ke22wK577GkJXQm4xG8f/ZZ7eTNH5UlbdXbGwgq2e5Sa7T4qE
	yLq6KYySlgz1D1BZUOLG+a4fRXdlLdx+zHTwaSWX34i4NHIOsQ/0mU+pSCISmZDe
	M39M2jFP9j3oEuYXFAO9UIc8snp19OLlHOU8CktzeefBPgeBHArmQMHz+1DtziYr
	j19e5Q==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 422hk6g814-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 04 Oct 2024 14:44:08 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 494DmLDU009297;
	Fri, 4 Oct 2024 14:44:07 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 42207kmjfj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 04 Oct 2024 14:44:07 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 494Ei6nB48759488
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 4 Oct 2024 14:44:06 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 94A1958059;
	Fri,  4 Oct 2024 14:44:06 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D75745804B;
	Fri,  4 Oct 2024 14:44:04 +0000 (GMT)
Received: from [9.171.87.189] (unknown [9.171.87.189])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  4 Oct 2024 14:44:04 +0000 (GMT)
Message-ID: <bcd2ef21b387ee4cd3a4aa78cad85f8fae02699b.camel@linux.ibm.com>
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
Date: Fri, 04 Oct 2024 16:44:04 +0200
In-Reply-To: <e916ff3347cef88981d8e519fe1bcedfabfbea24.camel@linux.ibm.com>
References: <20240405152924.252598-1-schnelle@linux.ibm.com>
	 <20240405152924.252598-2-schnelle@linux.ibm.com>
	 <alpine.DEB.2.21.2405230244140.1257@angie.orcam.me.uk>
	 <ef2912910d006c573324bcf063cb76e843dc8267.camel@linux.ibm.com>
	 <alpine.DEB.2.21.2410011707550.45128@angie.orcam.me.uk>
	 <7bcec0eb88c3891d23f5c9f224e708e4a9bb8b89.camel@linux.ibm.com>
	 <alpine.DEB.2.21.2410021632150.45128@angie.orcam.me.uk>
	 <84bbda13-ded1-4ada-a765-9d012d3f4abd@app.fastmail.com>
	 <alpine.DEB.2.21.2410022305040.45128@angie.orcam.me.uk>
	 <e916ff3347cef88981d8e519fe1bcedfabfbea24.camel@linux.ibm.com>
Autocrypt: addr=schnelle@linux.ibm.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 3NTYzQI5m5Wy7SGGvJ6rn2aOCydiMFkN
X-Proofpoint-GUID: 3NTYzQI5m5Wy7SGGvJ6rn2aOCydiMFkN
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-04_10,2024-10-04_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 mlxscore=0
 priorityscore=1501 mlxlogscore=999 spamscore=0 lowpriorityscore=0
 impostorscore=0 phishscore=0 bulkscore=0 clxscore=1015 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410040100

On Fri, 2024-10-04 at 12:09 +0200, Niklas Schnelle wrote:
> On Wed, 2024-10-02 at 23:59 +0100, Maciej W. Rozycki wrote:
> > On Wed, 2 Oct 2024, Arnd Bergmann wrote:
> >=20
---8<---
> > > Part of the problem that Niklas is trying to solve with the
> > > CONFIG_HAS_IOPORT annotations is to prevent an invalid inb()/outb()
> > > from turning into a NULL pointer dereference as it currently does
> > > on architectures that have no way to support PIO but get the
> > > default implementation from asm-generic/io.h.
> >=20
> >  It can be worse than that.  Part of my confusion with the defxx driver=
=20
> > trying to do port I/O with my POWER9 system came from the mapping actua=
lly=20
> > resulting in non-NULL invalid pointers, dereferencing which caused a fl=
ood=20
> > of obscure messages produced to the system console by the system firmwa=
re:
> >=20
> > LPC[000]: Got SYNC no-response error. Error address reg: 0xd0010014
> > IPMI: dropping non severe PEL event
> > LPC[000]: Got SYNC no-response error. Error address reg: 0xd0010014
> > IPMI: dropping non severe PEL event
> > LPC[000]: Got SYNC no-response error. Error address reg: 0xd0010014
> > IPMI: dropping non severe PEL event
> > LPC[000]: Got SYNC no-response error. Error address reg: 0xd0010014
> > IPMI: dropping non severe PEL event
> > [...]
> >=20
> > from which it was all but obvious that they were caused by an attempt t=
o=20
> > use PCI port I/O with a system lacking support for it.
> >=20
> > > It's not clear if having a silently non-working driver or one
> > > that crashes makes it easier to debug for users. Having a clear
> > > warning message in the PCI probe code is probably the best
> > > we can hope for.
> >=20
> >  I agree.  Enthusiastically.
>=20
> I think there was also a bit of a misunderstanding. My argument that
> this would be very ugly in the general case was really meant as general
> case outside of drivers like 8250 that deals with both I/O port and
> MMIO i.e. we can't warn/error when !HAS_IOPORT deactivates a whole
> driver because seeing an I/O port BAR in common PCI code doesn't mean
> that it is required for use of the device.
>=20
> I'm working on a new proposal for 8250 now. Basically I think we can
> put the warning/error in serial8250_pci_setup_port(). And then for
> those 8250_pci.c "sub drivers" that require I/O ports instead of just
> ifdeffing out their setup/init/exit we can define anything but setup to
> NULL and setup to pci_default_setup() such that the latter will find
> the I/O port BAR via FL_GET_BASE() and subsequently cause the error
> print in serial8250_pci_setup_port(). It's admittedly a bit odd but it
> also keeps the #ifdefs to just around the code that wouldn't compile.

I've now got this to compile on s390x with the !S390 check removed in
Kconfig. Instead of "misusing" pci_default_setup() I instead added a
pci_fail_io_port_setup() helper that prints the error and returns -
EINVAL.

>=20
> One thing I'm not happy with yet is the handling around
> is_upf_fourport(port) in 8250_pci.c. With !HAS_IOPORT this is defined
> as false. With that it makes sure that inb_p()/outb_p() aren't called
> but I think this only works because the compiler usually drops the dead
> if clause. I think there were previous discussions around this but I
> think just like IS_ENABLED() checks this isn't quite correct.

It's not the nicest but I added the necessary #ifdefs in 8250_port.c
and at least they are small sections. As Arnd said we will go back to a
single series. So I've also switched to a b4 prep workflow which I
usually use nowadays and so the current code can be found here:

https://git.kernel.org/pub/scm/linux/kernel/git/niks/linux.git/log/?h=3Db4/=
has_ioport

I plan to resend on Monday based on v6.12-rc2 which will also include
the bcachefs fix to fix building on Big Endian which I was previously
carrying for my s390x development convenience.

Thanks,
Niklas=20
