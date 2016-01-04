From: Greg Ungerer <gerg@uclinux.org>
Subject: Re: [PATCH] serial: Remove 68328 driver
Date: Mon, 4 Jan 2016 21:10:07 +1000
Message-ID: <568A530F.8020807@uclinux.org>
References: <1449830170-15096-1-git-send-email-frederik.voelkel@fau.de>
 <1450438103-1059-1-git-send-email-frederik.voelkel@fau.de>
 <CAMuHMdW6r_QszpXTj1FLtOfjzPqDCU7UcF6OT+7MgW8uo01KYA@mail.gmail.com>
 <5689FD36.4020609@westnet.com.au>
 <20160104103031.655b6f61@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160104103031.655b6f61@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Cc: Linux/m68k <linux-m68k@vger.kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, =?UTF-8?Q?Frederik_V=c3=b6lkel?= <frederik.voelkel@fau.de>, Jiri Slaby <jslaby@suse.com>, Greg KH <gregkh@linuxfoundation.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-kernel@i4.cs.fau.de, Lukas Braun <lukas.braun@fau.de>, uClinux development list <uclinux-dev@uclinux.org>
List-Id: linux-serial@vger.kernel.org

On 04/01/16 20:30, One Thousand Gnomes wrote:
> On Mon, 4 Jan 2016 15:03:50 +1000
> Greg Ungerer <gregungerer@westnet.com.au> wrote:
>
>> If 68328serial.c is removed is there any point keeping the
>> architecture support for 68328 platforms?
>>
>> The 68328serial.c provides pretty much the only type of console
>> that can be used on these devices. They are largely useless
>> without this
>
> Probably we should - unless someone wants to stand up and say "actually
> I'm using this with current kernels, need it, and I'll maintain it"
>
> Somehow I doubt anyone is.

Yep, I suspect you are right.
I can't even remember the last time a patch or improvement
for 68328 came past me. Same goes for 68360 cpu/platform
as well.

Regards
Greg
