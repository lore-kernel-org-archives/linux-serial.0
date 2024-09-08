Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB420176AC2
	for <linux-serial@vger.kernel.org>; Sun,  8 Sep 2024 20:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725826698; cv=none; b=jZwCuo0M8R95dWHd503HN5Tw3UJrYjADq1IgB939KCCSo3X6fLI7t+KN4N8Z+oBbjT31r7N82hxDiubWEeN1rinh7FTvtRhu4ZEJVC2RqvdBwzRmKzkclFqyYCj9tPGwo49BqjzYWKghwe/iuNDpKK5nvZ+qVrUk1NbZjhv/mqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725826698; c=relaxed/simple;
	bh=u+LEFLJPTCcLP//r/AZjcuvQGoHkeIrodEnWb0ofpNg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=GTvZ5eVI3A/OgCteE9aYiYkvihgKth5CIEcvh7iTpHyN7k3M/6gnp/3YSJxJSbqS3rqxxEbehMBYj13CKhPY+izNcQ9GbX3I7oqtNrnAjHo5qAGQB1911cf7yVISM/a4dmWZgCGNtsWoHByGtMHuIRONDRmOplsCA0jFf6Ga5hM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=radisson97@web.de header.b=MOFtWfEG; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=radisson97@web.de header.b="MOFtWfEG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1725826693; x=1726431493; i=radisson97@web.de;
	bh=J9dZvPrE5No80fSlEjUCCPde6FZtgL7+6mKG3hvLxsw=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:Cc:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=MOFtWfEGQnjfVosfMMDHjsK7RF52BW/zAYWcOcqtSOpZQ5TOW1uBqFAT+bd6KVJv
	 2Zgb9CsiZ5JwH2br2bg2v9KaP/7rnrkZeH6WxvpsAuoBg29zkvKUarHCXx0uV2mOT
	 p51t9QgYK4Q0+p0qrwLr9e7f47lmAKCdruqPIeiY1fG5xXVsQoEts1XJZLq2AdXs5
	 +E0VbUeMC/FjojoNKIZRWI3swqtYdDDf8bHw1gTBR2oLBmFXNcFDWQO9PFNemrq1a
	 MlRmTsKY24ocb0U2DsbLx+B7NC0NGjNBQhuEm3rHF4LlXPrc1nS/J8kB7Y4Ucm0ki
	 l+LycMeq55/DE6bkRQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.200.19] ([109.43.176.209]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MjBVv-1s97Wz3Btl-00eThW; Sun, 08
 Sep 2024 22:18:12 +0200
Message-ID: <a2f398fb-3649-4b84-82ac-cd3b2fff7fab@web.de>
Date: Sun, 8 Sep 2024 22:18:11 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: possible regression with rs485 usage
Content-Language: en-US
To: Greg KH <gregkh@linuxfoundation.org>
References: <trinity-385b45db-ce89-419e-a226-4e10351f0c0d-1725524112044@msvc-mesg-web108>
 <2024090555-dispatch-recent-b3ad@gregkh>
From: Peter Radisson <radisson97@web.de>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <2024090555-dispatch-recent-b3ad@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:9Qb5pDkyJ22E3WaqwkMuYviZQmR5DiurPdAB73ELcHNINTbZK9J
 7E578tnzLp9SHEjyQqL2XtFSHISb0L7syPxtgVvYaeIRuiLC8fk8FYEMSY0X4fpmpYdWdk5
 Ds1CcZdQghibnHdEZrBBIonelx3P7DB5aidzDFs5pAno8K7RYlcO9/NCUW/dDHlEBY76dQ1
 tx9nYkXWA631aGFBT8Q+Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Rq3xlD1EPWc=;5omLqJwtK9NxuBlhvIw/XU/Zhws
 o1FGw2GR0gjk9OR5yS75nOdTOgeMNVOuR5ZdgHrLwv5fsJWrgtzucMOhRHRjHRvdkHuI3MfOI
 oy12O2CPGN19tpzC38NWotopNxaynPT8W4LWdtz5nRoggAXUPPoDcSsIEGnm1pLkJw9k82xOi
 b4TYYR2sdjBSwD4XAOubuvWUNfkOVN0rjM1mcO+Dt4/aJOP3i46NCm4snNdkxu8pZpDGOiyR+
 zZlvUxqJRtwZn8MkKxwHxlXG8zYLuHf527b3uGdSPS+iI+aTONKibjaf7L583njgNllbwwV20
 1QbSTHnoxO2jFRGjCy9cfZhmOvTzjwOUw14Y01tAPiNWLusKcRmCTzm64EMjllVbZxRyiY/Xj
 BzTzml3BO8Y7z3/chNv01nsHjs7+NEh39FSHLQVRnwES5zlZlzGm65z/EU1PoZqiWKyt+QbQF
 7YZiuo0Zgq+AlxyU6YCdzmv0SsjlVp9TRaBubce/dhAXc7zazw8fFf2XEH23QSIVK3gcnAIbu
 81Fj7hw3tgJLmgHfmYcu3LGeTsuD6DdNicsVc7ouSCU8f3ZRYESA2idLBJntCtUZzqHFTQOhr
 iKAZm+oZxrjWi3Jk2tPuQaJKGeBpWItYREHx2Cyy9Bm9DVKsNYvVUOOcHj5ei90K0yv7abStT
 0Yvk3ZdBuEcsl7l9YhETX3kIVqw7hNs2Ou4SVFtFu0PimY+GWJKD1AKImyZl1fsT0wO7Czquj
 bDXSOrCCIrzRcc7Eug0cudbNTkTzEud2UBOlo+uce0NHs1aM+vMbLc4DRSQ9jwd8bf5/4TdpN
 /mkbNMSuMDz2EzG3zYCIiasA==



Am 05.09.24 um 10:25 schrieb Greg KH:
> On Thu, Sep 05, 2024 at 10:15:12AM +0200, Radisson97@web.de wrote:
>> Hi, i am new to this list because i have a strange problem.
>>
>> We have an embedded board based on the omap3-design with a rs485.
>> With kernel 3.5 it works fine. Since 3.5 is ancient we are noe trying
>> to get a new kernel up an running what is 5.8.
>
> Any specific reason why 5.8?  That too is ancient and obsolete and not
> supported by anyone.
>
it seems the last kernel where our system seems to work. We want the
system to work with the vanilla kernel in future, for now we would be
happy to have a workng system at all.

>> I turns out that the rs485 has issues (it seems a lot of ppl have
>> the same issue also with other boards). We enable the rs485 via ioctl()
>> and nothing seems to work. Several restarts, playing with Marcin Niestr=
oyj's
>> rs485config it suddenly works. (yes hardware is ok, works with older ke=
rnel).
>
> So it does work?
instable to say politely, we do not understand why, (read: this error
makes no sense). it seems stop working in later versions.
>
> What exact hardware and drivers are you using?
>
Board vased on Omap3-design with
* AM3703 with twl4030
* cp210x
* Ax88796

> And can you try a modern and supported kernel version please?  We can't
> do anything with 5.8 :(
>
Its a stepstone, (s.o). We have contracted a companie to upgrade the
kernel but they had trouble getting the patches accepted (so i send the
Ax88796 patch to the -netdev ml but i could not figure out
if there where incorporated actualy)

> thanks,
>
> greg k-h

hope that helps,

