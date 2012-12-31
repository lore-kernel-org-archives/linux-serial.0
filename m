From: Barry Song <21cnbao@gmail.com>
Subject: Re: [PATCH] seria: sirf: only use lookup table to set baudrate when ioclk=150MHz
Date: Mon, 31 Dec 2012 10:02:25 +0800
Message-ID: <CAGsJ_4xt5H2Q1J2ubm7bMRWXx7bi2A_cw6WuwPQ89pMKPBsp5w@mail.gmail.com>
References: <1356431162-8372-1-git-send-email-Barry.Song@csr.com>
	<20121226150433.GB24604@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-la0-f49.google.com ([209.85.215.49]:44720 "EHLO
	mail-la0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751677Ab2LaCC1 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sun, 30 Dec 2012 21:02:27 -0500
Received: by mail-la0-f49.google.com with SMTP id fk20so3325415lab.36
        for <linux-serial@vger.kernel.org>; Sun, 30 Dec 2012 18:02:26 -0800 (PST)
In-Reply-To: <20121226150433.GB24604@n2100.arm.linux.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Barry Song <Barry.Song@csr.com>, alan@linux.intel.com, workgroup.linux@csr.com, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org, Barry Song <Baohua.Song@csr.com>

2012/12/26, Russell King - ARM Linux <linux@arm.linux.org.uk>:
> On Tue, Dec 25, 2012 at 06:26:02PM +0800, Barry Song wrote:
>> @@ -375,7 +375,12 @@ static void sirfsoc_uart_set_termios(struct uart_port
>> *port,
>>  	int		threshold_div;
>>  	int		temp;
>>
>> -	ioclk_rate = 150000000;
>> +	struct clk *clk = clk_get_sys("io", NULL);
>> +	BUG_ON(IS_ERR(clk));
>
> No.  Really, no.  Stop using BUG_ON() as some kind of crappy assert().
> BUG_ON() takes the entire kernel out when it fails.  There's absolutely
> no need for this what so ever - especially here.
>
> Get the clock at probe or port initialization time.  Save that pointer.
> Only give it up when the port is torn down.  And treat it as any other
> clock - prepare and enable it, and disable and unprepare it when you're
> done with it.
>
> And there's no need to use this clk_get_sys() crap in drivers.  Add the
> necessary clkdev entries or deal with it in DT.  Absolutely do not use
> clk_get_sys() in drivers; it's there for *PLATFORM* code to use when
> there's no other possibility for them and NOT drivers.

Thanks, Russell.
what made this happen is that clkio is used in io bus and by all of
dmac, nand, audio, uart, i2c, spi, usp, pwm, pulse as an input, so we
took it as a global/system clock. this way should be not good for the
real users.
as i have enabled "clk: prima2: enable dt-binding clkdev mapping"
https://patchwork.kernel.org/patch/1898811/
i might simply let uart node in DT takes the uart clk output of clk
controller as your suggestion.

-barry
