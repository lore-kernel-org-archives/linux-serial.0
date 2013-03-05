From: Bastian Hecht <hechtb@gmail.com>
Subject: Re: [PATCH v4 3/3] ARM: mach-shmobile: r8a7740: Setup the serial
 devices using DT
Date: Tue, 5 Mar 2013 14:47:17 +0100
Message-ID: <CABYn4swottJ6knJXfHntJuWJ9rzrC7kA-47TaKJRG0mh+u+Pig@mail.gmail.com>
References: <1362414054-23092-1-git-send-email-hechtb+renesas@gmail.com>
	<1362414054-23092-3-git-send-email-hechtb+renesas@gmail.com>
	<2835497.S76YK1KMLM@wuerfel>
	<CABYn4sx=bC6JwicbVgRnmwdu=6DuW5GFgdG25a-Wow1Jn9M-bQ@mail.gmail.com>
	<5135F647.8050002@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <5135F647.8050002@cogentembedded.com>
Sender: linux-sh-owner@vger.kernel.org
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org, linux-sh@vger.kernel.org, Paul Mundt <lethal@linux-sh.org>, Magnus Damm <magnus.damm@gmail.com>, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

2013/3/5 Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>:
> Hello.
>
>
> On 05-03-2013 17:00, Bastian Hecht wrote:
>
>>>> +       sci@e6c40000 {
>>>> +               compatible = "renesas,sci-SCIFA-uart";
>>>> +               interrupt-parent = <&intca>;
>>>> +               reg = <0xe6c40000 0x100>;
>>>> +               interrupts = <0x0c00>, <0x0c00>, <0x0c00>, <0x0c00>;
>>>> +               cell-index = <0>;
>>>> +               renesas,scscr = <0x30>;
>>>> +               renesas,scbrr-algo-id = <4>;
>>>> +               renesas,autoconf;
>>>> +       };
>>>
>>>
>>> The default name for a uart is "serial", I would recommend sticking to
>>> that by convention. You may also want to add an "aliases" node
>>> somewhere, to define which port should get which logical device number
>>> on a given board.
>
>
>> Switched to "...-serial".
>
>
>    I think he was talking about the node name, not "compatible" property.

Ah sure! I'll wait for responses to v5 and will change it around in v6.

Thanks,

 Bastian


> WBR, Sergei
>
