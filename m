From: Mike Frysinger <vapier.adi@gmail.com>
Subject: Re: [PATCH][uart] fit blackfin uart over sport driver into common
	uart inftrastructure (v2)
Date: Fri, 18 Sep 2009 02:24:16 -0400
Message-ID: <8bd0f97a0909172324j32331e6ele1435cd93de188c@mail.gmail.com>
References: <1253095348.25791.6.camel@eight.analog.com> <8bd0f97a0909161156x3cf83b51tb01f6c890abf8594@mail.gmail.com>
	<4e5ebad50909172154m3c6450f2u7512f20ee3f1951e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-yw0-f175.google.com ([209.85.211.175]:48523 "EHLO
	mail-yw0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751694AbZIRGYc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 18 Sep 2009 02:24:32 -0400
In-Reply-To: <4e5ebad50909172154m3c6450f2u7512f20ee3f1951e@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Sonic Zhang <sonic.adi@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Linux Kernel <linux-kernel@vger.kernel.org>, Linux Serial <linux-serial@vger.kernel.org>

On Fri, Sep 18, 2009 at 00:54, Sonic Zhang wrote:
> On Thu, Sep 17, 2009 at 2:56 AM, Mike Frysinger wrote:
>> On Wed, Sep 16, 2009 at 06:02, sonic zhang wrote:
>>> 3. Move most platform data into arch specific board files.
>>
>> might as well do it right now since you've done most of it already.
>> i.e. all of the peripheral logic should be in the boards, not the
>> driver. =C2=A0so the bfin_uart_pin_req_sportx lists should get moved=
 to the
>> platform resources as well as the SPORT base addresses.
>
> No. You can't. Because the console is registered and running much
> earlier than the platform data is initialized. You have to know the
> peripheral lists and base address before registering the console.

this is why the early_platform_driver framework was created.  i was
looking into adding this to the Blackfin serial driver.  check out
Documentation/driver-model/platform.txt.

>>> Signed-off-by: Michael Frysinger <michael.frysinger@analog.com>
>>
>> you shouldnt add s-o-b tags for people who didnt opt for them ... i
>> was sleeping when you wrote, committed, and e-mailed out these
>> changes. =C2=A0i also handt posted these changes yet because i knew =
there
>> were still issues to be worked out.
>
> OK. I mean you also did some cleanup to this patch.

well once we get these issues hashed out, i'm happy to say the code is
good stuff ;)
-mike
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
