From: Rob Herring <robherring2@gmail.com>
Subject: Re: [Gta04-owner] [PATCH 0/4] UART slave device support - version 4
Date: Fri, 22 Jan 2016 10:49:52 -0600
Message-ID: <CAL_JsqL_cVMzNb2VmsJND11zZd6MEBqV1fgp7yy212Le8J2jvg@mail.gmail.com>
References: <481E05A9-A192-438D-B092-D7700B30BBC4@goldelico.com>
 <20160115110106.GA3262@leverpostej> <69F8E1E5-EF49-4C8E-88E9-973F82F7102E@goldelico.com>
 <569913A1.80606@cogentembedded.com> <CB69F6F0-B40B-47D1-B175-8401F43288C5@goldelico.com>
 <56992959.2020204@hurleysoftware.com> <CAL_JsqL=Wotz4FuoV7PULfZNfSV=S_q0iOzkckVA3NDDzMdfZQ@mail.gmail.com>
 <744620565.20160116103445@cogentembedded.com> <20160116233157.GA7774@rob-hp-laptop>
 <3D5F35D7-31B5-4E68-875F-7DD492EF0316@goldelico.com> <20160117141912.4aa2e46c@lxorguk.ukuu.org.uk>
 <1D5F146E-D347-453B-9158-8D269F8DA99C@goldelico.com> <20160117193849.69d00c28@lxorguk.ukuu.org.uk>
 <37DCE36D-0A5E-41C5-BDA4-857DCF9F2DD1@goldelico.com> <20160118111926.0882b422@lxorguk.ukuu.org.uk>
 <07F3B6C0-0C87-478C-B6DD-5C0EECB42D0D@goldelico.com> <20160118220319.051c9cc0@lxorguk.ukuu.org.uk>
 <C1E6AFE7-1EF2-4C70-8BE2-82F5CD7DDE22@goldelico.com> <9E37C552-361C-4A54-980E-E3BFFF834302@goldelico.com>
 <20160120174610.1c64239a@lxorguk.ukuu.org.uk> <39B850CE-E381-4D3B-BD0A-84AFE7DAEEDF@goldelico.com>
 <CAAObsKB4oFeM9Cjet5z+vz0S1M8RZ3jFt03b38KXq+sh6f5EwA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAAObsKB4oFeM9Cjet5z+vz0S1M8RZ3jFt03b38KXq+sh6f5EwA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tomeu Vizoso <tomeu@tomeuvizoso.net>
Cc: "H. Nikolaus Schaller" <hns@goldelico.com>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Vostrikov Andrey <andrey.vostrikov@cogentembedded.com>, Mark Rutland <mark.rutland@arm.com>, Peter Hurley <peter@hurleysoftware.com>, List for communicating with real GTA04 owners <gta04-owner@goldelico.com>, NeilBrown <neil@brown.name>, Arnd Bergmann <arnd@arndb.de>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sebastian Reichel <sre@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Grant Likely <grant.likely@linaro.org>, Jiri Slaby <jslaby@suse.cz>, Marek Belisko <marek@goldelico.com>, Marcel Holtmann <marcel@holtmann.org>
List-Id: linux-serial@vger.kernel.org

On Fri, Jan 22, 2016 at 9:45 AM, Tomeu Vizoso <tomeu@tomeuvizoso.net> wrote:
> On 20 January 2016 at 19:03, H. Nikolaus Schaller <hns@goldelico.com> wrote:
>>
>> Am 20.01.2016 um 18:46 schrieb One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>:
>>
>>>> The problem is that *I* have no control over user space. But I also don't want
>>>> to say to my users "that is not my problem - get it solved yourself". This does
>>>> not help them.
>>>
>>> Stuffing things into the kernel because the user space of a given
>>> platform can't get itself organised isn't helpful to the other billion
>>> plus Linux devices out there.
>>
>> The assumption that there is  "the" user space of a given platform is wrong.
>
> I'm a bit surprised at the arguments being exchanged here regarding
> why the kernel may or may not deal with the detail that a (say) BT
> chip is behind a uart.
>
> I would have expected that the main (and IMO sufficient) reason why
> the kernel should do it is because the particular bus used to connect
> a BT chip to the CPU is a hw detail that a kernel that does its job
> should keep to itself. Same as userspace not needing to care if a BT
> chip is behind SDIO or USB, why does it have to tell the kernel behind
> which UART a BT chip is sitting?

Thanks for writing exactly what I had not gotten around to writing.
You are exactly right. While historically UART devices where not
probe-able like SDIO (in theory) and USB are and maybe that was a
reason to handle in userspace, we do have the technology to describe
the UART connections now.

Adding Marcel who has also previously commented on the reasons why
this belongs in the kernel [1].

Rob

[1] https://lists.linuxfoundation.org/pipermail/ksummit-discuss/2015-August/002212.html
