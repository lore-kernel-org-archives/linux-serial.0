Received: from mail.systec-electronic.com (mail.systec-electronic.com [77.220.239.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E92F4C6C;
	Wed, 15 Jan 2025 05:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.220.239.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736918601; cv=none; b=Q4Hv8J7rOiOtuK33CSCaBl5Y5x3aa3Ub+pFjnwCVoxJPobpMnCEGAaeCVF5DSsy9ZW5mj/GzUu/1OThQYJjwMr7qau4Q4yRo1mGzNf89FkmDJNlLk3CSyCu0v6stLM5YXLr20vzSgr+hNDXnHtcae7h2779cyZNWMuyyUiKC0gI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736918601; c=relaxed/simple;
	bh=u8gf+tS1sfBUBJkKf1JwsZyRLyFxuXOaSSEg2APwr0o=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=SnGbEqxXCkbiddiQQzfCXYjxJ55EIxMp6ZWRl0+rTbbQgOXQsNaPFKoUdUAhPdN7eI4ef0kLvyH2yPfKvlnE1yiCJow1E7rTe5bn6OolY7gPIrF3wTTdynER2Hp8Sait+Ye0W4lR1xdrlgg2V5+Tl+ZbvCvp1O1Hd/MoiE+Jm/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=systec-electronic.com; spf=pass smtp.mailfrom=systec-electronic.com; dkim=pass (2048-bit key) header.d=systec-electronic.com header.i=@systec-electronic.com header.b=Z/nDIK7U; arc=none smtp.client-ip=77.220.239.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=systec-electronic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=systec-electronic.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=systec-electronic.com header.i=@systec-electronic.com header.b="Z/nDIK7U"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.systec-electronic.com (Postfix) with ESMTP id 9771C941A5C2;
	Wed, 15 Jan 2025 06:23:09 +0100 (CET)
Received: from mail.systec-electronic.com ([127.0.0.1])
 by localhost (mail.systec-electronic.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id 0PQdk0Wy8DRR; Wed, 15 Jan 2025 06:23:09 +0100 (CET)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.systec-electronic.com (Postfix) with ESMTP id 67867941A5C4;
	Wed, 15 Jan 2025 06:23:09 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.systec-electronic.com 67867941A5C4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=systec-electronic.com; s=B34D3B04-5DC7-11EE-83E3-4D8CAB78E8CD;
	t=1736918589; bh=TycTRDQsyHf0xmSmtDI1Y1rMY6gr4hDNBqKqb1dPLCE=;
	h=Date:From:To:Message-ID:MIME-Version;
	b=Z/nDIK7UcgmO7pPXTLOfUc354N3uNhTSTdvRObrSzZXDvvCllBx/SymkHU/cw4ZQ0
	 8mLaxE/nUB5GTT1u/JqG3meZTmp79JxSRZ25tykiUEaOamCwWUlafeOgxuzDqz64fa
	 i6vRhZXV4xWs3Q1aFgWQPSjOhsugTQJzzHGrpEQ9Lt8ScI7nAfrPnUkdRqIQ/+vnGI
	 a00ssyt7StIumSZKKqZUUTVenQLEZWIR0PBEc6tOP1nnphbtkRkyjrRrzGkN8QOkJV
	 uMUev9y73fDTAUDo2IdDD6YAmN/joRkvQaq+xqBEa2sqHT7oTz+iUvk9Kt7yp+SwGt
	 wrP8K+7XhhrOA==
X-Virus-Scanned: amavis at systec-electronic.com
Received: from mail.systec-electronic.com ([127.0.0.1])
 by localhost (mail.systec-electronic.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id m6eD9M80UKQN; Wed, 15 Jan 2025 06:23:09 +0100 (CET)
Received: from lt-278851.systec.local (unknown [212.185.67.148])
	by mail.systec-electronic.com (Postfix) with ESMTPSA id EE672941A5C2;
	Wed, 15 Jan 2025 06:23:08 +0100 (CET)
Date: Wed, 15 Jan 2025 06:23:08 +0100 (CET)
From: Andre Werner <andre.werner@systec-electronic.com>
Reply-To: Andre Werner <andre.werner@systec-electronic.com>
To: Andy Shevchenko <andy@kernel.org>
cc: Andre Werner <andre.werner@systec-electronic.com>, 
    gregkh@linuxfoundation.org, jirislaby@kernel.org, hvilleneuve@dimonoff.com, 
    devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
    linux-serial@vger.kernel.org, lech.perczak@camlingroup.com, 
    krzk+dt@kernel.org, conor+dt@kernel.org, robh@kernel.org
Subject: Re: [External Email] Re: [PATCH v7 2/2] serial: sc16is7xx: Add
 polling mode if no IRQ pin is available
In-Reply-To: <Z4Z7JUP2vMEX9JsW@smile.fi.intel.com>
Message-ID: <bc6aafdc-4b86-956b-afa0-ecf5b3ef393c@systec-electronic.com>
References: <20250114070449.34226-1-andre.werner@systec-electronic.com> <20250114070449.34226-2-andre.werner@systec-electronic.com> <Z4Z7JUP2vMEX9JsW@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-1463794929-641841564-1736918589=:17662"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463794929-641841564-1736918589=:17662
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable


Dear Andy,

On Tue, 14 Jan 2025, Andy Shevchenko wrote:

> On Tue, Jan 14, 2025 at 08:04:49AM +0100, Andre Werner wrote:
> > Fall back to polling mode if no interrupt is configured because there
> > is no possibility to connect the interrupt pin.
> >
> > If no interrupt pin is available the driver uses a delayed worker to
> > poll the state of interrupt status registers (IIR).
>
> ...
>
> > V6:
> > - Use polling mode for IRQ numbers <=3D 0 which encounter no valid IR=
Q
> >   were found/defined.
> > V7:
> > - Try to improve and unify comments as requested.
> > - Fix typo in commit message: pull -> poll
>
> Please, rebase your series on top of the recent Linux Next.

I performed the rebase and get a single new commit to fix the merge
conflicts. How do you expect the submission? Is it a new commit or
should I mark it as a fixup? Shall it have new version number v8 or
is it a full new commit series?

>
> --
> With Best Regards,
> Andy Shevchenko
>
>
>

Thanks and best regards,

Andr=E9
---1463794929-641841564-1736918589=:17662--
