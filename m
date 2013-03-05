From: Bastian Hecht <hechtb@gmail.com>
Subject: Re: [PATCH v4 3/3] ARM: mach-shmobile: r8a7740: Setup the serial
 devices using DT
Date: Tue, 5 Mar 2013 14:00:41 +0100
Message-ID: <CABYn4sx=bC6JwicbVgRnmwdu=6DuW5GFgdG25a-Wow1Jn9M-bQ@mail.gmail.com>
References: <1362414054-23092-1-git-send-email-hechtb+renesas@gmail.com>
	<1362414054-23092-3-git-send-email-hechtb+renesas@gmail.com>
	<2835497.S76YK1KMLM@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-bk0-f53.google.com ([209.85.214.53]:52971 "EHLO
	mail-bk0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752848Ab3CENAn (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 5 Mar 2013 08:00:43 -0500
In-Reply-To: <2835497.S76YK1KMLM@wuerfel>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, linux-sh@vger.kernel.org, Paul Mundt <lethal@linux-sh.org>, Magnus Damm <magnus.damm@gmail.com>, linux-serial@vger.kernel.org

Hi Arnd,

2013/3/4 Arnd Bergmann <arnd@arndb.de>:
> On Monday 04 March 2013 17:20:54 Bastian Hecht wrote:
>>
>> +       sci@e6c40000 {
>> +               compatible = "renesas,sci-SCIFA-uart";
>> +               interrupt-parent = <&intca>;
>> +               reg = <0xe6c40000 0x100>;
>> +               interrupts = <0x0c00>, <0x0c00>, <0x0c00>, <0x0c00>;
>> +               cell-index = <0>;
>> +               renesas,scscr = <0x30>;
>> +               renesas,scbrr-algo-id = <4>;
>> +               renesas,autoconf;
>> +       };
>
> The default name for a uart is "serial", I would recommend sticking to
> that by convention. You may also want to add an "aliases" node
> somewhere, to define which port should get which logical device number
> on a given board.

Switched to "...-serial".
About the aliases: Would I need to add that now, or can we postpone that?

Thanks,

 Bastian


>         Arnd
