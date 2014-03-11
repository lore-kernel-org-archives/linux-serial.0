From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: serial core: crash / race condition on unbind
Date: Tue, 11 Mar 2014 16:35:38 +0100
Message-ID: <CAMuHMdVgg-AbhiRPFJt=nXpP6chPw7L+ZMu8a3rnC61gaSZ41A@mail.gmail.com>
References: <CAMuHMdVV_NrQ3PPJwPNx7MoM9TWLdk02d+10zNipNcC7VC0HAA@mail.gmail.com>
	<CAMuHMdVwpQEWAVHA5BO2xXzaNc1DTdteDMWFHQ=MFJoo4Afm_A@mail.gmail.com>
	<531E7F81.20400@hurleysoftware.com>
	<CAMuHMdUeUjuBe0tWpYBZqwqWT=euPAn6fwzmXMYCP573Q1BDXQ@mail.gmail.com>
	<531EF864.5020104@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <531EF864.5020104@hurleysoftware.com>
Sender: linux-sh-owner@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
List-Id: linux-serial@vger.kernel.org

Hi Peter,

On Tue, Mar 11, 2014 at 12:49 PM, Peter Hurley <peter@hurleysoftware.com> wrote:
> On 03/11/2014 06:58 AM, Geert Uytterhoeven wrote:
>> On Tue, Mar 11, 2014 at 4:14 AM, Peter Hurley <peter@hurleysoftware.com>
>> wrote:
>>>>
>>>>
>>>>           [...]
>>>>
>>>>           /*
>>>>            * Indicate that there isn't a port here anymore.
>>>>            */
>>>>           uport->type = PORT_UNKNOWN;
>>>>
>>>>           state->uart_port = NULL;
>>>
>>>
>>> How did this ever work?
>>>
>>> Detaching the ll driver from the tty port in this manner is not ok;
>>> as you already note, it blows up if consoles are still running.
>>
>> No one unbinds serial drivers using serial_core, as all these drivers are
>> for fixed hardware?
>
> Yep, never tested until now :)
> Do you need this to work?

Well, "need" may be a bit strong. Crashes are not so nice.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
