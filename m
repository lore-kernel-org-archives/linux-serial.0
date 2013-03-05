From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH v4 3/3] ARM: mach-shmobile: r8a7740: Setup the serial
 devices using DT
Date: Tue, 05 Mar 2013 17:42:31 +0400
Message-ID: <5135F647.8050002@cogentembedded.com>
References: <1362414054-23092-1-git-send-email-hechtb+renesas@gmail.com> <1362414054-23092-3-git-send-email-hechtb+renesas@gmail.com> <2835497.S76YK1KMLM@wuerfel> <CABYn4sx=bC6JwicbVgRnmwdu=6DuW5GFgdG25a-Wow1Jn9M-bQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-la0-f54.google.com ([209.85.215.54]:64989 "EHLO
	mail-la0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752843Ab3CENnW (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 5 Mar 2013 08:43:22 -0500
Received: by mail-la0-f54.google.com with SMTP id gw10so6211910lab.13
        for <linux-serial@vger.kernel.org>; Tue, 05 Mar 2013 05:43:20 -0800 (PST)
In-Reply-To: <CABYn4sx=bC6JwicbVgRnmwdu=6DuW5GFgdG25a-Wow1Jn9M-bQ@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Bastian Hecht <hechtb@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org, linux-sh@vger.kernel.org, Paul Mundt <lethal@linux-sh.org>, Magnus Damm <magnus.damm@gmail.com>, linux-serial@vger.kernel.org

Hello.

On 05-03-2013 17:00, Bastian Hecht wrote:

>>> +       sci@e6c40000 {
>>> +               compatible = "renesas,sci-SCIFA-uart";
>>> +               interrupt-parent = <&intca>;
>>> +               reg = <0xe6c40000 0x100>;
>>> +               interrupts = <0x0c00>, <0x0c00>, <0x0c00>, <0x0c00>;
>>> +               cell-index = <0>;
>>> +               renesas,scscr = <0x30>;
>>> +               renesas,scbrr-algo-id = <4>;
>>> +               renesas,autoconf;
>>> +       };
>>
>> The default name for a uart is "serial", I would recommend sticking to
>> that by convention. You may also want to add an "aliases" node
>> somewhere, to define which port should get which logical device number
>> on a given board.

> Switched to "...-serial".

    I think he was talking about the node name, not "compatible" property.

WBR, Sergei

