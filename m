From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: serial core: crash / race condition on unbind
Date: Thu, 13 Mar 2014 08:55:36 +0100
Message-ID: <CAMuHMdU+1p+Z5dbb3Fee+3JR2Zf=se3raE5su0Z5c2+ZTBCz2w@mail.gmail.com>
References: <CAMuHMdVV_NrQ3PPJwPNx7MoM9TWLdk02d+10zNipNcC7VC0HAA@mail.gmail.com>
	<CAMuHMdVwpQEWAVHA5BO2xXzaNc1DTdteDMWFHQ=MFJoo4Afm_A@mail.gmail.com>
	<531E7F81.20400@hurleysoftware.com>
	<CAMuHMdUeUjuBe0tWpYBZqwqWT=euPAn6fwzmXMYCP573Q1BDXQ@mail.gmail.com>
	<531EF864.5020104@hurleysoftware.com>
	<CAMuHMdVgg-AbhiRPFJt=nXpP6chPw7L+ZMu8a3rnC61gaSZ41A@mail.gmail.com>
	<531F9540.4020906@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:33029 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751777AbaCMHzg (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 13 Mar 2014 03:55:36 -0400
In-Reply-To: <531F9540.4020906@hurleysoftware.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>

Hi Peter,

On Tue, Mar 11, 2014 at 11:59 PM, Peter Hurley <peter@hurleysoftware.com> wrote:
> On 03/11/2014 11:35 AM, Geert Uytterhoeven wrote:
>> On Tue, Mar 11, 2014 at 12:49 PM, Peter Hurley <peter@hurleysoftware.com>
>> wrote:
>>> On 03/11/2014 06:58 AM, Geert Uytterhoeven wrote:
>>>> On Tue, Mar 11, 2014 at 4:14 AM, Peter Hurley <peter@hurleysoftware.com>
>>>> wrote:
>>>>>>            state->uart_port = NULL;
>>>>>
>>>>> How did this ever work?
>>>>>
>>>>> Detaching the ll driver from the tty port in this manner is not ok;
>>>>> as you already note, it blows up if consoles are still running.
>>>>
>>>> No one unbinds serial drivers using serial_core, as all these drivers are
>>>> for fixed hardware?
>>>
>>> Yep, never tested until now :)
>>> Do you need this to work?
>>
>> Well, "need" may be a bit strong. Crashes are not so nice.
>
> :)
>
> What I meant was, 'is this a debug situation that I can eventually get to?'
> or 'are you on the verge of shipping product and this is a priority?'

"This is a debug situation that I can eventually get to?".

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
