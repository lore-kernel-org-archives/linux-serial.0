Received: from mail.systec-electronic.com (mail.systec-electronic.com [77.220.239.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83819155300;
	Fri, 17 Jan 2025 12:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.220.239.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737117487; cv=none; b=R0BvZlYBQRgUQcsNZT2EDbuWlSxI+MnoSq51y9ta1q+S08ugkFWSo+5A7Rq8gmjFBGQTJrRQ77RQnIOIsJHvojKIaso1dj8W5hk2NxcUMpdIty7S6yhZUGEySY7zPWw+wR+Fxi4qa/OIbDpIfz1fuUWQB4AvYl1gYHuhNhOEg0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737117487; c=relaxed/simple;
	bh=PMk6No1F0yK2Ij46s/f+tiYAv1DZnGzeluOn1EKz/Gc=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=PN70XksxFgCChxsubkODI1T8Rqc3jRLPPC7W2YiNmUj1lxtoGUf5S/QvXYm5wImiRqDgpq3W55KsaBZyEtyizCZ2GYHg1HjBQtv8cLDNfJSwcgCGyZw5wOq8fe14nuPVROz9+mPmKzmYOstxRsFrr3qnfAW6EcsyxEy/GIeg854=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=systec-electronic.com; spf=pass smtp.mailfrom=systec-electronic.com; dkim=pass (2048-bit key) header.d=systec-electronic.com header.i=@systec-electronic.com header.b=UBusCFXR; arc=none smtp.client-ip=77.220.239.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=systec-electronic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=systec-electronic.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=systec-electronic.com header.i=@systec-electronic.com header.b="UBusCFXR"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.systec-electronic.com (Postfix) with ESMTP id 91542940010A;
	Fri, 17 Jan 2025 13:37:55 +0100 (CET)
Received: from mail.systec-electronic.com ([127.0.0.1])
 by localhost (mail.systec-electronic.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id j8jyv-Q8Gsjk; Fri, 17 Jan 2025 13:37:55 +0100 (CET)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.systec-electronic.com (Postfix) with ESMTP id 66349941A5C4;
	Fri, 17 Jan 2025 13:37:55 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.systec-electronic.com 66349941A5C4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=systec-electronic.com; s=B34D3B04-5DC7-11EE-83E3-4D8CAB78E8CD;
	t=1737117475; bh=RQH+LbPn6Wwqo9t4+pldsiS3V/b5Hf8BN99fIAdkB78=;
	h=Date:From:To:Message-ID:MIME-Version;
	b=UBusCFXRJ4Q6nUksxQ/bIcFHA2IM9Kl4WjeBAHdGiYQvBUc7CMb9zH6r3EdR94mha
	 zGwYW0A57KUEgSOB3hVM8nZhbvSVqeYftllGxBwQht3kXcr2Sd3Z6kvj93KBkdALaW
	 BRldj7gGnkleLD5mzS9XBDT4N//K0o/vtEi/0N7dfU27pp5EhwJWQR6JUUKxgh0b7w
	 XN0k/Ay3BD21V2VkJgdLdw0lEo77SKEKRJR9yx9fXX4eBcBHIOjtxBV6v0zmLIkAZz
	 Vmi+A0mV+AVcksDAPoxmCfrEKmMczhi0DGho6+jJdQCmCoHdyHJXi3VKl7KbVE/bvQ
	 IapXr6dB3fDlQ==
X-Virus-Scanned: amavis at systec-electronic.com
Received: from mail.systec-electronic.com ([127.0.0.1])
 by localhost (mail.systec-electronic.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id hcyz4HO7SOPN; Fri, 17 Jan 2025 13:37:55 +0100 (CET)
Received: from lt-278851.systec.local (unknown [212.185.67.148])
	by mail.systec-electronic.com (Postfix) with ESMTPSA id 0A366940010A;
	Fri, 17 Jan 2025 13:37:55 +0100 (CET)
Date: Fri, 17 Jan 2025 13:37:54 +0100 (CET)
From: Andre Werner <andre.werner@systec-electronic.com>
Reply-To: Andre Werner <andre.werner@systec-electronic.com>
To: Greg KH <gregkh@linuxfoundation.org>
cc: Andre Werner <andre.werner@systec-electronic.com>, jirislaby@kernel.org, 
    hvilleneuve@dimonoff.com, andy@kernel.org, devicetree@vger.kernel.org, 
    linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
    lech.perczak@camlingroup.com, krzk+dt@kernel.org, conor+dt@kernel.org, 
    robh@kernel.org
Subject: Re: [External Email] Re: [PATCH v7] serial: sc16is7xx: Add polling
 mode if no IRQ pin is available
In-Reply-To: <2025011739-tavern-carpenter-86c3@gregkh>
Message-ID: <b24fba36-48bd-103b-8a6b-386d050ae5f6@systec-electronic.com>
References: <CAHp75Vc==m3mE1TtxjHnpwL-d8W4rFnKreu7XB7MWspJKCCOGA@mail.gmail.com> <20250116083447.453615-1-andre.werner@systec-electronic.com> <2025011739-tavern-carpenter-86c3@gregkh>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-1463794929-1452185776-1737117475=:445428"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463794929-1452185776-1737117475=:445428
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Dear Greg,

> On Thu, Jan 16, 2025 at 09:34:47AM +0100, Andre Werner wrote:
> > Fall back to polling mode if no interrupt is configured because there
> > is no possibility to connect the interrupt pin.
> >
> > If no interrupt pin is available the driver uses a delayed worker to
> > poll the state of interrupt status registers (IIR).
> >
> > Signed-off-by: Andre Werner <andre.werner@systec-electronic.com>
> > Link: https://lore.kernel.org/r/20250110073104.1029633-2-andre.werner=
@systec-electronic.com
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>
> This whole commit is already in my tree, why is it submitted again?

This is my fault. I misunderstood a comment from a reviewer.
There is a patch that i still discussed in this thread:

https://lkml.org/lkml/2025/1/16/398

Also the thread has a weird structure. Sorry!

>
> confused,
>
> greg k-h
>

Regards,
Andr=E9
---1463794929-1452185776-1737117475=:445428--
