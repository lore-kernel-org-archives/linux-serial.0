From: Sonic Zhang <sonic.adi@gmail.com>
Subject: Re: [PATCH][uart] fit blackfin uart over sport driver into common
	uart inftrastructure (v2)
Date: Fri, 18 Sep 2009 13:11:50 +0800
Message-ID: <4e5ebad50909172211s309cfcdbl7edd904178996799@mail.gmail.com>
References: <1253095348.25791.6.camel@eight.analog.com>
	 <8bd0f97a0909161156x3cf83b51tb01f6c890abf8594@mail.gmail.com>
	 <4e5ebad50909172154m3c6450f2u7512f20ee3f1951e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-yw0-f175.google.com ([209.85.211.175]:35316 "EHLO
	mail-yw0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750822AbZIRFLr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 18 Sep 2009 01:11:47 -0400
In-Reply-To: <4e5ebad50909172154m3c6450f2u7512f20ee3f1951e@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Mike Frysinger <vapier.adi@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Linux Kernel <linux-kernel@vger.kernel.org>, Linux Serial <linux-serial@vger.kernel.org>

On Fri, Sep 18, 2009 at 12:54 PM, Sonic Zhang <sonic.adi@gmail.com> wro=
te:
> On Thu, Sep 17, 2009 at 2:56 AM, Mike Frysinger <vapier.adi@gmail.com=
> wrote:
>>
>> then we get proper device bindings between ttySS# and SPORT# by usin=
g
>> the .id field. =A0ttySS0 should always be SPORT0, ttySS1 should alwa=
ys
>> be SPORT1, etc...
>
> You can't either. Because the index of tty devices is increased
> automatically when you successfully register a uart port. =A0If sport=
0
> is used for devices other than uart, uart over sport1 is always bond
> to ttySS0.
>
>
OK. This looks possible. I will take a look.

Sonic
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
