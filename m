Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40C131E377D;
	Fri,  4 Oct 2024 16:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728057839; cv=none; b=fzuBytcU2hBiF03TE3yuNAtNNJCWdVb6iI3vkZk3VgyaY49NS8Zb21R1/oGRwUvHcQG7Rk4wfEv7b5Cwyzgnj0PZFHjjZBUwR0fpwXI9bxpZru8zekzCfaq4A/P4E1eJ3ctJ0+Fl67wCCxXm1MuP8w2qLFWzb/oZKPZquVikVdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728057839; c=relaxed/simple;
	bh=9ea+zWqqt7siqy6qOXzP3uto4QAFiHkliWHiG5UbJss=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mf9fCsZ3pcBhdOkrrZc+Oq9MXrnZHzG/PNF+Qd8GK7BnSLi04eRXocgUzRZml0KsiG8BId0m+l/Rt47mpXbHTKCrBrsH9bJYjWEG6LHfpFhr7z+nyZQ5pzwEjH+c6IUn/PDcKFeCs+ZGc0gn7x80ekYatlf5S4yCAHGikYa/KHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=F/4QE4ix; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="F/4QE4ix"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 494Fv0wJ019827;
	Fri, 4 Oct 2024 16:03:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:subject:from:to:cc:date:in-reply-to:references
	:content-type:content-transfer-encoding:mime-version; s=pp1; bh=
	jQ+wFzVfxPX35cujQ6GKn6bMYeR2bpXlEYcS8vgA8KM=; b=F/4QE4ixnDdhXNAM
	/dgaMgRih8r1GXCniF/7uaZLS1VbrMpapYXv1zHdVYKNZltPkL/viEq/ZmKZEqBO
	T6EdfAov62st6+L2/nSfpGG1X79cIjmpTaytU2LVs/BzPnV1+7Oi6Ylj3IG6h+J/
	yqGwaG0GfA5DI7lgemgJtQCqLiQpE3/NsmIDx9Yhld/fAwjXLKuqCJZItLYTKg6Y
	lkhG7nT5vOlz5UHzk6kf4Wl8nid2RLejz/lBrpActInJaKGzl5JlB3MqSDVuuYe7
	7HoIo1/CMXYH3cI8MXt9HpH6g9iU+J2XYzGnANBcTPvHYMeKxfYfo23BMAraMPCt
	Jlx9hQ==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 422kejg19f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 04 Oct 2024 16:03:48 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 494DqsmE017912;
	Fri, 4 Oct 2024 16:03:47 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 42207jcw8f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 04 Oct 2024 16:03:47 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 494G3leU37355964
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 4 Oct 2024 16:03:47 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6CB1958067;
	Fri,  4 Oct 2024 16:03:47 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F05535805D;
	Fri,  4 Oct 2024 16:03:45 +0000 (GMT)
Received: from [9.171.87.189] (unknown [9.171.87.189])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  4 Oct 2024 16:03:45 +0000 (GMT)
Message-ID: <d5c4e2aa1cc04bf1259fb6bd44f269621693b114.camel@linux.ibm.com>
Subject: Re: [PATCH 1/1] tty: serial: handle HAS_IOPORT dependencies
From: Niklas Schnelle <schnelle@linux.ibm.com>
To: Arnd Bergmann <arnd@kernel.org>, "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby
 <jirislaby@kernel.org>,
        Ilpo =?ISO-8859-1?Q?J=E4rvinen?=
 <ilpo.jarvinen@linux.intel.com>,
        linux-serial@vger.kernel.org, Heiko
 Carstens <hca@linux.ibm.com>,
        linux-kernel@vger.kernel.org
Date: Fri, 04 Oct 2024 18:03:45 +0200
In-Reply-To: <eedc037b-8790-4269-8ed6-d641b9cbc4ad@app.fastmail.com>
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
	 <eedc037b-8790-4269-8ed6-d641b9cbc4ad@app.fastmail.com>
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
X-Proofpoint-ORIG-GUID: f7farfyOx9g5_m6IR_CEmrzVVB8AzlLg
X-Proofpoint-GUID: f7farfyOx9g5_m6IR_CEmrzVVB8AzlLg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-04_13,2024-10-04_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxscore=0
 mlxlogscore=844 adultscore=0 clxscore=1015 impostorscore=0 phishscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410040110

On Fri, 2024-10-04 at 12:48 +0000, Arnd Bergmann wrote:
> On Fri, Oct 4, 2024, at 10:09, Niklas Schnelle wrote:
>=20
> > I'm working on a new proposal for 8250 now. Basically I think we can
> > put the warning/error in serial8250_pci_setup_port(). And then for
> > those 8250_pci.c "sub drivers" that require I/O ports instead of just
> > ifdeffing out their setup/init/exit we can define anything but setup to
> > NULL and setup to pci_default_setup() such that the latter will find
> > the I/O port BAR via FL_GET_BASE() and subsequently cause the error
> > print in serial8250_pci_setup_port(). It's admittedly a bit odd but it
> > also keeps the #ifdefs to just around the code that wouldn't compile.
>=20
> Right, makes sense.
>=20
> > One thing I'm not happy with yet is the handling around
> > is_upf_fourport(port) in 8250_pci.c. With !HAS_IOPORT this is defined
> > as false. With that it makes sure that inb_p()/outb_p() aren't called
> > but I think this only works because the compiler usually drops the dead
> > if clause. I think there were previous discussions around this but I
> > think just like IS_ENABLED() checks this isn't quite correct.
>=20
> Not sure what you mean, we rely on dead code elimination in all
> kinds of places. The only bit to be aware of is that normal
> 'inline' functions may not get constant-folded all the time,
> but anything that is either a macro or __always_inline does
> work.

Ah ok, didn't know this was okay to rely on. Then I can roll the extra
#ifdefs back. Need to address the test bot's finding anyway. There we
can get #ifdef __i386__ but also !HAS_IOPORT on um.

>=20
> I just verified that the version below does what Maciej
> suggested with IS_ENABLED() in 8250-pci, and this works fine.
>=20
>        Arnd

Your version below is also pretty nice a bit more spread out but less
#ifdefs. That said at least in my NeoVim setup the #ifdefs are nicely
grayed out via clang-analyzer / lsp which to me actually makes #ifdefs
quite easy to see at a glance but that's probably a niche opinion.

>=20
> diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250=
/8250_pci.c
> index 6709b6a5f301..784190824aad 100644
> --- a/drivers/tty/serial/8250/8250_pci.c
> +++ b/drivers/tty/serial/8250/8250_pci.c
> @@ -928,6 +928,14 @@ static int pci_netmos_init(struct pci_dev *dev)
>  	return num_serial;
>  }
> =20
> +static int serial_8250_need_ioport(struct pci_dev *dev)
> +{
> +	dev_warn(&dev->dev,
> +		 "Serial port not supported because of missing I/O resource\n");
> +
> +	return -ENXIO;
> +}
> +
---8<---

